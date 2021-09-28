using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using ReportingService;
using System.Security.Principal;
using System.Data;
using Microsoft.Reporting.WebForms;

public partial class CommonControls_GeneralBillItems : BaseControl
{
    long returnCode = -1;
   

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadGeneralBillItems();
        }
    }
    public void LoadGeneralBillItems()
    {
        long visitID = 0;
        if (Request.QueryString["VID"] != null)
        {
            visitID = Request.QueryString["VID"].ToString() == "" ? 0 : Convert.ToInt64(Request.QueryString["VID"].ToString());
        }
        List<GeneralBillingItems> lstGBI = new List<GeneralBillingItems>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetGeneralBillItems(OrgID,visitID, out lstGBI);
        ddlGBI.DataSource = lstGBI;
        ddlGBI.DataTextField = "ItemName";
        ddlGBI.DataValueField = "ItemID";
        ddlGBI.DataBind();
        ddlGBI.Items.Insert(0, "--Select--");
    }
}
