using System;
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
using System.Collections.Generic;
using System.Web.Script.Serialization;

public partial class Investigation_Body_Fluid_Analysis : BaseControl
{
    public Investigation_Body_Fluid_Analysis()
        : base("Investigation_BodyFluidAnalysis_ascx")
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

    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidValChp.Value = id;
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


    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        //ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id);ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
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
        for (int i = 0; i < lstValues.Count; i++)
        {
            lblName.Text = lstValues[i].Value;
        }
    }
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status =ddlStatus.SelectedItem.Text;
        status = ddlStatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.ReferenceRange = txtRefRange.Text;
        Pinv.AccessionNumber = AccessionNumber;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
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
        Pinv.OrgID = OrgID;
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
        if ((txtVolume.Text != string.Empty) || (txtColour.Text != string.Empty) || (txtAppearance.Text != string.Empty) || (txtProtein.Text != string.Empty) || (txtSugar.Text != string.Empty) || (txtCellCount.Text != string.Empty) || (txtNeutrophils.Text != string.Empty) || (txtlymphocytes.Text != string.Empty))
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "BodyFluidAnalysis";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageName = PackageName;
            obj.SequenceNo=1;
            lstInvestigationVal.Add(obj);
        }
        if (lblPhysicalExamination.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.SequenceNo = 2;
            obj.Name = lblPhysicalExamination.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            lstInvestigationVal.Add(obj);
        }

        if (txtVolume.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblVolume.Text;
            obj.Value = txtVolume.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.UOMCode = lblUVolume.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 3;
            lstInvestigationVal.Add(obj);
        }
        if (txtColour.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblColour.Text;
            obj.Value = txtColour.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.UOMCode = lblUColour.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 4;
            lstInvestigationVal.Add(obj);
        }
        if (txtAppearance.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblAppearance.Text;
            obj.Value = txtAppearance.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.UOMCode = lblUGlucose.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 5;
            lstInvestigationVal.Add(obj);
        }
        if (lblChemicalExamination .Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.SequenceNo = 6;
            obj.Name = lblChemicalExamination.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            lstInvestigationVal.Add(obj);
        }

        if (txtProtein.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblProtein.Text;
            obj.Value = txtProtein.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.UOMCode = lblUProtein.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 7;
            lstInvestigationVal.Add(obj);
        }
        if (txtSugar.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSugar.Text;
            obj.Value = txtSugar.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.UOMCode = lblUSugar.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 8;
            lstInvestigationVal.Add(obj);
        }
        if (lblMicroscopic.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.SequenceNo = 9;
            obj.Name = lblMicroscopic.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            lstInvestigationVal.Add(obj);
        }

        if (txtCellCount.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblCellCount.Text;
            obj.Value = txtCellCount.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.UOMCode = lblUCellCount.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 10;
            lstInvestigationVal.Add(obj);
        }
        if (lblCellType.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.SequenceNo = 11;
            obj.Name = lblCellType.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            lstInvestigationVal.Add(obj);
        }
        if (txtNeutrophils.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblNeutrophils.Text;
            obj.Value = txtNeutrophils.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.UOMCode = lblUCellCount.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 12;
            lstInvestigationVal.Add(obj);
        }
        if (txtlymphocytes.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lbllymphocytes.Text;
            obj.Value = txtlymphocytes.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.UOMCode = lblUCellCount.Text;
            //obj.Status = ddlStatus.SelectedItem.Text;
            status = ddlStatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 13;
            lstInvestigationVal.Add(obj);
        }
        return lstInvestigationVal;
    }
    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "');");
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
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            pnlenabled.Enabled = value;
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
    public void LoadDataForEdit(List<InvestigationValues> lEditValues)
    {
        //lblName.Text = lEditValues[0].Name;
        foreach (var item in lEditValues)
        {
            switch (item.Name)
            {
                case "Volume":
                    txtVolume.Text = item.Value;
                    break;

                case "Colour":
                    txtColour.Text = item.Value;
                    break;

                case "Appearance":
                    txtAppearance.Text = item.Value;
                    break;

                case "Protein":
                    txtProtein.Text = item.Value;
                    break;

                case "Sugar":
                    txtSugar.Text = item.Value;
                    break;

                case "CellCount":
                    txtCellCount.Text = item.Value;
                    break;

                case "Neutrophils":
                    txtNeutrophils.Text = item.Value;
                    break;

                case "Lymphocytes":
                    txtlymphocytes.Text = item.Value;
                    break;

            }
        }
    }

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
        pnlenabled.Enabled = true;
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
