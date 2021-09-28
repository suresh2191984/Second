using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

/// <summary>
/// Summary description for ReportPrintingService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class ReportPrintingService : System.Web.Services.WebService
{

    public ReportPrintingService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }





    #region GetPatientDetailsVisitNumber
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<ReportPrinting> GetPatientDetailsVisitNumber(string prefixText)
    {
        
        List<ReportPrinting> lstReportPrinting = new List<ReportPrinting>();
        try
        {
            long returnCode = -1;
            returnCode = new Report_BL(new BaseClass().ContextInfo).GetPatientDetailsVisitNumber(prefixText, out lstReportPrinting);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return lstReportPrinting;
    }
    #endregion


    #region GetPatientReportPrintingStatus
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<ReportPrinting> GetPatientReportPrintingStatus(long VisitID)
    {

        List<ReportPrinting> lstReportPrinting = new List<ReportPrinting>();
        try
        {
            long returnCode = -1;
            returnCode = new Report_BL(new BaseClass().ContextInfo).GetPatientReportPrintingStatus(VisitID, out lstReportPrinting);
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return lstReportPrinting;
    }
    #endregion


}

