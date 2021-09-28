using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
using System.Xml;
using System.Xml.Xsl;
using System.IO;

public partial class Billing_CCDenomination : BasePage
{
    
    string CCID = string.Empty;
    List<CashClosureDenomination> lstCCD = new List<CashClosureDenomination>();
    protected void Page_Load(object sender, EventArgs e)
    {
        BillingEngine bL = new BillingEngine(base.ContextInfo);
        CCID=Request.QueryString["CCID"].ToString();
        bL.GetCCDenominationDetail(CCID, OrgID, LID, out lstCCD);
        if (lstCCD.Count > 0)
        {
            gvResult.DataSource = lstCCD;
            gvResult.DataBind();
            lblCCDatetxt.Text = lstCCD[0].CreatedAt.ToString("dd/MM/yyyy hh:mm:ss");
            lblUserNametxt.Text = lstCCD[0].Name;
            NumberToWord.NumberToWords num = new NumberToWord.NumberToWords();
            double amt = Convert.ToDouble(lstCCD.Sum(p => p.Amount));
           
            if (amt > 0)
            {
                lblAmountword.Text = Utilities.FormatNumber2Word(num.Convert(amt.ToString()));
            }
            lblReceiverSign.Text = "Signature <br> " + lstCCD[0].Name;
        }


    }
    protected void gvResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label lblTotalSum = (Label)e.Row.FindControl("lblTotalSum");
            lblTotalSum.Text = lstCCD.Sum(p => p.Amount).ToString("0.00");

        }
    }
}
