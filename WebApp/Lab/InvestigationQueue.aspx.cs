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
using System.Data;
using System.IO;
using Attune.Podium.ExcelExportManager;
using System.Security.Cryptography;
using System.Text;

public partial class Lab_InvestigationQueue : BasePage
{
    public Lab_InvestigationQueue()
        : base("Lab_InvestigationQueue_aspx")
    {
    }
    string Task = string.Empty;
    string PatientName = string.Empty;
    int HC;
    int searchtype;
    long returnCode = -1;
    List<InvestigationQueue> lstTest = new List<InvestigationQueue>();
    List<InvestigationQueue> lstRetestPatients = new List<InvestigationQueue>();
    List<InvestigationQueue> lstTempRetestPatients = new List<InvestigationQueue>();
    List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
    List<InvSampleMaster> lstInvSampleMaster = new List<InvSampleMaster>();
    List<InvDeptMaster> lstInvDeptMaster = new List<InvDeptMaster>();
    List<CollectedSample> lstOrderedInvSample = new List<CollectedSample>();
    List<RoleDeptMap> lstRoleDept = new List<RoleDeptMap>();
    List<InvDeptMaster> deptList = new List<InvDeptMaster>();
    List<InvestigationSampleContainer> lstSampleContainer = new List<InvestigationSampleContainer>();
    List<OrganizationAddress> lAddress = new List<OrganizationAddress>();
    Investigation_BL InvBL;
    string GUID = Guid.NewGuid().ToString();
    string strSelects = Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_02 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_PendingSampleCollection_aspx_02;
    protected void Page_Load(object sender, EventArgs e)
    {
        InvBL = new Investigation_BL(base.ContextInfo);
        
        if (!IsPostBack)
        {

            hdnPatientID.Value = "";
            hdnSelectedPatientID.Value = "";
            hdnSelectedVisitID.Value = "";
            rdoRetest.Focus();
            rdoRetest.Checked = true;
            InvBL.GetInvestigationSamplesCollect(0, OrgID, RoleID, "", ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);
            ddlSampleName.DataSource = lstInvSampleMaster;

            ddlSampleName.DataTextField = "SampleDesc";
            ddlSampleName.DataValueField = "SampleCode";
            ddlSampleName.DataBind();
            ddlSampleName.Items.Insert(0, new ListItem(strSelects, "0"));
            List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
            List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
            returnCode = new Referrals_BL(base.ContextInfo).GetALLLocation(OrgID, out lAddress);
            if (lAddress.Count > 0)
            {
                if (CID > 0)
                {
                    LoginLoc = lAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                    ParentLoc = (from lst in lAddress
                                 join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                                 select lst).ToList();
                    LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                    ddlocation.DataSource = LoginLoc;
                    ddlocation.DataValueField = "AddressID";
                    ddlocation.DataTextField = "Location";
                    ddlocation.DataBind();
                    ddlocation.SelectedValue = ILocationID.ToString();
                }
                else
                {
                    ddlocation.DataSource = lAddress;
                    ddlocation.DataTextField = "City";
                    ddlocation.DataValueField = "AddressID";
                    ddlocation.DataBind();
                }
            }
            ddlocation.Items.Insert(0, strSelects);
            ddlocation.Items[0].Value = "-1";
            LoadSourceNameTrustedOrg();
            LoadMeatData();
            //Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>();
            searchtype = Convert.ToInt32(TaskHelper.SearchType.InvestigationSearch);

            //returnCode = new Nurse_BL(base.ContextInfo).GetActionsIsTrusterdOrg(RoleID, searchtype, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            if (IsTrustedOrg == "Y")
            {
                returnCode = new Nurse_BL(base.ContextInfo).GetActionsIsTrusterdOrg(RoleID, searchtype, out lstActionMaster);
            }
            else
            {
                returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, searchtype, out lstActionMaster); //returnCode = patBL.GetSearchActionsByPage(RoleID, type, out pages);
            }

            #region Load Action Menu to Drop Down List
            if (lstActionMaster.Count > 0)
            {
                //lstActionsMaster = lstActionMaster.ToList();
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
            #endregion
            //if (RoleName == "Lab Technician")
            //{
            //    dList.Items.Insert(0, new ListItem("Collect sample", "0"));
            //    dList.Items.Insert(1, new ListItem("Investigation Capture", "1"));
            //}
            //if (RoleName == "Phlebotomist")
            //{
            //    dList.Items.Insert(0, new ListItem("Collect sample", "0"));
            //}
            AutoCompleteProduct.ContextKey = Convert.ToString("Y");
            if (Request.QueryString["FDate"] != null)
            {
                LoadFromAbberantQueue();
            }
            else
            {
                DateTime fromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime.TryParse(OrgTimeZone, out fromDate);
                txtFrom.Text = fromDate.AddDays(-1).ToString("dd-MM-yyyy hh:mm:ss tt");
                txtTo.Text = OrgDateTimeZone;
            }
        }
        if (RoleHelper.LabTech == RoleName || RoleHelper.SrLabTech == RoleName || RoleHelper.CustomerCare == RoleName || RoleHelper.JuniorDoctor == RoleName || RoleHelper.Doctor == RoleName)
        {
            aRow.Attributes.Add("style", "display:none;");
            bGo.Visible = false;
        }
        SetToolTip(ddClientName);
        SetToolTip(ddlocation);
    }



    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            InvestigationQueue T = (InvestigationQueue)e.Row.DataItem;

