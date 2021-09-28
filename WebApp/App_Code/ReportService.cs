using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

/// <summary>
/// Summary description for ReportService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
// [System.Web.Script.Services.ScriptService]
public class ReportService : System.Web.Services.WebService
{

    public ReportService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

   [WebMethod(EnableSession = true)]
    public List<byte[]> ProcessReport(Int32 OrgID, Int64 LocationID)
    {
        long returnCode = -1;
        List<byte[]> lstReport = new List<byte[]>();
        try
        {
            List<ReportSnapshot> lstReportSnapshot = new List<ReportSnapshot>();
            Report_BL objReportBL = new Report_BL(new BaseClass().ContextInfo);
            returnCode = objReportBL.GetReportSnapshot(OrgID, LocationID, 0, true,"", out lstReportSnapshot);
            lstReport = (from child in lstReportSnapshot
                         select child.Content).ToList();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Process Report", ex);
        }
        return lstReport;
    }
}

