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
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;

public partial class Lab_EditInvestigation : BasePage
{
    public Lab_EditInvestigation()
        : base("Lab\\EditInvestigation.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    long vid = -1;
    long returnCode = -1;
    int pCount = -1;

    protected void Page_Load(object sender, EventArgs e)
    {

    }
}
