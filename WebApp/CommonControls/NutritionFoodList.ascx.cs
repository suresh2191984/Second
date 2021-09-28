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
using System.IO;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using AjaxControlToolkit;


public partial class CommonControls_NutritionFoodList : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        loadFoodList();
    }

    /// <summary>
    /// NRR
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSaveFoodList_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = -1;
            Nutrition_BL pNutri = new Nutrition_BL(base.ContextInfo);
            Diet_FoodList DFL = new Diet_FoodList();
            DFL.FoodID = Convert.ToInt64(hdnFoodListID.Value);
            DFL.FoodName = txtFoodName.Text;
            if (!string.IsNullOrEmpty(hdnFoodCategoryID.Value))
            {
                DFL.FoodCategoryID = Convert.ToInt64(hdnFoodCategoryID.Value);
            }
            DFL.Description = txtFoodlistDescription.Text;
            DFL.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DFL.CreatedBy = LID;
            DFL.OrgID = OrgID;
            DFL.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DFL.ModifiedBy = LID;
            if (!string.IsNullOrEmpty(hdnSaveFoodList.Value))
            {
                DFL.FoodID = Convert.ToInt32(hdnFoodListID.Value);
            }
            returncode = pNutri.SaveFoodList(DFL);
            cleareFoodList(); 
            if (returncode.Equals(0))
            {

                if (hdnSaveFoodList.Value == "Update")
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Updated Successfully!');", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);

                }
                loadFoodList();
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Food Already Exist!');", true);
                loadFoodList();
            }
            hdnSaveFoodList.Value = string.Empty;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnSaveFoodList_Click", ex);
        }

    }
    //protected void btnFListCancel_Click(object sender, EventArgs e)
    //{

    //    txtFoodName.Focus();
    //}
    protected void gvFoodList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Diet_FoodList FL = (Diet_FoodList)e.Row.DataItem;

            string strScript = "extractRowFoodList('" + ((RadioButton)e.Row.FindControl("rdSel3")).ClientID + "','" + FL.FoodID + "','" + FL.FoodCategoryName + "','" + FL.FoodName + "','" + FL.Description + "','" + FL.FoodCategoryID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel3")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel3")).Attributes.Add("onclick", strScript);
        }

    }
    protected void gvFoodList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvFoodList.PageIndex = e.NewPageIndex;
        }
        loadFoodList();

    }
    private void loadFoodList()
    {
        try
        {
            long returnCode = -1;
            List<Diet_FoodList> DFL = new List<Diet_FoodList>();
            Nutrition_BL nutBL = new Nutrition_BL(base.ContextInfo);
            returnCode = nutBL.GetDietFoodList(OrgID, out DFL);
            gvFoodList.DataSource = DFL;
            gvFoodList.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load loadFoodList", ex);
        }
    }
    protected void cleareFoodList()
    {
        txtFoodName.Text = string.Empty;
        txtFoodCatoName.Text = string.Empty;
        txtFoodlistDescription.Text = string.Empty;
        hdnFoodListID.Value = string.Empty;

    }
    //---------------------------------------END--------------------------------------

}
