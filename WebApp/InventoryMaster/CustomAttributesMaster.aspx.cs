﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Text;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;
using System.IO;
using System.Xml;
using System.Xml.Xsl;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.InventoryMaster.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.InventoryCommon.BL;

public partial class Inventory_CustomAttributesMaster : Attune_BasePage 
{
    public Inventory_CustomAttributesMaster():base("InventoryMaster_CustomAttributesMaster_aspx")
       
    {

    }
    InventoryMaster_BL InventoryBL;
    List<InventoryAttributesOrgMapping> lstInventoryAttributesOrgMapping = new List<InventoryAttributesOrgMapping>();
    List<InventoryAttributesOrgMapping> lstCustomInventoryAttributes = new List<InventoryAttributesOrgMapping>();
    JavaScriptSerializer _Json = new JavaScriptSerializer();
    InventoryAttributesOrgMapping objAttributes = new InventoryAttributesOrgMapping();
    protected void Page_Load(object sender, EventArgs e)
    {
    
        if (!IsPostBack)
        {
            BindDataType();
            LoadControl();
            LoadMappingDetail(0);
            chkAttributeStatus.Checked = true;

        }
        hdnUserLoginId.Value = LID.ToString();
    }


    public void SaveAttributes()
    {
        List<InventoryAttributesOrgMapping> lstCustomInventoryAttributes = new List<InventoryAttributesOrgMapping>();
        InventoryAttributesOrgMapping objAttributes = new InventoryAttributesOrgMapping();
        long returnCode = -1;
        string AttributeName = string.Empty;
        string Displaytext = string.Empty;
        AttributeName = txtAttributeName.Text;
        Displaytext = txtDisplayText.Text;
        objAttributes.AttributeName = AttributeName;
        objAttributes.AttributeID = Int32.Parse(hdnAttributeID.Value);
        objAttributes.CreatedBy = LID;
        //if (chkIsPredefinedAttributes.Checked)
        //{
        //    objAttributes.IsPreDefined = true;
        //}
        //else
        //{
            objAttributes.IsPreDefined = false ;
        //}

        if (chkAttributeStatus.Checked)
        {
            objAttributes.AttributeStatus = true;
        }
        else
        {
            objAttributes.AttributeStatus = false;
        }
        objAttributes.MappingID = 0;
        objAttributes.Status = true;
        objAttributes.DataType = ddlDataType.SelectedItem.Text;
        objAttributes.ControlTypeID = int.Parse(ddlControlType.SelectedValue);
        objAttributes.ControlName = ddlControlType.SelectedItem.Text;
     //objAttributes.ControlTypeID = int.Parse(hdnControlTypeID.Value == "" ? "0" : hdnControlTypeID.Value);
     //   objAttributes.ControlName = lblControlType.Text;
        objAttributes.ControlLength = txtLength.Text == "" ? 0 : Convert.ToInt16(txtLength.Text);
        objAttributes.DisplayText = Displaytext;
        objAttributes.IsTableReference = false;
        lstCustomInventoryAttributes.Add(objAttributes);
        returnCode = new InventoryCommon_BL(ContextInfo).SaveInventoryAttributes(OrgID, int.Parse(ddlControlType.SelectedValue), lstCustomInventoryAttributes);
        if (returnCode == 0)
        {
            LoadMappingDetail(0);
            clearFields();
        }
        else
        {
            clearFields();
        }

    }


