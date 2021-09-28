using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.BillingEngine;

public partial class Billing_HospitalBillSearch : BasePage
{

    public Billing_HospitalBillSearch()
        : base("Billing_HospitalBillSearch_aspx")
    {
    }    

    #region "Initial"

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        uctrlBillSearch.onSearchComplete += new EventHandler(uctrlBillSearch_onSearchComplete);
    }

    #endregion

    #region "Events"

    protected void uctrlBillSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctrlBillSearch.HasResult)
        {
            aRow.Visible = true;
        }
        else
        {
            aRow.Visible = false;
        }
    }

    #endregion

    #region "Methods"

    private bool validatePage(long bid)
    {
        string strSelectBill = Resources.Billing_ClientDisplay.Billing_ReceiptSearch_aspx_01 == null ? "Please Select a Bill" : Resources.Billing_ClientDisplay.Billing_ReceiptSearch_aspx_01;
        bool retval = true;
        string error = "";
        if (bid <= 0)
        {
            retval = false;
            error = strSelectBill.Trim();
        }
        // ErrorDisplay1.ShowError = true;
        // ErrorDisplay1.Status = error;
        return retval;
    }

    #endregion
}
