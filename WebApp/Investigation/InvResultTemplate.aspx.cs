using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using Attune.Podium.Common;

public partial class Investigation_InvResultTemplate :BasePage 
{
    public Investigation_InvResultTemplate()
        : base("Investigation_InvResultTemplate_aspx")
    {
    }

    Investigation_BL InvestigationBL;
    List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();

    #region "Common Resource Property"

    string strAlert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_ascx_03 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_ascx_03;

    #endregion

    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            //string sPath = Request.Url.AbsolutePath;
            //int iIndex = sPath.LastIndexOf("/");
            //sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
            //sPath = Request.ApplicationPath;
            //sPath = sPath + "/Ckeditor/";
            //fckInvDetails.BasePath = sPath;
            ////fckInvDetails.ToolbarSet = "Attune";
            ////fckInvDetails.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            ////fckInvDetails.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
            //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", fckInvDetails.ClientID), true);
            //Page.ClientScript.RegisterOnSubmitStatement(fckInvDetails.GetType(), fckInvDetails.ClientID + "editor", "var fckInvDetails = FCKeditorAPI.GetInstance('" + fckInvDetails.ClientID + "').UpdateLinkedField(); }");
            //loadTemplate();
            
            ddlInvResultTemp.Items.Insert(0, strSelect.Trim());

