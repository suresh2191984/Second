using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class Reports_TNPReport : BasePage
{
    public Reports_TNPReport()
        : base("Reports\\TNPReport.aspx")
    {

    }
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                HdnOrgID.Value = OrgID.ToString();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Page Load", ex);
        }

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {

    }
    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {




        // grdResult.RenderControl(oHtmlTextWriter);



    }
}
