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

public partial class Investigation_HistoPathologyPatternQuantum : BaseControl
{
    public Investigation_HistoPathologyPatternQuantum()
        : base("Investigation_HistoPathologyPatternQuantum_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int groupID = 0;
    private string groupName = string.Empty;
    long visitid = 0;
    int ResultID = -1;
    string ResultName = string.Empty;
    string Macroscopy = string.Empty;
    string Microscopy = string.Empty;
    string Impression = string.Empty;
    Investigation_BL invBL ;
    List<InvResultTemplate> lstInvResultTemplate = new List<InvResultTemplate>();
    List<PatientInvestigationFiles> lstpatientImages;
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_InvestigationReport_aspx_01;
    public int GroupID
    {
        get { return groupID; }
        set
        {
            groupID = value;
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

    string Alert = Resources.Investigation_AppMsg.Investigation_Header_Alert == null ? "Alert" : Resources.Investigation_AppMsg.Investigation_Header_Alert;

    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        invBL = new Investigation_BL(base.ContextInfo);
        if (Request.QueryString["vid"] != null)
        {
            Int64.TryParse(Request.QueryString["vid"], out visitid);

        }
        if (!string.IsNullOrEmpty(ControlID))
        {
            BindImages(visitid, OrgID, ControlID);
        }
        LoadMetaData();
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");

        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath ;
        sPath = sPath + "/ckeditor/";

        txtOrgan.BasePath = sPath;
        //txtOrgan.ToolbarSet = "Default";
        //txtOrgan.ToolbarStartExpanded = false;
        //txtOrgan.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtOrgan.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";
        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtOrgan.ClientID), true);
        Page.ClientScript.RegisterOnSubmitStatement(txtOrgan.GetType(), txtOrgan.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtOrgan.ClientID + "').UpdateLinkedField();");
        if (ControlID == "9502"
           || ControlID == "9503" || ControlID == "9504" || ControlID == "9505" || ControlID == "9505" ||
           ControlID == "9506" || ControlID == "9507" || ControlID == "9508" || ControlID == "9509" || ControlID == "9510" ||
           ControlID == "9540" || ControlID == "9766")
        {
            txtGross.Visible = false;
            lblGross.Visible = false;
        }
        else
        {
            txtGross.BasePath = sPath;
            //txtGross.ToolbarSet = "Default";
            //txtGross.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
            //txtGross.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

            Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtGross.ClientID), true);

