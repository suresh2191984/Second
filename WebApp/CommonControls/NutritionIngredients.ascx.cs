using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using System.IO;
using AjaxControlToolkit;

public partial class CommonControls_NutritionIngredients : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        //try
        //{

        //    loadIngredient();
        //}
        //catch (Exception ex)
        //{
        //}
        loadIngredient();

    }
    //------------------------------------NRRAJAN-----------------------------------
    protected void Ingredient_Click(object sender, EventArgs e)
    {

        try
        {

            long returncode = -1;
            Nutrition_BL perNutri = new Nutrition_BL(base.ContextInfo);
            Diet_FoodIngredients DFI = new Diet_FoodIngredients();
            DFI.FoodIngredientID = Convert.ToInt64(hdningID.Value);
            DFI.FoodIngredientName = txtFoodIngredientName.Text;
            DFI.Description = txtDescription.Text;

            DFI.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DFI.CreatedBy = LID;
            DFI.OrgID = OrgID;
            DFI.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DFI.ModifiedBy = LID;

            if (hdningID.Value != "")
            {
                DFI.FoodIngredientID = Convert.ToInt32(hdningID.Value);
            }
            returncode = perNutri.PerfomingIngredient(DFI);
            cleareIngredient();
            loadIngredient();
            if (HdnIngredientSave.Value == "Update")
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Changes Saved Successfully!');", true);
            }
            else
            {

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            HdnIngredientSave.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Ingredient_Click", ex);
        }

    }

    protected void gvIng_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Diet_FoodIngredients FC = (Diet_FoodIngredients)e.Row.DataItem;
            string strScript = "extractRowIngredient('" + ((RadioButton)e.Row.FindControl("rdSel2")).ClientID + "','" + FC.FoodIngredientID + "','" + FC.FoodIngredientName + "','" + FC.Description + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel2")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel2")).Attributes.Add("onclick", strScript);
        }

    }
    protected void gvIng_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvIng.PageIndex = e.NewPageIndex;
        }
        loadIngredient();

    }
    public void loadIngredient()
    {
        try
        {
            long returnCode = -1;
            List<Diet_FoodIngredients> DFI = new List<Diet_FoodIngredients>();
            Nutrition_BL nutBL = new Nutrition_BL(base.ContextInfo);
            returnCode = nutBL.GetDietFoodIngredients(OrgID, out DFI);
            gvIng.DataSource = DFI;
            gvIng.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load Item Rate", ex);
        }
    }
    public void cleareIngredient()
    {
        txtFoodIngredientName.Text = string.Empty;
        txtDescription.Text = string.Empty;
        hdningID.Value = string.Empty;

    }
    //--------------------------------------END-------------------------------------
}
