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
public partial class Investigation_HematPattern7 : BaseControl
{
    private string name = string.Empty;
    private string result = string.Empty;
    private string uom = string.Empty;
    private string id = string.Empty;
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

        rdolist.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        ddlShow.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        chkName1.Attributes.Add("onclick", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        chkName2.Attributes.Add("onclick", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        chkName3.Attributes.Add("onclick", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txtValue1.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtValue2.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtValue3.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
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
            if (lstData[i].Name == "Data")
            {
                rdolist.Items.Add(lstData[i].Value);
            }
            if (lstData[i].Name == "Result")
            {
                ddlShow.Items.Add(lstData[i].Value);
            }
            if (lstData[i].Name == "Value1")
            {
                chkName1.Visible = true;
                chkName1.Text = lstData[i].Value;
            }
            if (lstData[i].Name == "Value2")
            {
                chkName2.Visible = true;
                chkName2.Text = lstData[i].Value;
            }
            if (lstData[i].Name == "Value3")
            {
                chkName3.Visible = true;
                chkName3.Text = lstData[i].Value;
            }
        }
        rdolist.Items[0].Selected = true;
        txtReason.Text = lstData[0].Reason;
        txtMedRemarks.Text = lstData[0].MedicalRemarks;
    }


    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        if (ddlShow.Visible)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            obj.Value = rdolist.SelectedItem.Text;
            obj.PatientVisitID = VID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Result";
            obj.Value = ddlShow.SelectedItem.Text;
            obj.PatientVisitID = VID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);

            if (chkName1.Checked)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = chkName1.Text;
                obj.Value = "Present";
                obj.PatientVisitID = VID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);

                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = chkName1.Text;
                obj.Value = txtValue1.Text;
                obj.PatientVisitID = VID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
            }
            if (chkName2.Checked)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = chkName2.Text;
                obj.Value = "Present";
                obj.PatientVisitID = VID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);

                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = chkName2.Text;
                obj.Value = txtValue2.Text;
                obj.PatientVisitID = VID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);
            }
            if (chkName3.Checked)
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = chkName3.Text;
                obj.Value = "Present";
                obj.PatientVisitID = VID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                lstInvestigationVal.Add(obj);

                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.Name = chkName3.Text;
                obj.Value = txtValue3.Text;
                obj.PatientVisitID = VID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = OrgID;
                lstInvestigationVal.Add(obj);
            }
        }
        else
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            obj.Value = rdolist.SelectedItem.Text;
            obj.PatientVisitID = VID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        return lstInvestigationVal;

    }
    protected void rdolist_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdolist.Items[1].Selected)
        {
            ddlShow.Visible = true;
        }
        else
        {
            ddlShow.Visible = false;
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
        Pinv.OrgID = OrgID;
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
    
  
    protected void chkName1_CheckedChanged(object sender, EventArgs e)
    {
        if (chkName1.Checked)
        {           
            txtValue1.Visible = true;
        }
        else
        {
            txtValue1.Visible = false;
        }
    }
    protected void chkName2_CheckedChanged(object sender, EventArgs e)
    {
        if (chkName2.Checked)
        {
            txtValue2.Visible = true;
        }
        else
        {
            txtValue2.Visible = false;
        }
    }
    protected void chkName3_CheckedChanged(object sender, EventArgs e)
    {
        if (chkName3.Checked)
        {
            txtValue3.Visible = true;
        }
        else
        {
            txtValue3.Visible = false;
        }
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
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;

            //txtValue.Enabled = value;
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
      
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
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
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }
}
