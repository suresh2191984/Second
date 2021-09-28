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
using Attune.Utilitie.Helper;

public partial class CommonControls_RefPhysicianPatSearch : BaseControl
{
    private bool hasResult = false;
    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    long visitID = 0;
    long returnCode = 0;
    int OP;
    int IP;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    public long VisitID
    {
        get { return visitID; }
        set { visitID = value; }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        txtPatientNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtPatientName.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
        txtRelation.Attributes.Add("onkeypress", "return onKeyPressBlockNumbers(event);");
        txtDOB.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtOthers.Attributes.Add("onKeyDown", "return validatenumber(event);");        
        //btnSearch.Attributes.Add("onClick", "return searchValidate();");
        AutoCompleteProduct.ContextKey = "N";
        if (!IsPostBack)
        {
            List<URNTypes> objURNTypes = new List<URNTypes>();
            List<URNof> objURNof = new List<URNof>();
            Patient_BL pBL = new Patient_BL(base.ContextInfo);
            returnCode = pBL.GetURNType(out objURNTypes, out objURNof);
            if (returnCode == 0)
            {
                ddlUrnType.DataSource = objURNTypes;
                ddlUrnType.DataTextField = "URNType";
                ddlUrnType.DataValueField = "URNTypeId";
                ddlUrnType.DataBind();
            }
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        OP = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
        long returnCode = -1;
        string strPatientName = "";
        string strDOB = "";
        string iPatientNo = "";
        string strLocation = "";
        string strOccuption = "";
        string strCity = "";
        string strMobile = "";
        string strRelation = "";
        string strUrno = "";
        long lngUrnTypeID = 0;

        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        iPatientNo = txtPatientNo.Text;
        strPatientName = txtPatientName.Text;

        string[] ArrayPName = strPatientName.Split('-');
        strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();
        strDOB = txtDOB.Text;
        strRelation = txtRelation.Text;
        strLocation = txtLocation.Text;

        if (ddOthers.SelectedValue == "Occupation")
        {
            strOccuption = txtOthers.Text;
        }
        else if (ddOthers.SelectedValue == "City")
        {
            strCity = txtOthers.Text;
        }
        else if (ddOthers.SelectedValue == "Mobile")
        {
            strMobile = txtOthers.Text;
        }
        if (txtURNo.Text != "")
        {
            strUrno = txtURNo.Text;
            lngUrnTypeID = Convert.ToInt64(ddlUrnType.SelectedValue);
        }

        try
        {
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            string ShareType = "Clinical View";
            if (IsTrustedOrg == "Y")
            {
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
            }
            else
            {
                TrustedOrgDetails TOD = new TrustedOrgDetails();
                TOD.SharingOrgID = OrgID;
                lstTOD.Add(TOD);
            }
            returnCode = patientBL.SearchPatientForRefPhysician(iPatientNo, strPatientName, strDOB, strRelation, strLocation, strOccuption, strCity, strMobile, OrgID, lstTOD, Convert.ToInt32(TaskHelper.SearchType.OP), strUrno, lngUrnTypeID,LID, out lstPatient);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Search Patient", ex);
        }

        //for (int i = 0; i < lstPatient.Count; i++)
        //{
        //    if (lstPatient[i].DOB.ToString() == "01/01/0001 00:00:00")
        //    {
        //        lstPatient[i].DOB = System.DateTime.MinValue;
        //    }
        //}
        if (returnCode == 0 && lstPatient.Count > 0)
        {

            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = lstPatient;
            grdResult.DataBind();
            HasResult = true;
            GrdHeader.Style.Add("display", "block");

        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            GrdHeader.Style.Add("display", "none");
            lblResult.Text = "No matching records found";
        }
        //txtPatientNo.Text = "";
        //txtPatientName.Text = "";
        //txtDOB.Text = "";
        //txtLocation.Text = "";
        //txtOthers.Text = "";
        //ddOthers.SelectedIndex = 0;
        //txtRelation.Text = "";

        onSearchComplete(this, e);
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
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Patient p = (Patient)e.Row.DataItem;
                string strScript = "SelectRowCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + p.PatientID + "','" + p.OrgID + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
                //((LinkButton)e.Row.Cells[0].FindControl("lblNaME")).Attributes.Add("onclick", "document.getElementById('DivChild').visible = true");
                DropDownList ddlVisitActionName = (DropDownList)e.Row.FindControl("ddlVisitActionName");

                ((Button)e.Row.Cells[0].FindControl("btnGo")).Attributes.Add("onclick", "return CheckVisitID('" + ((DropDownList)e.Row.Cells[1].FindControl("ddlVisitActionName")).ClientID + "');");
                if (lstActionMaster.Count == 0)
                    GetActionMaster(out lstActionMaster);

                ddlVisitActionName.DataSource = lstActionMaster;
                ddlVisitActionName.DataTextField = "ActionName";
                //ddlVisitActionName.DataValueField = "PageURL";
                ddlVisitActionName.DataValueField = "ActionCode";
                ddlVisitActionName.DataBind();

                //Label lblBirthDays = (Label)e.Row.FindControl("lblAge");
                //long days = Convert.ToInt64(lblBirthDays.Text == "" ? "0" : lblBirthDays.Text);
                //if (days == 0)
                //{
                //    lblBirthDays.Text = String.Empty;
                //}
                //else if (days > 0 && days < 30)
                //{
                //    lblBirthDays.Text = days.ToString() + " days";
                //}
                //else if (days >= 30 && days < 365)
                //{
                //    lblBirthDays.Text = (days / 30).ToString() + " months";
                //}
                //else if (days >= 365)
                //{
                //    lblBirthDays.Text = (days / 365).ToString() + " year";
                //}

            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Patient Search Control", Ex);
        }


    }

