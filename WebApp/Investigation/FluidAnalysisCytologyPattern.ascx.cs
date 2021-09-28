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


public partial class Investigation_FluidAnalysisCytologyPattern : BaseControl
{
    public Investigation_FluidAnalysisCytologyPattern()
        : base("Investigation_FluidAnalysisCytologyPattern_ascx")
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
            hidValCyp.Value = id;
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
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        rblEpithelial.Attributes.Add("onclick", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        rblMalignant.Attributes.Add("onclick", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        rblNormal.Attributes.Add("onclick", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

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
		LoadMetaData();
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
        for (int i = 0; i < lstValues.Count; i++)
        {
            lblName.Text = lstValues[i].Value;
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
        Pinv.AccessionNumber = AccessionNumber;	
        Pinv.MedicalRemarks = txtMedRemarks.Text; //Inv Remarks
        //InvRemarks
        if (hdnRemarksID.Value != null && hdnRemarksID.Value != "")
        {
            Pinv.RemarksID = Convert.ToInt64(hdnRemarksID.Value);
        }
        //InvRemarks
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
        Pinv.OrgID = OrgID;
        return Pinv;
    }
    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        if ((rblEpithelial.SelectedIndex != -1) || (rblMalignant.SelectedIndex != -1) || (rblNormal.SelectedIndex != -1))
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = "Cytology";
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = OrgID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstInvestigationVal.Add(obj);
        }

        if (rblEpithelial.SelectedIndex != -1)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblEpithelialCells.Text;
            obj.Value = rblEpithelial.SelectedItem.Text;
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

        if (rblMalignant.SelectedIndex != -1)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMalignantCells.Text;
            obj.Value = rblMalignant.SelectedItem.Text;
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

        if (rblNormal.SelectedIndex != -1)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblNormalCells.Text;
            obj.Value = rblNormal.SelectedItem.Text;
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
            txtMedRemarks.ReadOnly = value == false ? true : false; //Inv Remarks
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
        lblName.Text = lEditValues[0].Name;
        foreach (var item in lEditValues)
        {
            switch (item.Name)
            {
                case "Epithelial Cells":
                    rblEpithelial.SelectedItem.Text = item.Value;
                    break;

                case "Malignant Cells":
                    rblMalignant.SelectedItem.Text = item.Value;
                    break;

                case "Normal Cells":
                    rblNormal.SelectedItem.Text = item.Value;
                    break;

            }

        }
        txtReason.Text = lEditValues[0].Reason;
        txtMedRemarks.Text = lEditValues[0].MedicalRemarks; //Inv Remarks
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
        pnlenabled.Enabled = true;
    }
	
	public void LoadMetaData()
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_FluidAnalysisCytologyPattern_ascx == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_FluidAnalysisCytologyPattern_ascx;

        try
        {
            long returncode = -1;
            string domains = "Absent";
            string[] Tempdata = domains.Split(',');

            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            string LangCode = "en-GB";
            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "Absent"
                                 select child;
                rblEpithelial.DataSource = childItems;
                rblEpithelial.DataTextField = "DisplayText";
                rblEpithelial.DataValueField = "Code";
                rblEpithelial.DataBind();

                rblMalignant.DataSource = childItems;
                rblMalignant.DataTextField = "DisplayText";
                rblMalignant.DataValueField = "Code";
                rblMalignant.DataBind();

                rblNormal.DataSource = childItems;
                rblNormal.DataTextField = "DisplayText";
                rblNormal.DataValueField = "Code";
                rblNormal.DataBind();
                

            }
            ddlStatusReason.Items.Insert(0, strSelect);
            ddlOpinionUser.Items.Insert(0, strSelect);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
	
}
