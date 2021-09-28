﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;
using System.IO;
using System.Xml;
using System.Xml.Xsl;

public partial class Billing_GenerateBill : BasePage, System.Web.UI.ICallbackEventHandler
{
    #region DeclarationRegion
    string pPatientNo = string.Empty;
    long patientID = -1;
    long patientVisitID = -1;
    long taskID = -1;
    long FinalBillID = 0;
    string BillNumber = string.Empty;
    string gUID = string.Empty;
    long returnCode = -1;
    string visittype = "";
    decimal dtotalAmount = 0;
    string vType = string.Empty;
    int Tabindexs = 0;
    long EpisodeId = 0;
    long EpisodeID = 0;
    long IPrefPhyID = 0;
    int IPrefSpecialityID = 0;
    string IPrefPhyName = "";
    string IReferralType = "";

    string AgeUnit = string.Empty;
    int AgeValue = 0;

    List<TempPatientDueChart> lstDueChart = new List<TempPatientDueChart>();
    List<PatientDueChart> lstBedBooking = new List<PatientDueChart>();
    List<PatientDueChart> lstBedBookingRoomType = new List<PatientDueChart>();
    List<PatientAmbulancedetails> lstPatientAmbDetails = new List<PatientAmbulancedetails>();

    string patientName = string.Empty;
    string dischargeStatus = string.Empty;
    string VisitState = string.Empty;
    string sEditableUser = string.Empty;
    string BillPage = string.Empty;

    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<Patient> lstPatient = new List<Patient>();
    #endregion

    #region Code Block for Enabling Reading from Resource File to display user messages
    public Billing_GenerateBill()
        : base("Billing\\GenerateBill.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        // vType = Request.QueryString.Get("vType");
       // ScriptManager.RegisterStartupScript(Page, this.GetType(), "SetFeeTypeLabel", "javascript:onChangeItem();", true);
        if (!IsPostBack)
        {
            
            BillPage = "HOS";
            ClientScriptManager cs = Page.ClientScript;
            String CallBackReference = Page.ClientScript.GetCallbackEventReference("'" + Page.UniqueID + "'", "arg", "PopulatePatientDetail", "", "ProcessCallBackError", false);
            String CallBackScript = "function GetPatientDetail(arg){" + CallBackReference + "}";
            cs.RegisterClientScriptBlock(this.GetType(), "getPatientKey", CallBackScript, true);


            string rval = GetConfigValue("roundoffpatamt", OrgID);
            hdnDefaultRoundoff.Value = rval == "" ? "0" : rval;
            rval = GetConfigValue("patientroundoffpattern", OrgID);
            hdnRoundOffType.Value = rval;
            hdnLocationID.Value = ILocationID.ToString();
            string NeedINVFreeText = GetConfigValue("NeedINVFreeText", OrgID);
            string BillLogic = GetConfigValue("BillLogic", OrgID);
            if (!string.IsNullOrEmpty(BillLogic))
            {
                hdnBillingLogic.Value = BillLogic.ToLower();
                if (BillLogic.ToLower() == "after")
                {
                    divPaymentType.Style.Add("display", "none");
                    tblAmount.Style.Add("display", "none");
                    spanAmount1.Style.Add("display", "none");
                    spanAmount2.Style.Add("display", "none");
                    btnSave.Style.Add("display", "none");
                    btnGenerateVisit.Style.Add("display", "block");
                }
                else
                {
                    divPaymentType.Style.Add("display", "block");
                    tblAmount.Style.Add("display", "block");
                    spanAmount1.Style.Add("display", "block");
                    spanAmount2.Style.Add("display", "block");
                    btnSave.Style.Add("display", "block");
                    btnGenerateVisit.Style.Add("display", "none");
                }
            }
            else
            {
                hdnBillingLogic.Value = "normal";
            }
            string strPrintOpCard = GetConfigValue("PRINT_OP_CARD", OrgID);
            if (!string.IsNullOrEmpty(strPrintOpCard))
            {
                if (string.Compare(strPrintOpCard, "Y", true) == 0)
                {
                    chkboxPrintOPCard.Checked = true;
                }
            }
            string Ratesfreetext = GetConfigValue("RatesFreeText", OrgID);
            hdnRatesfreetext.Value = Ratesfreetext;
            txtAmount.Style.Add("Readonly", "true");
            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "NeedINVFreeText", String.Format("var NeedINVFreeText={0};", '"' + NeedINVFreeText + '"'), true);
            string NeedCreditLimt = string.Empty;
            string refphy = GetConfigValue("ReferigPhysician", OrgID);
            hdnRefPhy.Value = refphy;
            NeedCreditLimt = GetConfigValue("CreditLimitForIP", OrgID);
            if (NeedCreditLimt != "" && NeedCreditLimt == "Y")
            {
                hdnOrgCreditLimt.Value = "Y";
            }

            //PatVistiRefID.Value = (0).ToString();

            //Tabindexs = 0;
            ////Tabindexs = QPR.settabindex(Tabindexs);
            ////Tabindexs = ReferDoctor1.settabindex(Tabindexs++);
            //rblFeeTypes.TabIndex = (short)(Tabindexs++)
            //txtName.TabIndex = (short)(Tabindexs++);
            //txtQty.TabIndex = (short)(Tabindexs++);
            //txtAmount.TabIndex = (short)(Tabindexs++);
            //txtDate.TabIndex = (short)(Tabindexs++);
            //ImgBntCalc.TabIndex = (short)(Tabindexs++);
            //Tabindexs = Tabindexs + 2;
            //txtDiscount.TabIndex = (short)(Tabindexs++);
            //Tabindexs = PaymentType.settabindex(Tabindexs++);

            //btnSave.TabIndex = (short)(Tabindexs++);
            //btnClose.TabIndex = (short)(Tabindexs++);

            btnSave.Enabled = true;
            txtDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            

            LoadTaxMaster();
            //oadClient();

            //txtAmountRecieved.Text = (hdnAmountReceived.Value == null ? String.Format("{0:0.00}", "0") : hdnAmountReceived.Value.ToString());

            #region Load FeeTypes

            List<FeeTypeMaster> lstFTM = new List<FeeTypeMaster>();
            returnCode = new BillingEngine(new BaseClass().ContextInfo).GetFeeType(OrgID, vType, out lstFTM);
            if (lstFTM.Count > 0)
            {
                rblFeeTypes.DataSource = lstFTM;
                rblFeeTypes.DataTextField = "FeeTypeDesc";
                rblFeeTypes.DataValueField = "FeeType";
                rblFeeTypes.DataBind();
                rblFeeTypes.SelectedIndex = 0;
                hdnFeeType1.Value = rblFeeTypes.SelectedValue.ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "SetFeeTypeLabel", "javascript:chkPros();", true);
            }

            #endregion
            AutoCompleteExtender3.ContextKey = hdnFeeType1.Value.ToString() + "~" + OrgID.ToString() + "~" + uctlClientTpa.ClientID+ "~" + hdnLocationID.Value.ToString();
            //AutoCompleteExtender3.ContextKey = hdnFeeType1.Value.ToString() + "~" + OrgID.ToString() + "~" + hdnRateID.Value.ToString() + "~" + hndLocationID.Value.ToString();

            string pConfigKey = "IsReceptionCashier";
            string pOutStatus = string.Empty;

            string ReceptionandCashier = string.Empty;
            returnCode = new GateWay(base.ContextInfo).GetIsReceptionCashier(pConfigKey, OrgID, out pOutStatus);


