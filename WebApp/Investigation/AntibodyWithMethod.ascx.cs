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
public partial class Investigation_AntibodyWithMethod : BaseControl
{
    public Investigation_AntibodyWithMethod()
        : base("Investigation_AntibodyWithMethod_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private int i = 0;
    private long accessionNumber = 0;

    //code added on 23-07-2010 QRM - Started
    Investigation_BL InvestigationBL;
    protected override void Render(HtmlTextWriter writer)
    {

        long returnCode = -1;
        List<InvQualitativeResultMaster> lstQualitativeResult = new List<InvQualitativeResultMaster>();
        returnCode = InvestigationBL.GetInvQualitativeResultMaster(out lstQualitativeResult);


        for (int i = 0; i < lstQualitativeResult.Count; i++)
        {
            Page.ClientScript.RegisterForEventValidation(ddlData.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
        }
        base.Render(writer);

    }
    
    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        hlnkAdd.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlData.ClientID + "','Result')");
        ddlData.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','');appendDDLHdn('" + ddlData.ClientID + "','" + hdnDDL.ClientID + "')");
        hlnkAdd.Attributes.Add("onmouseover", "this.style.cursor='hand'");

        ADeltaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ADeltaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        txtRefRange.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','')");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    //code added on 23-07-2010 QRM - Completed
    /// <summary>
    /// Get and Set the Investigation Name
    /// </summary>
    /// 
    private long autoApproveLoginID = -1;
    public long AutoApproveLoginID
    {
        get { return autoApproveLoginID; }
        set { autoApproveLoginID = value; }
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
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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

    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUOM.Text = uom;
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
        hdnddlData1.Value = "";
        ddlData.Items.Insert(0, new ListItem("Select", "0"));
        ddlData.Items.FindByText("Select").Selected = true;
        
        for (i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "Result")
            {
                ddlData.Items.Add(lstData[i].Value);
                hdnddlData1.Value += lstData[i].Value + "~";
            }
            else if(lstData[i].Name == "Text")
            {
                if (!string.IsNullOrEmpty(lstData[i].Value))
                {
                    lblMethodName.Text = lstData[i].Value;
                }
            }
            
        }

    }


    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        //code modified on 23-07-2010 QRM
        //hdnDDL.Value = hdnDDL.Value == "" ? ddlData.SelectedItem.Text : hdnDDL.Value;
        hdnDDL.Value = ((hdnDDL.Value == "") || (hdnDDL.Value == "0")) ? ddlData.SelectedItem.Text : hdnDDL.Value;
        if ((hdnDDL.Value != "Select") || ((ddlData.SelectedItem.Text != "") && (ddlData.SelectedItem.Text != "Select")))
        {

            if (txtResult.Text != string.Empty)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                if (obj.InvestigationID == 4730)
                {
                    obj.Name = "Specimen";
                }
                else { obj.Name = lblMethodName.Text; }
                obj.Value = txtResult.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.UOMCode = lblUOM.Text;
                obj.GroupID = groupID;
                obj.GroupName = GroupName;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 2;
                obj.Dilution = txtDilution.Text;
                lstInvestigationVal.Add(obj);
            }

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            hdnDDL.Value = hdnDDL.Value == "" ? ddlData.SelectedItem.Text : hdnDDL.Value;
            obj.Value = hdnDDL.Value;//+ " " + txtResult.Text + " Method";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUOM.Text;
            obj.GroupID = groupID;
            obj.GroupName = GroupName;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 1;
            obj.Dilution = txtDilution.Text;
            lstInvestigationVal.Add(obj);

           

            
        }
            
        return lstInvestigationVal;
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

    public PatientInvestigation GetInvestigations(long Vid)
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        //added for refrence range - begin
        //Pinv.ReferenceRange = hdnXmlContent.Value;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        //added for refrence range - ends
        Pinv.MethodName = txtResult.Text;
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text; //Inv Remarks
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        Pinv.IsAbnormal = IsAbnormal;
        //InvRemarks
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        if (ddlStatusReason.Items.Count > 0)
        {
            Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == strSelect.Trim() ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
        }
        long LoginID = 0;

        if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
        {
            Int64.TryParse(hdnOpinionUser.Value, out LoginID);
        }
        Pinv.LoginID = LoginID;
        Pinv.AccessionNumber = AccessionNumber;
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

    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        lblName.Text = lEditInvestigation[0].Name;
        ddlData.ClearSelection();
        ddlData.Items.FindByText(lEditInvestigation[0].Value.Split()[0]).Selected = true;
        txtResult.Text = lEditInvestigation[1].Value;
        txtReason.Text = lEditInvestigation[0].Reason;
        txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks; //Inv Remarks
        txtDilution.Text = lEditInvestigation[0].Dilution;

        lblPVisitID.Text = Convert.ToString(PatientVisitID);
        lblPatternID.Text = Convert.ToString(PatternID);
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(POrgid);
        lblPatternClassName.Text = "Investigation_AntibodyWithMethod";
        //Delta CheckUp 
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "table-cell");
        }

    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            ddlData.Enabled = value;
            //txtResult.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtResult.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false; //Inv Remarks

            lnkEdit.Visible = true;

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
        txtResult.Attributes.Add("readOnly", "true");
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtDilution.Attributes.Add("readOnly", "true");

        ddlData.Enabled = true; 
        
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
    private string decimalPlaces;
    public string DecimalPlaces
    {
        get { return decimalPlaces; }
        set
        {
            decimalPlaces = value;
            if (!string.IsNullOrEmpty(value))
            {
                txtResult.Attributes.Add("onkeyup", "return setCompletedStatusValueType(event,'" + GroupName + "','" + txtResult.ClientID.ToString() + "','" + DecimalPlaces + "');");
            }
            else
            {
                txtResult.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            }
            txtResult.Attributes.Add("onblur", "javascript:validateResult('" + txtResult.ClientID + "','" + hdnXmlContent.ClientID + "','','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUOM.ClientID + "','" + Age + "','" + Sex + "');");
        }
    }
    private string sex = string.Empty;
    public string Sex
    {
        get { return sex; }
        set { sex = value; }
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

    private string isAbnormal = string.Empty;
    public string IsAbnormal
    {
        get { return isAbnormal; }
        set
        {
            isAbnormal = value;
            txtResult.Font.Bold = true;
            txtResult.ForeColor = System.Drawing.Color.Black;
            ddlData.ForeColor = System.Drawing.Color.Black;
            if (isAbnormal == "A")
            {
                txtResult.Attributes.Add("style", "background-color:yellow;");
                ddlData.Attributes.Add("style", "background-color:yellow;");
                txtIsAbnormal.Attributes.Add("style", "background-color:yellow;");
            }
            if (isAbnormal == "L")
            {
                txtResult.Attributes.Add("style", "background-color:LightPink;");
                ddlData.Attributes.Add("style", "background-color:LightPink;");
                txtIsAbnormal.Attributes.Add("style", "background-color:LightPink;");
            }
            if (isAbnormal == "P")
            {
                txtResult.Attributes.Add("style", "background-color:red;");
                ddlData.Attributes.Add("style", "background-color:red;");
                txtIsAbnormal.Attributes.Add("style", "background-color:red;");
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
}
