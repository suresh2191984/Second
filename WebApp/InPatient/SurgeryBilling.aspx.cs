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

public partial class InPatient_SurgeryBilling: BasePage
{

    public InPatient_SurgeryBilling()
        : base("InPatient\\SurgeryBilling.aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long visitID = 0;
    long pPatientID = 0;
    IP_BL ipBL;
    string NeedCreditLimt = string.Empty;
    decimal totalBilled = 0;
    decimal TotalCashandCreditLimitInHand = 0;
    string isPortTrust = "N";
    decimal EditSurgeryAmount = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        ipBL = new IP_BL(base.ContextInfo);
        try
        {

            if (Request.QueryString["VID"] != null)
            {
                visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
            }

            if (Request.QueryString["PID"] != null)
            {
                pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
            }

            if (!IsPostBack)
            {

                NeedCreditLimt = GetConfigValue("CreditLimitForIP", OrgID);
                if (NeedCreditLimt != "" && NeedCreditLimt == "Y")
                {
                    hdnOrgCreditLimt.Value = "Y";
                }


                if (Request.QueryString["PID"] != null)
                {
                    pPatientID = Request.QueryString["PID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["PID"].ToString());
                }
                PatientHeader.PatientID = pPatientID;
                PatientHeader.PatientVisitID = visitID;

                if (visitID != 0)
                {

                    SurgeryBilling1.lVisitID = visitID;
                    SurgeryBilling1.lPatientID = pPatientID;
                    SurgeryBilling1.BindSurgeryDetailByVisitID();
                    //Load Data's for Particular visit in Investigation Control

                }

            }
            if (hdnOrgCreditLimt.Value == "Y")
            {
                ucCreditLimit.LoadCreditDetails(pPatientID, visitID, OrgID);

            }

            string strConfigKey = "IPMakePayment";
            string configValue = GetConfigValue(strConfigKey, OrgID);

            if (configValue == "N")
            {
                btnMakePayment.Visible = false;
            }
            else
            {
                btnMakePayment.Visible = true;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error on Investigation PageLoad", ex);
        }
    }
    public void AddToDueForNormal()
    {
        long SurgeryFeeId = -1;
        decimal pTotalAmount = -1;
        long returnCode = -1;
        long SurgeryBillingID = -1;
        string Type = string.Empty;
        string InterimBillNo = string.Empty ;
        List<SurgeryBillingDetails> lstSurgeryBillingDetails = new List<SurgeryBillingDetails>();
        List<SurgeryBillingMaster> lstSurgeryBillingMaster = new List<SurgeryBillingMaster>();
        lstSurgeryBillingMaster = SurgeryBilling1.LoadSurgeryBillingMasterData(visitID, pPatientID);

        if (lstSurgeryBillingMaster[0].SurgeryBillingID > 0)
        {
            Type = "U";
            SurgeryBillingID = lstSurgeryBillingMaster[0].SurgeryBillingID;
            lstSurgeryBillingDetails = SurgeryBilling1.LoadSurgeryBillingDetails();
            returnCode = ipBL.SaveSurgeryBillingDetails(SurgeryBillingID, Type, pPatientID, visitID, OrgID, lstSurgeryBillingMaster, lstSurgeryBillingDetails, lstSurgeryBillingMaster[0].CreatedAt, out pTotalAmount);
            SurgeryFeeId = returnCode;
            SurgeryBilling1.ClearData();
            SurgeryBilling1.lVisitID = visitID;
            SurgeryBilling1.BindSurgeryDetailByVisitID();
        }
        else
        {
            Type = "I";
            lstSurgeryBillingDetails = SurgeryBilling1.LoadSurgeryBillingDetails();
            returnCode = ipBL.SaveSurgeryBillingDetails(SurgeryBillingID, Type, pPatientID, visitID, OrgID, lstSurgeryBillingMaster, lstSurgeryBillingDetails, lstSurgeryBillingMaster[0].CreatedAt, out pTotalAmount);
            SurgeryFeeId = returnCode;
            SurgeryBilling1.ClearData();
            ipBL.InsertSurgeryBillingToDue(lstSurgeryBillingMaster, visitID, LID, pPatientID, SurgeryFeeId, pTotalAmount, out InterimBillNo);
            SurgeryBilling1.lVisitID = visitID;
            SurgeryBilling1.BindSurgeryDetailByVisitID();

        }
        //List<PatientDueChart> lstSurgeryBilling = new List<PatientDueChart>();
        //lstSurgeryBilling = GetSurgeryBilling(returnCode, lstSurgeryBillingMaster);

        string sPage = "../Inpatient/PrintDueRequestPage.aspx?ReferenceID="
               + InterimBillNo.ToString() + "&dDate="
               + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
            //+ "&PNAME=" + patientName
               + "&PID=" + pPatientID.ToString()
               + "&VID=" + visitID.ToString()
               + "&IsAddServices=N"
               + "&IsPopup=Y";
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sky1", "<script language='javascript'> window.open('" + sPage + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>", false);


    }
    public void AddToDueCreditLimitPatient()
    {
        long SurgeryFeeId = -1;
        decimal pTotalAmount = -1;
        long returnCode = -1;
        long SurgeryBillingID = -1;
        string Type = string.Empty;
        string InterimBillNo = string.Empty;
        List<SurgeryBillingDetails> lstSurgeryBillingDetails = new List<SurgeryBillingDetails>();
        List<SurgeryBillingMaster> lstSurgeryBillingMaster = new List<SurgeryBillingMaster>();
        ucCreditLimit.GetCreditLimitValue(out TotalCashandCreditLimitInHand, out isPortTrust);
        lstSurgeryBillingMaster = SurgeryBilling1.LoadSurgeryBillingMasterData(visitID, pPatientID);
        if (lstSurgeryBillingMaster.Count > 0)
        {
            for (int i = 0; i < lstSurgeryBillingMaster.Count; i++)
            {
                totalBilled = totalBilled + lstSurgeryBillingMaster[i].SurgicalFee +
                                         lstSurgeryBillingMaster[i].ChiefSurgeonFee +
                                         lstSurgeryBillingMaster[i].OTCharges +
                                         lstSurgeryBillingMaster[i].Consumables +
                                         lstSurgeryBillingMaster[i].RoomCharges +
                                         lstSurgeryBillingMaster[i].ProsthesisFee;



            }
        }

        if (lstSurgeryBillingMaster[0].SurgeryBillingID > 0)
        {
            Type = "U";
            SurgeryBillingID = lstSurgeryBillingMaster[0].SurgeryBillingID;
            lstSurgeryBillingDetails = SurgeryBilling1.LoadSurgeryBillingDetails();
            if (lstSurgeryBillingDetails.Count > 0)
            {
                for (int i = 0; i < lstSurgeryBillingDetails.Count; i++)
                {
                    totalBilled = totalBilled + lstSurgeryBillingDetails[i].Value;
                }
            }
            SurgeryBilling1.GetEditSurgeryAmount(out EditSurgeryAmount);
            if (totalBilled >= (TotalCashandCreditLimitInHand + EditSurgeryAmount) && isPortTrust != "Y")
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "sky", "javascript:CreditLimitExit();", true);
            }
            else
            {
                returnCode = ipBL.SaveSurgeryBillingDetails(SurgeryBillingID, Type, pPatientID, visitID, OrgID, lstSurgeryBillingMaster, lstSurgeryBillingDetails, lstSurgeryBillingMaster[0].CreatedAt, out pTotalAmount);
                SurgeryFeeId = returnCode;
                SurgeryBilling1.ClearData();
                SurgeryBilling1.lVisitID = visitID;
                SurgeryBilling1.BindSurgeryDetailByVisitID();
            }
        }
        else
        {
            Type = "I";
            lstSurgeryBillingDetails = SurgeryBilling1.LoadSurgeryBillingDetails();

            if (lstSurgeryBillingDetails.Count > 0)
            {
                for (int i = 0; i < lstSurgeryBillingDetails.Count; i++)
                {
                    totalBilled = totalBilled + lstSurgeryBillingDetails[i].Value;
                }
            }
            if (totalBilled > TotalCashandCreditLimitInHand && isPortTrust != "Y")
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "sky", "javascript:CreditLimitExit();", true);

            }
            else
            {
                returnCode = ipBL.SaveSurgeryBillingDetails(SurgeryBillingID, Type, pPatientID, visitID, OrgID, lstSurgeryBillingMaster, lstSurgeryBillingDetails, lstSurgeryBillingMaster[0].CreatedAt, out pTotalAmount);
                SurgeryFeeId = returnCode;
                SurgeryBilling1.ClearData();
                ipBL.InsertSurgeryBillingToDue(lstSurgeryBillingMaster, visitID, LID, pPatientID, SurgeryFeeId, pTotalAmount, out InterimBillNo);
                SurgeryBilling1.lVisitID = visitID;
                SurgeryBilling1.BindSurgeryDetailByVisitID();
            }
        }
        //List<PatientDueChart> lstSurgeryBilling = new List<PatientDueChart>();
        //lstSurgeryBilling = GetSurgeryBilling(returnCode, lstSurgeryBillingMaster);
        if (InterimBillNo != "")
        {
            string sPage = "../Inpatient/PrintDueRequestPage.aspx?ReferenceID="
                   + InterimBillNo.ToString() + "&dDate="
                   + Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt")
                //+ "&PNAME=" + patientName
                   + "&PID=" + pPatientID.ToString()
                   + "&VID=" + visitID.ToString()
                   + "";
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "sky1", "<script language='javascript'> window.open('" + sPage + "', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');</script>", false);
        }
        if (hdnOrgCreditLimt.Value == "Y")
        {
            ucCreditLimit.LoadCreditDetails(pPatientID, visitID, OrgID);

        }

    }
    protected void btnAddToDueChart_Click(object sender, EventArgs e)
    {
        if (hdnOrgCreditLimt.Value == "N")
        {
            AddToDueForNormal();
        }
        if (hdnOrgCreditLimt.Value == "Y")
        {
            AddToDueCreditLimitPatient();
        }
    }
    protected void btnMakePayment_Click(object sender, EventArgs e)
    {
        try
        {

            long SurgeryFeeId = -1;
            decimal pTotalAmount = -1;
            long returnCode = -1;
            long SurgeryBillingID = -1;
            string Type = string.Empty;
            List<SurgeryBillingDetails> lstSurgeryBillingDetails = new List<SurgeryBillingDetails>();
            List<SurgeryBillingMaster> lstSurgeryBillingMaster = new List<SurgeryBillingMaster>();

            lstSurgeryBillingMaster = SurgeryBilling1.LoadSurgeryBillingMasterData(visitID, pPatientID);


            if (lstSurgeryBillingMaster[0].SurgeryBillingID > 0)
            {
                Type = "U";
                SurgeryBillingID = lstSurgeryBillingMaster[0].SurgeryBillingID;
                lstSurgeryBillingDetails = SurgeryBilling1.LoadSurgeryBillingDetails();
                returnCode = ipBL.SaveSurgeryBillingDetails(SurgeryBillingID, Type, pPatientID, visitID, OrgID, lstSurgeryBillingMaster, lstSurgeryBillingDetails, lstSurgeryBillingMaster[0].CreatedAt, out pTotalAmount);
                SurgeryFeeId = returnCode;
                SurgeryBilling1.ClearData();
                SurgeryBilling1.lVisitID = visitID;
                SurgeryBilling1.BindSurgeryDetailByVisitID();
            }
            else
            {
                Type = "I";
                lstSurgeryBillingDetails = SurgeryBilling1.LoadSurgeryBillingDetails();
                returnCode = ipBL.SaveSurgeryBillingDetails(SurgeryBillingID, Type, pPatientID, visitID, OrgID, lstSurgeryBillingMaster, lstSurgeryBillingDetails, lstSurgeryBillingMaster[0].CreatedAt, out pTotalAmount);
                SurgeryFeeId = returnCode;
                SurgeryBilling1.ClearData();
                string InterimBillNo = string.Empty;
                ipBL.InsertSurgeryBillingToDue(lstSurgeryBillingMaster, visitID, LID, pPatientID, SurgeryFeeId, pTotalAmount, out InterimBillNo);
                SurgeryBilling1.lVisitID = visitID;
                SurgeryBilling1.BindSurgeryDetailByVisitID();
            }

            if (returnCode != -1)
            {
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                returnCode = -1;
                long returnCodeINV = -1;
                long createTaskID = -1;
                Tasks task = new Tasks();
                Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);

                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();

                returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(visitID, out lstPatientVisitDetails);
                returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSurgeryPayment), visitID, 0,
                pPatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", 0, "", 0, "SOI", out dText, out urlVal, 0, lstPatientVisitDetails[0].PatientNumber, lstPatientVisitDetails[0].TokenNumber, "");
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSurgeryPayment);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = visitID;
                task.PatientID = pPatientID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                //Create task               
                returnCodeINV = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);

            }
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            CLogger.LogError("Error in SurgeryBilling.aspx:Page_Load", ex);
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
    protected void btnClose_Click(object sender, EventArgs e)
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


}
