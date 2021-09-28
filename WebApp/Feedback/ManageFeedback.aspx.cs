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
using System.Data.SqlClient;
using Attune.Kernel.BusinessEntities;
using System.Collections.Generic;
using System.Drawing;
using System.Net;
using System.Xml;
using System.Data;
using System.IO;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;

using Attune.Kernel.PlatForm.Base;
public partial class Feedback_ManageFeedback : Attune_BasePage
{
    public Feedback_ManageFeedback()
        : base("Feedback_ManageFeedback_aspx")
    {

    }
    protected void page_Init(object sender, EventArgs e)
    {
        try
        {
            base.page_Init(sender, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageFeedback.aspx:Page_Init", ex);
        }
    }

    long returnCode = -1;
    int mode = 0;
    FeedBack_BL objFbBL;
    List<SystemFeedBack> lstSystemFB = new List<SystemFeedBack>();
    SystemFeedBack objSysFB = new SystemFeedBack();
    string principleName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        objFbBL = new FeedBack_BL(base.ContextInfo);
        try
        {
            // tdexcel.Attributes.Add("Style", "display:none;");
            long retCode = -1;
            if (!IsPostBack)
            {
                List<SystemFeedBackType> lstFeedBackType = new List<SystemFeedBackType>();
                retCode = objFbBL.GetFeedbackType(out lstFeedBackType);
                LoadFeeType(lstFeedBackType);
                tblUpdate.Visible = false;
				BindFeeadbackStatus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageFeedback.aspx:Page_Load", ex);
        }
    }
    public void BindFeeadbackStatus()
    {
        List<MetaData> lstMetadata = GetMetaData("FeedBackStatus");
        ListItem ddlselect = GetMetaData("Select", "0");
        if (lstMetadata.Count > 0)
        {
            ddlStatus.DataSource = lstMetadata;
            ddlStatus.DataTextField = "DisplayText";
            ddlStatus.DataValueField = "Code";
            ddlStatus.DataBind();
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlChangeStatus.Items.Insert(0, ddlselect);
            ddlChangeStatus.DataSource = lstMetadata;
            ddlChangeStatus.DataTextField = "DisplayText";
            ddlChangeStatus.DataValueField = "Code";
            ddlChangeStatus.DataBind();
            
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlChangeStatus.Items.Insert(0, ddlselect);
        }
    }
    private void LoadFeeType(List<SystemFeedBackType> lstFeedBackType)
    {
        try
        {
            ListItem ddlselect = GetMetaData("Select", "0");
            if (lstFeedBackType.Count > 0)
            {

                ddlFeedBackCat.DataSource = lstFeedBackType;
                ddlFeedBackCat.DataTextField = "Type";
                ddlFeedBackCat.DataValueField = "TypeID";
                ddlFeedBackCat.DataBind();
                ddlFeedBackCat.Items.Insert(0, ddlselect);
            }
            else
            {
                ddlFeedBackCat.Items.Insert(0, ddlselect);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in LoadFeedbackType", ex);
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            objSysFB.ID = Convert.ToInt32(hdnPrincipleID.Value);
            objSysFB.Remarks = txtFBRemarks.Text.Trim();
            objSysFB.OrgID = OrgID;
            objSysFB.Status = ddlChangeStatus.SelectedValue;
            returnCode = objFbBL.UpdateSystemFeedBack(OrgID, objSysFB.ID, objSysFB.Remarks, objSysFB.Status);
            grdResult.Visible = false;
            //lblStatus.Visible = true;
            btnUpdate.Visible = false;
            tblUpdate.Visible = false;
            Panel7.Visible = true;
            btnCancel.Visible = false;
            ddlFeedBackCat.SelectedIndex = -1;
            ddlStatus.SelectedIndex = -1;
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Updating Feedback Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            tblUpdate.Visible = false;
            txtFBRemarks.Text = "";
            txtFBDesc.Text = "";
            ddlChangeStatus.SelectedIndex = -1;
            lblModule.Text = "";
            lblPgeURL.Text = "";
            lblPriority.Text = "";
            lblStatus.Text = "";
            btnUpdate.Visible = false;
            btnCancel.Visible = false;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
                objFbBL.GetSysFBList(objSysFB.TypeID, OrgID, ddlStatus.SelectedValue, out lstSystemFB);
                if (lstSystemFB.Count > 0)
                {
                    grdResult.Visible = true;
                    grdResult.DataSource = lstSystemFB;
                    grdResult.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageFeedback.aspx: GridView PageIndexChanging", ex);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        loadgrid();
    }
    public void loadgrid()
    {
        try
        {
            btnUpdate.Visible = false;
            btnCancel.Visible = false;
            tblUpdate.Visible = false;

            string status = ddlStatus.SelectedValue;
            objSysFB.TypeID = Convert.ToInt32(ddlFeedBackCat.SelectedValue);
            objFbBL.GetSysFBList(objSysFB.TypeID, OrgID, status, out lstSystemFB);
            if (lstSystemFB.Count > 0)
            {
                grdResult.Visible = true;
                grdResult.DataSource = lstSystemFB;
                grdResult.DataBind();
                lblStatus.Visible = false;
                //tdexcel.Attributes.Add("Style", "display:block;");
            }
            else
            {
                lblStatus.Visible = true;
                grdResult.Visible = false;
                lblStatus.Visible = true;
                lblStatus.Text = Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_09 == null ? "No Matching Records Found!" : Resources.Feedback_ClientDisplay.Feedback_ManageFeedback_aspx_09;
                //tdexcel.Attributes.Add("Style", "display:none;");
            }

            Panel7.Visible = true;
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Searching Feedback Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {

            Panel7.Visible = true;
            if (e.CommandName == "Select")
            {
                int RowIndex = Convert.ToInt32(e.CommandArgument);
                hdnPrincipleID.Value = Convert.ToString(grdResult.DataKeys[RowIndex][0]);
                ddlChangeStatus.SelectedValue = Convert.ToString(grdResult.DataKeys[RowIndex][1]);

                lblModule.Text = Convert.ToString(grdResult.DataKeys[RowIndex][2]);
                lblPgeURL.Text = Convert.ToString(grdResult.DataKeys[RowIndex][3]);
                txtFBDesc.Text = Convert.ToString(grdResult.DataKeys[RowIndex][4]);
                txtFBRemarks.Text = Convert.ToString(grdResult.DataKeys[RowIndex][5]);
                lblPriority.Text = Convert.ToString(grdResult.DataKeys[RowIndex][6]);
                GridViewRow row = (GridViewRow)grdResult.Rows[RowIndex];
                tblUpdate.Visible = true;
                btnUpdate.Visible = true;
                btnCancel.Visible = true;
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Feedback Details to Update - GridView RowCommand", ex);
        }
    }
    protected override void Render(HtmlTextWriter writer)
    {
        try
        {
            for (int i = 0; i < this.grdResult.Rows.Count; i++)
            {
                this.Page.ClientScript.RegisterForEventValidation(this.grdResult.UniqueID, "Select$" + i);
            }
            base.Render(writer);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Rendering.", ex);
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.grdResult, "Select$" + e.Row.RowIndex));
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Feedback Details to Update - GridView RowDatabound", ex);
        }
    }

    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        //ExportToExcel();
    }
    public void ExportToExcel()
    {
        try
        {
            grdResult.AllowPaging = false;
            loadgrid();
            string prefix = string.Empty;
            prefix = "TATReport_";
            string rptDate = prefix + DateTime.Now.ToShortDateString();
            string attachment = "attachment; filename=" + rptDate + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;

            //HttpContext.Current.Response.Write(getReportHeader(rdostock.SelectedItem.Text == "NilStock", gvIPReport.Columns.Count));
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            //oHtmlTextWriter(DateTime.Now.ToString("yyyy-mm-dd hh:mm:ss"));

            grdResult.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            grdResult.AllowPaging = true;
            grdResult.DataSource = lstSystemFB;
            grdResult.DataBind();
            Response.End();


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in ExCel, ExporttoExcel", ex);
        }
        finally
        {

        }
    }
}
