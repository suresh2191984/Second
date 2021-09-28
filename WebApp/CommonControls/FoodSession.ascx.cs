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

public partial class CommonControls_FoodSession : BaseControl
{
    Nutrition_BL nutrition_BL;

    Diet_FoodSessionMaster objFoodSession = new Diet_FoodSessionMaster();
    string update = Resources.ClientSideDisplayTexts.Common_Update;
    protected void Page_Load(object sender, EventArgs e)
    {
        nutrition_BL = new Nutrition_BL(base.ContextInfo);
        try
        {
            lblmsg.Text = "";
            if (!IsPostBack)
            {
                loadFromtime();
                loadTotime();

                LoadSession(string.Empty);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - ProductSession.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = Resources.ClientSideDisplayTexts.ErrorStatus_Message;
        }
    }
    public void loadTotime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (int i = 0; i < 48; i++)
        {
            ddlTo.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }
    public void loadFromtime()
    {
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;
        for (int i = 0; i < 48; i++)
        {
            ddlFrom.Items.Insert(i, dt.ToString("hh:mm.FF tt"));
            dt = dt.AddMinutes(30);
        }
    }

    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnStatus.Value == update)
            {

                SaveFoodSession();

            }

            else
            {
                long SessionStatus;
                string SessionName = txtSessionName.Text;
                int pOrgID = 0;
                Int32.TryParse(Session["OrgID"].ToString(), out pOrgID);
                SessionStatus = nutrition_BL.pCheckFoodSessionName(SessionName, pOrgID);
                if (SessionStatus == 0)
                {
                    lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_sessionAlrdyHve;
                }
                else
                {

                    SaveFoodSession();

                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Saving Session - FoodSession.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = Resources.ClientSideDisplayTexts.ErrorStatus_Message;
        }

    }
    public void SaveFoodSession()
    {

        long returnCode = -1;

        string SessionName = string.Empty;
        string description = string.Empty;

        //DateTime FromTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
        //objFoodSession.FromTime = TimeSpan.Parse(FromTime.ToShortTimeString());
        //DateTime ToTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());
        //objFoodSession.ToTime = TimeSpan.Parse(ToTime.ToShortTimeString());

        //DateTime FromTime = Convert.ToDateTime(ddlFrom.SelectedItem.ToString());
        //DateTime ToTime = Convert.ToDateTime(ddlTo.SelectedItem.ToString());

        TimeSpan FromTime1 = TimeSpan.Parse(ddlFrom.SelectedItem.Text.Split(' ')[0]);
        TimeSpan ToTime1 = TimeSpan.Parse(ddlTo.SelectedItem.Text.Split(' ')[0]);

        SessionName = txtSessionName.Text;
        description = txtDescription.Text;

        objFoodSession.FoodSessionID = Convert.ToInt32(hdnId.Value);
        objFoodSession.FromTime = FromTime1;
        objFoodSession.ToTime = ToTime1;
        objFoodSession.FoodSessionName = SessionName;
        objFoodSession.Description = description;
        objFoodSession.OrgID = OrgID;
        objFoodSession.CreatedBy = LID;
        objFoodSession.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        returnCode = nutrition_BL.InsertUpdateFoodSessionMaster(objFoodSession);

        if (returnCode == 0)
        {
            LoadSession(string.Empty);

            lblmsg.ForeColor = System.Drawing.Color.Black;

            if (hdnStatus.Value == update)
            {
                lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_sessionUptsucc;
            }
            else
            {
                lblmsg.Text = Resources.ClientSideDisplayTexts.CommonControl_FoodMenuMaster_sessionAddsucc;
            }
            clearFields();
            hdnSessionToBeDel.Value = "";
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
            hdnSessionToBeDel.Value = "";
        }
    }
    private void clearFields()
    {

        txtSessionName.Text = "";
        txtDescription.Text = "";
        hdnId.Value = "0";
        hdnStatus.Value = "";
    }

    private void LoadSession(string SearchSessionName)
    {
        List<Diet_FoodSessionMaster> lstFoodSessionMaster = new List<Diet_FoodSessionMaster>();
        nutrition_BL.GetFoodSessionMaster(OrgID, SearchSessionName, out lstFoodSessionMaster);
        if (lstFoodSessionMaster.Count > 0)
        {
            gvSession.DataSource = lstFoodSessionMaster;
            gvSession.DataBind();
            // gvSession.Visible = true;
            tblSessionGrid.Visible = true;
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
    //        string SessionName = string.Empty;
    //        string description = string.Empty;
    //        SessionName = txtSessionName.Text;
    //        description = txtDescription.Text;
    //        objFoodSession.SessionName = SessionName;
    //        objFoodSession.Description = description;
    //        objFoodSession.CreatedBy = LID;
    //        objFoodSession.OrgID = OrgID;
    //        objFoodSession.SessionID = Int32.Parse(hdnId.Value);


    //        returnCode = nutrition_BL.DeleteProductSession(objFoodSession);
    //        if (returnCode == 0)
    //        {
    //            LoadSession(string.Empty);
    //            lblmsg.ForeColor = System.Drawing.Color.Black;
    //            lblmsg.Text = "Session Deleted sucessfully";
    //            txtSessionName.Text = "";
    //            txtDescription.Text = "";
    //            hdnId.Value = "0";
    //            hdnStatus.Value = "";

    //        }
    //        else
    //        {
    //            lblmsg.ForeColor = System.Drawing.Color.Red;
    //            lblmsg.Text = "Session Deletion Failed";
    //        }
    //        hdnSessionToBeDel.Value = "";

    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while Deleteing Session - FoodSession.aspx", ex);
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
    //    }
    //}

    protected void gvSession_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        lblmsg.Text = "";
        if (e.NewPageIndex != -1)
        {
            gvSession.PageIndex = e.NewPageIndex;
            LoadSession(string.Empty);
            txtSessionName.Text = "";
            txtDescription.Text = "";
            hdnId.Value = "0";
        }
    }
}
