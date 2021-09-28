using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.SmartAccessor;


public partial class Physician_unfoundDiagnosisnew :BasePage 
{

    public int complaintID = 0;
    long visitID = 0;
    long previousVisitID = 0;
    long patientID = 0;
    long createdBy = 0;
    long taskID = 0;
    string PaymentLogic = String.Empty;
    String orderedList = string.Empty;
    string InvDrugData = string.Empty;
    string NextReview = string.Empty;
    string NextReviewNos = string.Empty;
    string NextReviewDMY = string.Empty;
    string phycomments = string.Empty;
    string[] nReview;
    string gUID = string.Empty;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
       //this.PreRender += new EventHandler(unfoundDiagnosisnew_PreRender);
        GetFCKPath();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
         List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
        List<PatientExamination> lstPatientExamination = new List<PatientExamination>();
        List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); 
        List<PatientHistory> lstPatientHistory = new List<PatientHistory>();
        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<PatientDiagnosticsAttribute> lstDiagonistics = new List<PatientDiagnosticsAttribute>();
        List<DHEBAdder> lstdhebDiagnosis = new List<DHEBAdder>();
        List<DHEBAdder> lstdhebHistory = new List<DHEBAdder>();
        List<DHEBAdder> lstdhebExamination = new List<DHEBAdder>();
        List<PatientDiagnosticsAttribute> lstPDA = new List<PatientDiagnosticsAttribute>();


        if (Request.QueryString["pvid"] != null)
        {
            Int64.TryParse(Request.QueryString["pvid"], out visitID);
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out visitID);
        }
        Int64.TryParse(Request.QueryString["pid"], out patientID);
        Int64.TryParse(Request.QueryString["tid"], out taskID);
        gUID = Guid.NewGuid().ToString();
        if (!IsPostBack)
        {
           




            //********** Form the Advice Control ************************/
            List<Config> lstConfigDD = new List<Config>();
            ComplaintICDCode1.ComplaintHeader = "Diagnosis";
            ComplaintICDCode1.SetWidth(500);
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
            if (patientID != 0)
            {
                uctPatientVitalsControl.FindControl("txtTemp").Focus();
                uctPatientVitalsControl.VisitID = visitID;
                uctPatientVitalsControl.LoadControls("U", patientID);
            }
        }

        if (Request.QueryString["pvid"] != null)
        {
            //Commented By Ramki
            //Session.Add("PatientVisitID", Request.QueryString["vid"]);
            //Session.Add("TaskID", Request.QueryString["tid"]);

            Int64.TryParse(Request.QueryString["tid"], out taskID);
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int32.TryParse(Request.QueryString["id"], out complaintID);

            new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(previousVisitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
        }
        else
        {
            // PatientVisit_BL pbl = new  
            new PatientVisit_BL(base.ContextInfo).GetPatientVisitDetailsByvisitID(visitID, out lstPatientComplaint, out lstPatientInvestigationHL, out lstPatientHistory, out lstPatientExamination, out lstDrugDetails, out lstPatientAdvice, out lstPatientVisit);
        }
               
        
        if (!IsPostBack)
        {
            //**********Form the redirect query for back button************************/
            string sRedirectURL = Convert.ToString(Request.QueryString["RedirectURL"]);
          //  string sQueryPath = Request.Url.PathAndQuery;
          
            //if (sRedirectURL == null || sRedirectURL == "")
            //{
            //    sRedirectURL = Request.UrlReferrer.PathAndQuery;
            //    if (!sRedirectURL.Contains(".aspx"))
            //        sRedirectURL = "diabetesEMR.aspx?vid=" + visitID + "&tid=" + taskID + "&pid=" + patientID;

            //    if (sRedirectURL.Contains("RedirectURL"))
            //    {
            //        sRedirectURL = sRedirectURL.Substring(0, sRedirectURL.IndexOf("RedirectURL") - 1);
            //    }

            //}

            //if (sQueryPath.Contains("RedirectURL"))
            //{
            //    sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL") - 1);
            //}

            //sRedirectURL = sRedirectURL.Replace("^~", "&");
            //sQueryPath = sQueryPath.Replace("&", "^~");

            //if (sRedirectURL.Contains("?"))
            //    sRedirectURL = sRedirectURL + "&RedirectURL=" + sQueryPath;
            //else
            //    sRedirectURL = sRedirectURL + "?RedirectURL=" + sQueryPath;

            //lblRedirectURL.Text = sRedirectURL;
            //***************************************************************************/
            Int64.TryParse(Request.QueryString["vid"], out visitID);
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            //uctPatientVitalsControl.FindControl("txtTemp").Focus();
            //uctPatientVitalsControl.VisitID = visitID;
            //uctPatientVitalsControl.LoadControls("U", patientID);

            if (patientID != 0)
            {
                uctPatientVitalsControl.FindControl("txtTemp").Focus();
                uctPatientVitalsControl.VisitID = visitID;
                uctPatientVitalsControl.LoadControls("U", patientID);
            }

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

            if(lstPatientAdvice.Count>0)
                uGAdv.setGeneralAdvice(lstPatientAdvice);
        
            //Convert PatientComplaint to DHEBAdder list
            if (lstPatientComplaint.Count > 0)
            {

                ComplaintICDCode1.ComplaintHeader = "Diagnosis";
                ComplaintICDCode1.SetPatientComplaint(lstPatientComplaint);
               // lstPatientComplaint[0].PhysicianComments = fckPhysicianComments.Value;
                //ConvertToDHEB(lstPatientComplaint, out lstdhebDiagnosis);
                //dhebDiagnosis.SetControl(lstdhebDiagnosis);
            }

            //Convert PatientHistory to DHEBAdder list
            if (lstPatientHistory.Count > 0)
            {
                ConvertToDHEB(lstPatientHistory, out lstdhebHistory);
                DHEBHistory.SetControl(lstdhebHistory);
            }

            //Convert PatientExamination to DHEBAdder list
            if (lstPatientExamination.Count > 0)
            {
                ConvertToDHEB(lstPatientExamination, out lstdhebExamination);
                dhebAddExam.SetControl(lstdhebExamination);
            }

          

          
            if (lstPatientInvestigationHL.Count > 0)
            {
                foreach (OrderedInvestigations pv in lstPatientInvestigationHL)
                {
                    bool investigationAvailableInMapping = false;
                    bool groupAvailableInMapping = false;


                    if (!groupAvailableInMapping && !investigationAvailableInMapping)
                    {
                       
                        if (pv.Type == "GRP")
                        {
                            if (!orderedList.Contains(pv.InvestigationName))
                            {
                                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~GRP^";
                            }
                        }
                        else
                        {
                            if (!orderedList.Contains(pv.InvestigationName))
                            {
                                orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
                            }
                        }

                        continue;

                    }

                   
                    if (!investigationAvailableInMapping && pv.Type == "INV")
                    {
                        if (!orderedList.Contains(pv.InvestigationName))
                        {
                            orderedList += pv.InvestigationID + "~" + pv.InvestigationName + "~INV^";
                        }

                    }

                
                    if (!groupAvailableInMapping)
                    {
                        if (pv.Type == "GRP")
                        {
                            if (!orderedList.Contains(pv.InvestigationName))
                            {
                                orderedList += pv.InvestigationID + "," + pv.InvestigationName + "~GRP^";
                            }
                        }
                    }
                }

                InvestigationControl1.setOrderedList(orderedList);

            }

            if (lstPatientVisit.Count > 0)
            {
                if ((lstPatientVisit[0].NextReviewDate != null)&&(lstPatientVisit[0].NextReviewDate !=""))
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
            ddlNos.SelectedIndex = 0;
            ddlDMY.SelectedIndex = 0;
        }
        //
       
    
        if (!Page.IsPostBack)
        {
            try
            {
              
                PatientHeader1.PatientVisitID = visitID;

                //Load Data's to investigation Control
                List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
                List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
                int ClientId = 0;
                List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();

                new PatientVisit_BL(base.ContextInfo).GetVisitClientMappingDetails(OrgID, visitID, out lstVisitClientMapping);
                if (lstVisitClientMapping.Count > 0)
                {
                    ClientId = (int)lstVisitClientMapping[0].RateID;
                }

                new Investigation_BL(base.ContextInfo).GetInvestigationDatabyComplaint(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.NotSpecific), complaintID, ClientId, out lstgroups, out lstInvestigations);
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

    void unfoundDiagnosisnew_PreRender(object sender, EventArgs e)
    {
        Response.Expires = 0;
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

    private void ConvertToDHEB(List<PatientHistory> lstPatientHistory, out List<DHEBAdder> lstdhebHistory)
    {
        lstdhebHistory = new List<DHEBAdder>();

        foreach (PatientHistory pc in lstPatientHistory)
        {
            DHEBAdder da = new DHEBAdder();
            da.Description = pc.HistoryName;
            da.Comments = pc.Description;
            lstdhebHistory.Add(da);
        }
    }

    private void ConvertToDHEB(List<PatientExamination> lstPatientExamination, out List<DHEBAdder> lstdhebExamination)
    {
        lstdhebExamination = new List<DHEBAdder>();

        foreach (PatientExamination pc in lstPatientExamination)
        {
            DHEBAdder da = new DHEBAdder();
            da.Description = pc.ExaminationName;
            da.Comments = pc.Description;
            lstdhebExamination.Add(da);
        }
    }

    private long SaveData()
    {
        long retval = -1;
        int NoOfVitalsEntered = 0;
        int pOrderedInvCnt = 0;
        string physiciancomments = string.Empty;
    
        //Commented By Ramki
        //Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out visitID);
        //Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
        //Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);
        //Int64.TryParse(Convert.ToString(Session["LID"]), out createdBy);
        createdBy = LID;
      
        List<DrugDetails> lstdrugs = new List<DrugDetails>();
        List<PatientAdvice> lstPatientAdvice = new List<PatientAdvice>();
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
      
        Uri_BL uriBL = new Uri_BL(base.ContextInfo);

        //Get entered complaints from the control
        List<PatientComplaint> lstdhebDiagnosis = new List<PatientComplaint>();
        List<PatientComplaint> lstPatientComplaint = new List<PatientComplaint>();
        //Get entered Examinations from the control
        List<PatientExamination> lstdhebExamination = new List<PatientExamination>();

        //Get entered History from the control
        List<PatientHistory> lstdhebHistory = new List<PatientHistory>();

        List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>(); 

        List<Config> lstConfigDD = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails("UseInvDrugData", OrgID, out lstConfigDD);
        if (lstConfigDD.Count > 0)
        {
            InvDrugData = lstConfigDD[0].ConfigValue.Trim();
        }
        string nextReviewDate = string.Empty;
        if ((ddlNos.SelectedIndex != 0) && (ddlDMY.SelectedIndex != 0))
        {
             nextReviewDate = ddlNos.SelectedItem.Text + "-" + ddlDMY.SelectedItem.Text;
        }
        try
        {
            if (uctPatientVitalsControl.GetPageValues(visitID, false, out NoOfVitalsEntered,out lstPatientVitals))
            {
                if (NoOfVitalsEntered <= 0)
                    lstPatientVitals.Clear();

              // List<DHEBAdder> lst = dhebDiagnosis.GetValues(visitID);
                List<DHEBAdder> lst;
               ComplaintICDCode1.DefaultComplaintID = "NO";
               ComplaintICDCode1.ComplaintID = 0;
               lstdhebDiagnosis = ComplaintICDCode1.GetPatientComplaint("UNF", visitID);
                if (lstdhebDiagnosis.Count > 0)
                {
                    lblError.Visible = false;
                   // GetComplaints(lst, out lstdhebDiagnosis);
                
                  
                    
                    
                    lst = new List<DHEBAdder>();
                    lst = DHEBHistory.GetValues(visitID);
                    GetHistories(lst, out lstdhebHistory);

                    lst = new List<DHEBAdder>();
                    lst = dhebAddExam.GetValues(visitID);
                    GetExaminations(lst, out lstdhebExamination);

                    if (InvDrugData == "Y")
                    {
                        lstdrugs = uIAdv.GetPrescription(visitID);
                    }
                    else
                    {
                        lstdrugs = uAd.GetPrescription(visitID);
                    }

                    lstPatientAdvice = uGAdv.GetGeneralAdvice(visitID);

                  //  lstphycomments[0].PhysicianComments = fckPhysicianComments.Value;

                    physiciancomments = fckPhysicianComments.Value;
                    //lstphysiciamComplaints[0].PhysicianComments = phycomments;
                    lstPatientInvestHL = InvestigationControl1.GetINVListHOSLAB(); //lstPatientInvest = InvestigationControl1.GetOrderedList(); 
                    List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>(); //List<PatientInvestigation> orderedInves = new List<PatientInvestigation>(); 

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

                    // HL Starts
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
                    // HL Ends

                    //Save the data


                    string admitSuggest = string.Empty;
                    if (chkAdmit.Checked == true)
                    {
                        admitSuggest = "Y";
                    }

                 
                   


                    string gUID = Guid.NewGuid().ToString();
                    retval = uriBL.SaveUnFoundDiagnosisData(0, admitSuggest, patientID, nextReviewDate, visitID, lstdhebDiagnosis,
                                    lstdhebHistory, lstdhebExamination,
                                    orderedInvesHL, lstdrugs, lstPatientAdvice, lstPatientVitals, OrgID, out pOrderedInvCnt, "pending", gUID, physiciancomments);


                  
                    if (lstdhebDiagnosis.Count > 0)
                    {
                        Patient_BL objPatient_BL = new Patient_BL(base.ContextInfo);
                        objPatient_BL.UpdatePatientICDStatus(visitID);
                    }
                    retval = 0;
                }
              
                else
                {
                    //retval = -1;
                    //ErrorDisplay1.ShowError = true;
                    //ErrorDisplay1.Status = "Pl. enter a diagnosis";
                    //lblError.Visible = true;
                    //lblError.Text = "Pl. enter a diagnosis";
                }
            }
        }
        catch (Exception ex)
        {
            retval = -1;
            CLogger.LogError("Error while saving unfound diagnosis", ex);
        }

        return retval;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //string rmvPres = "Remove";

        //Commented By Ramki
        //Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out visitID);
        //Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
        //Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);
        //Int64.TryParse(Convert.ToString(Session["LID"]), out createdBy);
        createdBy = LID;
        
           
            SaveData();
            // Create Task here
            //string sQueryPath = Request.Url.PathAndQuery;
            //if (sQueryPath.Contains("RedirectURL"))
            //{
            //    sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL"));
            //}
            //sQueryPath = sQueryPath.Replace("&", "^~");
            //sQueryPath = "&RedirectURL=" + sQueryPath;

            Int32.TryParse(Request.QueryString["id"], out complaintID);
            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Pending, LID);
            try
            {
                if (chkAdditionalPayments.Checked == true)
                {
                    if (Request.QueryString["pvid"] != null && Request.QueryString["vid"] != null)
                    {
                        Int64.TryParse(Request.QueryString["vid"], out visitID);
                        Int64.TryParse(Request.QueryString["pvid"], out previousVisitID);
                        ClearSession();
                        
                        Response.Redirect("../Physician/DiadetesEMROPCaseSheet.aspx.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + previousVisitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y", true);
                    }
                    //else
                    //{
                    //    ClearSession();
                    //    Response.Redirect("../CaseSheet/ViewCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + sQueryPath, true);
                    //}
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
                        Response.Redirect("../Referrals/ReferralLetter.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y", true);
                    }
                    else
                    {
                        ClearSession();
                        Response.Redirect("../Physician/DiadetesEMROPCaseSheet.aspx?id=" + complaintID + "&tid=" + taskID + "&vid=" + visitID + "&pvid=" + visitID + "&pid=" + patientID + "&ftype=CON" + "&oC=Y" + "&gUID=" + gUID, true);
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
       // }
        
       

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
            pComplaint.PhysicianComments = fckPhysicianComments.Value;
            //if (cPD.Checked)
            //    pComplaint.Query = "Y";
            //else
            //    pComplaint.Query = "N";
            pComplaint.PatientVisitID = visitID;
            pComplaint.CreatedBy = LID;

            if (d.Description.Trim() != "")
                lst.Add(pComplaint);
        }
    }

    private void GetHistories(List<DHEBAdder> lstDHEBAdder, out List<PatientHistory> lst)
    {

        PatientHistory pHistory;
        lst = new List<PatientHistory>();

        foreach (DHEBAdder d in lstDHEBAdder)
        {
            pHistory = new PatientHistory();
            pHistory.HistoryID = 0;
            pHistory.HistoryName = d.Description;
            pHistory.Description = d.Comments;
            pHistory.PatientVisitID = visitID;
            pHistory.CreatedBy = LID;

            if(d.Description.Trim()!="")
                lst.Add(pHistory);
        }
    }

    private void GetExaminations(List<DHEBAdder> lstDHEBAdder, out List<PatientExamination> lst)
    {
        PatientExamination pExamination;
        lst = new List<PatientExamination>();

        foreach (DHEBAdder d in lstDHEBAdder)
        {
            pExamination = new PatientExamination();
            pExamination.ExaminationID = 0;
            pExamination.ExaminationName = d.Description;
            pExamination.Description = d.Comments;
            pExamination.PatientVisitID = visitID;
            pExamination.CreatedBy = LID;

            if(d.Description.Trim()!="")
                lst.Add(pExamination);
        }
    }

    protected void Back_Click(object sender, EventArgs e)
    {
        try
        {
            ClearSession();
            Response.Redirect("../Physician/Home.aspx", true);
            //Response.Redirect(@"../Physician/Diagnose.aspx?vid=" + visitID + "&tid=" + Session["TaskID"] + "&pid=" + patientID + "", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
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
    protected void btnSaveContinue_Click(object sender, EventArgs e)
    {
        //Commented By Ramki
        //string rmvPres = "Remove";

        //Commented By Ramki
        //Int32.TryParse(Convert.ToString(Session["TaskID"]), out taskID);

        //if (SaveData() == 0)
        //{
        //    try
        //    {
        //        string sQueryPath = Request.Url.PathAndQuery;
        //        if (sQueryPath.Contains("RedirectURL"))
        //        {
        //            sQueryPath = sQueryPath.Substring(0, sQueryPath.IndexOf("RedirectURL") - 1);
        //            sQueryPath = sQueryPath.Substring(0, sQueryPath.LastIndexOf("aspx") + 4);
        //        }
        //        sQueryPath = sQueryPath.Replace("&", "^~");

        //        //vid, pid, tid, pvid, id
        //        if (!sQueryPath.Contains("?id=") && !sQueryPath.Contains("^~id="))
        //        {
        //            sQueryPath = sQueryPath + "?id=" + complaintID;
        //        }
        //        if (!sQueryPath.Contains("?vid=") && !sQueryPath.Contains("^~vid="))
        //        {
        //            sQueryPath = sQueryPath + "^~vid=" + visitID;
        //        }
        //        if (!sQueryPath.Contains("?pid=") && !sQueryPath.Contains("^~pid="))
        //        {
        //            sQueryPath = sQueryPath + "^~pid=" + patientID;
        //        }
        //        if (!sQueryPath.Contains("?tid=") && !sQueryPath.Contains("^~tid="))
        //        {
        //            sQueryPath = sQueryPath + "^~tid=" + taskID;
        //        }
        //        if (!sQueryPath.Contains("?pvid=") && !sQueryPath.Contains("^~pvid="))
        //        {
        //            sQueryPath = sQueryPath + "^~pvid=" + visitID;
        //        }


        //        sQueryPath = "&RedirectURL=" + sQueryPath;

        //        ClearSession();
        //        Response.Redirect(@"../Physician/diabetesEMR.aspx?&vid=" + visitID + "&tid=" + taskID + "&pid=" + patientID + "" + sQueryPath, true);
        //    }
        //    catch (System.Threading.ThreadAbortException tae)
        //    {
        //        string thread = tae.ToString();
        //    }
        //}
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

    //Newly Added.....
    private void GetFCKPath()
    {
        try
        {
            string sPath = Request.Url.AbsolutePath;
            int iIndex = sPath.LastIndexOf("/");

            sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            sPath = Request.ApplicationPath;
            sPath = sPath + "/fckeditor/";

            fckPhysicianComments.ToolbarSet = "Attune";
            fckPhysicianComments.BasePath = sPath;
            fckPhysicianComments.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            fckPhysicianComments.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in FCk Editor In DischargeSummary.aspx", ex);
        }
    }

    protected void btnviewEdit_Click(object sender, EventArgs e)
    {
        try
        {
            SaveData();
            //Response.Redirect(@"../Patient/PatientEMRPackage.aspx?vid=" + visitID + "&tid=" + taskID + "&pid=" + patientID + "&isDoc=Y", true);
            Response.Redirect(@"../Patient/PatientEMRPackage.aspx?vid=" + visitID + "&tid=" +taskID +  "&pid=" + patientID, true);
            //Response.Redirect("../Patient/PatientEMRPackage.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }



    
}
