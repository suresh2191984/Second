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
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using ReportingService;


public partial class Admin_ReportTemplate : BasePage
{
    public Admin_ReportTemplate() : base("Admin_ReportTemplate_aspx") { }

    long returnCode = -1;
    Investigation_BL InvBL;
    List<InvReportMaster> lstInvReportMasterOut = new List<InvReportMaster>();

    #region Constants
        const string reportImage = "../Images/report.gif";
        const string folderImage = "../Images/folder.gif";
    #endregion

        private ReportingService2005 rs;
        string strDefault = Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_02 == null ? "Default Report Template already available." : Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_02;
        string strAlert = Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_Alert == null ? "Alert" : Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_Alert;
       
    protected void Page_Load(object sender, EventArgs e)
    {
        InvBL = new Investigation_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            aBrowseM.Attributes.Add("onClick", "ShowPopUp('" + txtReportTemplateM.ClientID + "');");
            GetInvReportTemplate();
        }
        rs = new ReportingService2005();
        rs.Credentials = System.Net.CredentialCache.DefaultCredentials;
        if (!IsPostBack)
        {
            //tvCatalog.BackColor = System.Drawing.Color.Gainsboro;
            //tvCatalog.ForeColor = System.Drawing.Color.Black;
            //BuildTreeView();
        }
    }
    private void GetInvReportTemplate()
    {
        try
        {
            List<InvReportMaster> lstInvReportMasterSelect = new List<InvReportMaster>();
            InvReportMaster objInvReportMaster = new InvReportMaster();
            objInvReportMaster.InvestigationID = 0;
            objInvReportMaster.ReportTemplateName = "";
            objInvReportMaster.IsDefault = "Y";
            objInvReportMaster.OrgID = OrgID;
            lstInvReportMasterSelect.Add(objInvReportMaster);
            string DupDefaultExists = string.Empty;
            returnCode = InvBL.GetReportTemplateMaster(lstInvReportMasterSelect, out lstInvReportMasterOut, "S", out DupDefaultExists);
            grdResult.DataSource = lstInvReportMasterOut;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error GetInvReportTemplate()", ex);
        }
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdResult.PageIndex = e.NewPageIndex;
            }
            GetInvReportTemplate();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in grdResult_PageIndexChanging()", ex);
        }
    }
    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkIsDef = (CheckBox)e.Row.FindControl("chkIsDefaultD");
                InvReportMaster invRptTm = (InvReportMaster)e.Row.DataItem;
                if (invRptTm.IsDefault == "Y")
                {
                    chkIsDef.Checked = true;
                }
                else
                {
                    chkIsDef.Checked = false;
                }

                CheckBox chkActive = (CheckBox)e.Row.FindControl("chkIsActive");
                if (invRptTm.IsActive == "A")
                {
                    chkActive.Checked = true;
                }
                else
                {
                    chkActive.Checked = false;
                }

                if (hdnChkControls.Value == "")
                {
                    hdnChkControls.Value = chkIsDef.ClientID.ToString();
                }
                else
                {
                    hdnChkControls.Value += "~" + chkIsDef.ClientID.ToString();
                }
                chkIsDef.Attributes.Add("onClick", "SingleCheckAlert('" + chkIsDef.ClientID.ToString() + "');");
                TextBox txtPath = (TextBox)e.Row.FindControl("txtTemplateNameD");
                System.Web.UI.HtmlControls.HtmlAnchor aTemp = (System.Web.UI.HtmlControls.HtmlAnchor)e.Row.FindControl("aBrowseD");
                aTemp.Attributes.Add("onClick", "ShowPopUp('" + txtPath.ClientID.ToString() + "');");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error grdResult_RowDataBound", ex);
        }
    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        string strSaved = Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_03 == null ? "Saved Successfully" : Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_03;

        try
        {
            InvReportMaster objAdd = new InvReportMaster();
            objAdd.InvestigationID = 0;
            objAdd.ReportTemplateName = txtReportTemplateM.Text.ToString();
            if (chkIsDefaultM.Checked)
            {
                objAdd.IsDefault = "Y";
            }
            else
            {
                objAdd.IsDefault = "N";
            }
            objAdd.OrgID = OrgID;
            List<InvReportMaster> lstInvReportMasterIn = new List<InvReportMaster>();
            lstInvReportMasterIn.Add(objAdd);
            returnCode = -1;
            string DupDefaultExists = string.Empty;
            returnCode = InvBL.SaveReportTemplateMaster(lstInvReportMasterIn, "A", out DupDefaultExists);
            if (DupDefaultExists.Trim() != "")
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Default Report Template already available.');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + strDefault + "','" + strAlert + "');", true);
            }
            else
            {
                //need to retain newly added values - to be coded
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + strSaved + "','" + strAlert + "');", true);
                GetInvReportTemplate();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error btnAddNew_Click", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strUpdate = Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_04 == null ? "Updated Successfully" : Resources.Admin_AppMsg.Admin_ReportTemplate_aspx_04;

        try
        {
            returnCode = -1;
            List<InvReportMaster> lstInvReportMasterIn = new List<InvReportMaster>();
            foreach (GridViewRow row in grdResult.Rows)
            {
                HiddenField hdnTId = new HiddenField();
                TextBox txtRTname = new TextBox();
                CheckBox chkIsDft = new CheckBox();
                CheckBox chkActive = new CheckBox();

                hdnTId = (HiddenField)row.FindControl("hdnTemplateID");
                txtRTname = (TextBox)row.FindControl("txtTemplateNameD");
                chkIsDft = (CheckBox)row.FindControl("chkIsDefaultD");
                chkActive = (CheckBox)row.FindControl("chkIsActive");

                InvReportMaster objInvRptMaster = new InvReportMaster();
                objInvRptMaster.TemplateID = Convert.ToInt32(hdnTId.Value);
                objInvRptMaster.ReportTemplateName = txtRTname.Text.ToString();
                if (chkIsDft.Checked)
                {
                    objInvRptMaster.IsDefault = "Y";
                }
                else
                {
                    objInvRptMaster.IsDefault = "N";
                }
                if (chkActive.Checked)
                {
                    objInvRptMaster.IsActive = "A";
                }
                else
                {
                    objInvRptMaster.IsActive = "D";
                }

                objInvRptMaster.OrgID = OrgID;
                lstInvReportMasterIn.Add(objInvRptMaster);
            }
            string DupDefaultExists = string.Empty;
            returnCode = InvBL.SaveReportTemplateMaster(lstInvReportMasterIn, "U",out DupDefaultExists);
            if (DupDefaultExists.Trim() != "")
            {
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Default Report Template already available.');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + strDefault + "','" + strAlert + "');", true);
            }
            else
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Updated Successfully');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:ValidationWindow('" + strUpdate + "','" + strAlert + "');", true);
                GetInvReportTemplate();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error btnSave_Click()", ex);
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            List<InvReportMaster> lstInvReportMasterSelect = new List<InvReportMaster>();
            InvReportMaster objInvReportMaster = new InvReportMaster();
            objInvReportMaster.InvestigationID = 0;
            objInvReportMaster.ReportTemplateName = txtReportTemplateM.Text.ToString();
            objInvReportMaster.IsDefault = "Y";
            objInvReportMaster.OrgID = OrgID;
            lstInvReportMasterSelect.Add(objInvReportMaster);
            string DupDefaultExists = string.Empty;
            returnCode = InvBL.GetReportTemplateMaster(lstInvReportMasterSelect, out lstInvReportMasterOut, "F", out DupDefaultExists);
            grdResult.DataSource = lstInvReportMasterOut;
            grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error btnSearch_Click", ex);
        }
    }
    private void BuildTreeView()
    {
        try
        {
            TreeNode RootNode = new TreeNode();
            RootNode.Text = ""; //"Report Server";
            RootNode.Expanded = true;
            //tvCatalog.Nodes.AddAt(0, RootNode);
            GetCatalogItems(string.Empty, RootNode);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error BuildTreeView", ex);
        }
    }
    private void GetCatalogItems(string catalogPath, TreeNode parentNode)
    {
        CatalogItem[] items;
        try
        {
            if (catalogPath.Length == 0)
            {
                items = rs.ListChildren("/", false);
            }
            else
            {
                items = rs.ListChildren(catalogPath, false);
            }
            foreach (CatalogItem item in items)
            {
                if (item.Hidden != true)
                {
                    if ((item.Type.Equals(ItemTypeEnum.Folder) || item.Type.Equals(ItemTypeEnum.Report)) &
                        (item.Type != ItemTypeEnum.DataSource
                        & item.Name != "Data Sources"))
                    {
                        TreeNode folderNode = new TreeNode(item.Name, null);
                        folderNode.ImageUrl = GetNodeImage(item.Type);
                        folderNode.Text = item.Name;
                        folderNode.Value = item.Path;
                        folderNode.ToolTip = item.Name;
                        parentNode.ChildNodes.Add(folderNode);
                        if (item.Type.Equals(ItemTypeEnum.Folder))
                        {
                            GetCatalogItems(item.Path, folderNode);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error GetCatalogItems", ex);
        }
        finally
        {
            rs.Dispose();
        }
    }
    private string GetNodeImage(ItemTypeEnum type)
    {
        string imagePath = string.Empty;

        switch (type)
        {
            case ItemTypeEnum.Folder:
                imagePath = folderImage;
                break;
            case ItemTypeEnum.Report:
                imagePath = reportImage;
                break;
            case ItemTypeEnum.LinkedReport:
                imagePath = reportImage;
                break;
        }

        return imagePath;
    }
    //protected void tvCatalog_SelectedNodeChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        TreeNode node = this.tvCatalog.SelectedNode;
    //        string pathStr = node.Text;
    //        string separator = "\\";

    //        tvCatalog.PathSeparator = Convert.ToChar(separator);

    //        while (node.Parent != null)
    //        {
    //            pathStr = node.Parent.Text + this.tvCatalog.PathSeparator + pathStr;
    //            node = node.Parent;
    //        }
    //        //txtFilePath.Text = pathStr.Replace("\\", "/");
    //        //txtReportTemplateM.Text = pathStr.Replace("\\", "/");
    //        hdnClikedValue.Value = pathStr.Replace("\\", "/");
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:SetSelectedPath();", true);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error tvCatalog_SelectedNodeChanged", ex);
    //    }
    //}
}
