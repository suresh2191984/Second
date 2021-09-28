using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;
using Attune.Podium.BillingEngine;
using System.Globalization;
using System.Text;
using System.Security.Cryptography;

public partial class Physician_PatientDiagnose : BasePage
{

    public Physician_PatientDiagnose()
        : base("Physician\\PatientDiagnose.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    int VisitType = -1;
    int complaintID;
    public string drugIDs = string.Empty;
    long visitID = 0;
    long previousVisitID = 0;
    long patientID = 0;
    long createdBy = 0;
    int taskID = 0;
    string patientName = string.Empty;
    string hidValue = string.Empty;
    string pos = string.Empty;
    string PaymentLogic = String.Empty;
    string InvDrugData = string.Empty;
    string complaintName = string.Empty;
    string NextReview = string.Empty;
    string NextReviewNos = string.Empty;
    string NextReviewDMY = string.Empty;
    string[] nReview;
    string isBgP = string.Empty;
    string gUID = string.Empty;
    int invLocation = 0;

    PatientComplaint patientComplaint = new PatientComplaint();
    List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
    List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); 
    List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
    List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
    List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    int count;

    protected void Page_Load(object sender, EventArgs e)
    {

        //txtReviewDate.Attributes.Add("onchange", "ExcedDate('" + txtReviewDate.ClientID.ToString() + "','',0,1);");
        try
        {
            Int32.TryParse(Convert.ToString(Session["count"]), out count);
            if (count > 1)
            {
                string QueryString = Request.Url.Query;
                Response.Redirect("../Physician/DisplayPatientComplaint.aspx" + QueryString, true);
            }
            this.PreRender += new EventHandler(Physician_PatientDiagnose_PreRender);

            tvInvestiation.Attributes.Add("onclick", "OnTreeClick(event)");
            //btnSubmit.Attributes.Add("onClick", "javascript:GetDesc();");
            btnSaveContinue.Attributes.Add("onClick", "javascript:GetDesc();");

            Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out visitID);
            Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
            //Added By Ramki
            Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);
            Int32.TryParse(Request.QueryString["id"], out complaintID);
            pos = Convert.ToString(Request.QueryString["POS"]);
            uIAdv.Pvid = visitID.ToString();
            if (!IsPostBack)
            {
                ComplaintICDCode1.ComplaintHeader = "Diagnosis";
                ComplaintICDCode1.SetWidth(500);
                //********** Form the Advice Control ************************/
                List<Config> lstConfigDD = new List<Config>();
                new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
                if (lstConfigDD.Count > 0)
                {
                    InvDrugData = lstConfigDD[0].ConfigValue.Trim();
                }
                if (InvDrugData == "Y")
                {
                    uAd.Visible = false;
                    uIAdv.Visible = true;
                }
                else
                {
                    uAd.Visible = true;
                    uIAdv.Visible = false;
                }

                if (IsCorporateOrg == "Y")
                {
                    //ASSPHY.Visible = false;
                    if (RoleName != "Physician")
                    {
                        tbAssPhy.Attributes.Add("Style", "display:block");
                        Loadphysician();
                    }
                }
            }

            if (Request.QueryString["pvid"] != null)
            {
                //Session commented by Ramki
                //Session.Add("PatientVisitID", Request.QueryString["vid"]);
                //Session.Add("TaskID", Request.QueryString["tid"]);

                Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int32.TryParse(Request.QueryString["tid"], out taskID);
                //long returncode = -1;
                new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(complaintID, previousVisitID, out patientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit, out isBgP);
                //Load already entered PatientVitals

                if (!IsPostBack)
                {
                    
                    if (InvDrugData == "Y")
                    {
                        uIAdv.SetPrescription(lstDrugDetails);
                    }
                    else
                    {
                        uAd.SetPrescription(lstDrugDetails);
                    }
                    if (lstPatientAdvice.Count > 0)
                    {
                          uGAdv.setGeneralAdvice(lstPatientAdvice);
                    }
                    if (lstPatientVisit.Count > 0)
                    {

                       // txtDiagnosisType.Text = patientComplaint.Description;
                        ComplaintICDCode1.SetDiagnoseComplaint(patientComplaint.ComplaintName, patientComplaint.ICDCode, patientComplaint.ICDDescription);

                        if (patientComplaint.Query.Equals("Y"))
                            cPD.Checked = true;

                        if (Convert.ToString(patientComplaint.Position) != "")
                        {
                            pos = Convert.ToString(patientComplaint.Position);

                            if (pos == "LEF" || pos == "RIG" || pos == "BIL") //e.g. LEFt eye, RIGht eye, BILateral
                            {
                                cPos.Text = "Bilateral";
                                lblPos.Text = pos;
                                if (pos == "BIL")
                                    cPos.Checked = true;
                            }
                            else if (pos == "UPP" || pos == "LOW" || pos == "BOT") //e.g. UPPer Jaw (T)/LOWer Jaw. BOTh
                            {
                                cPos.Text = "Both";
                                lblPos.Text = pos;
                                if (pos == "BOT")
                                    cPos.Checked = true;
                            }
                            cPos.Visible = true;
                        }
                        else
                        {
                            cPos.Visible = false;
                        }

                        if ((lstPatientVisit[0].NextReviewDate != null) && (lstPatientVisit[0].NextReviewDate != ""))
                        {
                            if (lstPatientVisit[0].NextReviewDate.Contains("/"))
                            {
                            }
                            else
                            {
                                NextReview = lstPatientVisit[0].NextReviewDate;
                                nReview = NextReview.Split('-');
                                if (nReview.Length > 0)
                                {
                                    NextReviewNos = nReview[0].ToString();
                                    NextReviewDMY = nReview[1].ToString();
                                    ddlNos.SelectedValue = NextReviewNos;
                                    ddlDMY.SelectedValue = NextReviewDMY;
                                }
                                if (lstPatientVisit[0].AdmissionSuggested == "Y")
                                {
                                    chkAdmit.Checked = true;
                                }
                            }
                        }
                    }
                }
                //Session commented by Ramki
                //Session.Add("PatientVisitID", Request.QueryString["vid"]);
                //Session.Add("TaskID", Request.QueryString["tid"]);
            }

            if (!IsPostBack)
            {
                //**********Form the redirect query for back button************************/
                string sRedirectURL = Convert.ToString(Request.QueryString["RedirectURL"]);
                string sQueryPath = Request.Url.PathAndQuery;

                if (sRedirectURL == null || sRedirectURL == "")
                {
                    sRedirectURL = Request.UrlReferrer.PathAndQuery;
                    if (!sRedirectURL.Contains(".aspx"))
                        sRedirectURL = "Diagnose.aspx?vid=" + visitID + "&tid=" + taskID + "&pid=" + patientID;

                    if (sRedirectURL.Contains("RedirectURL"))
                    {
                        sRedirectURL = sRedirectURL.Substring(0, sRedirectURL.IndexOf("RedirectURL") - 1);
                    }

                }

                if (sQueryPath.Contains("RedirectURL"))
                {
                    sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL") - 1);
                }

                sRedirectURL = sRedirectURL.Replace("^~", "&");
                sQueryPath = sQueryPath.Replace("&", "^~");

                if (sRedirectURL.Contains("?"))
                    sRedirectURL = sRedirectURL + "&RedirectURL=" + sQueryPath;
                else
                    sRedirectURL = sRedirectURL + "?RedirectURL=" + sQueryPath;

                lblRedirectURL.Text = sRedirectURL;
                //***************************************************************************/

                PatientVitalsControl.FindControl("txtTemp").Focus();
                PatientVitalsControl.VisitID = visitID;
                PatientVitalsControl.LoadControls("U", patientID);
            }

