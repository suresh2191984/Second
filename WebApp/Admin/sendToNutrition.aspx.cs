using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessEngine;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using Attune.Solution.DAL;
using System.Web.UI.HtmlControls;

public partial class sendToNutrition : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FoodDetails();
            LoadFoodOrders();
        }
        hdnFoodOrderedDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString();
        hdnOrderBY.Value = LID.ToString();
        hdnOrgID.Value = OrgID.ToString();
    }

    /// <summary>
    /// Binding session and ward dropdown values
    /// </summary>
    protected void FoodDetails()
    {
        List<Diet_FoodSessionMaster> lstFoodSessionMaster = new List<Diet_FoodSessionMaster>();
        List<WardMaster> lstWardMaster = new List<WardMaster>();
        Nutrition_BL oNutrition_BL = new Nutrition_BL();
        oNutrition_BL.GetSessionAndWard(OrgID, out lstFoodSessionMaster, out lstWardMaster);
        if (lstFoodSessionMaster != null)
        {
            if (lstFoodSessionMaster.Count > 0)
            {
                ddlFoodSession.DataTextField = "FoodSessionName";
                ddlFoodSession.DataValueField = "FoodSessionID";
                ddlFoodSession.DataSource = lstFoodSessionMaster;
                ddlFoodSession.DataBind();
            }
        }
        if (lstWardMaster != null)
        {
            if (lstWardMaster.Count > 0)
            {
                ddlWardName.DataTextField = "WardName";
                ddlWardName.DataValueField = "WardID";
                ddlWardName.DataSource = lstWardMaster;
                ddlWardName.DataBind();
            }
        }
    }
    
    /// <summary>
    /// Click to load food orders
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnLoadFoodOrders_Click(object sender, EventArgs e)
    {
        LoadFoodOrders();
    }

    /// <summary>
    /// Load Grid List
    /// </summary>
    List<FoodOrderedDetails> lstFoodOrderedDetails;
    protected void LoadFoodOrders()
    {
        Nutrition_BL oNutrition_BL = new Nutrition_BL();
        lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        int totalRows = 0;
        int pageSize = 10;
        int pageNo = 1;
        string FoodSessionID = "0";
        string WardID = "0";
        if (!string.IsNullOrEmpty(ddlFoodSession.SelectedValue))
        {
            FoodSessionID = ddlFoodSession.SelectedValue;
        }
        if (!string.IsNullOrEmpty(ddlWardName.SelectedValue))
        {
            WardID = ddlWardName.SelectedValue;
        }
        oNutrition_BL.GetFoodOrderedDetails(OrgID, int.Parse(FoodSessionID), int.Parse(WardID), "PendingToOrder", out totalRows, pageSize, pageNo, out lstFoodOrderedDetails);
        if (lstFoodOrderedDetails != null)
        {
            if (lstFoodOrderedDetails.Count > 0)
            {
                hdnTotalCount.Value = totalRows.ToString();
                lblMsg.Visible = false;
                gvFoodOrdered.Style.Add("display", "block");
                gvFoodOrdered.DataSource = lstFoodOrderedDetails;
                gvFoodOrdered.DataBind();
            }
            else
            {
                hdnTotalCount.Value = string.Empty;
                gvFoodOrdered.Style.Add("display", "none");
                lblMsg.Visible = true;
            }
        }
        else
        {
            hdnTotalCount.Value = string.Empty;
            gvFoodOrdered.Style.Add("display", "none");
            lblMsg.Visible = true;
        }
    }

    /// <summary>
    /// Binding Values To gridView
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvFoodOrdered_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowIndex >= 0)
            {

                HtmlInputCheckBox chkFoodOrder = (HtmlInputCheckBox)e.Row.FindControl("chkFoodOrder");
                chkFoodOrder.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].PatientDietPlanID.ToString());

                HtmlTableCell lblWardName = (HtmlTableCell)e.Row.FindControl("lblWardName");
                lblWardName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].WardName.ToString();
                lblWardName.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].WardID.ToString());

                HtmlTableCell lblFoodMenuName = (HtmlTableCell)e.Row.FindControl("lblFoodMenuName");
                lblFoodMenuName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].FoodMenuName.ToString();
                lblFoodMenuName.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].FoodMenuID.ToString());

                HtmlTableCell lblFoodName = (HtmlTableCell)e.Row.FindControl("lblFoodName");
                lblFoodName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].FoodName.ToString();
                lblFoodName.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].FoodID.ToString());

                HtmlTableCell lblStatus = (HtmlTableCell)e.Row.FindControl("lblStatus");
                lblStatus.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].Status.ToString();
                lblStatus.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].Status.ToString());

                HtmlTableCell lblUOM = (HtmlTableCell)e.Row.FindControl("lblUOM");
                lblUOM.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].UOM.ToString();
                lblUOM.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].UOM.ToString());

                HtmlTableCell lblQuantity = (HtmlTableCell)e.Row.FindControl("lblQuantity");
                lblQuantity.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].Quantity.ToString();
                lblQuantity.Attributes.Add("PDPI", lstFoodOrderedDetails[e.Row.RowIndex].Quantity.ToString());
            }
        }
        catch (Exception ec)
        {

        }

    }
    
    
    /// <summary>
    /// framing food ordered data
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSendTOCND_Click(object sender, EventArgs e)
    {
        string temp = hdnFoodDetails.Value;
         Nutrition_BL oNutrition_BL;
        List<FoodOrderedDetails> lstFoodOrderedDetails;

        if (!string.IsNullOrEmpty(temp))
        {
            if (temp == "full")
            {
                oNutrition_BL = new Nutrition_BL();
                lstFoodOrderedDetails = new List<FoodOrderedDetails>();
                oNutrition_BL.GetAllFoodOrderedDetails(OrgID, int.Parse(ddlFoodSession.SelectedValue), int.Parse(ddlWardName.SelectedValue), "PendingToOrder", LID, Convert.ToDateTime(new BasePage().OrgDateTimeZone), out lstFoodOrderedDetails);
                if (lstFoodOrderedDetails != null)
                {
                    if (lstFoodOrderedDetails.Count > 0)
                    {
                        SaveFoodOrderedDetails(lstFoodOrderedDetails);
                    }
                }
            }
            else
            {
                string[] v1 = temp.Split('|');
                lstFoodOrderedDetails = new List<FoodOrderedDetails>();
                for (int i = 0; i < v1.Length; i++)
                {
                    FoodOrderedDetails oFoodOrderedDetails = new FoodOrderedDetails();
                    string[] v2 = v1[i].Split('@');
                    oFoodOrderedDetails.PatientDietPlanID = int.Parse(v2[0]);
                    oFoodOrderedDetails.WardID = int.Parse(v2[1]);
                    oFoodOrderedDetails.FoodMenuID = int.Parse(v2[2]);
                    oFoodOrderedDetails.FoodID = int.Parse(v2[3]);
                    oFoodOrderedDetails.Status = "OrderedToCND";
                    oFoodOrderedDetails.UOM = v2[5];
                    oFoodOrderedDetails.Quantity = Convert.ToDecimal(v2[6]);
                    oFoodOrderedDetails.FoodOrderDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    oFoodOrderedDetails.OrderBy = LID;
                    lstFoodOrderedDetails.Add(oFoodOrderedDetails);
                }

                if (lstFoodOrderedDetails != null)
                {
                    if (lstFoodOrderedDetails.Count > 0)
                    {
                        SaveFoodOrderedDetails(lstFoodOrderedDetails);
                    }
                }
                
            }
        }

    }

    /// <summary>
    /// save food order
    /// </summary>
    /// <param name="lstFoodOrderedDetails"></param>
    protected void SaveFoodOrderedDetails(List<FoodOrderedDetails> lstFoodOrderedDetails)
    {
        long returnCode = -1;
        Nutrition_BL oNutrition_BL = new Nutrition_BL();
        returnCode = oNutrition_BL.SaveFoodOrderedList(OrgID, LID, lstFoodOrderedDetails);
        if (returnCode == 0)
        {
            LoadFoodOrders();
        }
    }
 
}
