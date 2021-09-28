using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls; 
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent; 
using System.Data.SqlClient;
using System.Data; 
using Attune.Podium.TrustedOrg;

public partial class Admin_TrustedOrgAccessMapping : BasePage
{
    public Admin_TrustedOrgAccessMapping()
        : base("Admin_TrustedOrgAccessMapping_aspx")
    {

    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tvTrustedItems.Attributes.Add("onclick", "OnTreeClick(event)");
            LoadSharingOrgan(OrgID);
            LoadModuleCategory();

        }
    }
    private void LoadSharingOrgan(int OrgID)
    {
        TrustedOrg TrustedOrgBL = new TrustedOrg(base.ContextInfo);
        List<Organization> lstorgn1 = new List<Organization>();

        List<Locations> lstloc = new List<Locations>();
        TrustedOrgBL.GetSharingOrgList(OrgID, out lstorgn1, out lstloc);
        List<Organization> lstorgn = lstorgn1.FindAll(P => P.OrgID != OrgID);

        if (lstorgn.Count > 0)
        {
            ddlSharedOrg.Style.Add("display", "block");
            ddlSharedOrg.DataSource = lstorgn;// lstorgn.Find(p => p.OrgID != OrgID);
            ddlSharedOrg.DataTextField = "Name";
            ddlSharedOrg.DataValueField = "OrgID";
            ddlSharedOrg.DataBind();
            //ddlSharedOrg.SelectedValue = lstorgn.Find(p => p.OrgID == OrgID).ToString();
        }
        else
        {

        }
    }
    private void LoadModuleCategory()
    {
        TrustedOrg TrustedOrgBL = new TrustedOrg(base.ContextInfo);
        List<ModuleCategory> lstMdCat = new List<ModuleCategory>();
        TrustedOrgBL.GetModuleCategory(out lstMdCat);
        if (lstMdCat.Count > 0)
        {
            chkActionMaster.DataSource = lstMdCat;
            chkActionMaster.DataTextField = "ModuleName";
            chkActionMaster.DataValueField = "ModuleID";
            chkActionMaster.DataBind();
        }
    }

    protected void chkActionMaster_SelectedIndexChanged(object sender, System.EventArgs e)
    {
        tvTrustedItems.Nodes.Clear();
        IDSuccessMesg.Attributes.Add("style", "display:none");
        List<TrustedItems> lstorgn = new List<TrustedItems>();
        TrustedOrg TrustedOrgBL = new TrustedOrg(base.ContextInfo);
        int SharingOrgID = Convert.ToInt32(ddlSharedOrg.SelectedValue);
        string GroupID = string.Empty;

        List<ModuleCategory> lstModuleCategory = new List<ModuleCategory>();
        foreach (ListItem items in chkActionMaster.Items)
        {
            if (items.Selected == true)
            {
                ModuleCategory objModuleCategory = new ModuleCategory();
                objModuleCategory.ModuleID = Convert.ToInt32(items.Value);
                lstModuleCategory.Add(objModuleCategory);
            }
        }
        if (lstModuleCategory.Count > 0)
        {
            TrustedOrgBL.GetTrustedItemsForMapping(SharingOrgID, lstModuleCategory, out lstorgn);
            if (lstorgn.Count > 0)
            {
                tvTrustedItems.ForeColor = System.Drawing.Color.Black;

                var GroupByGroup = from Inves in lstorgn
                                   group Inves by Inves.GroupName into grp
                                   select grp;

                foreach (IGrouping<string, TrustedItems> dr1 in GroupByGroup)
                {
                    tvTrustedItems.Nodes.Add(new TreeNode(Convert.ToString(dr1.ElementAt(0).GroupName), Convert.ToString(dr1.Key)));

                    var GroupByName = from InvesName in lstorgn
                                      where InvesName.GroupName == Convert.ToString(dr1.ElementAt(0).GroupName)
                                      group InvesName by InvesName.Name into grp
                                      select grp;
                    foreach (IGrouping<string, TrustedItems> dr2 in GroupByName)
                    {
                        int count = tvTrustedItems.Nodes.Count - 1;
                        tvTrustedItems.Nodes[count].ChildNodes.Add(new TreeNode(dr2.ElementAt(0).Name, (Convert.ToString(dr2.ElementAt(0).ID) + "~" + Convert.ToString(dr2.ElementAt(0).Type))));


                        var GroupByType = from InvesType in lstorgn
                                          where InvesType.GroupName == Convert.ToString(dr1.ElementAt(0).GroupName)
                                          && InvesType.ID == dr2.ElementAt(0).ID
                                          && InvesType.Name == dr2.ElementAt(0).Name
                                          group InvesType by InvesType.TypeName into grp
                                          select grp;
                        foreach (IGrouping<string, TrustedItems> dr3 in GroupByType)
                        {
                            int count1 = tvTrustedItems.Nodes[count].ChildNodes.Count - 1;
                            tvTrustedItems.Nodes[count].ChildNodes[count1].ChildNodes.Add(new TreeNode(dr3.ElementAt(0).TypeName, (Convert.ToString(dr3.ElementAt(0).TypeID) + "~" + Convert.ToString(dr3.ElementAt(0).Type))));

                            foreach (TrustedItems pi in dr3)
                            {
                                int Childcount = tvTrustedItems.Nodes[count].ChildNodes[count1].ChildNodes.Count - 1;
                                tvTrustedItems.Nodes[count].ChildNodes[count1].ChildNodes[Childcount].ChildNodes.Add(new TreeNode(pi.RoleName, Convert.ToString(pi.RoleID)));

                            }
                        }

                    }
                }
                ShowMappedTrustedItems();
                btnSave.Attributes.Add("style", "display:inline");
                PnTreeView.Attributes.Add("style", "display:block");
                IDNullMesg.Attributes.Add("style", "display:none");
            }
            else
            {
                btnSave.Attributes.Add("style", "display:none");
                PnTreeView.Attributes.Add("style", "display:none");
                IDNullMesg.Attributes.Add("style", "display:block");
            }
            //MapTrustedItems();
        }
        else
        {
            PnTreeView.Attributes.Add("style", "display:none");
            btnSave.Attributes.Add("style", "display:none");
            IDNullMesg.Attributes.Add("style", "display:none");
        }
    }

    public List<TrustedOrgActions> MapTrustedItems()
    {
        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
        int SharingOrgID = Convert.ToInt32(ddlSharedOrg.SelectedValue);
        for (int i = 0; i < tvTrustedItems.Nodes.Count; i++)
        {
            if (tvTrustedItems.Nodes[i].ChildNodes.Count > 0)
            {
                for (int j = 0; j < tvTrustedItems.Nodes[i].ChildNodes.Count; j++)
                {
                    if (tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes.Count > 0)
                    {
                        for (int k = 0; k < tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes.Count; k++)
                        {
                            if (tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes.Count > 0)
                            {
                                for (int l = 0; l < tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes.Count; l++)
                                {
                                    if (tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes[l].Checked == true)
                                    {
                                        TrustedOrgActions objModuleCategory = new TrustedOrgActions();
                                        objModuleCategory.LoggedOrgID = SharingOrgID;
                                        objModuleCategory.SharingOrgID = OrgID;
                                        objModuleCategory.RoleID = Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes[l].Value);
                                        objModuleCategory.IdentifyingActionID = Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Value.Split('~')[0]);
                                        objModuleCategory.IdentifyingType = tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Value.Split('~')[1].ToString();
                                        lstTrustedOrgActions.Add(objModuleCategory);
                                        if(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Value.Split('~')[1].ToString()=="ACTION")
                                        {
                                            TrustedOrgActions objModuleCategoryForPageWithAction = new TrustedOrgActions();
                                            objModuleCategoryForPageWithAction.LoggedOrgID = SharingOrgID;
                                            objModuleCategoryForPageWithAction.SharingOrgID = OrgID;
                                            objModuleCategoryForPageWithAction.RoleID = Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes[l].Value);
                                            objModuleCategoryForPageWithAction.IdentifyingActionID = Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].Value.Split('~')[0]);
                                            objModuleCategoryForPageWithAction.IdentifyingType = "PAGE";
                                            lstTrustedOrgActions.Add(objModuleCategoryForPageWithAction);

                                        }
                                       
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return lstTrustedOrgActions;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        long Return = -1;
        TrustedOrg TrustedOrgBL = new TrustedOrg(base.ContextInfo);
        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
        int SharingOrgID = Convert.ToInt32(ddlSharedOrg.SelectedValue);
        lstTrustedOrgActions = MapTrustedItems();
        Return = TrustedOrgBL.SaveMappedTrustedItems(SharingOrgID, OrgID, lstTrustedOrgActions);
        IDSuccessMesg.Attributes.Add("style", "display:block");
        btnSave.Attributes.Add("style", "display:none");
        PnTreeView.Attributes.Add("style", "display:none");
        tvTrustedItems.Attributes.Add("onclick", "OnTreeClick(event)");
        tvTrustedItems.Nodes.Clear();
        LoadSharingOrgan(OrgID);
        LoadModuleCategory();
            
        
    }

    public void ShowMappedTrustedItems()
    {
        List<TrustedOrgActions> lstorgn = new List<TrustedOrgActions>();
        TrustedOrg TrustedOrgBL = new TrustedOrg(base.ContextInfo);
        long ret = -1;
        int SharingOrgID = Convert.ToInt32(ddlSharedOrg.SelectedValue);
        ret = TrustedOrgBL.GetMappedTrustedItems(SharingOrgID, OrgID, out lstorgn);
        List<TrustedOrgActions> lstTrustedOrgActions = new List<TrustedOrgActions>();
        // int SharingOrgID = Convert.ToInt32(ddlSharedOrg.SelectedValue);
        for (int i = 0; i < tvTrustedItems.Nodes.Count; i++)
        {
            if (tvTrustedItems.Nodes[i].ChildNodes.Count > 0)
            {
                for (int j = 0; j < tvTrustedItems.Nodes[i].ChildNodes.Count; j++)
                {
                    if (tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes.Count > 0)
                    {
                        int UnCheckCount = 0;
                        for (int k = 0; k < tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes.Count; k++)
                        {
                            for (int l = 0; l < tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes.Count; l++)
                            {
                                foreach (TrustedOrgActions obj in lstorgn)
                                {
                                    if ((obj.RoleID == Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes[l].Value))
                                        && (obj.IdentifyingType == tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Value.Split('~')[1].ToString())
                                        && (obj.IdentifyingActionID == Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Value.Split('~')[0])))
                                    {
                                        tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].ChildNodes[l].Checked = true;
                                        tvTrustedItems.ExpandAll();
                                        //UnCheckCount = 0;
                                        break;
                                    }
                                    else
                                    {
                                        UnCheckCount++;
                                    }
                                }
                            }
                            //foreach (TrustedOrgActions obj in lstorgn)
                            //{
                            //    if ((obj.RoleID == Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Value))
                            //        && (obj.IdentifyingType == tvTrustedItems.Nodes[i].ChildNodes[j].Value.Split('~')[1].ToString())
                            //        && (obj.IdentifyingActionID == Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].Value.Split('~')[0])))
                            //    {
                            //        tvTrustedItems.Nodes[i].ChildNodes[j].ChildNodes[k].Checked = true;
                            //        tvTrustedItems.ExpandAll();
                            //        //UnCheckCount = 0;
                            //        break;
                            //    }
                            //    else
                            //    {
                            //        UnCheckCount++;
                            //    }
                            //}
                        }
                        //if (UnCheckCount == 0)
                        //{
                        //    foreach (TrustedOrgActions obj in lstorgn)
                        //    {
                        //        if (obj.IdentifyingActionID == Convert.ToInt64(tvTrustedItems.Nodes[i].ChildNodes[j].Value.Split('~')[0]))
                        //        {
                        //            tvTrustedItems.Nodes[i].ChildNodes[j].Checked = true;
                        //        }
                        //    }
                        //}
                    }
                }
            }
        } 
    }
}

