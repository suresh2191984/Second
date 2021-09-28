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

public partial class Ledger_ClientMonthClosing : BasePage
{

    protected void Page_Load(object sender, EventArgs e)
    {
        //txtFrom.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).AddMonths(-1).ToString("dd/MM/yyyy");
        //txtTo.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
        hdnClientID.Value = string.Empty;
        hdnOrgID.Value = OrgID.ToString();
        AutoCompleteExtender1.ContextKey = OrgID.ToString() + "~" + "CLIENTZONE" + "~" + -1;
    }





}
