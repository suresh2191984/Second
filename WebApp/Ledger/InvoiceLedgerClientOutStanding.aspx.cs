using System;
using Attune.Podium.Common;

public partial class Ledger_InvoiceLedgerClientOutStanding : BasePage 
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                lblm1.InnerHtml=Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(0).ToString("MMMM");
                lblm2.InnerHtml = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1).ToString("MMMM");
                lblm3.InnerHtml = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-2).ToString("MMMM");
                lblm4.InnerHtml = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-3).ToString("MMMM");
                lblm5.InnerHtml = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-3).ToString("MMMM") + " > ";
                hdnOrgID.Value = OrgID.ToString();
                if (CID > 0)
                {
                    hdnCID.Value = CID.ToString();
                    hdnclientType.Value = "CLP";
                }
                else
                {
                    hdnCID.Value = "0";
                    hdnclientType.Value = "CLI";
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load while Outsatnding List :" + ex.ToString() + " Inner Exception-", ex.InnerException);

        }


    }
  

}
