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
using System.Xml.Linq;
using System.Web.Configuration;

public partial class Investigation_checkInvest : BaseControl
{

    public Investigation_checkInvest()
        : base("Investigation_checkInvest_ascx")
    {
    }

    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string isAbnormal = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private string age = string.Empty;
    private string sex = string.Empty;
    private string patientName = string.Empty;
    private string formula = string.Empty;
    private string isAutoAuthorize = string.Empty;
    private string isSensitive = string.Empty;

    private string qCData = string.Empty;

    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
        }
    }
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
    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUnit.Text = uom;
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
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }
    public string Value1
    {
        get { return txtValue.Text; }
        set { result = value; }
    }
    public int Maxlength
    {
        get { return maxlength; }
        set
        {
            maxlength = value;
            txtValue.MaxLength = maxlength;
        }
    }
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
    //added by prem 11-03-2013
    private string deviceID = String.Empty;
    private string deviceValue = String.Empty;
    private string deviceActualValue = String.Empty;
    private string deviceErrorCode = String.Empty;

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
    /// <summary>
    /// Gets or sets the DeviceValue value.
    /// </summary>
    public string DeviceValue
    {
        get { return deviceValue; }
        set { deviceValue = value; }
    }
    public string DeviceActualValue
    {
        get { return deviceActualValue; }
        set {
            deviceActualValue = value;
            lblQCValue.Text = value;
        }
    }
    //end---------------------
    string editTxtValue = string.Empty;
    public string Text
    {
        //get { return groupName; }
        set
        {
            txtValue.Text = value;
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
    public string Formula
    {
        get
        {
            return formula;
        }
        set
        {
            formula = value;
        }
    }
    public string DeviceErrorCode
    {
        get { return deviceErrorCode; }
        set { deviceErrorCode = value; }
    }
    public string IsAbnormal
    {
        get { return isAbnormal; }
        set
        {
            hdnIsAbnormal.Value = value;
            isAbnormal = value;
            txtValue.Font.Bold = true;
            txtValue.ForeColor = System.Drawing.Color.Black;
            if (isAbnormal == "A")
            {
                txtValue.Attributes.Add("style", "background-color:yellow;");
                txtIsAbnormal.Attributes.Add("style", "background-color:yellow;");
            }
            if (isAbnormal == "L")
            {
                txtValue.Attributes.Add("style", "background-color:LightPink;");
                txtIsAbnormal.Attributes.Add("style", "background-color:LightPink;");
            }
            if (isAbnormal == "P")
            {
                txtValue.Attributes.Add("style", "background-color:red;");
                txtIsAbnormal.Attributes.Add("style", "background-color:red;");
            }
        }
    }
    private bool _isdeltastatus = false;
    public bool Isdeltastatus
    {
        get { return _isdeltastatus; }
        set
        {
            _isdeltastatus = value;
            //if (_isdeltastatus == true)
            //{
            adeltastatus.Attributes.Add("style", "background-color:green;");
            adeltastatus.Attributes.Add("style", "font-size:large;");
            //}
        }
    }

    private string _isAutoCertification = String.Empty;
    public string IsAutoCertification
    {
        get { return _isAutoCertification; }
        set { _isAutoCertification = value; }
    }
    private string qcCheck = string.Empty;
    public string QcCheck
    {
        get { return qcCheck; }

        set
        {
            qcCheck = value;
            if (qcCheck == "Y")
            {
                ChkQcValue.Checked = true;
               
            }
            else
                ChkQcValue.Checked = false;
        }
    }
    public string IsAutoAuthorize
    {
        get { return isAutoAuthorize; }
        set
        {
            isAutoAuthorize = value;
            txtValue.Font.Bold = true;
            txtValue.ForeColor = System.Drawing.Color.Black;
            if (isAutoAuthorize == "Y")
            {
                txtValue.Attributes.Add("style", "background-color:LightGreen;");
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
        set
        {
            qCData = value;
            if (!string.IsNullOrEmpty(qCData))
            {
                aQcstatusImg.Style.Add("display", "block");
                string[] QCdatavalue = qCData.Split('~');
                if (QCdatavalue[0] == "1")
                {
                    aQcstatusImg.ImageUrl = "../Images/Pass.png";
                }
                // if (QCdatavalue.Count() > 1)
                //{
                //aQcstatusImg.Attributes.Add("onclick", "javascript:GetQCValue('" + QCdatavalue[1] + "');");
                //}
            }
            else
            {
                aQcstatusImg.Style.Add("display", "none");
            }
        }
    }

    private bool _isDeltaCheck = false;
    public bool IsDeltaCheck
    {
        get { return _isDeltaCheck; }
        set { _isDeltaCheck = value; }
    }

    private decimal _deltaLowerLimit = 0;
    public decimal DeltaLowerLimit
    {
        get { return _deltaLowerLimit; }
        set
        {
            _deltaLowerLimit = value;
        }
    }

    private decimal _deltaHigherLimit = 0;
    public decimal DeltaHigherLimit
    {
        get { return _deltaHigherLimit; }
        set
        {
            _deltaHigherLimit = value;
            if (_deltaHigherLimit > 0)
            {
                lbldeltarange.Text = _deltaLowerLimit.ToString() + "~" + _deltaHigherLimit.ToString();
            }
        }
    }

    private string _deltaDetails = string.Empty;
    public string DeltaDetails
    {
        get { return _deltaDetails; }
        set
        {
            _deltaDetails = value;
            if (_deltaHigherLimit > 0)
            {
                lbldeltadetails.Value = _deltaDetails;
            }
        }
    }

    private string isAutoApproveQueue = string.Empty;
    public string IsAutoApproveQueue
    {
        get { return isAutoApproveQueue; }
        set { isAutoApproveQueue = value; }
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
    bool readOnly = false;
    public bool Readonly
    {

        set
        {
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            txtValue.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            //Modified by Perumal on 23 Jan 2012

            //txtReason.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012
            //txtReason.ForeColor = System.Drawing.Color.Black;
            //txtRefRange.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012
            //txtRefRange.ForeColor = System.Drawing.Color.Black;
            //txtValue.Font.Bold = true;
            // txtRefRange.Font.Bold = true;
            //txtReason.Font.Bold = true;
            //txtValue.ForeColor = System.Drawing.Color.Black;
            //txtValue.BackColor = System.Drawing.Color.RosyBrown; //Commented by Perumal 23 Jan 2012
            //lnkEdit.Visible = true;
            ATag.Visible = true;
            //hdnReadonly.Value =Convert.ToString(value);


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


    public void setNonEditable(PatientInvestigation lstInv)
    {
        try
        {
            txtValue.ReadOnly = lstInv.IsNonEditable;
            hdnIsNonEditable.Value = Convert.ToString(lstInv.IsNonEditable);
        }
        catch (Exception ex)
        {
        }
    }
    // code added - reference range - starts

    //code added - reference range - ends

    // code added - panic range - starts

    //code added - panic range - ends

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
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    private bool isDeltaCheckWant = false;
    public bool IsDeltaCheckWant
    {
        get { return isDeltaCheckWant; }
        set { isDeltaCheckWant = value; }
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
    private string decimalPlaces;
    public string DecimalPlaces
    {
        get { return decimalPlaces; }
        set
        {
            decimalPlaces = value;
            if (!string.IsNullOrEmpty(value))
            {
                txtValue.Attributes.Add("onkeyup", "return setCompletedStatusValueType(event,'" + GroupName + "','" + txtValue.ClientID.ToString() + "','" + DecimalPlaces + "','" + IsAutoValidate + "');");
            }
            else
            {
                //txtValue.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
            }
        }
    }
    private string resultValueType;
    public string ResultValueType
    {
        get { return resultValueType; }
        set
        {
            resultValueType = value;
            if (value.Trim() == "NU")
            {
                txtValue.Attributes.Add("onkeydown", "return validatenumberOnly(event,'" + txtValue.ClientID.ToString() + "');");
            }
        }
    }
    private string Appendstr = string.Empty;
    public string RefAppendString
    {
        get { return Appendstr; }
        set
        {
            hdnRefAppendString.Value = value;
            Appendstr = value;
        }
    }
    private bool showComputationFieldEditOption = false;
    public bool ShowComputationFieldEditOption
    {
        get { return showComputationFieldEditOption; }
        set
        {
            imgEditComputation.Visible = value;
            if (value)
            {
                txtValue.Attributes.Add("style", "background-color:#FABF8F");
                imgEditComputation.Src = "~/Images/textedit.png";
                imgEditComputation.Attributes.Add("onclick", "ChangeComputationFieldEditOption('" + txtValue.ClientID + "');");
                txtValue.TabIndex = -1;
            }

            string isEditComputationIsNotNeeded = GetConfigValue("EditComputationIsNotNeeded", Convert.ToInt32(pOrgid));
            if (isEditComputationIsNotNeeded == "Y")
            {
                imgEditComputation.Visible = false;
            }
        }
    }
    public string TxtControlID
    {
        get
        {
            return txtValue.ClientID;
        }
    }
    public string TestName
    {
        get
        {
            return lblName.Text;
        }
    }
    public string TestUnit
    {
        get
        {
            return lblUnit.Text;
        }
    }
    private string conreferencerange = string.Empty;
    public string ConReferenceRange
    {
        get { return conreferencerange; }
        set
        {
            hdnConvReferenceRange.Value = value;
            conreferencerange = value;
        }
    }
    private decimal convfactorvalue = 0;
    public decimal ConvFactorvalue
    {
        get { return convfactorvalue; }
        set
        {

            hdnConvFactor.Value = Convert.ToString(value);
            convfactorvalue = value;
        }
    }
    private int convFactorDecimalPt = 0;
    public int CONVFactorDecimalPt
    {
        get { return convFactorDecimalPt; }
        set
        {
            hdnConvDecimalPoint.Value = Convert.ToString(value);
            convFactorDecimalPt = value;
        }
    }
    private string convUOMCode = string.Empty;
    public string ConvUOMCode
    {
        get { return convUOMCode; }
        set
        {
            hdnConvUOM.Value = Convert.ToString(value);
            convUOMCode = value;
        }
    }
    private string validateResultParameter = string.Empty;
    public string ValidateResultParameter
    {
        get { return validateResultParameter; }
        set { validateResultParameter = value; }
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
    private bool isSpecialValue = false;
    public bool IsSpecialValue
    {
        set
        {
            isSpecialValue = value;
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

    #region "Initial"
    string showbarcodeno = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdnIsWaters.Value = GetConfigValue("WatersMode", orgID);
        if (hdnIsWaters.Value == "Y")
        {
            txtMedRemarks.Visible = false;
            lblMedRemarks.Visible = false;
        
        }

        //Delta CheckUp 
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "table-cell");
            lblPVisitID.Text = Convert.ToString(PatientVisitID);
            lblPatternID.Text = Convert.ToString(PatternID);
            lblInvID.Text = ControlID;
            lblOrgID.Text = Convert.ToString(POrgid);
            lblPatternClassName.Text = "Investigation_checkInvest";


        }
        AutoCompleteExtender1.ContextKey = ControlID + "~" + "INV" + "~" + orgID + "~" + roleID;
        AutoCompleteExtender2.ContextKey = ControlID + "~" + "INV" + "~" + orgID + "~" + roleID;

        txtValue.Attributes.Add("onfocus", "javascript:ChecKINVSum();"); //onfocus
        //spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal(this.id,'" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "')");
        ATag.Attributes.Add("onmouseover", "this.style.cursor='pointer';");
        //Tag.Attributes.Add("onmouseout", "this.style.color='Red';");

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
        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'" + Formula + "');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    #endregion

    #region "Events"

    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        if (ViewState["test"] == null)
        {
            ViewState["isEdit"] = true;
        }
        Readonly = true;
    }
    public void setXmlValues(string xmlValues)
    {
        hdnXmlContent.Value = xmlValues;
    }

    #endregion

    #region "Methods"
    public void setPanicXmlValues(string xmlValues)
    {
        hdnPanicXmlContent.Value = xmlValues;
    }
    private void EnableMedicalRemarksForLabTech()
    {
        if (labTechEditMedRem == "N" && currentRoleName == RoleHelper.LabTech)
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
        }
    }
    public void BatchWise(bool IsBatchWise)
    {
        bool isInterpretationRange = false;

        hdnAutoAuthCount.Value = WebConfigurationManager.AppSettings["AutoAuthorizationCount"];
        if (!string.IsNullOrEmpty(hdnXmlContent.Value) && LabUtil.TryParseXml(hdnXmlContent.Value) && string.IsNullOrEmpty(DeviceID))
        {
            XElement xe = XElement.Parse(hdnXmlContent.Value);
            var Range = from range in xe.Elements("resultsinterpretationrange").Elements("property")
                        select range;
            if (Range != null && Range.Count() > 0)
            {
                isInterpretationRange = true;
            }
        }
        if (IsBatchWise)
        {
            /* BEGIN | NA | Sabari | 20190508 | Created | BulkEnterResult */
	if (Session["Action"] != null)
	{
                if (Session["Action"].ToString() == "Approvel" || Session["Action"].ToString() == "Validate" || Session["Action"].ToString() == "EnterResult")
            {
                tdCheckbox.Style.Add("display", "table-cell");
                
                //tdQcCheck.Visible = true;


            }
           
            else
            {

               // tdQcCheck.Visible = false;
                tdCheckbox.Style.Add("display", "none");
            }
	}
            /* END | NA | Sabari | 20190508 | Created | BulkEnterResult */
            
           
            tdPatientDetails.Style.Add("display", "table-cell");
            tdInvName.Style.Add("display", "table-cell");

            if (ResultValueType == "NTS")
            {
                if (isInterpretationRange)
                {
                    txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID
                        + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');ValidateInterpretationRange(" + PatternID + ",'" + txtValue.ClientID + "','','"
                        + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','"
                        + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID
                        + "','" + Age + "','" + Sex + "');ReplaceNumberWithCommas('" + txtValue.ClientID
                        + "');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
                }
                else
                {
                    txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID
                        + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');validateResult('" + txtValue.ClientID + "','" + hdnXmlContent.ClientID + "','"
                        + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID
                        + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','" + Age + "','" + Sex
                        + "');ReplaceNumberWithCommas('" + txtValue.ClientID + "');CallAllReferenceRangeValidate();setCompletedStatus('"
                        + GroupName + "',this.id,'" + IsAutoValidate + "');");
                }
            }
            else
            {
                if (isInterpretationRange)
                {
                    txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID
                        + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');ValidateInterpretationRange(" + PatternID + ",'" + txtValue.ClientID + "','','"
                        + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID
                        + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','" + Age + "','" + Sex
                        + "');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
                }
                else
                {
                    if (isSpecialValue)
                    {
                        txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID
                            + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');validateResult('" + txtValue.ClientID + "','" + hdnXmlContent.ClientID + "','"
                            + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','"
                            + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','" + Age + "','"
                            + Sex + "');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
                    }
                    else
                    {
                        txtValue.Attributes.Add("onblur", "ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');validateResult('" + txtValue.ClientID + "','"
                            + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','"
                            + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUnit.ClientID
                            + "','" + Age + "','" + Sex + "');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName
                            + "',this.id,'" + IsAutoValidate + "');");
                    }
                }
            }
            spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','"
                + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','"
                + lblName.ClientID + "','" + lblUnit.ClientID + "');");
            validateResultParameter = txtValue.ClientID + "," + hdnXmlContent.ClientID + ","
                + hdnPanicXmlContent.ClientID + "," + DecimalPlaces + "," + txtIsAbnormal.ClientID + ","
                + AutoApproveLoginID + "," + lblName.ClientID + "," + lblUnit.ClientID + "," + Age + "," + Sex;
        }
        else
        {
            lblName.Attributes.Add("onclick", "javascript:changeTestName(this.id);");
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
            if (ResultValueType == "NTS")
            {
                if (isInterpretationRange)
                {
                    txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','"
                        + hdnResultValue.ClientID + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');ValidateInterpretationRange(" + PatternID + ",'"
                        + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','"
                        + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID
                        + "','" + lblUnit.ClientID + "','','');ReplaceNumberWithCommas('" + txtValue.ClientID
                        + "');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
                }
                else
                {
                    txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID
                        + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');validateResult('" + txtValue.ClientID + "','" + hdnXmlContent.ClientID + "','"
                        + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID
                        + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "','','');ReplaceNumberWithCommas('" + txtValue.ClientID
                        + "');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
                }
            }
            else
            {
                if (isInterpretationRange)
                {
                    txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','"
                        + hdnResultValue.ClientID + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');ValidateInterpretationRange(" + PatternID + ",'"
                        + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','"
                        + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','"
                        + lblUnit.ClientID + "','','');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'"
                        + IsAutoValidate + "');");
                }
                else
                {
                    if (isSpecialValue)
                    {
                        txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','"
                            + hdnResultValue.ClientID + "');ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');validateResult('" + txtValue.ClientID
                            + "','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','"
                            + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','"
                            + lblUnit.ClientID + "','','');CallAllReferenceRangeValidate();setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
                    }
                    else
                    {
                        txtValue.Attributes.Add("onblur", "ChecKGroupSum(this.id);CheckDeltaValidate('" + txtValue.ClientID + "','" + lbldeltarange.ClientID + "','" + adeltastatus.ClientID + "');validateResult('" + txtValue.ClientID + "','"
                            + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','"
                            + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','"
                            + lblUnit.ClientID + "','','');CallAllReferenceRangeValidate();setCompletedStatus('"
                            + GroupName + "',this.id,'" + IsAutoValidate + "');chkAutoAuthorization('" + PatientVisitID + "','" + Convert.ToString(POrgid)
                            + "','" + hdnAutoAuthCount.Value + "','" + ControlID + "','" + this.ID + "');");
                        //txtValue.Attributes.Add("onfocusout", "chkAutoAuthorization('" + PatientVisitID + "','" + Convert.ToString(POrgid)
                        //    + "','" + hdnAutoAuthCount.Value + "','" + ControlID + "','" + this.ID + "');");
                    }
                }
            }
            spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','"
                + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','"
                + lblName.ClientID + "','" + lblUnit.ClientID + "');");
            validateResultParameter = txtValue.ClientID + "," + hdnXmlContent.ClientID + "," + hdnPanicXmlContent.ClientID + ","
                + DecimalPlaces + "," + txtIsAbnormal.ClientID + "," + AutoApproveLoginID + "," + lblName.ClientID + "," + lblUnit.ClientID
                + "," + Age + "," + Sex;
        }
    }
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        try
        {
            if (lstStatus.Count > 0)
            {
                ddlstatus.DataSource = lstStatus;
                ddlstatus.DataTextField = "DisplayText";
                ddlstatus.DataValueField = "StatuswithID";
                ddlstatus.DataBind();
                string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
                if (ddlstatus.Items.FindByValue(SelString) != null)
                {
                    ddlstatus.SelectedValue = SelString;
                }
                //else if (ddlstatus.Items.FindByValue("Validate_1") != null)
                //{
                //    ddlstatus.SelectedValue  = "Validate_1";
                //} 
            }
            else
            {
                ddlstatus.DataSource = null;
                ddlstatus.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading biopattern1 status dropdown", ex);
        }
    }
    public string GetInvStatusReason()
    {
        return (ddlStatusReason.SelectedValue);
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
    public void loadMethod(List<InvestigationValues> lstBulkData)
    {
        foreach (InvestigationValues values in lstBulkData)
        {
            txtValue.Text = values.Value;
            break;
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
    public string GetValidationForComputedField()
    {
        string result = string.Empty;
        try
        {
            result = "validateResult('" + txtValue.ClientID + "','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "');";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while setting validation for computed field", ex);
        }
        return result;
    }
    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        txtValue.Attributes.Add("readOnly", "true");
        txtRefRange.Attributes.Add("readOnly", "true");
       // txtReason.Attributes.Add("readOnly", "true");
        //txtMedRemarks.Attributes.Add("readOnly", "true");
        txtDilution.Attributes.Add("readOnly", "true");
    }
    public InvestigationValues GetResult(long VID)
    {
        InvestigationValues obj = new InvestigationValues();
        String[] status;
        //Commented By Arivalagan while Result is empty it should allow 
        if (txtValue.Text != "")
        {
            obj.Name = lblName.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.Value = txtValue.Text;
            obj.UOMCode = lblUnit.Text;
            long Approvedby = 0;
            if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
            {
                Int64.TryParse(hdnOpinionUser.Value, out Approvedby);
            }
            //Pinv.LoginID = Approvedby ?? Approvedby,LoginID;
            if (Approvedby != null && Approvedby > 0)
            {
                obj.CreatedBy = Approvedby;
            }
            else
            {
                obj.CreatedBy = lID;
            }
            obj.GroupID = groupID;
            obj.GroupName = GroupName;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.Dilution = txtDilution.Text;
            obj.UID = UID;
            obj.DeviceID = DeviceID;
            obj.DeviceValue = DeviceValue;
            obj.DeviceActualValue = DeviceActualValue;
            obj.DeviceErrorCode = DeviceErrorCode;
            // obj.ConvValue = Convert.ToString(Math.Round((Convert.ToDecimal(txtValue.Text) * ConvFactorvalue), convFactorDecimalPt));
            obj.ConvUOMCode = ConvUOMCode;
            //--Added By Murali---//

            string Str = txtValue.Text.Trim();
            double Num;
            bool isNum = double.TryParse(Str, out Num);

            if (isNum)
            {
                obj.ConvValue = Convert.ToString(Math.Round((Convert.ToDecimal(txtValue.Text) * ConvFactorvalue), convFactorDecimalPt));
            }
            else
            {
                obj.ConvValue = "0";
            }
            //---Murali--//
        }
        return obj;
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
        //added for refrence range - begin
        //Pinv.ReferenceRange = hdnXmlContent.Value;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        //added for refrence range - ENDS
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);//OrgID;
        Pinv.AutoApproveLoginID = AutoApproveLoginID;
        Pinv.AccessionNumber = AccessionNumber;
        Pinv.UID = UID;
        Pinv.LabNo = LabNo;

        Pinv.QCData = QCData;
        Pinv.IsDeltaCheck = IsDeltaCheck;
        Pinv.DeltaLowerLimit = DeltaLowerLimit;
        Pinv.DeltaHigherLimit = DeltaHigherLimit;
        Pinv.IsAutoCertification = IsAutoCertification;


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
        Pinv.GroupID = groupID;
        Pinv.IsAbnormal = IsAbnormal;

        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
        //Pinv.InvStatusReason = (ddlStatusReason.SelectedValue == "-----Select-----" ? 0 : ddlStatusReason.SelectedValue); 
        Pinv.GroupName = RefAppendString;
        Pinv.ConvReferenceRange = ConReferenceRange;
        Pinv.PrintableRange = hdnPrintableRange.Value.Trim().Replace("\n", "<br>");
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        if (hdnMedicalRemarksID.Value != null && hdnMedicalRemarksID.Value != "")
        {
            Pinv.MedicalRemarksID = Convert.ToInt64(hdnMedicalRemarksID.Value);
        }
        return Pinv;
    }
    public void setAttributes(string id)
    {
        //txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        //txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        //txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        //txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        txtValue.Text = lEditInvestigation[0].Value;
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
        lblPatternClassName.Text = "Investigation_checkInvest";
        if (!String.IsNullOrEmpty(lEditInvestigation[0].DeviceID))
        {
            DeviceID = lEditInvestigation[0].DeviceID;
            DeviceActualValue = lEditInvestigation[0].DeviceActualValue;
            DeviceValue = lEditInvestigation[0].DeviceValue;
        }
    }

    #endregion

}
