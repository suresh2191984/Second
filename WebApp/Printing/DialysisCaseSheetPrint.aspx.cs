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
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;

public partial class Dialysis_DialysisCaseSheetPrint : BasePage
{
    long visitID = 0;
    long taskID = 0;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        int pdp = -1;
        long FinalBillID = 0;
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        Int64.TryParse(Request.QueryString["bid"], out FinalBillID);

        if (Request.QueryString["tid"] != null)
        {
            Int64.TryParse(Request.QueryString["tid"], out taskID);
            new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, UID);
        }
       
        try
        {
            patientHeader.PatientVisitID = visitID;
            patientHeader.ShowVitalsDetails();
            string RedirectPage = GetConfigValue("BillPrintControl", OrgID);
            Control objCtrl;

            if (RedirectPage != string.Empty)
            {
                objCtrl = LoadControl("../CommonControls/RakshithBillPrint.ascx");
                Billing_RakshithBillPrint oRakshithBillPrint = (Billing_RakshithBillPrint)objCtrl;
                oRakshithBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                //rakshithbillPrint.Visible = true;
                //billprinting1.Visible = false;
            }
            else
            {
                objCtrl = LoadControl("../CommonControls/BillPrint.ascx");
                Billing_BillPrint oBaseBillPrint = (Billing_BillPrint)objCtrl;
                oBaseBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
                oBaseBillPrint.BillPrinting(visitID, FinalBillID, pdp);
                //billprinting1.Visible = true;
                //rakshithbillPrint.Visible = false;
            }
            pnlBillPrint.Controls.Add(objCtrl);
            DialysisCaseSheet1.loadDialysisDetails(visitID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Dialysis CaseSheet Page_Load ", ex);
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
            returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
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
}
