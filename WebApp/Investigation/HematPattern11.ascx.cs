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
public partial class Investigation_HematPattern11 :BaseControl
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

        rdolist.Attributes.Add("onchange", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        chkList.Attributes.Add("onclick", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");
        ddlPlasma.Attributes.Add("onclick", "javascript:return setCompletedStatus('" + GroupName + "',this.id);");

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
    //protected void ddlShow_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (ddlShow.SelectedIndex == 1)
    //    {
    //        ddlPlasma.Visible = true;
    //    }
    //    else
    //    {
    //        ddlPlasma.Visible = false;
    //    }
    //}

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

            if (lstData[i].Name == "Source")
            {
                //ddlShow.Items.Add(lstData[i].Value);
                chkList.Items.Add(new ListItem(lstData[i].Value, "1"));
            }

            if (lstData[i].Name == "Result")
            {
                ddlPlasma.Items.Add(lstData[i].Value);
            }
        }
        ddlPlasma.Items.Insert(0, new ListItem("Select"));
        rdolist.Items[0].Selected = true;
        txtReason.Text = lstData[0].Reason;
        txtMedRemarks.Text = lstData[0].MedicalRemarks;
    }


    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;

        //if (ddlPlasma.Visible)
        //{
            //obj = new InvestigationValues();
            //obj.InvestigationID = Convert.ToInt32(ControlID);
            //obj.Name = lblName.Text;
            //obj.Value = rdolist.SelectedItem.Text;
            //obj.PatientVisitID = VID;
            //obj.CreatedBy = LID;
            //obj.GroupName = GroupName;
            //obj.GroupID = groupID;
            //obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            //lstInvestigationVal.Add(obj);


            //foreach (ListItem li in chkList.Items)
            //{
            //    obj = new InvestigationValues();
            //    obj.InvestigationID = Convert.ToInt32(ControlID);
            //    obj.Name = "Result";
            //    obj.Value = li.Text;
            //    obj.PatientVisitID = VID;
            //    obj.CreatedBy = LID;
            //    obj.GroupName = GroupName;
            //    obj.GroupID = groupID;
            //    obj.Orgid = OrgID;
            //    obj.Status = ddlstatus.SelectedItem.Text;
            //    lstInvestigationVal.Add(obj);
            //}

            ////obj = new InvestigationValues();
            ////obj.InvestigationID = Convert.ToInt32(ControlID);
            ////obj.Name = "Result";
            ////////obj.Value = ddlShow.SelectedItem.Text;
            ////obj.PatientVisitID = VID;
            ////obj.CreatedBy = LID;
            ////obj.GroupName = GroupName;
            ////obj.GroupID = groupID;
            ////obj.Orgid = OrgID;
            ////obj.Status = ddlstatus.SelectedItem.Text;
            ////lstInvestigationVal.Add(obj);
            //if (ddlPlasma.SelectedItem.Text != "Select")
            //{
            //    obj = new InvestigationValues();
            //    obj.InvestigationID = Convert.ToInt32(ControlID);
            //    obj.Name = "Result";
            //    obj.Value = ddlPlasma.SelectedItem.Text;
            //    obj.PatientVisitID = VID;
            //    obj.CreatedBy = LID;
            //    obj.GroupName = GroupName;
            //    obj.GroupID = groupID;
            //    obj.Orgid = OrgID;
            //    obj.Status = ddlstatus.SelectedItem.Text;
            //    lstInvestigationVal.Add(obj);
            //}
        //}
        //else if (chkList.Visible)
        //{
            //obj = new InvestigationValues();
            //obj.InvestigationID = Convert.ToInt32(ControlID);
            //obj.Name = lblName.Text;
            //obj.Value = rdolist.SelectedItem.Text;
            //obj.PatientVisitID = VID;
            //obj.CreatedBy = LID;
            //obj.GroupName = GroupName;
            //obj.GroupID = groupID;
            //obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            //lstInvestigationVal.Add(obj);

           
        //}
        //else
        //{
            //obj = new InvestigationValues();
            //obj.InvestigationID = Convert.ToInt32(ControlID);
            //obj.Name = lblName.Text;
            //obj.Value = rdolist.SelectedItem.Text;
            //obj.PatientVisitID = VID;
            //obj.CreatedBy = LID;
            //obj.GroupName = GroupName;
            //obj.GroupID = groupID;
            //obj.Orgid = OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            //lstInvestigationVal.Add(obj);
        //}
        String[] status;
        int checkCount = 0;
        string resultString = string.Empty;
        foreach (ListItem li in chkList.Items)
        {
            if (li.Selected)
            {
                if (resultString != string.Empty)
                {
                    resultString = ddlPlasma.SelectedItem.Text != "Select" ? "," + li.Text
                                    + " Parasites " + rdolist.SelectedItem.Text : li.Text
                                    + " Parasites " + rdolist.SelectedItem.Text
                                    + "(" + ddlPlasma.SelectedItem.Text + ")";
                }
                else
                {
                    resultString = ddlPlasma.SelectedItem.Text != "Select" ? li.Text
                                                    + " Parasites " + rdolist.SelectedItem.Text
                                                    + "(" + ddlPlasma.SelectedItem.Text + ")" : li.Text
                                                    + " Parasites " + rdolist.SelectedItem.Text;
                }
                checkCount = 1;
            }
            
        }
        if (resultString != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            obj.Value = resultString;
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

        if (checkCount == 0)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            obj.Value = rdolist.SelectedItem.Text;
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
            checkCount = 1;
            lstInvestigationVal.Add(obj);
        }

        return lstInvestigationVal;

    }
    protected void rdolist_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rdolist.Items[1].Selected)
        {
           // ddlShow.Visible = true;
            chkList.Visible = true;
        }
        else
        {
            //ddlShow.Visible = false;
            //ddlShow.SelectedIndex = 0;
            chkList.Visible = false;
            ddlPlasma.Visible = false;
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

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }
    protected void chkList_SelectedIndexChanged(object sender, EventArgs e)
    {
         if(chkList.Items[1].Selected)
         {
             ddlPlasma.Visible = true;
         }
         else
         {
             ddlPlasma.Visible = false;
         }
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
