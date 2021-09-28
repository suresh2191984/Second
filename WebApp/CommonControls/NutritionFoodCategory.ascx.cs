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

public partial class CommonControls_NutritionFoodCategory : BaseControl
{
    //--------------------------------NRRAJAN-------------------------------------
    #region NRRAJAN


    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {

            loadCategory();
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {

            long returncode = -1;
            Nutrition_BL perNutri = new Nutrition_BL(base.ContextInfo);
            Diet_FoodCategory DFC = new Diet_FoodCategory();

            DFC.FoodCategoryID = Convert.ToInt64(hdnCatoID.Value);
            DFC.FoodCategoryName = txtNutritionName.Text;
            DFC.Description = txtDescrp.Text;

            DFC.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DFC.CreatedBy = LID;
            DFC.OrgID = OrgID;
            DFC.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            DFC.ModifiedBy = LID;

            if (hdnCatoID.Value != "")
            {
                DFC.FoodCategoryID = Convert.ToInt32(hdnCatoID.Value);
            }
            returncode = perNutri.PerfomingNutrition(DFC);
            cleareFoodCato();
            loadCategory();
            if (hdnbtnSave.Value == "Update")
            {
                // ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('" + Save_Message + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Changes Saved Successfully!');", true);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('" + Save_Message + "');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Saved Successfully!');", true);
            }
            hdnbtnSave.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in btnsave_Click1", ex);
        }
    }
    //protected void btnCanecl_Click(object sender, EventArgs e)
    //{
    //    Response.Redirect("NutritionFoodCategory.ascx");
    //    txtNutritionName.Focus();

    //}
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Diet_FoodCategory FC = (Diet_FoodCategory)e.Row.DataItem;
            string strScript = "extractRow('" + ((RadioButton)e.Row.FindControl("rdSel")).ClientID + "','" + FC.FoodCategoryID + "','" + FC.FoodCategoryName + "','" + FC.Description + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
        }
        loadCategory();
    }
    //protected void grdResult_RowDeleting1(object sender, GridViewDeleteEventArgs e)
    //{
    //    long returnCode = -1;
    //    try
    //    {
    //        string txt = grdResult.DataKeys[e.RowIndex].Values[1].ToString();
    //        int FoodCatoId = Convert.ToInt32(grdResult.DataKeys[e.RowIndex].Values[0].ToString());
    //        Nutrition_BL nutBL = new Nutrition_BL(base.ContextInfo);
    //        returnCode = nutBL.deleteAction(FoodCatoId, OrgID);
    //        if (returnCode == 0)
    //        {
    //            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Validation", "javascript:alert('Row Deleted  Successfully!');", true);
    //            loadCategory();
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Delete PerformingPhysician.aspx", ex);
    //    }

    //}
    public void loadCategory()
    {
        try
        {
            long returnCode = -1;
            List<Diet_FoodCategory> DFC = new List<Diet_FoodCategory>();
            Nutrition_BL nutBL = new Nutrition_BL(base.ContextInfo);
            returnCode = nutBL.GetDietFoodCategory(OrgID, out DFC);
            grdResult.DataSource = DFC;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load Item Rate", ex);
        }
    }
    protected void cleareFoodCato()
    {
        txtNutritionName.Text = string.Empty;
        txtDescrp.Text = string.Empty;
        hdnCatoID.Value = string.Empty;

    }

    #endregion
    //--------------------------------END-------------------------------------
}