            LoadMetaData();
        }
    }

    #endregion

    #region "Events"

    protected void ddlInvResultTemplate_SelectedIndexChanged(object sender, EventArgs e)
    {
        loadTemplate();
        txtResultName.Text = string.Empty;
        fckInvDetails.Text = string.Empty;
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        string strEnter = Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_02 == null ? "Enter the Report." : Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_02;
        string strSave = Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_03 == null ? "saved successfully." : Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_03;
        string strUpdate = Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_04 == null ? "Update successfully." : Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_04;
        string strMandatory = Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_05 == null ? "Mandatory fields missing." : Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_05;
        InvResultTemplate RT = new InvResultTemplate();
        System.Text.StringBuilder SBR = new System.Text.StringBuilder();
        
        long lresult = -1;
        try
        {
            if (ddlInvResultTemplate.SelectedIndex > 0 && (!String.IsNullOrEmpty(txtResultName.Text) || ddlInvResultTemp.SelectedIndex > 0))
            {
                if (btnSave.Text == "Save")
                {
                    if (fckInvDetails.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow(" + strEnter.Trim() + "," + strAlert.Trim() + ");", true);
                    }
                    else
                    {
                        if (ddlInvResultTemplate.SelectedItem.Value == "TextReport")
                        {
                            SBR.Append("<Value><InvestigationDetails>");
                            SBR.Append(fckInvDetails.Text);
                            SBR.Append("</InvestigationDetails>");
                        }
                        else
                        {
                            SBR.Append(fckInvDetails.Text);
                        }
                        RT.ResultName = txtResultName.Text;
                        RT.ResultValues = SBR.ToString();
                        RT.ResultTemplateType = ddlInvResultTemplate.SelectedItem.Value.ToString();
                        RT.OrgID = OrgID;
                        RT.DeptID = 0;
                        RT.ResultID = 0;
                        lresult = InvestigationBL.SaveInvResultTemplate(RT);
                    }
                    if (lresult == -1)
                    {
                        //ErrorDisplay1.ShowError = true;
                        //ErrorDisplay1.Status = "Error while executing SaveResultTemplate";
                       // this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('" + ErrorDisplay1.Status + "'); </script>");
                        return;
                    }
                    else
                    {
                        txtResultName.Text = "";
                        fckInvDetails.Text = "";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow(" + strSave.Trim() + ","+strAlert.Trim()+");", true);
                    }
                }
                else
                {
                    if (fckInvDetails.Text == "")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow(" + strEnter.Trim() + ","+strAlert.Trim()+");", true);
                    }
                    else
                    {
                        if (ddlInvResultTemplate.SelectedItem.Value == "TextReport")
                        {
                            SBR.Append("<Value><InvestigationDetails>");
                            SBR.Append(fckInvDetails.Text);
                            SBR.Append("</InvestigationDetails>");
                        }
                        else
                        {
                            SBR.Append(fckInvDetails.Text);
                        }
                        RT.ResultName = ddlInvResultTemp.SelectedItem.Text.ToString();
                        RT.ResultValues = SBR.ToString();
                        RT.ResultTemplateType = ddlInvResultTemplate.SelectedItem.Value.ToString();
                        RT.OrgID = OrgID;
                        RT.DeptID = 0;
                        RT.ResultID = Convert.ToInt32(ddlInvResultTemp.SelectedValue);
                        lresult = InvestigationBL.SaveInvResultTemplate(RT);
                    }
                    if (lresult == -1)
                    {
                        //ErrorDisplay1.ShowError = true;
                        //ErrorDisplay1.Status = "Error while executing SaveResultTemplate";
                      // this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('" + ErrorDisplay1.Status + "'); </script>");
                        return;
                    }
                    else
                    {
                        txtResultName.Text = "";
                        fckInvDetails.Text = "";
                        btnSave.Text = "Save";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow("+strUpdate.Trim()+","+strAlert.Trim()+");", true);
                        loadTemplate();
                    }
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow("+strMandatory.Trim()+","+strAlert.Trim()+");", true);
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while executing SaveResultTemplate in Investigation_DAL", Ex);
        }
        
    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        string strMandatory = Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_05 == null ? "Mandatory fields missing." : Resources.Investigation_AppMsg.Investigation_InvResultTemplate_ascx_05;
        try
        {


            if (ddlInvResultTemplate.SelectedIndex > 0 && ddlInvResultTemp.SelectedIndex > 0)
            {
                int ResultID = -1;
                string ResultName = string.Empty;
                Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
                ResultID = Convert.ToInt32(ddlInvResultTemp.SelectedValue);
                txtResultName.Text = ddlInvResultTemp.SelectedItem.ToString();
                inv_BL.GetInvestigationResultTemplateByID(OrgID, ResultID, ResultName, ddlInvResultTemplate.SelectedItem.Value, out lResultTemplate);


                //ViewState["TemplateID"] = ddlInvResultTemplate.SelectedValue;
                fckInvDetails.Visible = true;
                fckInvDetails.Focus();
                if (lResultTemplate.Count > 0)
                {
                    //    if (fckInvDetails.Value == string.Empty)
                    //  {
                    //trddl1resulttemp
                    trddlresulttemp.Style.Add("display", "none");
                    trtxtresulttemp.Style.Add("display", "none");
                    fckInvDetails.Text = lResultTemplate[0].ResultValues;
                    btnSave.Text = "Update";
                    //}
                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow("+strMandatory.Trim()+","+strAlert.Trim()+");", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While load Template in Imaging pattern", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        string strSave = Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_ascx_04 == null ? "Save" : Resources.Investigation_ClientDisplay.Investigation_InvResultTemplate_ascx_04;
        btnSave.Text = strSave.Trim();
        fckInvDetails.Text = "";
        txtResultName.Text = "";
        ddlInvResultTemp.Items.Clear();
        ddlInvResultTemplate.SelectedIndex = 0;
        ddlInvResultTemp.Items.Insert(0, strSelect.Trim());
        ddlInvResultTemp.Items[0].Value = "0";
        trddlresulttemp.Style.Add("display", "table-row");
        trtxtresulttemp.Style.Add("display", "table-row");
    }

    #endregion

    #region "Methods"

    public void loadTemplate()
    {
        List<InvResultTemplate> lstInvResultTemplates = new List<InvResultTemplate>();
        InvestigationBL.GetInvestigationResultTemplate(OrgID, ddlInvResultTemplate.SelectedItem.Value, 0, out lstInvResultTemplates);

        if (lstInvResultTemplates.Count > 0)
        {
            ddlInvResultTemp.DataSource = lstInvResultTemplates;
            ddlInvResultTemp.DataTextField = "ResultName";
            ddlInvResultTemp.DataValueField = "ResultID";
            ddlInvResultTemp.DataBind();
            ddlInvResultTemp.Items.Insert(0, strSelect.Trim());
            ddlInvResultTemp.Items[0].Value = "0";
        }
        else
        {
            ddlInvResultTemp.Items.Clear();
            ddlInvResultTemp.Items.Insert(0, strSelect.Trim());
            ddlInvResultTemp.Items[0].Value = "0";
        }
        
    }


    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "InvResultTemplate";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "InvResultTemplate"
                                 orderby child.DisplayText descending
                                 select child;
                ddlInvResultTemplate.DataSource = childItems;
                ddlInvResultTemplate.DataTextField = "DisplayText";
                ddlInvResultTemplate.DataValueField = "DisplayText";
                ddlInvResultTemplate.DataBind();
                ddlInvResultTemplate.Items.Insert(0, new ListItem(strSelect, ""));

            }


        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }

    #endregion
}
