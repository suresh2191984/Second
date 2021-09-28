<%@ WebService Language="C#" Class="WebService" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using Attune.Podium.Common;
using System.Web.Script.Serialization;
using System.Collections;
using MonitoringSystem;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class WebService  : System.Web.Services.WebService {

    int totalRows = 0;
    public WebService()
    {

    }

    #region GetAllCategoriesandFolders
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetAllCategoriesandFolders(long FolderID)
    {
        List<PMSCategories> lstCategories = new List<PMSCategories>();
        List<PMSFolders> lstFolders = new List<PMSFolders>();
        ArrayList a = new ArrayList();

        try
        {
            long returnCode = -1;
            returnCode = new PMS_BL(new BaseClass().ContextInfo).GetAllCategoriesandFolders(FolderID, out lstCategories, out lstFolders);
            a.Add(lstCategories);
            a.Add(lstFolders);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService GetAllCategoriesandFolders Message:", ex);
        }
        return a;
    }
    #endregion

    #region GetParametersforProcedure
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetParametersforProcedure(long ProcedureID)
    {
        List<PMSProcedureParameters> lstProcedureParameters = new List<PMSProcedureParameters>();
        ArrayList a = new ArrayList();

        try
        {
            long returnCode = -1;
            returnCode = new PMS_BL(new BaseClass().ContextInfo).GetParametersforProcedure(ProcedureID, out lstProcedureParameters);
            a.Add(lstProcedureParameters);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService GetParametersforProcedure Message:", ex);
        }
        return a;
    }
    #endregion

    #region RenderingReport
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList RenderingReport(long ProcedureID, string StringParam)
    {
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        oJavaScriptSerializer.MaxJsonLength = 2147483644;
        ArrayList OutArray = new ArrayList();
        DataSet lstOutDataSet = new DataSet();
        DataTable dt = new DataTable();

        try
        {
            lstOutDataSet = new PMS_BL(new BaseClass().ContextInfo).RenderingReport(ProcedureID, StringParam);
            dt = lstOutDataSet.Tables[0];
            //dt.Columns.Remove("Rowid");
            Dictionary<string, object> row;
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();

            foreach (DataRow dr in dt.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dt.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }
            OutArray.Add(oJavaScriptSerializer.Serialize(rows));
            OutArray.Add(totalRows);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService RenderingReport Message:", ex);
        }
        return OutArray;
    }
    #endregion


    #region GetDDLValuesForParameters
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public ArrayList GetDDLValuesForParameters(long ParamQueryID, long lID)
    {
        List<PMSDDLOutput> lstDDLOutput = new List<PMSDDLOutput>();
        ArrayList a = new ArrayList();

        try
        {
            long returnCode = -1;
            returnCode = new PMS_BL(new BaseClass().ContextInfo).GetDDLValuesForParameters(ParamQueryID,lID, out lstDDLOutput);
            a.Add(lstDDLOutput);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in  ReportTool_WebService GetDDLValuesForParameters Message:", ex);
        }
        return a;
    }
    #endregion

    
}

