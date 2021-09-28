using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CommonControls_BalanceCalc : System.Web.UI.UserControl
{
    private decimal ctrlgivenAmount = 0;
    public decimal CtrlGivenAmount
    {
        get { return ctrlgivenAmount; }
        set { ctrlgivenAmount = value; }
    }
    private decimal ctrlbalanceAmount = 0;
    public decimal CtrlBalanceAmount
    {
        get { return ctrlbalanceAmount; }
        set { ctrlbalanceAmount = value; }
    }
    private string isBilling = "Y";
    public string IsBilling
    {
        get { return isBilling; }
        set { isBilling = value; }
    }
     
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsBilling == "N")
        {
            txtGivenAmount.Enabled = true;
        }
    }
    public void setAmounts()
    {
        CtrlGivenAmount = txtGivenAmount.Text == "" ? 0 : Convert.ToDecimal(txtGivenAmount.Text);
        CtrlBalanceAmount = hdnBalanceAmount.Value == "" ? 0 : Convert.ToDecimal(hdnBalanceAmount.Value);
    }
}
