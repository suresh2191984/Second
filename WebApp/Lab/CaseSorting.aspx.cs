using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System;
using System.Data;
public partial class Lab_CaseSorting : BasePage
{

    public Lab_CaseSorting()
        : base("Lab_CaseSorting_ascx")
    {
    }

    List<OrderedInvestigations> lsttasks = new List<OrderedInvestigations>();
    List<Role> userRoles = new List<Role>();
    GateWay gateWay = new GateWay();
    DateTime fromdate =Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    DateTime todate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
    LoginDetail objLoginDetail = new LoginDetail();
    string Visitnumber = string.Empty;
    string InvID = string.Empty;
    string InvestigationName = string.Empty;
    long InvestigationID = -1;
    string InvestigationType = string.Empty;
    long returnCode = 0;
    int DeptID = -1;
    int startRowIndex = 1;
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            if(chkAssing.Checked==true)
            {
                //btnadd.Text ="Reassign";
                btnadd.Text = Resources.Lab_ClientDisplay.Lab_CaseSorting_aspx_01 == null ? "Reassign" : Resources.Lab_ClientDisplay.Lab_CaseSorting_aspx_01;

            }
            else
            {
                //btnadd.Text="Assign";
                btnadd.Text = Resources.Lab_ClientDisplay.Lab_CaseSorting_aspx_02 == null ? "Assign" : Resources.Lab_ClientDisplay.Lab_CaseSorting_aspx_02;
            }

            
            if (!IsPostBack)
            {
                AutoInvestigations.ContextKey = OrgID.ToString();
                loadDepartments();
                LoadRole();
                Session["Datatable"] = null;


            }
            //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Page Load", ex);
        }
    }

    public void loadDepartments()
    {
        Investigation_BL InvBL = new Investigation_BL(base.ContextInfo);
        try
        {

            List<InvDeptMaster> lstDpt = new List<InvDeptMaster>();
            returnCode = InvBL.GetInvforDept(OrgID, out lstDpt);
           // lstDpt.RemoveAll(p => p.IsSorting != "Y");


            ddlDept.DataSource = lstDpt;
            ddlDept.DataTextField = "DeptName";
            ddlDept.DataValueField = "DeptId";
            ddlDept.DataBind();
            ddlDept.Items.Insert(0, "---Select---");
            ddlDept.Items[0].Value = "0";
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Departments", ex);
        }
    }
    private void LoadRole()
    {
        try
        {
            Role_BL roleBL = new Role_BL(base.ContextInfo);
            List<Role> lstrole = new List<Role>();

            returnCode = roleBL.GetRoleName(OrgID, out lstrole);
            lstrole.RemoveAll(p => p.RoleName != "Lab Technician" && p.RoleName != "Doctor");


            if (lstrole.Count > 0)
            {

                ddlrole.DataSource = lstrole;
                ddlrole.DataTextField = "IntegrationName";
                ddlrole.DataValueField = "RoleID";
                ddlrole.DataBind();
                ddlrole.Items.Insert(0, "-----SELECT-----");
                ddlrole.Items[0].Value = "0";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Role", ex);
        }
    }
    private void Loaduser()
    {
        try
        {
            Users_BL UsersBL = new Users_BL(base.ContextInfo);
            List<Users> lstUsers = new List<Users>();
            DeptID = Int32.Parse(ddlDept.SelectedValue);

            RoleID = Int32.Parse(ddlrole.SelectedValue);

            returnCode = UsersBL.GetUserListByRoleDept(OrgID, DeptID, RoleID, out lstUsers);


            if (lstUsers.Count > 0)
            {

                ddluser.DataSource = lstUsers;
                ddluser.DataTextField = "Name";
                ddluser.DataValueField = "UserID";
                ddluser.DataBind();
                ddluser.Items.Insert(0, "-----SELECT-----");
                ddluser.Items[0].Value = "0";


            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in load Role", ex);
        }
    }


    private void LoadGrid(EventArgs e, int startRowIndex, int PageSize)
    {
        List<OrderedInvestigations> lsttasks = new List<OrderedInvestigations>();
        string isassigned = string.Empty;
        objLoginDetail.LoginID = LID;
        objLoginDetail.RoleID = RoleID;
        objLoginDetail.Orgid = OrgID;
        //startRowIndex = 1;
        //hdnCurrent.Value = startRowIndex.ToString();
        //lblCurrent.Text = startRowIndex.ToString();
        if (txtInvestigationName.Text != "" && hdnTestID.Value != "0")
        {

            InvestigationID = Convert.ToInt64(hdnTestID.Value);
            InvestigationType = hdnTestType.Value;
        }
        if (txtvisitno.Text != "")
        {
            Visitnumber = txtvisitno.Text;
        }


        if (txtFrom.Text != "")
        {
            fromdate = Convert.ToDateTime(txtFrom.Text);
        }
        if (txtTo.Text != "")
        {
            string temptodate = string.Empty;
            temptodate = txtTo.Text;
            todate = Convert.ToDateTime(temptodate);
        }

        DeptID = Int32.Parse(ddlDept.SelectedValue);
        int Reassion = 0; 
        if (chkAssing.Checked == true)
        {
            Reassion = 1;
        
        }

        returnCode = new Investigation_BL(base.ContextInfo).GetSortingTasks(OrgID, DeptID, fromdate, todate, InvestigationName, InvestigationID, InvestigationType, Visitnumber, startRowIndex, PageSize, out totalRows, objLoginDetail,Reassion, out lsttasks);
        grdSample.DataSource = lsttasks;
        grdSample.DataBind();
        if (lsttasks.Count > 0)
        {
            GrdFooter.Visible = true;
            ddlasignrole.Visible = true;
            //tblsecrole.Visible = true;
            btnsave.Visible = true;

            ddlrole.Visible = true;
            lblMessage.Text = "";
            pnlddl.Visible = true;
        }
        else if(ddlDept.SelectedValue!="0") 
        {
            lblMessage.Text = Resources.Lab_ClientDisplay.Lab_CaseSorting_aspx_03 == null ? "No Results found!!!" : Resources.Lab_ClientDisplay.Lab_CaseSorting_aspx_03;
            pnlddl.Visible = false;
            GrdFooter.Visible = false;
        }
        totalpage = totalRows;
        lblTotal.Text = CalculateTotalPages(totalRows).ToString();
        if (hdnCurrent.Value == "")
        {
            lblCurrent.Text = startRowIndex.ToString();
        }
        else
        {
            lblCurrent.Text = hdnCurrent.Value;
            startRowIndex = Convert.ToInt32(hdnCurrent.Value);
        }
        if (startRowIndex == 1)
        {
            Btn_Previous.Enabled = false;
            if (Int32.Parse(lblTotal.Text) > 1)
            {
                Btn_Next.Enabled = true;
            }
            else
                Btn_Next.Enabled = false;
        }
        else
        {
            Btn_Previous.Enabled = true;
            if (startRowIndex == Int32.Parse(lblTotal.Text))
                Btn_Next.Enabled = false;
            else Btn_Next.Enabled = true;
        }
        grdrole.Visible = false;
        Session["Datatable"] = null;

    }
    protected void btnBatchSearch_Click(object sender, EventArgs e)
    {
        LoadGrid(e, startRowIndex, PageSize);
        if (chkAssing.Checked == true)
        {
            foreach (DataControlField column in grdSample.Columns)
                if (column.HeaderText == "Role/LoginName")
                    column.Visible = true;


            
        }
        else
        {
            foreach (DataControlField column in grdSample.Columns)
                if (column.HeaderText == "Role/LoginName")
                    column.Visible = false;

        }
        

        ddlrole.SelectedIndex = ddlrole.Items.IndexOf(ddlrole.Items.FindByText("-----SELECT-----"));
        lbluser.Visible = false;
        ddluser.Visible = false;
        btnadd.Visible = false;
        grdrole.Visible = false;
        Session["Datatable"] = null;


    }
    private int CalculateTotalPages(double totalRows)
    {
        int totalPages = 0;
        try
        {
            totalPages = (int)Math.Ceiling(totalRows / PageSize);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while CalculateTotalPages", ex);
        }
        return totalPages;
    }
    protected void grdSample_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {


        if (e.NewPageIndex >= 0)
        {
            grdSample.PageIndex = e.NewPageIndex;
            btnBatchSearch_Click(sender, e);
        }

    }
    protected void Btn_Previous_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) - 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {
        if (hdnCurrent.Value != "")
        {
            startRowIndex = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        else
        {
            startRowIndex = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = startRowIndex.ToString();
            LoadGrid(e, startRowIndex, PageSize);
        }
        txtpageNo.Text = "";
    }
    protected void btnGo1_Click(object sender, EventArgs e)
    {
        hdnCurrent.Value = txtpageNo.Text;
        LoadGrid(e, Convert.ToInt32(txtpageNo.Text), PageSize);


    }


    protected void ddlrole_SelectedIndexChanged(object sender, EventArgs e)
    {
        string role = Convert.ToString(ddlrole.SelectedItem);
        if (role == "Lab Technician")
        {
            ddluser.Visible = true;
            lbluser.Visible = true;
            btnadd.Visible = true;
            Loaduser();
        }
        if (role == "Pathologist")
        {
            ddluser.Visible = true;
            lbluser.Visible = true;
            btnadd.Visible = true;
            Loaduser();
        }
    }
    public void Clear()
    {
        ddlDept.SelectedIndex = 0;
        txtFrom.Text = "";
        txtTo.Text = "";
        btnsave.Visible = false;
        GrdFooter.Visible = false;
        ddlasignrole.Visible = false;
        txtvisitno.Text = "";
        txtInvestigationName.Text = "";
        txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        lblMessage.Text = "";

    }


    protected void btnsave_Click(object sender, EventArgs e)
    {
        string Information = Resources.Lab_AppMsg.Lab_SampleArchival_aspx_11 == null ? "Information" : Resources.Lab_AppMsg.Lab_SampleArchival_aspx_11;
        string UsrDispWin = Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_27 == null ? "Save Successfully" : Resources.Lab_AppMsg.Lab_PendingSampleCollection_aspx_27;
	
        List<OrderedInvestigations> lstOrderinvestication = new List<OrderedInvestigations>();
        OrderedInvestigations lstitem;
        foreach (GridViewRow row in grdSample.Rows)
        {
            lstitem = new OrderedInvestigations();
            CheckBox chkBox = (CheckBox)row.FindControl("ChkbxSelect");

            Label lblacc = (Label)row.FindControl("lblacc");
            Label lblvisitid = (Label)row.FindControl("lblVisitID");


            if (chkBox.Checked)
            {
                lstitem.ReferralID = Convert.ToInt64(lblacc.Text);
                lstitem.VisitID = Convert.ToInt64(lblvisitid.Text);

                lstOrderinvestication.Add(lstitem);

            }


        }
        DataTable data = null;
        data = Session["Datatable"] as DataTable;
        DeptID = Int32.Parse(ddlDept.SelectedValue);
        Investigation_BL invbl = new Investigation_BL(base.ContextInfo);
        returnCode = invbl.Insertsortedtask(OrgID, DeptID, lstOrderinvestication, data);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + UsrDispWin + "','" + Information + "');", true);

      //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Saved Successfully');", true);
        Clear();
        LoadGrid(e, startRowIndex, PageSize);
    }


    protected void additems(object sender, EventArgs e)
    {
        grdrole.Visible = true;

        DataTable dt = new DataTable();
        dt.Clear();
        dt.Columns.Add("ID");
        dt.Columns.Add("Role");
        dt.Columns.Add("User");
        dt.Columns.Add("Roleid");
        dt.Columns.Add("Userid");
        int i = 0;

        if (Session["Datatable"] != null)
        {
            
            DataTable dtsessionvalue = (DataTable)Session["Datatable"];
            i = dtsessionvalue.Rows.Count;
            dt.Merge(dtsessionvalue);
            

        }
        dt.Rows.Add(i+1,ddlrole.SelectedItem, ddluser.SelectedItem, ddlrole.SelectedValue, ddluser.SelectedValue);
        grdrole.DataSource = dt;
        grdrole.DataBind();
        grdrole.Columns[0].Visible = false;
        grdrole.Columns[3].Visible = false;
        grdrole.Columns[4].Visible = false;
        Session["Datatable"] = dt;
    }
   
    protected void grdrole_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataTable dt = Session["Datatable"] as DataTable;
        int id = Convert.ToInt32(grdrole.DataKeys[e.RowIndex].Value);


        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (Convert.ToInt32(dt.Rows[i]["ID"].ToString()) == id)
            {
                dt.Rows.RemoveAt(i);
            
            }
         }

        grdrole.DataSource = dt;
        grdrole.DataBind();
        Session["Datatable"] = dt;
      
    }
    protected void chkAssing_CheckedChanged(object sender, EventArgs e)
    {

    }
}
   

   

