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
public partial class Investigation_StoneAnalysis : BaseControl
{
    public Investigation_StoneAnalysis()
        : base("Investigation_StoneAnalysis_ascx")
    {
    }

    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
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

        txtSamples.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtSize.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtStructure.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtCompsition.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtImpression.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

        txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
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

    
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
        }
    }


    public string Value
    {
        get { return result; }
        set { result = value; }
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

    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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
    public void LoadData(List<InvestigationValues> lstData)
    {
        //ddlData.DataSource = lstData;
        //ddlData.DataValueField = "Value";
        //ddlData.DataBind();
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstValues = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        //obj = new InvestigationValues();
        //obj.Name = "Sample Name";
        //obj.Value = ddlData.SelectedItem.Text;
        //obj.InvestigationID = Convert.ToInt32(ID);
        //obj.PatientVisitID = VID;
        //lstValues.Add(obj);

        obj = new InvestigationValues();
        obj.Name = "No of Stones";
        obj.Value = txtSamples.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstValues.Add(obj);

        obj = new InvestigationValues();
        obj.Name = "Largest Stone Size";
        obj.Value = txtSize.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstValues.Add(obj);

        obj = new InvestigationValues();
        obj.Name = "Stone Structure & Shape";
        obj.Value =txtStructure.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid =Convert.ToInt32(POrgid);// OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstValues.Add(obj);


        obj = new InvestigationValues();
        obj.Name = "Stone Composition";
        obj.Value = txtCompsition.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstValues.Add(obj);

        obj = new InvestigationValues();
        obj.Name = "Stone Impression";
        obj.Value = txtImpression.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.CreatedBy = LID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstValues.Add(obj);

        return lstValues;
    }

    public PatientInvestigation GetInvestigations(long Vid)
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;

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
            pnlStone.Enabled = value;
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
        lblName.Text = lstValues[0].Name;
        foreach (var item in lstValues)
        {
            switch (item.Name)
            {
                case "No of Stones":
                    txtSamples.Text = item.Value;
                    break;

                case "Largest Stone Size":
                    txtSize.Text = item.Value;
                    break;

                case "Stone Structure & Shape":
                    txtStructure.Text = item.Value;
                    break;

                case "Stone Composition":
                    txtCompsition.Text = item.Value;
                    break;

                case "Stone Impression":
                    txtImpression.Text = item.Value;
                    break;
            }
        }
        txtReason.Text = lstValues[0].Reason;
        txtMedRemarks.Text = lstValues[0].MedicalRemarks;
    }
 
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        pnlStone.Enabled = true;
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
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
