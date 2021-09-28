using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryReports.BL;

public partial class InventoryReports_Controls_IncomeFromOtherSource : Attune_BaseControl
{
    public InventoryReports_Controls_IncomeFromOtherSource()
        : base("InventoryReports_Controls_IncomeFromOtherSource_ascx")
    { }
    protected void Page_Load(object sender, EventArgs e)
    {
    }
    public long LoadIncomeSourceData(DateTime FromDate, DateTime ToDate, long LoginID, int CurrencyID, out long DataCount)
    {
        long returnCode = -1;
        DataCount = 0;
        try
        {
            List<IncSourcePaidDetails> incSourcePaidDetails = new List<IncSourcePaidDetails>();
            returnCode = new InventoryReports_BL(base.ContextInfo).GetIncomeSourceReport(FromDate, ToDate, OrgID, LoginID, CurrencyID, out  incSourcePaidDetails);
            if (incSourcePaidDetails.Count > 0)
            {
                grdothersrc.DataSource = incSourcePaidDetails;
                grdothersrc.DataBind();
                DataCount = incSourcePaidDetails.Count;
                GetOtherSourceTotal = incSourcePaidDetails.Sum(O => O.ReceivedCurrencyvalue);

            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in (CommonControls_IncomeFromOtherSource)LoadIncomeSourceData method", ex);

        } return returnCode;
    }
    private DateTime _fromDate = System.DateTime.MinValue;
    public DateTime FromDate
    {
        get { return _fromDate; }
        set { _fromDate = value; }
    }
    private DateTime _ToDate = System.DateTime.MinValue;

    public DateTime ToDate
    {
        get { return _ToDate; }
        set { _ToDate = value; }
    }
    long _loginID = 0;

    public long LoginID
    {
        get { return _loginID; }
        set { _loginID = value; }
    }
    private decimal _getOtherSourceTotal = 0;

    public decimal GetOtherSourceTotal
    {
        get { return _getOtherSourceTotal; }
        set { _getOtherSourceTotal = value; }
    }
}
