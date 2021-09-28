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

public partial class CommonControls_Nutrition :BaseControl
{
    Nutrition_BL oNutrition_BL = new Nutrition_BL();
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnCurrentDate.Value = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToShortDateString();
        hdnLoginID.Value = LID.ToString();
        if (!string.IsNullOrEmpty(Request.QueryString["VID"]))
        {
            hdnPatientVisitID.Value = Request.QueryString["VID"];
        }
        if (!string.IsNullOrEmpty(Request.QueryString["PID"]))
        {
            hdnPatientID.Value = Request.QueryString["PID"];
        }
        hdnRefType.Value = "patient";
        if (!IsPostBack)
        {
            MenuDetails();
            FoodDetails();
            LoadFoodOrdereDetails();
        }
    }

    /// <summary>
    /// menu dropdown values
    /// </summary>
    protected void MenuDetails()
    {
        List<Diet_FoodMenuMaster> lstFoodMenuMaster = new List<Diet_FoodMenuMaster>();      
        oNutrition_BL.GetMenuDetails(OrgID, out lstFoodMenuMaster);
        if (lstFoodMenuMaster != null)
        {
            if (lstFoodMenuMaster.Count > 0)
            {
                ddlMenu.DataTextField = "FoodMenuName";
                ddlMenu.DataValueField = "foodMenuID";
                ddlMenu.DataSource = lstFoodMenuMaster;
                ddlMenu.DataBind();
            }
        }
        ddlMenu.Items.Insert(0, new ListItem("-Select-", "0"));
    }

    /// <summary>
    /// session dropdown values
    /// </summary>
    protected void FoodDetails()
    {
        List<Diet_FoodSessionMaster> lstFoodSessionMaster = new List<Diet_FoodSessionMaster>();
        oNutrition_BL.GetFoodDetails(OrgID, out lstFoodSessionMaster);
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
        ddlFoodSession.Items.Insert(0, new ListItem("-Select-", "0"));
    }

    /// <summary>
    /// load food order details
    /// </summary>
    protected void LoadFoodOrdereDetails()
    {
        List<FoodOrderedDetails> lstFoodOrderedDetails = new List<FoodOrderedDetails>();
        oNutrition_BL.GetOrderedFoodDetails(OrgID, "PendingToOrder", int.Parse(hdnPatientVisitID.Value), out lstFoodOrderedDetails);
        if (lstFoodOrderedDetails != null)
        {
            if (lstFoodOrderedDetails.Count > 0)
            {
                gvFoodOrdered.DataSource = lstFoodOrderedDetails;
                gvFoodOrdered.DataBind();
                gvFoodOrdered.PageIndex = 1;
            }
        }
    }

    /// <summary>
    /// grid paging 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvFoodOrdered_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvFoodOrdered.PageIndex = e.NewPageIndex;
            LoadFoodOrdereDetails();
        }
    }

    /// <summary>
    /// delete food details 
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void gvFoodOrdered_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            Int32 rowIndex = Convert.ToInt32(e.CommandArgument);
            Int64 PatientDietPlanID = Convert.ToInt64(gvFoodOrdered.DataKeys[rowIndex]["PatientDietPlanID"]);

            if (e.CommandName == "DeleteOrder")
            {
                 oNutrition_BL.DeleteOrderedFoodDetails(OrgID, PatientDietPlanID);
            }

        }
        catch (Exception ec)
        {
            
        }
    }

    /// <summary>
    /// save food order details
    /// </summary>
    /// <param name="sender"></param>
    /// <param name="e"></param>
    protected void btnSaveFoodDetails_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string temp = hdnFoodDescription.Value;
        if (!string.IsNullOrEmpty(temp))
        {
            string[] v1 = temp.Split('|');
            List<Diet_PatientDietPlanMaster> oPatientDietPlanMasters = new List<Diet_PatientDietPlanMaster>();
            for (int i = 0; i < v1.Length; i++)
            {
                Diet_PatientDietPlanMaster oPatientDietPlanMaster = new Diet_PatientDietPlanMaster();
                string[] v2 = v1[i].Split('@');
                DateTime dtFrom = Convert.ToDateTime(v2[0]);
                DateTime dtTo = Convert.ToDateTime(v2[1]);
                oPatientDietPlanMaster.StartDate = dtFrom.Date;
                oPatientDietPlanMaster.Enddate = dtTo.Date;
                oPatientDietPlanMaster.FoodMenuID = int.Parse(v2[2]);
                oPatientDietPlanMaster.FoodSessionID = int.Parse(v2[3]);
                oPatientDietPlanMaster.FoodID = int.Parse(v2[4]);
                oPatientDietPlanMaster.PlanedBy = LID;
                oPatientDietPlanMaster.VisitID = int.Parse(hdnPatientVisitID.Value);
                oPatientDietPlanMaster.PatientID = int.Parse(hdnPatientID.Value);
                oPatientDietPlanMaster.RefType = hdnRefType.Value;
                oPatientDietPlanMaster.Status = "PendingToOrder";
                oPatientDietPlanMaster.OrgID = OrgID;
                oPatientDietPlanMasters.Add(oPatientDietPlanMaster);
            }
            returnCode = oNutrition_BL.SaveFoodList(oPatientDietPlanMasters);
            if (returnCode==0)
            {
                LoadFoodOrdereDetails();
            }
        }
    }
   
}
