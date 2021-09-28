using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Security.Cryptography;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Text;
using System.Web.Script.Serialization;
public partial class Physician_QuickDiagnosis : BasePage
{
    public int complaintID = 0;
    long visitID = 0;
    long patientID = 0;
    long taskID = 0;
    string NextReview = string.Empty;
    string NextReviewNos = string.Empty;
    string NextReviewDMY = string.Empty;
    string[] nReview;
    string PaymentLogic = String.Empty;
    String orderedList = string.Empty;
    long previousVisitID = 0;
    string InvDrugData = string.Empty;
    string gUID = string.Empty;
    int invLocation = 0;

    public Physician_QuickDiagnosis()
        : base("Physician\\QuickDiagnosis.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
   
    protected void Page_Load(object sender, EventArgs e)
    {
       
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        hdnVisitID.Value = visitID.ToString();
        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        List<DHEBAdder> lstdhebDiagnosis = new List<DHEBAdder>();
        //gUID = Guid.NewGuid().ToString(); //Comment By Syed[Not Need to Generate mone than one GUID in Same Page-Already in SaveData()]
        uIAdv.Pvid = visitID.ToString();
        if (!IsPostBack)
        {
            if (RoleName == "Transcriptionist")
            {
                tbAssPhy.Attributes.Add("Style", "display:block");
                Loadphysician();
            }
            SetOrderedProc();
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
        }

        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int32.TryParse(Request.QueryString["id"], out complaintID);

            //new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(previousVisitID, out lstPatientComplaint, out lstPatientInvestigation, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
            new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(previousVisitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
        }
        else
        {
            //new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(visitID, out lstPatientComplaint, out lstPatientInvestigation, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
            new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(visitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
        }

        if (!IsPostBack)
        {
            uctPatientVitalsControl.FindControl("txtTemp").Focus();
            uctPatientVitalsControl.VisitID = visitID;
            uctPatientVitalsControl.LoadControls("U", patientID);
            LoadMeatData();
            if (lstDrugDetails.Count > 0)
            {
                if (InvDrugData == "Y")
                {
                    uIAdv.SetPrescription(lstDrugDetails);
                }
                else
                {
                    uAd.SetPrescription(lstDrugDetails);
                }
            }
            if (lstPatientAdvice.Count > 0)
                uGAdv.setGeneralAdvice(lstPatientAdvice);

            //Convert PatientComplaint to DHEBAdder list
            if (lstPatientComplaint.Count > 0)
            {
                if (lstPatientComplaint[0].ComplaintName != "N/A")
                {
                    //ConvertToDHEB(lstPatientComplaint, out lstdhebDiagnosis);
                    //dhebDiagnosis.SetControl(lstdhebDiagnosis);
                    ComplaintICDCode1.ComplaintHeader = "Diagnosis";
                    ComplaintICDCode1.SetPatientComplaint(lstPatientComplaint);
                }
            }

            #region OrderedInvestigation
            if (lstPatientInvestigationHL.Count > 0)
            {
                foreach (OrderedInvestigations pv in lstPatientInvestigationHL)//.FindAll(p => p.Status != "SampleReceived"))
                {
                    bool investigationAvailableInMapping = false;
                    bool groupAvailableInMapping = false;


                    if (!groupAvailableInMapping && !investigationAvailableInMapping)
                    {

                        if (pv.Type == "GRP")
                        {
                            if (!orderedList.Contains(pv.InvestigationName))
                            {
                                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~GRP" +  "^"; 
                            }
                        }
                        else
                        {
                            if (!orderedList.Contains(pv.InvestigationName))
                            {
                                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV"  + "^"; 
                            }
                        }

                        continue;

                    }

                    if (!investigationAvailableInMapping && pv.Type == "INV")
                    {
                        if (!orderedList.Contains(pv.InvestigationName))
                        {
                            orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV"+"^";
                        }

                    }

                    if (!groupAvailableInMapping)
                    {
                        if (pv.Type == "GRP")
                        {
                            if (!orderedList.Contains(pv.InvestigationName))
                            {
                                orderedList += pv.InvestigationID + "," + pv.InvestigationName + "~GRP"+"^";
                            }
                        }
                    }
                }

                InvestigationControl1.setOrderedList(orderedList);

            }
            #endregion

            //Load More Investigations if selected


            #region PatientInvestigation

            //if (lstPatientInvestigation.Count > 0)
            //{
            //    foreach (PatientInvestigation pv in lstPatientInvestigation)
            //    {
            //        bool investigationAvailableInMapping = false;
            //        bool groupAvailableInMapping = false;


            //        if (!groupAvailableInMapping && !investigationAvailableInMapping)
            //        {
            //            if (pv.GroupID > 0)
            //            {
            //                if (!orderedList.Contains(pv.GroupName))
            //                {
            //                    orderedList += pv.GroupID + "~" + pv.GroupName + "~GRP^";
            //                }
            //            }
            //            else
            //            {
            //                if (!orderedList.Contains(pv.InvestigationName))
            //                {
            //                    orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
            //                }
            //            }

            //            continue;

            //        }

            //        if (!investigationAvailableInMapping && pv.GroupID < 1)
            //        {
            //            if (!orderedList.Contains(pv.InvestigationName))
            //            {
            //                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
            //            }

            //        }

            //        if (!groupAvailableInMapping)
            //        {
            //            if (pv.GroupID > 0)
            //            {
            //                if (!orderedList.Contains(pv.GroupName))
            //                {
            //                    orderedList += pv.GroupID + "," + pv.GroupName + "~GRP^";
            //                }
            //            }
            //        }
            //    }

            //    InvestigationControl1.setOrderedList(orderedList);

            //}
            #endregion

            if (lstPatientVisit.Count > 0)
            {
                if ((lstPatientVisit[0].NextReviewDate != null) && (lstPatientVisit[0].NextReviewDate != ""))
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
                }
                if (lstPatientVisit[0].AdmissionSuggested == "Y")
                {
                    chkAdmit.Checked = true;
                }
            }
        }

        if (!Page.IsPostBack)
        {
            try
            {
                PatientHeader1.PatientVisitID = visitID;

                //Load Data's to investigation Control
                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                //--Change
                int ClientID = 0;
                List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
                new PatientVisit_BL(base.ContextInfo).GetVisitClientMappingDetails(OrgID, visitID, out lstVisitClientMapping);
               
                if (lstVisitClientMapping.Count > 0)
                {
                    ClientID = (int)lstVisitClientMapping[0].RateID;
                }
                new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.NotSpecific), complaintID, ClientID, out lstgroups, out lstInvestigations);
                InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);


                //dhebDiagnosis.SetControl(

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
                    pnlMiscellaneous.Visible = true;
                }
                else
                {
                    chkAdditionalPayments.Visible = true;
                    pnlMiscellaneous.Visible = true;
                }

            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading UnfoundDiagnosis", ex);
            }
        }   
    }

    private long SaveData()
    {
        long retval = -1;
        int NoOfVitalsEntered = 0;
        int pOrderedInvCnt = 0;

        List<DrugDetails> lstdrugs = new List<DrugDetails>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();

        Uri_BL uriBL = new Uri_BL(base.ContextInfo);
        
        //Get entered complaints from the control
        List<PatientComplaint> lstdhebDiagnosis = new List<PatientComplaint>();

        //Get entered Examinations from the control
        List<PatientExamination> lstdhebExamination = new List<PatientExamination>();

        //Get entered History from the control
        List<PatientHistory> lstdhebHistory = new List<PatientHistory>();

        List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>();
        //List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>();
        string nextReviewDate = ddlNos.SelectedItem.Text + "-" + ddlDMY.SelectedItem.Text;

        List<Config> lstConfigDD = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
        if (lstConfigDD.Count > 0)
        {
            InvDrugData = lstConfigDD[0].ConfigValue.Trim();
        }

        try
        {
            if (uctPatientVitalsControl.GetPageValues(visitID, false, out NoOfVitalsEntered, out lstPatientVitals))
            {
                if (NoOfVitalsEntered <= 0)
                    lstPatientVitals.Clear();

             //   List<DHEBAdder> lst = dhebDiagnosis.GetValues(visitID);
                List<DHEBAdder> lst;
                ComplaintICDCode1.DefaultComplaintID = "NO";
                ComplaintICDCode1.ComplaintID = 0;
                Utilities objut = new Utilities();
                string sDefSelect = objut.GetDefaultEntryForDropDownControl("Defaults", "Select");
                if ((drpPhysician.SelectedValue) == sDefSelect || drpPhysician.SelectedValue=="")
                {
                    lstdhebDiagnosis = ComplaintICDCode1.GetPatientComplaint("QIC", visitID);
                }
                else
                {
                    lstdhebDiagnosis = ComplaintICDCode1.GetPatientComplaint("QIC", visitID,Convert.ToInt32(drpPhysician.SelectedValue));
                }
                if (lstdhebDiagnosis.Count > 0)
                {
                    lblError.Visible = false;
                  //  GetComplaints(lst, out lstdhebDiagnosis);
                    
                    //lst = new List<DHEBAdder>();
                    //lst = DHEBHistory.GetValues(visitID);
                    //GetHistories(lst, out lstdhebHistory);

                    //lst = new List<DHEBAdder>();
                    //lst = dhebAddExam.GetValues(visitID);
                    //GetExaminations(lst, out lstdhebExamination);

                    if (InvDrugData == "Y")
                    {
                        lstdrugs = uIAdv.GetPrescription(visitID);
                    }
                    else
                    {
                        lstdrugs = uAd.GetPrescription(visitID);
                    }

                    lstPatientAdvice = uGAdv.GetGeneralAdvice(visitID);

                    #region OrderedInvestigation
                    lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB(); //lstPatientInvest = InvestigationControl1.GetOrderedList(); 
                    List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>(); 

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
                            objInvest.Status = "Ordered";
                            objInvest.CreatedBy = LID;
                            objInvest.Type = inves.Type;
                            objInvest.StudyInstanceUId = CreateUniqueDecimalString();
                            objInvest.OrgID = OrgID;
                            orderedInvesHL.Add(objInvest);
                        }
                    }
                    #endregion

                    #region PatientInvestigation
                    //lstPatientInvest = InvestigationControl1.GetOrderedList();
                    //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();

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
                    //        objInvest.CreatedBy = LID;
                    //        objInvest.ComplaintId = -1;
                    //        objInvest.Type = inves.Type;
                    //        orderedInves.Add(objInvest);
                    //    }
                    //}
                    #endregion

                    //Save the data
                    string admitSuggest = string.Empty;
                    string physicihancomments = string.Empty;
                    if (chkAdmit.Checked == true)
                    {
                        admitSuggest = "Y";
                    }
                    gUID = Guid.NewGuid().ToString();
                    retval = uriBL.SaveUnFoundDiagnosisData(0, admitSuggest, patientID, nextReviewDate, visitID, lstdhebDiagnosis,
                                    lstdhebHistory, lstdhebExamination,
                                    orderedInvesHL, lstdrugs, lstPatientAdvice, lstPatientVitals, OrgID, out pOrderedInvCnt, "pending", gUID,physicihancomments);

                    if (lstdhebDiagnosis.Count > 0)
                    {
                        Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
                        objPatient_BL.UpdatePatientICDStatus(visitID);
                    }
                    //retval = uriBL.SaveUnFoundDiagnosisData(-1, admitSuggest, patientID, nextReviewDate, visitID, lstdhebDiagnosis,
                    //                lstdhebHistory, lstdhebExamination,
                    //                orderedInves, lstdrugs, lstPatientAdvice, lstPatientVitals, OrgID, out pOrderedInvCnt);

                    retval = 0;
                }
                else
                {
                    retval = -1;
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Pl. enter a diagnosis";// (or) Prescription";
                    lblError.Visible = true;
                    lblError.Focus();
                    lblError.Text = "Pl. enter a diagnosis";// (or) Prescription";
                }
            }
            #region OrderPhysiotherapy
            long returnCodePhysio = -1;
            List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
            JavaScriptSerializer JSserializer = new JavaScriptSerializer();
            if (hdnAddItems.Value != "")
            {
                lstOrderedPhysiotherapy = JSserializer.Deserialize<List<OrderedPhysiotherapy>>(hdnAddItems.Value);
            }
            long patientVisitID = 0;
            int PhysioCount = 0;
            patientVisitID = Convert.ToInt32(hdnVisitID.Value);
            string orderBy = "ORDPHY";
            returnCodePhysio = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(patientVisitID, ILocationID, OrgID, LID, orderBy, lstOrderedPhysiotherapy, out PhysioCount);
            hdnAddItems.Value = "";

            #endregion
        }
        catch (Exception ex)
        {
            retval = -1;
            CLogger.LogError("Error while saving unfound diagnosis", ex);
        }

        return retval;
    }

    private void ConvertToDHEB(List<PatientComplaint> lstPatientComplaint, out List<DHEBAdder> lstdhebDiagnosis)
    {
        bool isQuery = true;
        lstdhebDiagnosis = new List<DHEBAdder>();

        foreach (PatientComplaint pc in lstPatientComplaint)
        {
            DHEBAdder da = new DHEBAdder();
            da.Description = pc.ComplaintName;
            da.Comments = pc.Description;
            //if (pc.Query.Equals('Y') && isQuery == true)
            //{
            //    cPD.Checked = true;
            //    isQuery = false;
            //}
            lstdhebDiagnosis.Add(da);
        }
    }

    private void GetComplaints(List<DHEBAdder> lstDHEBAdder, out List<PatientComplaint> lst)
    {
        lst = new List<PatientComplaint>();
        PatientComplaint pComplaint;

        foreach (DHEBAdder d in lstDHEBAdder)
        {
            pComplaint = new PatientComplaint();
            pComplaint.ComplaintID = 0;
            pComplaint.ComplaintName = d.Description;
            pComplaint.Description = d.Comments;
            //if (cPD.Checked)
            //    pComplaint.Query = "Y";
            //else
            //    pComplaint.Query = "N";
            pComplaint.PatientVisitID = visitID;
            pComplaint.CreatedBy = LID;

            if (d.Description.Trim() != "")
                lst.Add(pComplaint);
        }
        if (lst.Count == 0)
        {
            pComplaint = new PatientComplaint();
            pComplaint.ComplaintID = 0;
            pComplaint.ComplaintName = "N/A";
            pComplaint.Description = "N/A";
            pComplaint.PatientVisitID = visitID;
            pComplaint.CreatedBy = LID;
            lst.Add(pComplaint);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
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

                if (chkAdditionalPayments.Checked == true)
                {
                    if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["vid"], out visitID);
                        Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                        ClearSession();
                        Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + "&AddPay=Y" + "&gUID=" + gUID+"&InvLocID="+invLocation, true);
                    }
                    else
                    {
                        ClearSession();
                        Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + "&AddPay=Y" + "&gUID=" + gUID+ "&InvLocID=" + invLocation, true);
                    }
                }
                else
                {
                    //COMMENTtED by venkat
                    //if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                    //{
                    //    Int64.TryParse(Request.QueryString["vid"], out visitID);
                    //    Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                    //    ClearSession();
                    //    Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath, true);
                    //}
                    //else
                    //{
                    //    ClearSession();
                    //    Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N" + sQueryPath, true);
                    //}
                    if (chkRefer.Checked == true)
                    {
                        Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&SPP=Y&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath + "&gUID=" + gUID, true);
                    }
                    else
                    {
                        // DeleteReferral();
                        Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON&SPP=Y" + "&oC=Y" + "&gUID=" + gUID + "&InvLocID=" + invLocation, true);
                    }
                }

                //if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                //{
                //    Int64.TryParse(Request.QueryString["vid"], out visitID);
                //    Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                //    ClearSession();
                //    Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N", true);
                //}
                //else
                //{
                //    ClearSession();
                //    Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=N", true);
                //}
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error in Quick Diagnosis", ex);
            }
        }
    }
    protected void Back_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Physician/Home.aspx", true);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Physician/Home.aspx", true);
    }

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
    public void Loadphysician()
    {
        try
        {
            Utilities objut = new Utilities();
            string sDefSelect = objut.GetDefaultEntryForDropDownControl("Defaults", "Select");
            List<Physician> lstroom = new List<Physician>();
            new Physician_BL(base.ContextInfo).GetPhysicianList(OrgID, out lstroom);
            drpPhysician.DataSource = lstroom;
            drpPhysician.DataTextField = "PhysicianName";
            drpPhysician.DataValueField = "PhysicianID";
            drpPhysician.DataBind();
            drpPhysician.Items.Insert(0, sDefSelect);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Physician Load", ex);
        }
    }

    public void SetOrderedProc()
    {
        long proTaskStatusID = -1;
        long returnCode = -1;
        List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        returnCode = patientBL.GetOrderedPhysio(patientID, visitID, LID, out lstOrderedPhysiotherapy, out proTaskStatusID);
        hdnSetOrderedProc.Value = JSserializer.Serialize(lstOrderedPhysiotherapy);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "SetorderedProcedure();", true);
    }

    public void LoadMeatData()
    {

        long returncode = -1;
        string domains = "DateAttributes";
        string[] Tempdata = domains.Split(',');
        string LangCode = LanguageCode;
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
                             where child.Domain == "DateAttributes"
                             select child;

            ddlDMY.DataSource = childItems.OrderByDescending(p => p.DisplayText);
            ddlDMY.DataTextField = "DisplayText";
            ddlDMY.DataValueField = "DisplayText";
            ddlDMY.DataBind();

        }
    }
}
