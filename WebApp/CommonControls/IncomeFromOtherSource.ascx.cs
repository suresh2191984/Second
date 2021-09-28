using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
public partial class CommonControls_IncomeFromOtherSource : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //LoadIncomeSourceData(FromDate, ToDate, LoginID);
    }
    /// <summary>
    /// Call this Method to load Income from other source details, based on the following parameters
    /// </summary>
    /// <param name="FromDate"> </param>
    /// <param name="ToDate"></param>
    /// <param name="LoginID"> pass 0 show all record or pass loginid shows only collected by patricular login </param>
    /// <param name="CurrencyID"> Pass 0 show all currency record and Pass particular currency for fileteration </param>
    /// <param name="DataCount">out parameter based on count, set Control visibility either true or false in page</param>
    /// <returns></returns>
    public long LoadIncomeSourceData(DateTime FromDate, DateTime ToDate, long LoginID, int CurrencyID, out long DataCount)
    {
        long returnCode = -1;
        DataCount = 0;
        try
        {
            List<IncSourcePaidDetails> incSourcePaidDetails = new List<IncSourcePaidDetails>();
            returnCode = new Report_BL(base.ContextInfo).GetIncomeSourceReport(FromDate, ToDate, OrgID, LoginID, CurrencyID, out  incSourcePaidDetails);
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
            Attune.Podium.Common.CLogger.LogError("Error in (CommonControls_IncomeFromOtherSource)LoadIncomeSourceData method", ex);

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