            if (!((Int32.TryParse(Request.QueryString["id"], out complaintID))))
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "Visit ID and/or ComplaintID not found";
            }
            else
            {
                if (Request.QueryString["POS"] != null)
                {
                    pos = Request.QueryString["POS"];
                    if (pos == "L" || pos == "R") //e.g. (L)eft eye/(R)ight eye
                    {
                        cPos.Text = "Bilateral";
                        if (pos == "L")
                            lblPos.Text = "LEF";
                        else if (pos == "R")
                            lblPos.Text = "RIG";
                    }
                    else if (pos == "U" || pos == "B") //e.g. Upper Jaw (T)/Lower Jaw (B)
                    {
                        cPos.Text = "Both";
                        if (pos == "U")
                            lblPos.Text = "UPP";
                        else if (pos == "B")
                            lblPos.Text = "LOW";
                    }
                    cPos.Visible = true;
                }
                else
                {
                    cPos.Visible = false;
                }

                if (!IsPostBack)
                {
                    //patientHeader.PatientID = patientID;
                    //patientHeader.PatientVisitID = visitID;
                    //patientHeader.ShowVitalsDetails();

                    //GetDiagnoseInfo(complaintID);

                    List<Examination> lstExamination = new List<Examination>();
                    List<History> lstHistory = new List<History>();
                    List<InvestigationMaster> lstInvestigation = new List<InvestigationMaster>();
                    List<OrderedInvestigations> lstPatInvestigationHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatInvestigation = new List<PatientInvestigation>(); 
                    long returnCode = -1;

                    if (lstDrugDetails.Count == 0)
                    {
                        //Only for getting DrugDetails

                        List<PatientHistory> lstHis = new List<PatientHistory>();
                        List<PatientExamination> lstExam = new List<PatientExamination>();
                        new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(0, visitID, out patientComplaint, out lstPatInvestigationHL, out lstHis, out lstExam, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit, out isBgP);
                        if (InvDrugData == "Y")
                        {
                            uIAdv.SetPrescription(lstDrugDetails);
                        }
                        else
                        {
                            uAd.SetPrescription(lstDrugDetails);
                        }
                        if (lstPatientAdvice.Count > 0)
                        {
                              uGAdv.setGeneralAdvice(lstPatientAdvice);
                        }

                        if (lstPatientVisit[0].NextReviewDate != null && lstPatientVisit[0].NextReviewDate!="")
                        {
                            NextReview = lstPatientVisit[0].NextReviewDate;
                            nReview = NextReview.Split('-');
                            if (nReview.Length > 0)
                            {
                                NextReviewNos = nReview[0].ToString();
                                NextReviewDMY = nReview[1].ToString();
                                ddlNos.SelectedValue = NextReviewNos;
                                ddlDMY.SelectedValue = NextReviewDMY;
                            }
                            if (lstPatientVisit[0].AdmissionSuggested == "Y")
                            {
                                chkAdmit.Checked = true;
                            }
                        }
                    }
                    returnCode = new Uri_BL(base.ContextInfo).GetDiagnosePageData(complaintID, out lstExamination, out lstHistory, out lstInvestigation, out complaintName);

                    List<Complaint> lstComplaint=new List<Complaint>();
                    new Patient_BL(base.ContextInfo).GetICDCodeByComplaintID(complaintID, out lstComplaint);
                    if (lstComplaint.Count > 0)
                    {
                        ComplaintICDCode1.ICDCode = lstComplaint[0].ICDCode;
                        ComplaintICDCode1.ICDDesc = lstComplaint[0].ICDDescription;
                    }
                    lblDiagnosisHeader.Text = complaintName;
                    ComplaintICDCode1.ComplaintName = complaintName;
                    ComplaintICDCode1.AddBtnVisible = "False";
                    ComplaintICDCode1.SetComplaint();

                    lblIsBgP.Text = "Is " + complaintName + " Background Problem";
                    SetExamination(lstExamination);
                    SetHistory(lstHistory);
                    List<OrderedInvestigations> lstInvestigationChildHL = new List<OrderedInvestigations>(); List<PatientInvestigation> lstInvestigationChild = new List<PatientInvestigation>();
                    //lstPatientInvestigation = new List<PatientInvestigation>();
                    List<InvestigationMaster> lstInvestigationMaster = new List<InvestigationMaster>();
                    returnCode = new Investigation_BL(base.ContextInfo).GetComplaintInvestigation(complaintID, OrgID, out lstInvestigationMaster, out  lstInvestigationChild); //returnCode = new Investigation_BL(base.ContextInfo).GetComplaintInvestigation(complaintID, OrgID, out lstInvestigationMaster, out lstInvestigationChildHL); 
                    SetInvestigationHL(lstInvestigationMaster, lstInvestigationChild); //SetInvestigation(lstInvestigationMaster, lstInvestigationChild); 
                    //uAd.SetPrescription(dlist);     
                    tvInvestiation.CssClass = "defaultfontcolor";

                    if (PaymentLogic == String.Empty)
                    {
                        List<Config> lstConfig = new List<Config>();
                        new GateWay(base.ContextInfo).GetConfigDetails("CON", OrgID, out lstConfig);
                        if (lstConfig.Count > 0)
                            PaymentLogic = lstConfig[0].ConfigValue.Trim();
                    }
                    if (PaymentLogic == "After")
                    {
                        //chkAdditionalPayments.Visible = false;
                        chkAdditionalPayments.Visible = false;
                    }
                    else
                    {
                        chkAdditionalPayments.Visible = true;
                        pnlMiscellaneous.Visible = true;
                    }

                    //Load Data's to investigation Control
                    List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                    List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
                    int Rateid = 0;
                    new PatientVisit_BL(base.ContextInfo).GetVisitClientMappingDetails(OrgID, visitID, out lstVisitClientMapping);
                    if (lstVisitClientMapping.Count > 0)
                    {
                        Rateid = (int)lstVisitClientMapping[0].RateID;
                    }

                    new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.NotSpecific), 
                        complaintID,Rateid, out lstgroups, out lstInvestigations);
                    int orgBased = 0;
                    InvestigationControl1.OrgSpecific = orgBased;
                    InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
                    if (!IsPostBack)
                    {
                        if (isBgP != "")
                        {
                            if (complaintName == isBgP)
                            {
                                chkIsBgP.Checked = true;
                            }
                        }
                        int pCount = -1; long refID = -1;
                        new Referrals_BL(base.ContextInfo).CheckReferralsAvailable(visitID, Convert.ToInt32(TaskHelper.VisitPurpose.Consultation), out pCount, out refID);
                        if (pCount > 0)
                        {
                            chkRefer.Checked = true;
                        }

                        new Referrals_BL(base.ContextInfo).CheckReferralsAndCertificate(visitID, out pCount);
                        if (pCount > 0)
                        {
                            chkRefer.Checked = true;
                        }



                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Page Load in PatientDiagnose.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = ex.Message;
        }
        btnSubmit.Enabled = true;
        btnSaveContinue.Enabled = true;
    }

    void Physician_PatientDiagnose_PreRender(object sender, EventArgs e)
    {
        Response.Expires = 0;
        //Response.ExpiresAbsolute = new DateTime().AddDays(-1);
    }

    void SetExamination(List<Examination> examinations)
    {
        TVE.NodeStyle.CssClass = "defaultfontcolor";
        TVE.NodeIndent = -1;
        AddChildNode(TVE.Nodes[0], examinations);
    }

    void AddChildNode(TreeNode parent, List<Examination> examinations)
    {
        int parentID;
        parentID = Convert.ToInt32(parent.Value);
        var queryExaminations = from ex in examinations
                                where ex.ParentID == parentID
                                select ex;
        string str = string.Empty;

        foreach (var ex in queryExaminations)
        {
            str = ex.HasChild == 0 ? "<input id='tCE" + ex.ExaminationID.ToString() + "' type='checkbox'  value='' onclick=javascript:Showtext('tE" + ex.ExaminationID.ToString() + "','tCE" + ex.ExaminationID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tE" + ex.ExaminationID.ToString() + "','tCE" + ex.ExaminationID.ToString() + "');\">" + ex.ExaminationName + "</a>&nbsp;<input type='text' maxlength ='240' onfocus='expand_me(this)' onblur='shrink_me(this)' class='textbox_hemat' style='visibility:hidden;width:50px' id='tE" + ex.ExaminationID.ToString() + "'>" : ex.ExaminationName;
            if (lstPatientExamination.Count > 0)
            {
                for (int i = 0; i < lstPatientExamination.Count; i++)
                {
                    if (ex.ExaminationID == lstPatientExamination[i].ExaminationID)
                    {
                        str = ex.HasChild == 0 ? "<input id='tCE" +
                            ex.ExaminationID.ToString() + "' type='checkbox'  value='' checked='True' onclick=javascript:Showtext('tE" +
                            ex.ExaminationID.ToString() + "','tCE" +
                            ex.ExaminationID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tE" +
                            ex.ExaminationID.ToString() + "','tCE" + ex.ExaminationID.ToString() + "');\">" +
                            ex.ExaminationName + "</a>&nbsp;<input type='text' maxlength ='240'  class='textbox_hemat' onfocus='expand_me(this)' onblur='shrink_me(this)' style='visibility:visible;width:50px' id='tE" +
                            ex.ExaminationID.ToString() + "' Value='" +
                            lstPatientExamination[i].Description + "'>" : ex.ExaminationName;
                        break;
                    }

                }
            }

            TreeNode tn = new TreeNode();
            //tn.Text = ex.HasChild == 0 ? "<input id='tCE" + ex.ExaminationID.ToString() + "' type='checkbox' value='' onclick=javascript:Showtext('tE" + ex.ExaminationID.ToString() + "','tCE" + ex.ExaminationID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tE" + ex.ExaminationID.ToString() + "','tCE" + ex.ExaminationID.ToString() + "');\">" + ex.ExaminationName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tE" + ex.ExaminationID.ToString() + "'>" : ex.ExaminationName;
            tn.Text = str;
            tn.Value = ex.ExaminationID.ToString();
            //tn.ShowCheckBox = ex.HasChild == 0 ? true : false;
            tn.SelectAction = TreeNodeSelectAction.Expand;
            tn.PopulateOnDemand = false;
            tn.NavigateUrl = string.Empty;
            parent.ChildNodes.Add(tn);
            if (ex.HasChild != 0)
            {
                AddChildNode(tn, examinations);
            }
        }
    }

    void SetHistory(List<History> histories)
    {
        try
        {

            TVH.NodeStyle.CssClass = "defaultfontcolor";
            TVH.NodeIndent = 0;
            AddHistChildNode(TVH.Nodes[0], histories);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing GetHistory", ex);
        }
    }

    void AddHistChildNode(TreeNode parent, List<History> histories)
    {
        int parentID;
        parentID = Convert.ToInt32(parent.Value);
        var queryHistories = from ex in histories
                             where ex.ParentID == parentID
                             select ex;
        string treeNodeText = string.Empty;
        foreach (var ex in queryHistories)
        {
            treeNodeText = ex.HasChild == 0 ? "<input id='tCH" +
                ex.HistoryID.ToString() +
                "' type='checkbox' value='' onclick=javascript:Showtext('tH" +
                ex.HistoryID.ToString() + "','tCH" +
                ex.HistoryID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tH" +
                ex.HistoryID.ToString() + "','tCH" +
                ex.HistoryID.ToString() + "');\">" +
                ex.HistoryName + "</a>&nbsp;<input type='text' maxlength ='240' class='textbox_hemat' onfocus='expand_me(this)' onblur='shrink_me(this)'  style='visibility:hidden;width:50px' id='tH" +
                ex.HistoryID.ToString() + "'>" : ex.HistoryName;

            if (lstPatientHistory.Count > 0)
            {

                for (int i = 0; i < lstPatientHistory.Count; i++)
                {
                    if (ex.HistoryID == lstPatientHistory[i].HistoryID)
                    {
                        treeNodeText = ex.HasChild == 0 ? "<input id='tCH" +
                            ex.HistoryID.ToString() + "' type='checkbox' checked='True' value='' onclick=javascript:Showtext('tH" +
                            ex.HistoryID.ToString() + "','tCH" +
                            ex.HistoryID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tH" +
                            ex.HistoryID.ToString() + "','tCH" +
                            ex.HistoryID.ToString() + "');\">" +
                            ex.HistoryName + "</a>&nbsp;<input type='text' maxlength ='240' class='textbox_hemat' onfocus='expand_me(this)' onblur='shrink_me(this)' style='visibility:visible;width:50px' id='tH" +
                            ex.HistoryID.ToString() + "'value='" +
                            lstPatientHistory[i].Description + "'>" : ex.HistoryName;
                        break;
                    }

                }
            }

            TreeNode tn = new TreeNode();
            //tn.Text = ex.HasChild == 0 ? "<input id='tCH" + ex.HistoryID.ToString() + "' type='checkbox' value='' onclick=javascript:Showtext('tH" + ex.HistoryID.ToString() + "','tCH" + ex.HistoryID.ToString() + "'); /> <a style='text-decoration:none;color:#000000' href=\"javascript:Showtext('tH" + ex.HistoryID.ToString() + "','tCH" + ex.HistoryID.ToString() + "');\">" + ex.HistoryName + "</a>&nbsp;<input type='text' class='textbox_hemat' style='visibility:hidden;width:50px' id='tH" + ex.HistoryID.ToString() + "'>" : ex.HistoryName;
            tn.Text = treeNodeText;
            tn.Value = ex.HistoryID.ToString();
            tn.SelectAction = TreeNodeSelectAction.Expand;
            //tn.ShowCheckBox = ex.HasChild == 0 ? true : false;
            tn.PopulateOnDemand = false;
            tn.NavigateUrl = string.Empty;
            parent.ChildNodes.Add(tn);
            if (ex.HasChild != 0)
            {
                AddHistChildNode(tn, histories);
            }
        }

    }

    //void SetInvestigation(List<Investigation> investigations)
    //{
    //    try
    //    {
    //        foreach (Investigation inv in investigations)
    //        {
    //            ListItem li = new ListItem();
    //            li.Text = inv.InvestigationName;
    //            li.Value = inv.InvestigationID.ToString();
    //            chkInvList.Items.Add(li);



    //            if (lstPatientInvestigation.Count > 0)
    //            {
    //                for (int j = 0; j < lstPatientInvestigation.Count; j++)
    //                {
    //                    if (inv.InvestigationID == lstPatientInvestigation[j].InvestigationID)
    //                    {

    //                        li.Selected = true;
    //                    }
    //                }
    //            }

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while executing GetInvestigation", ex);
    //    }
    //}


    //void SetInvestigation(List<InvestigationMaster> lstinvestigationMaster, List<PatientInvestigation> lstPatInvesChild)
    //{

    //    String orderedList = string.Empty;
    //    //Draw List of invstigations and group in treeview control for complaint
    //    if (lstPatInvesChild != null)
    //    {
    //        if (lstPatInvesChild.Count > 0)
    //        {
    //            List<PatientInvestigation> pat = new List<PatientInvestigation>();


    //            //tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(lstPatInves[i].GroupName),Convert.ToString(lstPatInves[i].GroupID)));

    //            var invesQuery = from Inves in lstPatInvesChild
    //                             group Inves by Inves.GroupID into grp
    //                             select grp;


    //            int elementValue = 0;

    //            tvInvestiation.ForeColor = System.Drawing.Color.Black;
    //            foreach (IGrouping<Int32, PatientInvestigation> dr in invesQuery)
    //            {

    //                tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(dr.ElementAt(0).GroupName), Convert.ToString(dr.Key)));


    //                foreach (PatientInvestigation pi in dr)
    //                {
    //                    int count = tvInvestiation.Nodes.Count - 1;
    //                    tvInvestiation.Nodes[count].ChildNodes.Add(new TreeNode(pi.InvestigationName, Convert.ToString(pi.InvestigationID)));

    //                }


    //                elementValue++;
    //            }
    //        }
    //        string val = tvInvestiation.Nodes[0].Value;
    //    }
    //    if (lstinvestigationMaster != null)
    //    {
    //        if (lstinvestigationMaster.Count > 0)
    //        {
    //            List<InvestigationMaster> lstMaster = new List<InvestigationMaster>();
    //            foreach (InvestigationMaster inv in lstinvestigationMaster)
    //            {
    //                tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(inv.InvestigationName), Convert.ToString(inv.InvestigationID)));
    //            }
    //        }
    //    }

    //     if (lstPatientInvestigation.Count > 0)
    //    {
    //        //Append investigations that are ordered using more investigation route....

    //        foreach (PatientInvestigation pv in lstPatientInvestigation)
    //        {
    //            bool investigationAvailableInMapping = false;
    //            bool groupAvailableInMapping = false;

    //            foreach (TreeNode tr in tvInvestiation.Nodes)
    //            {
    //                if (tr.ChildNodes.Count > 0)
    //                {
    //                    foreach (TreeNode tChilditem in tr.ChildNodes)
    //                    {
    //                        if (pv.InvestigationID == Convert.ToInt32(tChilditem.Value))
    //                        {
    //                            investigationAvailableInMapping = true;
    //                            groupAvailableInMapping = true;
    //                        }
    //                    }
    //                }
    //                else
    //                {

    //                    if (pv.InvestigationID == Convert.ToInt32(tr.Value))
    //                    {
    //                        investigationAvailableInMapping = true;
    //                    }

    //                    if (pv.GroupID == Convert.ToInt32(tr.Value))
    //                    {
    //                        groupAvailableInMapping = true;
    //                    }

    //                }
    //            }

    //            if (!groupAvailableInMapping && !investigationAvailableInMapping)
    //            {
    //                if (pv.GroupID > 0)
    //                {
    //                    if (!orderedList.Contains(pv.GroupName))
    //                    {
    //                        orderedList += pv.GroupID + "~" + pv.GroupName + "~GRP^";
    //                    }
    //                }
    //                else
    //                {
    //                    if (!orderedList.Contains(pv.InvestigationName))
    //                    {
    //                        orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
    //                    }
    //                }

    //                continue;

    //            }

    //            if (!investigationAvailableInMapping && pv.GroupID < 1)
    //            {
    //                if (!orderedList.Contains(pv.InvestigationName))
    //                {
    //                    orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
    //                }

    //            }

    //            if (!groupAvailableInMapping)
    //            {
    //                if (pv.GroupID > 0)
    //                {
    //                    if (!orderedList.Contains(pv.GroupName))
    //                    {
    //                        orderedList += pv.GroupID + "~" + pv.GroupName + "~GRP^";
    //                    }
    //                }
    //            }
    //        }

    //        InvestigationControl1.setOrderedList(orderedList);


    //        //Select/Mark Investigation that are ordered based on the Complaint Investigation
    //        //mapping.

    //        foreach (TreeNode tr in tvInvestiation.Nodes)
    //        {
    //            var query = from inv in lstPatientInvestigation
    //                        where inv.GroupID
    //                        == Convert.ToInt64(tr.Value)
    //                        select inv;

    //            if (query.Count() == 0)
    //            {
    //                foreach (TreeNode cTR in tr.ChildNodes)
    //                {
    //                    var invesQuery = from inv in lstPatientInvestigation
    //                                     where inv.InvestigationID == Convert.ToInt64(cTR.Value)
    //                                     select inv;
    //                    if (invesQuery.Count() > 0)
    //                    {
    //                        if (cTR.Value == Convert.ToString(invesQuery.ElementAt(0).InvestigationID))
    //                        {
    //                            cTR.Checked = true;

    //                        }
    //                    }
    //                }
    //            }


    //            if (query.Count() > 0)
    //            {
    //                int checkedStatus = 0;
    //                foreach (TreeNode cTR in tr.ChildNodes)
    //                {
    //                    for (int i = 0; i < query.Count(); i++)
    //                    {
    //                        long str = query.ElementAt(i).InvestigationID;
    //                        int childCount = tr.ChildNodes.Count;
    //                        if (cTR.Value == Convert.ToString(query.ElementAt(i).InvestigationID))
    //                        {
    //                            cTR.Checked = true;
    //                            checkedStatus++;
    //                            if (childCount == checkedStatus)
    //                                tr.Checked = true;
    //                        }
    //                    }
    //                }
    //            }
    //            else
    //            {
    //                var query1 = from inv in lstPatientInvestigation
    //                             where inv.InvestigationID == Convert.ToInt64(tr.Value)
    //                             select inv;

    //                if (query1.Count() > 0)
    //                {
    //                    if (tr.Value == Convert.ToString(query1.ElementAt(0).InvestigationID))
    //                    {
    //                        tr.Checked = true;

    //                    }
    //                }

    //            }
    //        }
    //    }
    //}

    private List<PatientComplaint> GetComplaint()
    {
        string sPosition = string.Empty;
        PatientComplaint pComplaint = new PatientComplaint();
        List<PatientComplaint> pComplaints = new List<PatientComplaint>();
        List<PatientComplaint> pComplaintsWithICD = new List<PatientComplaint>();
        pComplaintsWithICD = ComplaintICDCode1.GetDiagnoseComplaint();

        pComplaint.ComplaintID = complaintID;
      //  pComplaint.Description = txtDiagnosisType.Text;
        pComplaint.ICDCode = pComplaintsWithICD[0].ICDCode;
        pComplaint.ICDDescription = pComplaintsWithICD[0].ICDDescription;
        pComplaint.ComplaintType = "PDI";
        pComplaint.ICDCodeStatus = pComplaintsWithICD[0].ICDCodeStatus;

        if (IsCorporateOrg == "Y" && RoleName != "Physician")
        {
            pComplaint.OnBehalf = Convert.ToInt64(drpPhysician.SelectedValue);
        }
        else
        {
            PhysicianSchedule physician = new PhysicianSchedule();
            new GateWay(base.ContextInfo).GetPhysicianDetails(LID, out physician);
            pComplaint.OnBehalf = physician.PhysicianID;
        }
        

        //Position
        if (cPos.Checked)
        {
            if (cPos.Text == "Bilateral")
                sPosition = "BIL";
            else if (cPos.Text == "Both")
                sPosition = "BOT";

            pComplaint.ComplaintName = "(" + cPos.Text + ")";
        }
        else
        {
            sPosition = lblPos.Text;
            if (lblPos.Text.Equals("LEF"))
                pComplaint.ComplaintName = "(Left)";
            if (lblPos.Text.Equals("RIG"))
                pComplaint.ComplaintName = "(Right)";
            if (lblPos.Text.Equals("UPP"))
                pComplaint.ComplaintName = "(Upper)";
            if (lblPos.Text.Equals("LOW"))
                pComplaint.ComplaintName = "(Lower)";
        }

        pComplaint.Position = sPosition;

        //Provisional Diagnosis
        if (cPD.Checked)
            pComplaint.Query = "Y";
        else
            pComplaint.Query = "N";

        pComplaint.PatientVisitID = visitID;
        pComplaint.CreatedBy = LID;
        pComplaints.Add(pComplaint);
        return pComplaints;
    }

    long returnCode = -1;
    List<PatientInvestigation> pInvestigations = new List<PatientInvestigation>(); List<OrderedInvestigations> pInvestigationsHL = new List<OrderedInvestigations>();
    int tempcomplaintid;

    protected long SaveData()
    {
        //Commented By Ramki       
        //Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out visitID);
        //Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
        //Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);
        long retval = 0;
        int pOrderedInvCnt = 0;

        createdBy = LID;
        int NoOfVitalsEntered = 0;
        List<PatientHistory> pHistories = new List<PatientHistory>();
        List<PatientExamination> pExamination = new List<PatientExamination>();
        List<DrugDetails> pAdvices = new List<DrugDetails>();
        List<PatientComplaint> pComplaint = new List<PatientComplaint>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
        List<BackgroundProblem> lstBgP = new List<BackgroundProblem>();

        Uri_BL uriBL = new Uri_BL(base.ContextInfo);
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);

        try
        {
            pComplaint = GetComplaint();
            tempcomplaintid = pComplaint[0].ComplaintID;
            List<Config> lstConfigDD = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
            if (lstConfigDD.Count > 0)
            {
                InvDrugData = lstConfigDD[0].ConfigValue.Trim();
            }
            if (InvDrugData == "Y")
            {
                //uIAdv.SetPrescription(lstDrugDetails);
                pAdvices = uIAdv.GetPrescription(visitID);
            }
            else
            {
                pAdvices = uAd.GetPrescription(visitID);
            }
            
            lstPatientAdvice = uGAdv.GetGeneralAdvice(visitID);

            if (PatientVitalsControl.GetPageValues(visitID, false, out NoOfVitalsEntered, out lstPatientVitals))
            {
                if (NoOfVitalsEntered <= 0)
                    lstPatientVitals.Clear();

                //sami added bellow lines

                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                PatientVisit_BL oPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
                returnCode = oPatientVisit_BL.GetVisitDetails(visitID, out lstPatientVisit);
                foreach (var opatieentVistDetails in lstPatientVisit)
                {
                    VisitType = opatieentVistDetails.VisitType;
                }
                foreach (Attune.Podium.BusinessEntities.PatientVitals patientVitals in lstPatientVitals)
                {
                    if (VisitType == 0)
                    {
                        patientVitals.VitalsSetID = 0;
                    }
                }
                //sami added  lines ends


                foreach (string desc in hdExam.Value.Split('^'))
                {
                    if (desc.Split('~').Length > 1)
                    {
                        PatientExamination pex = new PatientExamination();
                        pex.ExaminationID = Convert.ToInt32(desc.Split('~')[0]);
                        pex.PatientVisitID = visitID;
                        pex.Description = desc.Split('~')[1];
                        pex.CreatedBy = createdBy;

                        pex.ComplaintId = complaintID;
                        pExamination.Add(pex);
                    }
                }
                if (txtEOthers.Value.Length > 0)
                {
                    PatientExamination pexOth = new PatientExamination();
                    pexOth.ExaminationID = 0;
                    pexOth.PatientVisitID = visitID;
                    pexOth.Description = txtEOthers.Value;
                    pexOth.CreatedBy = createdBy;
                    pexOth.ComplaintId = complaintID;
                    pExamination.Add(pexOth);
                }


                foreach (string desc in hdHist.Value.Split('^'))
                {
                    if (desc.Split('~').Length > 1)
                    {
                        PatientHistory ph = new PatientHistory();
                        ph.HistoryID = Convert.ToInt32(desc.Split('~')[0]);
                        ph.PatientVisitID = visitID;
                        ph.Description = desc.Split('~')[1];
                        ph.CreatedBy = createdBy;
                        ph.ComplaintId = complaintID;
                        pHistories.Add(ph);

                    }
                }
                if (txtEOthers.Value.Length > 0)
                {
                    PatientHistory phOth = new PatientHistory();
                    phOth.HistoryID = 0;
                    phOth.PatientVisitID = visitID;
                    phOth.Description = txtHOthers.Value;
                    phOth.CreatedBy = createdBy;
                    phOth.ComplaintId = complaintID;
                    pHistories.Add(phOth);
                }

                if (chkIsBgP.Checked == true)
                {
                    BackgroundProblem BgP = new BackgroundProblem();
                    BgP.ComplaintID = complaintID;
                    BgP.ComplaintName = lblDiagnosisHeader.Text;
                    BgP.PatientVisitID = visitID;
                    BgP.Status = "Y";
                    BgP.CreatedBy = LID;
                    lstBgP.Add(BgP);
                }

                //List<PatientInvestigation> lstPatientInvest = Profile1.GetSelectedItems();
                List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>(); 
                lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB(); //lstPatientInvest = InvestigationControl1.GetOrderedList(); 
                //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
                List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();
                //if (lstPatientInvest.Count > 0)
                //{
                //    foreach (PatientInvestigation inves in lstPatientInvest)
                //    {
                //        PatientInvestigation objInvest = new PatientInvestigation();
                //        objInvest.InvestigationID = inves.InvestigationID;
                //        objInvest.InvestigationName = inves.InvestigationName;
                //        objInvest.PatientVisitID = visitID;
                //        objInvest.GroupID = inves.GroupID;
                //        objInvest.GroupName = inves.GroupName;
                //        objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                //        objInvest.Status = "Ordered";
                //        objInvest.CreatedBy = createdBy;
                //        objInvest.ComplaintId = complaintID;
                //        objInvest.Type = inves.Type;
                //        orderedInves.Add(objInvest);
                //    }
                //}


                //for (int i = 0; i < tvInvestiation.Nodes.Count; i++)
                //{
                //    int groupID = 0;
                //    string groupName = null;
                //    if (tvInvestiation.Nodes[i].ChildNodes.Count > 0)
                //    {
                //        if (tvInvestiation.Nodes[i].Checked)
                //        {
                //            groupID = Convert.ToInt32(tvInvestiation.Nodes[i].Value);
                //            groupName = tvInvestiation.Nodes[i].Text;
                //        }

                //        foreach (TreeNode tn in tvInvestiation.Nodes[i].ChildNodes)
                //        {
                //            if (tn.Checked)
                //            {
                //                PatientInvestigation pInvestigation = new PatientInvestigation();
                //                pInvestigation.PatientVisitID = visitID;
                //                pInvestigation.GroupName = groupName;
                //                pInvestigation.GroupID = groupID;
                //                pInvestigation.InvestigationName = tn.Text;
                //                pInvestigation.InvestigationID = Convert.ToInt32(tn.Value);
                //                pInvestigation.CreatedBy = createdBy;
                //                pInvestigation.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                //                pInvestigation.Status = "Ordered";
                //                pInvestigation.ComplaintId = complaintID;
                //                pInvestigations.Add(pInvestigation);
                //            }
                //        }
                //    }
                //    else
                //    {
                //        if (tvInvestiation.Nodes[i].Checked)
                //        {
                //            PatientInvestigation pInvestigation = new PatientInvestigation();
                //            pInvestigation.PatientVisitID = visitID;
                //            pInvestigation.GroupName = null;
                //            //pInvestigation.GroupID = ;
                //            pInvestigation.InvestigationID = Convert.ToInt32(tvInvestiation.Nodes[i].Value);
                //            pInvestigation.InvestigationName = tvInvestiation.Nodes[i].Text;
                //            pInvestigation.CreatedBy = createdBy;
                //            pInvestigation.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                //            pInvestigation.Status = "Ordered";
                //            pInvestigation.ComplaintId = complaintID;
                //            pInvestigations.Add(pInvestigation);
                //        }

                //    }
                //}
                //}

                // HL Starts

                #region Sami commented for changing UID
                //if (lstPatientInvestHL.Count > 0)
                //{
                //    foreach (OrderedInvestigations inves in lstPatientInvestHL)
                //    {
                //        OrderedInvestigations objInvest = new OrderedInvestigations();
                //        objInvest.ID = inves.ID;
                //        objInvest.Name = inves.Name;
                //        objInvest.VisitID = visitID;
                //        objInvest.OrgID = OrgID;
                //        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                //        objInvest.Status = "Ordered";
                //        objInvest.CreatedBy = LID;
                //        objInvest.Type = inves.Type;
                //        objInvest.ComplaintId = complaintID;
                //        objInvest.OrgID = OrgID;
                //        orderedInvesHL.Add(objInvest);
                //    }
                //}

                #endregion 

                for (int i = 0; i < tvInvestiation.Nodes.Count; i++)
                {
                    int groupID = 0;
                    string groupName = null;
                    if (tvInvestiation.Nodes[i].ChildNodes.Count > 0)
                    {
                        if (tvInvestiation.Nodes[i].Checked)
                        {
                            groupID = Convert.ToInt32(tvInvestiation.Nodes[i].Value);
                            groupName = tvInvestiation.Nodes[i].Text;
                            OrderedInvestigations pInvestigationHL = new OrderedInvestigations();
                            pInvestigationHL.VisitID = visitID;
                            //pInvestigationHL.Name = groupName;
                            //pInvestigationHL.ID = groupID;
                            pInvestigationHL.Name = groupName;
                            pInvestigationHL.ID = groupID;
                            pInvestigationHL.CreatedBy = createdBy;
                            //pInvestigationHL.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            pInvestigationHL.Status = "Ordered";
                            pInvestigationHL.Type = "GRP";
                            pInvestigationHL.StudyInstanceUId = CreateUniqueDecimalString();
                            pInvestigationHL.ComplaintId = complaintID;
                            pInvestigationHL.OrgID = OrgID;
                            pInvestigationsHL.Add(pInvestigationHL);
                        }
                        if (groupID == 0)
                        {
                            foreach (TreeNode tn in tvInvestiation.Nodes[i].ChildNodes)
                            {
                                if (tn.Checked)
                                {
                                    OrderedInvestigations pInvestigationHL = new OrderedInvestigations();
                                    pInvestigationHL.VisitID = visitID;
                                    //pInvestigationHL.Name = groupName;
                                    //pInvestigationHL.ID = groupID;
                                    pInvestigationHL.Name = tn.Text;
                                    pInvestigationHL.ID = Convert.ToInt32(tn.Value);
                                    pInvestigationHL.CreatedBy = createdBy;
                                    //pInvestigationHL.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                                    pInvestigationHL.Status = "Ordered";
                                    pInvestigationHL.Type = "INV";
                                    pInvestigationHL.StudyInstanceUId = CreateUniqueDecimalString();
                                    pInvestigationHL.ComplaintId = complaintID;
                                    pInvestigationHL.OrgID = OrgID;
                                    pInvestigationsHL.Add(pInvestigationHL);
                                }
                            }
                        }
                    }
                    else
                    {
                        if (tvInvestiation.Nodes[i].Checked)
                        {
                            OrderedInvestigations pInvestigationHL = new OrderedInvestigations();
                            pInvestigationHL.VisitID = visitID;
                            //pInvestigationHL.Name = null;
                            //pInvestigation.GroupID = ;
                            pInvestigationHL.ID = Convert.ToInt32(tvInvestiation.Nodes[i].Value);
                            pInvestigationHL.Name = tvInvestiation.Nodes[i].Text;
                            pInvestigationHL.CreatedBy = createdBy;
                            //pInvestigationHL.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                            pInvestigationHL.Status = "Ordered";
                            pInvestigationHL.Type = "INV";
                            pInvestigationHL.StudyInstanceUId = CreateUniqueDecimalString();
                            pInvestigationHL.ComplaintId = complaintID;
                            pInvestigationHL.OrgID = OrgID;
                            pInvestigationsHL.Add(pInvestigationHL);
                        }

                    }
                }
                gUID = Guid.NewGuid().ToString();
                if (lstPatientInvestHL.Count > 0)
                {
                    foreach (OrderedInvestigations inves in lstPatientInvestHL)
                    {
                        OrderedInvestigations objInvest = new OrderedInvestigations();
                        objInvest.ID = inves.ID;
                        objInvest.Name = inves.Name;
                        objInvest.VisitID = visitID;
                        objInvest.OrgID = OrgID;
                        objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                        objInvest.Status = "Paid";
                        objInvest.CreatedBy = LID;
                        objInvest.Type = inves.Type;
                        objInvest.ComplaintId = complaintID;
                        objInvest.OrgID = OrgID;
                        pInvestigationsHL.Add(objInvest);
                    }
                }

                // HL Ends
                //gUID = Guid.NewGuid().ToString();
                //returnCode = new Investigation_BL(base.ContextInfo).SavePatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);

                #region Sami commented for changing UID
                //  returnCode = new Investigation_BL(base.ContextInfo).SaveOrderedInvestigationHOS(orderedInvesHL, OrgID, out pOrderedInvCnt, "pending", gUID);
                #endregion

                returnCode = 0;
                if (returnCode == 0)
                {
                    PatientVisit entPatientVisit = new PatientVisit();
                    //CultureInfo provider = CultureInfo.InvariantCulture;
                    //string format = "dd/MM/yyyy";

                    //entPatientVisit.NextReviewDate = txtReviewDate.Text;
                    entPatientVisit.NextReviewDate = ddlNos.SelectedValue.ToString() + "-" + ddlDMY.SelectedValue.ToString();

                    if (chkAdmit.Checked == true)
                    {
                        entPatientVisit.AdmissionSuggested = "Y";
                        entPatientVisit.PatientID = patientID;
                        entPatientVisit.PatientVisitId = visitID;
                    }
                    else
                    {
                        entPatientVisit.AdmissionSuggested = "";
                        entPatientVisit.PatientID = patientID;
                        entPatientVisit.PatientVisitId = visitID;
                    }
                    returnCode = uriBL.SaveHIE(pComplaint, pHistories, pExamination, pInvestigationsHL, pAdvices, entPatientVisit, lstPatientAdvice, lstPatientVitals, lstBgP, OrgID, gUID);

                    Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
                    objPatient_BL.UpdatePatientICDStatus(visitID);
                }
                else
                {
                    retval = -1;
                }
            }
        }
        catch (Exception ex)
        {
            retval = -1;
            CLogger.LogError("Error while save patient diagnose page", ex);
        }

        return retval;

    }


    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        btnSubmit.Enabled = false;
        string rmvPres = "Remove";
        //Commented By Ramki
        //Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out visitID);
        //Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
        //Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);
        createdBy = LID;


        // Delete patient diagnose details only for current visit id.
        if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
        {

            if (Convert.ToInt32(Request.QueryString["vid"]) ==
                Convert.ToInt32(Request.QueryString["pvid"]))
            {
                Int32.TryParse(Request.QueryString["id"], out complaintID);
                Int64.TryParse(Request.QueryString["vid"], out visitID);

                returnCode = new Uri_BL(base.ContextInfo).DeletePatientDiagnoseDetail(complaintID, visitID, rmvPres);
            }

        }

        if (SaveData() == 0)
        {
            string sQueryPath = Request.Url.PathAndQuery;
            if (sQueryPath.Contains("RedirectURL"))
            {
                sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL"));
            }
            sQueryPath = sQueryPath.Replace("&", "^~");
            sQueryPath = "&RedirectURL=" + sQueryPath;

            Int32.TryParse(Request.QueryString["id"], out complaintID);


            DropDownList ddllocation = (DropDownList)uIAdv.FindControl("drplocation");
            invLocation = Convert.ToInt32(ddllocation.SelectedItem.Value);
            try
            {
                if (returnCode == 0)
                {
                    if (chkAdditionalPayments.Checked == true)
                    {
                        if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                        {
                            Int64.TryParse(Request.QueryString["vid"], out visitID);
                            Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                            ClearSession();
                            if (chkRefer.Checked == true)
                            {
                                Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&SPP=Y&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&AddPay=Y" + "&gUID=" + gUID, true);
                            }
                            else
                            {
                                // DeleteReferral();
                                Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&SPP=Y&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&gUID=" + gUID + "&AddPay=Y" + "&InvLocID=" + invLocation, true);
                            }
                        }
                        else
                        {
                            ClearSession();
                            if (chkRefer.Checked == true)
                            {
                                Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&SPP=Y&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&gUID=" + gUID, true);
                            }
                            else
                            {
                                // DeleteReferral();
                                Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&SPP=Y&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&gUID=" + gUID + "&AddPay=Y" + "&InvLocID=" + invLocation, true);
                            }
                        }
                    }
                    else
                    {
                        if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                        {
                            Int64.TryParse(Request.QueryString["vid"], out visitID);
                            Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                            ClearSession();
                            if (chkRefer.Checked == true)
                            {
                                Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath + "&gUID=" + gUID, true);
                            }
                            else
                            {
                                //DeleteReferral();
                                Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath + "&gUID=" + gUID, true);
                            }
                        }
                        else
                        {
                            ClearSession();
                            if (chkRefer.Checked == true)
                            {
                                Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath+"&gUID=" + gUID, true);
                            }
                            else
                            {
                                //DeleteReferral();
                                Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath + "&gUID=" + gUID, true);
                            }
                        }
                    }
                }
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while save patient diagnose page", ex);
            }
        }
        else
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in saving the data. Please contact system administrator";
        }
    }


    private string GetDescription(string id, string type)
    {
        string longdesc = string.Empty;
        string detail = string.Empty;
        if (type == "E")
            longdesc = hdExam.Value;
        else
            longdesc = hdHist.Value;
        foreach (string desc in longdesc.Split('^'))
        {
            if (desc.Split('~').Length > 1)
            {
                if (desc.Split('~')[0] == id)
                    detail = desc.Split('~')[1];
            }
        }
        return detail;
    }

    protected void rpd_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.FindControl("lnkdel") != null)
        {
            string s = ((HyperLink)e.Item.FindControl("lnkdel")).NavigateUrl;
            ((HyperLink)e.Item.FindControl("lnkdel")).NavigateUrl = "javascript:DeleteRow(" + s + ");";
            drugIDs = drugIDs + s + ",";
        }

    }
    protected void btnSaveContinue_Click(object sender, EventArgs e)
    {
        string rmvPres = "Remove";
        btnSaveContinue.Enabled = false;
        //Int32.TryParse(Request.QueryString["id"], out tempcomplaintid);
        //Commented By Ramki
        //Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);

        if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
        {
            if (Convert.ToInt32(Request.QueryString["vid"]) ==
                Convert.ToInt32(Request.QueryString["pvid"]))
            {
                Int32.TryParse(Request.QueryString["id"], out complaintID);
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                returnCode = new Uri_BL(base.ContextInfo).DeletePatientDiagnoseDetail(complaintID, visitID, rmvPres);
            }

        }

        if (complaintID != tempcomplaintid)
        {
            if (SaveData() == 0)
            {

                try
                {
                    string sQueryPath = Request.Url.PathAndQuery;
                    if (sQueryPath.Contains("RedirectURL"))
                    {
                        sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL") - 1);
                        sQueryPath = sQueryPath.Substring(0, sQueryPath.LastIndexOf("aspx") + 4);
                    }
                    sQueryPath = sQueryPath.Replace("&", "^~");

                    //vid, pid, tid, pvid, id
                    if (!sQueryPath.Contains("?id=") && !sQueryPath.Contains("^~id="))
                    {
                        sQueryPath = sQueryPath + "?id=" + complaintID;
                    }
                    if (!sQueryPath.Contains("?vid=") && !sQueryPath.Contains("^~vid="))
                    {
                        sQueryPath = sQueryPath + "^~vid=" + visitID;
                    }
                    if (!sQueryPath.Contains("?pid=") && !sQueryPath.Contains("^~pid="))
                    {
                        sQueryPath = sQueryPath + "^~pid=" + patientID;
                    }
                    if (!sQueryPath.Contains("?tid=") && !sQueryPath.Contains("^~tid="))
                    {
                        sQueryPath = sQueryPath + "^~tid=" + taskID;
                    }
                    if (!sQueryPath.Contains("?pvid=") && !sQueryPath.Contains("^~pvid="))
                    {
                        sQueryPath = sQueryPath + "^~pvid=" + visitID;
                    }


                    sQueryPath = "&RedirectURL=" + sQueryPath;


                    ClearSession();
                    Response.Redirect(@"../Physician/Diagnose.aspx?&vid=" + visitID + "&tid=" + taskID + "&pid=" + patientID + "" + sQueryPath, true);
                }
                catch (System.Threading.ThreadAbortException tae)
                {
                    string thread = tae.ToString();
                }
            }
            else
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem in saving the data. Please contact system administrator";
            }
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            ClearSession();
            Response.Redirect("../Physician/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void invAll_Click1(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Investigation/InvestigationProfile.aspx?vid=" + visitID + "&pvid=" + previousVisitID + "&id=" + complaintID);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void Back_Click(object sender, EventArgs e)
    {
        try
        {
            ClearSession();
            Response.Redirect(lblRedirectURL.Text);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    //Created BY Ramki
    private void ClearSession()
    {
        Session["PatientVisitID"] = null;
        Session["PatientID"] = null;
        Session["TaskID"] = null;
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

    private string CreateUniqueDecimalString()
    {
        string uniqueDecimalString = "1.2.840.113619.";
        uniqueDecimalString += GetUniqueKey() + ".";
        uniqueDecimalString += GetUniqueKey();
        return uniqueDecimalString;
    }

    //void SetInvestigationHL(List<InvestigationMaster> lstinvestigationMaster, List<PatientInvestigation> lstPatInvesChild)
    //{

    //    String orderedList = string.Empty;
    //    //Draw List of invstigations and group in treeview control for complaint
    //    if (lstPatInvesChild != null)
    //    {
    //        if (lstPatInvesChild.Count > 0)
    //        {
    //            //List<OrderedInvestigations> pat = new List<OrderedInvestigations>();


    //            //tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(lstPatInves[i].GroupName),Convert.ToString(lstPatInves[i].GroupID)));

    //            var invesQuery = from Inves in lstPatInvesChild
    //                             group Inves by Inves.GroupID into grp
    //                             select grp;


    //            int elementValue = 0;

    //            tvInvestiation.ForeColor = System.Drawing.Color.Black;
    //            foreach (IGrouping<Int32, PatientInvestigation> dr in invesQuery)
    //            {

    //                tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(dr.ElementAt(0).GroupName), Convert.ToString(dr.Key)));


    //                foreach (PatientInvestigation pi in dr)
    //                {
    //                    int count = tvInvestiation.Nodes.Count - 1;
    //                    tvInvestiation.Nodes[count].ChildNodes.Add(new TreeNode(pi.InvestigationName, Convert.ToString(pi.InvestigationID)));

    //                }


    //                elementValue++;
    //            }
    //        }
    //        string val = tvInvestiation.Nodes[0].Value;
    //    }
    //    if (lstinvestigationMaster != null)
    //    {
    //        if (lstinvestigationMaster.Count > 0)
    //        {
    //            List<InvestigationMaster> lstMaster = new List<InvestigationMaster>();
    //            foreach (InvestigationMaster inv in lstinvestigationMaster)
    //            {
    //                tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(inv.InvestigationName), Convert.ToString(inv.InvestigationID)));
    //            }
    //        }
    //    }

    //    if (lstPatientInvestigationHL.Count > 0)
    //    {
    //        //Append investigations that are ordered using more investigation route....

    //        foreach (OrderedInvestigations pv in lstPatientInvestigationHL)
    //        {
    //            bool investigationAvailableInMapping = false;
    //            bool groupAvailableInMapping = false;

    //            foreach (TreeNode tr in tvInvestiation.Nodes)
    //            {
    //                if (tr.ChildNodes.Count > 0)
    //                {
    //                    foreach (TreeNode tChilditem in tr.ChildNodes)
    //                    {
    //                        if (pv.InvestigationID == Convert.ToInt32(tChilditem.Value))
    //                        {
    //                            investigationAvailableInMapping = true;
    //                            groupAvailableInMapping = true;
    //                        }
    //                    }
    //                }
    //                else
    //                {

    //                    if (pv.InvestigationID == Convert.ToInt32(tr.Value))
    //                    {
    //                        investigationAvailableInMapping = true;
    //                    }

    //                    if (pv.GroupID == Convert.ToInt32(tr.Value))
    //                    {
    //                        groupAvailableInMapping = true;
    //                    }

    //                }
    //            }

    //            if (!groupAvailableInMapping && !investigationAvailableInMapping)
    //            {
    //                if (pv.Type == "GRP")
    //                {
    //                    if (!orderedList.Contains(pv.InvestigationName))
    //                    {
    //                        orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~GRP^";
    //                    }
    //                }
    //                else
    //                {
    //                    if (!orderedList.Contains(pv.InvestigationName))
    //                    {
    //                        orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
    //                    }
    //                }

    //                continue;

    //            }

    //            if (!investigationAvailableInMapping && pv.Type == "INV")
    //            {
    //                if (!orderedList.Contains(pv.InvestigationName))
    //                {
    //                    orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
    //                }

    //            }

    //            if (!groupAvailableInMapping)
    //            {
    //                if (pv.Type == "GRP")
    //                {
    //                    if (!orderedList.Contains(pv.InvestigationName))
    //                    {
    //                        orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~GRP^";
    //                    }
    //                }
    //            }
    //        }

    //        InvestigationControl1.setOrderedList(orderedList);


    //        //Select/Mark Investigation that are ordered based on the Complaint Investigation
    //        //mapping.

    //        foreach (TreeNode tr in tvInvestiation.Nodes)
    //        {
    //            var query = from inv in lstPatientInvestigationHL
    //                        where inv.GroupID
    //                        == Convert.ToInt64(tr.Value)
    //                        select inv;

    //            if (query.Count() == 0)
    //            {
    //                foreach (TreeNode cTR in tr.ChildNodes)
    //                {
    //                    var invesQuery = from inv in lstPatientInvestigationHL
    //                                     where inv.InvestigationID == Convert.ToInt64(cTR.Value)
    //                                     select inv;
    //                    if (invesQuery.Count() > 0)
    //                    {
    //                        if (cTR.Value == Convert.ToString(invesQuery.ElementAt(0).InvestigationID))
    //                        {
    //                            cTR.Checked = true;

    //                        }
    //                    }
    //                }
    //            }


    //            if (query.Count() > 0)
    //            {
    //                int checkedStatus = 0;
    //                foreach (TreeNode cTR in tr.ChildNodes)
    //                {
    //                    for (int i = 0; i < query.Count(); i++)
    //                    {
    //                        long str = query.ElementAt(i).InvestigationID;
    //                        int childCount = tr.ChildNodes.Count;
    //                        if (cTR.Value == Convert.ToString(query.ElementAt(i).InvestigationID))
    //                        {
    //                            cTR.Checked = true;
    //                            checkedStatus++;
    //                            if (childCount == checkedStatus)
    //                                tr.Checked = true;
    //                        }
    //                    }
    //                }
    //            }
    //            else
    //            {
    //                var query1 = from inv in lstPatientInvestigationHL
    //                             where inv.InvestigationID == Convert.ToInt64(tr.Value)
    //                             select inv;

    //                if (query1.Count() > 0)
    //                {
    //                    if (tr.Value == Convert.ToString(query1.ElementAt(0).InvestigationID))
    //                    {
    //                        tr.Checked = true;

    //                    }
    //                }

    //            }
    //        }
    //    }
    //}
    void SetInvestigationHL(List<InvestigationMaster> lstinvestigationMaster, List<PatientInvestigation> lstPatInvesChild)
    {
        String orderedList = string.Empty;
        //Draw List of invstigations and group in treeview control for complaint
        if (lstPatInvesChild != null)
        {
            if (lstPatInvesChild.Count > 0)
            {
                //List<OrderedInvestigations> pat = new List<OrderedInvestigations>();


                //tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(lstPatInves[i].GroupName),Convert.ToString(lstPatInves[i].GroupID)));

                var invesQuery = from Inves in lstPatInvesChild
                                 group Inves by Inves.GroupID into grp
                                 select grp;
                              


                int elementValue = 0;

                tvInvestiation.ForeColor = System.Drawing.Color.Black;
                foreach (IGrouping<Int32, PatientInvestigation> dr in invesQuery)
                {

                    tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(dr.ElementAt(0).GroupName), Convert.ToString(dr.Key)));


                    foreach (PatientInvestigation pi in dr)
                    {
                        int count = tvInvestiation.Nodes.Count - 1;
                        tvInvestiation.Nodes[count].ChildNodes.Add(new TreeNode(pi.InvestigationName, Convert.ToString(pi.InvestigationID)));

                    }


                    elementValue++;
                }
            }
            string val = tvInvestiation.Nodes[0].Value;
        }
        if (lstinvestigationMaster != null)
        {
            if (lstinvestigationMaster.Count > 0)
            {
                List<InvestigationMaster> lstMaster = new List<InvestigationMaster>();
                foreach (InvestigationMaster inv in lstinvestigationMaster)
                {
                    tvInvestiation.Nodes.Add(new TreeNode(Convert.ToString(inv.InvestigationName), Convert.ToString(inv.InvestigationID)));
                }
            }
        }

        bool IsAddinMoreinvestigation = false;
        if (lstPatientInvestigationHL.Count > 0)
        {
            var lGroupByList = from lstInvList in lstPatientInvestigationHL
                               where lstInvList.Status == "Ordered" && lstInvList.ComplaintId==complaintID
                               group lstInvList by lstInvList.Type into resultSet
                               select resultSet;

            var lstPaid = from lstInvList in lstPatientInvestigationHL
                          where lstInvList.Status != "Ordered" && lstInvList.Status != "Refered"
                          select lstInvList;

            List<OrderedInvestigations> lstPaidInv=new List<OrderedInvestigations>();



            foreach (var item in lstPaid)
            {
                OrderedInvestigations objPaidInv = new OrderedInvestigations();
                if (item.GroupName != null)
                {
                    objPaidInv.Name = item.GroupName;
                    
                }
                else if (item.InvestigationName != null)
                {
                    objPaidInv.Name = item.InvestigationName;
                }
                lstPaidInv.Add(objPaidInv);

            }
                

            //List<OrderedInvestigations> lstPackagesTemp = lstPaid.ToList<OrderedInvestigations>();



            if (lstPaidInv.Count() > 0)
            {
                PaidInv.Style.Add("display", "block");
                dlInvName.DataSource = lstPaidInv;
                dlInvName.DataBind();

            }



            foreach (IGrouping<string, OrderedInvestigations> O in lGroupByList)
            {
                foreach (OrderedInvestigations pv in O)
                {
                    IsAddinMoreinvestigation = false;
                    foreach (TreeNode tr in tvInvestiation.Nodes)
                    {

                        if (tr.ChildNodes.Count > 0)
                        {
                            foreach (TreeNode trCh in tr.ChildNodes)
                            {
                                if (pv.InvestigationID == Convert.ToInt32(tr.Value))
                                {
                                    tr.Checked = true;
                                    IsAddinMoreinvestigation = true;
                                    foreach (TreeNode trChildSelect in tr.ChildNodes)
                                    {
                                        trChildSelect.Checked = true;
                                    }
                                    break;

                                }
                                else if (pv.InvestigationID == Convert.ToInt32(trCh.Value))
                                {
                                    trCh.Checked = true;
                                    IsAddinMoreinvestigation = true;
                                    break;
                                }
                            }
                        }
                        else if (pv.InvestigationID == Convert.ToInt32(tr.Value))
                        {
                            tr.Checked = true;
                            IsAddinMoreinvestigation = true;
                            break;
                        }
                    }
                    if (IsAddinMoreinvestigation == false)
                    {
                        orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~" + pv.Type + "^";
                    }
                }
            }
            InvestigationControl1.setOrderedList(orderedList);

            //Append investigations that are ordered using more investigation route....

            //foreach (OrderedInvestigations pv in lstPatientInvestigationHL)
            //{
            //    bool investigationAvailableInMapping = false;
            //    bool groupAvailableInMapping = false;

            //    foreach (TreeNode tr in tvInvestiation.Nodes)
            //    {
            //        if (tr.ChildNodes.Count > 0)
            //        {
            //            foreach (TreeNode tChilditem in tr.ChildNodes)
            //            {
            //                if (pv.InvestigationID == Convert.ToInt32(tChilditem.Value))
            //                {
            //                    investigationAvailableInMapping = true;
            //                    groupAvailableInMapping = true;
            //                    break;
            //                }
            //            }
            //        }
            //        else
            //        {

            //            if (pv.InvestigationID == Convert.ToInt32(tr.Value))
            //            {
            //                investigationAvailableInMapping = true;
            //            }

            //            if (pv.GroupID == Convert.ToInt32(tr.Value))
            //            {
            //                groupAvailableInMapping = true;
            //            }

            //        }
            //    }

            //    if (!groupAvailableInMapping && !investigationAvailableInMapping)
            //    {
            //        if (pv.Type == "GRP")
            //        {
            //            if (!orderedList.Contains(pv.InvestigationName))
            //            {
            //                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~GRP^";
            //            }
            //        }
            //        else
            //        {
            //            if (!orderedList.Contains(pv.InvestigationName))
            //            {
            //                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
            //            }
            //        }

            //        continue;

            //    }

            //    if (!investigationAvailableInMapping && pv.Type == "INV")
            //    {
            //        if (!orderedList.Contains(pv.InvestigationName))
            //        {
            //            orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
            //        }

            //    }

            //    if (!groupAvailableInMapping)
            //    {
            //        if (pv.Type == "GRP")
            //        {
            //            if (!orderedList.Contains(pv.InvestigationName))
            //            {
            //                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~GRP^";
            //            }
            //        }
            //    }
            //}

            //InvestigationControl1.setOrderedList(orderedList);


            ////Select/Mark Investigation that are ordered based on the Complaint Investigation
            ////mapping.

            //foreach (TreeNode tr in tvInvestiation.Nodes)
            //{
            //    var query = from inv in lstPatientInvestigationHL
            //                where inv.GroupID
            //                == Convert.ToInt64(tr.Value)
            //                select inv;

            //    if (query.Count() == 0)
            //    {
            //        foreach (TreeNode cTR in tr.ChildNodes)
            //        {
            //            var invesQuery = from inv in lstPatientInvestigationHL
            //                             where inv.InvestigationID == Convert.ToInt64(cTR.Value)
            //                             select inv;
            //            if (invesQuery.Count() > 0)
            //            {
            //                if (cTR.Value == Convert.ToString(invesQuery.ElementAt(0).InvestigationID))
            //                {
            //                    cTR.Checked = true;

            //                }
            //            }
            //        }
            //    }


            //    if (query.Count() > 0)
            //    {
            //        int checkedStatus = 0;
            //        foreach (TreeNode cTR in tr.ChildNodes)
            //        {
            //            for (int i = 0; i < query.Count(); i++)
            //            {
            //                long str = query.ElementAt(i).InvestigationID;
            //                int childCount = tr.ChildNodes.Count;
            //                if (cTR.Value == Convert.ToString(query.ElementAt(i).InvestigationID))
            //                {
            //                    cTR.Checked = true;
            //                    checkedStatus++;
            //                    if (childCount == checkedStatus)
            //                        tr.Checked = true;
            //                }
            //            }
            //        }
            //    }
            //    else
            //    {
            //        var query1 = from inv in lstPatientInvestigationHL
            //                     where inv.InvestigationID == Convert.ToInt64(tr.Value)
            //                     select inv;

            //        if (query1.Count() > 0)
            //        {
            //            if (tr.Value == Convert.ToString(query1.ElementAt(0).InvestigationID))
            //            {
            //                tr.Checked = true;

            //            }
            //        }

            //    }
            //}
        }
    }
    public void Loadphysician()
    {
        try
        {
            List<Physician> lstroom = new List<Physician>();
            new Physician_BL(base.ContextInfo).GetPhysicianList(OrgID, out lstroom);
            drpPhysician.DataSource = lstroom;
            drpPhysician.DataTextField = "PhysicianName";
            drpPhysician.DataValueField = "PhysicianID";
            drpPhysician.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Physician Load", ex);
        }
    }
    private void DeleteReferral()
    {
        int pCount = -1; long refID = -1;
        new Referrals_BL(base.ContextInfo).CheckReferralsAvailable(visitID, Convert.ToInt32(TaskHelper.VisitPurpose.Consultation), out pCount, out refID);
        if (pCount > 0)
        {
            List<Referral> lstReferrals = new List<Referral>();
            returnCode = new Referrals_BL(base.ContextInfo).UpdateReferrals(lstReferrals, LID, refID, "DELETE");
        }
    }
}