            if (pOutStatus != " ")
            {
                if ((pOutStatus == "Y" && RoleHelper.Cashier == RoleName) || (pOutStatus == "N" && RoleHelper.Reception == RoleName))
                {
                    QPR.pIPMakePayment = true;
                    btnMakePayment.Visible = true;
                }
                else
                {
                    btnMakePayment.Visible = false;
                    QPR.pIPMakePayment = false;
                }
            }
            else
            {
                QPR.pIPMakePayment = true;
                btnMakePayment.Visible = true;
            }
            
          
            LoadHospitalBranch();
            LoadDiscount();
            LoadDiscountReason();
            string strReset = GetConfigValue("QuickBilling_Reset", OrgID);
            hdnResetAll.Value = strReset == "" ? "N" : strReset;
            //int ConValue = Int32.Parse(GetConfigValue("URNNUMBER", OrgID));            
            int ConValue = 0;
            string StrConValue = GetConfigValue("URNNUMBER", OrgID);
            if (StrConValue != "")
            {
                ConValue = Int32.Parse(StrConValue);
            }
            if (OrgID == ConValue)
            {
                QPR.MrdSearch();
            }


        }
    }


    //---------Babu---07-12-2012-----------

  //  public void SaveAmbulanceDetails(long patientID, long patientVisitID)
    public void SaveAmbulanceDetails(long patientVisitID)
    {
        if (!string.IsNullOrEmpty(hdnAmbulanceDetails.Value)) 
        {
            string lsValue = Convert.ToString(hdnAmbulanceDetails.Value);
            char[] lcsplitFirst= { '^' };
            string[] lsAMBIN = lsValue.Split(lcsplitFirst);
                                 
            char[] splitOn = { '$' };
            string[] lsHiddenValue = lsAMBIN[0].Split(splitOn);
            PatientAmbulancedetails lobjAMBFieldValue;
                   
            lobjAMBFieldValue=new PatientAmbulancedetails();
            lobjAMBFieldValue.AmbulanceID = Convert.ToInt64(lsHiddenValue[0]);
            lobjAMBFieldValue.DriverID = Convert.ToInt64(lsHiddenValue[1]);
            lobjAMBFieldValue.LocationID = Convert.ToInt64(lsHiddenValue[2]);
            lobjAMBFieldValue.Distancekgm = Convert.ToInt64(lsHiddenValue[3]);
            lobjAMBFieldValue.AmbulancearrivalFromdate= Convert.ToDateTime(lsHiddenValue[4]);
            lobjAMBFieldValue.AmbulancearrivalTodate = Convert.ToDateTime(lsHiddenValue[5]);
            lobjAMBFieldValue.Duration = Convert.ToInt64(lsHiddenValue[6]);

           // lobjAMBFieldValue.PatientID = patientID;
            lobjAMBFieldValue.PatientVisitID = patientVisitID;
            lobjAMBFieldValue.Createdby = LID;
            lobjAMBFieldValue.Modifiedby = LID;
            lobjAMBFieldValue.Createdat = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            lobjAMBFieldValue.Modifiedat = Convert.ToDateTime(new BasePage().OrgDateTimeZone);  
            
            lstPatientAmbDetails.Add(lobjAMBFieldValue);
         
            if(!string.IsNullOrEmpty(lsAMBIN[1]))
            {
                string[] lsHiddenSecondValue = lsAMBIN[1].Split(splitOn);
                lobjAMBFieldValue = new PatientAmbulancedetails();
                lobjAMBFieldValue.AmbulanceID = Convert.ToInt64(lsHiddenSecondValue[0]);
                lobjAMBFieldValue.DriverID = Convert.ToInt64(lsHiddenSecondValue[1]);
                lobjAMBFieldValue.LocationID = Convert.ToInt64(lsHiddenSecondValue[2]);
                lobjAMBFieldValue.Distancekgm = Convert.ToInt64(lsHiddenSecondValue[3]);
                lobjAMBFieldValue.AmbulancearrivalFromdate = Convert.ToDateTime(lsHiddenSecondValue[4]);
                lobjAMBFieldValue.AmbulancearrivalTodate = Convert.ToDateTime(lsHiddenSecondValue[5]);
                lobjAMBFieldValue.Duration = Convert.ToInt64(lsHiddenSecondValue[6]);
                //lobjAMBFieldValue.FinalBillID  = patientID;
                lobjAMBFieldValue.PatientVisitID = patientVisitID;
                lobjAMBFieldValue.Createdby = LID;
                lobjAMBFieldValue.Modifiedby = LID;
                lobjAMBFieldValue.Createdat = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lobjAMBFieldValue.Modifiedat = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                lstPatientAmbDetails.Add(lobjAMBFieldValue);
            }

            //long returnCode = new Master_BL(base.ContextInfo).InsertAmbulanceDetails(lstPatientAmbDetails);

            hdnAmbulanceDetails.Value = "";
                 
            tdAmbulance.Style.Add("display", "none");

        }


    }

  
    //---------------end-----------------------
    
    public void LoadHospitalBranch()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<LabReferenceOrg> RefOrg = new List<LabReferenceOrg>();
            List<LabReferenceOrg> Hospital = new List<LabReferenceOrg>();
            //retCode = patBL.GetLabRefOrg(OrgID, 0, out RefOrg);
            retCode = patBL.GetLabRefOrg(OrgID, 0, "D", out RefOrg);
            Hospital = RefOrg.FindAll(delegate(LabReferenceOrg h) { return h.ClientTypeID == 1; });
            if (retCode == 0)
            {
                ddlHospital.DataSource = Hospital;
                ddlHospital.DataTextField = "RefOrgNameWithAddress";
                ddlHospital.DataValueField = "LabRefOrgID";
                ddlHospital.DataBind();
                ddlHospital.Items.Insert(0, "-----Select-----");
                ddlHospital.Items[0].Value = "0";

                foreach (ListItem lit in ddlHospital.Items)
                {
                    lit.Attributes.Add("Title", lit.Text);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Hospital Details.", ex);
        }
    }

    protected void ddlHospital_SelectedIndexChanged(object sender, EventArgs e)
    {

        PatVistiRefID.Value = (ddlHospital.SelectedValue).ToString();
    }

    private void LoadDiscount()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<DiscountMaster> getDiscount = new List<DiscountMaster>();
            retCode = patBL.GetLabDiscount(OrgID, out getDiscount);
            if (retCode == 0)
            {

                ddDiscountPercent.DataSource = getDiscount;
                ddDiscountPercent.DataTextField = "DiscountName";
                ddDiscountPercent.DataValueField = "Discount";
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, new ListItem("--Select--", "0"));

                if (getDiscount.Count > 0)
                {
                    ddDiscountPercent.Style.Add("display", "block");
                    tdDiscountLabel.Style.Add("display", "block");
                }
                else
                {
                    ddDiscountPercent.Style.Add("display", "none");
                    tdDiscountLabel.Style.Add("display", "none");
                }
            }
            else
            {
                ddDiscountPercent.DataSource = null;
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, "--Select--");
                ddDiscountPercent.Items[0].Value = "select";
                ddDiscountPercent.Style.Add("display", "none");
                tdDiscountLabel.Style.Add("display", "none");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Discount Details.", ex);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        try
        {
            saveOpBilling();

             
        }
        catch (Exception ex)
        {
            btnSave.Visible = true;
            CLogger.LogError("Error in Quick Billing", ex);
        }
    }

    protected void btnSameRefresh_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Billing/Generatebill.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnHome_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
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

    

    public void UpdateSitings()
    {

        patientVisitID = QPR.GetPatientVisitID();
        long EpisodeID = QPR.GetEpisodeID();
        patientID = QPR.GetPatientID();
        //long ret = -1;
        //ret = new BillingEngine(new BaseClass().ContextInfo).InsertPatientEpisodeMapping(patientID, patientVisitID, EpisodeId, LID, OrgID, VisitTypes);


    }

    protected void btnIPAddToDueChart_Click(object sender, EventArgs e)
    {
        patientVisitID = QPR.GetPatientVisitID();
        long EpisodeID = QPR.GetEpisodeID();
        string IsAddServices = string.Empty;
        IsAddServices = "N";

        //if (EpisodeID >0 && patientVisitID == -1 || patientVisitID == 0)
        //{

        //    Patientvisits();

        //    ////UpdateSitings();

        //}

        IPStoreDueChart(IsAddServices);


    }

    protected void btnIPbtnMakePayment_Click(object sender, EventArgs e)
    {
        //This VisitTypes are to give it for 

        patientVisitID = QPR.GetPatientVisitID();
        long EpisodeID = QPR.GetEpisodeID();

        //if (EpisodeID > 0 && patientVisitID == -1 || patientVisitID == 0)
        //{
        //    Patientvisits();
        //    //UpdateSitings();
        //}


        IPStoreMakePayment();
        // btnSameRefresh_Click(sender, e);
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string obtionValue = hdnSelectOnOption.Value;
            switch (obtionValue)
            {
                case "COLLECT_ADVANCE":
                    IPCollecetAdvanve();
                    break;
                case "SURGERY_BILL":
                    patientID = Convert.ToInt64(QPR.GetPatientID());
                    patientVisitID = QPR.GetPatientVisitID();
                    Response.Redirect("../InPatient/SurgeryBilling.aspx?PID=" + patientID + "&VID=" + patientVisitID, true);
                    break;
                case "SURGERY_ADVANCE":
                    SaveSurgeryAdvance();
                    break;
                default:
                    break;
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

    # region User Function

    public void SaveSurgeryAdvance()
    {
        AdvancePaid_BL oAdvancePaid_BL = new AdvancePaid_BL(base.ContextInfo);
        try
        {
            patientID = Convert.ToInt64(QPR.GetPatientID());
            patientVisitID = QPR.GetPatientVisitID();

            decimal dServiceCharge = 0;
            decimal.TryParse(hdnSurService.Value, out dServiceCharge);

            long pSurgeryBillingID = 0;


            System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
            dtAdvancePaidDetails = SurgeryBilling1.GetAmountReceivedDetails();
            string sreceiptNo = "";
            long IpIntermediateID = 0;
            string sType = "";
            if (dtAdvancePaidDetails.Rows.Count > 0)
            {
                returnCode = oAdvancePaid_BL.saveSurgeryAdvanceDetail(patientVisitID, patientID,
                    LID, pSurgeryBillingID, dtAdvancePaidDetails, dServiceCharge, out sreceiptNo, out IpIntermediateID,
                    out sType);
                SurgeryBilling1.ClearControls();
                string strName = "";
                QPR.PatientName(out strName);


                string sPage = "../InPatient/PrintReceiptPage.aspx?rcptno=" + sreceiptNo.ToString()



                        + "&PID=" + patientID.ToString()
                        + "&VID=" + patientVisitID.ToString()
                        + "&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "&OrgID=" + OrgID;
                dtAdvancePaidDetails = new DataTable();
                string str = hdnSelectOnOption.Value;
                if (hdnResetAll.Value == "Y")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();openPOPupQuick('" + sPage + "');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ItemscloseData();SetPanelOPorIP('IP','" + str + "');SetBillingOption();ResetOldValues('IP');openPOPupQuick('" + sPage + "');", true);
                }
                hdnSurPayment.Value = "0";
            }
        }


        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    public void IPCollecetAdvanve()
    {
        decimal dAmount = 0;
        AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);

        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<DHEBAdder> lstDhebAdder = new List<DHEBAdder>();
        decimal dServiceCharge = 0;
        decimal.TryParse(txtAdvServiceCharge.Text, out dServiceCharge);
        hdnNowPaid.Value = hdnNowPaid.Value == "" ? "0" : hdnNowPaid.Value;
        txtPayment.Text = (txtPayment.Text == "0" || txtPayment.Text == "") ? hdnNowPaid.Value : txtPayment.Text;
        dAmount = Convert.ToDecimal(txtPayment.Text);

        patientID = Convert.ToInt64(QPR.GetPatientID());
        patientVisitID = QPR.GetPatientVisitID();
        string PNumber = QPR.GetPatientNumber();
        long returnCode = -1;



        System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
        dtAdvancePaidDetails = PaymentType.GetAmountReceivedDetails();
 
        string sreceiptNo = "";
        long IpIntermediateID = 0;
        string sType = "";
        if (dtAdvancePaidDetails.Rows.Count > 0)
        {
            returnCode = objAdBL.SaveAdvancePaidDetails(patientVisitID, patientID, LID, dAmount, OrgID,
                                                            lstPatientInvestigation, lstPatientDueChart,
                                                            lstDhebAdder, dtAdvancePaidDetails, dServiceCharge,
                                                            out sreceiptNo, out IpIntermediateID, out sType);
            string strName = "";
            QPR.PatientName(out strName);

            string sPage = "../InPatient/PrintReceiptPage.aspx?rcptno=" + sreceiptNo.ToString()



                            + "&PID=" + patientID.ToString()
                            + "&VID=" + patientVisitID.ToString()
                            + "&OrgID=" + OrgID
                            + "&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "&PNumber=" + PNumber;
            if (txtPayment.Text.Trim() != "0")
            {
                string str = hdnSelectOnOption.Value;
                if (hdnResetAll.Value == "Y")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();openPOPupQuick('" + sPage + "');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "clear", "javascript:ItemscloseData();SetPanelOPorIP('IP','" + str + "');SetBillingOption(); ResetOldValues('IP');openPOPupQuick('" + sPage + "');", true);
                }
                txtPayment.Text = "0";
            }
            dtAdvancePaidDetails = new DataTable();
        }

    }

    public void IPStoreMakePayment()
    {

        patientVisitID = QPR.GetPatientVisitID();
        patientID = QPR.GetPatientID();
        string SitingTypes = QPR.GetVisitType();


        long returnCodeINV = -1;
        long createTaskID = -1;
        string pReceiptNo = string.Empty;
        long pIpIntermediateID = 0;
        string sType = "";
        long returnCode = -1;
        string pMsg = "";
        decimal pRoundOff = 0;
        decimal.TryParse(hdnRoundOff.Value, out pRoundOff);

        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);

        string feeType = String.Empty;

        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        FinalBill finalBill = new FinalBill();
        AmountReceivedDetails amtRD = new AmountReceivedDetails();
        DataTable dtAmountReceived = new DataTable();
        List<PatientReferringDetails> lstPatientRefDetails = new List<PatientReferringDetails>();
        List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();

        lstPatientRefDetails = dspData.GetPatientReferringDetails();
        txtAmountRecieved.Text = hdnTotalAmtRec.Value == null ? "0" : hdnTotalAmtRec.Value.ToString();

        txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
        finalBill.FinalBillID = FinalBillID;
        //---------------------------------------------------------------------------------------------------------
        finalBill.OrgID = OrgID;
        finalBill.VisitID = patientVisitID;
        finalBill.StdDedID = 0;// Convert.ToInt64(hdnStdDedID.Value);
        finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
        finalBill.GrossBillValue = Convert.ToDecimal(hdnGrossValue.Value.ToString());
        finalBill.NetValue = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                - finalBill.DiscountAmount
                                + pRoundOff;
        finalBill.ServiceCharge = dServiceCharge;
        finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text);
        finalBill.DiscountReason = txtDiscountReason.Text;
        finalBill.RoundOff = pRoundOff;
        dtAmountReceived = PaymentType.GetAmountReceivedDetails();

        amtRD.AmtReceived = Convert.ToDecimal(txtAmountRecieved.Text);
        amtRD.ReceivedBy = LID;
        amtRD.CreatedBy = LID;

        //// finalBill.CurrentDue = finalBill.NetValue + Convert.ToDecimal(txtDue.Text.ToString()) - finalBill.AmountReceived;
        finalBill.CurrentDue = finalBill.NetValue - finalBill.AmountReceived;

        if (txtAmountRecieved.Text.Trim() == "0" || txtAmountRecieved.Text.Trim() == "0.00" || txtAmountRecieved.Text.Trim() == "")
        {
            finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount + pRoundOff;
        }
        finalBill.CreatedBy = LID;

        lstPatientDueChart = dspData.GetIPBillingDetails("Paid");

        lstPatientInvestigationHL = dspData.GetOrderedInvestigations(patientVisitID, out gUID);
        long result = 0;
        int pOrderedInvCnt = 0;
        gUID = Guid.NewGuid().ToString();
        string labno = string.Empty;
        //int pOrderedInvCnt = 0;
        int referedCount = 0;
        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
        IPrefPhyID = QPR.GetRefPhyID();

       


        if (IPrefPhyID <= 0)
        {
            IPrefPhyID = ReferDoctor1.GetRefPhyID();
            IPrefSpecialityID = ReferDoctor1.GetSpeciality();
            IPrefPhyName = ReferDoctor1.GetRefPhyName();
            IReferralType = ReferDoctor1.GetReferralType();
            returnCode = new BillingEngine(new BaseClass().ContextInfo).InsertIPReferringDetails(OrgID, patientVisitID, IPrefPhyID, IPrefSpecialityID, IPrefPhyName, IReferralType);
        }

            
        long ret = -1;
        if (lstPatientDueChart.Count > 0)
        {
            ret = new BillingEngine(new BaseClass().ContextInfo).InsertPatientMakePayment(finalBill, dtAmountReceived, amtRD, lstPatientDueChart, lstPatientInvestigationHL,
                OrgID, SitingTypes, patientVisitID, patientID, LID, gUID, out lstOrderedInv, out pReceiptNo, out pIpIntermediateID,
                                                                    out sType, lstPatientRefDetails, out labno,lstVisitClientMapping[0].ClientID);
       

        }

        if (!string.IsNullOrEmpty(hdnAmbulanceDetails.Value))
        {
            SaveAmbulanceDetails(patientVisitID);
            returnCode = new Patient_BL(base.ContextInfo).InsertAmbulanceDetails(lstPatientAmbDetails);
            lstPatientAmbDetails.Clear(); 

        }

     
        
        if (ret == 0)
        {
            returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out pOrderedInvCnt); //returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out OrderedInvCnt);      
            if (lstPatientInvestigationHL != null)
            {
                if (lstPatientInvestigationHL.Count > 0)
                {
                    CollectSampleTaskCreator(patientVisitID, OrgID, RoleID, gUID, labno, lstPatientInvestigationHL);
                }
            }
            pMsg = "Items added successfully";
            lstPatientDueChart.Clear();

        
        }
        else
        {
            pMsg = "Due Items added Failed";
            lstPatientDueChart.Clear();
        }
        if (referedCount > 0)
        {
            long taskIDReffered = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), patientVisitID, 0,
             patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            //task.BillID = FinalBillID;
            task.PatientVisitID = patientVisitID;
            task.PatientID = patientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = labno.ToString();
            //Create task               
            returnCode = taskBL.CreateTask(task, out taskIDReffered);
        }
        string str = hdnSelectOnOption.Value;
        string sPage = "../InPatient/PrintReceiptPage.aspx?IsPopup=Y&rcptno=" + pReceiptNo.ToString()



                        + "&PID=" + patientID.ToString()
                        + "&VID=" + patientVisitID.ToString()
                        + "&OrgID=" + OrgID
                        + "&LabNo=" + labno
                        + "&pdid=" + pIpIntermediateID.ToString() + "&pDet=" + sType + "";
        ///QuickBilling_Reset
        ///
        if (hdnResetAll.Value == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();openPOPupQuick('" + sPage + "');", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "clear", "javascript:ItemscloseData();SetPanelOPorIP('IP','" + str + "');ResetOldValues('IP');openPOPupQuick('" + sPage + "');", true);
        } 

    }

    public void IPStoreDueChart(string IsAddServices)
    {
        patientVisitID = QPR.GetPatientVisitID();
        string SitingTypes = QPR.GetVisitType();
        patientID = QPR.GetPatientID();
        long returnCodeINV = -1;
         
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        long returnCode = -1;
        string pMsg = "";

        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<OrderedInvestigations> lstPatientInvestigationHL = new List<OrderedInvestigations>();

        lstPatientDueChart = dspData.GetIPBillingDetails("Pending");

        lstPatientInvestigationHL = dspData.GetOrderedInvestigations(patientVisitID, out gUID);
        List<PatientReferringDetails> lstPatientRefDetails = new List<PatientReferringDetails>();
        lstPatientRefDetails = dspData.GetPatientReferringDetails();


        
        string labno = string.Empty;
        int pOrderedInvCnt = 0;
        //gUID = Guid.NewGuid().ToString();

        //int pOrderedInvCnt = 0;
        int referedCount = 0;
        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();
        List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();
        string InterimBillNo = string.Empty;
        long ret = -1;
        IPrefPhyID = QPR.GetRefPhyID();
        if (IPrefPhyID <= 0)
        {
            IPrefPhyID = ReferDoctor1.GetRefPhyID();
            IPrefSpecialityID = ReferDoctor1.GetSpeciality();
            IPrefPhyName = ReferDoctor1.GetRefPhyName();
            IReferralType = ReferDoctor1.GetReferralType();
            returnCode = new BillingEngine(new BaseClass().ContextInfo).InsertIPReferringDetails(OrgID, patientVisitID, IPrefPhyID, IPrefSpecialityID, IPrefPhyName, IReferralType);
        }
        if (lstPatientDueChart.Count > 0)
        {
            ret = new BillingEngine(new BaseClass().ContextInfo).InsertPatientDueChart(lstPatientDueChart, lstPatientInvestigationHL,
                OrgID, SitingTypes, patientVisitID, patientID, LID, gUID, out lstOrderedInv, lstPatientRefDetails,
                out InterimBillNo, out labno, IsAddServices, lstVisitClientMapping[0].ClientID);
        }

        if (!string.IsNullOrEmpty(hdnAmbulanceDetails.Value))
        {
            SaveAmbulanceDetails(patientVisitID);
            returnCode = new Patient_BL(base.ContextInfo).InsertAmbulanceDetails(lstPatientAmbDetails);
            lstPatientAmbDetails.Clear(); 

        }

        //long returnCode = -1;
      

        if (ret == 0)
        {
            returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(patientVisitID, out referedCount, out pOrderedInvCnt); //returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out OrderedInvCnt); 
            if (lstPatientInvestigationHL != null)
            {
                if (lstPatientInvestigationHL.Count > 0)
                {
                    CollectSampleTaskCreator(patientVisitID, OrgID, RoleID, gUID, labno, lstPatientInvestigationHL);
                }
            }
            pMsg = "Items added successfully";
            lstPatientDueChart.Clear();
        }
        else
        {
            pMsg = "Due Items added Failed";
            lstPatientDueChart.Clear();
        }

        if (referedCount > 0)
        {
            long taskIDReffered = -1;
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);

            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), patientVisitID, 0,
             patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            //task.BillID = FinalBillID;
            task.PatientVisitID = patientVisitID;
            task.PatientID = patientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            task.RefernceID = labno.ToString();
            //Create task               
            returnCode = taskBL.CreateTask(task, out taskIDReffered);
        }
        string str = hdnSelectOnOption.Value;
        if (pMsg == "Due Items added Failed")
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "clear", "javascript:ItemscloseData();SetPanelOPorIP('IP','" + str + "');ResetOldValues('IP');alert('" + pMsg + "');", true);
        }
        else
        {
            string sPage = "../Inpatient/PrintDueRequestPage.aspx?ReferenceID="
                       + InterimBillNo.ToString() + "&dDate="
                       + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                //+ "&PNAME=" + patientName
                       + "&PID=" + patientID.ToString()
                       + "&VID=" + patientVisitID.ToString()
                       + "&PNAME=" + PatientHeader.Name.ToString()
                       + "&LabNo=" + labno
                        + "&IsAddServices=" + IsAddServices
                       + "&IsPopup=Y";

            if (hdnResetAll.Value == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();openPOPupQuick('" + sPage + "');", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "sky1", "javascript:openPOPupQuick('" + sPage + "');ItemscloseData();SetPanelOPorIP('IP','" + str + "');ResetOldValues('IP');", true);
            }

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

    protected void LoadTaxMaster()
    {
        BillingEngine billBL = new BillingEngine(new BaseClass().ContextInfo);
        List<Taxmaster> lstTaxMaster = new List<Taxmaster>();
        billBL.GetTaxDetails(OrgID, out lstTaxMaster);
        string sHtml = "";
        foreach (Taxmaster tm in lstTaxMaster)
        {
            txtTax.Text = "0";
            sHtml += " <input type='checkbox' id='chktax#" + tm.TaxID + "' value='" + tm.TaxPercent + "' runat='server' onclick='chkTaxPayment(this.id,this.value);' > " + tm.TaxName + "</input> </br>";
            txtTax.ReadOnly = true;
        }
        dvTaxDetails.InnerHtml = sHtml;
    }

    private List<DuePaidDetail> getDPDetails(decimal AmountReceived)
    {
        List<DuePaidDetail> lstDPD = new List<DuePaidDetail>();
        if (hdnDPDetails.Value != null)
        {
            foreach (string sValue in hdnDPDetails.Value.ToString().Split('|'))
            {
                if (sValue != "")
                {
                    decimal tempReceived = 0;
                    DuePaidDetail dPD = new DuePaidDetail();
                    if (AmountReceived < Convert.ToDecimal(sValue.Split('~')[1]))
                    {
                        tempReceived = AmountReceived;
                        dPD.PaidAmount = tempReceived;
                    }
                    else
                    {
                        dPD.PaidAmount = Convert.ToDecimal(sValue.Split('~')[1]);
                        tempReceived = AmountReceived - Convert.ToDecimal(sValue.Split('~')[1]);
                    }
                    AmountReceived = tempReceived;
                    dPD.DueBillNo = Convert.ToInt64(sValue.Split('~')[0]);

                    dPD.BillAmount = 0;
                    dPD.PaidBillNo = FinalBillID;
                    dPD.PaidDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    dPD.DueCollectedBy = LID;
                    lstDPD.Add(dPD);
                }
            }
        }
        return lstDPD;
    }
    

   
    private void clearNonReimburseFields()
    {
        string txt = Resources.ClientSideDisplayTexts.Billing_GenerateBill_aspx_cs_txt;
        txtNonMedical.Text = txt;
        txtCoPayment.Text = txt;
        txtExcess.Text = txt;
        ddDiscountPercent.SelectedIndex = 0;
    }

    private List<TaxBillDetails> getTaxDetails()
    {
        List<TaxBillDetails> lstTax = new List<TaxBillDetails>();
        if (hdfTax.Value != null)
        {
            foreach (string sValue in hdfTax.Value.ToString().Split('>'))
            {
                if (sValue != "")
                {
                    TaxBillDetails tTax = new TaxBillDetails();
                    tTax.TaxID = Convert.ToInt32(sValue.Split('~')[0].Split('#')[1]);
                    tTax.TaxPercent = Convert.ToDecimal(sValue.Split('~')[1]);
                    lstTax.Add(tTax);
                }
            }
        }
        return lstTax;
    }

    public short setTabIndex()
    {
        return (short)(ImgBntCalc.TabIndex + 1);
    }

    #endregion

    public void RaiseCallbackEvent(String eventArgument)
    {
        string SmartCardNo = string.Empty;
        List<Patient> lstPatientDetail = new List<Patient>();
        SmartCardNo = eventArgument;
        long returnCode = -1;
        try
        {
            returnCode = new Patient_BL(base.ContextInfo).GetPatientListForQuickBillSmartCard(SmartCardNo, OrgID, out lstPatientDetail);
            if (lstPatientDetail.Count > 0)
            {
                HiddenField hdnSC = (HiddenField)QPR.FindControl("hdnPatientDetailSC");
                hdnSC.Value += lstPatientDetail[0].Name + "^" + lstPatientDetail[0].Comments;
            }
        }
        catch (Exception er)
        {
            CLogger.LogError("There was a Retrieving Data for Smart Card Number in QuickPatientReg.aspx", er);
        }
    }

    public string GetCallbackResult()
    {
        HiddenField hdnSC = (HiddenField)QPR.FindControl("hdnPatientDetailSC");
        return hdnSC.Value.ToString();
    }

    public void CollectSampleTaskCreator(long patientVisitID, int OrgID, long RoleID, string gUID, string labno, List<OrderedInvestigations> lstOrderedInvestigations)
    {
        //Function Add By Syed for Both Investigation & Package Tasks
        try
        {
            #region INV
            Tasks task = new Tasks();
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            List<TaskActions> lstTaskAction = new List<TaskActions>();
            List<Patient> lstPatient = new List<Patient>();
            List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
            List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
            List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
            int specialityID = -1;
            new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(patientVisitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);
            string sVal = GetConfigValue("SampleCollect", OrgID);
            if (sVal.Trim() != "N")
            {
                foreach (var item in lstSampleDept1)
                {
                    if (item.Display == "Y")
                    {
                        //long createTaskID = -1;
                        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
                        string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                     patientVisitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                     patientName, "", 0, "", 0, "", 0, "INV"
                                     , out dText, out urlVal, "0", lstPatientVisitDetails[0].PatientNumber, 0, gUID, "", lstPatientVisitDetails[0].VisitNumber,"");
                        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.RoleID = RoleID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = patientVisitID;
                        task.PatientID = patientID;
                        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                        task.CreatedBy = LID;
                        task.RefernceID = labno.ToString();
                        //Create task               
                        returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out taskID);
                        break;

                    }
                }
                if (taskID > 0)
                {
                    returnCode = new Investigation_BL(base.ContextInfo).UpdateOrderedInvestigation(patientVisitID, labno, OrgID, BillNumber, taskID);
                }
            }
            foreach (var item in lstSampleDept1)
            {
                if (item.Display == "N")
                {
                    InvestigationValues inValues = new InvestigationValues();
                    inValues.InvestigationID = item.InvestigationID;
                    inValues.PerformingPhysicainName = item.PerformingPhysicainName;
                    inValues.PackageID = item.PackageID;
                    inValues.PackageName = item.PackageName;

                    lstInvResult.Add(inValues);
                }
            }
            if (lstInvResult.Count > 0)
            {
                returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(patientVisitID, "SampleReceived", OrgID, lstInvResult);
            }
            #endregion
            #region Helath Package
            //Add By Syed
            Investigation_BL investigationBL = new Investigation_BL(base.ContextInfo);
            List<InvGroupMaster> lstPackages = new List<InvGroupMaster>();
            List<PatientInvestigation> lstPackageContents = new List<PatientInvestigation>();
            List<InvPackageMapping> lstPackageMapping = new List<InvPackageMapping>();
            List<Speciality> lstSpeciality = new List<Speciality>();
            List<Speciality> lstCollectedSpeciality = new List<Speciality>();
            List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
            List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
            int PkgID = -1;
            investigationBL.GetHealthPackageData(OrgID,PkgID, out lstPackages, out lstPackageMapping, out lstPackageContents, out lstGeneralHealthCheckUpMaster);
            int purpID = 4;
            //  purpID =Convert.ToInt32(QPR.GetVisitPurposeID());

            foreach (OrderedInvestigations objItems in lstOrderedInvestigations)
            {
                if (objItems.Type == "PKG")
                {
                    //Get Speciality
                    
                    foreach (InvGroupMaster PkgMaster in lstPackages)
                    {
                        if (objItems.ID == PkgMaster.AttGroupID)
                        {
                            PkgID = PkgMaster.GroupID;
                        }

                    }
                    var invPMList = from invPM in lstPackageMapping
                                    where invPM.PackageID == Convert.ToInt32(PkgID) && (invPM.Type == "CON" || invPM.Type == "SPE")
                                    select invPM;
                    List<InvPackageMapping> lstPI1 = invPMList.ToList<InvPackageMapping>();
                    foreach (InvPackageMapping objPMTTT in lstPI1)
                    {
                        Speciality objCollectedSpeciality = new Speciality();
                        objCollectedSpeciality.SpecialityID = Convert.ToInt32(objPMTTT.ID);
                        objCollectedSpeciality.SpecialityName = "";
                        lstCollectedSpeciality.Add(objCollectedSpeciality);
                    }
                    //Get HealthCheckUpMaster
                    var invGHList = from invPM in lstPackageMapping
                                    where invPM.PackageID == Convert.ToInt32(PkgID) && invPM.Type == "GHC"
                                    select invPM;
                    List<InvPackageMapping> lstPI2 = invGHList.ToList<InvPackageMapping>();

                    foreach (InvPackageMapping objGHTTT in lstPI2)
                    {
                        GeneralHealthCheckUpMaster objGeneralHealthCheckUpMaster = new GeneralHealthCheckUpMaster();
                        objGeneralHealthCheckUpMaster.GeneralHealthCheckUpID = Convert.ToInt32(objGHTTT.ID);
                        objGeneralHealthCheckUpMaster.GeneralHealthCheckUpName = "";
                        lstCollectedHealthCheckUpMaster.Add(objGeneralHealthCheckUpMaster);
                    }

                    PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
                    Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                    PatientVisit pVisit = new PatientVisit();
                    // int purpID = 1;
                    long phyID = -1;
                    int otherID = -1;
                    returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out lstPatient);
                    Patient patient;
                    patient = lstPatient.Count > 0 ? lstPatient[0] : new Patient();

                    string feeType = String.Empty;
                    string otherName = String.Empty;
                    string physicianName = String.Empty;
                    string referrerName = string.Empty;
                    long ptaskID = -1;
                    //  string gUID = string.Empty;
                    string PaymentLogic = string.Empty;
                    long visitID = patientVisitID;

                    #region for HealthScreen Task
                    if (lstCollectedHealthCheckUpMaster.Count > 0)
                    {
                        long ptaskIDHC = -1;
                        feeType = "HEALTHPKG";
                        otherID = 0;
                        int visitPurposeID = 4;
                        phyID = 0;
                        if (PaymentLogic == string.Empty)
                        {
                            List<Config> lstConfig = new List<Config>();
                            new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
                            if (lstConfig.Count > 0)
                                PaymentLogic = lstConfig[0].ConfigValue.Trim();
                        }
                        pVisit.PhysicianName = "";
                        TaskActions taskActionHC = new TaskActions();

                        returnCode = pvisitBL.GetTaskActionID(OrgID, visitPurposeID, otherID, out lstTaskAction);
                        //Perform
                        taskActionHC = lstTaskAction[0];
                        returnCode = Utilities.GetHashTable(taskActionHC.TaskActionID, visitID, phyID,
                                                      patientID, patient.TitleName + " " + patient.Name,
                                                      physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0,
                                                      patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                        task.TaskActionID = taskActionHC.TaskActionID;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = patientID;
                        task.AssignedTo = phyID;
                        task.OrgID = OrgID;
                        task.PatientVisitID = visitID;
                        task.SpecialityID = specialityID;
                        task.CreatedBy = LID;
                        returnCode = taskBL.CreateTask(task, out ptaskIDHC);
                    }
                    #endregion
                    foreach (Speciality objSpeciality in lstCollectedSpeciality)
                    {
                        purpID = 1;
                        otherID = objSpeciality.SpecialityID; //21; 
                        specialityID = objSpeciality.SpecialityID; //1;// 
                        returnCode = pvisitBL.GetTaskActionID(OrgID, purpID, otherID, out lstTaskAction);
                        TaskActions taskAction = new TaskActions();
                        taskAction = lstTaskAction[0];
                        if (returnCode == 0)
                        {
                            //*******for Task*******************
                            //Created by ashok to add multiple tasks
                            //Evaluate
                            for (int i = 0; i < lstTaskAction.Count; i++)
                            {
                                taskAction = lstTaskAction[i];

                                returnCode = Utilities.GetHashTable(taskAction.TaskActionID, visitID, phyID,
                                                          patientID, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", 0, "", out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID
                                task.TaskActionID = taskAction.TaskActionID;
                                task.DispTextFiller = dText;
                                task.URLFiller = urlVal;
                                task.PatientID = patientID;

                                task.AssignedTo = 0;
                                task.OrgID = OrgID;
                                task.PatientVisitID = visitID;
                                task.SpecialityID = specialityID;
                                task.CreatedBy = LID;
                                returnCode = taskBL.CreateTask(task, out ptaskID);
                            }
                        }
                    }
                }
            }
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Creating Task for Investigation/Packages.", ex);
        }
    }
    //newly added.... For Discount Reason ----------------
    private void LoadDiscountReason()
    {
        try
        {
            long retCode = -1;

            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<DiscountReasonMaster> getDiscount = new List<DiscountReasonMaster>();
            retCode = patBL.GetDiscountReason(OrgID, out getDiscount);
            if (retCode == 0)
            {
                DdlDiscountreason.Style.Add("display", "block");
                DdlDiscountreason.Style.Add("display", "block");
                DdlDiscountreason.DataSource = getDiscount;
                DdlDiscountreason.DataTextField = "ReasonCode";
                DdlDiscountreason.DataValueField = "ReasonId";
                DdlDiscountreason.DataBind();
                DdlDiscountreason.Items.Insert(0, new ListItem("--Select--", "0"));
                foreach (var item in getDiscount)
                {
                    hdndiscountreason.Value += item.ReasonId + "~" + item.ReasonCode + "~" + item.ReasonDesc + "^";

                }
                if (getDiscount.Count > 0)
                {
                    DdlDiscountreason.Style.Add("display", "block");
                    DdlDiscountreason.Style.Add("display", "block");
                }
                else
                {
                    DdlDiscountreason.Style.Add("display", "none");
                    DdlDiscountreason.Style.Add("display", "none");
                }
            }
            else
            {
                DdlDiscountreason.DataSource = null;
                DdlDiscountreason.DataBind();
                DdlDiscountreason.Items.Insert(0, "--Select--");
                DdlDiscountreason.Items[0].Value = "select";
                foreach (var item in getDiscount)
                {
                    hdndiscountreason.Value += item.ReasonId + "~" + item.ReasonCode + "~" + item.ReasonDesc + "^";

                }
                DdlDiscountreason.Style.Add("display", "none");
                DdlDiscountreason.Style.Add("display", "none");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Discount Details.", ex);
        }
    }
    protected void btnAddToSurgeryServices_Click(object sender, EventArgs e)
    {
        patientVisitID = QPR.GetPatientVisitID();
        long EpisodeID = QPR.GetEpisodeID();
        string IsAddServices = string.Empty;
        IsAddServices = "Y";

        //if (EpisodeID >0 && patientVisitID == -1 || patientVisitID == 0)
        //{

        //    Patientvisits();

        //    ////UpdateSitings();

        //}

        IPStoreDueChart(IsAddServices);
    }
    void saveOpBilling()
    {
        try
        {
            btnSave.Style.Add("display", "none");
            decimal AmountReceived = 0;
            decimal Due = 0;
            decimal Currentdue = 0;
            decimal dServiceCharge = 0;
            decimal discount = 0;
            decimal GrossValue = 0;
            decimal NetValue = 0;
            decimal TaxAmount = 0;
            string DiscountReason = "";
            long lVisitType = -1;
            long pSpecialityID = 0;
             
            int rateID = 0;
            long refPhyID = 0;
            
            int refSpecialityID = 0;
            string refPhyName = "";
            string ReferralType = "";
            long FinalBillID = 0;
            int returnStatus = 0; string finalPName = string.Empty;
            decimal pRoundOff = 0;
            string feeType = String.Empty;
            int BaseCurrencyID = 0;
            int PaidCurrencyID = 0;
            decimal OtherCurrencyAmount = 0;
            decimal pNonMedicalAmtPaid = decimal.Zero;
            decimal pCoPayment = decimal.Zero;
            decimal pExcess = decimal.Zero;
            decimal recievedAmount = 0;
            string labno = string.Empty;
            string sPage = string.Empty;
            string ddlClientName = "";
            long vpurpose = -1;
            string path = string.Empty;
            int iBillGroupID = 0;
            int cnt = 0;

            decimal ClaimAmount = 0;
            decimal CoPayment = 0;
            decimal TowardsAmount = 0;

            decimal.TryParse(hdnClaim.Value, out ClaimAmount);
            decimal.TryParse(hdnTotalCopayment.Value, out CoPayment);
            decimal.TryParse(hdnTowardsAmount.Value, out TowardsAmount);

            FinalBill finalBill = new FinalBill();
            AmountReceivedDetails amtRD = new AmountReceivedDetails();
            Patient objPatient = new Patient();


            BillingEngine BE = new BillingEngine(new BaseClass().ContextInfo);
            BillingEngine billingEngineBL = new BillingEngine(new BaseClass().ContextInfo);
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);


            
            List<Config> lstConfig = new List<Config>();
            List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
            List<PatientDepositUsage> lstUsage = new List<PatientDepositUsage>();
            List<PatientReferringDetails> lstPatientRefDetails = new List<PatientReferringDetails>();
            List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            List<DuePaidDetail> lstPaidDueDetail = new List<DuePaidDetail>();
            List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();



            decimal.TryParse(hdnTotalAmtRec.Value, out AmountReceived);
            decimal.TryParse(hdnDue.Value, out Due);
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            decimal.TryParse(txtDiscount.Text.Trim(), out discount);
            decimal.TryParse(hdnGrossValue.Value, out GrossValue);
            decimal.TryParse(hdnNetValue.Value, out NetValue);
            decimal.TryParse(hdnTaxAmount.Value, out TaxAmount);
            DiscountReason = txtDiscountReason.Text;
            NetValue = GrossValue + TaxAmount - discount + dServiceCharge;
            Currentdue = (NetValue) - AmountReceived;
            

            lstPatientDueChart = dspData.GetConsNProDetails();
            lstPaidDueDetail = getDPDetails(AmountReceived);
            lstTaxDetails = getTaxDetails();

            var Specialty = from lstSP in lstPatientDueChart
                            where lstSP.FeeType == "CON" || lstSP.FeeType == "SPE"
                            orderby lstSP.FeeID descending
                            select lstSP.SpecialityID;



            if (Specialty.Count() > 0)
            {
                pSpecialityID = Specialty.First();
            }


            patientVisitID = QPR.GetPatientVisitID();
            patientID = QPR.GetPatientID();
            objPatient = QPR.GetPatientDetails();
            string[] SplitAge = objPatient.Age.Split('~');

            AgeValue = Convert.ToInt32(SplitAge[0]);
            if (SplitAge[1].Trim() == "Day(s)")
            {
                AgeUnit = "D";
            }
            else if (SplitAge[1].Trim() == "Week(s)")
            {
                AgeUnit = "W";
            }
            else if (SplitAge[1].Trim() == "Month(s)")
            {
                AgeUnit = "M";
            }
            else
            {
                AgeUnit = "Y";
            }


            if (patientVisitID > 0)
            {
                
                lVisitType = QPR.GetCurrentVisitType();
            }
            objPatient.VisitPurposeID = lstPatientDueChart.FindAll(p => p.FeeType == "CON").Count > 0 ? 1 : objPatient.VisitPurposeID;
            objPatient.VisitType = lVisitType.ToString();
            objPatient.RateID = rateID;
            refPhyID = ReferDoctor1.GetRefPhyID();
            refSpecialityID = ReferDoctor1.GetSpeciality();
            refPhyName = ReferDoctor1.GetRefPhyName();
            ReferralType = ReferDoctor1.GetReferralType();
            hdnRefferedPhyID.Value = refPhyID.ToString();
            hdnRefferedPhyType.Value = ReferralType.ToString();
            objPatient.ReferingPhysicianName = refPhyName;
            objPatient.PatientVisitID = Int32.Parse(PatVistiRefID.Value);
            objPatient.RateID = rateID;
            objPatient.SecuredCode = System.Guid.NewGuid().ToString();
            objPatient.WardNo = "";
            objPatient.PatientHistory = "";
            txtAmountRecieved.Text = hdnTotalAmtRec.Value == null ? "0" : hdnTotalAmtRec.Value.ToString();
            txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
            txtDue.Text = hdnDue.Value.ToString() == "" ? "0" : hdnDue.Value.ToString();
            lstPatientRefDetails = dspData.GetPatientReferringDetails();
            decimal.TryParse(hdnRoundOff.Value, out pRoundOff);
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);

            //lstPatientDueChart = dspData.GetConsNProDetails();

            lstUsage = DepositUsageCtrl.GetDepositUsage();


            //---------------------------------------------------------------------------------------------------------
            finalBill.FinalBillID = FinalBillID;
            //---------------------------------------------------------------------------------------------------------
            finalBill.OrgID = OrgID;
            finalBill.VisitID = patientVisitID;
            finalBill.StdDedID = 0;// Convert.ToInt64(hdnStdDedID.Value);
            finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            finalBill.GrossBillValue = Convert.ToDecimal(hdnGrossValue.Value.ToString());
            finalBill.NetValue = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                    - finalBill.DiscountAmount
                                    + pRoundOff;
            finalBill.ServiceCharge = dServiceCharge;
            finalBill.AmountReceived = Convert.ToDecimal(txtAmountRecieved.Text);
            finalBill.DiscountReason = txtDiscountReason.Text;
            finalBill.IsCreditBill = "N";
            finalBill.RoundOff = pRoundOff;
            finalBill.IsCreditBill = uctlClientTpa.IsCreditBill;
            finalBill.TaxAmount = Convert.ToDecimal(hdnTaxAmount.Value);
            if (ddDiscountPercent.SelectedIndex == 0)
                finalBill.IsDiscountPercentage = "N";
            else finalBill.IsDiscountPercentage = "Y";
            finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            pNonMedicalAmtPaid = txtNonMedical.Text == "" || Convert.ToDecimal(txtNonMedical.Text) == 0 ? decimal.Zero : Convert.ToDecimal(txtNonMedical.Text);
            pCoPayment = txtCoPayment.Text == "" || Convert.ToDecimal(txtCoPayment.Text) == 0 ? decimal.Zero : Convert.ToDecimal(txtCoPayment.Text);
            pExcess = txtExcess.Text == "" || Convert.ToDecimal(txtExcess.Text) == 0 ? decimal.Zero : Convert.ToDecimal(txtExcess.Text);
            uctlClientTpa.CoPayment = pCoPayment;
            uctlClientTpa.NonMedicalAmount = pNonMedicalAmtPaid;
            finalBill.ExcessAmtRecd = pExcess;
            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            dtAmountReceived = PaymentType.GetAmountReceivedDetails();
            amtRD.AmtReceived = Convert.ToDecimal(txtAmountRecieved.Text);
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;
            PaymentType.GetOtherCurrReceivedDetails(out BaseCurrencyID, out PaidCurrencyID);
            OtherCurrencyDisplay1.GetOtherCurrRecd(out OtherCurrencyAmount);
            amtRD.BaseCurrencyID = BaseCurrencyID;
            amtRD.PaidCurrencyID = PaidCurrencyID;
            amtRD.OtherCurrencyAmount = OtherCurrencyAmount;
            
            if (finalBill.IsCreditBill == "N")
            {
                finalBill.CurrentDue = finalBill.NetValue - finalBill.AmountReceived;
                if (txtAmountRecieved.Text.Trim() == "0" || txtAmountRecieved.Text.Trim() == "0.00" || txtAmountRecieved.Text.Trim() == "")
                {
                    finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount + pRoundOff;
                }
            }
            else
            {
                if (TowardsAmount > AmountReceived)
                {
                    finalBill.CurrentDue = TowardsAmount - AmountReceived;
                    finalBill.Due = TowardsAmount - AmountReceived;
                }
            }

            finalBill.CreatedBy = LID;
            recievedAmount = Convert.ToDecimal(txtAmountRecieved.Text);
            txtDue.Text = txtDue.Text == "" ? "0" : txtDue.Text;
            lstTaxDetails = getTaxDetails();
            if (recievedAmount > 0 && finalBill.IsCreditBill == "N")
            {
                if (Convert.ToDecimal(hdnTotalAmtRec.Value) > 0)
                {
                    finalBill.Due = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                            - finalBill.DiscountAmount + pRoundOff - finalBill.AmountReceived;//- recievedAmount
                }
                else
                {
                    finalBill.Due = 0;
                }
                finalBill.AmountReceived = Convert.ToDecimal(hdnTotalAmtRec.Value);// +Convert.ToDecimal(txtRecievedAmount.Text);
            }
            else
            {
                if (finalBill.IsCreditBill == "N")
                {
                    finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount + pRoundOff - finalBill.AmountReceived;
                }
                else
                {
                    if (TowardsAmount > AmountReceived)
                    {
                        finalBill.CurrentDue = TowardsAmount - AmountReceived;
                        finalBill.Due = TowardsAmount - AmountReceived;
                    }
                }
            }
            lstOrderedInvestigations = dspData.GetOrderedInvestigations(patientVisitID, out gUID);


            //returnCode = new Patient_BL(base.ContextInfo).SavePatientOPBilling(OrgID, ILocationID, LID, objPatient, lstPatientDueChart, lstBillingDetails, finalBill, amtRD, dtAmountReceived,
            //     dtAmountReceived, lstTaxDetails, lstPatientRefDetails, lstOrderedInvestigations, lstUsage, refPhyID, refSpecialityID, AgeValue, AgeUnit, pSpecialityID, ReferralType,
            //           out FinalBillID,  ref patientID, ref  patientVisitID, gUID, RoleID, out cnt);

            List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();
            ;
            if (lstVisitClientMapping.Count > 0)
            {
                lstVisitClientMapping[0].ClaimAmount = ClaimAmount;
                lstVisitClientMapping[0].CoPayment = CoPayment;
            }

            returnCode = new Patient_BL(base.ContextInfo).SavePatientOPBilling(OrgID, ILocationID, LID, objPatient, lstPatientDueChart, lstBillingDetails, finalBill, amtRD, dtAmountReceived,
                dtAmountReceived, lstTaxDetails,objPatient, lstPatientRefDetails, lstOrderedInvestigations, lstUsage, refPhyID, refSpecialityID, AgeValue, AgeUnit, pSpecialityID, ReferralType,
                      out FinalBillID, ref patientID, ref  patientVisitID, gUID, RoleID, out cnt, lstVisitClientMapping);

            if (!string.IsNullOrEmpty(hdnAmbulanceDetails.Value))
            {
                SaveAmbulanceDetails(patientVisitID);
                returnCode = new Patient_BL(base.ContextInfo).InsertAmbulanceDetails(lstPatientAmbDetails);
                lstPatientAmbDetails.Clear(); 
            }


            
            
            if (cnt <= 0)
            {
                if (returnCode >= 0)
                {
                    QPR.SetPatientID(patientID, patientVisitID);
                    

                    #region Print Bill

                    List<Role> lstUserRole = new List<Role>();
                    lstUserRole.Add(new Role() { RoleID = RoleID });
                    returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
                    hdnURL.Value = Request.ApplicationPath + path;
                    hdnOPCardDetail.Value = patientID.ToString() + "~" + patientVisitID.ToString();
                    ucSPage.loadPatientSecPrintPage(patientID, patientVisitID);

                    vpurpose = QPR.GetVisitPurposeID();
                     

                    iBillGroupID = (int)ReportType.OPBill;

                    new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Dynamic Print", OrgID, ILocationID, out lstConfig);

                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        sPage = " ../Reception/ViewPrintPage.aspx?vid=" + patientVisitID.ToString() + "&pagetype=BP&IsPopup=Y&CCPage=Y&dinc=y&pid=" + patientID.ToString() + "&bid=" + FinalBillID;

                    }
                    else
                    {
                        sPage = "../Reception/PrintPage.aspx?pid=" + patientID.ToString()
                                  + "&vid=" + patientVisitID.ToString()
                                  + "&pagetype=BP&quickbill=Y&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&IsPopup=Y";
                    }

                    string str = hdnSelectOnOption.Value;
                    if (hdnResetAll.Value == "Y")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();openPOPupQuick('" + sPage + "');PrintOPCard();", true);

                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "ItemscloseData();openPOPupQuick('" + sPage + "');SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');PrintOPCard();", true);
                    }
                    QPR.SetDate();




                    #endregion

                    clearNonReimburseFields();
                   
                }
                else
                {

                    CLogger.LogWarning("Error in Save Patient Details");
                    string str = hdnSelectOnOption.Value;
                                       

                    string sPath = "Billing\\\\GenerateBill.aspx_31";
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "ShowAlertMsg('" + sPath + "');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
                   
                    
                    //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Billing\\GenerateBill.aspx_31").ToString();
                    //if (sUserMsg != null)
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "alert('" + sUserMsg + "');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
                    //else
                    //    ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "alert('There was a problem in Save Billing Details.');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);

                }
            }

            else
            {
                string str = hdnSelectOnOption.Value;
                string sUserMsg = "Billing\\\\GenerateBill.aspx_32";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "ShowAlertMsg('" + sUserMsg + "');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Billing\\GenerateBill.aspx_32").ToString();
                //if (sUserMsg != null)
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "alert('" + sUserMsg + "');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
                //else
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "alert('Patient already registered with the given details');ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
                //return;
            }
            lblActualCopaymenttxt.Text = "0";
            lblDifferenceAmount.Text = "0";
            lblClaminAmount.Text = "0";
            hdnClaim.Value = "0";
            hdnTotalCopayment.Value = "0";
            hdnTowardsAmount.Value = "0";
        }
        catch (Exception ex)
        {
            btnSave.Visible = true;
            CLogger.LogError("Error in Quick Billing", ex);
        }
    }

    #region
    /// <summary>
    /// generate visit 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>

    void SavePatientandVisit(out long pPatientID, out long pPatientVisitID)
    {
        try
        {
            long lVisitType = -1;
            long pSpecialityID = 0;
            
            long refPhyID = 0;
            int refSpecialityID = 0;
            string refPhyName = "";
            string ReferralType = "";
            int cnt = 0;
            pPatientID = -1; pPatientVisitID = -1;
            FinalBill finalBill = new FinalBill();
            Patient objPatient = new Patient();
            List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
            List<PatientReferringDetails> lstPatientRefDetails = new List<PatientReferringDetails>();
            List<SaveBillingDetails> lstBillingDetails = new List<SaveBillingDetails>();
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
            System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
            lstPatientDueChart = dspData.GetConsNProDetails();
            var Specialty = from lstSP in lstPatientDueChart
                            where lstSP.FeeType == "CON" || lstSP.FeeType == "SPE"
                            orderby lstSP.FeeID descending
                            select lstSP.SpecialityID;
            if (Specialty.Count() > 0)
            {
                pSpecialityID = Specialty.First();
            }
            patientVisitID = QPR.GetPatientVisitID();
            patientID = QPR.GetPatientID();
            objPatient = QPR.GetPatientDetails();
            string[] SplitAge = objPatient.Age.Split('~');

            AgeValue = Convert.ToInt32(SplitAge[0]);
            switch (SplitAge[1].Trim())
            {
                case "Day(s)":
                    AgeUnit = "D";
                    break;

                case "Week(s)":
                    AgeUnit = "W";
                    break;

                case "Month(s)":
                    AgeUnit = "M";
                    break;

                default:
                    AgeUnit = "Y";
                    break;
            }

            if (patientVisitID > 0)
            {
            
                lVisitType = QPR.GetCurrentVisitType();
            }
            objPatient.VisitPurposeID = lstPatientDueChart.FindAll(p => p.FeeType == "CON").Count > 0 ? 1 : objPatient.VisitPurposeID;

            objPatient.VisitType = lVisitType.ToString();
             refPhyID = ReferDoctor1.GetRefPhyID();
            refSpecialityID = ReferDoctor1.GetSpeciality();
            refPhyName = ReferDoctor1.GetRefPhyName();
            ReferralType = ReferDoctor1.GetReferralType();

            hdnRefferedPhyID.Value = refPhyID.ToString();
            hdnRefferedPhyType.Value = ReferralType.ToString();

            objPatient.ReferingPhysicianName = refPhyName;
            objPatient.PatientVisitID = Int32.Parse(PatVistiRefID.Value);
             objPatient.SecuredCode = System.Guid.NewGuid().ToString();
            objPatient.WardNo = "";
            objPatient.PatientHistory = "";
            lstPatientRefDetails = dspData.GetPatientReferringDetails();
            List<VisitClientMapping> lstVisitClientMapping = uctlClientTpa.GetClientValues();
            returnCode = new Patient_BL(base.ContextInfo).SavePatientVisitandTask(OrgID, ILocationID, LID, objPatient, lstPatientDueChart,
                             lstBillingDetails, lstPatientRefDetails, lstOrderedInvestigations, refPhyID, refSpecialityID, AgeValue, AgeUnit,
                             pSpecialityID, ReferralType, ref patientID, ref patientVisitID, gUID, RoleID, out cnt,lstVisitClientMapping);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generate Visit in Quick Billing", ex);
        }
        pPatientID = patientID;
        pPatientVisitID = patientVisitID;
    }
    protected void btnGenerateVisit_Click(object sender, EventArgs e)
    {
        long pPatientID = -1, pPatientVisitID = -1;
        SavePatientandVisit(out pPatientID, out pPatientVisitID);
        PatientVisit_BL oPatVisit_BL = new PatientVisit_BL(base.ContextInfo);
        Patient_BL oPatient_BL = new Patient_BL(base.ContextInfo);
        oPatient_BL.GetPatientDemoandAddress(patientID, out lstPatient);
        oPatVisit_BL.GetVisitDetails(patientVisitID, out lstPatientVisit);

        if (chkboxPrintOPCard.Checked)
        {
            if (Request.QueryString["PNO"] != null)
            {
                PrintNewPatientVisitDetailsXml();
            }
            else
            {
                PrintExistingPatientVisitDetailsXml();
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintOpCard", "PrintOpCard();", true);
        }
        GenerateBarCodeOutput();
        string str = hdnSelectOnOption.Value;
        if (hdnResetAll.Value == "Y")
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
        }
        QPR.SetDate();
        clearNonReimburseFields();
    }
    #endregion

    private void GenerateBarCodeOutput()
    {
        string barcodeConfigValue = GetConfigValue("PRINT_BARCODE_ON_PATIENT_VISIT_REGISTRATION", OrgID);
        if (string.Compare(barcodeConfigValue, "Y") == 0)
        {
            if (lstPatient != null && lstPatient.Count > 0 && lstPatientVisit != null && lstPatientVisit.Count > 0)
            {
                long visitId = lstPatientVisit[0].PatientVisitId;
                // ScriptManager.RegisterStartupScript(this, this.GetType(), "PrintBarCode", "PrintVisitNumberAsBarCode(" + lstPatientVisit[0].PatientVisitId + ", " + OrgID + "'Visit_Number');", true);
                // Check if the patient is newly created. If that's the case, generate a barcode for MRD File. The Page redirection will have a valid query string and that'e the indication for New Patient
                if (Request.QueryString["PNO"] != null)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintMRDBarCode", "window.open('../admin/PrintBarcode.aspx?&IsPopup=Y&visitId=" + visitId + "&billId=0" + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.MRDNumber + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);
                }
                // Print Visit number in bar code format
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "PrintVisitBarCode", "window.open('../admin/PrintBarcode.aspx?&IsPopup=Y&visitId=" + visitId + "&billId=0" + "&orgId=" + OrgID + "&categoryCode=" + BarcodeCategory.VisitNumber + "','','width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes');", true);

            }
        }
    }

    protected void btnTempSave_Click(object sender, EventArgs e)
    {
        try
        {
            long pPatientID = -1, pPatientVisitID = -1;
            SavePatientandVisit(out pPatientID, out pPatientVisitID);
            List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
            lstPatientDueChart = dspData.GetConsNProDetails();
            string str = hdnSelectOnOption.Value;
            returnCode = new Patient_BL(base.ContextInfo).InsertTemporaryBills(patientID, pPatientVisitID, lstPatientDueChart);
            if (hdnResetAll.Value == "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:ReSetAllDetails();", true);

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "printQuickBill", "ItemscloseData();SetPanelOPorIP('OP','" + str + "');SetBillingOption();ResetOldValues('OP');", true);
            }
            QPR.SetDate();
            clearNonReimburseFields();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Generate Visit and Temp Save in Quick Billing", ex);
        }
    }


    #region PrintExistingPatientVisitDetailsXml
    /// <summary>
    /// creating xml for print op bill
    /// </summary>
    private void PrintExistingPatientVisitDetailsXml()
    {
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        PatientVisit_BL returnCodeINV = new PatientVisit_BL(base.ContextInfo);
        returnCodeINV.GetVisitDetails(patientVisitID, out lstPatientVisit);
        
        using (var sw = new StringWriter())
        {
            using (var xw = XmlWriter.Create(sw))
            {
                xw.WriteStartDocument();
                xw.WriteStartElement("GenerateVisit");

                xw.WriteStartElement("Department", "");
                DropDownList ddlDepartment = (DropDownList)QPR.FindControl("ddlDepartment");
                if (!ddlDepartment.SelectedItem.Text.Equals("--Select--"))
                {
                    xw.WriteString(ddlDepartment.SelectedItem.Text);
                }
                xw.WriteEndElement();


                xw.WriteStartElement("VisitPurpose", "");
                HiddenField hdnVisitPurposeText = (HiddenField)QPR.FindControl("hdnVisitPurposeText");
                if (!hdnVisitPurposeText.Value.Equals("-----Select-----"))
                {
                    xw.WriteString(hdnVisitPurposeText.Value);
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].VisitNumber))
                {
                    xw.WriteString(lstPatientVisit[0].VisitNumber);
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("VisitDate", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString()))
                {
                    xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                }
                else
                {
                    xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString());
                }
                xw.WriteEndElement();

                xw.WriteStartElement("SerialNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].PatientVisitId.ToString()))
                {
                    xw.WriteString(lstPatientVisit[0].PatientVisitId.ToString());
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("MediacalRecordNo", "");
                if (!string.IsNullOrEmpty(lstPatientVisit[0].PatientNumber))
                {
                    xw.WriteString(lstPatientVisit[0].PatientNumber);
                }
                else
                {
                    xw.WriteString("00");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("PatientName", "");
                TextBox txtPatientName = (TextBox)QPR.FindControl("txtPatientName");
                if (!string.IsNullOrEmpty(txtPatientName.Text.Trim()))
                {
                    xw.WriteString(txtPatientName.Text.Trim());
                }
                xw.WriteEndElement();

                xw.WriteStartElement("DOB", "");
                TextBox tDOB = (TextBox)QPR.FindControl("tDOB");
                if (!string.IsNullOrEmpty(tDOB.Text.Trim()))
                {
                    xw.WriteString(tDOB.Text.Trim());
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Age", "");
                string age = string.Empty;
                TextBox txtDOBNos = (TextBox)QPR.FindControl("txtDOBNos");
                if (!string.IsNullOrEmpty(txtDOBNos.Text.Trim()))
                {
                    age = " " + txtDOBNos.Text.Trim();
                }
                DropDownList ddlDOBDWMY = (DropDownList)QPR.FindControl("ddlDOBDWMY");
                if (!string.IsNullOrEmpty(ddlDOBDWMY.SelectedItem.Text))
                {
                    age += " " + ddlDOBDWMY.SelectedItem.Text;
                }
                xw.WriteString(age);
                xw.WriteEndElement();

                xw.WriteStartElement("Insurance", "");
                xw.WriteString(lblInsuranceName.Text.Trim());
                xw.WriteEndElement();

                xw.WriteStartElement("InsuranceName", "");
                TextBox txtClient = (TextBox)uctlClientTpa.FindControl("txtClient");
                if (!string.IsNullOrEmpty(txtClient.Text.Trim()))
                {
                    xw.WriteString(txtClient.Text.Trim());
                }
                xw.WriteEndElement();

                xw.WriteStartElement("LoginName", "");
                xw.WriteString(LoginName);
                xw.WriteEndElement();

                xw.WriteEndElement();
                xw.WriteEndDocument();
                xw.Close();

                XmlDocument xml = new XmlDocument();
                xml.LoadXml(sw.ToString());
                ///xml.Save(Server.MapPath("GenerateVisit.xml"));
                XslTransform xsl = new XslTransform();
                string s = Server.MapPath("..\\xsl\\GenerateVisit.xsl");
                xsl.Load(s);

                XmlOP.Document = xml;
                XmlOP.Transform = xsl;

            }
        }
    }
    #endregion

    #region PrintNewPatientVisitDetailsXml
    /// <summary>
    /// creating xml for print op bill
    /// </summary>
    private void PrintNewPatientVisitDetailsXml()
    {
        try
        {
            if (patientVisitID.Equals(-1))
            {
                patientVisitID = 0;
            }
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            PatientVisit_BL returnCodeINV = new PatientVisit_BL(base.ContextInfo);
            returnCodeINV.GetVisitDetails(patientVisitID, out lstPatientVisit);

            List<Patient> lstPatient = new List<Patient>();
            Patient_BL oPatient_BL = new Patient_BL(base.ContextInfo);
            oPatient_BL.GetPatientDemoandAddress(patientID, out lstPatient);

            using (var sw = new StringWriter())
            {
                using (var xw = XmlWriter.Create(sw))
                {
                    xw.WriteStartDocument();
                    xw.WriteStartElement("PatientIdentificationSheet");

                    xw.WriteStartElement("VisitNo", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitNumber)))
                    {
                        xw.WriteString(lstPatientVisit[0].VisitNumber);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("VisitDate", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString())))
                    {
                        xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("MedicalRecordNo", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].PatientNumber)))
                    {
                        xw.WriteString(lstPatientVisit[0].PatientNumber);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("PatientName", "");
                    if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].Name)))
                    {
                        xw.WriteString(lstPatient[0].Name);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Location", "");
                    if (lstPatient.Count != 0 && (!string.IsNullOrEmpty(lstPatient[0].PlaceOfBirth)))
                    {
                        xw.WriteString(lstPatient[0].PlaceOfBirth);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("DOB", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].DOB.ToString()))
                    {
                        xw.WriteString(lstPatient[0].DOB.ToString());
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Age", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].Age))
                    {
                        xw.WriteString(lstPatient[0].Age);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Sex", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].Sex)))
                    {
                        xw.WriteString(lstPatientVisit[0].Sex);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Religion", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].Religion))
                    {
                        xw.WriteString(lstPatient[0].Religion);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Address", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].Address)))
                    {
                        xw.WriteString(lstPatientVisit[0].Address);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("RTRW", "");
                    xw.WriteString("----");
                    xw.WriteEndElement();

                    xw.WriteStartElement("Kelurahan", "");
                    xw.WriteString("----");
                    xw.WriteEndElement();

                    xw.WriteStartElement("Kecamatan", "");
                    xw.WriteString("----");
                    xw.WriteEndElement();

                    xw.WriteStartElement("City", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].City)))
                    {
                        xw.WriteString(lstPatientVisit[0].City);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("State", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].StateName))
                    {
                        xw.WriteString(lstPatient[0].StateName);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("TelephoneNo", "");
                    if (lstPatient.Count != 0 && lstPatient[0].MobileNumber != null)
                    {
                        xw.WriteString(lstPatient[0].MobileNumber.ToString());
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Country", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].CountryName))
                    {
                        xw.WriteString(lstPatient[0].CountryName);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();
                    xw.WriteStartElement("NoKTP", "");
                if (!string.IsNullOrEmpty(lstPatient[0].URNO))
                {
                    xw.WriteString(lstPatient[0].URNO);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                xw.WriteStartElement("Qualification", "");
                if (!string.IsNullOrEmpty(lstPatient[0].TypeName))
                {
                    xw.WriteString(lstPatient[0].TypeName);
                }
                else
                {
                    xw.WriteString("----");
                }
                xw.WriteEndElement();

                    xw.WriteStartElement("Occupation", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].OCCUPATION))
                    {
                        xw.WriteString(lstPatient[0].OCCUPATION);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("MaritalStatus", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].MartialStatus))
                    {
                        xw.WriteString(lstPatient[0].MartialStatus);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("LastVisitDate", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].VisitDate.ToString())))
                    {
                        xw.WriteString(lstPatientVisit[0].VisitDate.ToString());
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Insurance", "");
                    if (lstPatientVisit.Count != 0 && (!string.IsNullOrEmpty(lstPatientVisit[0].ClientName)))
                    {
                        xw.WriteString(lstPatientVisit[0].ClientName);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Department", "");
                    if (!string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                    {
                        xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("SubDepartment", "");
                    if (!string.IsNullOrEmpty(lstPatientVisit[0].EmpDeptCode))
                    {
                        xw.WriteString(lstPatientVisit[0].EmpDeptCode);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Speciality", "");
                    if (!string.IsNullOrEmpty(lstPatient[0].SpecialityName))
                    {
                        xw.WriteString(lstPatient[0].SpecialityName);
                    }
                    else
                    {
                        xw.WriteString("----");
                    }
                    xw.WriteEndElement();

                    xw.WriteStartElement("Allergy", "");
                    xw.WriteString("----");
                    xw.WriteEndElement();

                    xw.WriteStartElement("CurrentDate", "");
                    xw.WriteString(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString());
                    xw.WriteEndElement();

                    xw.WriteStartElement("LoginName", "");
                    if (!string.IsNullOrEmpty(Name))
                    {
                        xw.WriteString(Name);
                    }
                    else
                    {
                        xw.WriteString("Officer Sign");
                    }
                    xw.WriteEndElement();

                    xw.WriteEndDocument();
                    xw.Close();

                    XmlDocument xml = new XmlDocument();
                    xml.LoadXml(sw.ToString());
                    ///xml.Save(Server.MapPath("GenerateVisit.xml"));
                    XslTransform xsl = new XslTransform();
                    string s = Server.MapPath("..\\xsl\\patientIdentificationSheet.xsl");
                    xsl.Load(s);

                    XmlOP.Document = xml;
                    XmlOP.Transform = xsl;

                }
            }
        }
        catch (Exception ec)
        {

        }
    }
    #endregion
} 