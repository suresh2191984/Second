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
using Attune.Solution.BusinessLogic_Ledger;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.IO;
using System.Xml;
using System.Drawing;
using System.ComponentModel;
using Attune.Podium.ExcelExportManager;
using Attune.Podium.PerformingNextAction;
using Attune.Solution.BusinessComponent;

public partial class Ledger_InvoiceAdvancePayment : BasePage
{

    ClientCredit ClientCreditdet = new ClientCredit();
    ClientDebit ClientDebitdet = new ClientDebit();
    string type = string.Empty;
    string PaymentType = string.Empty;
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
    protected void Page_Load(object sender, EventArgs e)
    {


        if (!IsPostBack)
        {
           

          
                txtCashDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                ddlType_SelectedIndexChanged(sender, e);
         }

        //AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
        AutoCompleteExtender2.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
        hdnClientLoginID.Value = LID.ToString();
        hdnDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        hdnOrgID.Value = OrgID.ToString();
        hdnDrivePath.Value = GetConfigValue("LedgerProofCopy", OrgID);
        hdnCID.Value = CID.ToString();


        //handlerpath.Value = ConfigurationManager.AppSettings["DriveName"].ToString();
    }
    List<ClientCredit> CreditValue = new List<ClientCredit>();
    List<ClientDebit> DebitValue = new List<ClientDebit>();
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void btnReset_click(object sender, EventArgs e)
    {
        //cleardata();
    }

    protected void btnCashReset_Click(object sender, EventArgs e)
    {
       
    }
   
    protected void btnCashSubmit_Click(object sender, EventArgs e)
    {
        Response.Redirect("../Ledger/InvoiceAdvancePayment.aspx");
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}
