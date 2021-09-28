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

public partial class Ledger_CreditDebitStatus : BasePage
{
    public DateTime from, to;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnorgid.Value = OrgID.ToString();
        if (!IsPostBack)
        {

            txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddDays(-10).ToString("dd/MM/yyyy");
            txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");

        }
        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;

    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void btnReset_click(object sender, EventArgs e)
    {
        Response.Redirect("CreditDebitStatus.aspx");
    }
}
