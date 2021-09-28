using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BusinessEntities.CustomEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Data.SqlClient;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Drawing;
using System.IO;

public partial class Reports_DoctorWiseReport : BasePage
{
    public Reports_DoctorWiseReport()
        : base("Reports_DoctorWiseReport_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("..//Reports//ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
}
