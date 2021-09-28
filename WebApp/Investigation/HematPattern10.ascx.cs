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
public partial class Investigation_HematPattern10 : BaseControl
{
    private string name = string.Empty;
    private string result = string.Empty;
    private string uom = string.Empty;
    private string id = string.Empty;
    private string isi = string.Empty;
    private int i = 0;
    private int groupID = 0;
    private string groupName = string.Empty;

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
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        ATag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ATag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ADeltaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ADeltaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        txtControl.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtPatient.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtINR.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");


        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
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
    /// Assign the ISI value to hidden field
    /// </summary>
    /// <param name="VID"></param>
    /// <returns></returns>
    /// 
    public string ISI
    {
        get { return isi; }
        set
        {
            isi = value;
            hidISI.Value = isi;
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


    public void loadData(List<InvestigationValues> lstValue)
    {
        //if (lstValue.Count > 0)
        //{
        //    Dshow.Visible = false;
        //}
        //else
        //{
        //    //txtPatient.Attributes.Add("onkeyup", "calculate('hidISI')");
        //}
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        if (txtControl.Text != "" && txtPatient.Text != "")
        {

            if (Dshow.Visible)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblName.Text + "-" + lblControl.Text;
                obj.Value = txtControl.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.UOMCode = lblmins.Text;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 1;
                obj.Dilution = txtDilution.Text;
                lstInvestigationVal.Add(obj);

                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblName.Text + "-" + lblPatient.Text;
                obj.Value = txtPatient.Text;
                obj.PatientVisitID = VID;
                obj.UOMCode = Label1.Text;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 2;
                obj.Dilution = txtDilution.Text;
                lstInvestigationVal.Add(obj);


                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = "INR";
                obj.Value = txtINR.Text;
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
                obj.SequenceNo = 3;
                obj.Dilution = txtDilution.Text;
                lstInvestigationVal.Add(obj);

            }
            else
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblName.Text + "-" + lblControl.Text;
                obj.Value = txtControl.Text;
                obj.UOMCode = lblmins.Text;
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
                obj.Dilution = txtDilution.Text;
                lstInvestigationVal.Add(obj);

                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = lblName.Text + "-" + lblPatient.Text;
                obj.Value = txtPatient.Text;
                obj.UOMCode = Label1.Text;
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
                obj.Dilution = txtDilution.Text;
                lstInvestigationVal.Add(obj);
            }
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
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);//OrgID;
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
            //txtControl.Enabled = value;
            //txtPatient.Enabled = value;

            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtControl.ReadOnly = value == false ? true : false;
            txtPatient.ReadOnly = value == false ? true : false;

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
    public void LoadDataForEdit(List<InvestigationValues> lstValues)
    {
        //lblName.Text = lstValues[0].Name;
        //Prothrombin Time(PT) -Control PT
        //Prothrombin Time(PT) -Patient PT
        for (int i = 0; i < lstValues.Count; i++)
        {
            if (lstValues[i].Name.Contains("-Control PT"))
            {
                txtControl.Text = lstValues[i].Value != string.Empty ? lstValues[i].Value : " ";
            }
            else if (lstValues[i].Name.Contains("-Patient PT"))
            {
                txtPatient.Text = lstValues[i].Value != string.Empty ? lstValues[i].Value : " ";
            }
        }
        txtReason.Text = lstValues[0].Reason;
        txtMedRemarks.Text = lstValues[0].MedicalRemarks;
        txtDilution.Text = lstValues[0].Dilution;

        lblPVisitID.Text = Convert.ToString(PatientVisitID);
        lblPatternID.Text = Convert.ToString(PatternID);
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(POrgid);
        lblPatternClassName.Text = "Investigation_HematPattern10";
        //Delta CheckUp 
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "block");
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
        txtControl.Attributes.Add("readOnly", "true");
        txtPatient.Attributes.Add("readOnly", "true");
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
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }

}
