using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Web.Script.Serialization;

public partial class Investigation_BioPattern3 : System.Web.UI.UserControl
{
    private string name = string.Empty;   
    private string result = string.Empty;
    private string uom = string.Empty;
    private string id = string.Empty;
    private int i = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private string age = string.Empty;
    private string sex = string.Empty;
    private string patientName = string.Empty;
    private string isSensitive = string.Empty;

    private string qCData = string.Empty;

    //code added on 23-07-2010 QRM - Started
    //Investigation_BL InvestigationBL;
    //protected override void Render(HtmlTextWriter writer)
    //{

    //    long returnCode = -1;
    //    List<InvQualitativeResultMaster> lstQualitativeResult = new List<InvQualitativeResultMaster>();
    //    returnCode = InvestigationBL.GetInvQualitativeResultMaster(out lstQualitativeResult);


    //    for (int i = 0; i < lstQualitativeResult.Count; i++)
    //    {
    //        Page.ClientScript.RegisterForEventValidation(ddlData.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
    //    }
    //    base.Render(writer);

    //}
    private string barCodenumber = string.Empty;
    public string BarCodeNumber
    {
        get { return barCodenumber; }
        set
        {
            barCodenumber = value;
            lblbarcodeno.Text = barCodenumber;
        }
    }
    string showbarcodeno = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "table-cell");
            lblPVisitID.Text = Convert.ToString(PatientVisitID);
            lblPatternID.Text = Convert.ToString(PatternID);
            lblInvID.Text = ControlID;
            lblOrgID.Text = Convert.ToString(POrgid);
            lblPatternClassName.Text = "Investigation_BioPattern3";


        }
        //InvestigationBL = new Investigation_BL(base.ContextInfo);
        
        AutoCompleteExtender1.ContextKey = ControlID + "~" + "INV" + "~" + orgID + "~" + roleID;
        AutoCompleteExtender2.ContextKey = ControlID + "~" + "INV" + "~" + orgID + "~" + roleID;

        hlnkAdd.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlData.ClientID + "','Source')");
        hlnkAdd.Attributes.Add("onmouseover", "this.style.cursor='hand'");

        ATag.Attributes.Add("onmouseover", "this.style.cursor='pointer';");
        //ATag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty1(this.id,'ddlData','0');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");

        showbarcodeno = GetConfigValue("Showbarcodeno", Convert.ToInt32(pOrgid));
        if (showbarcodeno == "Y")
        {
            lblbarcodeno.Style.Add("display", "table-cell");
        }
        else
        {
            lblbarcodeno.Style.Add("display", "none");
        }
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");

        spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + ddlData.ClientID + "','','" + hdnXmlContent.ClientID + "','','" + lblName.ClientID + "','" + lblUOM.ClientID + "');");

        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");

    }
    //code added on 23-07-2010 QRM - Completed
    private string refRange = string.Empty;

    public string RefRange
    {
        get { return refRange; }
        set
        {
            refRange = value;
            txtRefRange.Text = refRange;
        }
    }
    /// <summary>
    /// Get and Set the Investigation Name
    /// </summary>
    /// 
    private int groupID = 0;
    private string groupName = string.Empty;
    private string visitNumber = string.Empty;


    public int GroupID
    {
        get { return groupID; }
        set
        {
            hdnGroupID.Value = Convert.ToString(value);
            groupID = value;
        }
    }


    public string GroupName
    {
        get { return groupName; }
        set
        {
            hdnGroupName.Value = value;
            groupName = value;
        }
    }

    public string VisitNumber
    {
        get { return visitNumber; }
        set
        {
            lnkPDFReportPreviewer.Attributes.Add("onclick", "ShowReportPreview('" + PatientVisitID + "','" + roleID + "','all');return false;");
            lnkPDFReportPreviewer.Text = value;
        }
    }

    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
        }
    }
    public string Dilution
    {
        get { return txtDilution.Text; }
        set
        {
            txtDilution.Text = value;
        }
    }


    /// <summary>
    /// Get and Set the UOM Code
    /// </summary>
    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUOM.Text = uom;
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
    public long VisitID
    {
        get { return visitID; }
        set
        {
            visitID = value;
        }
    }
    public long PatientID
    {
        get { return patientID; }
        set
        {
            patientID = value;
        }
    }
    public string UID
    {
        get { return uID; }
        set
        {
            uID = value;
            hdnUID.Value = value;
        }
    }
    public string Age
    {
        get { return age; }
        set
        {
            lblAge.Text = age = value;
        }
    }
    public string Sex
    {
        get { return sex; }
        set
        {
            lblSex.Text = sex = value;
        }
    }
    public string PatientName
    {
        get { return patientName; }
        set
        {
            lblPatientName.Text = value;
        }
    }

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
            hdnPackageID.Value = Convert.ToString(value);
            packageID = value;
        }
    }


    public string PackageName
    {
        get { return packageName; }
        set
        {
            hdnPackageName.Value = value;
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


    //Added By Prasanna.S on 19-Sep-2013
    private string labno = string.Empty;
    public string LabNo
    {
        get
        {
            return labno;
        }
        set
        {
            labno = value;
            hdnLabNo.Value = value;
        }
    }


    //Added by Perumal on 13 Jan 2012


    /// <summary>
    /// Method to populate dropdown list
    /// </summary>
    /// <param name="lstData"></param>
    public void LoadData(List<InvestigationValues> lstData)
    {
        try
        {
            ddlData.DataSource = lstData;
            ddlData.DataTextField = "Value";
            ddlData.DataValueField = "Value";
            ddlData.DataBind();
            ddlData.SelectedIndex = 0;
            //ddlData.Items.Insert(0, new ListItem("Select", "0"));
            //ddlData.SelectedValue = "0";
			ddlData.Items.Insert(0, new ListItem("Select", "0"));
            ddlData.SelectedValue = "0";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in loading dropdown values", ex);
        }
    }


    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        //code modified on 23-07-2010 QRM 
        String[] status;
        //Commented By Arivalagan while Result is empty it should allow
        hdnDDL.Value = ((hdnDDL.Value == "") || (hdnDDL.Value == "0")) ? ddlData.SelectedItem.Text : hdnDDL.Value;
       
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            hdnDDL.Value = hdnDDL.Value == "Select" ? "" : hdnDDL.Value;
            //hdnDDL.Value = ddlData.SelectedItem.Value;
            obj.Value = hdnDDL.Value;
            obj.PatientVisitID = VID;
            obj.CreatedBy = lID;
            obj.UOMCode = lblUOM.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.Dilution = txtDilution.Text;
            lstInvestigationVal.Add(obj);
            obj.UID = UID;

        

        return lstInvestigationVal;

    }

    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        try
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
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading biopattern3 status dropdown", ex);
        }
    }

    //public void loadOpinionUser(List<Users> lstOpinionUser)
    //{
    //    ddlOpinionUser.DataSource = lstOpinionUser;
    //    ddlOpinionUser.DataTextField = "Name";
    //    ddlOpinionUser.DataValueField = "LoginID";
    //    ddlOpinionUser.DataBind();
    //    ListItem item = new ListItem();
    //    item.Text = "---Select---";
    //    item.Value = "0";
    //    ddlOpinionUser.Items.Insert(0, item);
    //    ddlOpinionUser.SelectedIndex = 0;
    //}

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
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);//OrgID;


        Pinv.QCData = QCData;

        Pinv.AutoApproveLoginID = AutoApproveLoginID;
        if (hdnstatusreason.Value != "")
        {
            Pinv.InvStatusReasonID = Convert.ToInt32(hdnstatusreason.Value.Split('~')[0].ToString());
            Pinv.Reason = hdnstatusreason.Value.Split('~')[1].ToString();
        }
        //if (ddlStatusReason.Items.Count > 0)
        //{
        //    Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == "-----Select-----" ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));


        //}
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

        if (hdnMedicalRemarksID.Value != null && hdnMedicalRemarksID.Value != "")
        {
            Pinv.MedicalRemarksID = Convert.ToInt64(hdnMedicalRemarksID.Value);
        }
		Pinv.AccessionNumber = AccessionNumber;
        Pinv.GroupID = groupID;
        Pinv.UID = UID;
        Pinv.LabNo = LabNo;
        //InvRemarks
        Pinv.IsAbnormal = IsAbnormal;
        Pinv.PrintableRange = hdnPrintableRange.Value.Trim().Replace("\n", "<br>");
        return Pinv;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }

    public string GetConfigValue(string strConfigKey, int OrgID)
    {
        string strConfigValue = string.Empty;
        try
        {
            long returncode = -1;
            GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
            List<Config> lstConfig = new List<Config>();
            returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
            if (lstConfig.Count >= 0)
                strConfigValue = lstConfig[0].ConfigValue;
            else
                CLogger.LogWarning("InValid " + strConfigKey);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading" + strConfigKey, ex);
        }
        return strConfigValue;
    }

    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        try
        {
            lblName.Text = lEditInvestigation[0].Name;
            txtReason.Text = lEditInvestigation[0].Reason;
            txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
            txtDilution.Text = lEditInvestigation[0].Dilution;
            if (lEditInvestigation[0].PatientVisitID > 0)
            {
                PatientVisitID = lEditInvestigation[0].PatientVisitID;
            }
            lblPVisitID.Text = Convert.ToString(PatientVisitID);
            lblPatternID.Text = Convert.ToString(PatternID);
            lblInvID.Text = ControlID;
            lblOrgID.Text = Convert.ToString(POrgid);
            lblPatternClassName.Text = "Investigation_BioPattern3";
            //Delta CheckUp 
            if (isDeltaCheckWant)
            {
                //tdDeltaCheck.Style.Add("display", "block");`
                tdBetaCheck.Style.Add("display", "table-cell");
            }
            if (!String.IsNullOrEmpty(lEditInvestigation[0].DeviceID))
            {
                DeviceID = lEditInvestigation[0].DeviceID;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading data", ex);
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
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            //ddlData.Enabled = value;
            //lnkEdit.Visible = true;
            //txtRefRange.Enabled = value;
            //Modified by Perumal on 23 Jan 2012
            //ddlstatus.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012          
            txtRefRange.ReadOnly = value == false ? true : false;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            //txtReason.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012
            //txtReason.ForeColor = System.Drawing.Color.Black;
            //txtRefRange.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012
            //txtRefRange.ForeColor = System.Drawing.Color.Black;
            //ddlData.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012
            //ddlData.ForeColor = System.Drawing.Color.Black;
            //txtReason.Font.Bold = true;            
            lnkEdit.Visible = true;

        }
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
    // code added - reference range - starts
    public void setXmlValues(string xmlValues)
    {
        hdnXmlContent.Value = xmlValues;
    }
    //code added - reference range - ends

    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }
    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        //txtMedRemarks.Attributes.Add("readOnly", "true");
        txtDilution.Attributes.Add("readOnly", "true");
    }
    private long patientVisitID = -1;
    public long PatientVisitID
    {
        get { return patientVisitID; }
        set
        {
            patientVisitID = value;
        }
    }
    private long patternID = -1;
    public long PatternID
    {
        get { return patternID; }
        set
        {
            patternID = value;
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
    private string currentRoleName = string.Empty;
    public string CurrentRoleName
    {
        get { return currentRoleName; }
        set
        {
            currentRoleName = value;
        }
    }
    private bool isDeltaCheckWant = false;
    public bool IsDeltaCheckWant
    {
        get { return isDeltaCheckWant; }
        set { isDeltaCheckWant = value; }
    }

    private string labTechEditMedRem = string.Empty;

    public string LabTechEditMedRem
    {
        get { return labTechEditMedRem; }
        set
        {
            labTechEditMedRem = value;
            //EnableMedicalRemarksForLabTech();
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
    private string isAutoValidate = "N";
    public string IsAutoValidate
    {
        get { return isAutoValidate; }
        set
        {
            hdnIsAutoValidate.Value = value;
            isAutoValidate = value;
        }
    }
    public void BatchWise(bool IsBatchWise)
    {
        if (IsBatchWise)
        {
            tdPatientDetails.Style.Add("display", "table-cell");
            tdInvName.Style.Add("display", "table-cell");
            ddlData.Attributes.Add("onchange", "javascript:expandDDL(this);setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');validateResult('" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','','','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUOM.ClientID + "','" + Age + "','" + Sex + "');appendDDLHdn('" + ddlData.ClientID + "','" + hdnDDL.ClientID + "');");
            validateResultParameter = ddlData.ClientID + "," + hdnXmlContent.ClientID + ",,," + txtIsAbnormal.ClientID + "," + AutoApproveLoginID + "," + lblName.ClientID + "," + lblUOM.ClientID + "," + Age + "," + Sex;
        }
        else
        {
            lblName.Attributes.Add("onclick", "javascript:changeTestName(this.id);");
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
            ddlData.Attributes.Add("onchange", "javascript:expandDDL(this);setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');validateResult('" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','','','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUOM.ClientID + "','','');appendDDLHdn('" + ddlData.ClientID + "','" + hdnDDL.ClientID + "');");
            validateResultParameter = ddlData.ClientID + "," + hdnXmlContent.ClientID + ",,," + txtIsAbnormal.ClientID + "," + AutoApproveLoginID + "," + lblName.ClientID + "," + lblUOM.ClientID + ",,";
        }
    }

    private long autoApproveLoginID = -1;
    public long AutoApproveLoginID
    {
        get { return autoApproveLoginID; }
        set 
        {
            hdnAutoApproveLoginID.Value = Convert.ToString(value);
            autoApproveLoginID = value; 
        }
    }

    private string isAbnormal = string.Empty;
    public string IsAbnormal
    {
        get { return isAbnormal; }
        set
        {
            hdnIsAbnormal.Value = value;
            isAbnormal = value;
            ddlData.ForeColor = System.Drawing.Color.Black;
            if (isAbnormal == "A")
            {
                ddlData.Attributes.Add("style", "background-color:yellow;");
                txtIsAbnormal.Attributes.Add("style", "background-color:yellow;");
            }
            if (isAbnormal == "L")
            {
                ddlData.Attributes.Add("style", "background-color:LightPink;");
                txtIsAbnormal.Attributes.Add("style", "background-color:LightPink;");
            }
            if (isAbnormal == "P")
            {
                ddlData.Attributes.Add("style", "background-color:red;");
                txtIsAbnormal.Attributes.Add("style", "background-color:red;");
            }
        }
    }
    public string IsSensitive
    {
        get { return isSensitive; }
        set
        {
            isSensitive = value;
        }
    }


    public string QCData
    {
        get { return qCData; }
        set { qCData = value; }
    }

    private string isAutoAuthorize = string.Empty;
    public string IsAutoAuthorize
    {
        get { return isAutoAuthorize; }
        set
        {
            isAutoAuthorize = value;
            ddlData.ForeColor = System.Drawing.Color.Black;
            if (isAutoAuthorize == "Y")
            {
                //ddlData.Attributes.Add("style", "background-color:LightGreen;");
            }

        }
    }
    private string isAutoApproveQueue = string.Empty;
    public string IsAutoApproveQueue
    {
        get { return isAutoApproveQueue; }
        set { isAutoApproveQueue = value; }
    }
    public string DDLClientID
    {
        get { return ddlData.ClientID; }
    }
    public string hdnDDLClientID
    {
        get { return hdnDDL.ClientID; }
    }
    public string TestName
    {
        get
        {
            return lblName.Text.Replace("'", "\\'");
        }
    }
    public string TestUnit
    {
        get
        {
            return lblUOM.Text;
        }
    }
    private string validateResultParameter = string.Empty;
    public string ValidateResultParameter
    {
        get { return validateResultParameter; }
        set { validateResultParameter = value; }
    }
    private string deviceID = String.Empty;
    public string DeviceID
    {
        get { return deviceID; }
        set
        {
            if (!String.IsNullOrEmpty(value))
            {
                imgDeviceValue.Visible = true;
                imgDeviceValue.Src = "~/Images/report.gif";
                imgDeviceValue.Attributes.Add("onclick", "javascript:GetDeviceValue('" + POrgid + "','" + PatientVisitID + "','" + ControlID + "' );");
            }
            else
            {
                imgDeviceValue.Visible = false;
            }
            deviceID = value;
        }
    }
    public string TestStatus
    {
        set
        {
            if (!string.IsNullOrEmpty(value))
            {
                lblTestStatus.Text = value;
            }
        }
    }
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }
	public long ClientID
    {
        set
        {
            hdnClientID.Value = Convert.ToString(value);
        }
    }
    public void loadMethodForHistory(List<InvestigationValues> lstBulkData)
    {
        foreach (InvestigationValues values in lstBulkData)
        {
            if (values.Name == "Y")
            {
                txtReason.Text = values.GroupName;
                break;
            }

        }

    }
    private int orgID = 0;
    public int OrgID
    {
        set
        {
            orgID = value;
        }
    }
    private long roleID = 0;
    public long RoleID
    {
        set
        {
            roleID = value;
        }
    }
    private long lID = 0;
    public long LID
    {
        set
        {
            lID = value;
        }
    }
}
