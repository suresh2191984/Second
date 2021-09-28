using System;
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
using System.Security.Cryptography;
using Attune.Podium.BillingEngine;

public partial class Billing_InPatientBilling : BasePage
{
   public Billing_InPatientBilling(): base("Billing\\InPatientBilling.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long visitID = 0;
    long patientID = 0;
    string PaidStatus = string.Empty;
    bool boolClickStatus = false;
    string IsCreditBill = string.Empty;
    decimal pPreAuthAmount = 0;
    decimal GrossBillAmount = 0;
    decimal DueAmount = 0;
    decimal PaidAmount = 0;
    int Physiocount = 0;
    string labno = string.Empty;
    List<PatientInvestigation> lstGroups = new List<PatientInvestigation>();
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<PatientInvestigation> lstInvestigations = new List<PatientInvestigation>(); List<OrderedInvestigations> lstInvestigationsHL = new List<OrderedInvestigations>();
    Investigation_BL investigationBL ;
    IP_BL ipBL ;

    string gUID = string.Empty;

    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();

    protected void Page_Load(object sender, EventArgs e)
    {
        investigationBL = new Investigation_BL(base.ContextInfo);
        ipBL = new IP_BL(base.ContextInfo);
        try
        {

            //New code Begins - 23-11-2010
            long visitID = 0;
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }
            hdnPDetail.Value = visitID.ToString();
            ipTreatmentBill.VisitID = visitID;

            
            //if (IsPostBack)
            //{
            if (!IsPostBack)
            {
                txtProcedureDT.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                txtInvDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
                txtgenDate.Text = txtInvDate.Text;
            }
                long pPatientID = 0;
                string IsCreditBill = string.Empty;
                decimal pPreAuthAmount = 0;
                decimal dAdvanceAmount = 0;
                List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
                List<AdvancePaidDetails> lstadvancepaidDetails = new List<AdvancePaidDetails>();
                List<SurgeryPackageItems> lstSurgeryPackageItems = new List<SurgeryPackageItems>();
                List<SurgeryPackageItems> lstSelectedSurgeryPKG = new List<SurgeryPackageItems>();
                List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
                List<OrderedInvestigations> lstGrp = new List<OrderedInvestigations>();
                List<PatientVisit> lstPatientVisitIP = new List<PatientVisit>();
                List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
                List<IpPayments> IPL = new List<IpPayments>();
                if (Request.QueryString["PID"] != null)
                {
                    pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
                }

                hdnPDetail.Value += "~" + pPatientID.ToString();
                long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientMakeBillEntryDetails(pPatientID, out lstPatientVisit,
                                               visitID, out pPreAuthAmount, out IsCreditBill, out lstDueChart, OrgID,
                                               "", out dAdvanceAmount, out lstadvancepaidDetails, out lstSurgeryPackageItems,
                                               out lstSelectedSurgeryPKG, RoleID, 1, out IPL, out lstInv, out lstGrp, 0, "",
                                               out lstGroups, out lstInvestigations);

                if (lstPatientVisit.Count > 0)
                {
                    hdnPDetail.Value += "~" + lstPatientVisit[0].Name;
                }
                PatientHeader.PatientID = pPatientID;
                PatientHeader.PatientVisitID = visitID;

                BillingEngine be = new BillingEngine(base.ContextInfo);
                decimal Copercent = -1;
                be.CheckIsCreditBill(visitID, out PaidAmount, out GrossBillAmount, out DueAmount, out IsCreditBill, out lstVisitClientMapping);

                if (pPreAuthAmount > 0 && IsCreditBill == "Y")
                {
                    Preauth.Style.Add("display", "block");
                    trGross.Style.Add("display", "block");
                    lblPreAuthAmount.Text = pPreAuthAmount.ToString();
                    lblGross.Text = GrossBillAmount.ToString();
                    if (GrossBillAmount > pPreAuthAmount)
                    {
                        trPreAuthLimitMsg.Style.Add("display", "block");
                    }
                }

                grdDuechart.DataSource = lstDueChart;
                grdDuechart.DataBind();
                GetAmountData();

                PatientVisit_BL objPatientVisitBL = new PatientVisit_BL(base.ContextInfo);


                //SPI.GetSurgeryPackageIP(lstSurgeryPackageItems);
                //OSPI.GetSurgeryPackageIP(lstSelectedSurgeryPKG);

                if (!IsPostBack)
                {
                    SPI.GetSurgeryPackageIP(lstSurgeryPackageItems);
                    OSPI.GetSurgeryPackageIP(lstSelectedSurgeryPKG);
                }

                if (IPL.Count > 0)
                {
                    ddlTypes.Items.Clear();
                    ddlTypes.DataSource = IPL;
                    ddlTypes.DataTextField = "PaymentTypeName";
                    ddlTypes.DataValueField = "PaymentTypeCde";
                    ddlTypes.DataBind();
                    ddlTypes.Items.Insert(0, new ListItem("--Select--", "SEL"));
                }

                if (visitID != 0)
                {
                    if (lstInv.Count > 0 || lstGrp.Count > 0)
                    {
                        InvestigationControl1.loadOrderedList(lstInv, lstGrp);
                    }
                }

                string strConfigKey = "IPMakePayment";
                string configValue = GetConfigValue(strConfigKey, OrgID);

                if (configValue == "N")
                {
                    btnFinish.Visible = false;
                }
                else
                {
                    btnFinish.Visible = true;
                }           

            //}
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "changefuncion", "javascript:changefuncion()", true);
             InvestigationControl1.LoadLabData(lstGroups, lstInvestigations);//New code Ends - 23-11-2010

            //// OLD CODE BEGINS
            //long visitID = 0;
            //if (Request.QueryString["VID"] != null)
            //{
            //    visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            //}
            //hdnPDetail.Value = visitID.ToString();
            //ipTreatmentBill.VisitID = visitID;
          
            
            //if (!IsPostBack)
            //{
            //    txtProcedureDT.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            //    txtInvDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
            //    txtgenDate.Text = txtInvDate.Text;
            //    long pPatientID = 0;
            //    decimal dAdvanceAmount = 0;
            //    if (Request.QueryString["PID"] != null)
            //    {
            //        pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            //    }
            //    hdnPDetail.Value += "~" + pPatientID.ToString();
            //    //List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            //    long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(pPatientID, out lstPatientVisit);
            //    if (lstPatientVisit.Count > 0)
            //    {
            //        hdnPDetail.Value += "~" + lstPatientVisit[0].Name;
            //    }
            //    PatientHeader.PatientID = pPatientID;
            //    PatientHeader.PatientVisitID = visitID;
            //    //ipConsultation.lVisitID = Convert.ToInt32(visitID);
            //    //IpConsultationDetails1.lVisitID = Convert.ToInt32(visitID);

            //    ////Load Data's to investigation Control
            //    //List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
            //    //List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
            //    //new Investigation_BL(base.ContextInfo).GetClientInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroups, out lstInvestigations, Convert.ToInt32(visitID));

            //    //InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);


               
            //    BillingEngine be = new BillingEngine(base.ContextInfo);
            //    be.CheckIsCreditBill(visitID, out pPreAuthAmount,out PaidAmount,out GrossBillAmount,out DueAmount, out IsCreditBill, out Copercent);

            //    if (pPreAuthAmount > 0 && IsCreditBill == "Y")
            //    {
            //        Preauth.Style.Add("display", "block");
            //        trGross.Style.Add("display", "block");
            //        lblPreAuthAmount.Text = pPreAuthAmount.ToString();
            //        lblGross.Text = GrossBillAmount.ToString();
            //        if (GrossBillAmount < pPreAuthAmount)
            //        {
            //            trPreAuthLimitMsg.Style.Add("display", "block");
            //        }
            //    }
            //    //ipBL.GetIPVisitDetails(visitID, out lstPatientVisit);
            //    //investigationBL.GetAllInvestigationWithRate(OrgID, Convert.ToInt32(lstPatientVisit[0].RateID), "GRP", visitID, out lstGroups);
            //    //investigationBL.GetAllInvestigationWithRate(OrgID, Convert.ToInt32(lstPatientVisit[0].RateID), "INV", visitID, out lstInvestigations);

            //    //InvestigationControl1.LoadLabData(lstGroups, lstInvestigations);

            //    List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
            //    List<AdvancePaidDetails> lstadvancepaidDetails = new List<AdvancePaidDetails>();
            //    new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, "", out dAdvanceAmount, out lstadvancepaidDetails);
            //    grdDuechart.DataSource = lstDueChart;
            //    grdDuechart.DataBind();
            //    GetAmountData();

            //    PatientVisit_BL objPatientVisitBL = new PatientVisit_BL(base.ContextInfo);
            //    List<IpPayments> IPL = new List<IpPayments>();

            //  //  SPI.VisitID = visitID;
            //    SPI.GetSurgeryPackage();              

            //    OSPI.GetOrderedSurgeryPkg();                

            //    objPatientVisitBL.GetIPPaymentTypes(RoleID, 1, out IPL);
            //    if (IPL.Count > 0)
            //    {
            //        ddlTypes.Items.Clear();
            //        ddlTypes.DataSource = IPL;
            //        ddlTypes.DataTextField = "PaymentTypeName";
            //        ddlTypes.DataValueField = "PaymentTypeCde";
            //        ddlTypes.DataBind();
            //        ddlTypes.Items.Insert(0, new ListItem("--Select--", "SEL"));
            //    }

            //    if (visitID != 0)
            //    {
            //        //Load Data's for Particular visit in Investigation Control
            //        List<OrderedInvestigations> lstInv = new List<OrderedInvestigations>();
            //        List<OrderedInvestigations> lstGrp = new List<OrderedInvestigations>();

            //        new IP_BL(base.ContextInfo).GetIPOrderedInvestigation(visitID, out lstInv, out lstGrp);
            //        if (lstInv.Count > 0 || lstGrp.Count > 0)
            //        {
            //            InvestigationControl1.loadOrderedList(lstInv, lstGrp);
            //        }
            //    }

            //    string strConfigKey = "IPMakePayment";
            //    string configValue = GetConfigValue(strConfigKey, OrgID);

            //    if (configValue == "N")
            //    {
            //        btnFinish.Visible = false;
            //    }
            //    else
            //    {
            //        btnFinish.Visible = true;
            //    }
            //}
            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "changefuncion", "javascript:changefuncion()", true);
            //ipBL.GetIPVisitDetails(visitID, out lstPatientVisit);
            //investigationBL.GetAllInvestigationWithRate(OrgID, Convert.ToInt32(lstPatientVisit[0].RateID), "GRP", visitID, out lstGroups);
            //investigationBL.GetAllInvestigationWithRate(OrgID, Convert.ToInt32(lstPatientVisit[0].RateID), "INV", visitID, out lstInvestigations);

