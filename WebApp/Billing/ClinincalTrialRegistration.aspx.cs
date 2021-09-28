﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.IO;
using Attune.Podium.BillingEngine;
using System.Data;
using System.Text;
using System.Security.Cryptography;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;


public partial class Billing_ClinincalTrialRegistration : BasePage
{
    //BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
    //List<Salutation> lstTitles = new List<Salutation>();
    //List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
    //List<Country> lstNationality = new List<Country>();
    //List<Country> lstCountries = new List<Country>();
    //List<BillingFeeDetails> lstDetails = new List<BillingFeeDetails>();
    Patient objPatient = new Patient();
    //FinalBill objFinalBill = new FinalBill();
    string vType = string.Empty, AgeUnit = string.Empty, BillNumber = string.Empty, Labno = string.Empty, pathname = string.Empty;
    long patientID = -1, patientVisitID = -1, returnCode = -1, taskID = -1;
    int AgeValue = 0, ClientID = 0;
    string ddlClientName;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgID.Value = OrgID.ToString();

        if (!IsPostBack)
        {

            AutoCompleteExtenderClientCorp.ContextKey = OrgID.ToString() + "~" + "CORP";
            AutoAuthorizer.ContextKey = OrgID.ToString();
            AutoCompleteExtenderPatient.ContextKey = OrgID.ToString();
            //ddSalutation.Attributes.Add("onchange", "setSexValueQB('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "' ,'" + ddMarital.ClientID.ToString() + "');");
            //ddlSex.Attributes.Add("onchange", "setSexValueopt('" + ddlSex.ClientID.ToString() + "','" + ddSalutation.ClientID.ToString() + "');");
            tDOB.Attributes.Add("onchange", "ExcedDate('" + tDOB.ClientID.ToString() + "','',0,0);");
            LoadQuickBillLoading();
            hndLocationID.Value = ILocationID.ToString();
            AutoCompleteExtenderClientCorp.ContextKey = "";

            ucControlList.LoadCustomerControls(0, "VST", "", -1, new List<ControlMappingDetails>());
            hdnIsReceptionPhlebotomist.Value = GetConfigValue("IsReceptionPhlebotomist", OrgID);
        }
    }



    #region PageLoadingData

    public void LoadQuickBillLoading()
    {
        List<Salutation> lstTitles = new List<Salutation>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Country> lstNationality = new List<Country>();
        List<Country> lstCountries = new List<Country>();

        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        string LanguageCode = string.Empty;
        LanguageCode = ContextInfo.LanguageCode;
        billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
        LoadTitle(lstTitles);
        LoadDiscount();
        LoadMeatData();
        loadRateType();
        loadClient();

    }

    public void loadClient()
    {

        SharedInventorySales_BL inventorySalesBL = new SharedInventorySales_BL(base.ContextInfo);
        List<ClientMaster> lstclients = new List<ClientMaster>();
        inventorySalesBL.GetClientNames(OrgID, out lstclients);
        var temp = lstclients.FindAll(p => p.ClientCode == "GENERAL");
        if (lstclients.Count > 0)
        {
            hdnBaseClientID.Value = temp[0].ClientID.ToString();
        }

    }
    public void loadRateType()
    {
        try
        {
            long Returncode = -1;
            List<RateMaster> lstRateMaster = new List<RateMaster>();
            Master_BL MasterBL = new Master_BL(base.ContextInfo);
            Returncode = MasterBL.pGetRateName(OrgID, out lstRateMaster);
            if (lstRateMaster.Count > 0)
            {
                var temp = lstRateMaster.FindAll(p => p.RateCode == "GENERAL");
                if (temp.Count > 0)
                {
                    hdnBaseRateID.Value = temp[0].RateId.ToString();
                    hdnRateID.Value = temp[0].RateId.ToString();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load data", ex);
        }
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


    private void LoadTitle(List<Salutation> lstTitles)
    {
        try
        {
            int titleID = 0;
            List<Salutation> titles = new List<Salutation>();
            Salutation selectedSalutation = new Salutation();

            List<Salutation> childItems = (from child in lstTitles
                                           where (child.TitleName == "Mr.") || (child.TitleName == "Ms.") || (child.TitleName == "Mrs.")
                                           || (child.TitleName == "Baby.") || (child.TitleName == "Others.") || (child.TitleName == "Pet.")
                                           || (child.TitleName == "Undisclosed.")
                                           select child).ToList();


            ddSalutation.DataSource = childItems;
            ddSalutation.DataTextField = "TitleName";
            ddSalutation.DataValueField = "TitleID";
            ddSalutation.DataBind();
            selectedSalutation = lstTitles.Find(Findsalutation);
            ddSalutation.SelectedValue = selectedSalutation.TitleID.ToString();
            Int32.TryParse(ddSalutation.SelectedItem.Value, out titleID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in patient registration.Message:", ex);
        }
    }
    static bool Findsalutation(Salutation s)
    {
        if (s.TitleName.ToUpper().Trim() == "MR.")
        {
            return true;
        }
        return false;
    }
    public void LoadMeatData()
    {
        try
        {

            long returncode = -1;
            string domains = "DateAttributes,Gender,MaritalStatus,PatientType,PatientStatus,PatientStatusinCollection";
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
                                 where child.Domain == "DateAttributes"
                                 select child;
                if (childItems.Count() > 0)
                {
                    ddlDOBDWMY.DataSource = childItems;
                    ddlDOBDWMY.DataTextField = "DisplayText";
                    ddlDOBDWMY.DataValueField = "DisplayText";
                    ddlDOBDWMY.DataBind();
                    ddlDOBDWMY.SelectedValue = "Year(s)";
                }

                var childItems1 = from child in lstmetadataOutput
                                  where child.Domain == "Gender"
                                  select child;

                if (childItems1.Count() > 0)
                {
                    ddlSex.DataSource = childItems1;
                    ddlSex.DataTextField = "DisplayText";
                    ddlSex.DataValueField = "Code";
                    ddlSex.DataBind();
                    ddlSex.Items.Insert(0, "--Select--");
                    ddlSex.Items[0].Value = "0";
                    ddlSex.SelectedValue = "M";
                }



                //var childItems2 = from child in lstmetadataOutput
                //                  where child.Domain == "MaritalStatus"
                //                  select child;

                //if (childItems2.Count() > 0)
                //{
                //    ddMarital.DataSource = childItems2;
                //    ddMarital.DataTextField = "DisplayText";
                //    ddMarital.DataValueField = "Code";
                //    ddMarital.DataBind();
                //    ddMarital.Items.Insert(0, "--Select--");
                //    ddMarital.Items[0].Value = "0";
                //    ddMarital.SelectedValue = "S";
                //}

                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "PatientStatusinCollection"
                                  select child;

                if (childItems3.Count() > 0)
                {
                    ddlStatus.DataSource = childItems3;
                    ddlStatus.DataTextField = "DisplayText";
                    ddlStatus.DataValueField = "Code";
                    ddlStatus.DataBind();
                    ddlStatus.Items.Insert(0, "--Select--");
                    ddlStatus.Items[0].Value = "0";
                }

            }
            // }
        }




        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data like Custom Period,Search Type ... ", ex);

        }
    }

    #endregion


    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        SaveData();
    }
    public void SaveData()
    {
        btnGenerate.Style.Add("display", "none");
        btnClose.Style.Add("display", "none");
        long pSpecialityID = 0, FinalBillID = 0, patientVisitID = -1;
        int returnStatus = -1, SavePicture = -1;

        FinalBill objFinalBill = new FinalBill();
        string gUID = string.Empty, paymentstatus = "Paid", ReferralType = "";
        DataTable dtAmountReceivedDet = null;
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<TaxBillDetails> lstTaxDetails = new List<TaxBillDetails>();
        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
        List<PatientReferringDetails> lstPatientReferringDetails = new List<PatientReferringDetails>();
        List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
        List<PatientDisPatchDetails> lstDispatchDetails = new List<PatientDisPatchDetails>();
        List<OrderedInvestigations> lstPkgandGrps = new List<OrderedInvestigations>();
        int age = 0, needTaskDisplay = -1; ;
        long vpurpose = -1;
        string sVal;
        long PatientRoleID = 0;
        string[] SplitAge;
        string strCollectAgain = string.Empty, strSampleRelationshipID = string.Empty;
        /******Added by Vijayalakshmi.M***********/
        string StatFlag = string.Empty;
        string ClientFlag = string.Empty;

        if (!string.IsNullOrEmpty(hdnCheckFlag.Value))
        {
            StatFlag = hdnCheckFlag.Value;
        }
        if (!string.IsNullOrEmpty(hdnClientFlag.Value))
        {
            ClientFlag = hdnClientFlag.Value;
        }
        objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();

        patientID = Convert.ToInt64(hdnPatientID.Value);

        sVal = GetConfigValue("SampleCollect", OrgID);
        objPatient = GetPatientDetails();

        SplitAge = objPatient.Age.Split('~');
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
        List<VisitTemplate> visittemplate = new List<VisitTemplate>();
        List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
        objFinalBill = GetFinalBillDetails(out lstVisitClientMapping);
        dtAmountReceivedDet = PaymentType.GetAmountReceivedDetails();
        lstPatientDueChart = GetBillingItems();
        lstTaxDetails = getTaxDetails();
        lstInv = GetOrderedInvestigations(patientVisitID, out gUID);
        List<ControlMappingDetails> lstControlSavedValues = new List<ControlMappingDetails>();
        ucControlList.getControlsValues(out lstControlSavedValues);
        patientID = Convert.ToInt64(hdnPatientID.Value);
        long SiteID = Convert.ToInt64(hdnEpisodeClientID.Value);
        string VisitSampleStatus = ddlStatus.SelectedItem.Text;
        DateTime dtSampleDate;
        DateTime.TryParse(txtSampleDate.Text.Trim(), out dtSampleDate);
        //string strUnscheduled =Convert.ToString(chkUnscheduled.Checked);
        string ConsignmentNo = txtConsignment.Text;
        objPatient.RegistrationRemarks = string.Empty;
        string IsEditMode = "N";
        long taskId = -1;
        List<PatientVisitLanguage> objlang = new List<PatientVisitLanguage>();
        try
        {
            List<Attune.Podium.BusinessEntities.PatientRedemDetails> lstPatientRedemDetails = new List<PatientRedemDetails>();
            List<PatientDiscount> lstPatientDiscount = new List<PatientDiscount>();
            new Patient_BL(base.ContextInfo).InsertPatientBilling(objPatient, objFinalBill, Convert.ToInt64(hdnReferedPhyID.Value),
                                                Convert.ToInt32(hdnRefPhySpecialityID.Value), pSpecialityID, lstPatientDueChart, AgeValue, AgeUnit,
                                                pSpecialityID, ReferralType, paymentstatus, gUID, dtAmountReceivedDet, lstInv, lstTaxDetails,
                                                out lstBillingDetails, out returnStatus, SavePicture, sVal, RoleID, LID, PageContextDetails,
                                                hdnIsReceptionPhlebotomist.Value, 1, "", Convert.ToInt64(hdnClientByEpisodeID.Value),
                                                Convert.ToInt64(hdnEpisodeVisitID.Value), Convert.ToInt64(hdnVisitTrackID.Value), SiteID, VisitSampleStatus,
                                                dtSampleDate, ConsignmentNo, lstControlSavedValues, IsEditMode, out needTaskDisplay, lstDispatchDetails, lstVisitClientMapping, out PatientRoleID, 0, -1, "", "", "", out taskId, "", lstPatientDiscount, "", "", "", "", "", 0, "", 0, 0, 0, 0, 0, lstPatientRedemDetails, lstPkgandGrps, StatFlag, ClientFlag, 0, "", "", "", "", visittemplate, objlang,"","","");
            if (lstBillingDetails.Count > 0 && returnStatus >= 0)
            {
                patientVisitID = lstBillingDetails[0].VisitID;
                Labno = lstBillingDetails[0].LabNo;
                FinalBillID = lstBillingDetails[0].FinalBillID;
                patientID = lstBillingDetails[0].PatientID;
                hdnVisitID.Value = lstBillingDetails[0].VisitID.ToString();
                hdnFinalBillID.Value = lstBillingDetails[0].FinalBillID.ToString();


                if (chkUploadPhoto.Checked == true)
                {
                    SaveTRFPicture(Convert.ToString(patientID), Convert.ToString(patientVisitID));
                }

                if (hdnIsReceptionPhlebotomist.Value == "Y")
                {
                    int taskactionID = (int)TaskHelper.TaskAction.CollectSample;
                    hdnPageUrl.Value = "/Lab/InvestigationSample.aspx?pid=" + patientID.ToString()
                                        + "&vid=" + patientVisitID.ToString()
                                        + "&gUID=" + gUID
                                        + "&taskactionid=" + taskactionID
                                        + "&LNo=" + lstBillingDetails[0].LabNo
                                        + "&RNo" + lstBillingDetails[0].LabNo
                                        + "&POrgID" + OrgID.ToString()
                                        + "&IsCT=Y";

                    Response.Redirect(Request.ApplicationPath + hdnPageUrl.Value, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, GetType(), "alt", "alter('Sample Registered');", true);
                }


            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "altSaveFailed", "alert('Error While Saving Data');clearPageControlsValue('N');", true);
            }

        }
        catch (Exception ex)
        {

            CLogger.LogError("Error While Save Patient and Billing in Lab Quick Billing", ex);
        }

    }

    public void PrintBilling(long PatientID, long patientVisitID, long FinalBillID, long vpurpose, string ddlClientName)
    {
        string sPage = string.Empty;
        //hdnPageUrl.Value = "/Reception/ViewPrintPage.aspx?pid=" + patientID.ToString()
        //                    + "&vid=" + patientVisitID.ToString()
        //                    + "&pageid=BP&quickbill=Y&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";

        //Response.Redirect(Request.ApplicationPath  + hdnPageUrl.Value, true);

        sPage = "../Reception/PrintPage.aspx?pid=" + patientID.ToString()
                    + "&vid=" + patientVisitID.ToString()
                    + "&pagetype=BP&quickbill=N&bid=" + FinalBillID + "&visitPur=" + vpurpose + "&ClientName=" + ddlClientName + "&OrgID=" + OrgID + "&IsPopup=Y" + "&RedirectPage=/Billing/LabQuickBilling.aspx";
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear", "javascript:clearPageControlsValue('N');OpenBillPrint('" + sPage + "');ClearControlValues();", true);
        ClearValues();
    }


    public List<OrderedInvestigations> GetOrderedInvestigations(long visitID, out string gUID)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        gUID = Guid.NewGuid().ToString();

        List<OrderedInvestigations> lstOrderedInvestigations = new List<OrderedInvestigations>();
        //long tempAdd = 0;
        OrderedInvestigations PatientInves;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();

        //CLogger.LogWarning(hdfBillType1.Value.ToString());
        string sNewDatas = "";
        sNewDatas = prescription;
        string sVal = GetConfigValue("SampleCollect", OrgID);

        foreach (string row in sNewDatas.Split('|'))
        {
            PatientInves = new OrderedInvestigations();
            if (row.Trim().Length != 0)
            {
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    //"RID^" + 0 + "~FeeType^" + FeeType + "~FeeID^" + FeeID + "~OtherID^" + OtherID + "~Descrip^" + Descrip + "~Quantity^" + Quantity + "~Amount^" + Amount + "~Total^" + Total + "";
                    colValue = colValue.Trim();

                    switch (colName)
                    {
                        case "FeeID":
                            colValue = colValue == "" ? "0" : colValue;
                            PatientInves.ID = Convert.ToInt64(colValue);
                            break;
                        case "Descrip":
                            PatientInves.Name = colValue;
                            break;
                        case "Amount":
                            colValue = colValue == "" ? "0" : colValue;
                            PatientInves.Rate = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":

                            PatientInves.Type = colValue;
                            break;
                        case "refType":
                            PatientInves.ReferenceType = colValue;
                            break;
                        case "refPhyID":
                            if (colValue != null && colValue != "")
                            {
                                PatientInves.RefPhysicianID = Int64.Parse(colValue);
                            }
                            break;
                        case "refPhyName":
                            PatientInves.RefPhyName = colValue;
                            break;


                    };

                }
                //if (tempAdd == 0)
                //{
                PatientInves.UID = gUID;
                PatientInves.StudyInstanceUId = CreateUniqueDecimalString();
                PatientInves.VisitID = visitID;
                PatientInves.OrgID = OrgID;
                PatientInves.PaymentStatus = "Paid";
                PatientInves.Status = "Ordered";
                if (sVal.Trim() == "N")
                {
                    PatientInves.Status = "Paid";
                }

                if (PatientInves.Type == "INV" || PatientInves.Type == "GRP" || PatientInves.Type == "PKG")
                {
                    lstOrderedInvestigations.Add(PatientInves);
                }
            }
        }
        return lstOrderedInvestigations;
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
    //public void SendSms(Patient lstPatient)
    //{
    //    Communication.SendSMS("Dear " + lstPatient.Name + ",\nYour test request has been registered successfully with\n" + OrgName + " at " + String.Format("{0:dd-MM-yyyy hh:mm:ss tt}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ". Thank you.", lstPatient.PatientAddress[0].MobileNumber.Trim());
    //}
    public List<PatientDueChart> GetBillingItems()//string feeType)
    {
        string prescription = string.Empty;
        string newPrescription = string.Empty;
        string dtoRemove = string.Empty;
        //long tempAdd=0;
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();

        PatientDueChart objBilling;
        if (hdfBillType1.Value != null)
            prescription = hdfBillType1.Value.ToString();
        //CLogger.LogWarning(hdfBillType1.Value.ToString());
        string sNewDatas = "";
        sNewDatas = prescription;
        //DataRow dr;
        foreach (string row in sNewDatas.Split('|'))
        {
            objBilling = new PatientDueChart();
            if (row.Trim().Length != 0)
            {
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    colValue = colValue.Trim();
                    switch (colName)
                    {
                        case "FeeID":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.FeeID = Convert.ToInt64(colValue);
                            break;

                        case "Descrip":
                            objBilling.Description = colValue;
                            break;


                        case "Amount":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Amount = Convert.ToDecimal(colValue);
                            break;
                        case "Quantity":
                            colValue = colValue == "" ? "0" : colValue;
                            objBilling.Unit = Convert.ToDecimal(colValue);
                            break;
                        case "FeeType":
                            if (colValue.ToUpper() == "LAB")
                            {
                                colValue = "INV";
                            }
                            objBilling.FeeType = colValue;
                            break;

                        case "IsReimbursable":
                            if (colValue == "Yes")
                            {
                                objBilling.IsReimbursable = "Y";
                            }
                            else
                            {
                                objBilling.IsReimbursable = "N";
                            }

                            break;

                        case "Remarks":

                            objBilling.Remarks = colValue;
                            break;

                    };
                    objBilling.Status = "Paid";
                    objBilling.FromDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt"));
                    objBilling.ToDate = Convert.ToDateTime(Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt"));
                }
                //if (tempAdd == 0)
                //{
                lstPatientDueChart.Add(objBilling);
                //}
            }
        }
        return lstPatientDueChart;
    }
    private List<TaxBillDetails> getTaxDetails()
    {
        List<TaxBillDetails> lstTax = new List<TaxBillDetails>();
        if (hdfTax.Value != null)
        {
            foreach (string sValue in hdfTax.Value.ToString().Split('>'))
            {
                if (sValue != "" && sValue != "0.00")
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
    public Patient GetPatientDetails()
    {
        Patient patient = new Patient();

        try
        {
            UserAddress useAddress = new UserAddress();
            short CountryID;
            short StateID;
            PatientAddress PA = new PatientAddress();
            Int16 age = 0;
            DateTime DOB = new DateTime();
            objPatient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();

            List<PatientAddress> pAddresses = new List<PatientAddress>();

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

            string finalPName = txtName.Text.ToString();


            patient.PatientID = Convert.ToInt64(hdnPatientID.Value);
            patient.OrgID = OrgID;
            patient.CreatedBy = LID;
            patient.Name = finalPName;
            patient.TITLECode = Convert.ToByte(ddSalutation.SelectedValue);
            //patient.SEX = ddlSex.SelectedValue;
            patient.SEX = ddlSex.SelectedValue;
            DOB = new DateTime(1800, 1, 1);
            tDOB.Text = tDOB.Text.Trim() == "" ? "01/01/1800" : tDOB.Text.Trim();
            patient.DOB = Convert.ToDateTime(tDOB.Text);
            Int16.TryParse(txtDOBNos.Text.Trim(), out age);
            patient.Age = age.ToString() + "~" + ddlDOBDWMY.SelectedValue.ToString();
            patient.PatientNumber = hdnPatientNumber.Value;

            PA.Add1 = "";
            PA.Add2 = "";
            PA.City = "Chennai";
            patient.Add3 = "";
            PA.AddressType = "P";
            PA.LandLineNumber = "";
            PA.MobileNumber = "";
            hdnMobileNumber.Value = "";
            CountryID = 75;
            StateID = 31;

            PA.CountryID = CountryID;
            PA.StateID = StateID;
            pAddresses.Add(PA);
            patient.PatientAddress = pAddresses;
            //patient.MartialStatus = ddMarital.SelectedValue.ToString();
            patient.CompressedName = finalPName.ToString();
            patient.Nationality =81;
            patient.StateID = StateID;
            patient.CountryID = CountryID;
            patient.PostalCode = "";
            patient.RegistrationFee = 0;
            patient.SmartCardNumber = "0";
            patient.RelationName = "";
            patient.RelationTypeId = 0;
            patient.Race = "";
            patient.EMail = "";
            patient.VisitPurposeID = 3;
            ClientID = hdnClientID.Value == "-1" ? Convert.ToInt32(hdnBaseClientID.Value) : Convert.ToInt32(hdnClientID.Value);
            patient.ClientID = ClientID;
            patient.SecuredCode = System.Guid.NewGuid().ToString();
            patient.RateID = Convert.ToInt32(hdnRateID.Value);
            //patient.PriorityID = ddlPriority.SelectedValue;
            patient.ReferingPhysicianName = "";
            //patient.ReferedHospitalID = Convert.ToInt32(hdfReferalHospitalID.Value);
            patient.ReferedHospitalName = "";
            patient.TPAID = Convert.ToInt64(hdnTPAID.Value);
            patient.TPAName = "";
            patient.TypeName = hdnClientType.Value;
            patient.TPAAttributes = "";
            patient.PatientVisitID = 0;
            patient.PatientHistory = txtPatientHistory.Text.Trim();
            //patient.PatientType = ddlPatientType.SelectedValue;
            //patient.PatientStatus = ddlPatientStatus.SelectedValue;
            return patient;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving patient & Billing details in Lab Quick Bill.", ex);
            return patient;
        }
    }
    public FinalBill GetFinalBillDetails(out List<VisitClientMapping> lst)
    {
        FinalBill finalBill = new FinalBill();
        lst = new List<VisitClientMapping>();
        VisitClientMapping VisitClientMapping = new VisitClientMapping();
        decimal AmountReceived = 0, Due = 0, pRoundOff = 0, Currentdue = 0, dServiceCharge = 0, discount = 0, GrossValue = 0, NetValue = 0, TaxAmount = 0;
        string gUID = string.Empty, refPhyName = "", finalPName = string.Empty, DiscountReason = string.Empty;
        int rateID = 0, TPAID = 0;
        long FinalBillID = 0;
        long MappingClientID = 0;

        decimal pNonMedicalAmtPaid = decimal.Zero;
        decimal pCoPayment = decimal.Zero;
        decimal pExcess = decimal.Zero;
        try
        {
            decimal.TryParse(hdnAmountReceived.Value, out AmountReceived);
            decimal.TryParse(hdnDue.Value, out Due);
            decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);
            decimal.TryParse(hdnDiscountAmt.Value, out discount);
            decimal.TryParse(hdnGrossValue.Value, out GrossValue);
            decimal.TryParse(hdnNetAmount.Value, out NetValue);
            decimal.TryParse(hdnTaxAmount.Value, out TaxAmount);
            decimal.TryParse(hdnRoundOff.Value, out pRoundOff);
            NetValue = GrossValue + TaxAmount - discount + dServiceCharge;
            //Currentdue = (NetValue) - AmountReceived;
            MappingClientID = Convert.ToInt32(hdnMappingClientID.Value);



            finalBill.OrgAddressID = ILocationID;
            finalBill.FinalBillID = FinalBillID;
            //---------------------------------------------------------------------------------------------------------
            finalBill.OrgID = OrgID;
            finalBill.VisitID = patientVisitID;
            finalBill.StdDedID = 0;

            finalBill.GrossBillValue = Convert.ToDecimal(hdnGrossValue.Value.ToString());
            finalBill.DiscountAmount = Convert.ToDecimal(hdnDiscountAmt.Value);
            finalBill.DiscountReason = txtDiscountReason.Text;
            finalBill.DiscountApprovedBy = Convert.ToInt64(hdnDiscountApprovedBy.Value);
            finalBill.RoundOff = pRoundOff;
            finalBill.ServiceCharge = dServiceCharge;
            finalBill.NetValue = finalBill.GrossBillValue + dServiceCharge + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim())
                                    - finalBill.DiscountAmount
                                    + pRoundOff;
            finalBill.AmountReceived = Convert.ToDecimal(hdnAmountReceived.Value);
            finalBill.Due = Due;
            finalBill.IsCreditBill = txtClient.Text == "" ? "Y" : "N";
            VisitClientMapping.PreAuthAmount = 0;
            finalBill.TaxAmount = Convert.ToDecimal(hdnTaxAmount.Value);


            Int32.TryParse(hdnRateID.Value, out rateID);
            ClientID = hdnClientID.Value == "-1" ? Convert.ToInt32(hdnBaseClientID.Value) : Convert.ToInt32(hdnClientID.Value);
            //Int32.TryParse(hdnClientID.Value, out ClientID);
            Int32.TryParse(hdnTPAID.Value, out TPAID);
            finalBill.IsCreditBill = txtClient.Text == "" ? "N" : "Y";

            finalBill.ClientName = "";
            VisitClientMapping.CoPayment = pCoPayment;
            VisitClientMapping.NonMedicalAmount = pNonMedicalAmtPaid;
            finalBill.ExcessAmtRecd = pExcess;
            finalBill.CurrentDue = Due;

            lst.Add(VisitClientMapping);
            if (Convert.ToDecimal(hdnAmountReceived.Value) <= 0)
            {
                finalBill.Due = finalBill.GrossBillValue + Convert.ToDecimal(hdnTaxAmount.Value.ToString().Trim()) - finalBill.DiscountAmount + pRoundOff;
            }
            finalBill.CreatedBy = LID;

            DateTime ReportCommitedDate = Convert.ToDateTime("01/01/1753");
            finalBill.TATDate = ReportCommitedDate;
            return finalBill;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving patient & Billing details in Lab Quick Bill.", ex);
            return finalBill;
        }
    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }






    private long SaveTRFPicture(String Pnumber, String visitid)
    {
        Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
        string VisitID = string.Empty;
        String VisitNumber = String.Empty;

        pathname = GetConfigValue("TRF_UploadPath", OrgID);
        new Patient_BL(base.ContextInfo).GetPatientVisitNumber(Convert.ToInt64(Pnumber), out VisitID, out VisitNumber);
        long returncode = -1;
        try
        {
            //Modified / By Arivalagan K//
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;
            //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf
            String Root = String.Empty;
            String RootPath = String.Empty;
            //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            Root = "UnKnown-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            //ENd///


            HttpFileCollection hfc = TRFFiles();

            for (int i = 0; i < hfc.Count; i++)
            {
                if (hfc.AllKeys[i] == "FileUpload1")
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {
                        string fileName = Path.GetFileNameWithoutExtension(hpf.FileName);
                        string fileExtension = Path.GetExtension(hpf.FileName);
                        //string imagePathname = ConfigurationManager.AppSettings["UploadPath"];
                        //string imagePath = imagePathname + pathname;
                        //string imagePath = pathname;
                        string picNameWithoutExt = Pnumber + '_' + visitid + '_' + OrgID + '_' + fileName;
                        string pictureName = string.Empty;
                        string filePath = string.Empty;
                        Response.OutputStream.Flush();
                        if (!System.IO.Directory.Exists(RootPath))
                        {
                            System.IO.Directory.CreateDirectory(RootPath);
                        }
                        //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                        string[] fileNames = Directory.GetFiles(RootPath, picNameWithoutExt + ".*");
                        foreach (string path in fileNames)
                        {
                            File.Delete(path);
                        }
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = picNameWithoutExt + ".jpg";
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            int thumbWidth = 640, thumbHeight = 480;
                            System.Drawing.Image image = System.Drawing.Image.FromStream(hpf.InputStream);
                            int srcWidth = image.Width;
                            int srcHeight = image.Height;
                            if (thumbWidth > srcWidth)
                                thumbWidth = srcWidth;
                            if (thumbHeight > srcHeight)
                                thumbHeight = srcHeight;
                            Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);
                            System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                            gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                            gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                            gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                            gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                            System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                            gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
                            //bmp.Save(filePath, ImageFormat.Jpeg);
                            if (System.IO.Directory.Exists(RootPath))
                            {
                                bmp.Save(filePath, ImageFormat.Jpeg);
                            }
                            // hpf.SaveAs(filePath,ImageFormat.Jpeg);
                            //hdnPatientImageName.Value = pictureName;
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                        }
                        else
                        {
                            pictureName = picNameWithoutExt + fileExtension;
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            hpf.SaveAs(filePath);
                        }
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(Pnumber.ToString());
                        int Vid = int.Parse(visitid.ToString());
                        returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "UnKnown", Root, LID, dt,"Y",0);
                        //hdnPatientImageName.Value = pictureName;          
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);

        }
        return returncode;

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
    void ClearValues()
    {
        txtName.Text = "";
        txtName.Focus();

        txtDOBNos.Text = "";

        ddlDOBDWMY.SelectedIndex = 0;

        txtClient.Text = "";

        txtTestName.Text = "";
        txtAuthorised.Text = "";
        txtPatientHistory.Text = "";
        txtGross.Text = "0.00";
        hdnGrossValue.Value = "0.00";
        txtDiscount.Text = "0.00";
        hdnDiscountAmt.Value = "0.00";
        txtTax.Text = "0.00";
        hdnTaxAmount.Value = "0.00";
        hdfTax.Value = "0.00";
        txtServiceCharge.Text = "0.00";
        hdnServiceCharge.Value = "0.00";
        txtRoundoffAmt.Text = "0.00";
        hdnRoundOff.Value = "0.00";
        txtNetAmount.Text = "0.00";
        hdnNetAmount.Value = "0.00";
        txtAmtReceived.Text = "0.00";
        hdnAmountReceived.Value = "0.00";
        txtDue.Text = "0.00";
        hdnDue.Value = "0.00";
        hdnRateID.Value = hdnBaseRateID.Value;
        hdnOPIP.Value = "OP";
        hdfBillType1.Value = "";
        hdnFeeTypeSelected.Value = "COM";
        hdnName.Value = "";
        hdnAmt.Value = "0.00";
        hdnID.Value = "";
        hdnReportDate.Value = "";
        hdnRemarks.Value = "";
        hdnIsRemimbursable.Value = "";
        hdnPaymentControlReceivedtemp.Value = "";
        hdnPatientID.Value = "-1";
        hdnVisitPurposeID.Value = "-1";
        hdnClientID.Value = "-1";
        hdnTPAID.Value = "-1";
        hdnClientType.Value = "CRP";
        hdnReferedPhyID.Value = "-1";

        hdnReferedPhyType.Value = "-1";

        hdnPreviousVisitDetails.Value = "";
        lblPreviousItems.Text = "0.00";
        hdnPatientAlreadyExists.Value = "0";
        btnGenerate.Style.Add("display", "block");
        btnClose.Style.Add("display", "block");
        tDOB.Text = "dd//MM//yyyy";
        ddSalutation.Focus();
        hdnPatientAlreadyExistsWebCall.Value = "0";
        txtDiscountReason.Text = "";
        txt_DOB_TextBoxWatermarkExtender.WatermarkText = "dd/MM/yyyy";

        hdnBillGenerate.Value = "N";
        hdnLstPatientInvSample.Value = "";
        hdnLstSampleTracker.Value = "";
        hdnLstPatientInvSampleMapping.Value = "";
        hdnLstInvestigationValues.Value = "";
        hdnLstCollectedSampleStatus.Value = "";
        hdnVisitID.Value = "-1";
        hdnGuID.Value = "";
    }

}

