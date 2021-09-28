using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;

public partial class Admin_TaskActionMapping : BasePage
{
    Role_BL roleBL;
    Master_BL masterBL;
    List<Role> role = new List<Role>();
    List<TaskActions> lstTaskActions = new List<TaskActions>();
    List<TaskActionOrgMapping> lstTaskActionOrgMapping = new List<TaskActionOrgMapping>();
    protected void Page_Load(object sender, EventArgs e)
    {
        roleBL = new Role_BL(base.ContextInfo);
        masterBL = new Master_BL(base.ContextInfo);
        if (!this.IsPostBack)
        {
            LoadRole();
            LoadActions();
        }
    }
    private void LoadRole()
    {
        long returnCode = -1;
        int pOrgID = OrgID;
        returnCode = roleBL.GetRoleName(pOrgID, out role);
        ddlTaskActions.DataSource = role;
        ddlTaskActions.DataTextField = "RoleName";
        ddlTaskActions.DataValueField = "RoleID";
        ddlTaskActions.DataBind();
        ddlTaskActions.Items.Insert(0, "-----SELECT-----");
        ddlTaskActions.Items[0].Value = "0";
    }
    public void LoadActions()
    {
        long returnCode = -1;
        try
        {
            returnCode = masterBL.GetTaskActions(out lstTaskActions);
            if (lstTaskActions.Count > 0)
            {
                SetCategory(lstTaskActions);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Task Action Name", ex);
        }
    }
    void SetCategory(List<TaskActions> lstTaskActions)
    {
        try
        {

            TVH.NodeIndent = 0;
            string str = "<u><font color='#00297A'>CATEGORY</font></u>";
            TVH.Nodes[0].Text = str;
            AddCatChildNode(TVH.Nodes[0], lstTaskActions);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetHistory", ex);
        }
    }
    void AddCatChildNode(TreeNode parent, List<TaskActions> lstTaskActions)
    {
        string catgry;
        catgry = parent.Value;
        var queryHistories = (from ex in lstTaskActions
                              group ex by new { ex.Category } into g
                              select new TaskActions
                              {
                                  Category = g.Key.Category,
                              }).Distinct().ToList();


        string treeNodeText = string.Empty;
        foreach (var ex in queryHistories)
        {
            var subchild = (from ex1 in lstTaskActions
                            where ex1.Category == ex.Category
                            select ex1);
            TreeNode tn = new TreeNode();
            tn.Text = "<font color='#0099CC'> " + ex.Category + "</font>";
            tn.Value = ex.Category;
            tn.Collapse();
            tn.PopulateOnDemand = false;
            parent.ChildNodes.Add(tn);
            foreach (var ex3 in subchild)
            {
                TreeNode tnChild = new TreeNode();
                tnChild.Text = "<font color='#4775A3'>" + ex3.ActionName + "</font>";
                tnChild.ShowCheckBox = ex3.TaskActionID != 0 ? true : false;
                tnChild.Value = ex3.TaskActionID.ToString();
                tnChild.Collapse();
                tnChild.PopulateOnDemand = false;
                tnChild.NavigateUrl = string.Empty;
                tn.ChildNodes.Add(tnChild);
            }
        }
    }
    public void roleid()
    {
        try
        {
            long roleID;
            roleID = Convert.ToInt64(ddlTaskActions.SelectedValue);
            GetMappedAction(OrgID, roleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Task Action Name", ex);
        }

    }
    protected void ddlTaskActions_SelectedIndexChanged(object sender, EventArgs e)
    {
        long i = Convert.ToInt64(ddlTaskActions.SelectedValue);
        if (i == 0)
        {
            pnlMaped.Visible = false;
            chklstMapedActions.Items.Clear();
            lblTaskError.Text = "";
        }
        else
        {
            roleid();
        }
    }
    public void GetMappedAction(long orgID, long roleID)
    {
        chklstMapedActions.Visible = true;
        long returnCode;
        returnCode = masterBL.GetMappedTaskActions(OrgID, roleID, out lstTaskActions);
        if (lstTaskActions.Count > 0)
        {
            pnlMaped.Visible = true;
            chklstMapedActions.Items.Clear();
            chklstMapedActions.DataSource = lstTaskActions;
            chklstMapedActions.DataTextField = "ActionName";
            chklstMapedActions.DataValueField = "TaskActionID";
            chklstMapedActions.DataBind();
            lblTaskError.Visible = false;
        }
        else
        {
            pnlMaped.Visible = false;
            chklstMapedActions.Items.Clear();
            lblTaskError.Visible = true;
            lblTaskError.Text = "No More Task Action Mapped to this Role";
        }

    }
    public void taskinsert()
    {
        long returnCode = -1;
        string stype = "Add";
        try
        {
            for (int i = 0; i < TVH.Nodes.Count; i++)
            {
                for (int j = 0; j < TVH.Nodes[i].ChildNodes.Count; j++)
                {
                    for (int k = 0; k < TVH.Nodes[i].ChildNodes[j].ChildNodes.Count; k++)
                    {
                        int taskActionID;
                        long roleID;
                        if (TVH.Nodes[i].ChildNodes[j].ChildNodes.Count > 0)
                        {

                            if (TVH.Nodes[i].ChildNodes[j].ChildNodes[k].Checked == true)
                            {
                                taskActionID = Convert.ToInt32(TVH.Nodes[i].ChildNodes[j].ChildNodes[k].Value);
                                roleID = Convert.ToInt64(ddlTaskActions.SelectedValue);
                                TaskActionOrgMapping objTaskActionOrgMapping = new TaskActionOrgMapping();
                                objTaskActionOrgMapping.OrgID = OrgID;
                                objTaskActionOrgMapping.TaskActionID = taskActionID;
                                objTaskActionOrgMapping.RoleID = roleID;
                                lstTaskActionOrgMapping.Add(objTaskActionOrgMapping);

                            }
                        }
                    }
                }
            }
            returnCode = masterBL.SaveAndDeleteTaskActions(stype, lstTaskActionOrgMapping);
            roleid();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving TaskActions", ex);
        }


    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        taskinsert();

    }
    protected void btnRemove_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string stype = "Remove";
            long roleID;
            List<TaskActionOrgMapping> lstTaskActionOrgMapping = new List<TaskActionOrgMapping>();
            IEnumerable<ListItem> checkedlist = (from ListItem item in chklstMapedActions.Items
                                                 where item.Selected
                                                 select item);
            foreach (ListItem item in checkedlist)
            {
                TaskActionOrgMapping objTaskActionOrgMapping = new TaskActionOrgMapping();
                objTaskActionOrgMapping.RoleID = Convert.ToInt64(ddlTaskActions.SelectedValue);
                objTaskActionOrgMapping.TaskActionID = Convert.ToInt16(item.Value);
                objTaskActionOrgMapping.OrgID = OrgID;
                lstTaskActionOrgMapping.Add(objTaskActionOrgMapping);
            }

            returnCode = masterBL.SaveAndDeleteTaskActions(stype, lstTaskActionOrgMapping);
            if (returnCode == 0)
            {
                roleID = Convert.ToInt64(ddlTaskActions.SelectedValue);
                GetMappedAction(OrgID, roleID);
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured in Saving Banner Test", ex);
        }
    }
}
