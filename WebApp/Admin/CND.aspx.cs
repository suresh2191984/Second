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

public partial class CND : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            FoodDetails();
            LoadFoodDeliveredDetails();
            LoadFilter();
        }
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
                ddlSession.DataTextField = "FoodSessionName";
                ddlSession.DataValueField = "FoodSessionID";
                ddlSession.DataSource = lstFoodSessionMaster;
                ddlSession.DataBind();
                ddlSession.Items.Insert(0, new ListItem("-Select-", "0"));
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
                ddlWardName.Items.Insert(0, new ListItem("-Select-", "0"));
            }
        }
    }

    /// <summary>
    /// values for Filter dropdown
    /// </summary>
    protected void LoadFilter()
    {
        ddlFilter.Items.Insert(0, new ListItem("-Select-", "0"));
        ddlFilter.Items.Insert(1, new ListItem("WardName", "1"));
        ddlFilter.Items.Insert(2, new ListItem("Session", "2"));
    }

    /// <summary>
    /// Load Food Orders According Filters
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnLoadOrders_Click(object sender, EventArgs e)
    {
        LoadFoodDeliveredDetails();
    }

    /// <summary>
    /// Loading food order details
    /// </summary>
    List<FoodOrderedDetails> lstFoodOrderedDetails;
    protected void LoadFoodDeliveredDetails()
    {
        long returnCode = -1;
        lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        Nutrition_BL oNutrition_BL = new Nutrition_BL();

        int totalRows = 0;
        int pageSize = 10;
        int pageNo = 1;
        long SessionID = 0;
        if (!string.IsNullOrEmpty(ddlSession.SelectedValue))
        {
            SessionID = int.Parse(ddlSession.SelectedValue);
        }
        long WardID = 0;
        if (!string.IsNullOrEmpty(ddlWardName.SelectedValue))
        {
            WardID = int.Parse(ddlWardName.SelectedValue);
        }
        returnCode = oNutrition_BL.GetFoodDeliveredDetails(OrgID, "OrderedToCND", SessionID, WardID, pageSize, pageNo, out totalRows, out lstFoodOrderedDetails);
        if (lstFoodOrderedDetails != null)
        {
            if (lstFoodOrderedDetails.Count > 0)
            {
                lblMsg.Visible = false;
                hdnTotalCount.Value = totalRows.ToString();
                gvFoodDeliveredDetails.Style.Add("display", "block");
                gvFoodDeliveredDetails.DataSource = lstFoodOrderedDetails;
                gvFoodDeliveredDetails.DataBind();
            }
            else
            {
                hdnTotalCount.Value = string.Empty;
                gvFoodDeliveredDetails.Style.Add("display", "none");
                lblMsg.Visible = true;
            }
        }
        else
        {
            hdnTotalCount.Value = string.Empty;
            gvFoodDeliveredDetails.Style.Add("display", "none");
            lblMsg.Visible = true;
        }
    }


    /// <summary>
    /// Bind Values To gridView
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvFoodDeliveredDetails_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowIndex >= 0)
            {

                HtmlInputCheckBox chkFoodOrder = (HtmlInputCheckBox)e.Row.FindControl("chkFoodOrder");
                chkFoodOrder.Attributes.Add("RI", lstFoodOrderedDetails[e.Row.RowIndex].Rowid.ToString());
                chkFoodOrder.Attributes.Add("FI", lstFoodOrderedDetails[e.Row.RowIndex].FoodOrdersID.ToString());

                HtmlTableCell lblWardName = (HtmlTableCell)e.Row.FindControl("lblWardName");
                lblWardName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].WardName.ToString();
                
                HtmlTableCell lblFoodOrderedDate = (HtmlTableCell)e.Row.FindControl("lblFoodOrderedDate");
                lblFoodOrderedDate.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].FoodOrderDate.ToString();

                HtmlTableCell lblFoodName = (HtmlTableCell)e.Row.FindControl("lblFoodName");
                lblFoodName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].FoodName.ToString();

                HtmlTableCell lblStatus = (HtmlTableCell)e.Row.FindControl("lblStatus");
                lblStatus.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].OrderStatus.ToString();

                HtmlTableCell lblUOM = (HtmlTableCell)e.Row.FindControl("lblUOM");
                lblUOM.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].UOM.ToString();

                HtmlTableCell lblQuantity = (HtmlTableCell)e.Row.FindControl("lblQuantity");
                lblQuantity.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].TotalQuantity.ToString();
            }
        }
        catch (Exception ec)
        {

        }

    }

    /// <summary>
    /// save Food Delivered Details
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnFoodDeliver_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        var temp = hdnDeliveringDetails.Value;
        if (!string.IsNullOrEmpty(temp))
        {
            var v1 = temp.Split(',');
            List<Diet_FoodOrderMaster> lstDiet_FoodOrderMaster = new List<Diet_FoodOrderMaster>();
            for (int i = 0; i < v1.Length; i++)
            {
                Diet_FoodOrderMaster oDiet_FoodOrderMaster = new Diet_FoodOrderMaster();
                oDiet_FoodOrderMaster.FoodOrderID = int.Parse(v1[i]);
                oDiet_FoodOrderMaster.OrgID = OrgID;
                lstDiet_FoodOrderMaster.Add(oDiet_FoodOrderMaster);
            }
           
            Nutrition_BL oNutrition_BL = new Nutrition_BL();
            returnCode = oNutrition_BL.UpdateFoodDeliveredDetails(OrgID, LID, lstDiet_FoodOrderMaster, "OrderedToCND", "OrderReceivedFromCND");
            if (returnCode == 0)
            {
                Response.Redirect(Request.RawUrl, true);
            }
        }
    }



   
}