            Page.ClientScript.RegisterOnSubmitStatement(txtGross.GetType(), txtGross.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtGross.ClientID + "').UpdateLinkedField();");

        }
        
        txtClinicalNotes.BasePath = sPath;
        //txtClinicalNotes.ToolbarSet = "Default";
        //txtClinicalNotes.ToolbarStartExpanded = false;
        //txtClinicalNotes.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtClinicalNotes.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtClinicalNotes.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtMicroscopy.GetType(), txtClinicalNotes.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtClinicalNotes.ClientID + "').UpdateLinkedField();");
        


        txtImpression.BasePath = sPath;
        //txtImpression.ToolbarSet = "Default";
        //txtImpression.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtImpression.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtImpression.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtImpression.GetType(), txtImpression.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtImpression.ClientID + "').UpdateLinkedField();");

        txtMicroscopyandInterpretation.BasePath = sPath;
        //txtMicroscopyandInterpretation.ToolbarSet = "Default";
        //txtMicroscopyandInterpretation.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtMicroscopyandInterpretation.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtMicroscopyandInterpretation.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtMicroscopyandInterpretation.GetType(), txtMicroscopyandInterpretation.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtMicroscopyandInterpretation.ClientID + "').UpdateLinkedField();");


        txtMicroscopy.BasePath = sPath;
        //txtMicroscopy.ToolbarSet = "Default";
        //txtMicroscopy.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtMicroscopy.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtMicroscopy.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtMicroscopy.GetType(), txtMicroscopy.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtMicroscopy.ClientID + "').UpdateLinkedField();");

        txtCommenttext.BasePath = sPath;
        //txtCommenttext.ToolbarSet = "Default";
        //txtCommenttext.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtCommenttext.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtCommenttext.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtCommenttext.GetType(), txtCommenttext.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtCommenttext.ClientID + "').UpdateLinkedField();");
        //txtGross.BasePath = sPath;
        //txtGross.ToolbarSet = "Default";
        //txtGross.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        //txtGross.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtGross.ClientID), true);

        //Page.ClientScript.RegisterOnSubmitStatement(txtGross.GetType(), txtGross.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtGross.ClientID + "').UpdateLinkedField();");
        
        
        
        //flUpload.FileName.Replace(" ", "c:\fakepath\venkat.jpg");
        
            invBL.GetInvestigationResultTemplate(Convert.ToInt32(POrgid), "Biopsy", 0, out lstInvResultTemplate);
            if (lstInvResultTemplate.Count > 0)
            {
                ddlInvResultTemplate.DataSource = lstInvResultTemplate;
                ddlInvResultTemplate.DataTextField = "ResultName";
                ddlInvResultTemplate.DataValueField = "ResultID";
                ddlInvResultTemplate.DataBind();
                ddlInvResultTemplate.Items.Insert(0, "-----Select-----");
                ddlInvResultTemplate.Items[0].Value = "0";
            }
            //Page.ClientScript.RegisterOnSubmitStatement(FCKinvFinidings.GetType(), FCKinvFinidings.ClientID + "FCKinvFinidings", "FCKeditorAPI.GetInstance('" + FCKinvFinidings.ClientID + "').UpdateLinkedField();");
            //Page.ClientScript.RegisterOnSubmitStatement(FCKImpression.GetType(), FCKImpression.ClientID + "FCKImpression", "FCKeditorAPI.GetInstance('" + FCKImpression.ClientID + "').UpdateLinkedField();");
            txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

            txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
    }

    
    public void LoadData(List<InvestigationValues> lstValues)
    {
        for (int i = 0; i < lstValues.Count; i++)
        {
            lblName.Text = lstValues[i].Value;
            txtReason.Text = lstValues[0].Reason;
            txtMedRemarks.Text = lstValues[0].MedicalRemarks;
        }
    }
    protected void BindImages(long visitid, int POrgID, string invid)
    {
        long returncode = -1;
        long investigationid = Convert.ToInt64(invid);
        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
        lstpatientImages = new List<PatientInvestigationFiles>();
        if (visitid != null && investigationid != null && POrgID != null)
        {
            returncode = InvestigationBL.ProbeImagesForPatientVisits(visitid, investigationid, POrgID, out lstpatientImages);
        }
        if (lstpatientImages.Count > 0)
        {
            // tdrptimages.Visible = true;
            rptimages.DataSource = lstpatientImages;
            rptimages.DataBind();
        }
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlStatus.DataSource = lstStatus;
        //ddlStatus.DataTextField = "Status";
        //ddlStatus.DataValueField = "InvestigationStatusID";
        ddlStatus.DataTextField = "DisplayText";
        ddlStatus.DataValueField = "StatuswithID";
        ddlStatus.DataBind();
        string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
        if (ddlStatus.Items.FindByValue(SelString) != null)
        {
            ddlStatus.SelectedValue = SelString;
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
            ddlBarcode.Items.Insert(0, new ListItem(strSelect.Trim(), "0"));
            tdbarcodetxt.Style.Add("display", "block");
            tdbarcode.Style.Add("display", "block");
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
        //Pinv.Status = ddlStatus.SelectedItem.Text;
        status = ddlStatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
        return Pinv;
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        if (ddlBarcode.Items.Count > 0)
        {
            if (ddlBarcode.SelectedItem.Text != strSelect.Trim())
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
                //obj.Status = ddlStatus.SelectedItem.Text;
                status = ddlStatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
            }
        }
        if (txtOrgan.Text  != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblOrgan.Text;
            obj.Value = txtOrgan.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 3;
            lstInvestigationVal.Add(obj);
        }

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
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 1;
            lstInvestigationVal.Add(obj);
        }

        if (txtSpecimen.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSpecimen.Text;
            obj.Value = txtSpecimen.Text;
            obj.PatientVisitID = VID;

            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 5;
            lstInvestigationVal.Add(obj);
        }

        if (txtClinicalNotes.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblClinicalNotes.Text;
            obj.Value = txtClinicalNotes.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 2;
            lstInvestigationVal.Add(obj);
        }
        if (txtClinicalDiagnosis.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblClinicalDiagnosis.Text;
            obj.Value = txtClinicalDiagnosis.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 4;
            lstInvestigationVal.Add(obj);
        }

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
                                //obj.Status = ddlStatus.SelectedItem.Text;
                                status = ddlStatus.SelectedValue.Split('_');
                                obj.Status = status[0].ToString();
                                obj.PackageID = PackageID;
                                obj.PackageName = PackageName;
                                obj.SequenceNo = 6;
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
                                //obj.Status = ddlStatus.SelectedItem.Text;
                                status = ddlStatus.SelectedValue.Split('_');
                                obj.Status = status[0].ToString();
                                obj.PackageID = PackageID;
                                obj.PackageName = PackageName;
                                obj.SequenceNo = 7;
                                lstInvestigationVal.Add(obj);
                            }

                            break;
                    };
                }
            }
        }

        if (txtGross.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblGross.Text;
            obj.Value = txtGross.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 8;
            lstInvestigationVal.Add(obj);
        }
        if (txtMicroscopy.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMicroscopy.Text;
            obj.Value = txtMicroscopy.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 9;
            lstInvestigationVal.Add(obj);
        }
        if (txtImpression.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblImpression.Text;
            obj.Value = txtImpression.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 10;
            lstInvestigationVal.Add(obj);
        }
        if (txtMicroscopyandInterpretation.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMicroInterpretation.Text;
            obj.Value = txtMicroscopyandInterpretation.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 11;
            lstInvestigationVal.Add(obj);
        }
        if (txtCommenttext.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblComm.Text;
            obj.Value = txtCommenttext.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 12;
            lstInvestigationVal.Add(obj);
        }
        //return lstInvestigationVal;
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
        string strValidation = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_05 == null ? "Select Result Template" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_05;
        txtGross.Text = "";
        txtMicroscopy.Text = "";
        txtImpression.Text = "";
        txtMicroscopyandInterpretation.Text = "";
        if (ddlInvResultTemplate.SelectedIndex > 0)
        {
            ResultID = Convert.ToInt32(ddlInvResultTemplate.SelectedValue);
            ResultName = Convert.ToString(ddlInvResultTemplate.SelectedItem);
            List<InvResultTemplate> lresultTemplate = new List<InvResultTemplate>();
            invBL.GetInvestigationResultTemplateByID(Convert.ToInt32(POrgid), ResultID, ResultName, "Biopsy", out lresultTemplate);
            XmlDocument xmldoc = new XmlDocument();
            xmldoc.LoadXml(lresultTemplate[0].ResultValues);
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods", "javascript:LoadExistingItems('" + hResultvalues.Value + "','" + this.ClientID + "');", true);
                   
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
                    txtImpression.Text = xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;
                }
                else
                {
                    txtImpression.Text += ", " + xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;
                }
                if (txtMicroscopyandInterpretation.Text == "")
                {
                   // txtMicroscopyandInterpretation.Text = xmldoc.GetElementsByTagName("Microscopy And Interpretation").Item(0).InnerText;
                }
                else
                {
                    //txtMicroscopyandInterpretation.Text += ", " + xmldoc.GetElementsByTagName("Microscopy And Interpretation").Item(0).InnerText;
                }
            }
            else
            {
                txtGross.Text = xmldoc.GetElementsByTagName("Gross").Item(0).InnerText;
                txtMicroscopy.Text = xmldoc.GetElementsByTagName("Microscopy").Item(0).InnerText;
                if (xmldoc.GetElementById("Impression") == null)
                {
                    if (xmldoc.InnerXml.Contains("Impression") == null)
                    {

                    }
                    else
                    {
                        try
                        {
                            txtImpression.Text = xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;

                        }
                        catch (Exception ex)
                        {
                            string strMessage = ex.Message;
                        }
                    }

                }
                else
                {
                    txtImpression.Text = xmldoc.GetElementsByTagName("Impression").Item(0).InnerText;

                }

                //txtMicroscopyandInterpretation.Value = xmldoc.GetElementsByTagName("Microscopy And Interpretation").Item(0).InnerText;
            }
        }
        else
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "SelectTemplate", "ValidationWindow(" + strValidation + "," + Alert + ");", true);
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
                || (flUpload.PostedFile.ContentType == "image/pjpeg") || (flUpload.PostedFile.ContentType == "image/jpeg") || (flUpload.PostedFile.ContentType == "image/x-png"))
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
                || (flUpload2.PostedFile.ContentType == "image/pjpeg") || (flUpload2.PostedFile.ContentType == "image/jpeg") || (flUpload.PostedFile.ContentType == "image/x-png"))
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
                || (flUpload3.PostedFile.ContentType == "image/pjpeg") || (flUpload3.PostedFile.ContentType == "image/jpeg") || (flUpload.PostedFile.ContentType == "image/x-png"))
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
                || (flUpload4.PostedFile.ContentType == "image/pjpeg") || (flUpload4.PostedFile.ContentType == "image/jpeg") || (flUpload.PostedFile.ContentType == "image/x-png"))
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
        string Bspecimen = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_22 == null ? "Biopsy Specimen" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_22;
        string Specimen = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_06 == null ? "Specimen" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_06;
        string SpecimenNo = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_07 == null ? "Specimen No." : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_07;
        string TOSpecimen = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_23 == null ? "Type of Specimen" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_23;
        string Technique = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_08 == null ? "Technique" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_08;
        string ClinicalNotes = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_24 == null ? "Clinical Notes" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_24;
        string ClinicalHistory = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_09 == null ? "Clinical History" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_09;
        string ClinicalDiagnosis = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_25 == null ? "Clinical Diagnosis" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_25;
        string Site = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_10 == null ? "Site" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_10;
        string Staining = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_26 == null ? "Staining" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_26;
        string Gross = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_13 == null ? "Gross" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_13;
        string ProcessMethod = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_11 == null ? "ProcessMethods" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_11;
        string Microscopy = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_17 == null ? "Microscopy" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_17;
        string Impression = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_18 == null ? "Impression" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_18;
        string MAInterpretation = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_19 == null ? "Microscopy And Interpretation" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_19;
        string Comment = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_20 == null ? "Comment" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_20;
        string SlideNo = Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_21 == null ? "Slide No" : Resources.Investigation_AppMsg.Investigation_HistoPathologyPatternQuantum_ascx_21;


        string ProcessMethods = string.Empty;
        //RID:1~ProcessMethods:Processing Methods af~Staining:Staining ^
        //RID:2~ProcessMethods:23~Staining:fasf^
        //lblName.Text = lInvestigationValues[0].Name;
        if (lInvestigationValues.Count > 0)
        {
            for (int Index = 0; Index < lInvestigationValues.Count; Index++)
            {
                if (lInvestigationValues[Index].Name == Bspecimen || lInvestigationValues[Index].Name == Specimen)
                {
                    txtOrgan.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == SpecimenNo)
                {
                    txtSpecimenNo.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == TOSpecimen || lInvestigationValues[Index].Name == Technique)
                {
                    txtSpecimen.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == ClinicalNotes || lInvestigationValues[Index].Name == ClinicalHistory)
                {
                    txtClinicalNotes.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == ClinicalDiagnosis || lInvestigationValues[Index].Name == Site)
                {
                    txtClinicalDiagnosis.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == ProcessMethod)
                {
                    ProcessMethods += "RID:" + Index + "~ProcessMethods:" + lInvestigationValues[Index].Value ;
                }
                else if (lInvestigationValues[Index].Name == Staining)
                {
                    ProcessMethods += "~Staining:" + lInvestigationValues[Index].Value + "^";
                }
                else if (lInvestigationValues[Index].Name == Gross)
                {
                    txtGross.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == Microscopy )
                {
                    txtMicroscopy.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == Impression)
                {
                    txtImpression.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == MAInterpretation)
                {
                    txtMicroscopyandInterpretation.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == Comment)
                {
                    txtCommenttext.Text = lInvestigationValues[Index].Value;
                }
                else if (lInvestigationValues[Index].Name == SlideNo )
                {
                    string barcodevalue = string.Empty;
                    barcodevalue= ddlBarcode.Items.FindByText(lInvestigationValues[Index].Value).Value;
                    ddlBarcode.SelectedValue = barcodevalue;
                }
            }
            txtReason.Text = lInvestigationValues[0].Reason;
        }
        if (ProcessMethods != string.Empty)
        {
            hResultvalues.Value = ProcessMethods;
            ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "ProcessMethods", "javascript:LoadExistingItems('" + hResultvalues.Value + "','" + this.ClientID + "');", true);
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
            //txtOrgan.ReadOnly = value == false ? true : false;
            //txtClinicalDiagnosis.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalDiagnosis.ForeColor = System.Drawing.Color.Black;
            txtClinicalDiagnosis.ReadOnly = value == false ? true : false;
            //txtClinicalNotes.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalNotes.ForeColor = System.Drawing.Color.Black;
           // txtClinicalNotes.ReadOnly = value == false ? true : false;            
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
            txtSpecimen.ReadOnly = value == false ? true : false;
            //txtSpecimenNo.BackColor = System.Drawing.Color.RosyBrown;
            //txtSpecimenNo.ForeColor = System.Drawing.Color.Black;
            txtSpecimenNo.ReadOnly = value == false ? true : false;
            //ddlStatus.BackColor = System.Drawing.Color.RosyBrown;
            //ddlProcessingMethods.BackColor = System.Drawing.Color.RosyBrown;
            //ddlStaining.BackColor = System.Drawing.Color.RosyBrown;
            //ddlInvResultTemplate.BackColor = System.Drawing.Color.RosyBrown;
            lnkEdit.Visible = true;
        }
    }
    protected void rptimages_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            System.Web.UI.WebControls.Image imgchrome = (System.Web.UI.WebControls.Image)e.Item.FindControl("imgchrome");
            HiddenField HiddenProbeImageID = (HiddenField)e.Item.FindControl("HiddenProbeImageID");
            HiddenField hdnInvestigationId = (HiddenField)e.Item.FindControl("hdnInvestigationId");
            HiddenField hdnPvisitid = (HiddenField)e.Item.FindControl("hdnPvisitid");
            HiddenField hdnOrgID = (HiddenField)e.Item.FindControl("hdnOrgID");
            Label imagpath = (Label)e.Item.FindControl("imagpath");
            imgchrome.ImageUrl = "ProbeImagehandler.ashx?InvID=" + hdnInvestigationId.Value + "&VisitId=" + hdnPvisitid.Value + "&POrgID=" + hdnOrgID.Value + "&ImageID=" + HiddenProbeImageID.Value;
            String ImgUrl = "ProbeImagehandler.ashx?InvID=" + hdnInvestigationId.Value + "&VisitId=" + hdnPvisitid.Value + "&POrgID=" + hdnOrgID.Value + "&ImageID=" + HiddenProbeImageID.Value;
            Button b = (Button)e.Item.FindControl("btnLarge");
            ((Button)e.Item.FindControl("btnLarge")).Attributes.Add("OnClick", "return OnImageEnLarge('" + ImgUrl + "')");
            Button ba = (Button)e.Item.FindControl("btnDelete");
            ((Button)e.Item.FindControl("btnDelete")).Attributes.Add("OnClick", "return onImageDelete('" + hdnInvestigationId.Value + "','" + hdnPvisitid.Value + "','" + hdnOrgID.Value + "','" + HiddenProbeImageID.Value + "','" + imgchrome.ClientID + "','" + imagpath.ClientID + "','" + b.ClientID + "','" + ba.ClientID + "')");
        }
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

    public void LoadMetaData()
    {
       // string strSelect = Resources.Investigation_ClientDisplay.Investigation_HistoPathologyPatternQuantum_ascx == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_HistoPathologyPatternQuantum_ascx;
        try
        {
            long returncode = -1;
            string domains = "ProcessingMethods,Staining,sample";
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
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "sample"
                                  select child;


                ddlInvResultTemplate.DataSource = childItems3;
                ddlInvResultTemplate.DataTextField = "DisplayText";
                ddlInvResultTemplate.DataValueField = "Code";
                ddlInvResultTemplate.DataBind();
                ddlInvResultTemplate.Items.Insert(0, new ListItem(strSelect, ""));


                

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

}