            //InvestigationControl1.LoadLabData(lstGroups, lstInvestigations);
            //// OLD CODE ENDS
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Investigation PageLoad", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        

        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "makeItTrue", "javascript:makeItTrue()", true);
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["PID"] != null)
        {
            patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string status = "";
        status = "Pending";
        try
        {
            StoreDueChart();
            decimal dAdvanceAmount = 0;
            List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
            List<AdvancePaidDetails> lstadvancepaidDetails = new List<AdvancePaidDetails>();
            new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, "", out dAdvanceAmount, out lstadvancepaidDetails);
            grdDuechart.DataSource = lstDueChart;
            grdDuechart.DataBind();
            GetAmountData();
            ddlTypes.SelectedIndex = 0;


            string sPage = "PrintDueRequestPage.aspx?ReferenceID="
                 + hdnInterimBillNo.Value.ToString() + "&dDate="
                 + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                 //+ "&PNAME=" + patientName
                 + "&PID=" + patientID.ToString()
                 + "&VID=" + visitID.ToString()
                 + "&PNAME=" + PatientHeader.Name.ToString()
                 + "&IsPopup=Y";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sky1", "<script language='javascript'> window.open('" + sPage + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>", false);
        




        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Inpatient/Save", ex);
        }
        ClearValues();
    }

    //Clear hidden control values
    private void ClearValues()
    {
        IpConsultationDetails1.clearItems();
        OtherPayments.clearvalues();
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
    public void StoreDueChart()
    {
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
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

        ((HiddenField)ipTreatmentBill.FindControl("hdnFromDate")).Value = txtProcedureDT.Text.Trim();
        ((HiddenField)InvestigationControl1.FindControl("hdnFromDate")).Value = txtInvDate.Text.Trim();
        
        lstPatientInvestigationHL = InvestigationControl1.GetNewOrderedListHOSLAB();
        PatientVisit_BL objPatientVisit = new PatientVisit_BL(base.ContextInfo);
        ipTreatmentBill.Status = status;
        //ipConsultation.Status = status;
        IpConsultationDetails1.Status = status;
        
        lstPatientProcedure = ipTreatmentBill.getInPatientProcedureDetails();
        //lstPatientConsultation = ipConsultation.getPatientConsultationDetails();
        lstPatientConsultation = IpConsultationDetails1.getPatientConsultationDetails();
        lstPatientIndents = medIndents.GetIndents();
        lstPatientSurgical = SurgicalItems.GetSurgicalItems();
        lstPatientIndents.AddRange(lstPatientSurgical);
        lstDhebAdder = OtherPayments.GetValues(visitID);  
        lstPatientGenItems = dspData.GetConsNProDetails();
        lstSurgergicalPkg = SPI.GetSelectedSurgeryPackage();

        SPI.ClearData();
        foreach (PatientDueChart pds in lstPatientGenItems)
        {
            PatientDueChart pdTemp = new PatientDueChart();
            pdTemp.FeeID = pds.FeeID;
            pdTemp.DetailsID = pds.DetailsID;
            pdTemp.Description = pds.Description;
            pdTemp.Amount = pds.Amount;
            pdTemp.Unit = pds.Unit;
            pdTemp.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            pdTemp.FromDate = Convert.ToDateTime(txtgenDate.Text.Trim());
            pdTemp.ToDate = Convert.ToDateTime(txtgenDate.Text.Trim());
            pdTemp.FeeType = pds.FeeType;
            lstPatientConsultation.Add(pdTemp);
        }

        long returnCodeINV = -1;
        long createTaskID = -1;
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        int returnStatus = -1;
        long returnCodePRO = -1;
        long returnCode = -1;

        List<OrderedPhysiotherapy> lstTempOrderedPhysiotherapy = ipTreatmentBill.getPhysioDetails();

        List<OrderedPhysiotherapy> lstOrderedPhysiotherapy = (from lstduetemp in lstTempOrderedPhysiotherapy
                                                              where lstduetemp.ProcedureName != "Dialysis" && lstduetemp.ProcedureName != "Others"
                                                              && lstduetemp.ProcedureName != "Radiation Therapy"
                                                              select lstduetemp).ToList();

       

        if (lstOrderedPhysiotherapy.Count > 0)
        {
            string Type = "Ordered";
            returnCode = new Patient_BL(base.ContextInfo).SaveOrderedPhysiotherapy(visitID, ILocationID, OrgID, LID, Type, lstOrderedPhysiotherapy, out Physiocount);
        }


        if (lstPatientProcedure.Count > 0)
        {
            List<PatientTreatmentProcedure> lstPTT = ipTreatmentBill.getPTT(visitID, lstPatientProcedure[0].FeeID);

            returnCodePRO = new Dialysis_BL(base.ContextInfo).InsertPatientTreatmentProcedure(lstPTT, OrgID, out returnStatus);

            if (lstPatientProcedure[0].Description == "Dialysis")
            {
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCodePRO = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                returnCodePRO = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, 0,
                    patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", lstPatientProcedure[0].FeeID, "", 0, "", 0, "PRO", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, ""); // Other Id meand Procedure ID

                task.TaskActionID = (int)TaskHelper.TaskAction.PreDialysis;
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.PatientID = patientID;
                task.OrgID = OrgID;
                task.PatientVisitID = visitID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                returnCodePRO = taskBL.CreateTask(task, out createTaskID);
            }
        }

        List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>();
        // HL Ends
        long result = 0;
        int pOrderedInvCnt = 0;
        gUID = Guid.NewGuid().ToString();

        if (lstPatientInvestigationHL.Count > 0)
        {
            foreach (OrderedInvestigations inves in lstPatientInvestigationHL)
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
                objInvest.UID = gUID;
                objInvest.CreatedAt = Convert.ToDateTime(txtInvDate.Text.Trim());
                orderedInvesHL.Add(objInvest);
            }
        }
        //int pOrderedInvCnt = 0;
        int referedCount = 0;
        List<OrderedInvestigations> lstOrderedInv = new List<OrderedInvestigations>();

        long ret = -1;
        if (orderedInvesHL.Count > 0)
        {
           // returnCodeINV = ipBL.DeleteInPatientInvestigation(visitID);
            string InterimBillNo = string.Empty;
            ret = new Investigation_BL(base.ContextInfo).SaveIPPaidInvestigationAndPatientIndents(lstSurgergicalPkg, orderedInvesHL, OrgID, out lstOrderedInv, lstPatientConsultation, lstPatientProcedure, lstPatientIndents, lstDhebAdder, visitID, LID, patientID, Convert.ToDateTime(txtInvDate.Text.Trim()), gUID, out InterimBillNo,out labno);
            hdnInterimBillNo.Value = InterimBillNo.ToString();

        }

        if (ret == 0)
        {
            returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out pOrderedInvCnt); //returnCodeINV = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out OrderedInvCnt);
        }
        
        if (ret == 0)
        {
            //returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
            //returnCodeINV = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), visitID, 0,
            //    patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber);
            //task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            //task.DispTextFiller = dText;
            //task.URLFiller = urlVal;
            //task.RoleID = RoleID;
            //task.OrgID = OrgID;
            //task.PatientVisitID = visitID;
            //task.PatientID = patientID;
            //task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            //task.CreatedBy = LID;
            //returnCodeINV = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
            List<PatientInvestigation> lstSampleDept1 = new List<PatientInvestigation>();
            List<PatientInvSample> lstSampleDept2 = new List<PatientInvSample>();
            List<InvestigationValues> lstInvResult = new List<InvestigationValues>();
            //Tasks task = new Tasks();
            //Hashtable dText = new Hashtable();
            //Hashtable urlVal = new Hashtable();
            new Investigation_BL(base.ContextInfo).GetDeptToTrackSamples(visitID, OrgID, RoleID, gUID, out lstSampleDept1, out lstSampleDept2);

            foreach (var item in lstSampleDept1)
            {
                if (item.Display == "Y")
                {
                    Int64.TryParse(Request.QueryString["pid"], out patientID);
                    //long createTaskID = -1;
                    List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                    returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                    string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                    returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample),
                                 visitID, 0, patientID, lstPatientVisitDetails[0].TitleName + " " +
                                 patientName, "", 0, "", 0, "", 0, "INV"
                                 , out dText, out urlVal, 0, "", 0, gUID);
                    task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.RoleID = RoleID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.PatientID = patientID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    task.RefernceID = labno.ToString();
                    //Create task               
                    returnCode = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);

                    break;
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

            returnCode = new Investigation_BL(base.ContextInfo).UpdateInvestigationStatus(visitID, "SampleReceived", OrgID, lstInvResult);
        }
        if (IsTrustedOrg == "Y")
        {
            if (referedCount > 0)
            {
                lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0,
                               patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = visitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //create task
                returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

            }
        }
        else
        {
            if (referedCount > 0)
            {
                long taskIDReffered = -1;
                lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCodeINV = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), visitID, 0,
                patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                //task.BillID = FinalBillID;
                task.PatientVisitID = visitID;
                task.PatientID = patientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create task               
                returnCode = taskBL.CreateTask(task, out taskIDReffered);
            }
        }
        if (orderedInvesHL.Count == 0)
        {
            string InterimBillNo = string.Empty;
            objPatientVisit.InsertPatientIndents(lstSurgergicalPkg,orderedInvesHL, lstPatientConsultation, lstPatientProcedure, lstPatientIndents, lstDhebAdder, visitID, LID, patientID,out InterimBillNo);
            OSPI.GetOrderedSurgeryPkg();
//            SPI.VisitID = visitID;
            SPI.GetSurgeryPackage();
            hdnInterimBillNo.Value = InterimBillNo.ToString();
            
        }
        ClearControls();
        ((HiddenField)dspData.FindControl("hdfBillType")).Value = "";
    }

    //Clear hidden control values
    //private void ClearValues()
    //{
    //    IpConsultationDetails1.clearItems();
    //    OtherPayments.clearvalues();
    //}

    public void ClearControls()
    {
        //((HiddenField)ipConsultation.FindControl("iconHidDelete")).Value = "";
        ((HiddenField)IpConsultationDetails1.FindControl("iconHidDelete")).Value = "";
        ((HiddenField)InvestigationControl1.FindControl("iconHid")).Value = "";
         ipTreatmentBill.GetProcedureNameByProcedure();
        ((HiddenField)medIndents.FindControl("hdfIndent")).Value = "";
        ((HiddenField)medIndents.FindControl("hdnIndentNameExists")).Value = "";
        ((HiddenField)medIndents.FindControl("hdnIndentDeleted")).Value = "";      

        ((HiddenField)SurgicalItems.FindControl("hdfMedItems")).Value = "";
        ((HiddenField)SurgicalItems.FindControl("hdfMedExists")).Value = "";
        ((HiddenField)SurgicalItems.FindControl("hdfMedDelete")).Value = "";
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            ClearValues();
            Response.Redirect("~/InPatient/IPBillingHome.aspx");
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void grdDuechart_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
        e.Row.Cells[2].Visible = false;
        e.Row.Cells[3].Visible = false;
    }

    protected void GetAmountData()
    {
        decimal dTotalAmount = 0;
        decimal dTempAmount = 0;
        foreach (GridViewRow rows in grdDuechart.Rows)
        {
            dTempAmount = 0;
            decimal.TryParse(((Label)rows.FindControl("lblAmount")).Text.Trim(), out dTempAmount);
            dTotalAmount += dTempAmount;
        }
        lblTotalAmount.Text = dTotalAmount.ToString("0.00");
        lblTotalAmount1.Text = lblTotalAmount.Text;
    }
    protected void btnEditDueChart_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        long pPatientID = 0;
        ClearValues();
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["PID"] != null)
        {
            pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        Response.Redirect("~/InPatient/IpOutstandingDues.aspx?PID=" + pPatientID + "&VID=" + visitID);

    }
    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
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
            //if (RoleName == "Nurse" && ddlTypes.SelectedItem.Text == "Investigation")
            //{


            //    MakePayment();

            //    try
            //    {
            //        List<Role> lstUserRole = new List<Role>();
            //        string path = string.Empty;
            //        Role role = new Role();
            //        role.RoleID = RoleID;
            //        lstUserRole.Add(role);
            //        long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            //        Response.Redirect(Helper.GetAppName() + path, true);
            //    }
            //    catch (System.Threading.ThreadAbortException tae)
            //    {
            //        string thread = tae.ToString();
            //    }
            //}
            //else
            //{
                StoreDueChart();
                Response.Redirect("~/InPatient/DueClearance.aspx?PID=" + patientID + "&VID=" + visitID + "&LabNo=" + labno + "&PNAME=" + sPatientName + "&vType=IP&ptType=pnow", true);
            //}
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Makebill Entry page", ex);
        }
        ClearValues();
    }
    public void MakePayment()
    {

        try
        {

            long visitID = 0;
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }

            long patientID = 0;
            if (Request.QueryString["PID"] != null)
            {
                patientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }
            List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
            Investigation_BL investigBL = new Investigation_BL(base.ContextInfo);
            Hashtable dText = new Hashtable();
            Hashtable urlVal = new Hashtable();
            long returnCode = -1;
            long taskID = -1;



            List<OrderedInvestigations> lstPatientInvestHL = new List<OrderedInvestigations>(); List<PatientInvestigation> lstPatientInvest = new List<PatientInvestigation>();
            lstPatientInvestHL = InvestigationControl1.GetNewOrderedListHOSLAB(); lstPatientInvest = InvestigationControl1.GetNewOrderedList();
            List<OrderedInvestigations> orderedInvesHL = new List<OrderedInvestigations>(); List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();

            if (lstPatientInvest.Count > 0)
            {
                foreach (PatientInvestigation inves in lstPatientInvest)
                {
                    PatientInvestigation objInvest = new PatientInvestigation();
                    objInvest.InvestigationID = inves.InvestigationID;
                    objInvest.InvestigationName = inves.InvestigationName;
                    objInvest.PatientVisitID = visitID;
                    objInvest.GroupID = inves.GroupID;
                    objInvest.GroupName = inves.GroupName;
                    objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    objInvest.Status = "Ordered";
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    orderedInves.Add(objInvest);
                }
            }
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
                    //objInvest.ComplaintId = complaintID;
                    objInvest.CreatedBy = LID;
                    objInvest.Type = inves.Type;
                    orderedInvesHL.Add(objInvest);
                }
            }


            long result = 0;
            int pOrderedInvCnt = 0;
            int referedCount = -1;
            int returnstatus = -1;
            //for(int i=0;i<lstPatientInvestigation.Count;i++)
            //{
            //    lstPatientInvestigation[i].CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone) ;
            //    lstPatientInvestigation[i].CreatedBy = LID;
            //    lstPatientInvestigation[i].PatientVisitID = Convert.ToInt64(patientVisitId);
            //}

            if (lstPatientInvestHL.Count > 0)
            {
                gUID = Guid.NewGuid().ToString();
                returnCode = ipBL.DeleteInPatientInvestigation(visitID, OrgID);
                returnCode = new Investigation_BL(base.ContextInfo).SaveIPOrderedInvestigation(orderedInvesHL, OrgID, out returnstatus, gUID);

            }
            //returnCode = new Investigation_BL(base.ContextInfo).SaveIPInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
            returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out pOrderedInvCnt); //returnCode = new Investigation_BL(base.ContextInfo).GetReferedInvCount(visitID, out referedCount, out pOrderedInvCnt);
            //investigBL.SavePatientInvestigation(lstPatientInvestigation, Convert.ToInt64(OrgID));
            //(lstPatientInvestnigation, Convert.ToInt64(patientVisitId), Convert.ToInt64(OrgID));
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);

            if (result == 0)
            {
                if (Request.QueryString["pvid"] == null && Request.QueryString["id"] == null)
                {
                    Tasks task = new Tasks();
                    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                    //Int64.TryParse(Request.QueryString["tid"], out taksId);

                    //returnCode = taskBL.UpdateTask(taksId, TaskHelper.TaskStatus.Completed, UID);

                    Int64.TryParse(Request.QueryString["pid"].ToString(), out patientID);
                    if (IsTrustedOrg == "Y")
                    {
                        if (pOrderedInvCnt > 0 || referedCount > 0)
                        {
                            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0,
                            patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            returnCode = taskBL.CreateTask(task, out taskID);



                        }
                    }
                    else
                    {
                        if (pOrderedInvCnt > 0)
                        {
                            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectPayment), visitID, 0,
                            patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.InvestigationPayment);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;
                            returnCode = taskBL.CreateTask(task, out taskID);
                        }
                        if (referedCount > 0)
                        {
                            long taskIDReffered = -1;
                            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.ReferedInvestigation), visitID, 0,
                            patientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.ReferedInvestigation);
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.RoleID = RoleID;
                            task.OrgID = OrgID;
                            //task.BillID = FinalBillID;
                            task.PatientVisitID = visitID;
                            task.PatientID = patientID;
                            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                            task.CreatedBy = LID;

                            //Create task               
                            returnCode = taskBL.CreateTask(task, out taskIDReffered);
                        }
                    }

                }

            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

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
    //protected void lbtnViewBill_Click(object sender, EventArgs e)
    //{

    //    try
    //    {
    //        string sPatientName = "";
    //      Response.Redirect("../InPatient/IPViewBill.aspx?IsPopup=Y&PID=" + patientID + "&VID=" + visitID + "&PNAME=" + sPatientName + "&vType=" + "IP&BP=N", true);
    //    }
    //    catch (System.Threading.ThreadAbortException tae)
    //    {
    //        string thread = tae.ToString();
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while save ViewBill.aspx  page", ex);
    //    }
        

    //}
}
