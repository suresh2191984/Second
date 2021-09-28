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

public partial class Ledger_CreditDebitOutstandingResult : BasePage
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnOrgid.Value = OrgID.ToString();

    }

    protected void btnback_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClientOutstanding.aspx");
    }
}

