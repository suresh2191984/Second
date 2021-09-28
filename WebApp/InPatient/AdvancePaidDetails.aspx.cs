using System;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class Reception_AdvancePaidDetails :BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        long pVisitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            pVisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        ipTreatmentBill.VisitID = pVisitID;

        if (!IsPostBack)
        {

            PatientVisit_BL objPatientVisitBL = new PatientVisit_BL(base.ContextInfo);
            List<IpPayments> IPL = new List<IpPayments>();
            

            objPatientVisitBL.GetIPPaymentTypes(RoleID, 2, out IPL);
            if (IPL.Count > 0)
            {
                ddlPaymentFor.Items.Clear();
                ddlPaymentFor.DataSource = IPL;
                ddlPaymentFor.DataTextField = "PaymentTypeName";
                ddlPaymentFor.DataValueField = "PaymentTypeCde";
                ddlPaymentFor.DataBind();
                ddlPaymentFor.Items.Insert(0, new ListItem("--Select--", "SEL"));
            }
            //Text="--Select--" Value="SEL"
            loadInitialDatas();
            BindGridDatas();
            GetAmountData();


            int visitID = 0;
            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt32(Request.QueryString["VID"].ToString());
            }

            List<InvGroupMaster> lstgroups = new List<InvGroupMaster>();
            List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
            new Investigation_BL(base.ContextInfo).GetClientInvestigationData(OrgID, Convert.ToInt32(TaskHelper.OrgStatus.orgSpecific), out lstgroups, out lstInvestigations, visitID);
            InvestigationControl1.LoadDatas(lstgroups, lstInvestigations);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        decimal dAmount = 0;
        AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);
        AdvancePaidDetails AdvanceDetails = new AdvancePaidDetails();
        long pVisitID = 0;


        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<DHEBAdder> lstDhebAdder = new List<DHEBAdder>();

        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);

        if (Request.QueryString["VID"] != null)
        {
            pVisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["PID"] != null)
        {
            lblPatientID.Text = Request.QueryString["PID"].ToString() == "" ? "0" : Request.QueryString["PID"].ToString();
        }
        hdnNowPaid.Value = hdnNowPaid.Value == "" ? "0" : hdnNowPaid.Value;
        txtPayment.Text = (txtPayment.Text == "0" || txtPayment.Text == "") ? hdnNowPaid.Value : txtPayment.Text;

        dAmount = Convert.ToDecimal(txtPayment.Text);
        long pPatientID = Convert.ToInt64(lblPatientID.Text);
        long returnCode = -1;
        lstPatientInvestigation = InvestigationControl1.GetOrderedList();
        lstPatientDueChart = ipTreatmentBill.getInPatientProcedureDetails();
        lstDhebAdder = OtherPayments.GetValues(pVisitID);

        System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
        dtAdvancePaidDetails = PaymentTypes.GetAmountReceivedDetails();

        long returnCodeINV = -1;
        long createTaskID = -1;
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
        if (lstPatientInvestigation.Count > 0)
        {
            foreach (PatientInvestigation inves in lstPatientInvestigation)
            {
                PatientInvestigation objInvest = new PatientInvestigation();
                objInvest.InvestigationID = inves.InvestigationID;
                objInvest.InvestigationName = inves.InvestigationName;
                objInvest.PatientVisitID = pVisitID;
                objInvest.GroupID = inves.GroupID;
                objInvest.GroupName = inves.GroupName;
                objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objInvest.Status = "Paid";
                objInvest.CreatedBy = LID;
                objInvest.Type = inves.Type;
                orderedInves.Add(objInvest);
            }
        }
        int pOrderedInvCnt = 0;

        returnCodeINV = new Investigation_BL(base.ContextInfo).SaveInPatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
        if (pOrderedInvCnt > 0)
        {
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), pVisitID, 0,
                pPatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = pPatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            //Create task               
            returnCodeINV = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
        }

        string sAdvance = "";
        long IpIntermediateID = 0;
        string sType = "";
        returnCode = objAdBL.SaveAdvancePaidDetails(pVisitID, pPatientID, LID, dAmount, OrgID, lstPatientInvestigation, lstPatientDueChart, lstDhebAdder, dtAdvancePaidDetails, dServiceCharge,out sAdvance,out IpIntermediateID,out sType);
        if (txtPayment.Text.Trim() != "0")
        {
            //hdnDate
            hdnAmount.Value = txtPayment.Text.Trim();
            hdnDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
            this.Page.RegisterStartupScript("strKyAdvancePaidDetails", "<script type='text/javascript'> PopUpPage(); </script>");
        }

        #region Clear Datas

        ((HiddenField)InvestigationControl1.FindControl("iconHid")).Value = "";
        ipTreatmentBill.GetProcedureNameByProcedure();
        txtPayment.Text = "";
        ((HiddenField)OtherPayments.FindControl("hdfValues")).Value = "";
        ((HiddenField)OtherPayments.FindControl("hdnValueExists")).Value = "";
        ((HiddenField)OtherPayments.FindControl("hdnValuesDeleted")).Value = "";

        ((HiddenField)PaymentTypes.FindControl("hdfPaymentType")).Value = "";
        ((HiddenField)PaymentTypes.FindControl("hdnPaymentsDeleted")).Value = "";

        this.Page.RegisterStartupScript("strKyClearPaidDetails", "<script type='text/javascript'> ClearScriptDatas(); </script>");
        #endregion

        loadInitialDatas();
        BindGridDatas();
        GetAmountData();
    }

    protected void loadInitialDatas()
    {
        AdvancePaid_BL objPaidBl = new AdvancePaid_BL(base.ContextInfo);
        List<AdvancePaidDetails> lstAdvancePaid = new List<AdvancePaidDetails>();

        
        decimal dAmount = 0;
        long pVisitID = 0;

        if (Request.QueryString["VID"] != null)
        {
            pVisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        if (Request.QueryString["PID"] != null)
        {
            lblPatientID.Text = Request.QueryString["PID"].ToString() == "" ? "0" : Request.QueryString["PID"].ToString();
        }
        if (Request.QueryString["PNAME"] != null)
        {
            lblPatientName.Text = Request.QueryString["PNAME"].ToString() == "" ? "" : Request.QueryString["PNAME"].ToString();
        }

        PatientHeader.PatientID = Convert.ToInt64(lblPatientID.Text);
        PatientHeader.PatientVisitID = pVisitID;

        objPaidBl.GetAdvancePaidDetails(pVisitID, out lstAdvancePaid, out dAmount);
        //lblCurrentDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");

        lblAdvancePaid.Text = dAmount.ToString("0.00");
        lblAdvancePaid1.Text = lblAdvancePaid.Text;
        //grdAdvancePaid.DataSource = lstAdvancePaid;
        //grdAdvancePaid.DataBind();
        ddlPaymentFor.SelectedIndex = 0;

       
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long createTaskID = -1;
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        Tasks task = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);

        long pVisitID = 0;

        if (Request.QueryString["VID"] != null)
        {
            pVisitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        long pPatientID = 0;
        if (Request.QueryString["PID"] != null)
        {
            pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
        }
        string sPatientName = "";
        if (Request.QueryString["PNAME"] != null)
        {
            sPatientName = Request.QueryString["PNAME"].ToString() == "" ? "" : Request.QueryString["PNAME"].ToString();
        }

        decimal dAmount = 0;
        AdvancePaid_BL objAdBL = new AdvancePaid_BL(base.ContextInfo);
        AdvancePaidDetails AdvanceDetails = new AdvancePaidDetails();

        List<PatientInvestigation> lstPatientInvestigation = new List<PatientInvestigation>();
        List<PatientDueChart> lstPatientDueChart = new List<PatientDueChart>();
        List<DHEBAdder> lstDhebAdder = new List<DHEBAdder>();
        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);

        txtPayment.Text = txtPayment.Text == "" ? "0" : txtPayment.Text;


        dAmount = Convert.ToDecimal(txtPayment.Text);
        long returnCode = -1;
        lstPatientInvestigation = InvestigationControl1.GetOrderedList();
        lstPatientDueChart = ipTreatmentBill.getInPatientProcedureDetails();
        lstDhebAdder = OtherPayments.GetValues(pVisitID);

        int returnStatus = -1;
        long returnCodePRO = -1;
        if (lstPatientDueChart.Count > 0)
        {
            List<PatientTreatmentProcedure> lstPTT = ipTreatmentBill.getPTT(pVisitID, lstPatientDueChart[0].FeeID);

            returnCodePRO = new Dialysis_BL(base.ContextInfo).InsertPatientTreatmentProcedure(lstPTT, OrgID, out returnStatus);

            if (lstPatientDueChart[0].Description == "Dialysis")
            {
                

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returnCodePRO = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
                string patientName = lstPatientVisitDetails[0].PatientName + "-" + lstPatientVisitDetails[0].Age;
                returnCodePRO = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, pVisitID, 0,
                    pPatientID, lstPatientVisitDetails[0].TitleName + " " + patientName, "", lstPatientDueChart[0].FeeID, "", 0, "", 0, "PRO", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, ""); // Other Id meand Procedure ID

                task.TaskActionID = (int)TaskHelper.TaskAction.PreDialysis;
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.PatientID = pPatientID;
                task.OrgID = OrgID;
                task.PatientVisitID = pVisitID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                returnCodePRO = taskBL.CreateTask(task, out createTaskID);
            }
                 
        }
        System.Data.DataTable dtAdvancePaidDetails = new System.Data.DataTable();
        dtAdvancePaidDetails = PaymentTypes.GetAmountReceivedDetails();

        long returnCodeINV = -1;

        List<PatientInvestigation> orderedInves = new List<PatientInvestigation>();
        if (lstPatientInvestigation.Count > 0)
        {
            foreach (PatientInvestigation inves in lstPatientInvestigation)
            {
                PatientInvestigation objInvest = new PatientInvestigation();
                objInvest.InvestigationID = inves.InvestigationID;
                objInvest.InvestigationName = inves.InvestigationName;
                objInvest.PatientVisitID = pVisitID;
                objInvest.GroupID = inves.GroupID;
                objInvest.GroupName = inves.GroupName;
                objInvest.CollectedDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                objInvest.Status = "Paid";
                objInvest.CreatedBy = LID;
                objInvest.Type = inves.Type;
                orderedInves.Add(objInvest);
            }
        }
        int pOrderedInvCnt = 0;

        returnCodeINV = new Investigation_BL(base.ContextInfo).SaveInPatientInvestigation(orderedInves, OrgID, out pOrderedInvCnt);
        if (pOrderedInvCnt > 0)
        {
            List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
            returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), pVisitID, 0,
                pPatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "INV", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
            task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
            task.DispTextFiller = dText;
            task.URLFiller = urlVal;
            task.RoleID = RoleID;
            task.OrgID = OrgID;
            task.PatientVisitID = pVisitID;
            task.PatientID = pPatientID;
            task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
            task.CreatedBy = LID;
            //Create task               
            returnCodeINV = new Tasks_BL(base.ContextInfo).CreateTaskAllowDuplicate(task, out createTaskID);
        }

        string sadvance = "";
        long IpIntermediateID = 0;
        string sType = "";
        returnCode = objAdBL.SaveAdvancePaidDetails(pVisitID, pPatientID, LID, dAmount, OrgID, lstPatientInvestigation, lstPatientDueChart, lstDhebAdder, dtAdvancePaidDetails,dServiceCharge,out sadvance,out IpIntermediateID,out sType);
        Response.Redirect("~/InPatient/BillCollect.aspx?PID=" + pPatientID + "&VID=" + pVisitID + "&PNAME=" + sPatientName + "&PTYPE=PNOW&pdid=" + IpIntermediateID.ToString() + "&pDet=" + sType + "");
    }

    protected void BindGridDatas()
    {
        long visitID = 0;
        decimal dAdvanceAmount = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        List<PatientDueChart> lstDueChart = new List<PatientDueChart>();
        List<AdvancePaidDetails> lstAdvancePaid = new List<AdvancePaidDetails>();
        new PatientVisit_BL(base.ContextInfo).GetDueChart(out lstDueChart, OrgID, visitID, "PNOW", out dAdvanceAmount, out lstAdvancePaid);
        grdDuechart.DataSource = lstDueChart;
        grdDuechart.DataBind();

        gvAdvancePaidDetails.DataSource = lstAdvancePaid;
        gvAdvancePaidDetails.DataBind();
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            long returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
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
        lblTotalAmount.Text = dTotalAmount.ToString();
        lblTotalAmount2.Text = dTotalAmount.ToString();
    }

    protected string NumberConvert(object a, object b)
    {
        decimal c = 0;
        c = (decimal)a * (decimal)b;
        return c.ToString("0.00");
    }
}

