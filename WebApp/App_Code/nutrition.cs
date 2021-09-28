using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Xml.Linq;
using Attune.Podium.Common;
using System.Web.Script.Serialization;
using System.Web.Script.Services;

/// <summary>
/// Summary description for nutrition
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class nutrition : System.Web.Services.WebService
{

    public nutrition()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    #region GetFoodList
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Diet_FoodList> GetFoodList(long orgid, long FoodMenuID, long FoodSessionID)
    {
        List<Diet_FoodList> lstFoodList = new List<Diet_FoodList>();
        try
        {
            long returnCode = -1;
            Nutrition_BL objNutrition_BL = new Nutrition_BL(new BaseClass().ContextInfo);
            returnCode = objNutrition_BL.GetFoodList(orgid, FoodMenuID, FoodSessionID, out lstFoodList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in nutrition Web Service GetFoodList Message:", ex);
        }
        return lstFoodList;
    }
    #endregion



    #region GetFoodList
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public List<Diet_FoodList> SaveFoodList(string FoodList)
    {
        List<Diet_FoodList> lstFoodList = new List<Diet_FoodList>();
        try
        {
            long returnCode = -1;
            Nutrition_BL objNutrition_BL = new Nutrition_BL(new BaseClass().ContextInfo);
            //returnCode = objNutrition_BL.GetFoodList(orgid, FoodMenuID, FoodSessionID, out lstFoodList);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in nutrition Web Service GetFoodList Message:", ex);
        }
        return lstFoodList;
    }
    #endregion

  
}

