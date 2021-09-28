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

public partial class CommonControls_FoodIngredientsMapping : BaseControl
{
    Diet_FoodList objFoodList = new Diet_FoodList();
    Diet_FoodIngredients objFoodIngredients = new Diet_FoodIngredients();
    Diet_FoodIngredientsMapping objFoodIngredientsMapping = new Diet_FoodIngredientsMapping();
    Nutrition_BL Nutrition_BL;
    string update = Resources.ClientSideDisplayTexts.Common_Update;
    protected void Page_Load(object sender, EventArgs e)
    {
        Nutrition_BL = new Nutrition_BL(base.ContextInfo);
        try
        {
            lblmsg.Text = "";
            if (!IsPostBack)
            {
                LoadUomlist();
                LoadFoodIngredientsMappinglist();
            }
        }
        catch (Exception ex)
        {
            //CLogger.LogError("Error in Page Load - FoodMapping.aspx", ex);
            //ErrorDisplay.ShowError = true;
            //ErrorDisplay.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            string hdnTableValues = htntableValues1.Value;
            var SplitTableRows = htntableValues1.Value.Split('^');
            List<Diet_FoodIngredientsMapping> ListFoodIngredientsMapping = new List<Diet_FoodIngredientsMapping>();
            for (int i = 0; i < SplitTableRows.Length; i++)
            {
                if (SplitTableRows[i] != "")
                {
                    Diet_FoodIngredientsMapping objFoodIngredientsMapping = new Diet_FoodIngredientsMapping();
                    var SplitRowCells = SplitTableRows[i].Split('~');
                    objFoodIngredientsMapping.FoodIngredientMappingID = Convert.ToInt32(SplitRowCells[0]);
                    objFoodIngredientsMapping.FoodID = Convert.ToInt32(SplitRowCells[1]);
                    objFoodIngredientsMapping.FoodIngredientID = Convert.ToInt32(SplitRowCells[3]);
                    objFoodIngredientsMapping.Quantity = Convert.ToDecimal(SplitRowCells[5]);
                    objFoodIngredientsMapping.UOM = SplitRowCells[6];
                    objFoodIngredientsMapping.OrgID = OrgID;
                    objFoodIngredientsMapping.CreatedBy = LID;
                    objFoodIngredientsMapping.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    ListFoodIngredientsMapping.Add(objFoodIngredientsMapping);
                  
                }
            }
            if (hdnMenuToBeDel.Value != "")
            {

                int FoodId = Convert.ToInt32(hdnMenuToBeDel.Value);
                returnCode = Nutrition_BL.SaveFoodMapping(FoodId, OrgID, ListFoodIngredientsMapping);
                if (returnCode == 0)
                {
                    if (hdnStatus.Value == update)
                    {
                        lblmsg.Text = Resources.ClientSideDisplayTexts.Commoncontrols_FoodMenuDetail_FoodIngredntsMapppingUptdSucc;
                    }
                    else
                    {
                        lblmsg.Text = Resources.ClientSideDisplayTexts.Commoncontrols_FoodMenuDetail_FoodIngredntsMapppingaddsucc;
                    }
                    clearFields();
                    LoadFoodIngredientsMappinglist();
                    lblmsg.ForeColor = System.Drawing.Color.Black;
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving NutritionFoodIngredientsMapping - NutritionFoodIngredientsMapping.ascx", ex);
            
        }

    }

    private void clearFields()
    {
        txtFoodName.Text = "";
        hdnMenuToBeDel.Value = "";
        txtIng.Text = "";
        hdnIngDeleted.Value = "";
        txtQty.Text = "";
        hdnId.Value = "0";
        htntableValues1.Value = "";
        hdnStatus.Value = "";
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void gvFoodIngredientsMapping_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblmsg.Text = "";
        if (e.NewPageIndex != -1)
        {
            gvFoodIngredientsMapping.PageIndex = e.NewPageIndex;
            LoadFoodIngredientsMappinglist();
            hdnId.Value = "0";
            clearFields();
        }
    }

    public void LoadUomlist()
    {
        List<UOM> Uom = new List<UOM>();
        Nutrition_BL.GetUomList(out Uom);
        if (Uom.Count > 0)
        {
            ddlUOM.DataSource = Uom;
            ddlUOM.DataTextField = "UOMCode";
            ddlUOM.DataValueField = "UOMID";
            ddlUOM.DataBind();
            ListItem item = new ListItem();
            item.Text = "---Select---";
            item.Value = "0";
            ddlUOM.Items.Insert(0, item);
        }
    }

    public void LoadFoodIngredientsMappinglist()
    {
        List<Diet_FoodIngredientsMapping> Diet_FoodIngredientsMapping = new List<Diet_FoodIngredientsMapping>();
        Nutrition_BL.GetAllFoodIngredientsMappingList(OrgID, out Diet_FoodIngredientsMapping);
        if (Diet_FoodIngredientsMapping.Count > 0)
        {
            gvFoodIngredientsMapping.Visible = true;
            gvFoodIngredientsMapping.DataSource = Diet_FoodIngredientsMapping;
            gvFoodIngredientsMapping.DataBind();
        }
        else
        {
            gvFoodIngredientsMapping.Visible = false;
        }
    }


}
