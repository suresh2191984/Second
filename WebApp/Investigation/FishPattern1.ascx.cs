using System;
using System.Data;
using System.Collections.Generic;
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
using Attune.Podium.Common;
using System.Linq;
using Attune.Solution.DAL;
using System.Security.Cryptography;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;

public partial class Investigation_FishPattern1 : BaseControl
{
    public Investigation_FishPattern1()
        : base("Investigation_FishPattern1_ascx")
    {
    }
    private string name = string.Empty;
    private string formula = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string isAbnormal = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
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
    //List<InvResultTemplate> lstInvResultTemplate;
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
            lblPatternClassName.Text = "Investigation_checkInvest";


        }
        showbarcodeno = GetConfigValue("Showbarcodeno",Convert.ToInt32(pOrgid));
        if (showbarcodeno == "Y")
        {
            lblbarcodeno.Style.Add("display", "table-cell");
        }
        else
        {
            lblbarcodeno.Style.Add("display", "none");
        }
        tdFish.Visible = true;
        if (!string.IsNullOrEmpty(ControlID))
        {
            //LoadDeafultLegend(Convert.ToInt32(ControlID));
            //if (lstInvResultTemplate.Count > 0)
            //{
            //    txtDescription.Text = lstInvResultTemplate[0].ResultValues;
            //}

            txtValue.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
        }
                ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
				//ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'" + Formula + "');ShowStatusReason(this.id);");
				ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
				ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        AutoCompleteExtender2.ContextKey = ControlID + "~" + "INV" + "~" + orgID + "~" + roleID;
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
        //ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtDescription');ChangeGroupStatus('" + GroupName + "',this.id);ShowStatusReason(this.id);");
        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

    }
    public void loadMethod(List<InvestigationValues> lstBulkData)
    {
     //   int count = 0;
        for (int i = 0; i < lstBulkData.Count; i++)
        {
            txtValue.Text = lstBulkData[i].Value;
           break;
        }     
         
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

    //public void LoadDeafultLegend(long invid)
    //{
    //    try
    //    {
    //        long returncode = -1;
    //        Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
    //        lstInvResultTemplate = new List<InvResultTemplate>();
    //        returncode = InvestigationBL.GetSignalPatterns(invid, OrgID, out lstInvResultTemplate);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while LoadDeafultLegend ", ex);
    //    }
    //}
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
            CLogger.LogError("Error while loading fishpattern1 status dropdown", ex);
        }
    }
    public InvestigationValues GetResult(long VID)
    {

        InvestigationValues InVestVal = new InvestigationValues();
        //List<InvestigationValues> lstVal = new List<InvestigationValues>();s
        String[] status;
        //Commented By Arivalagan while Result is empty it should be allow
        if (txtValue.Text != "")
        {
            InVestVal = new InvestigationValues();
            InVestVal.Name = lblName.Text;
            status = ddlstatus.SelectedValue.Split('_');
            InVestVal.Status = status[0].ToString();
            InVestVal.InvestigationID = Convert.ToInt32(ControlID);
            InVestVal.Value = txtValue.Text.ToString();
            InVestVal.PatientVisitID = VID;
            InVestVal.GroupID = GroupID;
            InVestVal.GroupName = GroupName;
            InVestVal.Orgid = orgID;
            InVestVal.CreatedBy = lID;
            InVestVal.UID = UID;
            //lstVal.Add(InVestVal);
        }

        return InVestVal;

    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        string[] status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.OrgID = Convert.ToInt32(orgID);//OrgID;        
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
        Pinv.GroupID = groupID;
        Pinv.UID = UID;
        Pinv.LabNo = LabNo;
        Pinv.AccessionNumber = AccessionNumber;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        return Pinv;
    }
    public void LoadDataForComments(List<InvestigationValues> lEditInvestigation)
    {
        if (lEditInvestigation.Count > 0)
        {
            lblName.Text = lEditInvestigation[0].Name;
            txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
        }
    }
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        if (lEditInvestigation.Count > 0)
        {
            txtValue.Text = lEditInvestigation[0].Value;
            lblName.Text = lEditInvestigation[0].Name;
            txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
        }
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(orgID);     

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
                //txtDescription.Attributes.Add("onblur", "ChecKGroupSum(this.id);validateResult('" + txtDescription.ClientID + "','" + "','"  + "','" + DecimalPlaces + "','"  + "','"   + "','" + lblUnit.ClientID + "','" + Age + "','"  + "');");
            }
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
   bool readOnly = false;
    public bool Readonly
    {
        set
        {
            txtMedRemarks.ReadOnly = value == false ? true : false;
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
    private string currentRoleName = string.Empty;
    public string CurrentRoleName
    {
        get { return currentRoleName; }
        set
        {
            currentRoleName = value;
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
        if (labTechEditMedRem == "N" && currentRoleName == RoleHelper.LabTech)
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
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

    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }


    


    private int groupID = 0;
    private string groupName = string.Empty;

    public int GroupID
    {
        get { return groupID; }
        set
        {
            hdnGroupID.Value = Convert.ToString(value);
            groupID = value;
        }
    }
    public void BatchWise(bool IsBatchWise)
    {
        if (IsBatchWise)
        {
            tdPatientDetails.Style.Add("display", "table-cell");
            tdInvName.Style.Add("display", "table-cell");
            if (ResultValueType == "NTS")
            {
                txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID + "');ChecKGroupSum(this.id);ReplaceNumberWithCommas('" + txtValue.ClientID + "');");
            }
            else
            {
                txtValue.Attributes.Add("onblur", "ChecKGroupSum(this.id);");
            }
            //spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "')");
            validateResultParameter = txtValue.ClientID + "," + "," + "," + "," + "," + DecimalPlaces + "," + "" + "," + "," + "," + lblName.ClientID + "," + lblUnit.ClientID + "," + Age + "," + ",";
        }
        else
        {
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
            if (ResultValueType == "NTS")
            {
                txtValue.Attributes.Add("onblur", "SaveResultValue('" + txtValue.ClientID + "','" + hdnResultValue.ClientID + "');ChecKGroupSum(this.id);ReplaceNumberWithCommas('" + txtValue.ClientID + "');");
            }
            else
            {
                txtValue.Attributes.Add("onblur", "ChecKGroupSum(this.id);");
            }
            //spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtValue.ClientID + "','','" + hdnXmlContent.ClientID + "','" + hdnPanicXmlContent.ClientID + "','" + lblName.ClientID + "','" + lblUnit.ClientID + "')");
            validateResultParameter = txtValue.ClientID + "," + "," + "," + "," + "," + DecimalPlaces + "," + "," + "," + "," + "," + lblName.ClientID + "," + lblUnit.ClientID + ",,";
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

    public string GroupName
    {
        get { return groupName; }
        set
        {
            hdnGroupName.Value = value;
            groupName = value;
        }
    }
	private string validateResultParameter = string.Empty;
    public string ValidateResultParameter
    {
        get { return validateResultParameter; }
        set { validateResultParameter = value; }
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
                txtValue.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
            }
            
        }
    }
    private string age = string.Empty;
    private string sex = string.Empty;
    private string patientName = string.Empty;
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
    private string visitNumber = string.Empty;
    public string VisitNumber
    {
        get { return visitNumber; }
        set
        {
            lnkPDFReportPreviewer.Attributes.Add("onclick", "ShowReportPreview('" + PatientVisitID + "','" + roleID + "','all');return false;");
            lnkPDFReportPreviewer.Text = value;
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
    private bool isDeltaCheckWant = false;
    public bool IsDeltaCheckWant
    {
        get { return isDeltaCheckWant; }
        set { isDeltaCheckWant = value; }
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
    public long ClientID
    {
        set
        {
            hdnClientID.Value = Convert.ToString(value);
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
    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUnit.Text = uom;
        }
    }
}
