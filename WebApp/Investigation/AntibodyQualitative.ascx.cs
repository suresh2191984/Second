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
public partial class Investigation_AntibodyQualitative : BaseControl
{
    public Investigation_AntibodyQualitative()
        : base("Investigation_AntibodyQualitative_ascx")
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
    //code added on 23-07-2010 QRM - Completed

    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        //code added on 23-07-2010 QRM - Started

        hlnkAdd.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlData.ClientID + "','Result')");
        ddlData.Attributes.Add("onchange", "setCompletedStatus('" + GroupName + "',this.id);onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','');appendDDLHdn('" + ddlData.ClientID + "','" + hdnDDL.ClientID + "')");
        hlnkAdd.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','')");
        txtRefRange.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");

        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }

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

    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUOM.Text = uom;
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
        ddlData.Items.Insert(0, new ListItem("Select", "0"));
        ddlData.Items.FindByText("Select").Selected = true;

        for (i = 0; i < lstData.Count; i++)
        {
            ddlData.Items.Add(lstData[i].Value);
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
        if ((hdnDDL.Value != "Select")||(ddlData.SelectedItem.Text != "Select"))
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text + "-" + lblQualitativeResult.Text;

            hdnDDL.Value = hdnDDL.Value == "" ? ddlData.SelectedItem.Text : hdnDDL.Value;
            obj.Value = hdnDDL.Value;
            obj.PatientVisitID = VID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupID = GroupID;
            obj.GroupName = groupName;
            obj.CreatedBy = LID;
            //obj.UOMCode = lblUOM.Text;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }
       
        if (txtResult.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text + "-" + lblQuantitativeResult.Text;
            obj.PatientVisitID = VID;
            obj.Value = txtResult.Text.Trim();
            obj.UOMCode = lblUOM.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupID = GroupID;
            obj.GroupName = groupName;
            obj.CreatedBy = LID;
            obj.PatientVisitID = VID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
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

    string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
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
        //added for refrence range - ends
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text; //Inv Remarks
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
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        Pinv.IsAbnormal = IsAbnormal;
        Pinv.AccessionNumber = AccessionNumber;
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
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        //lblName.Text = lEditInvestigation[0].Name.Split('-')[0];
        foreach (var item in lEditInvestigation)
        {
            if (item.Name.Contains(lblQualitativeResult.Text))
            {
                this.ddlData.ClearSelection();
                this.ddlData.Items.FindByText(item.Value.Trim()).Selected = true;
            }
            else if (item.Name.Contains(lblQuantitativeResult.Text))
            {
                this.txtResult.Text = item.Value;
            }
        }
        txtReason.Text = lEditInvestigation[0].Reason;
        txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            //txtResult.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtResult.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;

            ddlData.Enabled = value;
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
        ddlData.Enabled = true;
         
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
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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
            txtResult.Attributes.Add("onblur", "javascript:validateResult('" + txtResult.ClientID + "','" + hdnXmlContent.ClientID + "','','" + DecimalPlaces + "','" + spanIsAbnormal.ClientID + "','" + AutoApproveLoginID + "','" + lblName.ClientID + "','" + lblUOM.ClientID + "','" + Age + "','" + Sex + "');");
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
            if (!String.IsNullOrEmpty(value) && value.Trim() == "NU")
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
