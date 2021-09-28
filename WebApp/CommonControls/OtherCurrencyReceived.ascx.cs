using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CommonControls_OtherCurrencyReceived : System.Web.UI.UserControl
{
    private bool isDisplayPayedAmount = true;
    public bool IsDisplayPayedAmount
    {
        get { return isDisplayPayedAmount; }
        set { isDisplayPayedAmount = value; }
    }

    private bool isDisplayOtherCurr = true;
    public bool IsDisplayOtherCurr
    {
        get { return isDisplayOtherCurr; }
        set { isDisplayOtherCurr = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsDisplayPayedAmount==false)
        {
            tbAmountPayble.Style.Add("display", "none");
        }
        if (isDisplayOtherCurr == false)
        {
            tbOtherCurr.Style.Add("display", "none");
        }
    }
    public void GetOtherCurrRecd(out decimal OterCurrReceived)
    {
        OterCurrReceived = 0;
        Decimal.TryParse(hdnOterCurrReceived.Value,out OterCurrReceived);
    }
}
