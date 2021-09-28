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

public partial class Investigation_BleedingTime : BaseControl
{
    public Investigation_BleedingTime()
        : base("Investigation_BleedingTime_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private long accessionNumber = 0;


  
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

        txtmins.Attributes.Add("onkeyup", "setCompletedStatus('" + GroupName + "',this.id)");
        txtSecs.Attributes.Add("onkeyup", "setCompletedStatus('" + GroupName + "',this.id)");
        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
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


    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
     //lblUnit.Text = uom;
        }
    }


    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
       //     hidVal.Value = id;
        }
    }


    public string Value
    {
        get { return result; }
        set { result = value; }
    }


    public int Maxlength
    {
        get { return maxlength; }
        set
        {
            maxlength = value;
            //txtValue.MaxLength = maxlength;
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
    string editTxtValue = string.Empty;

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

    //public List<InvestigationValues> GetResult(long VID)
    //{
    //    List<InvestigationValues> lstValues = new List<InvestigationValues>();
    //    string resultValue = string.Empty;
    //    //resultValue = txtmins.Text != string.Empty ? txtmins.Text + " " + lblmins.Text : "";
    //    //resultValue += txtSecs.Text != string.Empty ? " " + txtSecs.Text + " " + lblSec.Text : "";
        
    //    InvestigationValues obj = new InvestigationValues();
    //    if ((txtmins.Text != string.Empty ) || (txtSecs.Text != string.Empty))
    //    {
    //        if (txtmins.Text != string.Empty && txtSecs.Text != string.Empty)
    //        {
              
    //            resultValue = txtmins.Text + " " + lblUOM1.Text + " , " + txtSecs.Text + " " + lblUOM2.Text; 
    //        }
    //        else if (txtmins.Text != string.Empty)
    //        {
    //            resultValue = txtmins.Text + " " + lblUOM1.Text;
    //        }
    //        else if (txtSecs.Text != string.Empty)
    //        {
    //            resultValue = "-- " + lblUOM1.Text + " , " + txtSecs.Text + " " + lblUOM2.Text;
    //        }

    //        obj.InvestigationID = Convert.ToInt32(ControlID);
    //        obj.PatientVisitID = VID;
    //        obj.Name = lblName.Text;
    //        obj.Value = resultValue;
    //        obj.CreatedBy = LID;
    //        obj.GroupID = groupID;
    //        obj.GroupName = GroupName;
    //        obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
    //        obj.Status = ddlstatus.SelectedItem.Text;
    //        obj.PackageID = PackageID;
    //        obj.PackageName = PackageName;
    //        lstValues.Add(obj);
    //    }

    //    //if (txtSecs.Text != "")
    //    //{
    //    //    obj = new InvestigationValues();
    //    //    //obj.Name = lblName.Text;
    //    //    obj.InvestigationID = Convert.ToInt32(ControlID);
    //    //    obj.PatientVisitID = VID;
    //    //    obj.Value = txtSecs.Text + " " + lblUOM2.Text;
    //    //    obj.CreatedBy = LID;
    //    //    obj.GroupID = groupID;
    //    //    obj.GroupName = GroupName;
    //    //    obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
    //    //    obj.Status = ddlstatus.SelectedItem.Text;
    //    //    obj.PackageID = PackageID;
    //    //    obj.PackageName = PackageName;
    //    //    lstValues.Add(obj);
    //    //}
    //    return lstValues;
    //}

    public List<InvestigationValues> GetResult(long VID)
    {

        List<InvestigationValues> lstValues = new List<InvestigationValues>();

        string resultValue = string.Empty;
        string[] status;
        //resultValue = txtmins.Text != string.Empty ? txtmins.Text + " " + lblmins.Text : "";

        //resultValue += txtSecs.Text != string.Empty ? " " + txtSecs.Text + " " + lblSec.Text : "";


        if ((txtmins.Text != string.Empty) || (txtSecs.Text != string.Empty))
        {
            resultValue = lblName.Text;
        }
        if ((txtmins.Text != string.Empty) && (txtSecs.Text != string.Empty))
        {

            InvestigationValues obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.Name = resultValue.Trim();
            obj.Value = txtmins.Text.Trim() + " " + lblUOM1.Text.Trim() + " " + txtSecs.Text.Trim() + " " + lblUOM2.Text.Trim();
            obj.CreatedBy = LID;
            obj.GroupID = groupID;
            obj.GroupName = GroupName;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 1;
            lstValues.Add(obj);
            resultValue = "";
        }
        else
        {
            if (txtmins.Text != string.Empty)
            {
                InvestigationValues obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt32(ControlID);
                obj.PatientVisitID = VID;
                obj.Name = resultValue.Trim();
                obj.Value = txtmins.Text.Trim() + " " + lblUOM1.Text.Trim();
                obj.CreatedBy = LID;
                obj.GroupID = groupID;
                obj.GroupName = GroupName;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                //obj.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                obj.Status = status[0].ToString();
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 1;
                lstValues.Add(obj);
                resultValue = "";
            }
            else if (txtSecs.Text != string.Empty)
            {
                if (lstValues.Count > 0)
                {
                    InvestigationValues obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.PatientVisitID = VID;
                    //obj.Name = resultValue.Trim(); 
                    obj.Value = txtSecs.Text.Trim() + " " + lblUOM2.Text.Trim();
                    obj.CreatedBy = LID;
                    obj.GroupID = groupID;
                    obj.GroupName = GroupName;
                    obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                    //obj.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 1;
                    lstValues.Add(obj);
                }
                else
                {
                    InvestigationValues obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt32(ControlID);
                    obj.PatientVisitID = VID;
                    obj.Name = resultValue.Trim();
                    obj.Value = txtSecs.Text.Trim() + " " + lblUOM2.Text.Trim();
                    obj.CreatedBy = LID;
                    obj.GroupID = groupID;
                    obj.GroupName = GroupName;
                    obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
                    //obj.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 1;
                    lstValues.Add(obj);
                }
            }
        }

        //if (txtSecs.Text != string.Empty)
        //{
        //    if (lstValues.Count > 0)
        //    {
        //        InvestigationValues obj = new InvestigationValues();
        //        obj.InvestigationID = Convert.ToInt32(ControlID);
        //        obj.PatientVisitID = VID;
        //        obj.Value = txtSecs.Text + " " + lblUOM2.Text;
        //        obj.CreatedBy = LID;
        //        obj.GroupID = groupID;
        //        obj.GroupName = GroupName;
        //        obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
        //        obj.Status = ddlstatus.SelectedItem.Text;
        //        obj.PackageID = PackageID;
        //        obj.PackageName = PackageName;
        //        obj.SequenceNo = 2;
        //        lstValues.Add(obj);
        //    }
        //    else
        //    {
        //        InvestigationValues obj = new InvestigationValues();
        //        obj.InvestigationID = Convert.ToInt32(ControlID);
        //        obj.PatientVisitID = VID;
        //        obj.Name = resultValue;
        //        obj.Value = txtSecs.Text + " " + lblUOM2.Text;
        //        obj.CreatedBy = LID;
        //        obj.GroupID = groupID;
        //        obj.GroupName = GroupName;
        //        obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
        //        obj.Status = ddlstatus.SelectedItem.Text;
        //        obj.PackageID = PackageID;
        //        obj.PackageName = PackageName;
        //        obj.SequenceNo = 2;
        //        lstValues.Add(obj);
        //    }
        //}
        return lstValues;
    }

    public PatientInvestigation GetInvestigations(long Vid)
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
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
        Pinv.AccessionNumber = AccessionNumber;	
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
        //InvRemarks
        Pinv.PrintableRange = hdnPrintableRange.Value.Trim().Replace("\n", "<br>");
        return Pinv;
    }
    public void LoadDataForEdit(List<InvestigationValues> lstValues)
    {

//        2 Mins 45 Secs
//6 Mins 00 Secs

        //lblName.Text = lstValues[0].Name; 1 min 2 secs
        string[] EditValue = lstValues[0].Value.Split();
        //txtmins.Text = EditValue[0];
        if (EditValue.Count() == 2)
        {
            if (EditValue[1] == "mm/h")
            {
                txtSecs.Text = EditValue[0];
            }

            else if (EditValue[1] == "mm/30min")
            {
                txtmins.Text = EditValue[0];
            }
            
        }


        if (EditValue.Count() == 4)
        {
            switch (EditValue[1])
            {
                case "mm/h":
                    txtSecs.Text = EditValue[0];
                    break;

                case "mm/30min":
                    txtmins.Text = EditValue[0];
                    break;

            }



            switch (EditValue[3])
            {
                case "mm/h":
                    txtSecs.Text = EditValue[2];
                    break;

                case "mm/30min":
                    txtmins.Text = EditValue[2];
                    break;

            }
  

        }


        if (EditValue.Count() == 2)
        {
            if (EditValue[1] == "Secs")
            {
                txtSecs.Text = EditValue[0];
            }

            else if (EditValue[1] == "Mins")
            {
                txtmins.Text = EditValue[0];
            }

        }


        if (EditValue.Count() == 4)
        {
            switch (EditValue[1])
            {
                case "Secs":
                    txtSecs.Text = EditValue[0];
                    break;

                case "Mins":
                    txtmins.Text = EditValue[0];
                    break;

            }



            switch (EditValue[3])
            {
                case "Secs":
                    txtSecs.Text = EditValue[2];
                    break;

                case "Mins":
                    txtmins.Text = EditValue[2];
                    break;
            }
        }
 
        txtReason.Text = lstValues[0].Reason;
        txtMedRemarks.Text = lstValues[0].MedicalRemarks;
        lblPVisitID.Text = Convert.ToString(PatientVisitID);
        lblPatternID.Text = Convert.ToString(PatternID);
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(POrgid);
        lblPatternClassName.Text = "Investigation_BleedingTime";
        //Delta CheckUp 
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "table-cell");
        }

    }
    public void LoadData(List<InvestigationValues> lstData)
    {
        for (int i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "UOM1")
            {
                lblUOM1.Text = lstData[i].Value;
            }
            else if (lstData[i].Name == "UOM2")
            {
                lblUOM2.Text = lstData[i].Value;
            }

        }

    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            txtReason.Enabled = value;
            txtMedRemarks.ReadOnly = value;
            //txtRefRange.Enabled = value;
            //txtmins.Enabled = value;
            //txtSecs.Enabled = value;
            txtReason.BackColor = System.Drawing.Color.RosyBrown;
            txtMedRemarks.BackColor = System.Drawing.Color.RosyBrown;
            txtmins.ForeColor = System.Drawing.Color.Black;
            txtmins.ReadOnly = value == false ? true : false;
            txtRefRange.BackColor = System.Drawing.Color.RosyBrown;
            txtmins.ForeColor = System.Drawing.Color.Black;
            txtmins.ReadOnly = value == false ? true : false;
            lnkEdit.Visible = true;
            txtmins.BackColor = System.Drawing.Color.RosyBrown;
            txtmins.ForeColor = System.Drawing.Color.Black;
            txtmins.ReadOnly = value == false ? true : false;
            txtSecs.BackColor = System.Drawing.Color.RosyBrown;
            txtmins.ForeColor = System.Drawing.Color.Black;
            txtmins.ReadOnly = value == false ? true : false;
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
        txtmins.Attributes.Add("readOnly", "true");
        txtSecs.Attributes.Add("readOnly", "true");
 
        //txtReason.BackColor = System.Drawing.Color.RosyBrown;
        //txtmins.ForeColor = System.Drawing.Color.Black;        

        //txtRefRange.BackColor = System.Drawing.Color.RosyBrown;
        //txtmins.ForeColor = System.Drawing.Color.Black;       

        //txtmins.BackColor = System.Drawing.Color.RosyBrown;
        //txtmins.ForeColor = System.Drawing.Color.Black;        

        //txtSecs.BackColor = System.Drawing.Color.RosyBrown;
        //txtmins.ForeColor = System.Drawing.Color.Black;         
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
