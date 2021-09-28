using System;
using Attune.Podium.Common;

public partial class Ledger_InvoiceLedgerClosing : BasePage 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

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
            CLogger.LogError("Error while Page Loading in Ledger Closing List :" + ex.ToString() + " Inner Exception-", ex.InnerException);

        }
    }
}