    //protected override void Render(HtmlTextWriter writer)
    //{
    //    for (int i = 0; i < this.grdResult.Rows.Count; i++)
    //    {
    //        this.Page.ClientScript.RegisterForEventValidation(this.grdResult.UniqueID, "Select$" + i);
    //    }
    //    base.Render(writer);
    //}
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
                    HtmlControl NoRecordDiv1 = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("NoRecord");
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
                HtmlControl NoRecordDiv = (HtmlControl)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("NoRecord");
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

                    //Label patientID = (Label)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].ToString(); ;

                    HdnPID.Value = patientId.Text;
                    int VisitID = 0;
                    GridView ChildGrd = (GridView)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ChildGrid");
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisitForRefPhy(Convert.ToInt32(patientId.Text), VisitID, OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo,LID);
                    //UpdateProgress UpProgess = (UpdateProgress)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("Progressbar");
                    //UpProgess.Visible = true;

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
                        //NoRecordDiv.Style.Add("display", "none");
                    }
                    else
                    {
                        ChildGrd.DataSource = null;
                        //Div.Style.Add("display", "none");
                        Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                        DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                        Gobtn1.Visible = false;
                        DrpList.Visible = false;
                        //NoRecordDiv.Style.Add("display", "block");
                    }
                    HasResult = true;

                    onSearchComplete(this, e);

                }
                else
                {
                    Button Gobtn1 = (Button)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("btnGo");
                    DropDownList DrpList = (DropDownList)grdResult.Rows[Convert.ToInt32(e.CommandArgument)].FindControl("ddlVisitActionName");
                    Gobtn1.Visible = false;
                    DrpList.Visible = false;
                }
                // }
            }
            HdnID.Value = e.CommandArgument.ToString();
        }
        catch (Exception ex)
        {

        }
    }




    public long GetSelectedPatient()
    {
        long patientID = -1;

        if (Request.Form["pid"] != null && Request.Form["pid"].ToString() != "")
        {
            patientID = Convert.ToInt32(Request.Form["pid"]);
        }

        return patientID;
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
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
    public void VisitDetails_RowBound(object Obj, GridViewRowEventArgs e)
    {
        //if(e.Row.DataItem == 
    }
    public int GetSelectedPatientOrgID()
    {
        int patientOrgID = -1;

        if (Request.Form["patOrgID"] != null && Request.Form["patOrgID"].ToString() != "")
        {
            patientOrgID = Convert.ToInt32(Request.Form["patOrgID"]);
        }

        return patientOrgID;
    }

    public void accessinPatientSearchPage(object sender, EventArgs e)
    {
        btnSearch_Click(sender, e);
    }
    #region Child Grid Activities...........

    public long GetActionMaster(out List<ActionMaster> lstActionMaster)
    {
        IP = Convert.ToInt32(TaskHelper.SearchType.VisitSearch);
        long returnCode = -1;
        lstActionMaster = new List<ActionMaster>();
        try
        {
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IP, out lstActionMaster);
            //lstActionsMaster = lstActionMaster.ToList();
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  GetActions", ex);
        }

        return returnCode;
    }
    protected void ChildGrd_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
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
            //btnSearch_Click(sender, e);
            int VisitID = 0;
            List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(Convert.ToInt32(HdnPID.Value), VisitID, OrgID, 0, out lstPatientVisit, out lstOrderedInv, out pPatientName, out pPatientNo);
            ChildGrd.PageIndex = e.NewPageIndex;
            ChildGrd.DataSource = lstPatientVisit;
            ChildGrd.DataBind();
        }

    }
    long patientID;
    long pvisitID;
    protected void btnGo_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["PID"], out patientID);
        try
        {
            string pagename = string.Empty;
            returnCode = -1;
            long pBornVisitID = -1;
            /*for (int i = 0; grdResult.Rows.Count > i; i++)
            {
                 DrpName = (DropDownList)grdResult.Rows[Convert.ToInt32(i)].Cells[0].FindControl("ddlVisitActionName");
                if (DrpName.Items.Count > 0)
                {
                    string Str = DrpName.SelectedValue;
                }
            }*/
            if (hdnVID.Value == "")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please select visit detail');", true);
                return;
            }

            DropDownList DrpName = (DropDownList)grdResult.Rows[Convert.ToInt32(HdnID.Value)].Cells[0].FindControl("ddlVisitActionName");
            returnCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(hdnVID.Value), out pBornVisitID);
            #region Hardcode
            ////if (ddlVisitActionName.SelectedItem.Text == "Print Bill")
            ////    pagename = "?vid=" + hdnVID.Value + "&pagetype=BP";
            ////else if (ddlVisitActionName.SelectedItem.Text == "Print CaseSheet")
            ////    pagename = "?vid=" + hdnVID.Value + "&pagetype=CP";
            ////else if (ddlVisitActionName.SelectedItem.Text == "Pint Consolidate Report")
            ////    pagename = "?vid=" + hdnVID.Value + "&pagetype=CR";
            ////else if (ddlVisitActionName.SelectedItem.Text == "Print Prescription")
            ////    pagename = "?vid=" + hdnVID.Value + "&pagetype=PP";
            ////else if (ddlVisitActionName.SelectedItem.Text == "Dialysis Case Sheet")
            ////    pagename = "?vid=" + hdnVID.Value;

            //if (hdnVisitDetail.Value == "Print Bill")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=BP";
            //else if (hdnVisitDetail.Value == "Print CaseSheet")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + patientID + "&pagetype=CP";
            //else if (hdnVisitDetail.Value == "Print Consolidate Report")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=CR";
            //else if (hdnVisitDetail.Value == "Print Prescription")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=PP";
            //else if (hdnVisitDetail.Value == "Dialysis Case Sheet")
            //    pagename = "?vid=" + hdnVID.Value;
            //else if (hdnVisitDetail.Value == "Show Report")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=CPL";
            //else if (hdnVisitDetail.Value == "Order Investigation")
            //    pagename = "?vid=" + hdnVID.Value + " &pid=" + HdnPID.Value + "&pagetype=OI";
            //else if (hdnVisitDetail.Value == "Add Bill Items")
            //    pagename = "?vid=" + hdnVID.Value + " &pid=" + HdnPID.Value + "&pagetype=ABI";
            //else if (hdnVisitDetail.Value == "Collect Payments")
            //    pagename = "?vid=" + hdnVID.Value + "&pagetype=CPay";
            //else if (hdnVisitDetail.Value == "Refund to Patient")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            //else if (hdnVisitDetail.Value == "Enter Additional Notes")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            //else if (hdnVisitDetail.Value == "Print Label")
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            //else if (hdnVisitDetail.Value == "Upload Old Notes")
            //{
            //    pagename = "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value;
            //}
            //else if (hdnVisitDetail.Value == "Generate Bill")
            //{
            //    pagename = "?pid=" + HdnPID.Value;
            //}
            //else if (hdnVisitDetail.Value == "Edit Diagnosis")
            //{
            //    visitID = Convert.ToInt64(hdnVID.Value);
            //    pvisitID = Convert.ToInt64(hdnVID.Value);
            //    List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
            //    if (visitID != null)
            //    {
            //        if (visitID == pvisitID)
            //            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //        else
            //            returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    }
            //    else
            //    {
            //        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
            //    }
            //    if (lstPatientComplaintDetail.Count > 1)
            //    {
            //        Response.Redirect("../Physician/DisplayPatientComplaint.aspx?vid=" + visitID + "&pid=" + HdnPID.Value + "&tid=" + "0" + "&pvid=" + pvisitID + "&id=" + "0", true);
            //    }
            //    else if (lstPatientComplaintDetail.Count == 1)
            //    {
            //        Response.Redirect(@"../Physician/PatientDiagnose.aspx?vid=" + visitID + "&pid=" + HdnPID.Value + "&id=" + lstPatientComplaintDetail[0].ComplaintID + "&pvid=" + pvisitID + "&tid=" + "0", true);
            //    }
            //    else if (lstPatientComplaintDetail.Count == 0)
            //    {
            //        lblResult.Text = "The Patient '" + hdnPNAME.Value + "' is yet to be Diagnosed";
            //        return;
            //    }
            //}
            //if (hdnVisitDetail.Value == "Collect Consultation Fees")
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please Proceed via Todays Patient Link');", true);
            //}
            //else if (hdnVisitDetail.Value == "Print Secured Prescription Page")
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days2", "javascript:alert('Please Proceed via Todays Patient Link');", true);
            //}
            //else if (hdnVisitDetail.Value == "Print HealthPackage CaseSheet")
            //{
            //    if (patientID != 0)
            //    {
            //        HdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value, true);
            //}
            //else if (pBornVisitID == 0 && hdnVisitDetail.Value == "Edit/Print Discharge Summary")
            //{
            //    if (patientID != 0)
            //    {
            //        HdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&vType=" + "IP", true);
            //}
            //else if (pBornVisitID == 0 && hdnVisitDetail.Value == "View/Edit Admission Notes")
            //{
            //    if (patientID != 0)
            //    {
            //        HdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&vType=" + "IP", true);
            //}
            //else if (hdnVisitDetail.Value == "View/Edit Operation Notes")
            //{
            //    if (patientID != 0)
            //    {
            //        HdnPID.Value = patientID.ToString();
            //    }
            //    Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);
            //}
            //else if (pBornVisitID > 0)
            //{
            //    if (hdnVisitDetail.Value == "View/Edit Admission Notes" || hdnVisitDetail.Value == "Edit/Print Discharge Summary")
            //    {

            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for New born baby');", true);
            //    }
            //    else if (hdnVisitDetail.Value == "Print Bill")
            //    {
            //        Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);

            //    }
            //    else if (hdnVisitDetail.Value == "Print Bill")
            //    {
            //        Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);

            //    }
            //    else if (hdnVisitDetail.Value == "Show Report")
            //    {
            //        Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&page=" + "Visit", true);

            //    }
            //    else if (hdnVisitDetail.Value == "Print Neonatal Notes")
            //    {
            //        if (patientID != 0)
            //        {
            //            HdnPID.Value = patientID.ToString();
            //        }
            //        Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value + "&pid=" + HdnPID.Value + "&vType=" + "IP", true);
            //    }
            //}
            //else if (pBornVisitID == 0 && hdnVisitDetail.Value == "Print Neonatal Notes")
            //{

            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action can be performed for New born baby');", true);

            //}

            //else
            //{
            //    //Response.Redirect("../Reception/ViewPrintPage.aspx?vid=" + hdnVID.Value + "&pagetype=" + pagename + "", true);
            //    //Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + "?vid=" + hdnVID.Value, true);
            //    Response.Redirect(Request.ApplicationPath + DrpName.SelectedItem.Value + pagename, true);
            //}
            #endregion

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
            
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            if (pBornVisitID > 0)
            {
                if (DrpName.SelectedValue == "View_Edit_Admission_Notes_IPCaseRecordSheet" || DrpName.SelectedValue == "Edit_Print_Discharge_Summary_DischargeSummaryDynamic")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed for New born baby');", true);
                }
            }
            else if (pBornVisitID == 0 && DrpName.SelectedValue == "Print_Neonatal_Notes_NeonatalCaseSheet")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action can be performed for New born baby');", true);
            }
            //if (lstActionsMaster.Exists(p => p.ActionCode == DrpName.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == DrpName.SelectedValue).QueryString;
            //}
            #region View State Action List
            string ActCode = DrpName.SelectedValue;
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
            if (DrpName.SelectedValue == "Edit_Diagnosis_PatientDiagnose")
            {
                visitID = Convert.ToInt64(hdnVID.Value);
                pvisitID = Convert.ToInt64(hdnVID.Value);
                List<PatientComplaint> lstPatientComplaintDetail = new List<PatientComplaint>();
                if (visitID != null)
                {
                    if (visitID == pvisitID)
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                    else
                        returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                }
                else
                {
                    returnCode = new CaseSheet_BL(base.ContextInfo).GetPatientComplaintDetail(visitID, out lstPatientComplaintDetail);
                }
                if (lstPatientComplaintDetail.Count == 0)
                {
                    lblResult.Text = "The Patient '" + hdnPNAME.Value + "' is yet to be Diagnosed";
                    return;
                }
                else if (lstPatientComplaintDetail.Count > 1)
                {
                    objQueryMaster.IdentityValue = "0";
                }
                else
                {
                    objQueryMaster.IdentityValue = lstPatientComplaintDetail[0].ComplaintID.ToString();
                }
                objQueryMaster.CountValue = lstPatientComplaintDetail.Count.ToString();
                objQueryMaster.PPatientVisitID = pvisitID.ToString();
            }
            if (DrpName.SelectedValue == "Collect_Consultation_Fees_CheckPayment" || DrpName.SelectedValue == "Print_Secured_Prescription_Page_ViewPrintPage")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Go2days1", "javascript:alert('Please Proceed via Todays Patient Link');", true);
            }
            if (DrpName.SelectedValue == "Print_CaseSheet_ViewPrintPage" || DrpName.SelectedValue == "View_Edit_Operation_Notes_OperationNotesCaseSheet" || DrpName.SelectedValue == "Print_Neonatal_Notes_NeonatalCaseSheet")
            {
                objQueryMaster.PatientID = patientID.ToString();
            }
            else if (DrpName.SelectedValue == "Edit_Print_Discharge_Summary_DischargeSummaryDynamic" || DrpName.SelectedValue == "View_Edit_Admission_Notes_IPCaseRecordSheet" || DrpName.SelectedValue == "Edit_Capture_Case_Sheet_IPCaseRecord" && pBornVisitID == 0)
            {
                objQueryMaster.PatientID = patientID.ToString();
            }
            else if (DrpName.SelectedValue == "View_Print_Case_Sheet_IPCaseRecordSheet" && pBornVisitID == 0)
            {
                HdnPID.Value = patientID.ToString();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Case Sheet", "PrintCaseSheet('" + hdnVID.Value + "','" + HdnPID.Value + "','OP');", true);
            }
            else
            {
                objQueryMaster.PatientID = HdnPID.Value;
            }
            objQueryMaster.PatientVisitID = hdnVID.Value;
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
    protected void ChildGrid_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            //List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
            //List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
            //List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
            //List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
            //List<InvDeptMaster> deptList = new List<InvDeptMaster>();
            //List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            //List<SampleAttributes> lstSampleAttributes = new List<SampleAttributes>();
            //List<InvestigationValues> lstInvestigationValues = new List<InvestigationValues>();
            //List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
            List<OrderedInvestigations> lstorderInv = new List<OrderedInvestigations>();
            //List<InvDeptMaster> deptList1 = new List<InvDeptMaster>();

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                PatientVisit pv = (PatientVisit)e.Row.DataItem;
                //if (lstOrderedInv.Find(p => p.VisitID == pv.PatientVisitId) != null)
                //{
                //    Label lblReportingRadiologist = (Label)e.Row.FindControl("lblReportingRadiologist");
                //    lblReportingRadiologist.Text = lstOrderedInv.Find(p => p.VisitID == pv.PatientVisitId).PerformingPhysicain;
                //}
                string strScript = "SelectVisit('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + pv.PatientVisitId + "','" + HdnPID.Value + "','" + pv.PatientName + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                //new Investigation_BL(base.ContextInfo).GetInvestigationSamplesCollect(pv.PatientVisitId, OrgID, Convert.ToInt64(RoleID), out lstPatientInvestigation,
                //                            out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample
                //                              , out deptList1, out lstSampleContainer, out lstorderInv);
                returnCode = new Investigation_BL(base.ContextInfo).GetInvestigationForVisit(pv.PatientVisitId, OrgID,ILocationID, out lstorderInv);

                if (lstorderInv.Count > 0)
                {
                    string strtemp = GetToolTip(lstorderInv);
                    e.Row.Cells[5].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[5].Attributes.Add("onmouseout", "hideTooltip();");

                    e.Row.Cells[6].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                    e.Row.Cells[6].Attributes.Add("onmouseout", "hideTooltip();");
                    //e.Row.Cells[2].Style.Add("color", "Blue");
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
            //+ "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List For this task</td></tr>"
                    + "<tr style=\"font-weight: bold;text-decoration:underline\"><td>Investigation List</td><td>Reporting Radiologist</td><td>Status</td></tr>";
        foreach (var Item in InvestigationList)
        {
            TableDate += "<tr>  <td>" + Item.InvestigationName + "</td>";
            TableDate += " <td>" + Item.PerformingPhysicain + "</td>";
            TableDate += " <td>" + Item.Status + "</td></tr>";
        }
        return TableHead + TableDate + "</table> ";
    }
    #endregion
}
