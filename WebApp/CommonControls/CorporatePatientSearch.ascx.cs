using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Threading;
using Attune.Utilitie.Helper;

public partial class CommonControls_CorporatePatientSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long visitID = 0;
    long returnCode = 0;
    int OP;
    int IP;
    int currentPageNo = 1;
    string isWardNo = string.Empty;
    string employeeNo = string.Empty;
    public string EmployeeNo
    {
        get { return employeeNo; }
        set { employeeNo = value; }
    }

    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            long returnCode = -1;
            List<DesignationMaster> lstDesignationMaster = new List<DesignationMaster>();
            List<RelationshipMaster> lstRealtionshipMaster = new List<RelationshipMaster>();
          
            List<EmploymentType> lstEmploymentType = new List<EmploymentType>();
            List<EmployerDeptMaster> lstEmployerDeptMaster = new List<EmployerDeptMaster>();
            List<PatientTypeMaster> lstPatientTypeMaster = new List<PatientTypeMaster>();
            List<GradeMaster> lstGradeMaster = new List<GradeMaster>();
            List<EmployerMaster> lstEmployerMaster = new List<EmployerMaster>();
            List<EmployerLocationMaster> lstEmployerLocationMaster = new List<EmployerLocationMaster>();
         
            Master_BL masterBL = new Master_BL(base.ContextInfo);
            long EmpID = 0;
            long ExternalID = 0;
            returnCode = masterBL.GetEmployeeMasters(OrgID,
                                                    out lstDesignationMaster,
                                                    out lstRealtionshipMaster,
                                                    out lstEmploymentType,
                                                    out lstEmployerDeptMaster,
                                                    out lstPatientTypeMaster,
                                                    out lstGradeMaster,
                                                    out lstEmployerMaster,
                                                    out lstEmployerLocationMaster,
                                                    out EmpID,
                                                    out ExternalID
                                                    );
            if (lstEmployerMaster.Count > 0)
            {
                ddlEmployerName.DataTextField = "EmployerName";
                ddlEmployerName.DataValueField = "EmployerID";
                ddlEmployerName.DataSource = lstEmployerMaster;
                ddlEmployerName.DataBind();
                ddlEmployerName.Items.Insert(0, "---Select---");
            }
            if (EmployeeNo != "")
            {
                txtEmpNo.Text = EmployeeNo.ToString();
                GrdViewEmployeeDetails();
            }
        }

    }



    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            //Response.Redirect("../Reception/Home.aspx", true);
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        hdnPatientID.Value = "";
        GrdViewEmployeeDetails();
    }
    public void GrdViewEmployeeDetails()
    {
        Patient_BL pbl = new Patient_BL(base.ContextInfo);
        long returnCode = -1;
        string FromDate = "", ToDate = "";
        List<EmployeeRegMaster> lstDetails = new List<EmployeeRegMaster>();
        List<Patient> lstPatient = new List<Patient>();
        string deps = ddlPatientType.SelectedItem.Value;
        returnCode = pbl.SearchCorporatePatient(txtEmpNo.Text, txtEmployeeName.Text, txtEmpAge.Text, deps, ddlEmployerName.SelectedValue == "---Select---" ? 0 : Convert.ToInt32(ddlEmployerName.SelectedValue), OrgID, FromDate, ToDate, out lstPatient);
        if (lstPatient.Count > 0)
        {
            grdResult.DataSource = lstPatient;
            grdResult.DataBind();
            lblErrmsg.Text = "";
        }
        else
        {
            grdResult.DataSource = lstPatient;
            grdResult.DataBind();
            lblErrmsg.Text = "No Record Found";
        }

    }
    public bool HasResult
    {
        get
        {
            return hasResult;
        }
        set
        {
            hasResult = value;
        }
    }
    protected void btnGo_Click1(object sender, EventArgs e)
    {
        try
        {
            string pagename = string.Empty;
            returnCode = -1;
            if (hdnVID.Value == "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please select visit detail');", true);
                return;
            }
                pagename = hdnPathpage.Value;
                #region Get Redirect URL
                QueryMaster objQueryMaster = new QueryMaster();
                 
                string RedirectURL = string.Empty;
                string QueryString = string.Empty;
                //if (lstActionsMaster.Exists(p => p.ActionCode == hdnVisitDetail.Value))
                //{
                //    QueryString = lstActionsMaster.Find(p => p.ActionCode == hdnVisitDetail.Value).QueryString;
                //}
                #region View State Action List
                string ActCode = hdnVisitDetail.Value;
                string ActionList = ViewState["ActionList"].ToString();
                foreach (string CompareList in ActionList.Split('^'))
                {
                    if (CompareList.Split('~')[0] == ActCode)
                    {
                        QueryString = CompareList.Split('~')[1];
                        break;
                    }
                }
                #endregion
                objQueryMaster.Querystring = QueryString;
                objQueryMaster.PatientID = HdnPID.Value;
                objQueryMaster.PatientVisitID = hdnVID.Value;               
                objQueryMaster.ViewType = "P";
                objQueryMaster.SpecialityID = "51";
                AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                if (!String.IsNullOrEmpty(RedirectURL))
                {
                    Response.Redirect(RedirectURL, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                }
                #endregion
                 
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        
    }
    protected void ChildGrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (HdnID.Value == "")
        {
            HdnID.Value = "1";
        }
        GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(HdnID.Value)].FindControl("ChildGrid");
        if (e.NewPageIndex == ChildGrd.PageCount)
        {
            try
            {
                ImageButton ibtnNext = (ImageButton)(ChildGrd.BottomPagerRow.FindControl("lnkNext"));
                if (ibtnNext != null) ibtnNext.Visible = false;
            }
            catch (Exception ex)
            {
                ImageButton ibtnPrev = (ImageButton)(ChildGrd.BottomPagerRow.FindControl("lnkPrev"));
                if (ibtnPrev != null) ibtnPrev.Visible = false;
            }
        }
        if (e.NewPageIndex >= 0)
        {
            int VisitID = 0;
            List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(Convert.ToInt32(HdnPID.Value), VisitID, OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);
            ChildGrd.PageIndex = e.NewPageIndex;
            ChildGrd.DataSource = lstPatientVisit;
            ChildGrd.DataBind();
        }
    }
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {   
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;

                string strScript = "SelectRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "','" + p.Name + "','" + p.Age + "','" + p.MartialStatus + "','" + p.AliasName + "','" + p.PatientNumber + "','" + p.Status + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //((LinkButton)e.Row.Cells[0].FindControl("lblNaME")).Attributes.Add("onclick", "document.getElementById('DivChild').visible = true");
                //DropDownList ddlVisitActionName = (DropDownList)e.Row.FindControl("ddlVisitActionName");

                //((Button)e.Row.Cells[0].FindControl("btnGo")).Attributes.Add("onclick", "return CheckVisitID('" + ((DropDownList)e.Row.Cells[1].FindControl("ddlVisitActionName")).ClientID + "');");
                DropDownList ddlVisitActionName = (DropDownList)e.Row.FindControl("ddlVisitActionName");

                ((Button)e.Row.Cells[0].FindControl("btnGo")).Attributes.Add("onclick", "return CheckVisitID('" + ((DropDownList)e.Row.Cells[1].FindControl("ddlVisitActionName")).ClientID + "');");
                if (lstActionMaster.Count == 0)
                    GetActionMaster(out lstActionMaster);
                
                    ddlVisitActionName.DataSource = lstActionMaster;
                    ddlVisitActionName.DataTextField = "ActionName";
                    ddlVisitActionName.DataValueField = "ActionCode";
                    ddlVisitActionName.DataBind();

                ImageButton imgPatient = (ImageButton)e.Row.Cells[1].FindControl("imgPatient");
                if (String.IsNullOrEmpty(p.PictureName))
                {
                    imgPatient.Visible = false;
                }
                else
                {
                    imgPatient.Visible = true;
                    imgPatient.Attributes.Add("onmouseover", "ShowPicture(this.id,'" + p.PictureName + "')");
                    imgPatient.Attributes.Add("onmouseout", "HidePicture()");
                }
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Patient Search Control", Ex);
        }


    }
    public long GetActionMaster(out List<ActionMaster> lstActionMaster)
    {
        //IP = Convert.ToInt32(TaskHelper.SearchType.Corporate);
        IP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
        long returnCode = -1;
        lstActionMaster = new List<ActionMaster>();
        try
        {
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            #region Add View State ActionList
            if (lstActionMaster.Count > 0)
            {
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
            }
            #endregion
            //lstActionsMaster = lstActionMaster.ToList();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  GetActions", ex);
        }

        return returnCode;
    }
    string gUID = string.Empty;
    protected void ChildGrid_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
            List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
            List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
            List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
            List<InvDeptMaster> deptList1 = new List<InvDeptMaster>();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + HdnPID.Value + "','" + pv.PatientName + "','" + pv.VisitPurposeName +"');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                new Investigation_BL(base.ContextInfo).GetInvestigationSamplesCollect(pv.PatientVisitId, OrgID, Convert.ToInt64(RoleID), gUID, ILocationID,22, out lstPatientInvestigation,
                                            out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample
                                              , out deptList1, out lstSampleContainer);//By Shajahan , out lstorderInv
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(pv.PatientVisitId, ILocationID, OrgID, out lstorderInv);
                if (lstorderInv.Count > 0)
                {
                    string strtemp = GetToolTip(lstorderInv);
                    e.Row.Cells[5].Attributes.Add("onmouseover", "showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[5].Attributes.Add("onmouseout", "hideTooltip();");

                    e.Row.Cells[6].Attributes.Add("onmouseover", "showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[6].Attributes.Add("onmouseout", "hideTooltip();");
                    e.Row.Style.Add("Cursor", "Pointer");
                }
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Patient Search Control", Ex);
        }
    }
    private string GetToolTip(List<OrderedInvestigations> InvestigationList)
    {
        string TableHead = "";
        string TableDate = "";
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\">"
                    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_CorporatePatientSearch_InvestigationList %>" + "</td><td>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_CorporatePatientSearch_ReportingRadiologist %>" + "</td><td>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_CorporatePatientSearch_Status %>" + "</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>";
            TableDate += " <td>" + Item.PerformingPhysicain + "</td>";
            TableDate += " <td>" + Item.Status + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }

    }
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
    string pPatientName = "";
    string pPatientNo = "";

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (HdnID.Value != string.Empty)
            {
                if (HdnID.Value != e.CommandArgument.ToString())
                {
                    int rID = Convert.ToInt32(HdnID.Value);
                    HtmlControl Div1 = (HtmlControl)grdResult.Rows[rID].FindControl("DivChild");
                    ImageButton imgBTN = (ImageButton)grdResult.Rows[rID].FindControl("imgClick");
                    imgBTN.ImageUrl = "~/Images/collapse.jpg";
                    Div1.Style.Add("display", "none");
                }
            }

            if (e.CommandArgument.ToString() != "")
            {
                int A = 0;
                ImageButton imgBTN = (ImageButton)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("imgClick");
                imgBTN.ImageUrl = "~/Images/expand.jpg";
                TextBox patientId = (TextBox)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("txtPatientId");
                HtmlControl Div = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("DivChild");
                string[] str = (Div.Attributes["style"].ToString()).Split(';');
                if (str[0] == "display:block")
                {
                    Div.Style.Add("display", "none");
                    imgBTN.ImageUrl = "~/Images/collapse.jpg";
                }
                else
                {
                    Div.Style.Add("display", "block");
                    A = A + 2;
                }
                if (A != 0)
                {
                    HdnPID.Value = patientId.Text;
                    int VisitID = 0;
                    GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGrid");
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(Convert.ToInt32(patientId.Text), VisitID, OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);
                    if (lstPatientVisit.Count != 0)
                    {
                        Button Gobtn = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        Gobtn.Focus();
                        ChildGrd.DataSource = lstPatientVisit;
                        ChildGrd.DataBind();
                        Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                        Gobtn1.Visible = true;
                        DrpList.Visible = true;
                        if (ChildGrd.Columns.Count != 0)
                        {
                            List<DynamicColumnMapping> lst = new List<DynamicColumnMapping>();
                            lst = VisitSearchColumn();

                            for (int j = 0; ChildGrd.Columns.Count > j; j++)
                            {
                                if (lst.Exists(delegate(DynamicColumnMapping x) { return x.SearchColumnName == ChildGrd.Columns[j].HeaderText; }) || ChildGrd.Columns[j].HeaderText == "Select")
                                    ChildGrd.Columns[j].Visible = true;
                                else
                                    ChildGrd.Columns[j].Visible = false;
                            }
                        }
                        HasResult = true;
                    }
                    else
                    {
                        ChildGrd.DataSource = null;
                        Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                        Gobtn1.Visible = false;
                        DrpList.Visible = false;
                    }
                    onSearchComplete(this, e);
                }
                else
                {
                    Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                    DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                    Gobtn1.Visible = false;
                    DrpList.Visible = false;
                }
            }
            HdnID.Value = e.CommandArgument.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load Child Grid", ex);
        }
    }
    public List<DynamicColumnMapping> VisitSearchColumn()
    {
        long returnCode = -1;
        List<DynamicColumnMapping> lstColumn = new List<DynamicColumnMapping>();
        try
        {
            int VisitSearch = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
            returnCode = new Patient_BL(base.ContextInfo).SearchColumns(VisitSearch, OrgID, out lstColumn);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while SearchColumns", ex);
        }
        return lstColumn;
    }

    public long GetSelectedPatient()
    {
        long patientID = -1;
        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            patientID = Convert.ToInt64(Request.Form["pid"]);
        }
        else
        {

            //patientID = Convert.ToInt64(Request.Form["pid"]);
            patientID = Convert.ToInt64(hdnTempPatientid.Value);
        }

        return patientID;
    }
    public long GetSelectedPatientID()
    {
        long patientID = -1;
        string pname = string.Empty;
        if (hdnPatientID.Value != "")
        {
            patientID = Convert.ToInt64(hdnPatientID.Value);
        }
        return patientID;
    }

    public string GetSelectedPatientName()
    {
        string pname = string.Empty;
        if (hdnPatientName.Value != "")
        {
            pname = hdnPatientName.Value;
        }
        return pname;
    }

    public string GetSelectedPatients()
    {
        string pname = string.Empty;

        if (Request.Form["pname"] != null && Request.Form["pname"].ToString() != "")
        {
            pname = Request.Form["pname"];
        }
        else
        {

            //patientID = Convert.ToInt64(Request.Form["pid"]);
            pname = hdnTempPatientName.Value;
        }

        return pname;
    }
}


