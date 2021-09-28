using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml.Linq;
using Attune.Podium.Common;
using System.Text.RegularExpressions;

/// <summary>
/// Summary description for NutritionWebService
/// </summary>
[WebService(Namespace = "http://Attune.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class NutritionWebService : System.Web.Services.WebService
{

    public NutritionWebService()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }


    #region pGetMasterFoodSessionName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] pGetMasterFoodSessionName(string prefixText, int count)
    {
        long returnCode = -1;
        List<string> items = new List<string>();
        int pOrgID;
        Int32.TryParse(Session["OrgID"].ToString(), out pOrgID);
        Nutrition_BL Nutrition_BL = new Nutrition_BL();
        List<Diet_FoodSessionMaster> lstFoodSessionMaster = new List<Diet_FoodSessionMaster>();
       returnCode=Nutrition_BL.pGetMasterFoodSessionName(prefixText, pOrgID, out lstFoodSessionMaster);
        if (lstFoodSessionMaster.Count > 0)
        {
            foreach (Diet_FoodSessionMaster item in lstFoodSessionMaster.Take(10))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodSessionName, item.FoodSessionID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    //----------------------------------------------------------------------------------//

    #region pGetMasterFoodMenuName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] pGetMasterFoodMenuName(string prefixText, int count, string contextKey)
    {
        long returnCode = -1;
        List<string> items = new List<string>();
        int pOrgID =0;
        Int32.TryParse(Session["OrgID"].ToString(), out pOrgID);
        Nutrition_BL Nutrition_BL = new Nutrition_BL(new BaseClass().ContextInfo);
        List<Diet_FoodMenuMaster> lstFoodMenuMaster = new List<Diet_FoodMenuMaster>();
        returnCode = Nutrition_BL.pGetMasterFoodMenuName(prefixText, pOrgID, out lstFoodMenuMaster);
        if (lstFoodMenuMaster.Count > 0)
        {
            foreach (Diet_FoodMenuMaster item in lstFoodMenuMaster.Take(10))
            {
                item.FoodMenuID = Convert.ToInt32(item.FoodMenuID);
                item.FoodMenuName = item.FoodMenuName;
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodMenuName, item.FoodMenuID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    //-------------------------------------------------------NRRAJAN-------------------------------------------------
    #region GetFoodCategory
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetFoodCategory(string prefixText, int count)
    {
        Nutrition_BL inventoryBL = new Nutrition_BL(new BaseClass().ContextInfo);
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
        List<string> items = new List<string>();
        List<Diet_FoodCategory> lstpcategory = new List<Diet_FoodCategory>();
        new Nutrition_BL(new BaseClass().ContextInfo).GetFoodCategory(orgID, prefixText, out lstpcategory);
        if (lstpcategory.Count > 0)
        {

            var templist = from s in lstpcategory
                           where s.FoodCategoryName.StartsWith(prefixText.ToUpper())
                           orderby s.FoodCategoryName
                           select s;

            foreach (Diet_FoodCategory item in lstpcategory.Take(10))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodCategoryName, item.Description + "~" + item.FoodCategoryID));
            }
        }
        return items.ToArray();
    }
    #endregion
    //-------------------------------------------------------END-------------------------------------------------

    #region GetFoodMenuName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetFoodMenuNameService(string prefixText, int count)
    {
        Nutrition_BL Nutrition_BL = new Nutrition_BL(new BaseClass().ContextInfo);
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);     
        List<string> items = new List<string>();
        List<Diet_FoodMenuMaster> lstpcategory = new List<Diet_FoodMenuMaster>();
        new Nutrition_BL(new BaseClass().ContextInfo).GetAllFoodMenuMaster(prefixText, orgID, out lstpcategory);
        if (lstpcategory.Count > 0)
        {
            foreach (Diet_FoodMenuMaster item in lstpcategory.Take(10))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodMenuName, item.FoodMenuID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    #region GetFoodName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetFoodName(string prefixText, int count)
    {
        Nutrition_BL Nutrition_BL = new Nutrition_BL(new BaseClass().ContextInfo);
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);     
        List<string> items = new List<string>();
        List<Diet_FoodList> Diet_FoodList = new List<Diet_FoodList>();
        new Nutrition_BL(new BaseClass().ContextInfo).GetAllFoodList(prefixText, orgID, out Diet_FoodList);
        if (Diet_FoodList.Count > 0)
        {
            foreach (Diet_FoodList item in Diet_FoodList.Take(10))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodName,  item.FoodID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    #region GetFoodSessionName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] GetFoodsessionService(string prefixText, int count)
    {
        Nutrition_BL Nutrition_BL = new Nutrition_BL(new BaseClass().ContextInfo);
        int orgID = 0;
        Int32.TryParse(Session["OrgID"].ToString(), out orgID);
      
        List<string> items = new List<string>();
        List<Diet_FoodSessionMaster> Diet_FoodSessionMaster = new List<Diet_FoodSessionMaster>();
        new Nutrition_BL(new BaseClass().ContextInfo).GetAllFoodsessionMaster(prefixText,orgID, out Diet_FoodSessionMaster);
        if (Diet_FoodSessionMaster.Count > 0)
        {

            //var templist = from s in Diet_FoodSessionMaster
            //               where s.FoodSessionName.StartsWith(prefixText.ToUpper())
            //               orderby s.FoodSessionName
            //               select s;

            foreach (Diet_FoodSessionMaster item in Diet_FoodSessionMaster.Take(10))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodSessionName,  item.FoodSessionID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion

    #region pGetFoodIngredientName
    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public string[] pGetFoodIngredientName(string prefixText, int count)
    {
        long returnCode = -1;
        List<string> items = new List<string>();
        int pOrgID;
        Int32.TryParse(Session["OrgID"].ToString(), out pOrgID);
        Nutrition_BL Nutrition_BL = new Nutrition_BL();
        List<Diet_FoodIngredients> lstFoodIngredients = new List<Diet_FoodIngredients>();
        returnCode = Nutrition_BL.pGetFoodIngredientName(prefixText, pOrgID, out lstFoodIngredients);
        if (lstFoodIngredients.Count > 0)
        {          
            foreach (Diet_FoodIngredients item in lstFoodIngredients.Take(10))
            {
                items.Add(AjaxControlToolkit.AutoCompleteExtender.CreateAutoCompleteItem(item.FoodIngredientName,  item.FoodIngredientID.ToString()));
            }
        }
        return items.ToArray();
    }
    #endregion   

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


}

