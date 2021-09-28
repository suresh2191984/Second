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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Xml;
using System.Linq;
using Attune.Podium.BillingEngine;

public partial class Reception_InPatientRegistration : BasePage
{
    # region DeclarationRegion
    public string donation = string.Empty;
    long patientID = -1;
    long VisitID = -1;
    long returnCode = -1;
    int count = 0;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
     
    long PrimaryConID = 0;
    long SurgeonID = 0;
    long DutyOfficesID = 0;


    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
//    string IsCreditBill = string.Empty;

    List<PrimaryConsultant> lstPrimaryConsultant = new List<PrimaryConsultant>();
    InPatientAdmissionDetails Inpatient = new InPatientAdmissionDetails();
    string NeedCreditLimt = string.Empty;
    # endregion
  

     public Reception_InPatientRegistration()
        : base("Reception\\InPatientRegistration.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    TextBox accompany;
    TextBox txtAddress;
    DropDownList ddlRelationship;
    TextBox relContactNo;

   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            accompany = (TextBox)ucAttenderDetails.FindControl("txtATTName");
            txtAddress = (TextBox)ucAttenderDetails.FindControl("txtAddress");
            ddlRelationship = (DropDownList)ucAttenderDetails.FindControl("ddlRelation");
            relContactNo = (TextBox)ucAttenderDetails.FindControl("txtContactNo");

            //emergencyContactNo.Attributes.Add("onKeyDown", "return validatenumber(event);");
            relContactNo.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");
            btnFinish.Visible = true; btnPrint.Visible = true;
            btnUpdate.Visible = true;
            string IsCreditPatient = Request.QueryString["IsCreditPatient"];
            AutoGname1.ContextKey = OrgID.ToString();
            NeedCreditLimt = GetConfigValue("CreditLimitForIP", OrgID);

            if (NeedCreditLimt != "" && NeedCreditLimt == "Y")
            {
                trCreditLimit.Style.Add("display", "block");
            }
            if (!IsPostBack)
            {
                LoadDropDown();
                btnFinish.Enabled = true;
                btnPrint.Enabled = true;
                btnUpdate.Enabled = true;
                CheckRegFeeCollected();
                Panel3.Style.Add("display", "none");
              //  organDIV.Style.Add("display", "none");
              //  gridTab.Style.Add("display", "none");
                LoadPurposeOfAdmission();
                LoadConditionOnAdmission();
                // LoadPhysicians();
                LoadSpecialityName();
                LoadOrgan();
                LoadMetaData();
                // LoadRelationship();
                LoadKnowledgeOfService();
            

            //    InPatientAdmissionDetails Inpatient = new InPatientAdmissionDetails();
                accompany.Text = Inpatient.AccompaniedBy;
                txtAddress.Text = Inpatient.Address;
                relContactNo.Text = Inpatient.RelationContactNo;
                //emergencyContactNo.Text = Inpatient.ContactNo;
                txtAdmissionDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
               // txtAdmissionDate.Text = Inpatient.AdmissionDate.ToString();
           
                if (Request.QueryString["PID"] != null)
                {
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    PopulateAdmissionPatientDetails(patientID);
                     // TPA User control Populating Data
                    //if (accompany.Text == string.Empty && relContactNo.Text == string.Empty && emergencyContactNo.Text == string.Empty)
                    //{
                    //    btnFinish.Visible = true; btnPrint.Visible = true;
                    //    btnUpdate.Visible = false;
                    //    //btnFinish.Style.Add("display", "block");
                    //    //btnUpdate.Style.Add("display", "none");
                    //}
                    if (Inpatient.AdmissionDate==DateTime.MaxValue)
                    {
                        btnFinish.Visible = true; btnPrint.Visible = true;
                        btnUpdate.Visible = false;
                        //btnFinish.Style.Add("display", "block");
                        //btnUpdate.Style.Add("display", "none");
                    }
                    else
                    {
                        btnFinish.Visible = false; btnPrint.Visible = false;
                        btnUpdate.Visible = true;
                        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();

                        //Set referring phy name and speciality to the ref phy control
                        //Venkat
                        //long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);
                        //if(lstPatientVisit.Count > 0)
                        //{
                        //    RefDoctor.SpecalityID = lstPatientVisit[0].ReferingSpecialityID;
                        //    RefDoctor.RefferringPhysicianID = lstPatientVisit[0].ReferingPhysicianID;
                        //}
                        //btnFinish.Style.Add("display", "none");
                        //btnUpdate.Style.Add("display", "block");
                    }
                }

                // code added for registration fee collection - begin
                
                string regFees = string.Empty;
                decimal decimalAmt = 0;
                regFees = GetConfigValue("IpRegistrationFees", OrgID);
                if (regFees != "")
                {
                    decimal.TryParse(regFees, out decimalAmt);
                }
                else { txtRegFee.Text = string.Format("{0:0.00}", decimalAmt); }
                txtRegFee.Text = string.Format("{0:0.00}", decimalAmt);
                rdoPayNow.Attributes.Add("OnClick", "ShowPaymentType()");
                rdoPayLater.Attributes.Add("OnClick", "HidePaymentType()");
                // code added for registration fee collection - ends

                if (RoleName != "Super Admin")
                {
                    txtApprovedBy.Enabled = false;
                    txtCreditLimt.Enabled = false;
                    chkCreditLimit.Enabled = false;
                }
                string SurgeryFlow = GetConfigValue("SurgeryBilling", OrgID);
                if (SurgeryFlow != "Y")
                    trIsSurgeryPatient.Style.Add("display", "none");

            }
            if (IsPostBack)
            {
                CheckRegFeeCollected();
               
            if (Convert.ToInt32(regForOrgan.SelectedValue) == 1)
                {
                    organDIV.Style.Add("display", "block");
                    gridTab.Style.Add("display", "block");
                }
                 
            }
        }
        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in Admission PatientRegistration: Page_Load", ex);
        }
    }

    private void PopulateAdmissionPatientDetails(long patientID)
    {
        Patient_BL pBL = new Patient_BL(base.ContextInfo);
        IP_BL ipBL = new IP_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        List<InPatientAdmissionDetails> lstpatients = new List<InPatientAdmissionDetails>();
        List<PatientEmployer> lstEmp = new List<PatientEmployer>();
        List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
        //InPatientAdmissionDetails Inpatient = new InPatientAdmissionDetails();
        PatientEmployer pEmp = new PatientEmployer();
        List<OrganRegWithMapping> lstOrgRegWithMapping = new List<OrganRegWithMapping>();
        List<Patient> patientDetails = new List<Patient>();
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        //long patientVisitID
        try
        {
            Int64.TryParse(Request.QueryString["VID"], out VisitID);
            pBL.GetAdmissionPatientDemoandAddress(patientID, VisitID, "", out lstpatients, out lstEmp, out lstRTAMLCDetails, out patientDetails, out lstVisitClientMapping);
            
            
            
            if (patientDetails.Count > 0)
            {
                relContactNo.Text = patientDetails[0].ContactNo;
            }

            if (lstpatients.Count > 0)
            {
                Inpatient = lstpatients[0];
                

                //if (lstpatients[0].TPAAttributes != string.Empty)
                //{
                //    CreateControl(lstpatients[0].TPAAttributes);
                //}
                if (Request.QueryString["PID"] != null)
                {
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    txtPatientNo.Text = patientID.ToString();
                }
                if (Request.QueryString["VID"] != null)
                {
                    Int64.TryParse(Request.QueryString["VID"], out VisitID);
                    ipBL.GetIPVisitDetails(VisitID, out lstPatientVisit);
                    
                    
                }
                if (lstPatientVisit.Count > 0)
                {
                    if (lstPatientVisit[0].RoomTypeID > 0)
                    {
                        uctlClientTpa.RoomType = lstPatientVisit[0].RoomTypeID.ToString();
                    }
                    hdnOldRoomValue.Value = lstPatientVisit[0].RoomTypeID.ToString();
                    uctlClientTpa.LoadClientValue();

                    if (lstPatientVisit[0].CreditLimit > 0 && NeedCreditLimt == "Y")
                    {
                        chkCreditLimit.Checked = true;
                        trApproved.Style.Add("display", "block");
                        txtApprovedBy.Text = lstPatientVisit[0].Status;
                        txtCreditLimt.Text = lstPatientVisit[0].CreditLimit.ToString("0.00");
                        txtCreditRemarks.Text = lstPatientVisit[0].Remarks;
                        hdnOldCreditLimitAmount.Value = lstPatientVisit[0].CreditLimit.ToString("0.00");
                        if (RoleName != "Super Admin")
                        {
                            txtApprovedBy.Enabled = false;
                            txtCreditLimt.Enabled = false;
                            chkCreditLimit.Enabled = false;
                            txtCreditRemarks.Enabled = false;
                        }
                    }
                    if (lstPatientVisit[0].IsSurgeryPatient == "Y")
                    {
                        rblSurgeryPatient.SelectedIndex = 0;
                        rblSurgeryPatient.Enabled = false;
                    }
                    else
                        rblSurgeryPatient.SelectedIndex = 1;
                }

                accompany.Text = Inpatient.AccompaniedBy;
                txtAddress.Text = Inpatient.Address;
                ddlRelationship.SelectedValue = Inpatient.RelationshipID.ToString();
                relContactNo.Text = Inpatient.ContactNo;
                //emergencyContactNo.Text = Inpatient.RelationContactNo;
                txtAdmissionDate.Text = Inpatient.AdmissionDate.ToString();
                //if (medicallyInsured. == 0)
                //Inpatient.MedicallyInsured;
                //Inpatient.OrganDonation;
                purposeOfAdmission.SelectedValue = Inpatient.PurposeOfAdmissionID.ToString();
                ctndOnAdmission.SelectedValue = Inpatient.ConditionOnAdmissionID.ToString();
                //primaryPhysician.SelectedValue = Inpatient.PrimaryPhysicianID.ToString();             

                if (Inpatient.PrimaryPhysicianName != null)
                {
                    hdnPC.Value = Inpatient.PrimaryPhysicianName;
                    string[] pID = Inpatient.PrimaryPhysicianName.Split('~');
                    txtPrimaryCons.Text = pID[1].ToString();
                }


                speciality.SelectedValue = Inpatient.SpecialityID.ToString();
                // consultingSurgeon.SelectedValue = Inpatient.ConsultingSurgeonID.ToString();

                if (Inpatient.ConsultingSurgeonName != null)
                {
                    hdnCS.Value = Inpatient.ConsultingSurgeonName;
                    string[] SID = Inpatient.ConsultingSurgeonName.Split('~');
                    txtSurgen.Text = SID[1].ToString();
                }

                if (Inpatient.DutyOfficer != null)
                {
                    hdnDO.Value = Inpatient.DutyOfficer;
                    string[] DID = Inpatient.DutyOfficer.Split('~');
                    txtDutyOfficer.Text = DID[1].ToString();
                }




                ourService.SelectedValue = Inpatient.KnowledgeOfServiceID.ToString();
                name.Text = Inpatient.ServiceProviderName;
                informationBy.Text = Inpatient.InformationBy;


             





                BillingEngine be = new BillingEngine(base.ContextInfo);
                
                string IsCreditBill = string.Empty;
                be.CheckIsCreditBill(VisitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);
                hdnGrossAmt.Value = GrossBillAmount.ToString("0.00");

                uctlClientTpa.IsCreditBill = IsCreditBill;
                 
                if (lstEmp.Count > 0)
                {
                    chkPED.Checked = true;
                    trPED.Style.Add("display", "block");
                    pEmp = lstEmp[0];
                    txtEmployerName.Text = pEmp.EmployerName;
                    txtEmployeeName.Text = pEmp.EmployeeName;
                    txtEmployeeNo.Text = pEmp.EmployeeNo;
                    ((TextBox)employerAddress.FindControl("txtAddress1")).Text = pEmp.Add1;
                    ((TextBox)employerAddress.FindControl("txtAddress2")).Text = pEmp.Add2;
                    ((TextBox)employerAddress.FindControl("txtAddress3")).Text = pEmp.Add3;
                    ((TextBox)employerAddress.FindControl("txtCity")).Text = pEmp.City;
                    ((DropDownList)employerAddress.FindControl("ddCountry")).SelectedValue = pEmp.CountryID.ToString();
                    ((DropDownList)employerAddress.FindControl("ddState")).SelectedValue = pEmp.StateID.ToString();
                    ((TextBox)employerAddress.FindControl("txtPostalCode")).Text = pEmp.PostalCode;
                    ((TextBox)employerAddress.FindControl("txtMobile")).Text = pEmp.MobileNumber;
                    ((TextBox)employerAddress.FindControl("txtLandLine")).Text = pEmp.LandLineNumber;
                }
              


                if (lstRTAMLCDetails.Count > 0)
                {
                    trRTABlock.Style.Add("display", "block");
                    chkRTA.Checked = true;
                    foreach (RTAMLCDetails objRTAMLC in lstRTAMLCDetails)
                    {
                        if (objRTAMLC.AlcoholDrugInfluence == "Y")
                        {
                            chkRTAInfluenceOfDrugs.Checked = true;
                        }
                        if (objRTAMLC.RTAMLCDate != null)
                        {
                            txtRTADate.Text = objRTAMLC.RTAMLCDate.ToString();
                        }
                        if (objRTAMLC.FIRDate != DateTime.MinValue)
                        {
                            txtFIRDate.Text = objRTAMLC.FIRDate.ToString();
                        }
                        txtRTAFIRNo.Text = objRTAMLC.FIRNo;
                        txtRTALocation.Text = objRTAMLC.Location;
                        txtPoliceStation.Text = objRTAMLC.PoliceStation;
                        txtMLCNo.Text = objRTAMLC.MLCNo;
                    }
                }
            }

            ipBL.GetIPOrganDonation(patientID, out lstOrgRegWithMapping);
            if (lstOrgRegWithMapping.Count > 0)
            {
                int i = 1;
                foreach (OrganRegWithMapping objORWMapping in lstOrgRegWithMapping)
                {
                    donation += "RID^" + i + "~OrgN^" + objORWMapping.OrganName + "~OrgC^" + objORWMapping.OrganRegWith + "~OrgNID^" + objORWMapping.OrganID + "~OrgCID^" + objORWMapping.OrganRegWith + "|";
                    i += 1;
                }
                BuildTable();
                ViewState["pre"] = donation;
                organDIV.Style.Add("display", "block");
                gridTab.Style.Add("display", "block");
                regForOrgan.SelectedValue = "1";
            }
            //Newly Add for Binding Primary consultant Details -sami
            pBL.GetPrimaryConsultant(VisitID, 0, out lstPrimaryConsultant);
            if (lstPrimaryConsultant.Count > 0)
            {
                trPC.Style.Add("Display", "block");
                int i = 320;
                hdnPCItems.Value = "";
                foreach (PrimaryConsultant objPC in lstPrimaryConsultant)
                {
                    hdnPCItems.Value += i + "~" + objPC.PrimaryConsultantID + "~" + objPC.PhysicianName + "^";
                    i += 1;
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing Populate Admission PatientDetails", ex);
        }
    }


    public void StoreDueChart()
    {
        if (Request.QueryString["VID"] != null)
        {
            VisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string status = "";
        status = "Pending";

        List<PatientDueChart> lstPatientConsultation = new List<PatientDueChart>();
        List<PatientDueChart> lstPatientProcedure = new List<PatientDueChart>();
        List<PatientDueChart> lstPatientIndents = new List<PatientDueChart>();
        List<PatientDueChart> lstPatientSurgical = new List<PatientDueChart>();
        List<PatientDueChart> lstPatientGenItems = new List<PatientDueChart>();
        List<PatientDueChart> lstSurgergicalPkg = new List<PatientDueChart>();
        List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();//List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>(); 
        List<DHEBAdder> lstOthers = new List<DHEBAdder>();
        List<DHEBAdder> lstDhebAdder = new List<DHEBAdder>();
        PatientVisit_BL objPatientVisit = new PatientVisit_BL(base.ContextInfo);


        //lstPatientGenItems = dspData.GetConsNProDetails();



        PatientDueChart pdTemp = new PatientDueChart();
        pdTemp.FeeID = -1;
        pdTemp.DetailsID = 0;
        pdTemp.Description = "IP REGISTRATION";
        pdTemp.Amount = Convert.ToDecimal(txtRegFee.Text);
        pdTemp.Unit = 1;
        pdTemp.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        pdTemp.FromDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        pdTemp.ToDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        pdTemp.FeeType = "REG";
        lstPatientConsultation.Add(pdTemp);



      



        List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();


        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();

        if (orderedInvesHL.Count == 0)
        {
            string InterimBillNo = string.Empty;
            objPatientVisit.InsertPatientIndents(lstSurgergicalPkg, orderedInvesHL, lstPatientConsultation, lstPatientProcedure, lstPatientIndents, lstDhebAdder, VisitID, LID, patientID, out InterimBillNo);

        }


    }
    private void PayRegFeeLater()
    {
        try
        {
            StoreDueChart();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Due Clearance", ex);
        }
    }

    private void PayRegFeeNow(bool PrintReceipt)
    {

        if (Request.QueryString["VID"] != null)
        {
            VisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }

        long patientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string sPatientName = "";
        if (Request.QueryString["PNAME"] != null)
        {
            sPatientName = Request.QueryString["PNAME"].ToString() == "" ? "" : Request.QueryString["PNAME"].ToString();
        }
        string status = "";
        status = "Pending";
        try
        {

            StoreDueChart();
            List<Patient> lstPatientDetail = new List<Patient>();
            List<Organization> lstOrganization = new List<Organization>();
            List<Physician> physicianName = new List<Physician>();
            List<Taxmaster> lstTaxes = new List<Taxmaster>();
            List<FinalBill> lstFinalBill = new List<FinalBill>();

             
            List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
            List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();

            decimal FinalAmount = 0;
            string sPaymentType = "";

            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
              

           
            string isCreditBill = string.Empty;

            isCreditBill = uctlClientTpa.IsCreditBill;
             
            



            decimal pAmtReceived = Convert.ToDecimal(hdnNowPaid.Value.ToString());
            decimal pAdvanceReceived = 0;
            decimal pPreviousDue = 0;
            decimal PreviousAmountReceived = 0;
            decimal pAmountReceived = pAmtReceived + PreviousAmountReceived;

            decimal pRefundAmount = 0;
 

            decimal pDiscountAmount = 0;
            decimal pDue = 0;
            if (pAmountReceived == FinalAmount)
            {
                pDue = 0;
            }
            else
            {
                pDue = FinalAmount - pAmountReceived;
            }

            decimal pGrossBillValue = (FinalAmount + pPreviousDue) -
                (pDiscountAmount + pAdvanceReceived);
            decimal dServiceCharge = 0;
            dServiceCharge += Convert.ToDecimal("0.00");
            decimal pnetValue = FinalAmount + dServiceCharge - pDiscountAmount;

            System.Data.DataTable dtAmtReceivedDetails = new System.Data.DataTable();
            dtAmtReceivedDetails = PaymentTypes.GetAmountReceivedDetails();

            //lstPatientDueChart = new List<PatientDueChart>();
            string PayerType = string.Empty;
            string TPAPaymentStatus = string.Empty;
            PayerType = "Patient";
            TPAPaymentStatus = "Pending";
            string ReceiptNo = string.Empty;
            long IpIntermediateID = 0;
            string sType = "";
            new PatientVisit_BL(base.ContextInfo).InsertPatientBillItemsDetails(lstPatientDueChart, VisitID, LID, OrgID,
                                                                    pAmountReceived, pRefundAmount,
                                                                    pDiscountAmount, pDue,
                                                                    pGrossBillValue, isCreditBill,
                                                                    pnetValue, pAdvanceReceived,
                                                                    dtAmtReceivedDetails, pAmtReceived,
                                                                    LID, sPaymentType, ILocationID,
                                                                    dServiceCharge, TPAPaymentStatus,
                                                                    PayerType, out ReceiptNo, out IpIntermediateID,
                                                                    out sType);

            //Response.Redirect("~/InPatient/IPCashReceipt.aspx?VID=" + visitID + "&PID=" + patientID);

            rdoPayLater.Enabled = false;
            rdoPayNow.Enabled = false;
            btnPrintReceipt.Enabled = false;
            //trREGFeePayType.Visible = false;

            hdnRegFeeStatus.Value = "Paid" + "~" + Convert.ToDateTime(new BasePage().OrgDateTimeZone);

            CheckRegFeeCollected();

            if (PrintReceipt)
            {


                string sPage = @"../InPatient/PrintReceiptPage.aspx?Amount="
                             + pAmtReceived.ToString() + "&dDate="
                             + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                             + "&rcptno=" + ReceiptNo.ToString()
                             + "&PNAME=" + sPatientName
                             + "&PID=" + patientID.ToString()
                             + "&VID=" + VisitID.ToString()
                             + "&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "";
                this.Page.RegisterClientScriptBlock("sky",
                            "<script language='javascript'> window.open('" + sPage + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>");
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Due Clearance", ex);
        }

    
    }

    protected void SaveRegFee(object sender, EventArgs e)
    {
        PayRegFeeNow(true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "sKy1", "ShowPaymentTypeCompleted();", true);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "sKy", "reCreateDoctorTable();", true);
        chkRegFee.Enabled = false;
        rdoPayLater.Enabled = false;
        rdoPayNow.Enabled = false;
        btnPrintReceipt.Enabled = false;
        btnFinish.Focus();
    }

    private void CheckRegFeeCollected()
    {
        string[] RegFeeStatus = hdnRegFeeStatus.Value.Split('~');


        if ((RegFeeStatus[0].ToString() == "Paid"))
        {
            divRegFeePaid.Visible = true;
            lblRegFeeCollectMsg.Text = string.Format("Registration Fee Collected on {0}", RegFeeStatus[1].ToString());

        }
        else
        {
            divRegFeePaid.Visible = false;
            lblRegFeeCollectMsg.Text = "";
        }


         
    }
    
    public string GetConfigValue(string configKey, int orgID)
    {
        
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
        bool RegFeeClear = false;
        decimal decRegFee = 0;
        btnFinish.Enabled = false;
        btnPrint.Visible = false;
        btnCancel.Visible = false;
        if (txtRegFee.Text != "")
        {
            Decimal.TryParse(txtRegFee.Text.ToString(), out decRegFee);
        }
        // code added for Collecting Registration Fee - Begins
        if (chkRegFee.Checked != false && (rdoPayNow.Checked == true || rdoPayLater.Checked == true) && chkRegFee.Enabled == true && decRegFee > 0)
        {
            if (rdoPayLater.Checked)
            {
                PayRegFeeLater();
                RegFeeClear = true;
            }
            else if (rdoPayNow.Checked)
            {
                if(hdnNowPaid.Value != "" && hdnNowPaid.Value != null)
                {
                if (Convert.ToDecimal(hdnNowPaid.Value) == Convert.ToDecimal(txtRegFee.Text))
                {
                    if (hdnRegFeeStatus.Value == "")
                    {
                        PayRegFeeNow(true);
                        RegFeeClear = true;
                    }
                }
                else
                {
                    divRegFeePaid.Visible = true;
                    //lblRegFeeCollectMsg.Text = "<font color='red'>Please Collect Registration Fee or Select PayLater</font>";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "sKy1", "ShowPaymentType();", true);
                }
                }
                else
                {
                    divRegFeePaid.Visible = true;
                    //lblRegFeeCollectMsg.Text = "<font color='red'>Please Collect Registration Fee or Select PayLater</font>";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "sKy2", "ShowPaymentType();", true);
                }
            }
        }
        else { RegFeeClear = true; }
        // code added for Collecting Registration Fee - Ends

        if (RegFeeClear == true)
        {

            try
            {
                long returnCode = 0;
                 long taskID = -1;


                 
                string PolicyNumber = string.Empty;
                string PolicyName = string.Empty;
                 
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["vid"], out VisitID);
                PatientEmployer PEmployer = new PatientEmployer();
                InPatientAdmissionDetails IPDetails = new InPatientAdmissionDetails();
                string employerName = txtEmployerName.Text;
                string employeeName = txtEmployeeName.Text;
                string employeeNo = txtEmployeeNo.Text;
                IPDetails.PatientID = patientID;
                IPDetails.VisitID = VisitID;
                IPDetails.AdmissionDate = Convert.ToDateTime(txtAdmissionDate.Text);
                IPDetails.PurposeOfAdmissionID = Convert.ToInt64(purposeOfAdmission.SelectedValue);
                IPDetails.ConditionOnAdmissionID = Convert.ToInt32(ctndOnAdmission.SelectedValue);
                IPDetails.ContactNo = relContactNo.Text;
                //if (txtPrimaryCons.Text.Trim() != "")
                //{
                //    string[] pID = hdnPC.Value.Split('~');
                //    PrimaryConID = Convert.ToInt64(pID[0].ToString());
                //}

                if (txtSurgen.Text.Trim() != "")
                {
                    string[] sID = hdnCS.Value.Split('~');
                    SurgeonID = Convert.ToInt64(sID[0].ToString());
                }
                if (txtDutyOfficer.Text.Trim() != "")
                {
                    string[] DOID = hdnDO.Value.Split('~');
                    DutyOfficesID = Convert.ToInt64(DOID[0].ToString());
                }
                 
                    IPDetails.MedicallyInsured = Convert.ToBoolean(1);
                  
                IPDetails.PrimaryPhysicianID = PrimaryConID;
                IPDetails.ConsultingSurgeonID = SurgeonID;
                IPDetails.SpecialityID = Convert.ToInt64(speciality.SelectedValue);
                IPDetails.DutyOfficerID = DutyOfficesID;

                IPDetails.OrganDonation = Convert.ToBoolean(Convert.ToInt16(regForOrgan.SelectedValue));
                IPDetails.AccompaniedBy = accompany.Text.Trim();
                IPDetails.Address = txtAddress.Text.Trim();
                IPDetails.RelationshipID = int.Parse(ddlRelationship.SelectedItem.Value);
                IPDetails.RelationshipName = ddlRelationship.SelectedItem.Text;
                IPDetails.RelationContactNo = string.Empty; //emergencyContactNo.Text;
                IPDetails.KnowledgeOfServiceID = Convert.ToInt32(ourService.SelectedValue);
                IPDetails.ServiceProviderName = name.Text;
                IPDetails.InformationBy = informationBy.Text;
                IPDetails.CreatedBy = LID;
                 
                if (Request.QueryString["PID"] != null)
                {
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    IPDetails.PatientID = patientID;
                }

                List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
                RTAMLCDetails objRTAMLC = new RTAMLCDetails();
                objRTAMLC = GetRTAMLCDetails();
                lstPrimaryConsultant = GetPrimaryConsultantDetail();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                if (chkPED.Checked == true)
                {
                    returnCode = employerAddress.GetPatientEmployer(patientID, employerName, employeeName, employeeNo, LID, out PEmployer);
                }
                long refPhyID = ReferDoctor1.GetRefPhyID();
             
                int refSpecalityID = ReferDoctor1.GetSpeciality() == 0 ? -1 : ReferDoctor1.GetSpeciality();
             
                string refDoctorType = ReferDoctor1.GetRefPhyType();
                decimal CreditLimit = txtCreditLimt.Text != "" ? Convert.ToDecimal(txtCreditLimt.Text) : -1;
                string creditLimitApprover = string.Empty;
                string CreditRemarks = string.Empty;
                CreditRemarks = txtCreditRemarks.Text;
                if (txtApprovedBy.Text != "")
                {
                    string[] lineItems = txtApprovedBy.Text.Split('~');
                    creditLimitApprover = lineItems[1];
                }     
                string refDoctorName = refPhyID == 0 ? string.Empty : ReferDoctor1.GetRefPhyName().ToString();
                string IsSurgeryPatient = string.Empty;
                if (rblSurgeryPatient.SelectedItem.Text == "Yes")
                    IsSurgeryPatient = "Y";
                else
                    IsSurgeryPatient = "N";
                List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();
                returnCode = patientBL.SavePatientEmployer(PEmployer, IPDetails,   objRTAMLC, 
                    lstPrimaryConsultant, OrgID,    refPhyID,
                                    refDoctorName, refSpecalityID, refDoctorType, uctlClientTpa.IsCreditBill, CreditLimit, creditLimitApprover,
                                      CreditRemarks, uctlClientTpa.RoomType == "" ? 0 : Convert.ToInt32(uctlClientTpa.RoomType), IsSurgeryPatient, lstVisitClientMapping);
                if (regForOrgan.SelectedValue.ToString() == "1")
                {
                    returnCode = GetDonation(patientID);
                }
                 
                try
                {
                    string vid = "";
                    string sPatientName = "";

                    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                    long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);
                    if (lstPatientVisit.Count > 0)
                    {
                        vid = lstPatientVisit[0].PatientVisitId.ToString();
                        sPatientName = lstPatientVisit[0].Name.ToString();
                    }

                  //  Response.Redirect(@"../InPatient/RoomBooking.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                    Response.Redirect(@"../InPatient/RoomAndBedBooking.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                     
                }
                catch (System.Threading.ThreadAbortException tex)
                {
                    string te = tex.ToString();
                    btnFinish.Visible = true;
                    btnFinish.Enabled = true;
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
                    btnFinish.Visible = true;
                    btnFinish.Enabled = true;
                }



            }

            catch (System.Threading.ThreadAbortException tae)
            {
                string exep = tae.ToString();
                btnFinish.Visible = true;
                btnFinish.Enabled = true;

            }
            catch (Exception ex)
            {
                btnFinish.Visible = true;
                btnFinish.Enabled = true;
                CLogger.LogError("Error While Saving InPatient Registration Details.", ex);
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";

            }


        }
    }

    private List<PrimaryConsultant> GetPrimaryConsultantDetail()
    {
        List<PrimaryConsultant> lstPrimaryConsultantTemp = new List<PrimaryConsultant>();

        foreach (string lstPC in hdnPCItems.Value.Split('^'))
        {
            if (lstPC != "")
            {
                PrimaryConsultant objPrimaryConsultant = new PrimaryConsultant();
                string[] lstChildData = lstPC.Split('~');
                objPrimaryConsultant.PrimaryConsultantID = Convert.ToInt16(lstChildData[1]);
                objPrimaryConsultant.PhysicianName = lstChildData[2];
                lstPrimaryConsultantTemp.Add(objPrimaryConsultant);
            }
        }
        return lstPrimaryConsultantTemp;

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = 0;
            Int64.TryParse(Request.QueryString["pid"], out patientID);
            Int64.TryParse(Request.QueryString["vid"], out VisitID);
            string PolicyNumber = string.Empty;
            string PolicyName = string.Empty;
            string lsClientValidation = string.Empty;
            string SplitEligibleRateType = string.Empty;

            btnUpdate.Enabled = false;
        
            SplitEligibleRateType = GetConfigValue("SplitEligibleRoomRateType", OrgID);
            
            int oldRoomTypeID = Convert.ToInt32(hdnOldRoomValue.Value);
            int newRoomTypeID = uctlClientTpa.RoomType == "" ? 0 : Convert.ToInt32(uctlClientTpa.RoomType);

            SplitEligibleRateType = GetConfigValue("SplitEligibleRoomRateType", OrgID);

            if (SplitEligibleRateType == "Y")
            {
                if (oldRoomTypeID != newRoomTypeID)
                {
                    lsClientValidation = "Y";
                }
                if (uctlClientTpa.ClientStatus == "Y")
                {
                    lsClientValidation = "Y";
                }
            }
            else
            {
                lsClientValidation = "N";
            }
            PatientEmployer PEmployer = new PatientEmployer();
            InPatientAdmissionDetails IPDetails = new InPatientAdmissionDetails();
            string employerName = txtEmployerName.Text;
            string employeeName = txtEmployeeName.Text;
            string employeeNo = txtEmployeeNo.Text;
            IPDetails.PatientID = patientID;
            IPDetails.VisitID = VisitID;
            IPDetails.AdmissionDate = Convert.ToDateTime(txtAdmissionDate.Text);
            IPDetails.PurposeOfAdmissionID = Convert.ToInt64(purposeOfAdmission.SelectedValue);
            IPDetails.ConditionOnAdmissionID = Convert.ToInt32(ctndOnAdmission.SelectedValue);
            IPDetails.ContactNo = relContactNo.Text;
             

            if (txtSurgen.Text.Trim() != "")
            {
                string[] sID = hdnCS.Value.Split('~');
                SurgeonID = Convert.ToInt64(sID[0].ToString());
            }
            if (txtDutyOfficer.Text.Trim() != "")
            {
                string[] DOID = hdnDO.Value.Split('~');
                DutyOfficesID = Convert.ToInt64(DOID[0].ToString());
            }
            IPDetails.PrimaryPhysicianID = PrimaryConID;
            IPDetails.ConsultingSurgeonID = SurgeonID;
            IPDetails.DutyOfficerID = DutyOfficesID;
            IPDetails.SpecialityID = Convert.ToInt64(speciality.SelectedValue);
             
                IPDetails.MedicallyInsured = Convert.ToBoolean(1);
            
            IPDetails.OrganDonation = Convert.ToBoolean(Convert.ToInt16(regForOrgan.SelectedValue));
            IPDetails.AccompaniedBy = accompany.Text.Trim();
            IPDetails.Address = txtAddress.Text.Trim();
            IPDetails.RelationshipID = int.Parse(ddlRelationship.SelectedItem.Value);
            IPDetails.RelationshipName = ddlRelationship.SelectedItem.Text;
            IPDetails.RelationContactNo = string.Empty; //emergencyContactNo.Text;
            IPDetails.KnowledgeOfServiceID = Convert.ToInt32(ourService.SelectedValue);
            IPDetails.ServiceProviderName = name.Text;
            IPDetails.InformationBy = informationBy.Text;
            IPDetails.CreatedBy = LID;
             
            if (Request.QueryString["PID"] != null)
            {
                Int64.TryParse(Request.QueryString["PID"], out patientID);
                IPDetails.PatientID = patientID;
            }
             
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);

            List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
            RTAMLCDetails objRTAMLC = new RTAMLCDetails();
            objRTAMLC = GetRTAMLCDetails();

             
            lstPrimaryConsultant = GetPrimaryConsultantDetail();
            if (chkPED.Checked == true)
            {
                returnCode = employerAddress.GetPatientEmployer(patientID, employerName, employeeName, employeeNo, LID, out PEmployer);
            }
            //long refPhyID = RefDoctor.GetRefPhyID();//Commented to remove refphy
            long refPhyID = ReferDoctor1.GetRefPhyID();
            //int refSpecalityID = RefDoctor.GetSpeciality();//Commented to remove refphy
            int refSpecalityID = ReferDoctor1.GetSpeciality() == 0 ? -1 : ReferDoctor1.GetSpeciality();
            //string refDoctorName = refPhyID == 0 ? string.Empty : RefDoctor.RefferingPhyName;// Commented to remove refphy
            string refDoctorName = refPhyID == 0 ? string.Empty : ReferDoctor1.GetRefPhyName().ToString();
            string refDoctorType = ReferDoctor1.GetRefPhyType();
            decimal CreditLimit = txtCreditLimt.Text != "" ? Convert.ToDecimal(txtCreditLimt.Text) : -1;
            string creditLimitApprover = string.Empty;
            string CreditRemarks = string.Empty;
            CreditRemarks = txtCreditRemarks.Text;
            if (txtApprovedBy.Text != "")
            {
                string[] lineItems = txtApprovedBy.Text.Split('~');
                creditLimitApprover = lineItems[1];
            }
            string IsSurgeryPatient = string.Empty;
            if (rblSurgeryPatient.SelectedItem.Text == "Yes")
                IsSurgeryPatient = "Y";
            else
                IsSurgeryPatient = "N";
            List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();

            if (lsClientValidation == "Y")
            {
                Session["VisitClientMapping"] = lstVisitClientMapping;

                List<VisitClientMapping> lstoldVisitClientMapping = uctlClientTpa.GetClientValues(uctlClientTpa.OldClientValue);

                returnCode = patientBL.UpdatePatientEmployer(PEmployer, IPDetails, objRTAMLC, lstPrimaryConsultant, OrgID, uctlClientTpa.IsCreditBill,
                                                          refPhyID, refDoctorName,
                                                         refSpecalityID, refDoctorType, CreditLimit, creditLimitApprover, CreditRemarks,
                                                                    oldRoomTypeID, IsSurgeryPatient, lstoldVisitClientMapping);
            }
            else
            {

                returnCode = patientBL.UpdatePatientEmployer(PEmployer, IPDetails, objRTAMLC, lstPrimaryConsultant, OrgID, uctlClientTpa.IsCreditBill,
                                                             refPhyID, refDoctorName,
                                                            refSpecalityID, refDoctorType, CreditLimit, creditLimitApprover, CreditRemarks,
                                                                       uctlClientTpa.RoomType == "" ? 0 : Convert.ToInt32(uctlClientTpa.RoomType), IsSurgeryPatient, lstVisitClientMapping);
            }
            returnCode = GetDonation(patientID);
            try
            {
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                if (returnCode == 0)
                {
                    if (lsClientValidation == "Y")
                    {
                        Response.Redirect("../InPatient/IPBillSettlement.aspx?PID=" + IPDetails.PatientID.ToString() + "&VID=" + IPDetails.VisitID.ToString() + "&vType=IP&RoomTypeID=" + newRoomTypeID.ToString());
                    }
                    else
                    {
                        Response.Redirect(Request.ApplicationPath + relPagePath, true);
                    }
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

        catch (System.Threading.ThreadAbortException tae)
        {
            string exep = tae.ToString();
            btnUpdate.Visible = true;
            btnUpdate.Enabled = true;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving InPatient Registration Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";

        }
    }

    public RTAMLCDetails GetRTAMLCDetails()
    {
        RTAMLCDetails objRTAMLCDetails = new RTAMLCDetails();
        if (chkRTA.Checked == true)
        {

            if (chkRTAInfluenceOfDrugs.Checked)
            {
                objRTAMLCDetails.AlcoholDrugInfluence = "Y";
            }
            else
            {
                objRTAMLCDetails.AlcoholDrugInfluence = "N";
            }
            objRTAMLCDetails.FIRNo = txtRTAFIRNo.Text;
            objRTAMLCDetails.Location = txtRTALocation.Text;
            objRTAMLCDetails.PoliceStation = txtPoliceStation.Text;
            objRTAMLCDetails.MLCNo = txtMLCNo.Text;

            if (txtFIRDate.Text != "")
            {
                objRTAMLCDetails.FIRDate = Convert.ToDateTime(txtFIRDate.Text);
            }
            else
            {
                objRTAMLCDetails.FIRDate = Convert.ToDateTime("01/01/1753");
            }

            if (txtRTADate.Text != "")
            {
                objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime(txtRTADate.Text);
            }
            else
            {
                objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime("01/01/1753");
            }
        }
        else
        {
            objRTAMLCDetails.RTAMLCDate = Convert.ToDateTime("01/01/1753");
            objRTAMLCDetails.FIRDate = Convert.ToDateTime("01/01/1753");
        }

        return objRTAMLCDetails;
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
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
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

    protected void btnOrgan_Click(object sender, EventArgs e)
    {
        string orgRegistered = string.Empty;
        string orgID = string.Empty;
        string regWith = string.Empty;
        string regWithID = string.Empty;
        string dtoRemove = string.Empty;
        dtoRemove = did.Value;
        string newDonation = string.Empty;
        int rowCount = 0;
        if (ViewState["rowCount"] != null)
        {
            Int32.TryParse(ViewState["rowCount"].ToString(), out rowCount);
        }
        rowCount++;

        if (ViewState["pre"] != null)
        {
            donation = ViewState["pre"].ToString();
        }
        if (organsRegistered.SelectedValue != "0")
        {
            if (dtoRemove.Trim().Length > 0)
            {
                foreach (string drow in donation.Split('|'))
                {

                    bool IsDeleted = false;
                    foreach (string s in dtoRemove.Split(','))
                    {
                        if (s != string.Empty && !IsDeleted)
                        {
                            if (drow.Contains("RID^" + s + "~"))
                            {
                                IsDeleted = true;
                            }
                        }
                    }
                    if (!IsDeleted && drow != string.Empty)
                        newDonation += drow + "|";
                }
                donation = string.Empty;
                donation = newDonation;
            }

            did.Value = "";
            orgRegistered = organsRegistered.SelectedItem.Text;
            orgID = organsRegistered.SelectedValue;
            regWith = regWithOrganisation.Text;
            regWithID = regWithOrganisation.Text;


            //if (!donation.Contains("OrgN^" + orgRegistered + "~OrgC^" + regWith))
            if (!donation.Contains("OrgN^" + orgRegistered))
            {
                donation += "RID^" + rowCount.ToString() + "~OrgN^" + orgRegistered + "~OrgC^" + regWith + "~OrgNID^" + orgID + "~OrgCID^" + regWithID + "|";
            }
            ViewState["rowCount"] = rowCount;
            ViewState["pre"] = donation;
        }
        if (donation.Trim().Length > 0)
            BuildTable();

        regWithOrganisation.Text = "";

    }

    public void BuildTable()
    {
        List<TableCell> cells = new List<TableCell>();

        string rid = string.Empty;
        foreach (string drow in donation.Split('|'))
        {
            TableRow row = new TableRow();
            if (drow != string.Empty)
            {
                foreach (string column in drow.Split('~'))
                {
                    cells.Add(AddCell(column, out rid));
                    if (rid != string.Empty)
                        row.Attributes.Add("id", rid);
                }
                foreach (TableCell cell in cells)
                {
                    row.Cells.Add(cell);
                }
                cells.Clear();

                gridTab.Rows.Add(row);
            }
        }
        gridTab.Visible = true;
        count++;

    }

    private TableCell AddCell(string column, out string rid)
    {
        string colName = column.Split('^')[0];
        string colValue = column.Split('^')[1];
        TableCell cell = new TableCell();
        cell.Attributes.Add("align", "center");

        rid = string.Empty;
        switch (colName)
        {
            case "RID":
                HyperLink hLnk = new HyperLink();
                hLnk.ImageUrl = "~/Images/delete.jpg";
                hLnk.NavigateUrl = "javascript:OrganDonationDeleteRow('" + colValue + "','" + did.ClientID + "');";
                //cell.Width = Unit.Pixel(20);
                cell.Width = Unit.Percentage(20);
                rid = colValue;
                cell.Controls.Add(hLnk);
                break;
            case "OrgN":
                cell.Text = colValue;
                cell.Width = Unit.Percentage(40);
                break;
            case "OrgC":
                cell.Text = colValue;
                cell.Width = Unit.Percentage(40);
                break;
            case "OrgNID":
                cell.Text = colValue;
                cell.Width = Unit.Percentage(40);
                cell.Style.Add("display", "none");
                break;
            case "OrgCID":
                cell.Text = colValue;
                cell.Width = Unit.Percentage(40);
                cell.Style.Add("display", "none");
                break;

        };
        return cell;

    }

    public long GetDonation(long patientID)
    {
        long rtn = -1;
        string donation = string.Empty;
        string newDonation = string.Empty;
        string dtoRemove = string.Empty;
        dtoRemove = did.Value;
        List<OrganRegWithMapping> orgMap = new List<OrganRegWithMapping>();
        if (ViewState["pre"] != null)
            donation = ViewState["pre"].ToString();

        if (dtoRemove.Trim().Length > 0)
        {
            foreach (string drow in donation.Split('|'))
            {

                bool IsDeleted = false;
                foreach (string s in dtoRemove.Split(','))
                {
                    if (s != string.Empty && !IsDeleted)
                    {
                        if (drow.Contains("RID^" + s + "~"))
                        {
                            IsDeleted = true;
                        }
                    }
                }
                if (!IsDeleted && drow != string.Empty)
                    newDonation += drow + "|";
            }
            donation = string.Empty;
            donation = newDonation;
        }
        did.Value = "";

        foreach (string row in donation.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                OrganRegWithMapping orgMapp = new OrganRegWithMapping();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    switch (colName)
                    {
                        case "OrgNID":
                            orgMapp.OrganID = Convert.ToInt16(colValue);
                            break;
                        case "OrgCID":
                            orgMapp.OrganRegWith = colValue;
                            break;

                    };
                }
                orgMapp.PatientID = patientID;
                orgMapp.CreatedBy = LID;
                orgMap.Add(orgMapp);
            }
        }

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        rtn = patientBL.SavePatientOrganDonation(orgMap, VisitID);
        return rtn;
    }

    public void LoadPurposeOfAdmission()
    {
        long retCode = -1;
        PatientVisit_BL patBL = new PatientVisit_BL(base.ContextInfo);
        List<PurposeOfAdmission> vPOA = new List<PurposeOfAdmission>();
        retCode = patBL.GetPurposeOfAdmission(OrgID, out vPOA);


        purposeOfAdmission.DataSource = vPOA;
        purposeOfAdmission.DataTextField = "PurposeOfAdmissionName";
        purposeOfAdmission.DataValueField = "PurposeOfAdmissionID";
        purposeOfAdmission.DataBind();
        purposeOfAdmission.Items.Insert(0, "----Select----");
        purposeOfAdmission.Items[0].Value = "0";


    }

    public void LoadConditionOnAdmission()
    {
        long retCode = -1;
        PatientVisit_BL patBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientCondition> vCOA = new List<PatientCondition>();
        retCode = patBL.GetConditionOnAdmission(out vCOA);

        ctndOnAdmission.DataSource = vCOA;
        ctndOnAdmission.DataTextField = "Condition";
        ctndOnAdmission.DataValueField = "ConditionID";
        ctndOnAdmission.DataBind();
        ctndOnAdmission.Items.Insert(0, "-----Select-----");
        ctndOnAdmission.Items[0].Value = "0";
    }

    public void LoadOrgan()
    {
        long retCode = -1;
        PatientVisit_BL patBL = new PatientVisit_BL(base.ContextInfo);
        List<Organ> getOrgan = new List<Organ>();
        retCode = patBL.GetOrgan(out getOrgan);
        if (retCode == 0)
        {
            organsRegistered.DataSource = getOrgan;
            organsRegistered.DataTextField = "OrganName";
            organsRegistered.DataValueField = "OrganID";
            organsRegistered.DataBind();
            organsRegistered.Items.Insert(0, "-----Select-----");
            organsRegistered.Items[0].Value = "0";
        }
    }
     
    public void LoadKnowledgeOfService()
    {
        long retCode = -1;
        PatientVisit_BL patBL = new PatientVisit_BL(base.ContextInfo);
        List<KnowledgeOfService> getKnowledgeOfService = new List<KnowledgeOfService>();
        retCode = patBL.GetKnowledgeOfService(out getKnowledgeOfService);

        if (retCode == 0)
        {
            ourService.DataSource = getKnowledgeOfService;
            ourService.DataTextField = "KnowledgeOfServiceName";
            ourService.DataValueField = "KnowledgeOfServiceID";
            ourService.DataBind();
            ourService.Items.Insert(0, "-----Select-----");
            ourService.Items[0].Value = "0";
        }

    }

    

    public void LoadSpecialityName()
    {

        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);

        speciality.DataSource = lstSpeciality;
        speciality.DataTextField = "SpecialityName";
        speciality.DataValueField = "SpecialityID";
        speciality.DataBind();
        speciality.Items.Insert(0, "-----Select-----");
        speciality.Items[0].Value = "0";
    }

    

    protected void btnPrint_Click(object sender, EventArgs e)
    
    {
        btnPrint.Enabled = false;
        btnFinish.Visible = false;
        btnCancel.Visible = false;
        bool RegFeeClear = false;
        decimal decRegFee = 0;
        if (txtRegFee.Text != "")
        {
            Decimal.TryParse(txtRegFee.Text.ToString(), out decRegFee);
        }

        // code added for Collecting Registration Fee - Begins
        if (chkRegFee.Checked != false && (rdoPayNow.Checked == true || rdoPayLater.Checked == true) && chkRegFee.Enabled == true && chkRegFee.Enabled == true && decRegFee > 0)
        {
                 if (rdoPayLater.Checked)
        {
            PayRegFeeLater();
            RegFeeClear = true;
        }
        else if (rdoPayNow.Checked)
            {
                if(hdnNowPaid.Value != "" && hdnNowPaid.Value != null)
                {
                if (Convert.ToDecimal(hdnNowPaid.Value) == Convert.ToDecimal(txtRegFee.Text))
                {
                    if (hdnRegFeeStatus.Value == "")
                    {
                        PayRegFeeNow(false);
                        RegFeeClear = true;
                    }
                }
                else
                {
                    divRegFeePaid.Visible = true;
                    //lblRegFeeCollectMsg.Text = "<font color='red'>Please Collect Registration Fee or Select PayLater</font>";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "sKy1", "ShowPaymentType();", true);
                }
                }
                else
                {
                    divRegFeePaid.Visible = true;
                    //lblRegFeeCollectMsg.Text = "<font color='red'>Please Collect Registration Fee or Select PayLater</font>";
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "sKy2", "ShowPaymentType();", true);
                }
            }
        }
        else { RegFeeClear = true; }
        // code added for Collecting Registration Fee - Ends
        if (RegFeeClear == true)
        {
          try
            {
                long returnCode = 0;
                long taskID = -1;
                string PolicyNumber = string.Empty;
                string PolicyName = string.Empty;
                decimal TPALimit = 0;

                  
                Int64.TryParse(Request.QueryString["pid"], out patientID);
                Int64.TryParse(Request.QueryString["vid"], out VisitID);
                PatientEmployer PEmployer = new PatientEmployer();
                InPatientAdmissionDetails IPDetails = new InPatientAdmissionDetails();
                string employerName = txtEmployerName.Text;
                string employeeName = txtEmployeeName.Text;
                string employeeNo = txtEmployeeNo.Text;
                IPDetails.PatientID = patientID;
                IPDetails.VisitID = VisitID;
                IPDetails.AdmissionDate = Convert.ToDateTime(txtAdmissionDate.Text);
                IPDetails.PurposeOfAdmissionID = Convert.ToInt64(purposeOfAdmission.SelectedValue);
                IPDetails.ConditionOnAdmissionID = Convert.ToInt32(ctndOnAdmission.SelectedValue);
                IPDetails.ContactNo = relContactNo.Text;

                if (txtPrimaryCons.Text.Trim() != "")
                {
                    string[] pID = hdnPC.Value.Split('~');
                    PrimaryConID = Convert.ToInt64(pID[0].ToString());
                }

                if (txtSurgen.Text.Trim() != "")
                {
                    string[] sID = hdnCS.Value.Split('~');
                    SurgeonID = Convert.ToInt64(sID[0].ToString());
                }
                if (txtDutyOfficer.Text.Trim() != "")
                {
                    string[] DOID = hdnDO.Value.Split('~');
                    DutyOfficesID = Convert.ToInt64(DOID[0].ToString());
                }
                IPDetails.PrimaryPhysicianID = PrimaryConID;
                IPDetails.ConsultingSurgeonID = SurgeonID;
                IPDetails.DutyOfficerID = DutyOfficesID;
                IPDetails.SpecialityID = Convert.ToInt64(speciality.SelectedValue);
                 
                    IPDetails.MedicallyInsured = Convert.ToBoolean(1);
                
                IPDetails.OrganDonation = Convert.ToBoolean(Convert.ToInt16(regForOrgan.SelectedValue));
                IPDetails.AccompaniedBy = accompany.Text.Trim();
                IPDetails.Address = txtAddress.Text.Trim();
                IPDetails.RelationshipID = ddlRelationship.SelectedIndex;
                IPDetails.RelationshipName = ddlRelationship.SelectedItem.Text;
                IPDetails.RelationContactNo = string.Empty; //emergencyContactNo.Text;
                IPDetails.KnowledgeOfServiceID = Convert.ToInt32(ourService.SelectedValue);
                IPDetails.ServiceProviderName = name.Text;
                IPDetails.InformationBy = informationBy.Text;
                IPDetails.CreatedBy = LID;

                if (Request.QueryString["PID"] != null)
                {
                    Int64.TryParse(Request.QueryString["PID"], out patientID);
                    IPDetails.PatientID = patientID;
                }

                 
                 
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                if (chkPED.Checked == true)
                {
                    returnCode = employerAddress.GetPatientEmployer(patientID, employerName, employeeName, employeeNo, LID, out PEmployer);
                }
                 
                List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
                RTAMLCDetails objRTAMLC = new RTAMLCDetails();
                objRTAMLC = GetRTAMLCDetails();
                lstPrimaryConsultant = GetPrimaryConsultantDetail();

                //long refPhyID = RefDoctor.GetRefPhyID();//Commented to remove refphy
                long refPhyID = ReferDoctor1.GetRefPhyID();
                //int refSpecalityID = RefDoctor.GetSpeciality();//Commented to remove refphy 
                int refSpecalityID = ReferDoctor1.GetSpeciality() == 0 ? -1 : ReferDoctor1.GetSpeciality();
                //string refDoctorName = refPhyID == 0 ? string.Empty : RefDoctor.RefferingPhyName;//Commented to remove refphy
                string refDoctorName = refPhyID == 0 ? string.Empty : ReferDoctor1.GetRefPhyName().ToString();
                string refDoctorType = ReferDoctor1.GetRefPhyType();
                decimal CreditLimit = txtCreditLimt.Text != "" ? Convert.ToDecimal(txtCreditLimt.Text) : -1;
                string creditLimitApprover = string.Empty;
                string CreditRemarks = string.Empty;
                CreditRemarks = txtCreditRemarks.Text;
                if (txtApprovedBy.Text != "")
                {
                    string[] lineItems = txtApprovedBy.Text.Split('~');
                    creditLimitApprover = lineItems[1];
                }
                string IsSurgeryPatient = string.Empty;
                if (rblSurgeryPatient.SelectedItem.Text == "Yes")
                    IsSurgeryPatient = "Y";
                else
                    IsSurgeryPatient = "N";
              List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();
                returnCode = patientBL.SavePatientEmployer(PEmployer, IPDetails,  objRTAMLC, lstPrimaryConsultant, OrgID,
                                    refPhyID, refDoctorName, refSpecalityID, refDoctorType, uctlClientTpa.IsCreditBill, CreditLimit, creditLimitApprover, CreditRemarks,
                                    uctlClientTpa.RoomType==""?0 : Convert.ToInt32(uctlClientTpa.RoomType) , IsSurgeryPatient, lstVisitClientMapping);
                if (regForOrgan.SelectedValue.ToString() == "1")
                {
                    returnCode = GetDonation(patientID);
                }

                //// Create Task for Nurse
                //List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                //returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(VisitID, out lstPatientVisitDetails);
                //returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.IPAdmission), VisitID, 0,patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0, "IP", out dText, out urlVal);
                //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.IPAdmission);
                //task.DispTextFiller = dText;
                //task.URLFiller = urlVal;
                //task.RoleID = RoleID;
                //task.OrgID = OrgID;
                //task.PatientVisitID = VisitID;
                //task.PatientID = patientID;
                //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                //task.CreatedBy = LID;
                ////Create task               
                //returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out taskID);
                                
                try
                {
                    string vid = "";
                    string sPatientName = "";

                    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                    long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(patientID, out lstPatientVisit);
                    if (lstPatientVisit.Count > 0)
                    {
                        vid = lstPatientVisit[0].PatientVisitId.ToString();
                        sPatientName = lstPatientVisit[0].Name.ToString();
                    }
                    //hdnURL.Value = Request.ApplicationPath + @"./InPatient/RoomBooking.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&PRINT=Y&vType=" + "IP";
                    //Response.Redirect(@"../InPatient/RoomBooking.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&PRINT=Y&vType=" + "IP", true);

                    hdnURL.Value = Request.ApplicationPath + @"./InPatient/RoomAndBedBooking.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&PRINT=Y&vType=" + "IP";
                    Response.Redirect(@"../InPatient/RoomAndBedBooking.aspx?PID=" + patientID.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&PRINT=Y&vType=" + "IP", true);

                    //Navigation navigation = new Navigation();
                    //Role role = new Role();
                    //role.RoleID = RoleID;
                    //List<Role> userRoles = new List<Role>();
                    //userRoles.Add(role);
                    //string relPagePath = string.Empty;
                    //returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
                    //if (returnCode == 0)
                    //{
                    //    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                    //}
                    System.Text.StringBuilder sb = new System.Text.StringBuilder("");
                    {
                        sb.Append("<script language='JavaScript'>");
                        sb.Append("var ScreenWidth = window.screen.width;");
                        sb.Append("var ScreenHeight = window.screen.height;");
                        sb.Append("var movefromedge = 0;");
                        sb.Append("var WinPop = window.open('printpopup.aspx?pid=" + patientID + "&IP=Y&IsPopup=Y', '', 'toolbar=0,location=0,directories=0,status=0,scrollbars=1,menubar=1,resizable=1,');");
                        //sb.Append("Show('PrintPatientRegistration.aspx');");
                        //hdnURL.Value = hdnURL.Value + "&IP=Y";
                        sb.Append("window.location.href='" + hdnURL.Value + "&IsPopup=Y';");
                        sb.Append("</script>");
                    }

                    Page.RegisterStartupScript("Print", sb.ToString());


                }
                catch (System.Threading.ThreadAbortException tex)
                {
                    string te = tex.ToString();
                    btnPrint.Visible = true;
                    btnPrint.Enabled = true;
                }
                catch (Exception ex)
                {
                    CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
                }
            }

            catch (System.Threading.ThreadAbortException tae)
            {
                string exep = tae.ToString();
                btnPrint.Visible = true;
                btnPrint.Enabled = true;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error While Saving InPatient Registration Details.", ex);
                ErrorDisplay1.ShowError = true;
                ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";

            }
        }
    }

    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ConditionOnAdmission,";
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

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
			returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "ConditionOnAdmission"
                                 select child;
                ctndOnAdmission.DataSource = childItems;
                ctndOnAdmission.DataTextField = "DisplayText";
                ctndOnAdmission.DataValueField = "Code";
                ctndOnAdmission.DataBind();


            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    


    public void LoadDropDown()
    {
        long retCode = -1;
        Patient_BL patBL = new Patient_BL(base.ContextInfo);
        List<RelationshipMaster> lstRel = new List<RelationshipMaster>();
        retCode = patBL.GetRelationshipMaster(OrgID, out lstRel);

        if (retCode == 0)
        {
            ddlRelationship.DataSource = lstRel;
            ddlRelationship.DataTextField = "RelationshipName";
            ddlRelationship.DataValueField = "RelationshipID";
            ddlRelationship.DataBind();
            ddlRelationship.Items.Insert(0, "--Select--");
            ddlRelationship.Items[0].Value = "0";
        }
    }
   
}
