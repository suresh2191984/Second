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

public partial class Investigation_DifferentialPattern : BaseControl
{
    private string name = string.Empty;
    private string result = string.Empty;
    private string uom = string.Empty;
    private string id = string.Empty;
    private int i = 0;


    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        txt1.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt2.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt3.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt4.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt5.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt6.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt7.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt8.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txt9.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

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


    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUom1.Text = uom;
            lblUom2.Text = uom;
            lblUom3.Text = uom;
            lblUom4.Text = uom;
            lblUom5.Text = uom;
            lblUom6.Text = uom;
            lblUom7.Text = uom;
            lblUom8.Text = uom;
            lblUom9.Text = uom;
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
            lblCaption.Text = name;
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


    public void LoadData(List<InvestigationValues> lstData)
    {
        for (i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "Source1")
            {
                lblName1.Text = lstData[i].Value;
                trSource1.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source2")
            {
                lblName2.Text = lstData[i].Value;
                trSource2.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source3")
            {
                lblName3.Text = lstData[i].Value;
                trSource3.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source4")
            {
                lblName4.Text = lstData[i].Value;
                trSource4.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source5")
            {
                lblName5.Text = lstData[i].Value;
                trSource5.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source6")
            {
                lblName6.Text = lstData[i].Value;
                trSource6.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source7")
            {
                lblName7.Text = lstData[i].Value;
                trSource7.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source8")
            {
                lblName8.Text = lstData[i].Value;
                trSource8.Style.Add("display", "block");
            }
            else if (lstData[i].Name == "Source9")
            {
                lblName9.Text = lstData[i].Value;
                trSource9.Style.Add("display", "block");
            }
        }
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        if (txt1.Text != "" || txt2.Text != "" || txt3.Text != "" || txt4.Text != "" || txt5.Text != "" || txt6.Text != "" || txt7.Text != "" || txt8.Text != "" || txt9.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblCaption.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 1;
            lstInvestigationVal.Add(obj);
        }
        if (txt1.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name =  lblName1.Text;
            obj.Value = txt1.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom1.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 2;
            lstInvestigationVal.Add(obj);
        }
        if (txt2.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName2.Text;
            obj.PatientVisitID = VID;
            obj.Value = txt2.Text;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom2.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 3;
            lstInvestigationVal.Add(obj);
        }
        if (txt3.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name =  lblName3.Text;
            obj.Value = txt3.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom3.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 4;
            lstInvestigationVal.Add(obj);
        }
        if (txt4.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName4.Text;
            obj.Value = txt4.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom4.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 5;
            lstInvestigationVal.Add(obj);
        }
        if (txt5.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName5.Text;
            obj.Value = txt5.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom5.Text;
            obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 6;
            lstInvestigationVal.Add(obj);
        }
        if (txt6.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName6.Text;
            obj.Value = txt6.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom6.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 7;
            lstInvestigationVal.Add(obj);
        }
        if (txt7.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName7.Text;
            obj.Value = txt7.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom7.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 8;
            lstInvestigationVal.Add(obj);
        }
        if (txt8.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName8.Text;
            obj.Value = txt8.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom8.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 9;
            lstInvestigationVal.Add(obj);
        }
        if (txt9.Text != "")
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName9.Text;
            obj.Value = txt9.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUom9.Text;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.SequenceNo = 10;
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
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        String[] status;
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
            pnlenabled.Enabled = value;
            
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            
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
        lblCaption.Text = lstValues[0].Name;
        foreach (var item in lstValues)
        {
            switch (item.Name)
            {
                case "Neutrophils":
                    txt1.Text = item.Value;
                    break;

                case "Lymphocytes":
                    txt2.Text = item.Value;
                    break;

                case "Eosinophils":
                    txt3.Text = item.Value;
                    break;

                case "Basophils":
                    txt4.Text = item.Value;
                    break;

                case "Monocytes":
                    txt5.Text = item.Value;
                    break;

                case "Bands":
                    txt6.Text = item.Value;
                    break;

                case "Metamyelocytes":
                    txt7.Text = item.Value;
                    break;

                case "PDW":
                    txt8.Text = item.Value;
                    break;

                case "RDW":
                    txt9.Text = item.Value;
                    break;

                case "Sample Name":
                    txt1.Text = item.Value;
                    break;

              
                case "Source":
                    txt2.Text = item.Value;
                    break;

                case "Microscopy <br> Ziehl-Neelsen stain":
                    txt3.Text = item.Value;
                    break;

                case "Culture Report":
                    txt4.Text = item.Value;
                    break;

            }

        }
        txtReason.Text = lstValues[0].Reason;
        txtMedRemarks.Text = lstValues[0].MedicalRemarks;
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
        pnlenabled.Enabled = true;

        
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
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }
}
