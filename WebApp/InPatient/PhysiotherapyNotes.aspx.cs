using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using System.Text.RegularExpressions;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Web.UI.HtmlControls;
using System.Timers;

public partial class InPatient_PhysiotherapyNotes : BasePage
{
    public InPatient_PhysiotherapyNotes()
        : base("InPatient\\PhysiotherapyNotes.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<Patient> lstPatient ;
    List<IPTreatmentPlan> lstIPTreatmentPlan;
    List<OrderedPhysiotherapy> lstOrderedPhysiotherapy;
    List<PatientPhysioDetails> lsPatientPhysioDetails;
    List<PhysioCompliant> lstPhysioCompliant;
    List<BackgroundProblem> lstBackgroundProblem;


    Patient_BL objPatient_BL;

    string VisitType = String.Empty;
    long VisitID = -1;
    long PatientID = -1;
    long returncode = -1;
    long PhysicanID = -1;
    string Edit = string.Empty;
    long procID = 0;
    int PhysioCount = 0;
    static string EmpNo = "0";
    string parentVisitID = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        ComplaintICDCode1.ComplaintHeader = "Clinical Diagnosis";
        ComplaintICDCode1.SetWidth(500); 
        //txtExpD.Attributes.Add("onchange", "ExcedDate('" + txtExpD.ClientID.ToString() + "','',0,0);");
        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/"); 
        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath ;
        sPath = sPath + "/fckeditor/";
        fckPhysio.BasePath = sPath;
        fckPhysio.ToolbarSet = "Attune";
        fckPhysio.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        fckPhysio.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        FCKeditorRef.BasePath = sPath;
        FCKeditorRef.ToolbarSet = "Attune";
        FCKeditorRef.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        FCKeditorRef.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        if (!IsPostBack)
        {
            try
            {
                if (Request.QueryString["pid"] != null)
                {
                    if (IsCorporateOrg == "Y")
                    {
                        tbMainProc.Style.Add("display", "block");
                        tabProc.Style.Add("display", "block");
                        Grdplus.Style.Add("display", "block");
                    }
                    //pid,vid,vtype
                    Int64.TryParse(Request.QueryString["vid"], out VisitID);
                    Int64.TryParse(Request.QueryString["pid"], out PatientID);
                    hdnPatientID.Value = PatientID.ToString();
                    if (Request.QueryString["ProcID"] != null)
                    {
                        Int64.TryParse(Request.QueryString["ProcID"], out procID);
                    }
                    hdnCurrentDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                    VisitType = Request.QueryString["vtype"];
                    LoadOrderProcedure();
                    BindOrderedPhysiotherapy(PatientID, VisitID, procID);
                    BindPatientRegDetail(PatientID, VisitID, VisitType);
                    GetClinicalSotting(PatientID, VisitID);
                    DropDownShow();
                    GetPatientPhysioDetail(PatientID, VisitID);
                    GetPreviousPhysioVisit(PatientID);
                    GetPhysioComplaint(PatientID, VisitID);
                    ddlNos.Attributes.Add("onchange", "setActualDay()");
                    ddlDMY.Attributes.Add("onchange", "setActualDay()");
                    ComplaintICDCode1.ComplaintHeader = "Clinical Diagnosis";

                    if (Request.QueryString["Edit"] == "Y")
                    {
                        ddlType.SelectedValue = "1";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "ShowhideTable();", true);
                    }
                    else
                    {
                        ddlType.SelectedValue = "0";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "ShowhideTable();", true);
                    }
                }
            }



