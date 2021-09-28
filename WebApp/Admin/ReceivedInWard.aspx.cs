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

public partial class ReceivedInWard : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        BindCompletedOrderDetails();
        hdnOrgID.Value = OrgID.ToString();
    }

    /// <summary>
    /// load received food list from cnd
    /// </summary>
    List<FoodOrderedDetails> lstFoodOrderedDetails;
    protected void BindCompletedOrderDetails()
    {
        long returnCode = -1;
        lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        Nutrition_BL oNutrition_BL = new Nutrition_BL();
        int totalRows = 0;
        int pageSize = 10;
        int pageNo = 1;
        returnCode = oNutrition_BL.GetCompletedFoodDetails(OrgID, "OrderReceivedFromCND", pageSize, pageNo, out totalRows, out lstFoodOrderedDetails);
        if (lstFoodOrderedDetails != null)
        {
            if (lstFoodOrderedDetails.Count > 0)
            {
                lblMsg.Visible = false;
                hdnTotalCount.Value = totalRows.ToString();
                gvCompletedFoodDetails.DataSource = lstFoodOrderedDetails;
                gvCompletedFoodDetails.DataBind();
            }
            else
            {
                hdnTotalCount.Value = string.Empty;
                lblMsg.Visible = true;
                lblMsg.Text = "<h3>No Completed food orders list !!!</h3>";
            }
        }
        else
        {
            hdnTotalCount.Value = string.Empty;
            lblMsg.Visible = true;
            lblMsg.Text = "<h3>No Completed food orders list !!!</h3>";
        }
    }


    /// <summary>
    /// Bind Values To gridView
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvCompletedFoodDetails_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowIndex >= 0)
            {

                HtmlInputCheckBox chkFoodOrder = (HtmlInputCheckBox)e.Row.FindControl("chkFoodOrder");
                chkFoodOrder.Attributes.Add("RI", lstFoodOrderedDetails[e.Row.RowIndex].Rowid.ToString());
                chkFoodOrder.Attributes.Add("FI", lstFoodOrderedDetails[e.Row.RowIndex].FoodOrderID.ToString());

                HtmlTableCell lblWardName = (HtmlTableCell)e.Row.FindControl("lblWardName");
                lblWardName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].WardName.ToString();

                HtmlTableCell lblPatientName = (HtmlTableCell)e.Row.FindControl("lblPatientName");
                lblPatientName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].Name.ToString();

                HtmlTableCell lblFoodName = (HtmlTableCell)e.Row.FindControl("lblFoodName");
                lblFoodName.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].FoodName.ToString();

                HtmlTableCell lblOrderedDate = (HtmlTableCell)e.Row.FindControl("lblOrderedDate");
                lblOrderedDate.InnerText = lstFoodOrderedDetails[e.Row.RowIndex].FoodOrderDate.ToString();
            }
        }
        catch (Exception ec)
        {

        }

    }

    /// <summary>
    /// issue food to patient 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnReceivedInWard_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        var temp = hdnReceivedDetails.Value;
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
            returnCode = oNutrition_BL.UpdateFoodDeliveredDetails(OrgID, LID, lstDiet_FoodOrderMaster, "OrderReceivedFromCND", "IssuedToPatient");
            if (returnCode == 0)
            {
                Response.Redirect(Request.RawUrl, true);
            }
        }

    }
}
