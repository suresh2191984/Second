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
using System.Web.Script.Serialization;


public partial class Investigation_FungalSmearPattern : BaseControl
{
    public Investigation_FungalSmearPattern()
        : base("Investigation_FungalSmearPattern_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;

    private int groupID = 0;
    private string groupName = string.Empty;
    private long accessionNumber = 0;


    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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

    ///// <summary>
    ///// To get the textbox value
    ///// </summary>
    //public string Value
    //{
    //    get { return result; }
    //    set { result = value; }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
            AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

            ddlReportingStatus.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            ddlSmearFindings.Attributes.Add("onchange", "javascript:ddlOnchange(this.id);setCompletedStatus('" + GroupName + "',this.id);");
            txtSpecimen.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtSource.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtKohMount.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txt10KohMount.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtLPCB.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtResult.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtClinicalDiagnosis.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtClinicalNotes.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

            txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

            ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

            txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

            ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
            ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
            // trFungusPresent.Visible = false;
        }
        // ddlSmearFindings_SelectedIndexChanged(sender, e);
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

    public void LoadData(List<InvestigationValues> lstValues)
    {
        int count = 0;
        if (lstValues.Count > 0)
        {
            ListItem lstitem = new ListItem();
            lstitem.Text = "Select";
            lstitem.Value = "0";
            ddlReportingStatus.Items.Add(lstitem);
        }
        for (int i = 0; i < lstValues.Count; i++)
        {
            if (lstValues[i].Name == "Reporting Status")
            {
                ddlReportingStatus.Items.Add(lstValues[i].Value);

            }
        }

        for (int j = 0; j < lstValues.Count; j++)
        {
            if (lstValues[j].Name == "Smear Findings")
            {
                if (count == 0)
                {
                    ddlSmearFindings.Items.Add(new ListItem("Select", count.ToString()));
                    count++;
                }

                ddlSmearFindings.Items.Add(new ListItem(lstValues[j].Value, count.ToString()));
                count++;
            }
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
        Pinv.OrgID = Convert.ToInt32(POrgid);//OrgID;
        Pinv.AccessionNumber = AccessionNumber;	
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
        return Pinv;
    }
    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;

        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = lblName.Text;
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstInvestigationVal.Add(obj);

        if (ddlReportingStatus.SelectedValue != "0")
        {

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblReportingStatus.Text;
            obj.Value = ddlReportingStatus.SelectedValue;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
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
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 2;
            lstInvestigationVal.Add(obj);
        }

        if (txtSource.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSource.Text;
            obj.Value = txtSource.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 3;
            lstInvestigationVal.Add(obj);
        }


        //if (ddlSmearFindings.SelectedValue == "1")
        //{
        //    if (hResultvalues.Value != string.Empty)
        //    {
        //        obj = new InvestigationValues();
        //        obj.Name = lblKohMount.Text;
        //        //a~1^Resistant To~2^
        //        string SmearFindings = string.Empty;

        //        foreach (string strValues in hResultvalues.Value.Split('^'))
        //        {
        //            if (strValues != string.Empty)
        //            {
        //                SmearFindings += SmearFindings == string.Empty ? strValues.Split('~')[0] : "," + strValues.Split('~')[0];
        //            }
        //        }
        //        obj.Value = SmearFindings;
        //        obj.InvestigationID = Convert.ToInt32(ControlID);
        //        obj.PatientVisitID = VID;
        //        obj.CreatedBy = LID;
        //        obj.GroupName = GroupName;
        //        obj.GroupID = groupID;
        //        obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
        //        obj.PackageID = PackageID;
        //        obj.PackageName = PackageName;
        //        lstInvestigationVal.Add(obj);

        //    }
        //}
        //else if (ddlSmearFindings.SelectedValue != "0")
        //{
        //    obj = new InvestigationValues();
        //    obj.InvestigationID = Convert.ToInt32(ControlID);
        //    obj.Name = lblKohMount.Text;
        //    obj.Value = ddlSmearFindings.SelectedItem.Text;
        //    obj.PatientVisitID = VID;
        //    obj.CreatedBy = LID;
        //    obj.GroupName = GroupName;
        //    obj.GroupID = groupID;
        //    obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
        //    obj.PackageID = PackageID;
        //    obj.PackageName = PackageName;
        //    lstInvestigationVal.Add(obj);
        //}




        if (txtKohMount.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblKohMount.Text;
            obj.Value = txtKohMount.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 4;
            lstInvestigationVal.Add(obj);
        }


        if (txt10KohMount.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lbl10KOH.Text;
            obj.Value = txt10KohMount.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 5;
            lstInvestigationVal.Add(obj);
        }


        if (txtLPCB.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lbllpcb.Text;
            obj.Value = txtLPCB.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 6;
            lstInvestigationVal.Add(obj);
        }

        if (txtResult.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblResult.Text;
            obj.Value = txtResult.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 7;
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
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 8;
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
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 9;
            lstInvestigationVal.Add(obj);
        }



        return lstInvestigationVal;
    }
    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
    }
    //protected void ddlSmearFindings_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if(ddlSmearFindings.SelectedValue == "1")
    //    {
    //        trFungusPresent.Visible = true;
    //    }
    //    if (ddlSmearFindings.SelectedValue == "0")
    //    {
    //        trFungusPresent.Visible = false;
    //    }
    //    else
    //    {
    //    }
    //}
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtSpecimen.ReadOnly = value == false ? true : false;
            txtSource.ReadOnly = value == false ? true : false;
            txtKohMount.ReadOnly = value == false ? true : false;
            txt10KohMount.ReadOnly = value == false ? true : false;
            txtLPCB.ReadOnly = value == false ? true : false;
            txtResult.ReadOnly = value == false ? true : false;
            txtGlucose.ReadOnly = value == false ? true : false;
            txtLDH.ReadOnly = value == false ? true : false;
            txtClinicalDiagnosis.ReadOnly = value == false ? true : false;
            txtClinicalNotes.ReadOnly = value == false ? true : false;
            //            pnlEnabled.Enabled = value;
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
    public void loadDataForEdit(List<InvestigationValues> Ivalues)
    {

        foreach (InvestigationValues O in Ivalues)
        {

            switch (O.Name)
            {


                case "Specimen":
                    txtSpecimen.Text = O.Value;
                    break;

                case "Source":
                    txtSource.Text = O.Value;
                    break;
                case "KOH Mount":
                    txtKohMount.Text = O.Value;
                    break;

                case "10% KOH Mount":
                    txt10KohMount.Text = O.Value;
                    break;

                case "Result":
                    txtResult.Text = O.Value;
                    break;

                case "Growth Status":
                    txtResult.Text = O.Value;
                    break;

                case "LPCB":
                    txtLPCB.Text = O.Value;
                    break;
                case "Clinical Diagnosis":
                    txtClinicalDiagnosis.Text = O.Value;
                    break;
                case "Clinical Notes":
                    txtClinicalNotes.Text = O.Value;
                    break;
                case "Report Status":
                    ddlReportingStatus.Items.FindByText(O.Value).Selected = true; ;
                    break;
            }
        }
        txtReason.Text = Ivalues[0].Reason;
        txtMedRemarks.Text = Ivalues[0].MedicalRemarks;
    }
    
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
        txtSpecimen.Attributes.Add("readOnly", "true");
        txtSource.Attributes.Add("readOnly", "true");
        txtKohMount.Attributes.Add("readOnly", "true");
        txt10KohMount.Attributes.Add("readOnly", "true");
        txtLPCB.Attributes.Add("readOnly", "true");
        txtResult.Attributes.Add("readOnly", "true");
        txtGlucose.Attributes.Add("readOnly", "true");
        txtLDH.Attributes.Add("readOnly", "true");
        txtClinicalDiagnosis.Attributes.Add("readOnly", "true");
        txtClinicalNotes.Attributes.Add("readOnly", "true");      
       
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

}