            catch (Exception ex)
            {
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
                CLogger.LogError("Error in PhysiotherapyNotes.aspx:Page_Load", ex);
            }
        }
    }


    protected void GetPhysioComplaint(long PatientID, long VisitID)
    {
        lstPhysioCompliant=new List<PhysioCompliant>();
        objPatient_BL.GetPhysioComplaint(PatientID, VisitID, out lstPhysioCompliant);
        ComplaintICDCode1.SetPhysioComplaint(lstPhysioCompliant);
    }

    public void DropDownShow()
    {
        try
        {
            Physician_BL ObjPhysician = new Physician_BL(base.ContextInfo);
            List<Physician> physicianList = new List<Physician>();
            ObjPhysician.GetPhysicianListByOrg(OrgID, out physicianList, 0);

            ddlConsultant.DataSource = physicianList;
            ddlConsultant.DataTextField = "PhysicianName";
            ddlConsultant.DataValueField = "PhysicianID";
            ddlConsultant.DataBind();
            ddlConsultant.Items.Insert(0, "--All--");
            ddlConsultant.Items[0].Value = "0";
        }



        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in ConsultantDropDownShow Page_Load", ex);
        }
    }


    private void GetPatientPhysioDetail(long PatientID, long VisitID)
    {
        try
        {
            lsPatientPhysioDetails = new List<PatientPhysioDetails>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            string type = "CVID";
            objPatient_BL.GetPatientPhysioDetail(PatientID, VisitID, type, out lsPatientPhysioDetails);


            if (lsPatientPhysioDetails.Count > 0)
            {
                //tblPPDT.Style.Add("display", "block");
                //tblPPDTH.Style.Add("display", "block");
                gvPPDT.DataSource = lsPatientPhysioDetails;
                gvPPDT.DataBind();
                ddlType.Enabled = true;
                FCKeditorRef.Value = lsPatientPhysioDetails[0].PhysicianComments;
                fckPhysio.Value = lsPatientPhysioDetails[0].Symptoms;
                int cnt = lsPatientPhysioDetails.Max(p => p.CurrentNoOfSitting);
                if (cnt > 1)
                {
                   // tbVtype.Style.Add("display", "block");
                    string vType = lsPatientPhysioDetails[0].VisitType;
                    if (vType != "")
                    {
                        if (vType == "Review")
                        {
                            ddlVisitType.SelectedValue = "1";
                        }
                        else
                        {
                            ddlVisitType.SelectedValue = "2";
                        }
                    }
                    else
                    {
                        ddlVisitType.SelectedValue = "0";
                    }
                }
                else
                {
                   // tbVtype.Style.Add("display", "none");
                }
            }
            else
            {
                ddlType.Enabled = false;
            }

        }



        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error Wile binding  GetPatientPhysioDetail ", ex);
        }
    }

  //  private void GetPreviousPhysioVisit(long PatientID)
    //{

    //    try
    //    {
    //        lsPatientPhysioDetails = new List<PatientPhysioDetails>();

    //        PatientPhysioDetails obi = new PatientPhysioDetails();
    //        objPatient_BL = new Patient_BL(base.ContextInfo);
    //        objPatient_BL.GetPreviousPhysioVisit(PatientID, out lsPatientPhysioDetails);


    //        if (lsPatientPhysioDetails.Count > 0)
    //        {
    //            //tblPrevVisit.Style.Add("display", "block");
    //            //tblPrevVisitH.Style.Add("display", "block");
    //            //gvPrevVisit.DataSource = lsPatientPhysioDetails;
    //            //gvPrevVisit.DataBind();
    //        }
    //    }

    //    catch (Exception ex)
    //    {
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
    //        CLogger.LogError("Error Wile binding  GetPreviousPhysioVisit ", ex);
    //    }
    //}

    private void GetPreviousPhysioVisit(long PatientID)
    {

        try
        {
            string VisitDate = string.Empty;
            List<PatientPhysioDetails> lsPatientPhysioDetails = new List<PatientPhysioDetails>();
            List<PhysioCompliant> lstPhysioCompliant = new List<PhysioCompliant>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            objPatient_BL.GetPreviousPhysioVisitDt(PatientID, VisitDate, out lsPatientPhysioDetails, out lstPhysioCompliant);
            int x = 0;
            int y = 0;
            x = lsPatientPhysioDetails.Count;
            y = lstPhysioCompliant.Count;
            if (x > 0 || y > 0)
            {
                btnShow.Enabled = true;
            }
            if (x > 0)
            {
                gvPrevVisitDetail.DataSource = lsPatientPhysioDetails;
                gvPrevVisitDetail.DataBind();

                long vstID = lsPatientPhysioDetails.Max(p => p.VisitID);
                string symptoms = lsPatientPhysioDetails.Find(s => s.VisitID == vstID).Symptoms.ToString();
                string phyCmmt = lsPatientPhysioDetails.Find(s => s.VisitID == vstID).PhysicianComments.ToString();
                fckPhysio.Value = symptoms;
                FCKeditorRef.Value = phyCmmt;
            }
            if (y > 0)
            {
                gvPrevDiagnose.DataSource = lstPhysioCompliant;
                gvPrevDiagnose.DataBind();
            }
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error Wile binding  GetPreviousPhysioVisit ", ex);
        }
    }

    private void GetClinicalSotting(long PatientID, long VisitID)
    {

        try
        {



            lstIPTreatmentPlan = new List<IPTreatmentPlan>();
            lstBackgroundProblem = new List<BackgroundProblem>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            objPatient_BL.GetClinicalSotting(PatientID, VisitID, out lstIPTreatmentPlan, out lstBackgroundProblem);

            string ClinicalSotting = string.Empty;
            if (lstIPTreatmentPlan.Count > 0)
            {
                foreach (IPTreatmentPlan objCS in lstIPTreatmentPlan)
                {
                    if (ClinicalSotting == string.Empty)
                    {
                        ClinicalSotting = objCS.IPTreatmentPlanName;
                    }
                    else
                    {
                        ClinicalSotting += objCS.IPTreatmentPlanName;
                    }
                }
                if (ClinicalSotting != "")
                {

                    lblCS.Text = ClinicalSotting;
                }
            }


            if (lstIPTreatmentPlan.Count > 0)
            {
                tblPrevSOI.Style.Add("display", "block");
                tblSOIH.Style.Add("display", "block");
                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                TableCell cellH2 = new TableCell();
                TableCell cellH3 = new TableCell();
                TableCell cellH4 = new TableCell();
                TableCell cellH5 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Type";
                cellH2.Attributes.Add("align", "left");
                cellH2.Text = "Treatment Name";
                cellH3.Attributes.Add("align", "left");
                cellH3.Text = "Prosthesis";
                cellH4.Attributes.Add("align", "left");
                cellH4.Text = "Date";

                rowH.Cells.Add(cellH1);
                rowH.Cells.Add(cellH2);
                rowH.Cells.Add(cellH3);
                rowH.Cells.Add(cellH4);

                rowH.Font.Bold = true;

                rowH.Style.Add("color", "#000");
                tblSurgeryDetail.Rows.Add(rowH);

                foreach (var oIPTreatmentPlan in lstIPTreatmentPlan)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();

                    cell1.Attributes.Add("align", "left");
                    cell1.Text = oIPTreatmentPlan.ParentName;
                    cell2.Attributes.Add("align", "left");
                    cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;

                    if (oIPTreatmentPlan.Prosthesis == "")
                    {
                        cell3.Attributes.Add("align", "left");
                        cell3.Text = "-";
                    }
                    else
                    {
                        cell3.Attributes.Add("align", "left");
                        cell3.Text = oIPTreatmentPlan.Prosthesis;
                    }


                    if (oIPTreatmentPlan.FromTime == DateTime.MinValue)
                    {
                        cell4.Attributes.Add("align", "left");
                        cell4.Text = "-";
                    }
                    else
                    {
                        cell4.Attributes.Add("align", "left");
                        cell4.Text = oIPTreatmentPlan.FromTime.ToString();
                    }
                    row1.Cells.Add(cell1);
                    row1.Cells.Add(cell2);
                    row1.Cells.Add(cell3);
                    row1.Cells.Add(cell4);

                    row1.Style.Add("color", "#000");
                    tblSurgeryDetail.Rows.Add(row1);
                }
            }



            if (lstBackgroundProblem.Count > 0)
            {

                tblBPH.Style.Add("display", "block");
                tblBP.Style.Add("display", "block");
                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                TableCell cellH2 = new TableCell();
                TableCell cellH3 = new TableCell();
                TableCell cellH4 = new TableCell();
                TableCell cellH5 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "BackgroundProblem";
                cellH2.Attributes.Add("align", "left");
                cellH2.Text = "Description";


                rowH.Cells.Add(cellH1);
                rowH.Cells.Add(cellH2);


                rowH.Font.Bold = true;

                rowH.Style.Add("color", "#000");
                tblproblems.Rows.Add(rowH);

                foreach (var oBackgroundProblem in lstBackgroundProblem)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();

                    cell1.Attributes.Add("align", "left");
                    cell1.Text = oBackgroundProblem.ComplaintName;
                    cell2.Attributes.Add("align", "left");
                    cell2.Text = oBackgroundProblem.Description;

                    row1.Cells.Add(cell1);
                    row1.Cells.Add(cell2);

                    row1.Style.Add("color", "#000");
                    tblproblems.Rows.Add(row1);
                }
            }
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error Wile binding  Clinicalsotting ", ex);
        }

    }

    private void BindPatientRegDetail(long PatientID, long VisitID, string VisitType)
    {
        lstPatient = new List<Patient>();
        List<PatientVisit> lstPatientVisit=new List<PatientVisit>();
        objPatient_BL=new Patient_BL(base.ContextInfo);

        objPatient_BL.GetPatientVisitType(PatientID, VisitID, out lstPatientVisit);

        if (lstPatientVisit[0].VisitType == 0)
        {
            VisitType = "OP";
            hdnvistType.Value = VisitType;
        }
        else
        {
            VisitType = "IP";
            hdnvistType.Value = VisitType;
        }
       
        objPatient_BL.BindPatientRegDetail(PatientID, VisitID, VisitType, out lstPatient);

       

        if (VisitType == "IP")
        {
            string primaryConsultant = string.Empty;
            List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
            new Patient_BL(base.ContextInfo).GetPrimaryConsultant(VisitID, 1, out lstPrimaryConsultant);

            if (lstPrimaryConsultant.Count > 0)
            {
                foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                {
                    if (primaryConsultant == "")
                    {
                        primaryConsultant = objPC.PhysicianName;
                    }
                    else
                    {
                        primaryConsultant += " , " + objPC.PhysicianName;
                    }

                }

                lblConsultantV.Text = primaryConsultant;
            }


            lblNameV.Text = lstPatient[0].Name;
            string sex = (lstPatient[0].SEX == "M") ? "Male" : "Female";
            lblAgeSexV.Text = lstPatient[0].Age + " / " + sex;
            lblPIDV.Text = lstPatient[0].PatientNumber.ToString();

            if (lblConsultantV.Text != "")
            {
                dvConsultant.Style.Add("display", "none");
            }
        }

        else
        {
            lblNameV.Text = lstPatient[0].Name;
            string sex = (lstPatient[0].SEX == "M") ? "Male" : "Female";
            lblAgeSexV.Text = lstPatient[0].Age + " / " + sex;
            lblPIDV.Text = lstPatient[0].PatientNumber.ToString();
            if (lstPatient[0].ReferingPhysicianName != null)
            {
                //dvConsultant.Style.Add("display", "none");
                lblConsultantV.Text = "Dr. "+lstPatient[0].ReferingPhysicianName;
            }
            else
            {
                
                if (lstPatient[0].PrimaryPhysician != null)
                {
                    //dvConsultant.Style.Add("display", "none");
                    lblConsultantV.Text = lstPatient[0].PrimaryPhysician;
                }
            }

            if (lblConsultantV.Text != "")
            {
                dvConsultant.Style.Add("display", "none");
            }
            if (lblConsultantV.Text == "")
            {
                dvConsultant.Style.Add("display", "block");
            }
        }
       

    }

    private void BindOrderedPhysiotherapy(long PatientID, long VisitID, long procID)
    {
        lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        procID = 0;   //--- Procedure ID assign to Zero because the Physiotherapist wants to view all the procedure in dropdown
        objPatient_BL.BindOrderedPhysiotherapy(PatientID, VisitID, procID,out lstOrderedPhysiotherapy);

        if (lstOrderedPhysiotherapy.Count > 0)
        {
            ddlPhysio.DataValueField = "Status";
            ddlPhysio.DataTextField = "ProcedureName";
            ddlPhysio.DataSource = lstOrderedPhysiotherapy;
            ddlPhysio.DataBind();
        }        
        ddlPhysio.Items.Insert(0, "--Select--");
       

    }
  
    //protected void ddlPhysio_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    try
    //    {



    //        Clear();

    //        decimal Quantity = 0;
    //        int CurrentNoOfSitting = 0;
    //        int AdvisedNoOfSitting = 0;
    //        ComplaintICDCode1.ComplaintHeader = "Clinical Diagnosis";

    //        objPatient_BL = new Patient_BL(base.ContextInfo);

    //        List<PatientPhysioDetails> lstPatientPhysioDetails = new List<PatientPhysioDetails>();

    //        Int64.TryParse(Request.QueryString["vid"], out VisitID);
    //        Int64.TryParse(Request.QueryString["pid"], out PatientID);

    //        objPatient_BL.GetPatientPhysioByProcID(Convert.ToInt64(ddlPhysio.SelectedValue), PatientID, VisitID, hdnvistType.Value, out Quantity, out CurrentNoOfSitting, out AdvisedNoOfSitting);

    //        //if (Quantity > 0)
    //        //{
    //        // txtPaidSitting.Text = Quantity.ToString();
    //        txtCurrentNoSitting.Text = (CurrentNoOfSitting + 1).ToString();

    //        if (AdvisedNoOfSitting == 0)
    //        {

    //            txtAdVNoSitting.Text = "";
    //        }
    //        else
    //        {
    //            txtAdVNoSitting.Text = AdvisedNoOfSitting.ToString();
    //        }


    //        //if (AdvisedNoOfSitting == Convert.ToInt32(txtCurrentNoSitting.Text))
    //        //{
    //        //    chkPendingSitting.Enabled = false;
    //        //    chkPendingSitting.Checked = false;
    //        //}
    //        //else
    //        //{
    //        //    chkPendingSitting.Checked = true;
    //        //    chkPendingSitting.Enabled = true;
    //        //}



    //        //}

    //        ComplaintICDCode1.LoadComplaintItems();

    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
    //        CLogger.LogError("Error While  ddlPhysio_SelectedIndexChanged ", ex);
    //    }
        
       
    //}
    void Clear()
    {
       // txtPaidSitting.Text = "";
        txtCurrentNoSitting.Text="";
        txtAdVNoSitting.Text = "";
        txtDutation.Text = "";
        txtSCV.Text = "";
        txtRemarks.Text = "";
        txtActualDate.Text = "";
        
      //  hdnDiagnosisItems.Value = "";
      //  ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadDiagnosisItems();", true);

    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
         SaveData();
         if (Request.QueryString["parentVID"] != null)
         {
             parentVisitID = Request.QueryString["parentVID"].ToString();
         }
         if (Request.QueryString["ProcID"] != null)
         {
             Int64.TryParse(Request.QueryString["ProcID"], out procID);
         }

         if (hdnType.Value != "Update")
         {
             long taskID = -1;
             Int64.TryParse(Request.QueryString["tid"], out taskID);
             Response.Redirect(@"../InPatient/PhysioCaseSheet.aspx?pid=" + PatientID + "&vid=" + VisitID + "&Show=Y" + "&parentVID=" + parentVisitID + "&ProcID=" + procID + "&PhysioCount=" + PhysioCount.ToString() + "&tid=" + taskID.ToString(), true);
         }
         else
         {
             btnFinish.Text = "Update";
             AddMore.Visible = true;
         }


    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {

        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void AddMore_Click(object sender, EventArgs e)
    {
        SaveData();       

    }
    public void SaveData()
    {

        try
        {
            long returnCode = -1;
            PatientPhysioDetails objPatientPhysioDetails = new PatientPhysioDetails();

            lstPhysioCompliant = new List<PhysioCompliant>();

            lsPatientPhysioDetails = new List<PatientPhysioDetails>();
            List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
            Int64.TryParse(Request.QueryString["vid"], out VisitID);
            Int64.TryParse(Request.QueryString["pid"], out PatientID);

            TimeSpan timeNow = Convert.ToDateTime(new BasePage().OrgDateTimeZone).TimeOfDay;
            TimeSpan trimmedTimeNow = new TimeSpan(timeNow.Hours, timeNow.Minutes, timeNow.Seconds);
            var dtUtc = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToUniversalTime(); 
            dtUtc.AddHours(trimmedTimeNow.Hours); 
            dtUtc.AddMinutes(trimmedTimeNow.Minutes);
            var dtLocal = dtUtc.ToLocalTime();
            string s = dtLocal.ToString("hh:mm:ss tt");

            objPatientPhysioDetails.NextReview = txtActualDate.Text + " " +s;            

            if (ddlConsultant.SelectedValue != "0")
            {
                PhysicanID = Convert.ToInt64(ddlConsultant.SelectedValue);
            }
           

            lstPhysioCompliant = ComplaintICDCode1.GetPhysioCompliant();           

            objPatient_BL = new Patient_BL(base.ContextInfo);

         

            if (hdnType.Value != "Update")
            {
                lsPatientPhysioDetails = GetPatientPhysioDetails();                
                returncode = objPatient_BL.SavePhysioDetails(PatientID, VisitID, ILocationID, OrgID, LID, hdnvistType.Value, lsPatientPhysioDetails, objPatientPhysioDetails, lstPhysioCompliant, PhysicanID);
                //lstOrderedPhysiotherapy = GetExtendedSittings();
                OrderProcedure();
                //if (lstOrderedPhysiotherapy.Count > 0)
                //{
                //    string Type = "Ordered";
                //    int Physiocount = 0;
                //    returnCode = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(VisitID, ILocationID, OrgID, LID, Type, lstOrderedPhysiotherapy, out Physiocount);
                //}
                
                
                                
                hdnPhysioItems.Value = "";                
                ddlType.SelectedValue = "0";                
                tblPPDT.Style.Add("display", "none");
                btnFinish.Text = "Save";
                hdnType.Value = "Save";
                trNxtReview.Style.Add("display", "block");
                tblAddPhysiotherophy.Style.Add("display", "block");
                tblPhysioItems.Style.Add("display", "block");
                AddMore.Style.Add("display", "block");

            }
            else
            {
                lsPatientPhysioDetails = GetPhysioDetailsForUpdate();
                returncode = objPatient_BL.UpdatePhysioDetails(PatientID, VisitID, ILocationID, OrgID, LID, hdnvistType.Value, lsPatientPhysioDetails, objPatientPhysioDetails, lstPhysioCompliant, PhysicanID);
                OrderProcedure();
                hdnPhysioItems.Value = "";
                
                //ddlType.SelectedValue = "1";

                //tblPPDT.Style.Add("display", "block");
                //btnFinish.Text = "Update";
                //hdnType.Value = "Update";
                //trNxtReview.Style.Add("display", "none");
                //tblAddPhysiotherophy.Style.Add("display", "none");
                //tblPhysioItems.Style.Add("display", "none");
                //AddMore.Style.Add("display", "none");
                if (Request.QueryString["parentVID"] != null)
                {
                    parentVisitID = Request.QueryString["parentVID"].ToString();
                }
                if (Request.QueryString["ProcID"] != null)
                {
                    Int64.TryParse(Request.QueryString["ProcID"], out procID);
                }
                long taskID = -1;
                Int64.TryParse(Request.QueryString["tid"], out taskID);
                Response.Redirect(@"../InPatient/PhysioCaseSheet.aspx?pid=" + PatientID + "&vid=" + VisitID + "&Show=Y" + "&parentVID=" + parentVisitID + "&ProcID=" + procID + "&PhysioCount=" + PhysioCount.ToString() + "&tid=" + taskID.ToString(), true);
            }
            if (Request.QueryString["ProcID"] != null)
            {
                Int64.TryParse(Request.QueryString["ProcID"], out procID);
            }
            BindOrderedPhysiotherapy(PatientID, VisitID, procID);
            GetPatientPhysioDetail(PatientID, VisitID);
            //GetPreviousPhysioVisit(PatientID);
           // ComplaintICDCode1.hdnClear();
            ComplaintICDCode1.LoadComplaintItems();
            Clear();
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error While  Saving Physio data", ex);
        }

    }

    private List<PatientPhysioDetails> GetPhysioDetailsForUpdate()
    {
        List<PatientPhysioDetails> lstPatientPhysioDetailsTemp = new List<PatientPhysioDetails>();

        foreach (GridViewRow grdItems in gvPPDT.Rows)
        {
            Label lblPatientPhysioDtlIDE = (Label)grdItems.FindControl("lblPatientPhysioDtlIDE");
            TextBox txtDutationE = (TextBox)grdItems.FindControl("txtDutationE");
            DropDownList ddlDurationUnitsE = (DropDownList)grdItems.FindControl("ddlDurationUnitsE");
            TextBox txtAdVNoSittingE = (TextBox)grdItems.FindControl("txtAdVNoSittingE");
            TextBox txtCurrentNoSittingE = (TextBox)grdItems.FindControl("txtCurrentNoSittingE");
            TextBox txtSCVE = (TextBox)grdItems.FindControl("txtSCVE");
            TextBox txtRemarksE = (TextBox)grdItems.FindControl("txtRemarksE");
            TextBox txtCommentsE = (TextBox)grdItems.FindControl("txtCommentsE");
            Label lblProcedureNameE = (Label)grdItems.FindControl("lblProcedureNameE");
            Label lblHasPending = (Label)grdItems.FindControl("lblHasPending");

            DropDownList ddlNosE = (DropDownList)grdItems.FindControl("ddlNosE");
            DropDownList ddlDMYE = (DropDownList)grdItems.FindControl("ddlDMYE");
            TextBox txtNextReviewDateE = (TextBox)grdItems.FindControl("txtNextReviewDateE");
            
            

            PatientPhysioDetails objPPD = new PatientPhysioDetails();
            objPPD.PatientPhysioDtlID = Convert.ToInt64(lblPatientPhysioDtlIDE.Text);
            objPPD.DurationValue = Convert.ToDecimal(txtDutationE.Text);
            objPPD.DurationUnits = ddlDurationUnitsE.SelectedItem.Text;
            objPPD.AdvisedNoOfSitting = Convert.ToInt32(txtAdVNoSittingE.Text);
            objPPD.CurrentNoOfSitting = Convert.ToInt32(txtCurrentNoSittingE.Text);
            objPPD.ProcedureName = lblProcedureNameE.Text;
            objPPD.HasPending = lblHasPending.Text;
            if (txtSCVE.Text != "")
            {
                objPPD.ScoreCardValue = Convert.ToDecimal(txtSCVE.Text);
            }
            objPPD.Remarks = txtRemarksE.Text + "|" + txtCommentsE;
            string symt = Regex.Replace(fckPhysio.Value, "<[^>]+>", "");
            string phycmt = Regex.Replace(FCKeditorRef.Value, "<[^>]+>", "");
            objPPD.Symptoms = symt;
            objPPD.PhysicianComments = phycmt;
            objPPD.NextReview = txtNextReviewDateE.Text;
            int vType = Convert.ToInt32(ddlVisitType.SelectedValue);
            string vTypeText = string.Empty;
            if (vType != 0)
            {
                vTypeText = ddlVisitType.SelectedItem.ToString();
            }
            objPPD.VisitType = vTypeText;
            lstPatientPhysioDetailsTemp.Add(objPPD);

            
        }

        return lstPatientPhysioDetailsTemp;
    }

    private List<OrderedPhysiotherapy> GetExtendedSittings()
    {
        List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
        if (hdnAddMoreItems.Value != "")
        {
            foreach (string PhysioDetail in hdnAddMoreItems.Value.Split('^'))
            {
                if (PhysioDetail != "")
                {
                    OrderedPhysiotherapy objOrderedPhysiotherapy = new OrderedPhysiotherapy();
                    objOrderedPhysiotherapy.ProcedureName = Convert.ToString((PhysioDetail).Split('~')[0]);
                    objOrderedPhysiotherapy.ProcedureID = Convert.ToInt64((PhysioDetail).Split('~')[1]);
                    objOrderedPhysiotherapy.OdreredQty = Convert.ToDecimal((PhysioDetail).Split('~')[2]);
                    objOrderedPhysiotherapy.Status = "InProgress";
                    objOrderedPhysiotherapy.PaymentStatus = "";
                    lstOrderedPhysiotherapy.Add(objOrderedPhysiotherapy);
                }
            }
        }
        return lstOrderedPhysiotherapy;
    }
    private List<PatientPhysioDetails> GetPatientPhysioDetails()
    {
        List<PatientPhysioDetails> lstPatientPhysioDetailsTemp = new List<PatientPhysioDetails>();

        // parseInt(rwNumber) + "~" + Procname + "~" + ProcID(308 procID|0 C|0 A) + "~" +;
        //Duration + "~" + DurationUnits + "~" + Advised + "~" + Current ;
        // + "~" + SCV + "~" + Notes + "~" + HasPending;

        int i = 1;

        foreach (string listParentDiagnosis in hdnPhysioItems.Value.Split('^'))
        {
            if (listParentDiagnosis != "")
            {
                PatientPhysioDetails objPPD = new PatientPhysioDetails();
               
                string[] listChildPPD = listParentDiagnosis.Split('~');
                objPPD.RowID = i;
                objPPD.ProcedureName = listChildPPD[1];
                string[] ProcedureID = listChildPPD[2].Split('|');
                objPPD.ProcedureID = Convert.ToInt64(ProcedureID[0]);
                objPPD.DurationValue = Convert.ToDecimal(listChildPPD[3]);
                objPPD.DurationUnits = listChildPPD[4];
                objPPD.AdvisedNoOfSitting =Convert.ToInt32(listChildPPD[5]);
                objPPD.CurrentNoOfSitting = Convert.ToInt32(listChildPPD[6]);
                if (listChildPPD[7] != "")
                {
                    objPPD.ScoreCardValue = Convert.ToDecimal(listChildPPD[7]);
                }
                else
                {
                    objPPD.ScoreCardValue = -1;
                }
                objPPD.Remarks = listChildPPD[8];
                if (listChildPPD[9] == "Yes")
                {
                    objPPD.HasPending = "Y";
                }
                else
                {
                    objPPD.HasPending = "N";
                }
                //string symt = Regex.Replace(fckPhysio.Value, "<[^>]+>", "");
                //string phycmt = Regex.Replace(FCKeditorRef.Value, "<[^>]+>", "");
                //objPPD.Symptoms = symt;
                //objPPD.PhysicianComments = phycmt;
                objPPD.Symptoms = fckPhysio.Value;
                objPPD.PhysicianComments = FCKeditorRef.Value;                
                int vType = Convert.ToInt32(ddlVisitType.SelectedValue);
                string vTypeText = string.Empty;
                if (vType != 0)
                {
                    vTypeText = ddlVisitType.SelectedItem.ToString();
                }
                objPPD.VisitType = vTypeText;
                objPPD.NextReview = txtActualDate.Text;
                lstPatientPhysioDetailsTemp.Add(objPPD);
            }
            i++;
        }
        return lstPatientPhysioDetailsTemp;
    }

    //protected void gvPrevVisit_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "OView")
    //    {
    //        long PatientID = 0;
    //        string VisitDate = string.Empty;
    //        int RowIndex = Convert.ToInt32(e.CommandArgument);
    //        //VisitDate = gvPrevVisit.DataKeys[RowIndex][0].ToString();
    //        //PatientID = Convert.ToInt64(gvPrevVisit.DataKeys[RowIndex][1]);

    //       lsPatientPhysioDetails = new List<PatientPhysioDetails>();
    //       lstPhysioCompliant = new List<PhysioCompliant>();
    //       objPatient_BL = new Patient_BL(base.ContextInfo);           
    //       objPatient_BL.GetPreviousPhysioVisitDt(PatientID, VisitDate, out lsPatientPhysioDetails, out lstPhysioCompliant);

    //       if (lsPatientPhysioDetails.Count > 0)
    //       {
    //           //tblPrevVisit.Style.Add("display", "block");
    //           //tblPrevVisitH.Style.Add("display", "block");

    //           gvPrevVisitDetail.DataSource = lsPatientPhysioDetails;
    //           gvPrevVisitDetail.DataBind();
    //           if (lstPhysioCompliant.Count > 0)
    //           {

    //               gvPrevDiagnose.DataSource = lstPhysioCompliant;
    //               gvPrevDiagnose.DataBind();
    //           }

    //           ModelPopPrevVisitDetail.Show();
    //       }
    //       //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "LoadPhysioItems();", true);
    //       //ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "CreateTabl1();", true); 
    //       ComplaintICDCode1.LoadComplaintItems();

            
           
    //    }
    //}
    //protected void gvPrevVisit_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    try
    //    {
    //        if (e.NewPageIndex != -1)
    //        {
    //            //gvPrevVisit.PageIndex = e.NewPageIndex;
    //            Int64.TryParse(Request.QueryString["pid"], out PatientID);
    //            GetPreviousPhysioVisit(PatientID);
    //            ComplaintICDCode1.LoadComplaintItems();
    //            LoadPhysioItems();
               
    //        }
    //    }

    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Get Report, gvPrevVisit_PageIndexChanging", ex);
    //    }
    //}

    protected void LoadPhysioItems()
    {
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "PhysioItems", "  LoadPhysioItems();", true);
    }

    protected void gvPrevVisitDetail_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientPhysioDetails PPD = (PatientPhysioDetails)e.Row.DataItem;
            Label lblRemarks = (Label)e.Row.FindControl("lblPhysioNote");
            lblRemarks.Text = PPD.Remarks.Split('|')[0];
        }
    }

    protected void gvPPDT_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PatientPhysioDetails PPD = (PatientPhysioDetails)e.Row.DataItem;
            Label lblCreatedAtE = (Label)e.Row.FindControl("lblCreatedAtE");
            Label lblProcedureNameE = (Label)e.Row.FindControl("lblProcedureNameE");
            TextBox txtDutationE = (TextBox)e.Row.FindControl("txtDutationE");
            DropDownList ddlDurationUnitsE = (DropDownList)e.Row.FindControl("ddlDurationUnitsE");
            TextBox txtAdVNoSittingE = (TextBox)e.Row.FindControl("txtAdVNoSittingE");
            TextBox txtCurrentNoSittingE = (TextBox)e.Row.FindControl("txtCurrentNoSittingE");
            TextBox txtSCVE = (TextBox)e.Row.FindControl("txtSCVE");
            TextBox txtRemarksE = (TextBox)e.Row.FindControl("txtRemarksE");
            TextBox txtCommentsE = (TextBox)e.Row.FindControl("txtCommentsE");
            //CheckBox chkPendingSittingE = (CheckBox)e.Row.FindControl("chkPendingSittingE");
            //Button btnCancel = (Button)e.Row.FindControl("btnCancel");

            TextBox txtNextReviewDateE = (TextBox)e.Row.FindControl("txtNextReviewDateE");
            txtNextReviewDateE.Attributes.Add("onfocus", "ValidatePrevDate('" + txtNextReviewDateE.ClientID + "')");

            DropDownList ddlNosE = (DropDownList)e.Row.FindControl("ddlNosE");
            DropDownList ddlDMYE = (DropDownList)e.Row.FindControl("ddlDMYE");


            hdnChkValues.Value += txtDutationE.ClientID + "~" + txtAdVNoSittingE.ClientID + "~" + txtCurrentNoSittingE.ClientID + "^";


            txtRemarksE.Text = PPD.Remarks.Split('|')[0];
            txtCommentsE.Text = PPD.Remarks.Split('|')[1];

            if (PPD.DurationUnits == "Hour(s)")
            {
                ddlDurationUnitsE.SelectedValue = "1";
            }
            else if (PPD.DurationUnits == "Min(s)")
            {
                ddlDurationUnitsE.SelectedValue = "2";
            }
            else
            {
                ddlDurationUnitsE.SelectedValue = "3";

            }
            if (PPD.ScoreCardValue == 0)
            {
                txtSCVE.Text = "";
            }

            //if (PPD.HasPending == "Y")
            //{
            //    //chkPendingSittingE.Visible = true;
            //    //chkPendingSittingE.Checked = true;
            //    btnCancel.Visible = true;
            //}
            //else
            //{
            //    btnCancel.Visible = false;
            //    txtAdVNoSittingE.Enabled = false;
            //}

            if ((PPD.NextReview != "") && (PPD.NextReview != null))
             {
                 if (PPD.NextReview.Contains(":") || PPD.NextReview.Contains("/"))
                 {
                     txtNextReviewDateE.Text = PPD.NextReview;
                 }
                 else
                 {
                     string NextReview = string.Empty;
                     string NextReviewNos = string.Empty;
                     string NextReviewDMY = string.Empty;
                     string[] nReview;

                     NextReview = PPD.NextReview;
                     nReview = NextReview.Split('-');
                     if (nReview.Length > 0)
                     {
                         NextReviewNos = nReview[0].ToString();
                         NextReviewDMY = nReview[1].ToString();
                         ddlNosE.SelectedValue = NextReviewNos;
                         ddlDMYE.SelectedValue = NextReviewDMY;
                     }
                 }
             }
          
            
        }
    }

    public void LoadOrderProcedure()
    {
        try
        {
            long returnCode = -1;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
            Int64.TryParse(Request.QueryString["vid"], out VisitID);
            Int64.TryParse(Request.QueryString["pid"], out PatientID);
            long proTaskStatusID = -1;
            returnCode = patientBL.GetOrderedPhysio(PatientID, VisitID, LID, out lstOrderedPhysiotherapy, out proTaskStatusID);
            string Additems = string.Empty;
            hdnOrdered.Value = "";
            if (lstOrderedPhysiotherapy.Count > 0)
            {
                for (int i = 0; i < lstOrderedPhysiotherapy.Count; i++)
                {
                    hdnOrdered.Value += lstOrderedPhysiotherapy[i].ProcedureID + "~" + lstOrderedPhysiotherapy[i].ProcedureName + "~" + String.Format("{0:0}", lstOrderedPhysiotherapy[i].OdreredQty) + '^';
                }                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading LoadOrderProcedure", ex);
        }
    }

    protected void lnkHome_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void btnOrder_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        returnCode = OrderProcedure();
        if (returnCode == 0)
        {
            #region Physiotherapy Task
            if (IsCorporateOrg == "Y")
            {                
                Patient patient;
                List<Patient> lsPatient = new List<Patient>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                string feeType = String.Empty;
                feeType = "PRO";
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
                Tasks task = new Tasks();
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                long physioTaskID;
                long retnCode = -1;
                Int64.TryParse(Request.QueryString["vid"], out VisitID);
                Int64.TryParse(Request.QueryString["pid"], out PatientID);
                if (PhysioCount > 0)
                {
                    retnCode = patientBL.GetPatientDemoandAddress(PatientID, out lsPatient);
                    patient = lsPatient[0];
                    if (lsPatient.Count > 0)
                    {
                        EmpNo = lsPatient[0].PatientNumber.ToString();
                    }
                    retnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.PerformPhysiotherapy, VisitID, 0,
                           PatientID, patient.TitleName + " " + patient.Name, "", 0, "", 0, "", 0, feeType, out dText,
                           out urlVal, 0, isCorporateOrg == "Y" ? EmpNo : patient.PatientNumber, patient.TokenNumber, "");
                    task.TaskActionID = (int)TaskHelper.TaskAction.PerformPhysiotherapy;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = PatientID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = VisitID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    retnCode = taskBL.CreateTask(task, out physioTaskID);
                    //foreach (var items in lstOrderedPhysiotherapy)
                    //{
                    //    for (int i = 0; i < lstOrderedPhysiotherapy.Count; i++)
                    //    {
                    //        PatientDueChart inValues = new PatientDueChart();
                    //        inValues.FeeID = lstOrderedPhysiotherapy[i].ProcedureID;
                    //        inValues.FeeType = "PRO";
                    //        inValues.Description = lstOrderedPhysiotherapy[i].ProcedureName;
                    //        inValues.DetailsID = physioTaskID;
                    //        inValues.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    //        inValues.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    //        //lstBillingforTask.Add(inValues);
                    //    }
                    //}
                }
            }
            #endregion
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Service Ordered Successfully')", true);
            Response.Redirect("../Dialysis/Home.aspx");
        }
    }

    public long OrderProcedure()
    {
        #region OrderPhysiotherapy
        long returnCodePhysio = -1;        
        if (Request.QueryString["ProcID"] != null)
        {
            Int64.TryParse(Request.QueryString["ProcID"], out procID);
        }
        string ordProc = string.Empty;
        ordProc = hdnAddItems.Value.ToString();
        //if (procID > 0)
        //{
        //    ordProc = hdnAddItems.Value.ToString();
        //}
        //else
        //{
        //    ordProc = hdnNewProc.Value.ToString();
        //}        
        if (ordProc != "")
        {
            string comments = string.Empty;
            List<OrderedPhysiotherapy> lstOrderPhysiotherapy = new List<OrderedPhysiotherapy>();
            foreach (string physioItem in ordProc.Split('^'))
            {
                if (physioItem != "")
                {
                    OrderedPhysiotherapy ptt = new OrderedPhysiotherapy();
                    ptt.ProcedureID = Convert.ToInt64(physioItem.Split('~')[0]);
                    ptt.ProcedureName = physioItem.Split('~')[1].ToString();
                    ptt.OdreredQty = Convert.ToDecimal(physioItem.Split('~')[2]);
                    ptt.Status = "InProgress";
                    ptt.PaymentStatus = "";
                    ptt.PhysicianComments = txtComments.Text;
                    lstOrderPhysiotherapy.Add(ptt);
                }
            }
            if (lstOrderPhysiotherapy.Count > 0)
            {
                string orderBy = string.Empty;
                int tmp = Convert.ToInt32(hdnOnlyOrderProc.Value);
                if (tmp == 0)
                {
                    orderBy = "ORDPHYSIO";
                }
                else
                {
                    orderBy = "";
                }
                Int64.TryParse(Request.QueryString["vid"], out VisitID);
                returnCodePhysio = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(VisitID, ILocationID, OrgID, LID, orderBy, lstOrderPhysiotherapy, out PhysioCount);
                        
            }            
        }
        hdnOrdered.Value = "";
        hdnAddItems.Value = "";
        return returnCodePhysio;
        #endregion
    }


    //protected void gvPPDT_RowCommand(object sender, GridViewCommandEventArgs e)
    //{
    //    if (e.CommandName == "OEdit")
    //    {
    //        long PatientPhysioDtlID = 0;
    //        int RowIndex = Convert.ToInt32(e.CommandArgument);
    //        PatientPhysioDtlID = Convert.ToInt64(gvPPDT.DataKeys[RowIndex][0]);
    //        hdnPatientPhysioDtlID.Value = PatientPhysioDtlID.ToString();

    //        objPatient_BL = new Patient_BL(base.ContextInfo);
    //        lsPatientPhysioDetails = new List<PatientPhysioDetails>();
    //        lstPhysioCompliant = new List<PhysioCompliant>();
    //        lstOrderedPhysiotherapy = new List<OrderedPhysiotherapy>();
    //        objPatient_BL.GetPatientPhysioDetailByProcID(PatientPhysioDtlID, out lsPatientPhysioDetails, out lstPhysioCompliant, out lstOrderedPhysiotherapy);
    //        // hdnDiagnosisItems.Value = "";
    //        ComplaintICDCode1.ComplaintHeader = "Clinical Diagnosis";



    //        if (lstPhysioCompliant.Count > 0)
    //        {
    //            ComplaintICDCode1.SetPhysioComplaint(lstPhysioCompliant);

    //            //int i = 220;
    //            //foreach (PhysioCompliant objPC in lstPhysioCompliant)
    //            //{
    //            //    hdnDiagnosisItems.Value += i + "~" + objPC.ComplaintName +"~"+objPC.ComplaintID+ "^";
    //            //    i += 1;
    //            //}

    //        }

    //        //     ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  LoadDiagnosisItems();", true);

    //        if (lstOrderedPhysiotherapy.Count > 0)
    //        {
    //            ddlPhysio.DataSource = null;
    //            ddlPhysio.DataSource = lstOrderedPhysiotherapy;
    //            ddlPhysio.DataBind();
    //        }

    //        if (lsPatientPhysioDetails.Count > 0)
    //        {

    //            btnFinish.Text = "Update";
    //            AddMore.Visible = false;
    //            ddlPhysio.SelectedValue = lsPatientPhysioDetails[0].ProcedureID.ToString();
    //            ddlPhysio.SelectedItem.Text = lsPatientPhysioDetails[0].ProcedureName.ToString();
    //            ddlPhysio.Enabled = false;
    //            txtAdVNoSitting.Text = lsPatientPhysioDetails[0].AdvisedNoOfSitting.ToString();
    //            txtCurrentNoSitting.Text = lsPatientPhysioDetails[0].CurrentNoOfSitting.ToString();
    //            txtDutation.Text = lsPatientPhysioDetails[0].DurationValue.ToString();
    //            ddlDurationUnits.SelectedItem.Text = lsPatientPhysioDetails[0].DurationUnits.ToString();
    //            if (lsPatientPhysioDetails[0].ScoreCardValue != 0)
    //            {
    //                txtSCV.Text = lsPatientPhysioDetails[0].ScoreCardValue.ToString();
    //            }
    //            // ddlSCU.SelectedItem.Text = lsPatientPhysioDetails[0].ScoreCardUnit.ToString();
    //            txtRemarks.Text = lsPatientPhysioDetails[0].Remarks;

    //            if (lsPatientPhysioDetails[0].HasPending == "Y")
    //            {
    //                chkPendingSitting.Visible = true;
    //                chkPendingSitting.Checked = true;
    //            }
    //            else
    //            {
    //                chkPendingSitting.Visible = false;
    //                chkPendingSitting.Checked = false;
    //                txtAdVNoSitting.Enabled = false;
    //            }

    //            if ((lsPatientPhysioDetails[0].NextReview != "") && (lsPatientPhysioDetails[0].NextReview != null))
    //            {
    //                if (lsPatientPhysioDetails[0].NextReview.Contains(":") || lsPatientPhysioDetails[0].NextReview.Contains("/"))
    //                {
    //                    txtNextReviewDate.Text = lsPatientPhysioDetails[0].NextReview;
    //                }
    //                else
    //                {
    //                    string NextReview = string.Empty;
    //                    string NextReviewNos = string.Empty;
    //                    string NextReviewDMY = string.Empty;
    //                    string[] nReview;

    //                    NextReview = lsPatientPhysioDetails[0].NextReview;
    //                    nReview = NextReview.Split('-');
    //                    if (nReview.Length > 0)
    //                    {
    //                        NextReviewNos = nReview[0].ToString();
    //                        NextReviewDMY = nReview[1].ToString();
    //                        ddlNos.SelectedValue = NextReviewNos;
    //                        ddlDMY.SelectedValue = NextReviewDMY;
    //                    }
    //                }
    //            }


    //        }




    //    }
    //}

   
}
