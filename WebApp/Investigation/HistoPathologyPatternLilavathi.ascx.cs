using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Text;
using Attune.Podium.Common;
using System.Xml;
using System.Web.Script.Serialization;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

public partial class Investigation_HistoPathologyPatternLilavathi : BaseControl
{
    public Investigation_HistoPathologyPatternLilavathi()
        : base("Investigation_HistoPathologyPatternLilavathi_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int groupID = 0;
    private string groupName = string.Empty;
    int ResultID = -1;
    string ResultName = string.Empty;
    string Macroscopy = string.Empty;
    string Microscopy = string.Empty;
    string Impression = string.Empty;
    private long accessionNumber = 0;
	List<PatientInvestigationFiles> lstpatientImages;
    Investigation_BL invBL ;
    List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
    public int GroupID
    {
        get { return groupID; }
        set
        {
            groupID = value;
        }
    }
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
        }
    }


    public string GroupName
    {
        get { return groupName; }
        set
        {
            groupName = value;
        }
    }
    /// <summary>
    /// Get and Set the Investigation Name
    /// </summary>
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
        }
    }

    ///// <summary>
    ///// Set the UOM value
    ///// </summary>
    //public string UOM
    //{
    //    get { return uom; }
    //    set
    //    {
    //        uom = value;
    //        lblUOM.Text = uom;
    //    }
    //}

    /// <summary>
    /// Assign the ControlID to hidden field
    /// </summary>
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }
    private int packageID = 0;
    private string packageName = string.Empty;

    public int PackageID
    {
        get { return packageID; }
        set
        {
            packageID = value;
        }
    }


    public string PackageName
    {
        get { return packageName; }
        set
        {
            packageName = value;
        }
    }

    //Added by Perumal on 13 Jan 2012
    private string reason = string.Empty;
    public string Reason
    {
        get { return reason; }
        set
        {
            reason = value;
            txtReason.Text = reason;
        }
    }
    private string medicalremarks = string.Empty;
    public string MedicalRemarks
    {
        get { return medicalremarks; }
        set
        {
            medicalremarks = value;
            txtMedRemarks.Text = medicalremarks;
        }
    }
    //Added by Perumal on 13 Jan 2012


    ///// <summary>
    ///// To get the textbox value
    ///// </summary>
    //public string Value
    //{
    //    get { return result; }
    //    set { result = value; }
    //}

    #region "Common Resource Property"

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38;
    string strSel = Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_InvestigationApprovel_aspx_38;

    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            invBL = new Investigation_BL(base.ContextInfo);
        
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        hdnContext.Value = ControlID.ToString() + "~" + GroupID.ToString() + "~" + OrgID.ToString();
        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");

        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath ;
        sPath = sPath + "/ckeditor/";
        //txtImpression.BasePath = sPath;
        //txtImpression.ToolbarSet = "Interpretation";
        //txtImpression.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtImpression.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtImpression.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtImpression.GetType(), txtImpression.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtImpression.ClientID + "').UpdateLinkedField();");


        txtMicroscopy.BasePath = sPath;
        //txtMicroscopy.ToolbarSet = "Interpretation";
        //txtMicroscopy.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtMicroscopy.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtMicroscopy.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtMicroscopy.GetType(), txtMicroscopy.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtMicroscopy.ClientID + "').UpdateLinkedField();");


        txtGross.BasePath = sPath;
        //txtGross.ToolbarSet = "Interpretation";
        //txtGross.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtGross.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtGross.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtGross.GetType(), txtGross.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtGross.ClientID + "').UpdateLinkedField();");


        txtResult.BasePath = sPath;
        //txtResult.ToolbarSet = "Interpretation";
        //txtResult.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtResult.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtResult.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtResult.GetType(), txtResult.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtResult.ClientID + "').UpdateLinkedField();");

        //VEL | 08-07-2019 | Add new IF

        txtIF.BasePath = sPath;

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtIF.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtIF.GetType(), txtIF.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtIF.ClientID + "').UpdateLinkedField();");

        //VEL | 08-07-2019 | Add new IF

        txtDiagnosis.BasePath = sPath;
        //txtDiagnosis.ToolbarSet = "Interpretation";
        //txtDiagnosis.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtDiagnosis.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtDiagnosis.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtDiagnosis.GetType(), txtDiagnosis.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtDiagnosis.ClientID + "').UpdateLinkedField();");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        //ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'" + Formula + "');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        
            txtClinicalNotes.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            //txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            //txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

            txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            List<PatientInvSample> lstInvestigationSampleItem = new List<PatientInvSample>();
            if ((txtOrgan.Text == string.Empty || txtOrgan.Text == "") && RoleName == RoleHelper.LabTech)
            {
                long patientVisitID = -1;
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

                new Investigation_BL().GetSampleItem(Convert.ToInt32(POrgid), Convert.ToInt32(ControlID), patientVisitID, out lstInvestigationSampleItem);
            txtOrgan.Text = lstInvestigationSampleItem[0].SampleDesc;
            }
            if (!IsPostBack)
            {
                invBL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), Convert.ToInt64(ControlID), string.Empty, "HistoTempleteLilavathi", out lstInvResultTemplate);
                //invBL.GetInvestigationResultTemplate(Convert.ToInt32(POrgid), "Biopsy", 0, out lstInvResultTemplate);
                if (lstInvResultTemplate.Count > 0)
                {
                    ddlInvResultTemplate.DataSource = lstInvResultTemplate;
                    ddlInvResultTemplate.DataTextField = "ResultName";
                    ddlInvResultTemplate.DataValueField = "ResultName";
                    ddlInvResultTemplate.DataBind();
                }
                ddlInvResultTemplate.Items.Insert(0, strSelect.Trim());
                ddlInvResultTemplate.Items[0].Value = "0";
            }
            if (!string.IsNullOrEmpty(ControlID))
            {
                GenPtnImages(Convert.ToInt64(ControlID));
            }

            LoadMetaData();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Imaging pattern Page Load", ex);
        }
    }

    
    public void LoadMetaData()
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_HistoPathologyPattern_ascx_10 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_HistoPathologyPattern_ascx_10;
        ddlStatusReason.Items.Insert(0, strSelect);
        ddlOpinionUser.Items.Insert(0, strSelect);
        try
        {
            long returncode = -1;
            string domains = "ProcessingMethods,Staining";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "ProcessingMethods"
                                 select child;
                ddlProcessingMethods.DataSource = childItems;
                ddlProcessingMethods.DataTextField = "DisplayText";
                ddlProcessingMethods.DataValueField = "Code";
                ddlProcessingMethods.DataBind();
                ddlProcessingMethods.Items.Insert(0, new ListItem(strSelect, ""));
                var childItems2 = from child in lstmetadataOutput
                                  where child.Domain == "Staining"
                                  select child;

                ddlStaining.DataSource = childItems2;
                ddlStaining.DataTextField = "DisplayText";
                ddlStaining.DataValueField = "Code";
                ddlStaining.DataBind();
                ddlStaining.Items.Insert(0, new ListItem(strSelect, ""));

            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    public void LoadData(List<InvestigationValues> lstValues)
    {
        for (int i = 0; i < lstValues.Count; i++)
        {
            lblName.Text = lstValues[i].Value;
            txtReason.Text = lstValues[0].Reason;
            txtMedRemarks.Text = lstValues[0].MedicalRemarks;
        }

 if (lstValues.Count > 0)
        {
            for (int Index = 0; Index < lstValues.Count; Index++)
            {
                if (lstValues[Index].Name == "Biopsy Specimen" || lstValues[Index].Name == "Specimen")
                {
                    txtOrgan.Text = lstValues[Index].Value;
                }
                else if (lstValues[Index].Name == "Case No")
                {
                    txtSpecimenNo.Text = lstValues[Index].Value;
                }
                /*else if (lInvestigationValues[Index].Name == "Type of Specimen" || lInvestigationValues[Index].Name == "Technique")
                {
                    txtSpecimen.Text = lInvestigationValues[Index].Value;
                }*/
                else if (lstValues[Index].Name == "ClinicalNotes" || lstValues[Index].Name == "Clinical Notes")
                {
                    if (txtClinicalNotes.Text == string.Empty)
                    {
                        txtClinicalNotes.Text = lstValues[Index].Value;
                    }
                    else
                    {
                        txtClinicalNotes.Text = lblClinicalNotes.Text + "," + lstValues[Index].Value;
                    }
                }
                else if (lstValues[Index].Name == "ClinicalDiagnosis" || lstValues[Index].Name == "Clinical Diagnosis")
                {
                    if (txtDiagnosis.Text == string.Empty)
                    {
                        txtDiagnosis.Text = lstValues[Index].Value;
                    }
                    else
                    {
                        txtDiagnosis.Text = lblClinicalNotes.Text + "," + lstValues[Index].Value;
                    }
                }
            }
        }

        //ddltimeoffixation.DataSource = lstValues.FindAll(p => p.Name == "Time Of Fixation");
        //ddltimeoffixation.DataTextField = "Value";
        //ddltimeoffixation.DataValueField = "Value";
        //ddltimeoffixation.DataBind();
        //ddltimeoffixation.SelectedIndex = 0;
        //ddltimeoffixation.Items.Insert(0, new ListItem("Select", "0"));
        //ddltimeoffixation.SelectedValue = "0";

        //ddlGrossedBy.DataSource = lstValues.FindAll(p => p.Name == "Grossed By");
        //ddlGrossedBy.DataTextField = "Value";
        //ddlGrossedBy.DataValueField = "Value";
        //ddlGrossedBy.DataBind();
        //ddlGrossedBy.SelectedIndex = 0;
        //ddlGrossedBy.Items.Insert(0, new ListItem("Select", "0"));
        //ddlGrossedBy.SelectedValue = "0";

        //ddlAssistedBy.DataSource = lstValues.FindAll(p => p.Name == "Assisted By");
        //ddlAssistedBy.DataTextField = "Value";
        //ddlAssistedBy.DataValueField = "Value";
        //ddlAssistedBy.DataBind();
        //ddlAssistedBy.SelectedIndex = 0;
        //ddlAssistedBy.Items.Insert(0, new ListItem("Select", "0"));
        //ddlAssistedBy.SelectedValue = "0";

        //ddlTestperformedBy.DataSource = lstValues.FindAll(p => p.Name == "TestPerformedBy");
        //ddlTestperformedBy.DataTextField = "Value";
        //ddlTestperformedBy.DataValueField = "Value";
        //ddlTestperformedBy.DataBind();
        //ddlTestperformedBy.SelectedIndex = 0;
        //ddlTestperformedBy.Items.Insert(0, new ListItem("Select", "0"));
        //ddlTestperformedBy.SelectedValue = "0";
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlstatus.DataSource = lstStatus;
        //ddlstatus.DataTextField = "Status";
        //ddlstatus.DataValueField = "InvestigationStatusID";
        ddlstatus.DataTextField = "DisplayText";
        ddlstatus.DataValueField = "StatuswithID";
        ddlstatus.DataBind();
        string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
        if (ddlstatus.Items.FindByValue(SelString) != null)
        {
            ddlstatus.SelectedValue = SelString;
        }        
    }
    public void loadAliquotBarcode(List<PatientInvSampleAliquot> lstPatientInvSampleAliquot)
    {
        if (lstPatientInvSampleAliquot.Count > 0)
        {
            ddlBarcode.DataSource = lstPatientInvSampleAliquot;
            ddlBarcode.DataTextField = "BarcodeNumber";
            ddlBarcode.DataValueField = "ID";
            ddlBarcode.DataBind();
            ddlBarcode.Items.Insert(0, new ListItem(strSel.Trim(), "0"));
            tdbarcodetxt.Style.Add("display", "table-cell");
            tdbarcode.Style.Add("display", "table-cell");
        }
        else
        {
            tdbarcodetxt.Style.Add("display", "none");
            tdbarcode.Style.Add("display", "none");
        }
    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        if (!String.IsNullOrEmpty(hdnstatusreason.Value))
        {
            Pinv.InvStatusReasonID = Convert.ToInt32(hdnstatusreason.Value.Split('~')[0].ToString());
            Pinv.Reason = hdnstatusreason.Value.Split('~')[1].ToString();
        }
        long LoginID = 0;
        if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
        {
            Int64.TryParse(hdnOpinionUser.Value, out LoginID);
        }
        Pinv.LoginID = LoginID;
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
        Pinv.GroupID = groupID;
        Pinv.AccessionNumber = AccessionNumber;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        return Pinv;
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        if (ddlBarcode.Items.Count > 0)
        {
            if (ddlBarcode.SelectedItem.Text != strSel.Trim())
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblbarcode.Text;
                obj.Value = ddlBarcode.SelectedItem.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
            }
        }
        //if (txtOrgan.Text != string.Empty)
        //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblOrgan.Text;
            obj.Value = txtOrgan.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        //}

        if (txtSpecimenNo.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSpecimenNo.Text;
            obj.Value = txtSpecimenNo.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;

            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        if (txtSuggest.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSuggest.Text;
            obj.Value = txtSuggest.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;

            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txtICDCode.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblICDCode.Text;
            obj.Value = txtICDCode.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;

            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        //if (txtCategory.Text != string.Empty)
        if (ddlCategory.SelectedItem.Text != "Select")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblCategory.Text;
            obj.Value = ddlCategory.SelectedItem.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        if (txtSummary.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSummary.Text;
            obj.Value = txtSummary.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;

            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        if (txtcit.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblColdIschemicTime.Text;
            obj.Value = txtcit.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;

            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        if (ddltesttype.SelectedItem.Text != "Select")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = labTesttypeby.Text;
            obj.Value = ddltesttype.SelectedItem.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        //if (txtSpecialStain.Text != string.Empty)
        //{
        //    obj = new InvestigationValues();
        //    obj.InvestigationID = Convert.ToInt32(ControlID);
        //    obj.Name = lblSpecialStain.Text;
        //    obj.Value = txtSpecialStain.Text;
        //    obj.PatientVisitID = VID;
        //    obj.CreatedBy = LID;

        //    obj.GroupName = GroupName;
        //    obj.GroupID = groupID;
        //    obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
        //    //obj.Status = ddlstatus.SelectedItem.Text;
        //    status = ddlstatus.SelectedValue.Split('_');
        //    obj.Status = status[0].ToString();
        //    obj.PackageID = PackageID;
        //    obj.PackageName = PackageName;
        //    lstInvestigationVal.Add(obj);
        //}

        foreach (string splitString in hResultvalues.Value.Split('^'))
        {
            //obj = new InvestigationValues();
            //RID:2~SensitiveTo:~ModerateSensitive:dsa~resistant:as^
            if (splitString != "")
            {
                foreach (string strValues in splitString.Split('~'))
                {
                    string chkString = strValues.Split(':')[0];
                    string Strvalue = strValues.Split(':')[1];
                    switch (chkString)
                    {
                        case "ProcessMethods":
                            if (Strvalue != "")
                            {
                                obj = new InvestigationValues();
                                obj.Name = chkString;
                                obj.Value = Strvalue;
                                obj.InvestigationID = Convert.ToInt32(ControlID);
                                obj.PatientVisitID = VID;
                                obj.CreatedBy = LID;
                                obj.GroupName = GroupName;
                                obj.GroupID = groupID;
                                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                                //obj.Status = ddlstatus.SelectedItem.Text;
                                status = ddlstatus.SelectedValue.Split('_');
                                obj.Status = status[0].ToString();
                                obj.PackageID = PackageID;
                                obj.PackageName = PackageName;
                                lstInvestigationVal.Add(obj);
                            }
                            break;

                        case "Staining":
                            if (Strvalue != "")
                            {
                                obj = new InvestigationValues();
                                obj.Name = chkString;
                                obj.Value = Strvalue;

                                obj.InvestigationID = Convert.ToInt32(ControlID);
                                obj.PatientVisitID = VID;
                                obj.CreatedBy = LID;
                                obj.GroupName = GroupName;
                                obj.GroupID = groupID;
                                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                                //obj.Status = ddlstatus.SelectedItem.Text;
                                status = ddlstatus.SelectedValue.Split('_');
                                obj.Status = status[0].ToString();
                                obj.PackageID = PackageID;
                                obj.PackageName = PackageName;
                                lstInvestigationVal.Add(obj);
                            }

                            break;
                    };
                }
            }
        }
        string chkString1 = "ClinicalNotes";
        string FinalVal = string.Empty;
        int flag = 0;
        foreach (string splitString in hdnClinicalNotes.Value.Split(','))
        {
            //obj = new InvestigationValues();
            //RID:2~SensitiveTo:~ModerateSensitive:dsa~resistant:as^
           if (splitString != "")
            {
                if (FinalVal == string.Empty)
                {
                    FinalVal = splitString;
                }
                else
                {
                    FinalVal = FinalVal + "," + splitString;
                }
                flag = flag + 1;               
            }
            else
            {
                flag = -1;
            }
        } 
        if (flag > 0)
        {
            obj = new InvestigationValues();
            obj.Name = chkString1;
            obj.Value = FinalVal;

            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        else if (flag ==-1)
        {
            obj = new InvestigationValues();
            obj.Name = chkString1;
            obj.Value = FinalVal;

            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
        if (txttimeoffixation.Text != string.Empty)
        {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblTimeoffixation.Text;
                obj.Value =txttimeoffixation.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
        }
        
        //if (txtGrossedBy.Text != string.Empty)
        //{
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblGrossedby.Text;
                obj.Value = txtGrossedBy.Text.Trim();
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);

                 
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.Name = lblSpecialStain.Text;
                    obj.Value = txtSpecialStain.Text.Trim();
                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;

                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                    //obj.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    lstInvestigationVal.Add(obj);
                 
        //}
        //if (txtAssistedBy.Text != string.Empty)
        //{
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblAssistedby.Text;
                obj.Value = txtAssistedBy.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
            
        //}
        //if (txtTestperformedBy.Text != string.Empty)
        //{
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblTestperformedby.Text;
                obj.Value = txtTestperformedBy.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
        //}
        //if (txtGross.Value != string.Empty)
        //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblGross.Text;
           // obj.Value = txtGross.Value;
            obj.Value = txtGross.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        //}
        //if (txtMicroscopy.Value != string.Empty)
        //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMicroscopy.Text;
           // obj.Value = txtMicroscopy.Value;
            obj.Value = txtMicroscopy.Text.Trim();
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        //}

        //    if (txtImpression.Text != string.Empty)
        //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblComments.Text;
          //  obj.Value = txtImpression.Value;
            obj.Value = txtComments.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);

            //VEL | 16-07-2019 | Add new Column Remarks
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblRemarks.Text;
            obj.Value = txtRemarks.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
            //VEL | 16-07-2019 | Add new Column Remarks

        //}
        //if (txtResult.Value != string.Empty)
        //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblResult.Text;
           // obj.Value = txtResult.Value;
            obj.Value = txtResult.Text.Trim();
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        //}
            //VEL | 08-07-2019 | Add new IF
            //if (txtResult.Value != string.Empty)
            //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblIF.Text;
            // obj.Value = txtIF.Value;
            obj.Value = txtIF.Text.Trim();
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
            //}
            //VEL | 08-07-2019 | Add new IF
        //if (txtDiagnosis.Value != string.Empty)
        //{
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblDiagnosis.Text;
            //obj.Value = txtDiagnosis.Value;
            obj.Value = txtDiagnosis.Text.Trim();
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);

            //VEL | 16-06-2019 | Impression
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblImpression.Text;
            obj.Value = txtImpression.Text.Trim();
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
            //VEL | 26-06-2019 | Impression

            //VEL | 11-06-2019 | Technical Remarks
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = Rs_Comments.Text;
            obj.Value = txtReason.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMedRemarks.Text;
            obj.Value = txtMedRemarks.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
            //VEL | 11-06-2019 | Technical Remarks

        //}
        return lstInvestigationVal;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
    }
    protected void btnLoadResultTemplate_Click(object sender, EventArgs e)
    {
        SetResultTemplate("Load");
    }

    protected void btnAddResultTemplate_Click(object sender, EventArgs e)
    {
        SetResultTemplate("Add");
    }

    private void SetResultTemplate(string actionType)
    {
        if (ddlInvResultTemplate.SelectedIndex > 0)
        {
            //ResultID = Convert.ToInt32(ddlInvResultTemplate.SelectedValue);
            ResultName = ddlInvResultTemplate.SelectedItem.Text;
            List<InvResultTemplate> lresultTemplate = new List<InvResultTemplate>();
            invBL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), Convert.ToInt32(ControlID), ResultName, "HistoTempleteLilavathi", out lresultTemplate);
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.LoadXml(lresultTemplate[0].ResultValues);

            if (actionType == "Add")
            {
                if (txtGross.Text == "")
                {
                    txtGross.Text = xmldoc.GetElementsByTagName("Gross").Item(0).InnerText;
                }
                else
                {
                    txtGross.Text += ", " + xmldoc.GetElementsByTagName("Gross").Item(0).InnerText;
                }
                if (txtMicroscopy.Text == "")
                {
                    txtMicroscopy.Text = xmldoc.GetElementsByTagName("Microscopy").Item(0).InnerText;
                }
                else
                {
                    txtMicroscopy.Text += ", " + xmldoc.GetElementsByTagName("Microscopy").Item(0).InnerText;
                }
                if (txtImpression.Text == "")
                {
                    txtImpression.Text = xmldoc.GetElementsByTagName("Comments").Item(0).InnerText;
                }
                else
                {
                    txtImpression.Text += ", " + xmldoc.GetElementsByTagName("Comments").Item(0).InnerText;
                }
                if (txtResult.Text == "")
                {
                    txtResult.Text = xmldoc.GetElementsByTagName("IHC").Item(0).InnerText;
                }
                else
                {
                    txtResult.Text += ", " + xmldoc.GetElementsByTagName("IHC").Item(0).InnerText;
                }
                //VEL | 08-07-2019 | Add new IF
                if (txtIF.Text == "")
                {
                    txtIF.Text = xmldoc.GetElementsByTagName("IF").Item(0).InnerText;
                }
                else
                {
                    txtIF.Text += ", " + xmldoc.GetElementsByTagName("IF").Item(0).InnerText;
                }
                //VEL | 08-07-2019 | Add new IF
                if (txtDiagnosis.Text == "")
                {
                    txtDiagnosis.Text = xmldoc.GetElementsByTagName("Diagnosis").Item(0).InnerText;
                }
                else
                {
                    txtDiagnosis.Text += ", " + xmldoc.GetElementsByTagName("Diagnosis").Item(0).InnerText;
                }

                //VEL | 16-07-2019 | Add new Impression
                if (txtImpression.Text == "")
                {
                    txtImpression.Text = xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;
                }
                else
                {
                    txtImpression.Text += ", " + xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;
                }
                //VEL | 16-07-2019 | Add new Impression
            }
            else
            {
                txtGross.Text = xmldoc.GetElementsByTagName("Gross").Item(0).InnerText;
                txtMicroscopy.Text = xmldoc.GetElementsByTagName("Microscopy").Item(0).InnerText;
                txtImpression.Text = xmldoc.GetElementsByTagName("Comments").Item(0).InnerText;
                txtResult.Text = xmldoc.GetElementsByTagName("IHC").Item(0).InnerText;
                //VEL | 08-07-2019 | Add new IF
                txtIF.Text = xmldoc.GetElementsByTagName("IF").Item(0).InnerText;
                //VEL | 08-07-2019 | Add new IF
                txtDiagnosis.Text = xmldoc.GetElementsByTagName("Diagnosis").Item(0).InnerText;
                //VEL | 17-07-2019 | Add new Impression
                txtImpression.Text = xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;
                //VEL | 17-07-2019 | Add new Impression
            }
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods" + Convert.ToString(this.ClientID), "javascript:LoadExistingItems('" + hResultvalues.Value + "','" + this.ClientID + "');", true);
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods" + Convert.ToString(this.ClientID), "javascript:LoadExistingItems('" + hResultvalues.Value + "','" + this.ClientID + "','" + hdnClinicalNotes.Value + "');", true);
        }
        else
        {
            string strValidate = Resources.Investigation_AppMsg.Investigation_HistoPathologyPattern_ascx_05 == null ? "Select Result Template" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPattern_ascx_05;
            string strAlert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "SelectTemplate", "ValidationWindow(" + strValidate + "," + strAlert + ");", true);
        }
    }

    public List<PatientInvestigationFiles> GetInvestigationFiles(long PatientVisitID,out bool Flag)
    {
        
        Flag = true;
        HttpPostedFile httpPSFiles;
        PatientInvestigationFiles pFiles;
        List<PatientInvestigationFiles> lstPfiles = new List<PatientInvestigationFiles>();

        if (flUpload.HasFile)
            
        {
            if ((flUpload.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload.PostedFile.ContentType == "jpg")
                || (flUpload.PostedFile.ContentType == "image/pjpeg") || (flUpload.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //flUpload.SaveAs(@"C:\temp\" + flUpload.FileName);
                //CLogger.LogError("Upload path:" + System.IO.Path.GetFullPath(flUpload.PostedFile.FileName),new Exception());
                //CLogger.LogError("Upload path:" + System.IO.Path.GetFullPath(flUpload.FileName), new Exception());
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload.FileBytes;
                pFiles.FilePath = flUpload.FileName;
                pFiles.CreatedBy = LID;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID); 
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        if (flUpload2.HasFile)
        {
            if ((flUpload2.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload2.PostedFile.ContentType == "jpg")
                || (flUpload2.PostedFile.ContentType == "image/pjpeg") || (flUpload2.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //httpPSFiles = flUpload2.PostedFile;
                //btImage = new byte[flUpload2.PostedFile.ContentLength];
                //httpPSFiles.InputStream.Read(btImage, 0, flUpload2.PostedFile.ContentLength);
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload2.FileBytes;
                pFiles.CreatedBy = LID;
                pFiles.FilePath = flUpload2.FileName;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID);
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        if (flUpload3.HasFile)
        {
            if ((flUpload3.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload3.PostedFile.ContentType == "jpg")
                || (flUpload3.PostedFile.ContentType == "image/pjpeg") || (flUpload3.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //httpPSFiles = flUpload.PostedFile;
                //btImage = new byte[flUpload3.PostedFile.ContentLength];
                //httpPSFiles.InputStream.Read(btImage, 0, flUpload3.PostedFile.ContentLength);
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload3.FileBytes;
                pFiles.FilePath = flUpload3.FileName;
                pFiles.CreatedBy = LID;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID);
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        if (flUpload4.HasFile)
        {

            if ((flUpload4.PostedFile.ContentType.ToLower() == "jpeg") || (flUpload4.PostedFile.ContentType == "jpg")
                || (flUpload4.PostedFile.ContentType == "image/pjpeg") || (flUpload4.PostedFile.ContentType == "image/jpeg"))
            {
                pFiles = new PatientInvestigationFiles();
                //httpPSFiles = flUpload4.PostedFile;
                //btImage = new byte[flUpload4.PostedFile.ContentLength];
                //httpPSFiles.InputStream.Read(btImage, 0, flUpload4.PostedFile.ContentLength);
                pFiles.PatientVisitID = PatientVisitID;
                pFiles.ImageSource = flUpload4.FileBytes;
                pFiles.FilePath = flUpload4.FileName;
                pFiles.CreatedBy = LID;
                pFiles.OrgID = Convert.ToInt32(POrgid);// OrgID;
                pFiles.InvestigationID = Convert.ToInt32(ControlID); 
                lstPfiles.Add(pFiles);
            }
            else
            {
                Flag = false;
            }
        }
        return lstPfiles;
    }

    public void SetInvestigationValue(List<InvestigationValues> lInvestigationValues)
    {
        string ProcessMethods = string.Empty;
        string ClinicalNotes = string.Empty;
        //RID:1~ProcessMethods:Processing Methods af~Staining:Staining ^
        //RID:2~ProcessMethods:23~Staining:fasf^
        //lblName.Text = lInvestigationValues[0].Name;
        if (lInvestigationValues.Count > 0)
        {
            for (int Index = 0; Index < lInvestigationValues.Count; Index++)
            {
                if (lInvestigationValues[Index].Name == "Biopsy Specimen" || lInvestigationValues[Index].Name == "Specimen")
                {
                    txtOrgan.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Case No")
                {
                    txtSpecimenNo.Text = lInvestigationValues[Index].Value;
                }
                /*else if (lInvestigationValues[Index].Name == "Type of Specimen" || lInvestigationValues[Index].Name == "Technique")
                {
                    txtSpecimen.Text = lInvestigationValues[Index].Value;
                }*/
                else if (lInvestigationValues[Index].Name == "ClinicalNotes" || lInvestigationValues[Index].Name == "Clinical Notes")
                {
                    if (ClinicalNotes == string.Empty)
                    {
                        ClinicalNotes = lInvestigationValues[Index].Value;
                    }
                    else
                    {
                        ClinicalNotes = ClinicalNotes + "," + lInvestigationValues[Index].Value;
                    }
                }
                /*else if (lInvestigationValues[Index].Name == "Clinical Diagnosis" || lInvestigationValues[Index].Name == "Site")
                {
                    txtClinicalDiagnosis.Text = lInvestigationValues[Index].Value;
                }*/
                else if (lInvestigationValues[Index].Name == "Suggest")
                {
                    txtSuggest.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "ICD Code")
                {
                    txtICDCode.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Category")
                {
                    ddlCategory.SelectedItem.Text = lInvestigationValues[Index].Value;
                    ddlCategory.SelectedItem.Value = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Summary of Sections")
                {
                    txtSummary.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Special Stains")
                {
                    txtSpecialStain.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "ProcessMethods")
                {
                    if (lInvestigationValues[Index].Value != string.Empty)
                    {
                        ProcessMethods += "RID:" + "tblResult" + Index + "~ProcessMethods:" + lInvestigationValues[Index].Value;
                    }
                }
                else if (lInvestigationValues[Index].Name == "Staining")
                {
                    if (lInvestigationValues[Index].Value != string.Empty)
                    {
                        ProcessMethods += "~Staining:" + lInvestigationValues[Index].Value + "^";
                    }
                }
                else if (lInvestigationValues[Index].Name == "Gross")
                {
                    txtGross.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Microscopy")
                {
                    txtMicroscopy.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Comments")
                {
                    txtComments.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Remarks")
                {
                    txtRemarks.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "IHC")
                {
                    txtResult.Text = lInvestigationValues[Index].Value;
                }
                //VEL | 08-07-2019 | Add new IF
                else if (lInvestigationValues[Index].Name == "IF")
                {
                    txtIF.Text = lInvestigationValues[Index].Value;
                }
                //VEL | 08-07-2019 | Add new IF
                else if (lInvestigationValues[Index].Name == "Slide No")
                {
                    string barcodevalue = string.Empty;
                    barcodevalue= ddlBarcode.Items.FindByText(lInvestigationValues[Index].Value).Value;
                    ddlBarcode.SelectedValue = barcodevalue;
                }
                else if (lInvestigationValues[Index].Name == "Time of Fixation")
                {
                    txttimeoffixation.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Grossed By")
                {
                    txtGrossedBy.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Assisted By")
                {
                    txtAssistedBy.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Supervised by")
                {
                    txtTestperformedBy.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Diagnosis")
                {
                    txtDiagnosis.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Impression")
                {
                    txtImpression.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Cold Ischemic Time")
                {
                    txtcit.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Test Typed By")
                {
                    ddltesttype.SelectedItem.Text = lInvestigationValues[Index].Value;
                    ddltesttype.SelectedItem.Value = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Technical Remarks")
                {
                    txtReason.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == "Medical Remarks")
                {
                    txtMedRemarks.Text = lInvestigationValues[Index].Value;
                }
            }
            txtReason.Text = lInvestigationValues[0].Reason;
        }
        if (ProcessMethods != string.Empty || ClinicalNotes != string.Empty)
        {
            hResultvalues.Value = ProcessMethods;
            hdnClinicalNotes.Value = ClinicalNotes;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods" + Convert.ToString(this.ClientID), "javascript:LoadExistingItems('" + hResultvalues.Value + "','" + this.ClientID + "');", true);
            //ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods" +Convert.ToString(this.ClientID), "javascript:LoadExistingItems('" + hResultvalues.Value + "','" + this.ClientID + "','" + hdnClinicalNotes.Value + "');", true);
            hdnControlID.Value  = this.ClientID;
        }
    }
    private void LoadImage()
    {

    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //txtReason.Enabled = value;
            //pnlEnableHis.Enabled = value;
            //lnkEdit.Visible = true;

            //Modified by Perumal on 23 Jan 2012
            //txtReason.BackColor = System.Drawing.Color.RosyBrown;
            //txtReason.ForeColor = System.Drawing.Color.Black;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            //txtOrgan.BackColor = System.Drawing.Color.RosyBrown;
            //txtOrgan.ForeColor = System.Drawing.Color.Black;
            txtOrgan.ReadOnly = value == false ? true : false;
            //txtClinicalDiagnosis.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalDiagnosis.ForeColor = System.Drawing.Color.Black;
            //txtClinicalDiagnosis.ReadOnly = value == false ? true : false;
            //txtClinicalNotes.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalNotes.ForeColor = System.Drawing.Color.Black;
            txtClinicalNotes.ReadOnly = value == false ? true : false;            
            ////txtGross.BackColor = System.Drawing.Color.RosyBrown;
            //txtGross.ForeColor = System.Drawing.Color.Black;
            //txtGross.ReadOnly = value == false ? true : false;
            //txtImpression.BackColor = System.Drawing.Color.RosyBrown;
            //txtImpression.ForeColor = System.Drawing.Color.Black;
            //txtImpression.ReadOnly = value == false ? true : false;
            //txtMicroscopy.BackColor = System.Drawing.Color.RosyBrown;
            //txtMicroscopy.ForeColor = System.Drawing.Color.Black;
            //txtMicroscopy.ReadOnly = value == false ? true : false;
            //txtSpecimen.BackColor = System.Drawing.Color.RosyBrown;
            //txtSpecimen.ForeColor = System.Drawing.Color.Black;
            //txtSpecimen.ReadOnly = value == false ? true : false;
            //txtSpecimenNo.BackColor = System.Drawing.Color.RosyBrown;
            //txtSpecimenNo.ForeColor = System.Drawing.Color.Black;
            txtSpecimenNo.ReadOnly = value == false ? true : false;
            //ddlstatus.BackColor = System.Drawing.Color.RosyBrown;
            //ddlProcessingMethods.BackColor = System.Drawing.Color.RosyBrown;
            //ddlStaining.BackColor = System.Drawing.Color.RosyBrown;
            //ddlInvResultTemplate.BackColor = System.Drawing.Color.RosyBrown;
            lnkEdit.Visible = true;
        }
    }
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {

        lnkEdit.Visible = true;
        hdnReadonly.Value = "true";
        txtSpecimenNo.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtOrgan.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
        txtClinicalNotes.Attributes.Add("readOnly", "true");
    }
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        if (ViewState["test"] == null)
        {
            ViewState["isEdit"] = true;
        }
        Readonly = true;
    }
    string isEdit = "false";
    public string IsEdit
    {
        get
        {
            if (ViewState["isEdit"] != null)
            {
                isEdit = ViewState["isEdit"].ToString();
            }
            else
            {
                isEdit = "false";
            }
            return isEdit;
        }

    }
    private long pOrgid = -1;
    public long POrgid
    {
        get { return pOrgid; }
        set
        {
            pOrgid = value;
        }
    }

    private string labTechEditMedRem = string.Empty;

    public string LabTechEditMedRem
    {
        get { return labTechEditMedRem; }
        set
        {
            labTechEditMedRem = value;
            EnableMedicalRemarksForLabTech();
        }
    }

    private void EnableMedicalRemarksForLabTech()
    {
        if (labTechEditMedRem == "N" && currentRoleName == "Lab Technician")
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
        }
    }

    private string currentRoleName = string.Empty;
    public string CurrentRoleName
    {
        get { return currentRoleName; }
        set
        {
            currentRoleName = value;
        }
    }

    public void GenPtnImages(long invid)
    {
        try
        {
            long patientvid = -1;
            long returncode = -1;
            long POrgID = -1;

            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            hdninvid.Value = invid.ToString();
            lstpatientImages = new List<PatientInvestigationFiles>();
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            if (Request.QueryString["POrgID"] != null)
            {
                Int64.TryParse(Request.QueryString["POrgID"], out POrgID);
            }
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientvid);
            }

            if (patientvid != null && invid != null)
            {
                returncode = InvestigationBL.ProbeImagesForPatientVisits(patientvid, invid, POrgID, out lstpatientImages);
                List<PatientInvestigationFiles> lstResult = (from R in lstpatientImages
                                                             select new PatientInvestigationFiles
                                                             {
                                                                 ImageID = R.ImageID,
                                                                 FilePath = R.FilePath
                                                             }).ToList();
                if (lstResult.Count > 0)
                {
                    hdnImgSourceDetails.Value = oJavaScriptSerializer.Serialize(lstResult);
                    ScriptManager.RegisterStartupScript(this, GetType(), this.ClientID, "BindImage(" + invid + "," + POrgID + "," + patientvid + ",'" + this.ClientID + "');", true);
                    
                }
            }
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GenPtnImages Getting ", ex);
        }
    }
}
