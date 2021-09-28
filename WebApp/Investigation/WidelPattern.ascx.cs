using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.DataAccessLayer;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Web.Script.Serialization;

public partial class Investigation_WidelPattern : BaseControl
{
    private string name = string.Empty;
    private string controlID = string.Empty;
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
            Page.ClientScript.RegisterForEventValidation(ddlresult2.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
            Page.ClientScript.RegisterForEventValidation(ddlresult1.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
            Page.ClientScript.RegisterForEventValidation(ddlresult3.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
            Page.ClientScript.RegisterForEventValidation(ddlresult4.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
        }
        base.Render(writer);

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
        get { return controlID; }
        set { controlID = value; }
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
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        //code added on 23-07-2010 QRM - Started

        hlnkAdd1.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlresult2.ClientID + "','Result')");
        hlnkAdd1.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        txtdilution2.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlresult2.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);appendDDLHdn('" + ddlresult2.ClientID + "','" + hdnDDL1.ClientID + "')");
        
        hlnkAdd2.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlresult1.ClientID + "','Result')");
        hlnkAdd2.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        txtdilution1.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlresult1.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);appendDDLHdn('" + ddlresult1.ClientID + "','" + hdnDDL2.ClientID + "')");
        
        hlnkAdd3.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlresult3.ClientID + "','Result')");
        hlnkAdd3.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        txtdilution3.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlresult3.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);appendDDLHdn('" + ddlresult3.ClientID + "','" + hdnDDL3.ClientID + "')");

        hlnkAdd4.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlresult4.ClientID + "','Result')");
        hlnkAdd4.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        txtdilution4.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlresult4.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);appendDDLHdn('" + ddlresult4.ClientID + "','" + hdnDDL4.ClientID + "')");

        //code added on 23-07-2010 QRM - Completed
        //code added for reference range - begin
        txtdilution2.Attributes.Add("onblur", "javascript:validateResult('" + txtdilution2.ClientID + "','" + hdnXmlContent.ClientID + "','');");
        txtdilution1.Attributes.Add("onblur", "javascript:validateResult('" + txtdilution1.ClientID + "','" + hdnXmlContent.ClientID + "','');");
        txtdilution3.Attributes.Add("onblur", "javascript:validateResult('" + txtdilution3.ClientID + "','" + hdnXmlContent.ClientID + "','');");
        txtdilution4.Attributes.Add("onblur", "javascript:validateResult('" + txtdilution4.ClientID + "','" + hdnXmlContent.ClientID + "','');");

        //code added for reference range - ends


        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");

        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    
    public void LoadData(List<InvestigationValues> lstInves)
    {
       

        for (int i = 0; i < lstInves.Count; i++)
        {
            if (lstInves[i].Name == "Result")
            {
                ddlresult1.Items.Add(lstInves[i].Value);
                ddlresult2.Items.Add(lstInves[i].Value);
                ddlresult3.Items.Add(lstInves[i].Value);
                ddlresult4.Items.Add(lstInves[i].Value);
            }
        }

        //ddldilution1.Items.Insert(0, new ListItem("Select", "0"));
        //ddldilution2.Items.Insert(0, new ListItem("Select", "0"));
        //ddldilution3.Items.Insert(0, new ListItem("Select", "0"));
        //ddldilution4.Items.Insert(0, new ListItem("Select", "0"));

        ddlresult1.Items.Insert(0, new ListItem("Select", "0"));
        ddlresult2.Items.Insert(0, new ListItem("Select", "0"));
        ddlresult3.Items.Insert(0, new ListItem("Select", "0"));
        ddlresult4.Items.Insert(0, new ListItem("Select", "0"));
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInves = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        try
        {
            if ((txtdilution1.Text != string.Empty) || (txtdilution2.Text != string.Empty) ||
                (txtdilution3.Text != string.Empty) || (txtdilution4.Text != string.Empty) ||
                (ddlresult1.SelectedItem.Text != "Select") || (ddlresult2.SelectedItem.Text != "Select") ||
                (ddlresult3.SelectedItem.Text != "Select") || (ddlresult4.SelectedItem.Text != "Select"))
            {
                obj = new InvestigationValues();
                obj.InvestigationID = Convert.ToInt64(ControlID);
                obj.Name = lblName.Text;
                obj.PatientVisitID = VID;
                obj.CreatedBy = LID;
                obj.GroupName = GroupName;
                obj.GroupID = groupID;
                obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                obj.PackageID = PackageID;
                obj.PackageName = PackageName;
                obj.SequenceNo = 1;
                lstInves.Add(obj);


                hdnDDL1.Value = ((hdnDDL1.Value == "") || (hdnDDL1.Value == "0")) ? ddlresult2.SelectedItem.Text : hdnDDL1.Value;
                if ((hdnDDL1.Value != "Select") || (txtdilution2.Text != string.Empty))
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt64(ControlID);
                    obj.Name = "S. Typhi O";

                    if ((hdnDDL1.Value != "Select")||(ddlresult2.SelectedItem.Text != "Select"))
                    {
                        hdnDDL1.Value = hdnDDL1.Value == "" ? ddlresult2.SelectedItem.Text : hdnDDL1.Value;

                        obj.Value = txtdilution2.Text != "" ? hdnDDL1.Value.Trim() + " , " + txtdilution2.Text.Trim() : hdnDDL1.Value.Trim();
                    }
                    else if (txtdilution2.Text != string.Empty)
                    {
                        obj.Value = txtdilution2.Text.Trim();
                    }

                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                    //obj.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 2;
                    lstInves.Add(obj);
                }
                hdnDDL2.Value = ((hdnDDL2.Value == "") || (hdnDDL2.Value == "0")) ? ddlresult1.SelectedItem.Text : hdnDDL2.Value;
                if ((hdnDDL2.Value != "Select") || (txtdilution1.Text != string.Empty))
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt64(ControlID);
                    obj.Name = "S. Typhi H";

                    if ((hdnDDL2.Value != "Select")||(ddlresult1.SelectedItem.Text != "Select") )
                    {
                        hdnDDL2.Value = hdnDDL2.Value == "" ? ddlresult1.SelectedItem.Text : hdnDDL2.Value;
                        obj.Value = txtdilution1.Text != "" ? hdnDDL2.Value.Trim() + " , " + txtdilution1.Text.Trim() : hdnDDL2.Value.Trim();
                    }
                    else if (txtdilution1.Text != string.Empty)
                    {
                        obj.Value = txtdilution1.Text.Trim();
                    }
                    obj.PatientVisitID = VID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                    obj.CreatedBy = LID;
                    //obj.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 3;
                    lstInves.Add(obj);
                }
                hdnDDL3.Value = ((hdnDDL3.Value == "") || (hdnDDL3.Value == "0")) ? ddlresult3.SelectedItem.Text : hdnDDL3.Value;
                if ((hdnDDL3.Value != "Select") || (txtdilution3.Text != string.Empty))
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt64(ControlID);
                    obj.Name = "S. Paratyphi AH";
                    //obj.Value = ddldilution3.Text == "" ? ddlresult3.SelectedItem.Text : ddlresult3.SelectedItem.Text + " at " + ddldilution3.Text; ;

                    if ((hdnDDL3.Value != "Select")||(ddlresult3.SelectedItem.Text != "Select"))
                    {
                        hdnDDL3.Value = hdnDDL3.Value == "" ? ddlresult3.SelectedItem.Text : hdnDDL3.Value;
                        obj.Value = txtdilution3.Text != "" ? hdnDDL3.Value.Trim() + " , " + txtdilution3.Text.Trim() : hdnDDL3.Value.Trim();
                    }
                    else if (txtdilution3.Text != string.Empty)
                    {
                        obj.Value = txtdilution3.Text.Trim();
                    }

                    obj.PatientVisitID = VID;
                    obj.CreatedBy = LID;
                    obj.GroupName = GroupName;
                    obj.GroupID = groupID;
                    obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
                    //obj.Status = ddlstatus.SelectedItem.Text;
                    status = ddlstatus.SelectedValue.Split('_');
                    obj.Status = status[0].ToString();
                    obj.PackageID = PackageID;
                    obj.PackageName = PackageName;
                    obj.SequenceNo = 4;
                    lstInves.Add(obj);
                }
                hdnDDL4.Value = ((hdnDDL4.Value == "") || (hdnDDL4.Value == "0")) ? ddlresult4.SelectedItem.Text : hdnDDL4.Value;
                if ((hdnDDL4.Value != "Select") || (txtdilution4.Text != string.Empty))
                {
                    obj = new InvestigationValues();
                    obj.InvestigationID = Convert.ToInt64(ControlID);
                    obj.Name = "S. Paratyphi BH";
                    // obj.Value = ddldilution4.Text == "" ? ddlresult4.SelectedItem.Text : ddlresult4.SelectedItem.Text + " at " + ddldilution4.Text; ;
                    if ((hdnDDL4.Value != "Select")||(ddlresult4.SelectedItem.Text != "Select"))
                    {
                        hdnDDL4.Value = hdnDDL4.Value == "" ? ddlresult4.SelectedItem.Text : hdnDDL4.Value;
                        obj.Value = txtdilution4.Text != "" ? hdnDDL4.Value.Trim() + " , " + txtdilution4.Text.Trim() : hdnDDL4.Value.Trim();
                    }
                    else if (txtdilution4.Text != string.Empty)
                    {
                        obj.Value = txtdilution4.Text.Trim();
                    }

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
                    obj.SequenceNo = 5;
                    lstInves.Add(obj);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getresult in widel pattern", ex);
        }
        return lstInves;
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

        //ddlstatus.Items.FindByText("Pending").Selected = true;
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
        //code added for reference range - begin
        //Pinv.ReferenceRange = hdnXmlContent.Value;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        //code added for reference range - end
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        if (ddlStatusReason.Items.Count > 0)
        {
            Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == "-----Select-----" ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
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

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }

    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
       // lblName.Text = lEditInvestigation[0].Name;
        foreach (var item in lEditInvestigation)
        {
            if (item.Name == "S. Typhi H")
            {
                if (item.Value.Contains(","))
                {
                    ddlresult1.ClearSelection();
                    ddlresult1.Items.FindByText(item.Value.Split(',')[0].Trim()).Selected = true;
                    txtdilution1.Text = item.Value.Split(',')[1].Trim();
                }
                else
                {
                    //ddlresult1.ClearSelection();
                    //ddlresult1.Items.FindByText(item.Value.Split()[0].Trim()).Selected = true;
                    //txtdilution1.Text = item.Value.Split()[2];

                    ddlresult1.ClearSelection();
                    string ddlText = item.Value;
                    if (ddlresult1.Items.Contains(new ListItem(ddlText)))
                    {
                        ddlresult1.Items.FindByText(ddlText).Selected = true;
                    }
                    txtdilution1.Text = ddlText.Trim();
                }
            }
            else if (item.Name == "S. Typhi O")
            {
                if (item.Value.Contains(","))
                {
                    ddlresult2.ClearSelection();
                    ddlresult2.Items.FindByText(item.Value.Split(',')[0].Trim()).Selected = true;
                    txtdilution2.Text = item.Value.Split(',')[1].Trim();
                }
                else
                {
                    ddlresult2.ClearSelection();
                    string ddlText = item.Value;
                    if (ddlresult2.Items.Contains(new ListItem(ddlText)))
                    {
                        ddlresult2.Items.FindByText(ddlText).Selected = true;
                    }
                    txtdilution2.Text = ddlText.Trim();
                }
            }
            else if (item.Name == "S. Paratyphi AH")
            {

                if (item.Value.Contains(","))
                {//Positive , S. Typhi O
                    ddlresult3.ClearSelection();
                    ddlresult3.Items.FindByText(item.Value.Split(',')[0].Trim()).Selected = true;
                    txtdilution3.Text = item.Value.Split(',')[1].Trim();
                }
                else
                {
                    ddlresult3.ClearSelection();
                    string ddlText = item.Value;
                    if (ddlresult3.Items.Contains(new ListItem(ddlText)))
                    {
                        ddlresult3.Items.FindByText(ddlText).Selected = true;
                    }

                    //ddlresult3.ClearSelection();
                    //ddlresult3.Items.FindByText(item.Value.Split()[0].Trim()).Selected = true;
                    txtdilution3.Text = ddlText.Trim();
                }
            }
            else if (item.Name == "S. Paratyphi BH")
            {
                if (item.Value.Contains(","))
                {
                    ddlresult4.ClearSelection();
                    ddlresult4.Items.FindByText(item.Value.Split(',')[0].Trim()).Selected = true;
                    txtdilution4.Text = item.Value.Split(',')[1].Trim();
                }
                else
                {
                    ddlresult4.ClearSelection();
                    string ddlText = item.Value;
                    if (ddlresult4.Items.Contains(new ListItem(ddlText)))
                    {
                        ddlresult4.Items.FindByText(ddlText).Selected = true;
                    }
                    txtdilution4.Text = ddlText.Trim();
                }
            }
        }
        txtReason.Text = lEditInvestigation[0].Reason;
        txtMedRemarks.Text = lEditInvestigation[0].MedicalRemarks;
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
            txtRefRange.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
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
        hdnReadonly.Value = "true";
        pnlenabled.Enabled = true;
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");

        txtdilution1.Attributes.Add("readOnly", "true");
        txtdilution2.Attributes.Add("readOnly", "true");
        txtdilution3.Attributes.Add("readOnly", "true");
        txtdilution4.Attributes.Add("readOnly", "true");
        ddlresult1.Enabled = false;
        ddlresult2.Enabled = false;
        ddlresult3.Enabled = false;
        ddlresult4.Enabled = false;
        //ddlstatus.Enabled = false;
        //ddlStatusReason.Enabled = false;
        ddlresult1.ForeColor = System.Drawing.Color.Black;
        ddlresult1.Font.Bold = true;
        ddlresult2.ForeColor = System.Drawing.Color.Black;
        ddlresult2.Font.Bold = true;
        ddlresult3.ForeColor = System.Drawing.Color.Black;
        ddlresult3.Font.Bold = true;
        ddlresult4.ForeColor = System.Drawing.Color.Black;
        ddlresult4.Font.Bold = true;
        ddlstatus.ForeColor = System.Drawing.Color.Black;
        ddlstatus.Font.Bold = true;
        ddlStatusReason.ForeColor = System.Drawing.Color.Black;
        ddlStatusReason.Font.Bold = true;
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
