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

public partial class Investigation_BioPattern4 : BaseControl
{
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private int i = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private string age = string.Empty;
    private string sex = string.Empty;

    private string qCData = string.Empty;

    private string patientName = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        //code added for reference range - begin
        ddlData.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
        ddlType.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
        ddlResult.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','','" + hdnXmlContent.ClientID + "','')");
        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        //code added for reference range - end
    }

    private long autoApproveLoginID = -1;
    public long AutoApproveLoginID
    {
        get { return autoApproveLoginID; }
        set { autoApproveLoginID = value; }
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
    public string Dilution
    {
        get { return txtDilution.Text; }
        set
        {
            txtDilution.Text = value;
        }
    }


    /// <summary>
    /// Set the UOM value
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
        }
    }
    public string Age
    {
        get { return age; }
        set
        {
            lblAge.Text = value;
        }
    }
    public string Sex
    {
        get { return sex; }
        set
        {
            lblSex.Text = value;
        }
    }

    public string QCData
    {
        get { return qCData; }
        set { qCData = value; }
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

    /// <summary>
    /// To get the textbox value
    /// </summary>
    public string Value
    {
        get { return result; }
        set { result = value; }
    }

    /// <summary>
    /// Property to set the maxlength for textbox
    /// </summary>
    public int Maxlength
    {
        get { return maxlength; }
        set
        {
            maxlength = value;
            txtResult.MaxLength = maxlength;
        }
    }
    private int groupID = 0;
    private string groupName = string.Empty;

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


    /// <summary>
    /// Method to populate dropdown list
    /// </summary>
    /// <param name="lstData"></param>
    public void LoadData(List<InvestigationValues> lstData)
    {
        for (i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "Source")
            {
                ddlData.Items.Add(lstData[i].Value);
            }
            else if (lstData[i].Name == "Type")
            {
                ddlType.Items.Add(lstData[i].Value);
            }
            else if (lstData[i].Name == "Result")
            {
                ddlResult.Items.Add(lstData[i].Value);
            }
        }
    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType.SelectedIndex == 0)
        {
            divHCGResult.Visible = true;
            divHCGQual.Visible = true;
        }
        else
        {
            divHCGResult.Visible = false;
            divHCGQual.Visible = true;
        }
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

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;


        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = "Source";
        obj.Value = ddlData.SelectedItem.Text;
        obj.PatientVisitID = VID;
        obj.UOMCode = lblUOM.Text;
        obj.Orgid = OrgID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.CreatedBy = LID;
        obj.Status = ddlstatus.SelectedItem.Text;
        ddlstatus.DataTextField = "DisplayText";
        ddlstatus.DataValueField = "StatuswithID";
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        obj.Dilution = txtDilution.Text;
        obj.UID = UID;
        lstInvestigationVal.Add(obj);

        if (divHCGResult.Visible)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Result";
            obj.Value = txtResult.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUOM.Text;
            obj.Orgid = OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Status = ddlstatus.SelectedItem.Text;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.Dilution = txtDilution.Text;
            obj.UID = UID;
            lstInvestigationVal.Add(obj);

        }


        if (divHCGQual.Visible)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Result";
            obj.Value = ddlResult.SelectedItem.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUOM.Text;
            obj.Orgid = OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Status = ddlstatus.SelectedItem.Text;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.Dilution = txtDilution.Text;
            obj.UID = UID;
            lstInvestigationVal.Add(obj);
        }

        return lstInvestigationVal;

    }


    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.Status = ddlstatus.SelectedItem.Text;
        //added for refrence range - begin
        //Pinv.ReferenceRange = hdnXmlContent.Value;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        //added for refrence range - ends
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = OrgID;
        Pinv.AccessionNumber = AccessionNumber;
        Pinv.UID = UID;

        Pinv.QCData = QCData;

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
        Pinv.IsAbnormal = IsAbnormal;
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
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
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;

            ddlData.Enabled = value;
            ddlType.Enabled = value;
            //txtResult.Enabled = value;
            txtResult.ReadOnly = value == false ? true : false;

            lnkEdit.Visible = true;

        }
    }
    public void BatchWise(bool IsBatchWise)
    {
        if (IsBatchWise)
        {
            tdPatientDetails.Style.Add("display", "table-cell");
            tdInvName.Style.Add("display", "none");
        }
        else
        {
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
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
        txtMedRemarks.Attributes.Add("readOnly", "true");
        txtResult.Attributes.Add("readOnly", "true");
        txtDilution.Attributes.Add("readOnly", "true");

        ddlData.Enabled = true;
        ddlType.Enabled = true;        

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
                txtResult.Attributes.Add("onkeydown", "return validatenumberOnly(event,'" + txtResult.ClientID.ToString() + "');");
            }
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
                //txtResult.Attributes.Add("onkeyup", "return setCompletedStatusValueType(event,'" + GroupName + "','" + txtResult.ClientID.ToString() + "','" + DecimalPlaces + "','" + IsAutoValidate + "');");
								txtResult.Attributes.Add("onkeyup", "return setCompletedStatusValueType(event,'" + GroupName + "','" + txtResult.ClientID.ToString() + "','" + IsAutoValidate + "');");
            }
            else
            {
                txtResult.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id,'" + IsAutoValidate + "');");
            }
            txtResult.Attributes.Add("onblur", "javascript:validateResult('" + txtResult.ClientID + "','" + hdnXmlContent.ClientID + "','','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "');");
        }
    }

    private string isAbnormal = string.Empty;
    public string IsAbnormal
    {
        get { return isAbnormal; }
        set
        {
            isAbnormal = value;
            txtResult.Font.Bold = true;
            txtResult.ForeColor = System.Drawing.Color.Black;
            if (isAbnormal == "A")
            {
                txtResult.Attributes.Add("style", "background-color:yellow;");
                txtIsAbnormal.Attributes.Add("style", "background-color:yellow;");
            }
            if (isAbnormal == "L")
            {
                txtResult.Attributes.Add("style", "background-color:LightPink;");
                txtIsAbnormal.Attributes.Add("style", "background-color:LightPink;");
            }
            if (isAbnormal == "P")
            {
                txtResult.Attributes.Add("style", "background-color:red;");
                txtIsAbnormal.Attributes.Add("style", "background-color:red;");
            }
        }
    }
    private string isAutoAuthorize = string.Empty;
    public string IsAutoAuthorize
    {
        get { return isAutoAuthorize; }
        set
        {
            isAutoAuthorize = value;
            txtResult.ForeColor = System.Drawing.Color.Black;
            if (isAutoAuthorize == "Y")
            {
                //txtResult.Attributes.Add("style", "background-color:LightGreen;");
            }

        }
    }
    private string isAutoApproveQueue = string.Empty;
    public string IsAutoApproveQueue
    {
        get { return isAutoApproveQueue; }
        set { isAutoApproveQueue = value; }
    }
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }
}