            string strScript = "SelectRow('" + ((CheckBox)e.Row.Cells[1].FindControl("ChkSel")).ClientID + "','" + T.TestID + "','" + T.PatientID + "','" + T.Status + "','" + T.VisitID + "','" + T.UID + "','" + T.ClientID + "','" + T.AccessionNumber + "');";
            ((CheckBox)e.Row.Cells[0].FindControl("ChkSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((CheckBox)e.Row.Cells[0].FindControl("ChkSel")).Attributes.Add("onclick", strScript);
            hdnchkids.Value += e.Row.Cells[1].FindControl("ChkSel").ClientID+"~";
        }
    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        if (RoleHelper.CustomerCare != RoleName  || RoleHelper.JuniorDoctor != RoleName || RoleHelper.Doctor != RoleName)
        {
            string page = string.Empty;
            string LabNo = string.Empty;
            long returnCode = -1;
            List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
            long RefID = -1; string RefType = "";
            returnCode = InvBL.GetNextBarcode(OrgID, ILocationID, "INV", out LabNo, RefID, RefType);
            QueryMaster objQueryMaster = new QueryMaster();

            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
        if (!String.IsNullOrEmpty(LabNo))
        {
            hdnLabNumber.Value = LabNo;
        }
            //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
            //{
            //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
            //}
            #region View State Action List
            string ActCode = dList.SelectedValue;
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

        foreach (GridViewRow Gv in grdMain.Rows)
        {

            OrderedInvestigations objInvest;
            RadioButton rdoSel = (RadioButton)Gv.FindControl("rdoSel");
            Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
            Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
            Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");
            Label lblOrderedUID = (Label)Gv.FindControl("lblOrderedUID");
            Label lblVisitID = (Label)Gv.FindControl("lblVisitID");
            HiddenField hdnStatus = (HiddenField)Gv.FindControl("hdnStatus");
            Label lblRootUID = (Label)Gv.FindControl("lblRootUID");
            Label lbltype = (Label)Gv.FindControl("lbltype");
            if (rdoSel.Checked == true)
            {
                if (lblInvestigationID.Text.Contains(","))
                {
                    GetInvestigation();
                    break;
                }
                else
                {
                    if (dList.SelectedValue == "Collect_sample_InvestigationSample")
                    {
                        if (hdnStatus.Value == InvStatus.Retest)
                        {
                            objInvest = new OrderedInvestigations();
                            objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                            objInvest.Name = lblInvestigationName.Text;
                            objInvest.VisitID = Convert.ToInt64(lblVisitID.Text);
                            objInvest.Status = "Paid";
                            objInvest.PaymentStatus = "Paid";
                            objInvest.CreatedBy = LID;
                            objInvest.Type =  lbltype.Text;
                            objInvest.OrgID = OrgID;
                            objInvest.LabNo = LabNo;
                            objInvest.ReferenceType = "R";
                            //Added By Prasanna.S to Save Labno in orderedinvestigation
                            objInvest.ComplaintId = Convert.ToInt32(LabNo);
                            if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                            {
                                objInvest.UID = GUID = lblOrderedUID.Text;
                            }
                            else
                            {
                                objInvest.UID = GUID;
                            }
                            objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                            objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                            ordInves.Add(objInvest);
                        }
                        if (hdnStatus.Value == "Reflexwithnewsample")
                        {
                            long InvID = 0;
                            List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
                            InvID = Convert.ToInt64(lblInvestigationID.Text);
                            //returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                            //if (lstInvValueRangeMaster.Count > 0)
                            //{
                            //    foreach (InvValueRangeMaster oInvValueRangeMaster in lstInvValueRangeMaster)
                            //    {
                                    objInvest = new OrderedInvestigations();
                                    objInvest.ID = InvID;
                                    objInvest.Name =lblInvestigationName.Text;
                                    objInvest.VisitID = Convert.ToInt64(lblVisitID.Text);
                                    objInvest.Status = "Paid";
                                    objInvest.PaymentStatus = "Paid";
                                    objInvest.CreatedBy = LID;
                                    objInvest.Type = lbltype.Text;
                                    objInvest.OrgID = OrgID;
                                    objInvest.LabNo = LabNo;
                                    objInvest.ReferenceType = "F";
                                    //Added By Prasanna.S to Save Labno in orderedinvestigation
                                    objInvest.ComplaintId = Convert.ToInt32(LabNo);
                                    if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                                    {
                                        objInvest.UID = GUID = lblOrderedUID.Text;
                                    }
                                    else
                                    {
                                        objInvest.UID = GUID = lblRootUID.Text;
                                    }
                                    objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                                    ordInves.Add(objInvest);
                            //    }
                            //}
                        }

                        objQueryMaster.Querystring = QueryString;
                        objQueryMaster.PatientID = hdnPatientID.Value;
                        objQueryMaster.GuId = GUID.ToString();
                        objQueryMaster.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);

                        if (hdnStatus.Value != "")
                        {
                            objQueryMaster.Status = hdnStatus.Value;
                        }
                        
                        //page = "/Lab/InvestigationSample.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString() + "&taskactionid=22";
                    }
                    else
                    {
                        if (hdnStatus.Value == InvStatus.Retest)
                        {
                            objInvest = new OrderedInvestigations();
                            objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                            objInvest.Name = lblInvestigationName.Text;
                            objInvest.VisitID = Convert.ToInt64(lblVisitID.Text);
                            objInvest.Status = "Pending";
                            objInvest.PaymentStatus = "Paid";
                            objInvest.CreatedBy = LID;
                            objInvest.Type = "INV";
                            objInvest.OrgID = OrgID;
                            objInvest.LabNo = LabNo;
                            objInvest.ReferenceType = "R";
                            //Added By Prasanna.S to Save Labno in orderedinvestigation
                            objInvest.ComplaintId = Convert.ToInt32(LabNo);
                            if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                            {
                                objInvest.UID = GUID = lblOrderedUID.Text;
                            }
                            else
                            {
                                objInvest.UID = GUID;
                            }
                            objInvest.ReferedToLocation = ILocationID;
                            objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                            objInvest.StudyInstanceUId = "";
                            ordInves.Add(objInvest);
                            //page = "/Investigation/InvestigationResultsCapture.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString() + "&Invid=";
                        }
                        if (hdnStatus.Value == "Reflexwithnewsample")
                        {
                            long InvID = 0;
                            List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
                            InvID = Convert.ToInt64(lblInvestigationID.Text);
                            //returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                            //if (lstInvValueRangeMaster.Count > 0)
                            //{
                            //    foreach (InvValueRangeMaster oInvValueRangeMaster in lstInvValueRangeMaster)
                            //    {
                                    objInvest = new OrderedInvestigations();
                                    objInvest.ID = InvID;
                                    objInvest.Name = lblInvestigationName.Text;
                                    objInvest.VisitID = Convert.ToInt64(lblVisitID.Text);
                                    objInvest.Status = "Pending";
                                    objInvest.PaymentStatus = "Paid";
                                    objInvest.CreatedBy = LID;
                                    objInvest.Type = lbltype.Text;
                                    objInvest.OrgID = OrgID;
                                    objInvest.LabNo = LabNo;
                                    objInvest.ReferenceType = "F";
                                    //Added By Prasanna.S to Save Labno in orderedinvestigation
                                    objInvest.ComplaintId = Convert.ToInt32(LabNo);
                                    if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                                    {
                                        objInvest.UID = GUID = lblOrderedUID.Text;
                                    }
                                    else
                                    {
                                        objInvest.UID = GUID = lblRootUID.Text;
                                    }
                                    objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                                    objInvest.StudyInstanceUId = "";
                                    ordInves.Add(objInvest);
                            //    }
                            //}
                        }
                        objQueryMaster.Querystring = QueryString;
                        objQueryMaster.PatientID = hdnPatientID.Value;
                        objQueryMaster.GuId = GUID.ToString();

                    }


                    if (ordInves.Count > 0)
                    {
                        returnCode = InvBL.SaveOrderedInvestigation(ordInves, OrgID);
                    }

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
                    List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
                    int pOrderedCount = -1;
                    InvBL.GetInvestigationSamplesCollect(Convert.ToInt64(hdnvid.Value), OrgID, RoleID, GUID, ILocationID,22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

                    foreach (PatientInvestigation patient in lstPatientInvestigation)
                    {
                        PatientInvestigation objPinvest = new PatientInvestigation();
                        objPinvest.InvestigationID = patient.InvestigationID;
                        objPinvest.InvestigationName = patient.InvestigationName;
                        objPinvest.PatientVisitID = patient.PatientVisitID;
                        objPinvest.GroupID = patient.GroupID;
                        objPinvest.GroupName = patient.GroupName;
                        objPinvest.Status = patient.Status;
                        objPinvest.CollectedDateTime = patient.CreatedAt;
                        objPinvest.CreatedBy = LID;
                        objPinvest.Type = patient.Type;
                        objPinvest.OrgID = OrgID;
                        objPinvest.InvestigationMethodID = 0;
                        objPinvest.KitID = 0;
                        objPinvest.InstrumentID = 0;
                        objPinvest.UID = patient.UID;
                        SaveInvestigation.Add(objPinvest);
                    }
                    if (lstPatientInvestigation.Count > 0)
                    {
                        if (lstPatientInvestigation[0].UID != null)
                        {
                            GUID = lstPatientInvestigation[0].UID;
                        }
                    }
                    if (SaveInvestigation.Count > 0 && dList.SelectedValue != "Collect_sample_InvestigationSample")
                    {
                        returnCode = InvBL.SavePatientInvestigation(SaveInvestigation, OrgID, GUID, out pOrderedCount);
                    }
                    objQueryMaster.PatientVisitID = hdnvid.Value;
                    objQueryMaster.ClientID = hdnClientID.Value;
                    objQueryMaster.TaskID = "0";
                    objQueryMaster.AccessionNumber = hdnLabNumber.Value;
                    objQueryMaster.TestID = hdnTestID.Value;

                    if (hdnStatus.Value != "")
                    {
                        objQueryMaster.Status = hdnStatus.Value;
                    }

                    Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                    if (!String.IsNullOrEmpty(RedirectURL))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                    else
                    {
                        string aUsrMsg1 = Resources.Lab_InvestigationQueue_ClientDisplay.Lab_InvestigationQueue_aspx_002;
                        string aInformation1 = Resources.Lab_InvestigationQueue_ClientDisplay.Lab_InvestigationQueue_aspx_001 == null ? "URL Not Found." : Resources.Lab_InvestigationQueue_ClientDisplay.Lab_InvestigationQueue_aspx_001;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + aUsrMsg1 + "','" + aInformation1 + "');", true);
                    
                       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
                    }
                    //Response.Redirect(Request.ApplicationPath + page + "&TestID=" + hdnTestID.Value.ToString() + "&vid=" + hdnvid.Value.ToString() + "&tid=0" + "&cid=" + hdnClientID.Value.ToString() + "&AccNo=" + hdnAccessionNumber.Value.ToString(), true);
                }
            }

            }
        }

    }
    protected void btnOk_Click(object sender, EventArgs e)
    {
        string page = string.Empty;
        string LabNo = string.Empty;
        List<OrderedInvestigations> ordInves = new List<OrderedInvestigations>();
        long RefID = -1; string RefType = "";
        returnCode = InvBL.GetNextBarcode(OrgID, ILocationID, "INV", out LabNo, RefID, RefType);
        QueryMaster objQueryMaster = new QueryMaster();
         
        string RedirectURL = string.Empty;
        string QueryString = string.Empty;
        //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
        //{
        //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
        //}
        #region View State Action List
        string ActCode = dList.SelectedValue;
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
        if (dList.SelectedValue == "Collect_sample_InvestigationSample")
        {
            foreach (GridViewRow Gv in grdResult.Rows)
            {
                OrderedInvestigations objInvest;
                Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
                Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
                Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");
                Label lblOrderedUID = (Label)Gv.FindControl("lblOrderedUID");
                Label lblVisitID = (Label)Gv.FindControl("lblVisitID");
                CheckBox chkID = (CheckBox)Gv.FindControl("ChkSel");
                HiddenField hdnStatus = (HiddenField)Gv.FindControl("hdnStatus");
                Label lblRootUID = (Label)Gv.FindControl("lblRootUID");
                Label lblType = (Label)Gv.FindControl("lblType");
                if (chkID.Checked == true && hdnStatus.Value == InvStatus.Retest)
                {
                    objInvest = new OrderedInvestigations();
                    objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                    objInvest.Name = lblInvestigationName.Text;
                    objInvest.VisitID = Convert.ToInt64(lblVisitID.Text);
                    objInvest.Status = "Paid";
                    objInvest.PaymentStatus = "Paid";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = lblType.Text;
                    objInvest.OrgID = OrgID;
                    objInvest.LabNo = LabNo;
                    objInvest.ReferenceType = "R";
                    //Added By Prasanna.S to Save Labno in orderedinvestigation
                    objInvest.ComplaintId = Convert.ToInt32(LabNo);
                    if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                    {
                        objInvest.UID = GUID = lblOrderedUID.Text;
                    }
                    else
                    {
                        objInvest.UID = GUID;
                    }
                    objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                    objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                    ordInves.Add(objInvest);
                }
                if (chkID.Checked == true && hdnStatus.Value == "Reflexwithnewsample")
                {
                    long InvID=0;
                    List<InvValueRangeMaster> lstInvValueRangeMaster=new List<InvValueRangeMaster>();
                    InvID=Convert.ToInt64(lblInvestigationID.Text);
                    //returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID,OrgID,out lstInvValueRangeMaster);
                    //if (lstInvValueRangeMaster.Count > 0)
                    //{
                       //// foreach (InvValueRangeMaster oInvValueRangeMaster in lstInvValueRangeMaster)
                        //{
                            objInvest = new OrderedInvestigations();
                            objInvest.ID = InvID;
                            objInvest.Name = lblInvestigationName.Text;
                            objInvest.VisitID = Convert.ToInt64(lblVisitID.Text);
                            objInvest.Status = "Paid";
                            objInvest.PaymentStatus = "Paid";
                            objInvest.CreatedBy = LID;
                            objInvest.Type = lblType.Text;
                            objInvest.OrgID = OrgID;
                            objInvest.LabNo = LabNo;
                            objInvest.ReferenceType = "F";
                            //Added By Prasanna.S to Save Labno in orderedinvestigation
                            objInvest.ComplaintId = Convert.ToInt32(LabNo);
                            if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                            {
                                objInvest.UID = GUID = lblOrderedUID.Text;
                            }
                            else
                            {
                                objInvest.UID = GUID = lblRootUID.Text;
                            }
                            objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                            objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                            ordInves.Add(objInvest);
                        //}
                   // }
                }
            }
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = hdnPatientID.Value;
            objQueryMaster.GuId = GUID.ToString();
            objQueryMaster.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
           // page = "/Lab/InvestigationSample.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString() + "&taskactionid=22";
        }
        else
        {
            foreach (GridViewRow Gv in grdResult.Rows)
            {
                OrderedInvestigations objInvest = new OrderedInvestigations();
                Label lblInvestigationID = (Label)Gv.FindControl("lblInvestigationID");
                Label lblType = (Label)Gv.FindControl("lblType");
                Label lblInvestigationName = (Label)Gv.FindControl("lblInvestigationName");
                Label lblAccessionNumber = (Label)Gv.FindControl("lblAccessionNumber");
                Label lblOrderedUID = (Label)Gv.FindControl("lblOrderedUID");
                CheckBox chkID = (CheckBox)Gv.FindControl("ChkSel");
                HiddenField hdnStatus = (HiddenField)Gv.FindControl("hdnStatus");
                Label lblRootUID = (Label)Gv.FindControl("lblRootUID");
                if (chkID.Checked == true && hdnStatus.Value == InvStatus.Retest)
                {
                    objInvest.ID = Convert.ToInt64(lblInvestigationID.Text);
                    objInvest.Name = lblInvestigationName.Text;
                    objInvest.VisitID = Convert.ToInt64(hdnvid.Value);
                    objInvest.Status = "Pending";
                    objInvest.PaymentStatus = "Paid";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = lblType.Text;
                    objInvest.OrgID = OrgID;
                    objInvest.LabNo = LabNo;
                    objInvest.ReferenceType = "R";
                    //Added By Prasanna.S to Save Labno in orderedinvestigation
                    objInvest.ComplaintId = Convert.ToInt32(LabNo);
                    if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                    {
                        objInvest.UID = GUID = lblOrderedUID.Text;
                    }
                    else
                    {
                        objInvest.UID = GUID;
                    }
                    objInvest.ReferedToLocation = ILocationID;
                    objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                    objInvest.StudyInstanceUId = "";
                    ordInves.Add(objInvest);

                }
                if (chkID.Checked == true && hdnStatus.Value == "Reflexwithnewsample")
                {
                    long InvID = 0;
                    List<InvValueRangeMaster> lstInvValueRangeMaster = new List<InvValueRangeMaster>();
                    InvID = Convert.ToInt64(lblInvestigationID.Text);
                    //returnCode = InvBL.GetReflexTestDetailsbyInvID(InvID, OrgID, out lstInvValueRangeMaster);
                    //if (lstInvValueRangeMaster.Count > 0)
                    //{
                    //    foreach (InvValueRangeMaster oInvValueRangeMaster in lstInvValueRangeMaster)
                    //    {
                            objInvest = new OrderedInvestigations();
                            objInvest.ID = InvID;
                            objInvest.Name = lblInvestigationName.Text;
                            objInvest.VisitID = Convert.ToInt64(hdnvid.Value);
                            objInvest.Status = "Pending";
                            objInvest.PaymentStatus = "Paid";
                            objInvest.CreatedBy = LID;
                            objInvest.Type = lblType.Text;
                            objInvest.OrgID = OrgID;
                            objInvest.LabNo = LabNo;
                            objInvest.ReferenceType = "F";
                            //Added By Prasanna.S to Save Labno in orderedinvestigation
                            objInvest.ComplaintId = Convert.ToInt32(LabNo);
                            if (lblOrderedUID.Text != null && lblOrderedUID.Text != "")
                            {
                                objInvest.UID = GUID = lblOrderedUID.Text;
                            }
                            else
                            {
                                objInvest.UID = GUID = lblRootUID.Text;
                            }
                            objInvest.ReferralID = Convert.ToInt64(lblAccessionNumber.Text);
                            objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                            ordInves.Add(objInvest);
                    //    }
                    //}
                }
            }
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = hdnPatientID.Value;
            objQueryMaster.GuId = GUID.ToString();
            //page = "/Investigation/InvestigationResultsCapture.aspx?gUID=" + GUID.ToString() + "&pid=" + hdnPatientID.Value.ToString() + "&Invid=";
        }
        if (ordInves.Count > 0)
        {
            returnCode = InvBL.SaveOrderedInvestigation(ordInves, OrgID);
        }

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
        List<PatientInvestigation> SaveInvestigation = new List<PatientInvestigation>();
        int pOrderedCount = -1;
        InvBL.GetInvestigationSamplesCollect(Convert.ToInt64(hdnvid.Value), OrgID, RoleID, GUID, ILocationID, 22, out lstPatientInvestigation, out lstInvSampleMaster, out lstInvDeptMaster, out lstRoleDept, out lstOrderedInvSample, out deptList, out lstSampleContainer);

        foreach (PatientInvestigation patient in lstPatientInvestigation)
        {

            PatientInvestigation objInvest = new PatientInvestigation();
            objInvest.InvestigationID = patient.InvestigationID;
            objInvest.InvestigationName = patient.InvestigationName;
            objInvest.PatientVisitID = patient.PatientVisitID;
            objInvest.GroupID = patient.GroupID;
            objInvest.GroupName = patient.GroupName;
            objInvest.Status = patient.Status;
            objInvest.CollectedDateTime = patient.CreatedAt;
            objInvest.CreatedBy = LID;
            objInvest.Type = patient.Type;
            objInvest.OrgID = OrgID;
            objInvest.InvestigationMethodID = 0;
            objInvest.KitID = 0;
            objInvest.InstrumentID = 0;
            objInvest.UID = patient.UID;
            SaveInvestigation.Add(objInvest);
        }
        if (lstPatientInvestigation.Count > 0)
        {
            if (lstPatientInvestigation[0].UID != null)
            {
                GUID = lstPatientInvestigation[0].UID;
            }
        }
        if (SaveInvestigation.Count > 0 && dList.SelectedValue != "Collect_sample_InvestigationSample")
        {
            returnCode = InvBL.SavePatientInvestigation(SaveInvestigation, OrgID, GUID, out pOrderedCount);
        }
        objQueryMaster.PatientVisitID = hdnvid.Value;
        objQueryMaster.ClientID = hdnClientID.Value;
        objQueryMaster.TaskID = "0";
        objQueryMaster.AccessionNumber = hdnAccessionNumber.Value;
        objQueryMaster.TestID = hdnTestID.Value;
        Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
        if (!String.IsNullOrEmpty(RedirectURL))
        {
            Response.Redirect(RedirectURL, true);
        }
        else
        {
            string aUsrMsg1 = Resources.Lab_InvestigationQueue_ClientDisplay.Lab_InvestigationQueue_aspx_002;
            string aInformation1 = Resources.Lab_InvestigationQueue_ClientDisplay.Lab_InvestigationQueue_aspx_001 == null ? "URL Not Found." : Resources.Lab_InvestigationQueue_ClientDisplay.Lab_InvestigationQueue_aspx_001;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert_002", "javascript:ValidationWindow('" + aUsrMsg1 + "','" + aInformation1 + "');", true);
                    
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
        }
        //Response.Redirect(Request.ApplicationPath + page + "&TestID=" + hdnTestID.Value.ToString() + "&vid=" + hdnvid.Value.ToString() + "&tid=0" + "&cid=" + hdnClientID.Value.ToString() + "&AccNo=" + hdnAccessionNumber.Value.ToString(), true);
    }



    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }
    private string GetUniqueKey()
    {
        int maxSize = 10;
        char[] chars = new char[62];
        string a;
        //a = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        a = "0123456789012345678901234567890123456789012345678901234567890123456789";
        chars = a.ToCharArray();
        int size = maxSize;
        byte[] data = new byte[1];
        RNGCryptoServiceProvider crypto = new RNGCryptoServiceProvider();
        crypto.GetNonZeroBytes(data);
        size = maxSize;
        data = new byte[size];
        crypto.GetNonZeroBytes(data);
        StringBuilder result = new StringBuilder(size);
        foreach (byte b in data)
        { result.Append(chars[b % (chars.Length - 1)]); }
        return result.ToString();
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {

        long PatientID = -1;
        long SampleCode = -1;
        long ClientID = -1;
        long LocationID = -1;
        string BillNumber = String.Empty;
        string Priority = string.Empty;
        string TestType = string.Empty;
        if (hdnSearchPatientID.Value == "")
        {
            PatientID = 0;
        }
        if (hdnSearchPatientID.Value != null && hdnSearchPatientID.Value != "")
        {
            PatientID = Convert.ToInt64(hdnSearchPatientID.Value);
        }

        if (txtBillNumber.Text != null && txtBillNumber.Text != "")
        {
            BillNumber = txtBillNumber.Text.Trim();
        }
        if (ddClientName.SelectedValue != "-1")
        {
            ClientID =Convert.ToInt64(ddClientName.SelectedValue);
        }
        if (ddlocation.SelectedValue != "-1")
        {
            LocationID = Convert.ToInt64(ddlocation.SelectedValue);
        }
        if (ddlPriority.SelectedValue != "-1")
        {
            Priority = ddlPriority.SelectedValue;
        }
        if (ddlTestType.SelectedValue != "-1")
        {
            if (ddlTestType.SelectedValue == "Recollect")
            {
                TestType = "Retest";
            }
            else
            {
                TestType = ddlTestType.SelectedValue;
            }
        }
        SampleCode = Convert.ToInt64(ddlSampleName.SelectedItem.Value);
        InvBL.GetPatientDetailsForRetest(OrgID, txtFrom.Text, txtTo.Text, PatientID, BillNumber, ClientID, LocationID, Priority, TestType, out lstRetestPatients);
      
        grdMain.DataSource = lstRetestPatients;
        grdMain.DataBind();
        InvGrd.Style.Add("display", "none");
        if (lstRetestPatients.Count > 0)
        {
            aRow.Style.Add("display", "block");
        }
        else
        {
            aRow.Style.Add("display", "none");
        }
    }
    public void GetInvestigation()
    {
        string TestType = string.Empty;
        if (rdoRetest.Checked == true)
        {
            searchtype = 1;
            dList.Visible = true;
            dList1.Visible = false;

        }
        else if (rdoRefelectTest.Checked == true)
        {
            searchtype = 2;
            dList1.Visible = true;
            dList.Visible = false;

        }
        else
        {
            searchtype = 0;
        }
        if (ddlTestType.SelectedValue != "-1")
        {
            TestType = ddlTestType.SelectedValue;
        }
        if (TestType == "Retest")
        {
            searchtype = 1;
        }
        if (TestType == "Reflexwithnewsample")
        {
            searchtype = 2;
        }
        foreach (GridViewRow Gv in grdMain.Rows)
        {
            RadioButton rdoSel = (RadioButton)Gv.FindControl("rdoSel");
            Label lblVisitID = (Label)Gv.FindControl("lblVisitID");
            if (rdoSel.Checked == true)
            {
                InvBL.GetTestDetails(OrgID, searchtype, 0, hdnSelectedVisitID.Value, 0, out lstTest);
                hdnchkids.Value = "";
                grdResult.DataSource = lstTest;
                grdResult.DataBind();
                if (lstTest.Count > 0)
                {
                    InvGrd.Style.Add("display", "block");
                    aRow.Style.Add("display", "block");
                    ModalPopupExtender1.Show();
                }
                else
                {
                    aRow.Style.Add("display", "none");
                }
            }
        }

    }

    protected void grdMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InvestigationQueue iq = (InvestigationQueue)e.Row.DataItem;
                string strScript = "javascript:selectvisitid('" + ((RadioButton)e.Row.Cells[1].FindControl("rdoSel")).ClientID + "','" + iq.VisitID + "','" + iq.PatientID + "');";
                ((RadioButton)e.Row.Cells[1].FindControl("rdoSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[1].FindControl("rdoSel")).Attributes.Add("onclick", strScript);
            }
        }
        catch (Exception Ex)
        {
            //report error
        }

    }
    public void LoadSourceNameTrustedOrg()
    {
        try
        {
            long returnCode = -1;
            Patient_BL objPatientBL = new Patient_BL(base.ContextInfo);
            List<InvClientMaster> lstSourceName = new List<InvClientMaster>();
            returnCode = objPatientBL.GetTrustedOrgInvClientMaster(OrgID, "", out lstSourceName);
            if (CID > 0)
            {
                var lstLinqInvclientMaster = from child in lstSourceName
                                             where child.ClientID == CID
                                             select child;
                if (lstLinqInvclientMaster.Count() > 0)
                {
                    ddClientName.DataSource = lstLinqInvclientMaster;
                    ddClientName.DataTextField = "ClientName";
                    ddClientName.DataValueField = "ClientID";
                    ddClientName.DataBind();
                }
                ddClientName.Attributes.Add("disabled", "true");
            }
            else
            {
            if (lstSourceName.Count > 0)
            {
                ddClientName.DataSource = lstSourceName;
                ddClientName.DataTextField = "ClientName";
                ddClientName.DataValueField = "ClientID";
                ddClientName.DataBind();
            }
            ddClientName.Items.Insert(0, strSelects);
            ddClientName.Items[0].Value = "-1";
            }
        }
        catch (Exception e)
        {
            CLogger.LogError("Error while executing LoadSourceName() in Investigation Queue ", e);
        }
    }
    public void SetToolTip(DropDownList cmb)
    {
        if (cmb.Items.Count > 0)
        {
            foreach (ListItem item in cmb.Items)
            {
                item.Attributes.Add("Title", item.Text);
            }
        }
    }
    public void LoadFromAbberantQueue()
    {
        string FDate = string.Empty;
        string TDate = string.Empty;
        string LocationType = String.Empty;
        string TestType = String.Empty;
        if (Request.QueryString["Location"] != null)
        {
            LocationType = Request.QueryString["Location"];
        }
        if (Request.QueryString["Status"] != null)
        {
            TestType = Request.QueryString["Status"];
            ddlTestType.SelectedValue = TestType;
        }
        FDate = Request.QueryString["FDate"];
        FDate = Convert.ToDateTime(FDate).AddDays(-1).AddDays(1).ToString("dd-MM-yyyy hh:mm tt");
        TDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMinutes(2).ToString("dd-MM-yyyy hh:mm tt");
        txtFrom.Text = FDate;
        txtTo.Text = TDate;
        if (CID > 0)
        {
            InvBL.GetPatientDetailsForRetest(OrgID, FDate, TDate, 0, "", CID, -1, "All", TestType, out lstRetestPatients);
        }
        else
        {
            InvBL.GetPatientDetailsForRetest(OrgID, FDate, TDate, 0, "", -1, -1, "All", TestType, out lstRetestPatients);
        }

        if (LocationType == "CL")
        {
            ddlocation.SelectedValue = ILocationID.ToString();
            lstTempRetestPatients = lstRetestPatients.FindAll(P => P.AddressID == ILocationID);
        }
        else if (LocationType == "OL")
        {
            lstTempRetestPatients = lstRetestPatients.FindAll(P => P.AddressID != ILocationID);
        }
        else
        {
            lstTempRetestPatients = lstRetestPatients;
        }
        grdMain.DataSource = lstTempRetestPatients;
        grdMain.DataBind();
        if (lstTempRetestPatients.Count > 0)
        {
            aRow.Style.Add("display", "block");
            dList.Visible = true;
        }
        else
        {
            aRow.Style.Add("display", "none");
        }
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;

            string domains = "Preference,TestType,invlist";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Preference"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlPriority.DataSource = childItems;
                    ddlPriority.DataTextField = "DisplayText";
                    ddlPriority.DataValueField = "Code";
                    ddlPriority.DataBind();
                }
                var childItems1 = from child in lstmetadataOutput
                                 where child.Domain == "TestType"
                                 orderby child.DisplayText ascending
                                 select child;
                if (childItems1.Count() > 0)
                {
                    ddlTestType.DataSource = childItems1;
                    ddlTestType.DataTextField = "DisplayText";
                    ddlTestType.DataValueField = "Code";
                    ddlTestType.DataBind();
                }
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "invlist"
                                  orderby child.DisplayText ascending
                                  select child;
                if (childItems2.Count() > 0)
                {
                    dList1.DataSource = childItems1;
                    dList1.DataTextField = "DisplayText";
                    dList1.DataValueField = "Code";
                    dList1.DataBind();
                }
            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data  ", ex);
            //edisp.Visible = true;
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

}

    