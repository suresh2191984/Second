using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Solution.DAL;
using Attune.Podium.BusinessEntities;
using System.Web.Script.Serialization;


public partial class Investigation_ANAPattern :BaseControl // System.Web.UI.UserControl
{
    private string name = string.Empty;
    private string controlID = string.Empty;
    private string refRange = string.Empty;
   
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        divSeroCollagen1.Visible = false;

        ddlResult1.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlResult2.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlResult3.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

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
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = Name;
        }
    }

    public string ControlID
    {
        get { return controlID; }
        set
        {
            controlID = value;
            hidValue.Value = controlID;
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
    //Added by Perumal on 13 Jan 2012

    
    public void LoadData(List<InvestigationValues> lstInvesValues)
    {
        ddlResult1.Items.Insert(0, new ListItem("Select", "0"));
        ddlResult2.Items.Insert(0, new ListItem("Select", "0"));
        ddlResult3.Items.Insert(0, new ListItem("Select", "0"));

        for (int i = 0; i < lstInvesValues.Count; i++)
        {
            if (lstInvesValues[i].Name == "Source")
            {
                ddlResult1.Items.Add(lstInvesValues[i].Value);
            }
            else if (lstInvesValues[i].Name == "Result")
            {
                ddlResult2.Items.Add(lstInvesValues[i].Value);
            }
            else if (lstInvesValues[i].Name == "Data")
            {
                ddlResult3.Items.Add(lstInvesValues[i].Value);
            }
        }
     
    }


    protected void ddlResult1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlResult1.SelectedIndex == 1)
        {
            divSeroCollagen1.Visible = true;
        }
        else
        {
            divSeroCollagen1.Visible = false;
        }
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> obj = new List<InvestigationValues>();
        InvestigationValues invesValues;
        String[] status;
        if (ddlResult1.SelectedItem.Text != "Select")
        {

            if (divSeroCollagen1.Visible)
            {
                if (ddlResult2.SelectedItem.Text != "Select" && ddlResult3.SelectedItem.Text != "Select")
                {
                    invesValues = new InvestigationValues();
                    invesValues.InvestigationID = Convert.ToInt64(ControlID);
                    invesValues.Name = name;
                    invesValues.Value = ddlResult1.SelectedItem.Text;
                    invesValues.PatientVisitID = VID;
                    invesValues.Orgid = OrgID;
                    invesValues.GroupID = GroupID;
                    invesValues.CreatedBy = LID;
                    invesValues.GroupName = GroupName;
                    //invesValues.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    invesValues.Status = status[0].ToString();
                    invesValues.PackageID = PackageID;
                    invesValues.PackageName = PackageName;
                    obj.Add(invesValues);

                    invesValues = new InvestigationValues();
                    invesValues.InvestigationID = Convert.ToInt64(ControlID);
                    invesValues.Name = "Result";
                    invesValues.Value = ddlResult2.SelectedItem.Text;
                    invesValues.Orgid = OrgID;
                    invesValues.GroupID = GroupID;
                    invesValues.GroupName = GroupName;
                    invesValues.CreatedBy = LID;
                    invesValues.PatientVisitID = VID;
                    //invesValues.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    invesValues.Status = status[0].ToString();
                    invesValues.PackageID = PackageID;
                    invesValues.PackageName = PackageName;
                    obj.Add(invesValues);

                    invesValues = new InvestigationValues();
                    invesValues.InvestigationID = Convert.ToInt64(ControlID);
                    invesValues.Name = "Result";
                    invesValues.Value = ddlResult3.SelectedItem.Text;
                    invesValues.Orgid = OrgID;
                    invesValues.GroupID = GroupID;
                    invesValues.GroupName = GroupName;
                    invesValues.CreatedBy = LID;
                    invesValues.PatientVisitID = VID;
                    //invesValues.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    invesValues.Status = status[0].ToString();
                    invesValues.PackageID = PackageID;
                    invesValues.PackageName = PackageName;
                    obj.Add(invesValues);
                }

            }
            else
            {
                invesValues = new InvestigationValues();
                invesValues.InvestigationID = Convert.ToInt64(ControlID);
                invesValues.Name = name;
                invesValues.Value = ddlResult1.SelectedItem.Text;
                invesValues.Orgid = OrgID;
                invesValues.GroupID = GroupID;
                invesValues.GroupName = GroupName;
                invesValues.CreatedBy = LID;
                invesValues.PatientVisitID = VID;
                //invesValues.Status = ddlstatus.SelectedItem.Text;
                status = ddlstatus.SelectedValue.Split('_');
                invesValues.Status = status[0].ToString();
                invesValues.PackageID = PackageID;
                invesValues.PackageName = PackageName;
                obj.Add(invesValues);
            }
        }
        return obj;
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
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
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
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        Pinv.PrintableRange = hdnPrintableRange.Value.Trim().Replace("\n", "<br>");
        return Pinv;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "');");
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
       
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");

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
        if (labTechEditMedRem == "N" && currentRoleName == Attune.Podium.Common.RoleHelper.LabTech)
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
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
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }
}
