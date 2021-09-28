using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using NumberToWord;


public partial class Printing_ConsolidateReport : BasePage
{
    long patientVisitID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        long FinalBillID = 0;
        if (!Page.IsPostBack)
        {
            Int64.TryParse(Request.QueryString["bid"], out FinalBillID);
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                OPCaseSheet1.LoadPatientDetails(patientVisitID, 0);
                //BillPrint1.BillPrinting(patientVisitID, FinalBillID);
            }
        }
        int pdp = -1;
        string RedirectPage = GetConfigValue("BillPrintControl", OrgID);
        Control objCtrl;
        if (RedirectPage != string.Empty)
        {
            objCtrl = LoadControl("../CommonControls/RakshithBillPrint.ascx");
            Billing_RakshithBillPrint rakshithbillPrint = (Billing_RakshithBillPrint)objCtrl;
            rakshithbillPrint.BillPrinting(patientVisitID, FinalBillID,pdp);
            //rakshithbillPrint.Visible = true;
            //BillPrint1.Visible = false;
        }
        else
        {
            objCtrl = LoadControl("../CommonControls/BillPrint.ascx");
            Billing_BillPrint oBaseBillPrint = (Billing_BillPrint)objCtrl;
            oBaseBillPrint.LoadBillConfigMetadata(OrgID, ILocationID);
            oBaseBillPrint.BillPrinting(patientVisitID, FinalBillID, pdp);
            //BillPrint1.Visible = true;
            //rakshithbillPrint.Visible = false;
        }
        pnlBillPrint.Controls.Add(objCtrl);

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
