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

public partial class CommonControls_NutritionMenuDeatails : BaseControl
{
    Diet_FoodMenuDetails objDiet_FoodMenuDetails = new Diet_FoodMenuDetails();
    List<Diet_FoodMenuDetails> Diet_FoodMenuDetails = new List<Diet_FoodMenuDetails>();
    Nutrition_BL Nutrition_BL;
    string update = Resources.ClientSideDisplayTexts.Common_Update;



    protected void Page_Load(object sender, EventArgs e)
    {

        try
        {
            Nutrition_BL = new Nutrition_BL(base.ContextInfo);
            lblmsg.Text = "";
            if (!IsPostBack)
            {
                LoadUomlist();
                LoadFoodDetails();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - FoodMenuDetailMaster.aspx", ex);           
        }
    }
    public void LoadFoodDetails()
    {
        try
        {
            Nutrition_BL.GetAllFoodDetails(OrgID, out Diet_FoodMenuDetails);
            if (Diet_FoodMenuDetails.Count > 0)
            {
                gvFoodMenuDetails.DataSource = Diet_FoodMenuDetails;
                gvFoodMenuDetails.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFoodDetails - FoodMenuDetailMaster.aspx", ex);    
        }

    }

    public void LoadUomlist()
    {
        try
        {
            List<UOM> Uom = new List<UOM>();
            Nutrition_BL.GetUomList(out Uom);
            if (Uom.Count > 0)
            {
                ddlUom.DataSource = Uom;
                ddlUom.DataTextField = "UOMCode";
                ddlUom.DataValueField = "UOMID";
                ddlUom.DataBind();
                ListItem item = new ListItem();
                item.Text = "---Select---";
                item.Value = "0";
                ddlUom.Items.Insert(0, item);
            }
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error in LoadUomlist - FoodMenuDetailMaster.aspx", ex);  
        }
    }

    public void clearFields()
    {
        hdnMenuDetailsNametoBeDel.Value = "0";
        hdnMenuNametoBeDel.Value = "";
        htnFSessiontoBeDel.Value = "";
        hdnFoodNameToBeDel.Value = "";
        txtFoodName.Text = "";
        txtMenuName.Text = "";
        txtFSeessionName.Text = "";
        txtQuantity.Text = "";
        ddlUom.SelectedIndex = 0;        
    }

    protected void gvFoodMenuDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblmsg.Text = "";
        if (e.NewPageIndex != -1)
        {
            gvFoodMenuDetails.PageIndex = e.NewPageIndex;
            LoadFoodDetails();
            hdnId.Value = "0";
            clearFields();
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            objDiet_FoodMenuDetails.FoodMenuDetailID = Int32.Parse(hdnMenuDetailsNametoBeDel.Value);
            objDiet_FoodMenuDetails.FoodMenuID = Int32.Parse(hdnMenuNametoBeDel.Value);
            objDiet_FoodMenuDetails.FoodID = Int32.Parse(hdnFoodNameToBeDel.Value);
            objDiet_FoodMenuDetails.FoodSessionID = Int32.Parse(htnFSessiontoBeDel.Value);
            objDiet_FoodMenuDetails.Quantity = Convert.ToDecimal(txtQuantity.Text);
            objDiet_FoodMenuDetails.UOM = ddlUom.SelectedValue.ToString();
            returnCode = Nutrition_BL.SaveFoodMenuDetails(OrgID, Convert.ToInt32(LID), objDiet_FoodMenuDetails);
            if (returnCode == 0)
            {
                LoadFoodDetails();
                lblmsg.ForeColor = System.Drawing.Color.Black;
                if (hdnStatus.Value == "Update")
                {
                    lblmsg.Text = Resources.ClientSideDisplayTexts.Commoncontrols_FoodMenuDetail_FoodMenuDetailsUptdsuc;
                }
                else
                {
                    lblmsg.Text = Resources.ClientSideDisplayTexts.Commoncontrols_FoodMenuDetail_FoodMenuDetailAddsuc;
                }
                clearFields();
                hdnMenuNametoBeDel.Value = "0";
                hdnStatus.Value = "";
            }
            else
            {
                lblmsg.ForeColor = System.Drawing.Color.Red;
                if (hdnStatus.Value == update)
                {
                    lblmsg.Text = Resources .ClientSideDisplayTexts .Commoncontrols_FoodMenuDetail_FoodMenuDetailsUptdFald ;
                    clearFields();
                    hdnMenuNametoBeDel.Value = "0";
                    hdnStatus.Value = "";
                }
                else
                {
                    lblmsg.Text = Resources.ClientSideDisplayTexts.Commoncontrols_FoodMenuDetail_FoodMenuDetailAlrdyExst;
                }
              
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving FoodMenuDetails - NutritionMenuDeatails.ascx", ex);
        }
    }


}
