using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Web.Script.Serialization;

using System.Drawing;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;

using Attune.Kernel.PlatForm.Base;
public partial class PlatFormControls_FeedbackControl : Attune_BaseControl
{
    public PlatFormControls_FeedbackControl()
        : base("PlatFormControls_FeedbackControl_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblmessage.Visible = false;
        long retCode = -1;
        if (!IsPostBack)
        {

            FeedBack_BL objFbBL = new FeedBack_BL(base.ContextInfo);
            List<SystemFeedBackType> lstFeedBackType = new List<SystemFeedBackType>();
            retCode = objFbBL.GetFeedbackType(out lstFeedBackType);
            LoadFeeType(lstFeedBackType);
        }
    }

    protected void btnFeedBackSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            long retCode = -1;
            List<SystemFeedBack> lstSysFB = new List<SystemFeedBack>();
            SystemFeedBack objFB = new SystemFeedBack();
            FeedBack_BL objFbBL = new FeedBack_BL(base.ContextInfo);
            objFB.TypeID = Convert.ToInt32(ddlFeedBackCat.SelectedValue);
            objFB.Priority = 1;
            objFB.Module = HttpContext.Current.Request.ApplicationPath;
             objFB.PageURL = HttpContext.Current.Request.Url.AbsoluteUri;
            //string path = objFB.PageURL;
            //string lastDirectory = path.Split(new char[] { System.IO.Path.DirectorySeparatorChar }, StringSplitOptions.RemoveEmptyEntries).Last();
           // objFB.PageURL = lastDirectory;
            objFB.Description = txtFBDetails.Text;
            objFB.Remarks = txtFBRemarks.Text;
            objFB.Status = "Posted";
            retCode = objFbBL.InsertFeedback(objFB.TypeID, objFB.Priority, objFB.Module, objFB.PageURL, objFB.Description, objFB.Remarks, objFB.Status);

            // ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "ScriptKey", "alert('FeedBack Posted Successfully '); ", true);

            // Page.RegisterStartupScript("alert", "<script>alert('FeedBack Posted Successfully')</script>");
            string sPath = Resources.PlatFormControls_ClientDisplay.PlatFormControls_FeedbackControl_ascx_01;
            if (sPath == null)
            {
                sPath = "FeedBack Posted Successfully";
            }
            string str = sPath;
            lblmessage.ForeColor = Color.Green;
            lblmessage.Visible = true;
            lblmessage.Text = str;
            clear();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in InsertFeedback", ex);
        }
    }
    public void clear()
    {
        txtFBDetails.Text = "";
        txtFBRemarks.Text = "";
        ddlFeedBackCat.SelectedIndex = -1;

    }

    private void LoadFeeType(List<SystemFeedBackType> lstFeedBackType)
    {
        try
        {
            if (lstFeedBackType.Count > 0)
            {

                ddlFeedBackCat.DataSource = lstFeedBackType;
                ddlFeedBackCat.DataTextField = "Type";
                ddlFeedBackCat.DataValueField = "TypeID";
                ddlFeedBackCat.DataBind();
                ddlFeedBackCat.Items.Insert(0, GetMetaData("Select", "0"));
            }
            else
            {
                ddlFeedBackCat.Items.Insert(0, GetMetaData("Select", "0"));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFeedbackType", ex);
        }
    }

}
