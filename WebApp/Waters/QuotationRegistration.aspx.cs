using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using Attune.Podium.BusinessEntities.CustomEntities;
using System.Web.Script.Serialization;
using Attune.Podium.PerformingNextAction;


public partial class Waters_QuotationRegistration : BasePage
{

    public Waters_QuotationRegistration()
        : base("Waters_QuotationRegistration_aspx")
    {
    }

    Patient objPatient = new Patient();
    long VisitID = 0;
    string WinAlert = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10 == null ? "Alert" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10;
    string strSelect = Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03;

    Waters_BL WatersBL = new Waters_BL();

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            billPart.QuotationRegistrationDisplay();
            Loadcountries();
            AutoCompleteExtenderQuotationNo.ContextKey = OrgID.ToString() + '~' + "REG";
            string rval, roundpattern, rrval, rroundpattern;
            rval = GetConfigValue("roundoffpatamt", OrgID);//Round off is done by config value(orgbased)
            roundpattern = GetConfigValue("patientroundoffpattern", OrgID);
            rrval = GetConfigValue("RoundOffTPAAmt", OrgID);
            rroundpattern = GetConfigValue("TPARoundOffPattern", OrgID);
            hdnDefaultRoundoff.Value = rval;
            hdnTpaRoundoff.Value = rrval;
            hdnRoundOffType.Value = roundpattern;
            hdnTpaRoundOffType.Value = rroundpattern;
            loadClientName();

        }


        txtRegCollectedTime.Attributes.Add("onchange", "ExcedDate('" + txtRegCollectedTime.ClientID.ToString() + "','',0,0);");
        txtSampleReceivetime.Attributes.Add("onchange", "ExcedDate('" + txtSampleReceivetime.ClientID.ToString() + "','',0,0); ExcedDate('" + txtRegCollectedTime.ClientID.ToString() + "','txtFrom',1,1);");

        hdnRegPageType.Value = "REG";
        hdnOrgID.Value = OrgID.ToString();
        hdnRoleID.Value = RoleID.ToString();
        hdnDate.Value = OrgDateTimeZone;
        hdnDefaultLocationID.Value = ILocationID.ToString();
       // hdnCurrentDate.Value = DateTime.Today.ToString("dd/MM/yyyy HH:mm tt");
        hdnCurrentDate.Value = OrgDateTimeZone.ToString();
        
    }

   // string strSelect = Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03 == null ? "--Select--" : Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_03;
    
    protected void btnGenerateBill_onclick(object sender, EventArgs e)
    {
        long returncode = -1;
        long VisitID = 0;
        string InvestigationDetails = "";
        string OrderedInvestigationDetails = "";
        string[] sNewDatas = null;
        string[] OrderedInvestigation = null;
        string[] SubOrderedInvestigation = null;
        long QuotationID = 0;

        string[] sNewSubDatas = null; 
        int i=0;

        List<FinalBill> FinalBillDetails = new List<FinalBill>();

        FinalBill BillDetails = new FinalBill();

        List<PatientDueChart> BillamountDetails = new List<PatientDueChart>();

        
        List<VisitClientMapping> lst = new List<VisitClientMapping>();


        DataTable dtAmountReceivedDet = null;

        dtAmountReceivedDet = billPart.GetAmountReceivedDetails();
        string[] RegQuotationDetails;
        Patient_BL Details = new Patient_BL(base.ContextInfo);

        if (hdnSelectedClientDetails.Value != "")
        {


            RegQuotationDetails = hdnSelectedClientDetails.Value.Split('~');




            
            objPatient.Name = txtClient.Value;
            objPatient.Add1 = RegQuotationDetails[1];
            objPatient.City = RegQuotationDetails[2];
            objPatient.CountryID = Convert.ToInt64(RegQuotationDetails[3]);
            objPatient.StateID = Convert.ToInt64(RegQuotationDetails[4]);
            objPatient.OrgID = OrgID;
            objPatient.SecuredCode = System.Guid.NewGuid().ToString();


        }

        List<OrderedInvestigations> lstinvestigations=new List<OrderedInvestigations>();
        
        if (hdnTestQuotationList.Value != "")
        {
            InvestigationDetails = hdnTestQuotationList.Value;
            
        
        }

        sNewDatas = InvestigationDetails.Split('|');

        for (i = 0; i < sNewDatas.Length - 1; i++)
        {
            OrderedInvestigations Quotationinvestigations = new OrderedInvestigations();
            PatientDueChart AmountDetails = new PatientDueChart();
            sNewSubDatas = sNewDatas[i].Split('~');
            //Quotationinvestigations.ID = Convert.ToInt64(sNewSubDatas[0]);
            //Quotationinvestigations.Name = sNewSubDatas[1];
            //Quotationinvestigations.Type = sNewSubDatas[2];
            //string gUID = Guid.NewGuid().ToString();
            //Quotationinvestigations.UID = gUID;
            //Quotationinvestigations.SampleID = sNewSubDatas[8];
            AmountDetails.FeeID = Convert.ToInt64(sNewSubDatas[0]);
            AmountDetails.Description = sNewSubDatas[1];
            AmountDetails.FeeType = sNewSubDatas[2];
            AmountDetails.Amount =  Convert.ToDecimal(sNewSubDatas[7]);
            AmountDetails.Unit = Convert.ToDecimal(sNewSubDatas[4]);
            //lstinvestigations.Add(Quotationinvestigations);
            BillamountDetails.Add(AmountDetails);
        
        
        }


        if (hdnAppendTest.Value != "")
        {


            OrderedInvestigationDetails = hdnAppendTest.Value;
        
        }

        OrderedInvestigation = OrderedInvestigationDetails.Split('|');

        string OldSampleid = "";
        string gUID = "";

        for (i = 0; i < OrderedInvestigation.Length - 1; i++)
        {
            OrderedInvestigations Quotationinvestigations = new OrderedInvestigations(); 
            
            SubOrderedInvestigation = OrderedInvestigation[i].Split('~');
            Quotationinvestigations.ID = Convert.ToInt64(SubOrderedInvestigation[0]);
            Quotationinvestigations.Name = SubOrderedInvestigation[1];
            Quotationinvestigations.Type = SubOrderedInvestigation[2];
            if (OldSampleid != SubOrderedInvestigation[8])
            {
                 gUID = Guid.NewGuid().ToString();
            }
            Quotationinvestigations.UID = gUID;
            Quotationinvestigations.SampleID = SubOrderedInvestigation[8];
            OldSampleid = SubOrderedInvestigation[8];
            Quotationinvestigations.RefPhysicianID = Convert.ToInt64(SubOrderedInvestigation[10]);
            Quotationinvestigations.RefPhyName = SubOrderedInvestigation[11];
            lstinvestigations.Add(Quotationinvestigations);
        }





        BillDetails = billPart.GetFinalBillDetails(out lst);
        QuotationID = Convert.ToInt64(hdnSelectedQuotationID.Value);


        //BillDetails.GrossBillValue = Convert.ToDecimal(hdnGrossValue.Value);
        //BillDetails.NetValue = Convert.ToDecimal(hdnGrossValue.Value);
        returncode = Details.InsertQuotationbillingDetails(objPatient, lstinvestigations, dtAmountReceivedDet, BillamountDetails,QuotationID,out VisitID);

        hdnVisitID.Value = VisitID.ToString();

        //btnGenerateBill.Attributes.Add("onclick", "return QuotationCollectSample()");
        ScriptManager.RegisterStartupScript(this, this.GetType(), "CollectSample", "javascript:NewQuotationCollectSample();", true);
        btnGenerateWorkOrder.Visible = true;
        grdCollectSample.Visible = true;
        btnCollectClear.Visible = true;
        btnGenerateBill.Visible = false;
        btnClear.Visible = false;
        txtSampleReceivetime.Visible = true;
        lblSampleReceivetime.Visible = true;
        chkSampleReceivetime.Visible = true;
        lblApplyAll.Visible = true;

        //Newly added for collect sample
        loadCollectSample();
        //divBillingPart.Visible = false;


    }


    protected void btnGenerateWorkOrder_onclick(object sender, EventArgs e)
    {

        try
        {

            List<PatientInvSample> lstPatientInvSample = new List<PatientInvSample>();
            List<PatientInvSampleMapping> lstPatientInvSampleMapping = new List<PatientInvSampleMapping>();
            int loop = 0;
            long returncode = -1;
            long QuotationID = 0;
            long VisitID = 0;
            string PatientInvSampleList = "";
            string[] sNewInvSampleList = null;
            string[] SubNewInvSampleList = null;
            long ClientID = 0; 
            Patient_BL Details = new Patient_BL(base.ContextInfo);
            QuotationID = Convert.ToInt64(hdnSelectedQuotationID.Value);



            if (hdnFinalTestList.Value != "")
            {

                PatientInvSampleList = hdnFinalTestList.Value;

                sNewInvSampleList = PatientInvSampleList.Split('|');
            }

            foreach (GridViewRow gvRows in grdCollectSample.Rows) {


                PatientInvSample PatientSample = new PatientInvSample();
                PatientInvSampleMapping PatientSampleMapping = new PatientInvSampleMapping();
                HiddenField InvestigationID = gvRows.FindControl("hdnID") as HiddenField;
                Label InvestigationName = gvRows.FindControl("lblName") as Label;
                Label SampleID = gvRows.FindControl("lblSampleID") as Label;
                HiddenField SampleContainerID = gvRows.FindControl("hdnSampleContainerID") as HiddenField;
                HiddenField SampleCode = gvRows.FindControl("hdnSampleCode") as HiddenField;
                Label barcode = gvRows.FindControl("lblbarcode") as Label;
                HiddenField DeptID = gvRows.FindControl("hdnID") as HiddenField;
                HiddenField InvestigationType = gvRows.FindControl("hdnInvestigationType") as HiddenField;
                PatientSample.OrgID = Convert.ToInt32(hdnOrgID.Value);//Orgid
                //PatientSampleMapping.VisitID = Convert.ToInt64(hdnVisitID.Value);//VisitID
                string gUID = Guid.NewGuid().ToString();
                PatientSample.UID = gUID;
                PatientSample.PatientVisitID = Convert.ToInt64(hdnVisitID.Value);//VisitID
                PatientSample.BarcodeNumber = Convert.ToString(barcode.Text);//barcode
                PatientSample.ConsignmentNo = Convert.ToString(SampleID.Text);//SampleID
                PatientSample.SampleID = Convert.ToInt32(InvestigationID.Value);//investigationID
                PatientSample.SampleCode = Convert.ToInt32(SampleCode.Value);//Sample Code
                PatientSample.SampleContainerID = Convert.ToInt32(SampleContainerID.Value);//SampleContainer
                PatientSample.CollectedLocID = Convert.ToInt32(DeptID.Value);//DeptID
                PatientSampleMapping.ID = Convert.ToInt32(InvestigationID.Value);//investigationID
               PatientSampleMapping.Type = Convert.ToString(InvestigationType.Value);//InvestigationType
                PatientSampleMapping.VisitID = Convert.ToInt64(hdnVisitID.Value);//VisitID
                PatientSampleMapping.SampleID = Convert.ToInt32(SampleCode.Value);//SampleCode
                PatientSampleMapping.UID = Convert.ToString(SampleID.Text);//SampleID
                PatientSampleMapping.Barcode = Convert.ToString(barcode.Text);//barcode
                PatientSampleMapping.OrgID = Convert.ToInt32(hdnOrgID.Value);//Orgid
                lstPatientInvSample.Add(PatientSample);

                lstPatientInvSampleMapping.Add(PatientSampleMapping);
            
            }

            if (hdnClientID.Value != "")
            {

                ClientID = Convert.ToInt64(hdnClientID.Value);

            }

            if (hdnVisitID.Value != "")
            {

                VisitID = Convert.ToInt64(hdnVisitID.Value);
            
            }


            returncode = Details.InsertQuotationPatientInvSample(lstPatientInvSample, lstPatientInvSampleMapping, QuotationID, ClientID,VisitID);

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('WorkOrder Generated Sucessfully','" + WinAlert + "');", true);

            Clearitems();

        
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while btnGenerateWorkOrder_onclick In Quotation Registration", ex);

        }
    
    
    }

    protected void btnClear_onClick(object sender, EventArgs e)
    {

        try
        {
            long returncode = -1;
            WatersBL = new Waters_BL(base.ContextInfo);
            long VisitID = 0;

            if(hdnVisitID.Value!="")

             
            {
            VisitID = Convert.ToInt64(hdnVisitID.Value);
            returncode = WatersBL.DeleteQuotationRegistration(VisitID);
            }
           
            Clearitems();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "CollectSample", "javascript:ClearPaymentControlEvents1();", true);
            

        }

        catch (Exception ex)
        {


            CLogger.LogError("Error while btnClear_onClick In Quotation Registration", ex);
        
        }
    
    
    
    }

    public void Loadcountries()
    {
        List<Country> lstCountries = new List<Country>();
        List<Salutation> lstTitles = new List<Salutation>();
        List<VisitPurpose> lstVisitPurpose = new List<VisitPurpose>();
        List<Country> lstNationality = new List<Country>();
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetQuickBillingDetails(OrgID, LanguageCode, out lstTitles, out lstVisitPurpose, out lstNationality, out lstCountries);
        int countryID = 0;
        Country selectedCountry = new Country();
        ddCountry.Items.Clear();

        try
        {
            ddCountry.DataSource = lstCountries;
            ddCountry.DataTextField = "CountryName";
            ddCountry.DataValueField = "CountryID";
            ddCountry.DataBind();
            ddCountry.Items.Insert(0, strSelect);
            ddCountry.Items[0].Value = "0";
            selectedCountry = lstCountries.Find(FindCountry);


            if (CountryID > 0)
            {
                ddCountry.SelectedValue = CountryID.ToString();
            }
            else
            {
                ddCountry.SelectedItem.Value = selectedCountry.CountryID.ToString();
            }
            Int32.TryParse(ddCountry.SelectedItem.Value, out countryID);
            
            LoadState(countryID);
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Country", ex);
        }
        finally
        {
        }



    }

    protected void LoadState(int countryID)
    {
        List<State> states = new List<State>();
        State_BL stateBL = new State_BL(base.ContextInfo);
        State selectedState = new State();
        long returnCode = -1;
        ddState.Items.Clear();
        int stateID = 0;
        try
        {

            returnCode = stateBL.GetStateByCountry(countryID, out states);

            foreach (State st in states)
            {
                ddState.Items.Add(new ListItem(st.StateName, st.StateID.ToString()));

                
            }

            selectedState = states.Find(FindState);
            if (StateID > 0)
            {
                ddState.Value = StateID.ToString();
                
            }
            else
            {
                ddState.Value = selectedState.StateID.ToString();
                
            }
            Int32.TryParse(ddState.Value, out stateID);
            hdnPatientStateID.Value = StateID.ToString();
            hdnPatientStateID1.Value = StateID.ToString();
            //hdnDefaultStateID.Value = selectedState.StateID.ToString();
            //Int32.TryParse(, out stateID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Sate", ex);
        }
        finally
        {
        }
    }
    static bool FindState(State s)
    {
        if (s.IsDefault == "Y")
        {
            return true;
        }
        return false;
    }
    static bool FindCountry(Country c)
    {
        if (c.IsDefault == "Y")
        {

            return true;
        }
        return false;
    }

    public void Clearitems()
    {

        txtQuotationNo.Text = "";
        hdnSelectedQuotationID.Value = "";
        hdnSelectedQuotationNo.Value = "";
        //txtClient.Text = "";
        txtRegAddress.Text = "";
        txtRegCity.Text = "";
        ddCountry.SelectedValue = "75";
        ddState.Value = "31";
        txtRegCollectedTime.Text = "";
        txtRegSalesPerson.Text = "";
        txtRegBranch.Text = "";
        chkRegSMS.Checked = false;
        chkRegEmail.Checked = false;
        lblSampleReceivetime.Visible = false;
        txtSampleReceivetime.Text = "";
        txtSampleReceivetime.Visible = false;
        hdnCollectSampleList.Value = "";
        hdnTestQuotationList.Value = "";
        hdnVisitID.Value = "";
        hdnLoadSampleStatus.Value = "";
        hdnRoleID.Value = "";
        hdnLocation.Value = "";
        hdnDate.Value = "";
        hdnAppendTest.Value = "";
        divCollectSample.InnerHtml = "";
        divTestName.InnerHtml = "";
        btnGenerateWorkOrder.Visible = false;
        btnCollectClear.Visible = false;
        btnGenerateBill.Visible = true;
        btnClear.Visible = true;
        hdnGrossValue.Value = "0";
        chkSampleReceivetime.Visible = false;
        lblApplyAll.Visible = false;
        grdCollectSample.Visible = false;
        divBillingPart.Visible = true;
        //document.getElementById('').innerHTML


        
    
    
    }

    public void loadClientName()
    {

        WatersBL = new Waters_BL();

        List<ClientMaster> lstDetails = new List<ClientMaster>();

        int orgid = OrgID;

        long returncode = -1;

        returncode = WatersBL.GetQuotationRegClientName(orgid, out lstDetails);

        

        if (lstDetails.Count > 0)
        {

                var childItems = from n in lstDetails
                                 select new
                                 {  //DiscountName = n.DiscountName + "~" + n.Discount,
                                     //DiscountPercentage = n.DiscountPercentage,
                                     ClientID = n.ClientID,
                                     ClientName = n.ClientName
                                 };

            ddlClientName.DataSource = lstDetails;
            ddlClientName.DataValueField = "ClientID";
            ddlClientName.DataTextField = "ClientName";
            ddlClientName.DataBind();
            ddlClientName.Items.Insert(0, strSelect);

        }







    }

    public void loadCollectSample()
    {

        long QuotationID = Convert.ToInt64(hdnSelectedQuotationID.Value);
        long VisitID = Convert.ToInt64(hdnVisitID.Value);
        int Orgid = OrgID;
        List<PreQuotationInvestigations> lstinvestigations = new List<PreQuotationInvestigations>();

        long returnCode = -1;


        returnCode = new BillingEngine(new BaseClass().ContextInfo).GetRegistrationSampleCollect(QuotationID, OrgID, VisitID, out lstinvestigations);



        if (lstinvestigations.Count > 0)
        {

            grdCollectSample.DataSource = lstinvestigations;
            grdCollectSample.DataBind();


        }
        else
        {

            grdCollectSample.DataSource = null;
            grdCollectSample.DataBind();

        }






    }

    public List<OrganizationAddress> LoadLocation()
    {
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        long returnCode = -1;
        long loginID = -1;
        int RoleID = Convert.ToInt32(hdnRoleID.Value);
        int iOrgID = OrgID;
        PatientVisit_BL patientBL = new PatientVisit_BL(new BaseClass().ContextInfo);
        returnCode = patientBL.GetLocation(iOrgID, loginID, RoleID, out lstLocation);
        return lstLocation;

    }


    public List<MetaData> LoadQuotationDropDownValues()
    {
        //string strSelect = Resources.Lab_ClientDisplay.Lab_Home_aspx_08 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_Home_aspx_08;
        long returncode = -1;
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        List<MetaData> lstSampleReceived = new List<MetaData>();
        try
        {
            string domains = "SampleStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            returncode = new MetaData_BL(new BaseClass().ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data in OPIP Billing ", ex);

        }

       // lstmetadataOutput.;
        
        return lstmetadataOutput;

    }




    protected void grdCollectSample_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        foreach (GridViewRow gvRow in grdCollectSample.Rows)
        {
            DropDownList drpSampleStatus = gvRow.FindControl("drpStatus") as DropDownList;
            DropDownList drpSampleLocation = gvRow.FindControl("drplocation") as DropDownList;
            TextBox ReceiveDate = gvRow.FindControl("txtReceiveTime") as TextBox;
            drpSampleStatus.Items.Remove("Pending");
            //drpSampleStatus.Items.Remove("SampleCollected");
          //  string Status = drpSampleStatus.Items.FindByValue("SampleCollected").Value;
            ListItem itemToRemove = drpSampleStatus.Items.FindByValue("SampleCollected");
            if (itemToRemove != null)
            {
                drpSampleStatus.Items.Remove(itemToRemove);
            }
           

            drpSampleLocation.SelectedValue = hdnDefaultLocationID.Value;
            ReceiveDate.Text = Convert.ToDateTime(hdnDate.Value).ToString("dd-MM-yyyy hh:mm tt");
            




        }

    }

    protected void chkApplyAll_CheckedChanged(object sender, EventArgs e)
    {

        string ChangedTime = txtSampleReceivetime.Text;
        if (chkSampleReceivetime.Checked == true)
        {

            foreach (GridViewRow gvRows in grdCollectSample.Rows)
            {

                TextBox ReceiveTime = gvRows.FindControl("txtReceiveTime") as TextBox;

                ReceiveTime.Text = ChangedTime;



            }
        }
        chkSampleReceivetime.Checked = false;

    }

}
