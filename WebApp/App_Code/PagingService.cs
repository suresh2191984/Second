using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

/// <summary>
/// Summary description for PagingService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class PagingService : System.Web.Services.WebService
{

    public PagingService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    /// <summary>
    /// send to nutrition
    /// </summary>
    /// <param name="OrgID"></param>
    /// <param name="FoodSessionID"></param>
    /// <param name="WardID"></param>
    /// <param name="CurrentStatus"></param>
    /// <param name="pno"></param>
    /// <param name="TotalRows"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public List<FoodOrderedDetails> ProcessFoodOrderedDetails(Int32 OrgID, Int64 FoodSessionID, Int64 WardID, String CurrentStatus, int pno, int TotalRows)
    {
        List<FoodOrderedDetails> lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        TotalRows = -1;
        try
        {
            Nutrition_BL oNutrition_BL = new Nutrition_BL();
            oNutrition_BL.GetFoodOrderedDetails(OrgID, FoodSessionID, WardID, CurrentStatus, out TotalRows, 10, pno, out lstFoodOrderedDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Process Report", ex);
        }
        return lstFoodOrderedDetails;
    }

    /// <summary>
    /// cnd (central nutrition department)
    /// </summary>
    /// <param name="OrgID"></param>
    /// <param name="SessionID"></param>
    /// <param name="WardID"></param>
    /// <param name="pno"></param>
    /// <param name="totalRows"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public List<FoodOrderedDetails> ProcessFoodDeliveredDetails(long OrgID, long SessionID, long WardID, int pno, int totalRows)
    {
        List<FoodOrderedDetails> lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        totalRows = -1;
        try
        {
            Nutrition_BL oNutrition_BL = new Nutrition_BL();
            int pageSize = 10;
            oNutrition_BL.GetFoodDeliveredDetails(OrgID, "OrderedToCND", SessionID, WardID, pageSize, pno, out totalRows, out lstFoodOrderedDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Process Report", ex);
        }
        return lstFoodOrderedDetails;
    }

    /// <summary>
    /// received in ward
    /// </summary>
    /// <param name="OrgID"></param>
    /// <param name="pno"></param>
    /// <param name="totalRows"></param>
    /// <returns></returns>
    [WebMethod(EnableSession = true)]
    public List<FoodOrderedDetails> ProcessCompletedFoodDetails(Int32 OrgID, int pno, int totalRows)
    {
        List<FoodOrderedDetails> lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        totalRows = -1;
        try
        {
            Nutrition_BL oNutrition_BL = new Nutrition_BL();
            int pageSize = 10;
            oNutrition_BL.GetCompletedFoodDetails(OrgID, "OrderReceivedFromCND", pageSize, pno, out totalRows, out lstFoodOrderedDetails);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Process Report", ex);
        }
        return lstFoodOrderedDetails;
    }
}

