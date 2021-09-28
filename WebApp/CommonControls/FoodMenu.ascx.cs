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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Text;
using Attune.Podium.Common;
using System.Web.Caching;

public partial class CommonControls_FoodMenu :BaseControl
{
    Nutrition_BL nutrition_BL;

    Diet_FoodMenuMaster objFoodMenu = new Diet_FoodMenuMaster();
    string update = Resources.ClientSideDisplayTexts.Common_Update;
    protected void Page_Load(object sender, EventArgs e)
    {
        nutrition_BL = new Nutrition_BL(base.ContextInfo);
        try
        {
            lblmsg.Text = "";
            if (!IsPostBack)
            {

                LoadMenu(string.Empty);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - ProductMenu.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = Resources.ClientSideDisplayTexts.ErrorStatus_Message;
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnStatus.Value == update)
            {

                SaveFoodMenu();

            }

            else
            {
                long MenuStatus;
                string FoodMenuName = txtFoodMenuName.Text;
                int pOrgID = 0;
                Int32.TryParse(Session["OrgID"].ToString(), out pOrgID);
                MenuStatus = nutrition_BL.pCheckFoodMasterName(FoodMenuName, pOrgID);
                if (MenuStatus == 0)
                {
                    lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_MenuAlrdyHve;
                }
                else
                {

                    SaveFoodMenu();

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Menu - FoodMenu.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = Resources.ClientSideDisplayTexts.ErrorStatus_Message;
        }

    }
    public void SaveFoodMenu()
    {

        long returnCode = -1;

        string FoodMenuName = string.Empty;
        string description = string.Empty;


        FoodMenuName = txtFoodMenuName.Text;
        description = txtDescription.Text;

        objFoodMenu.FoodMenuID = Convert.ToInt32(hdnId.Value);
        objFoodMenu.FoodMenuName = FoodMenuName;
        objFoodMenu.Description = description;
        objFoodMenu.OrgID = OrgID;
        objFoodMenu.CreatedBy = LID;
        objFoodMenu.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        returnCode = nutrition_BL.InsertUpdateFoodMenuMaster(objFoodMenu);

        if (returnCode == 0)
        {
            LoadMenu(string.Empty);

            lblmsg.ForeColor = System.Drawing.Color.Black;

            if (hdnStatus.Value == update)
            {
                lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_MenuUptSucc;
            }
            else
            {
                lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_sessionAddsucc;
            }
            clearFields();
            hdnMenuToBeDel.Value = "";
        }
        else
        {

            lblmsg.ForeColor = System.Drawing.Color.Red;

            if (hdnStatus.Value == update)
            {
                lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_sessionUptFalid;
            }
            else
            {
                lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_sessionAddFalid;
            }
            clearFields();
            hdnMenuToBeDel.Value = "";
        }
    }
    private void clearFields()
    {
        txtFoodMenuName.Text = "";
        txtDescription.Text = "";
        hdnId.Value = "0";
        hdnStatus.Value = "";
    }

    private void LoadMenu(string SearchFoodMenuName)
    {
        List<Diet_FoodMenuMaster> lstFoodMenuMaster = new List<Diet_FoodMenuMaster>();
        nutrition_BL.GetFoodMenuMaster(OrgID, SearchFoodMenuName, out lstFoodMenuMaster);
        if (lstFoodMenuMaster.Count > 0)
        {
            gvMenu.DataSource = lstFoodMenuMaster;
            gvMenu.DataBind();
            // gvMenu.Visible = true;
            tblMenuGrid.Visible = true;
        }
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

    //protected void btnDelete_Click(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        long returnCode = -1;
    //        string FoodMenuName = string.Empty;
    //        string description = string.Empty;
    //        FoodMenuName = txtFoodMenuName.Text;
    //        description = txtDescription.Text;
    //        objFoodMenu.FoodMenuName = FoodMenuName;
    //        objFoodMenu.Description = description;
    //        objFoodMenu.CreatedBy = LID;
    //        objFoodMenu.OrgID = OrgID;
    //        objFoodMenu.MenuID = Int32.Parse(hdnId.Value);


    //        returnCode = nutrition_BL.DeleteProductMenu(objFoodMenu);
    //        if (returnCode == 0)
    //        {
    //            LoadMenu(string.Empty);
    //            lblmsg.ForeColor = System.Drawing.Color.Black;
    //            lblmsg.Text = "Menu Deleted sucessfully";
    //            txtFoodMenuName.Text = "";
    //            txtDescription.Text = "";
    //            hdnId.Value = "0";
    //            hdnStatus.Value = "";

    //        }
    //        else
    //        {
    //            lblmsg.ForeColor = System.Drawing.Color.Red;
    //            lblmsg.Text = "Menu Deletion Failed";
    //        }
    //        hdnMenuToBeDel.Value = "";

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Deleteing Menu - FoodMenu.aspx", ex);
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
    //    }
    //}

    protected void gvMenu_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblmsg.Text = "";
        if (e.NewPageIndex != -1)
        {
            gvMenu.PageIndex = e.NewPageIndex;
            LoadMenu(string.Empty);
            txtFoodMenuName.Text = "";
            txtDescription.Text = "";
            hdnId.Value = "0";
        }
    }
    
}
