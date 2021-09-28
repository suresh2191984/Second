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

public partial class Investigation_MicroPattern : BaseControl
{
    private string name = string.Empty;
    private string id = string.Empty;

    private int groupID = 0;
    private string groupName = string.Empty;
    private long accessionNumber = 0;

    public int GroupID
    {
        get { return groupID; }
        set
        {
            groupID = value;
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

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        ddlSource.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        ddlMethod.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        ddlType.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        ddlResult.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        txtValue.Attributes.Add("onkeyup", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }

    public void loadMethod(List<InvestigationValues> lstBulkData)
    {
        int count=0;
        for (int i = 0; i < lstBulkData.Count; i++)
        {

            if (lstBulkData[i].Name == "Source")
            {
                ddlSource.Items.Add(lstBulkData[i].Value);
            }
            else if (lstBulkData[i].Name == "Method")
            {
               // ddlMethod.Items.Add(lstBulkData[i].Value); 
                ddlMethod.Items.Insert(count,new ListItem(lstBulkData[i].Value,Convert.ToString(lstBulkData[i].InvestigationValueID)));
                count++;
            }
            else if (lstBulkData[i].Name == "Type")
            {
                ddlType.Items.Add(lstBulkData[i].Value);
            }
            else if (lstBulkData[i].Name == "Result")
            {
                ddlResult.Items.Add(lstBulkData[i].Value);
            }
            
        }
        txtReason.Text = lstBulkData[0].Reason;
        txtMedRemarks.Text = lstBulkData[0].MedicalRemarks;
    }

    public string Name
    {
        get { return name; }
        set { 
            name = value;
            //lblName.Style["color"] = "Black";
            lblName.Text = name;
        }
    }

    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        
        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.Name = "Source";
        obj.Value = ddlSource.SelectedItem.Text;
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid = OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstInvestigationVal.Add(obj);


        obj = new InvestigationValues();
        obj.InvestigationID = Convert.ToInt32(ControlID);          
        obj.Name = "Method";
        obj.Value = ddlMethod.SelectedItem.Value;
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid = OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstInvestigationVal.Add(obj);


        
        if(Dtxt.Visible)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Result";
            obj.Value = txtValue.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }


         if(Dresult.Visible)
         {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Result";
            obj.Value = ddlResult.SelectedItem.Text;
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        return lstInvestigationVal;

    }

    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlType.SelectedIndex == 0)
        {
            Dtxt.Visible = true;
            Dresult.Visible = true;
        }
        else
        {
            Dtxt.Visible = false;
            Dresult.Visible = true;
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
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = OrgID;
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
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            //txtRefRange.Enabled = value;
            //txtValue.Enabled = value;
            txtValue.ReadOnly = value == false ? true : false;

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
    public void LoadInvStatusReason(List<InvReasonMasters> lstInvReasonMaster)
    {
        ddlStatusReason.DataSource = lstInvReasonMaster;
        ddlStatusReason.DataTextField = "ReasonDesc";
        ddlStatusReason.DataValueField = "ReasonID";
        ddlStatusReason.DataBind();
        ddlStatusReason.Items.Insert(0, "-----Select-----");
        ddlStatusReason.SelectedIndex = 0;
    }
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        txtValue.Attributes.Add("readOnly", "true");
       
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
}