    private void clearFields()
    {
        txtAttributeName.Text = "";
        txtDisplayText.Text = "";
        hdnAttributeID.Value = "0";
        hdnMappingID.Value = "0";
        txtAttributeName.Text = "";
        txtDisplayText.Text = "";
        hdnAttributeID.Value = "0";
        hdnMappingID.Value = "0";
        lblControlType.Text = "";
        ddlDataType.SelectedValue = "0";
        hdnStatus.Value = "";
        hdnControlTypeID.Value = "0";
        lblControlType.Text = ""; 
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
      
        List<InventoryAttributesOrgMapping> lstCustomInventoryAttributes = new List<InventoryAttributesOrgMapping>();
        InventoryMaster_BL InventoryBL = new InventoryMaster_BL(base.ContextInfo);
        //if (hdnAttributeList.Value != "")
        //{
        //    lstCustomInventoryAttributes = _Json.Deserialize<List<InventoryAttributesOrgMapping>>(hdnAttributeList.Value);
        //}
        try
        {

            //if (hdnStatus.Value == "Update")
            //{

            //    SaveAttributes();

            //}
            //else
            //{
            InventoryMaster_BL InventoryBL1 = new InventoryMaster_BL(base.ContextInfo);
                long returnCode = -1;
                string AttributeName = string.Empty;
                string Displaytext = string.Empty;
                AttributeName = txtAttributeName.Text;
                Displaytext = txtDisplayText.Text;
                objAttributes.AttributeName = AttributeName;
                objAttributes.AttributeID = Int32.Parse(hdnAttributeID.Value == "" ? "0" : hdnAttributeID.Value);
                objAttributes.CreatedBy = LID;
                //if (chkIsPredefinedAttributes.Checked)
                //{
                //    objAttributes.IsPreDefined = true;
                //}
                //else
                //{
                //    objAttributes.IsPreDefined = false;
                //}

                if (chkAttributeStatus.Checked)
                {
                    objAttributes.AttributeStatus = true;
                }
                else
                {
                    objAttributes.AttributeStatus = false;
                }
                objAttributes.MappingID = Int32.Parse(hdnMappingID.Value == "" ? "0" : hdnMappingID.Value);
                objAttributes.Status = true;
                string update = (Resources.InventoryMaster_ClientDisplay.InventoryMaster_CustomAttributesMaster_aspx_Update == null ? "Update" :
                    Resources.InventoryMaster_ClientDisplay.InventoryMaster_CustomAttributesMaster_aspx_Update);
                if (hdnStatus.Value == update)
                {
                    if (int.Parse(ddlControlType.SelectedValue) > 0)
                    {
                        objAttributes.ControlTypeID = int.Parse(ddlControlType.SelectedValue);
                    }
                    else
                    {
                        objAttributes.ControlTypeID = int.Parse(hdnControlTypeID.Value == "" ? "0" : hdnControlTypeID.Value);
                    }
                    objAttributes.ControlName = ddlControlType.SelectedItem.Text;
                }
                else
                {
                    objAttributes.ControlTypeID = int.Parse(hdnControlTypeID.Value == "" ? "0" : hdnControlTypeID.Value);
                    objAttributes.ControlName = lblControlType.Text;
                }
               // objAttributes.DataType = ddlDataType.SelectedItem.Text;
                objAttributes.DataType = hdnDataType.Value;
                objAttributes.ControlLength = txtLength.Text == "" ? 0 : Convert.ToInt16(txtLength.Text);
                objAttributes.DisplayText = Displaytext;
                objAttributes.IsTableReference = false;
                lstCustomInventoryAttributes.Add(objAttributes);
                //Int16 Controltypeid = int.Parse(hdnControlTypeID.Value == "" ? "0" : hdnControlTypeID.Value);

                returnCode = new InventoryCommon_BL(ContextInfo).SaveInventoryAttributes(OrgID,int.Parse(hdnControlTypeID.Value == "" ? "0" : hdnControlTypeID.Value), lstCustomInventoryAttributes);
                if (returnCode == 0)
                {

                    if (hdnStatus.Value == "Update")
                    {


                        string sPath = Resources.InventoryMaster_AppMsg.InventoryMaster_CustomAttributesMaster_aspx_AttributeUpdate;
                        string infoMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Information;
                        sPath = sPath == null ? "Attribute updated successfully" : sPath;
                        infoMsg = infoMsg == null ? "Information" : infoMsg;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:ValidationWindow('" + sPath + "','" + infoMsg + "');fnHideProgress();", true);
                    }
                    else
                    {
                        string sPath = Resources.InventoryMaster_AppMsg.InventoryMaster_CustomAttributesMaster_aspx_AttributeAdd;
                        string infoMsg = Resources.InventoryMaster_AppMsg.InventoryMaster_Information;
                        sPath = sPath == null ? "Attribute  saved  successfully" : sPath;
                        infoMsg = infoMsg == null ? "Information" : infoMsg;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "loadSrd", "javascript:ValidationWindow('" + sPath + "','" + infoMsg + "');fnHideProgress();", true);
                    }
                    LoadMappingDetail(0);
                    txtAttributeName.Text = "";
                    txtDisplayText.Text = "";
                    hdnAttributeID.Value = "0";
                    hdnMappingID.Value = "0";
                    lblControlType.Text = "";
                    ddlDataType.SelectedValue = "0";
                    hdnStatus.Value = "";
                    hdnControlTypeID.Value = "0";
                    lblControlType.Text = "";
                    ddlControlType.SelectedValue = "0";

                }
          //  }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while attributemaster ", ex);
            //ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
            //ErrorDisplay1.Status = Resources.ClientSideDisplayTexts.ErrorStatus_Message;
        }
    
    }

    private object InventoryCommon_BL(ContextDetails ContextInfo)
    {
        throw new NotImplementedException();
    }

    public void LoadMappingDetail(int ControlID)
    {
        long retrunCode = -1;
        string AttributeName = txtAttributeName.Text==""?"":txtAttributeName.Text.Trim();
        retrunCode = new InventoryCommon_BL(base.ContextInfo).GetAttributeMappingDetails(OrgID, 0, 0, AttributeName, "", out lstInventoryAttributesOrgMapping);

        //if (lstInventoryAttributesOrgMapping.Count > 0)
        //{
        //    hdnAttributeList.Value = _Json.Serialize(lstInventoryAttributesOrgMapping);
        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "LoadAttributes", "DynamicTable();", true);
        //}

        if (lstInventoryAttributesOrgMapping.Count > 0)
        {
            gvCategory.DataSource = lstInventoryAttributesOrgMapping;
            gvCategory.DataBind();
            gvCategory.Visible = true;
            tblCategoryGrid.Visible = true;

        }

    }

    protected void LoadControl()
    {
        long retrunCode =-1;
        InventoryMaster_BL InventoryBL = new InventoryMaster_BL(base.ContextInfo);
          List<ControlTypeMaster> lstControlTypeMaster = new List<ControlTypeMaster>();
          retrunCode = new InventoryCommon_BL(ContextInfo).GetControlType(OrgID, out lstControlTypeMaster);
        if (lstControlTypeMaster.Count > 0)
        {
            ddlControlType.DataSource = lstControlTypeMaster;
            ddlControlType.DataTextField = "ControlName";
            ddlControlType.DataValueField = "ControlTypeID";
            ddlControlType.DataBind();
            ddlControlType.Items.Insert(0, GetMetaData("Select", "0"));
        }

        StringBuilder sbContent = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        foreach (ControlTypeMaster row in lstControlTypeMaster)
        {
            if (row.IsEnable == "Y")
                sb.Append("<tr><td id='" + row.ControlTypeID + "' class='bluecolor underline pointer' onclick='SetControlType(this);' >" + row.ControlName + "</td></td>");
        }
        sbContent.Append("<table>");
        sbContent.Append(sb);
        sbContent.Append("</table>");
        divPanel.InnerHtml = sbContent.ToString();
    }

    protected void BindDataType()
    {
        long returncode = -1;
        string domains = "DataType";
        string[] Tempdata = domains.Split(',');
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        List<MetaData> lstmetadataOutput1 = new List<MetaData>();

        MetaData objMeta;
        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);

        }


        returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LanguageCode, out lstmetadataOutput);
        var lstDataType = from child in lstmetadataOutput
                           where child.Domain == "DataType"
                           orderby child.Code descending
                           select child;


        if (lstDataType.Count() > 0)
        {
            ddlDataType.DataSource = lstDataType;
            ddlDataType.DataTextField = "DisplayText";
            ddlDataType.DataValueField = "Code";
            ddlDataType.DataBind();
            ddlDataType.Items.Insert(0, GetMetaData("Select", "0"));
        }
    }

   
    protected void gvCategory_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
 
        if (e.NewPageIndex != -1)
        {
            gvCategory.PageIndex = e.NewPageIndex;
            LoadMappingDetail(0);
            txtAttributeName.Text = "";
            txtDisplayText.Text = "";
            hdnAttributeID.Value = "0";
            hdnMappingID.Value = "0";
        }
    }

    protected void gvCategory_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            //if (e.CommandName == "Search1")
            //{
            //    TextBox txt = (TextBox)gvCategory.HeaderRow.Cells[1].FindControl("txtCategoryNameWiseSearch");
            //   // LoadCategory(txt.Text.Trim());
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  ", ex);
        }
    }

    protected void gvCategory_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (lstInventoryAttributesOrgMapping[e.Row.RowIndex].IsPreDefined)
            {
                e.Row.ToolTip = Resources.InventoryMaster_ClientDisplay.InventoryMaster_CustomAttributesMaster_aspx_01==null? "Pre definded attributes":
                  Resources.InventoryMaster_ClientDisplay.InventoryMaster_CustomAttributesMaster_aspx_01;
                e.Row.BackColor = System.Drawing.ColorTranslator.FromHtml("#DBD5D5");
                e.Row.Cells[0].Enabled = false;
            }
            Label lblActive = (Label)e.Row.FindControl("lblActive");
            Image ImgActive = (Image)e.Row.FindControl("ImgActive");
            Image ImgDeActive = (Image)e.Row.FindControl("ImgDeActive");
            if (lblActive.Text == "True")
            {
                ImgActive.Visible = true;
                ImgDeActive.Visible = false;
            }
            else
            {
                ImgActive.Visible = false;
                ImgDeActive.Visible = true;
            }
        }
    }

}
