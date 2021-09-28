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
using System.IO;
using System.Xml;
using System.Linq;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;

public partial class TemplateMaker : BasePage
{
    public TemplateMaker() : base("Admin_TemplateMaker_aspx") { }
      System.IO.StreamWriter StreamWriter;
      static int i = 8;
      Investigation_BL InvestigationBL;
      string strAlert = Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_Alert==null ? "Alert" : Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_Alert;
      string strAlestOne = Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_03 == null ? "At least one check box must be selected" : Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_03;
      string strMore1Check = Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_02 == null ? "More than one checkbox selected" : Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_02;
    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        btnSubmit.Attributes.Add("onclick","return ValidateNullField();");
        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");

        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath;
        sPath = sPath + "/fckeditor/";
        fckInvDetails.BasePath = sPath;
        fckInvDetails.ToolbarSet = "Attune";
        fckInvDetails.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        fckInvDetails.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        FCKImpression.BasePath = sPath;
        FCKImpression.ToolbarSet = "Attune";
        FCKImpression.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        FCKImpression.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        FCKinvFinidings.BasePath = sPath;
        FCKinvFinidings.ToolbarSet = "Attune";
        FCKinvFinidings.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        FCKinvFinidings.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        //Page.ClientScript.RegisterOnSubmitStatement(fckInvDetails.GetType(), fckInvDetails.ClientID + "fckInvDetails", "FCKeditorAPI.GetInstance('" + fckInvDetails.ClientID + "').UpdateLinkedField();");
        //Page.ClientScript.RegisterOnSubmitStatement(FCKinvFinidings.GetType(), FCKinvFinidings.ClientID + "FCKinvFinidings", "FCKeditorAPI.GetInstance('" + FCKinvFinidings.ClientID + "').UpdateLinkedField();");
        //Page.ClientScript.RegisterOnSubmitStatement(FCKImpression.GetType(), FCKImpression.ClientID + "FCKImpression", "FCKeditorAPI.GetInstance('" + FCKImpression.ClientID + "').UpdateLinkedField();");
        //autosave();

        List<InvDeptMaster> d = new List<InvDeptMaster>();
        new Investigation_BL(base.ContextInfo).GetInvforDept(OrgID, out d);
        ddlDepartment.DataSource = d;
        ddlDepartment.DataTextField = "DeptName";
        ddlDepartment.DataValueField = "DeptID";
        ddlDepartment.DataBind();

