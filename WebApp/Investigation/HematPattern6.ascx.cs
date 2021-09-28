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
public partial class Investigation_HematPattern6 : BaseControl
{
    private string name = string.Empty;
    private string result = string.Empty;
    private string uom = string.Empty;
    private string id = string.Empty;
    private int i = 0;
    private int groupID = 0;
    private string groupName = string.Empty;
    private string refRange = string.Empty;

    //code added on 23-07-2010 QRM - Started
    Investigation_BL InvestigationBL;
    protected override void Render(HtmlTextWriter writer)
    {

        long returnCode = -1;
        List<InvQualitativeResultMaster> lstQualitativeResult = new List<InvQualitativeResultMaster>();
        returnCode = InvestigationBL.GetInvQualitativeResultMaster(out lstQualitativeResult); 
        for (int i = 0; i < lstQualitativeResult.Count; i++)
        {
            Page.ClientScript.RegisterForEventValidation(ddlData1.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
            Page.ClientScript.RegisterForEventValidation(ddlData2.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
        }
        base.Render(writer);

    }



    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        hlnkAdd1.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlData1.ClientID + "','Source')");
        ddlData1.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);appendDDLHdn('" + ddlData1.ClientID + "','" + hdnDDL1.ClientID + "')");

        hlnkAdd1.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        hlnkAdd2.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlData2.ClientID + "','Result')");

        ddlData2.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);appendDDLHdn('" + ddlData2.ClientID + "','" + hdnDDL2.ClientID + "')");
        hlnkAdd2.Attributes.Add("onmouseover", "this.style.cursor='hand'");

        ADeltaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ADeltaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    //code added on 23-07-2010 QRM - Completed



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
    public string Dilution
    {
        get { return txtDilution.Text; }
        set
        {
            txtDilution.Text = value;
        }
    }


    /// <summary>
    /// Get and Set the UOM Code
    /// </summary>
    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            if(uom!="0")
            lblUOM.Text = uom;
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
        hdnddlData1.Value = "";
        hdnddlData2.Value = "";
        ddlData1.Items.Insert(0, new ListItem("Select", "0"));
        ddlData2.Items.Insert(0, new ListItem("Select", "0"));
        ddlData1.SelectedIndex = 0;
        ddlData2.SelectedIndex = 0;
        int count=0;
        for (i = 0; i < lstData.Count; i++)
        {
            if (lstData[i].Name == "Source")
            {
                ddlData1.Items.Add(new ListItem(lstData[i].Value,lstData[i].GroupName));
                hdnddlData1.Value += lstData[i].Value + "~";
                //ddlData1.Items.Insert(count, new ListItem(lstData[i].Value, Convert.ToString(lstData[i].InvestigationValueID)));
                //count++;
            }
            else if(lstData[i].Name == "Result")
            {
                ddlData2.Items.Add(new ListItem(lstData[i].Value, lstData[i].GroupName));
                hdnddlData2.Value += lstData[i].Value + "~";
                //DDLDATA2.ITEMS.INSERT(COUNT, NEW LISTITEM(LSTDATA[I].VALUE, CONVERT.TOSTRING(LSTDATA[I].INVESTIGATIONVALUEID)));
                //COUNT++;
                //ddlData2.Items.Insert(count, new ListItem(lstData[i].Value, Convert.ToString(lstData[i].InvestigationValueID)));
                //count++;
            }
        }

        
    }


    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        hdnDDL1.Value = ((hdnDDL1.Value == "")||(hdnDDL1.Value == "0")) ? ddlData1.SelectedItem.Text : hdnDDL1.Value;
        hdnDDL2.Value = ((hdnDDL2.Value == "")||(hdnDDL2.Value == "0")) ? ddlData2.SelectedItem.Text : hdnDDL2.Value;
        String[] status;
        if ((hdnDDL1.Value != "Select") || (hdnDDL2.Value != "Select"))
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblName.Text;
            //code modified on 23-07-2010 QRM
            if (hdnDDL1.Value != "Select")
            {
                obj.Value = hdnDDL1.Value;
            }
            if ((obj.Value != string.Empty) && (hdnDDL2.Value != "Select"))
            {
                obj.Value += " " + hdnDDL2.Value;
            }
            else if (hdnDDL2.Value != "Select")
            {
                obj.Value += hdnDDL2.Value;
            }
            obj.PatientVisitID = VID;
            obj.CreatedBy = LID;
            obj.UOMCode = lblUOM.Text;
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.Orgid = Convert.ToInt32(POrgid);//OrgID;
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.Dilution = txtDilution.Text;
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
        Pinv.OrgID = Convert.ToInt32(POrgid);//OrgID;
        Pinv.IsAbnormal = ddlData2.SelectedItem.Value;
        //Pinv.IsAbnormal = ddlData1.SelectedItem.Value;

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
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        lblName.Text = lEditInvestigation[0].Name;
        foreach (var item in lEditInvestigation[0].Value.Split())
        {
            if (item != string.Empty)
            {

                var str = ddlData1.Items.Cast<ListItem>().Where(O => O.Text == item);

                var ddl1SelectionText = (from ListItem Sitem in ddlData1.Items
                                         where Sitem.Text == item
                                         select Sitem.Text).ToList();
                var ddl2SelectionText = (from ListItem Sitem in ddlData2.Items
                                         where Sitem.Text == item
                                         select Sitem.Text).ToList();

                if (ddl1SelectionText.Count > 0)
                {
                    this.ddlData1.ClearSelection();
                    this.ddlData1.Items.FindByText(item).Selected = true;
                }
                
                if (ddl2SelectionText.Count>0 )
                {
                    this.ddlData2.ClearSelection();
                    this.ddlData2.Items.FindByText(item).Selected = true;
                    //this.ddlData2.SelectedItem.Text = item;
                    //this.ddlData2.SelectedValue = "1";
                }
            }
        }
        txtReason.Text = lEditInvestigation[0].Reason;
        txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
        txtDilution.Text = lEditInvestigation[0].Dilution;

        lblPVisitID.Text = Convert.ToString(PatientVisitID);
        lblPatternID.Text = Convert.ToString(PatternID);
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(POrgid);
        lblPatternClassName.Text = "Investigation_HematPattern6";
        //Delta CheckUp 
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "block");
        }

    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            //ddlData1.Enabled = value;
            //ddlData2.Enabled = value;
            //lnkEdit.Visible = true;

            //Modified by Perumal on 23 Jan 2012
            //txtReason.BackColor = System.Drawing.Color.RosyBrown;
            //txtReason.ForeColor = System.Drawing.Color.Black;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            //txtRefRange.BackColor = System.Drawing.Color.RosyBrown;
            //txtRefRange.ForeColor = System.Drawing.Color.Black;
            txtRefRange.ReadOnly = value == false ? true : false;
            //ddlData1.BackColor = System.Drawing.Color.RosyBrown;
            //ddlData1.ForeColor = System.Drawing.Color.Black;
            //ddlData2.BackColor = System.Drawing.Color.RosyBrown;
            //ddlData2.ForeColor = System.Drawing.Color.Black;
            //ddlstatus.BackColor = System.Drawing.Color.RosyBrown;
            //ddlstatus.ForeColor = System.Drawing.Color.Black;

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
        txtDilution.Attributes.Add("readOnly", "true");

        ddlData1.Enabled = false;
        ddlData2.Enabled = false;
        //ddlstatus.Enabled = false;
        //ddlStatusReason.Enabled = false;
        ddlData1.Font.Bold = true;
        ddlData2.Font.Bold = true;
        ddlstatus.Font.Bold = true;
        ddlStatusReason.Font.Bold = true;
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