        ddlDept.DataSource = d;
        ddlDept.DataTextField = "DeptName";
        ddlDept.DataValueField = "DeptID";
        ddlDept.DataBind();
        if (!IsPostBack)
        {
            //if (!File.Exists("F:\\InsScriptForTemplate.txt"))
            //{
            //    StreamWriter = File.CreateText("F:\\InsScriptForTemplate.txt");
            //}
        }
    }
    protected void btnsubmit_click(object sender, EventArgs e)
    {
        string strSave = Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_01 == null ? "Changes saved successfully." : Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_01;
       
        InvResultTemplate RT = new InvResultTemplate();
        System.Text.StringBuilder SBR = new System.Text.StringBuilder();
       
        long lresult = -1;
        try
        {

            //SBR.Append("INSERT INTO InvResultTemplate(ResultID,ResultName,ResultValues,ResultTemplateType,OrgID,DeptID)VALUES(");
            //SBR.Append(i);
            //SBR.Append(",'");
            //SBR.Append(txtTemplateHeader.Text);
            SBR.Append("<Value><InvestigationDetails>");
            SBR.Append(fckInvDetails.Value);
            SBR.Append("</InvestigationDetails>");
            SBR.Append("<InvestigationFindings>");
            SBR.Append(FCKinvFinidings.Value);
            SBR.Append("</InvestigationFindings><Impression>");
            SBR.Append(FCKImpression.Value);
            SBR.Append("</Impression></Value>");
            RT.ResultName = txtTemplateHeader.Text;
            RT.ResultValues = SBR.ToString();
            RT.ResultTemplateType = "Imaging";
            RT.OrgID = OrgID;
            RT.DeptID = Convert.ToInt32(ddlDepartment.SelectedValue);
            RT.ResultID = Convert.ToInt32(HdnResultID.Value);
            lresult = InvestigationBL.SaveInvResultTemplate(RT);

            if (lresult == -1)
            {
                //ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Error while executing SaveResultTemplate";
                //this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('" + ErrorDisplay1.Status + "'); </script>");
                return;
            }
            else {
                txtTemplateHeader.Text = "";
                fckInvDetails.Value = "";
                FCKinvFinidings.Value = "";
                FCKImpression.Value = "";
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Changes saved successfully.');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strSave + "','" + strAlert + "');", true);
                
                //Response.Redirect("TemplateMaker.aspx");
            }
           
            
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while executing SaveResultTemplate in Investigation_DAL", Ex);
        }
    }
    protected void BtnSearch_click(object sender, EventArgs e)
    {
        LoadGrid();
    }
    private void LoadGrid()
    {
        string strNomatch = Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_04 == null ? "No Matching Records." : Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_04;
        List<InvResultTemplate> d = new List<InvResultTemplate>();
        int DeptID =Convert.ToInt32(ddlDepartment.SelectedItem.Value);
        new Investigation_BL(base.ContextInfo).GetInvResultTemplateByResultName(OrgID, 0, txtResultname.Text, DeptID, out d);

        if (d.Count != 0)
        {
            grdResult.DataSource = d;
            grdResult.DataBind();
            btnEdit.Visible = true;
            grdResult.Visible = true;
            lblMsg.Visible = false;
            //btnDelete.Visible = true;
        }
        else
        {
            grdResult.DataSource = null;
            grdResult.Visible = false;
            btnEdit.Visible = false;
            lblMsg.Visible = true;
            //lblMsg.Text = "No Matching Records.";
            lblMsg.Text = strNomatch;
            //btnDelete.Visible = false;
        }
    }
    private void EditTemplate(int ResultID)
    {
        string strupdate = Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_05 == null ? "Update" : Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_05;
        try
        {

            fckInvDetails.Value = "";
            FCKinvFinidings.Value = "";
            FCKImpression.Value = "";

            string ResultName = string.Empty;
            Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
            List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
          
            new Investigation_BL(base.ContextInfo).GetInvResultTemplateByResultName(OrgID, ResultID, ResultName,0, out lResultTemplate);
            if (lResultTemplate.Count > 0)
            {
                XmlDocument xmlDocEdit = new XmlDocument();
                //btnSubmit.Text = "Update";
                btnSubmit.Text = strupdate;
                txtTemplateHeader.Text = lResultTemplate[0].ResultName;
                ddlDepartment.SelectedValue = lResultTemplate[0].DeptID.ToString();
                string str = lResultTemplate[0].ResultValues;
                //ViewState["TemplateID"] = ddlInvResultTemplate.SelectedValue;
                int invDetailsStartIndex = str.IndexOf("<InvestigationDetails>");
                if (invDetailsStartIndex != -1)
                {
                    string invDetails = "<InvestigationDetails>";
                    int invDetailsEndIndex = str.IndexOf("</InvestigationDetails>");
                    fckInvDetails.Value = str.Substring(invDetailsStartIndex + invDetails.Length, invDetailsEndIndex - invDetailsStartIndex - invDetails.Length);
                }
                //fckInvDetails.Value = "hai";

                int invFindingsStartIndex = str.IndexOf("<InvestigationFindings>");
                if (invFindingsStartIndex != -1)
                {
                    string invFindings = "<InvestigationFindings>";
                    int invFindingsEndIndex = str.IndexOf("</InvestigationFindings>");
                    FCKinvFinidings.Value = str.Substring(invFindingsStartIndex + invFindings.Length, invFindingsEndIndex - invFindingsStartIndex - invFindings.Length);
                }


                int invImpressionStartIndex = str.IndexOf("<Impression>");
                if (invImpressionStartIndex != -1)
                {
                    string invImpression = "<Impression>";
                    int invImpressionEndIndex = str.IndexOf("</Impression>");
                    FCKImpression.Value = str.Substring(invImpressionStartIndex + invImpression.Length, invImpressionEndIndex - invImpressionStartIndex - invImpression.Length);
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While load Template in Imaging pattern", ex);
        }
    }
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        
        int flag = 0;
        int val = 0;
        for (int i = 0; i < grdResult.Rows.Count; i++)
        {
            CheckBox chk = (CheckBox)grdResult.Rows[i].Cells[1].FindControl("chkSel");
            if (chk.Checked == true)
            {
                flag = flag + 1;
                val = i;
                break;
            }
        }
        if (flag == 0)
        {
                //string strEx = "<script>alert('At least one check box must be selected');</script>";
            string strEx = "<script>ValidationWindow('" + strAlestOne + "','" + strAlert + "');</script>";
            RegisterStartupScript("Key1", strEx);
        }
        else if (flag == 1)
        {   
            
            List<BedMaster> lstBed = new List<BedMaster>();
            HiddenField txtResultID = (HiddenField)grdResult.Rows[val].Cells[0].FindControl("lblResultId");
            HdnResultID.Value = txtResultID.Value;
            EditTemplate(Convert.ToInt32(txtResultID.Value));

            

        }
        else if (flag > 1)
        {
            string strEx = "<script>ValidationWindow('" + strMore1Check + "','" + strAlert + "');</script>";
            RegisterStartupScript("Key1", strEx);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("TemplateMaker.aspx");
    }
    protected void btnDelete_click(object sender, EventArgs e)
    {

        List<RoomBookingDetails> RoomBook = new List<RoomBookingDetails>();
        long lresult = -1;
        int flag = 0;
        string val = "";
        try
        {
            for (int i = 0; i < grdResult.Rows.Count; i++)
            {
                CheckBox chk = (CheckBox)grdResult.Rows[i].Cells[1].FindControl("chkSel");
                if (chk.Checked == true)
                {
                    flag = flag + 1;
                    val +=
                    Convert.ToString(i) + "^";
                }
            }
            if (flag == 0)
            {
                string strEx = "<script>ValidationWindow('" + strAlestOne + "','" + strAlert + "');</script>";
                RegisterStartupScript(
                "Key1", strEx);
            }
            else if (flag >= 1)
            {
                string ResultId = "";
                if (val != "")
                {
                    string[] ID = val.Split('^');
                    for (int i = 0; ID.Length > i; i++)
                    {
                        if (ID[i] != "")
                        {
                            HiddenField txtResultID = (HiddenField)grdResult.Rows[Convert.ToInt16(ID[i])].Cells[0].FindControl("lblResultId");

                            if (ResultId == "")
                                ResultId += txtResultID.Value;
                            else
                                ResultId +=
                                "," + txtResultID.Value;
                        }
                    }
                    DeleteTemlate(ResultId);
                    LoadGrid();
                }
            }
            else if (flag > 1)
            {
                string strEx = "<script>ValidationWindow('" + strMore1Check + "','" + strAlert + "');</script>";
                RegisterStartupScript(
                "Key1", strEx);
            }
        }
        catch (Exception Ex)
        {
            throw Ex;
        }
    }
      
     
    
    private long DeleteTemlate(string ResultID)
    {
        string strDelete = Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_04 == null ? "Deletion successful" : Resources.Admin_AppMsg.Admin_TemplateMaker_aspx_04;
        long lresult = -1;
        try
        {
            lresult = new Investigation_BL(base.ContextInfo).DelResultTemplate(ResultID);
            if (lresult == -1)
            {
                //ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "Error while executing DeleteTemplate";
                //this.Page.RegisterStartupScript("key1", "<script language='javascript' >alert('" + ErrorDisplay1.Status + "'); </script>");

            }
            else
            {
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('Deletion successful');", true);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:ValidationWindow('" + strDelete + "','" + strAlert + "');", true);
                LoadGrid();
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while executing DeleteTemplate in Investigation_DAL", Ex);
        }
        return lresult;
    }
    protected void Result_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string strTemp = Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_06 == null ? "Template Deleted Successfully..." : Resources.Admin_ClientDisplay.Admin_TemplateMaker_aspx_06;
        long lresult = -1;
        if (e.CommandName == "pDelete")
        {
            foreach (GridViewRow row in grdResult.Rows)
            {

                HiddenField hdnResultID = (HiddenField)row.FindControl("lblResultID");
                if (hdnResultID.Value == e.CommandArgument.ToString())
                {
                  lresult=  DeleteTemlate(hdnResultID.Value);
                }
            }
            if (lresult == 0)
            {   
                //grdResult.PageIndex = int.Parse(hdnPageIndx.Value);
                //lblMsg.Text = "Template Deleted Successfully...";
                lblMsg.Text = strTemp;
            }
            else
            {
               // lblMsg.Text = "Template Deleted Failed...";
            }

        }
    }
    protected void Result_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {


        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            hdnPageIndx.Value = grdResult.PageIndex.ToString();
            BtnSearch_click(sender, e);
        }
    }
   
}
