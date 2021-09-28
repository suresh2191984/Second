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

public partial class Investigation_MicroBioPattern1 : BaseControl
{
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
            hidVal.Value = id;
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

        string sPath = Request.Url.AbsolutePath;
        int iIndex = sPath.LastIndexOf("/");

        sPath = sPath.Remove(iIndex, sPath.Length - iIndex);
        sPath = Request.ApplicationPath ;
        sPath = sPath + "/fckeditor/";
        txtImpression.BasePath = sPath;
        txtImpression.ToolbarSet = "Default";
        txtImpression.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        txtImpression.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        txtGross.BasePath = sPath;
        txtGross.ToolbarSet = "Default";
        txtGross.ImageBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Type=Image&Connector=connectors/aspx/connector.aspx";
        txtGross.LinkBrowserURL = sPath + "editor/filemanager/browser/default/browser.html?Connector=connectors/aspx/connector.aspx";

        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "lblfckID", String.Format("var lblfckID=\"{0}\";", txtMicroscopy.ClientID), true);

        Page.ClientScript.RegisterOnSubmitStatement(txtGross.GetType(), txtGross.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtGross.ClientID + "').UpdateLinkedField();");
        Page.ClientScript.RegisterOnSubmitStatement(txtGross.GetType(), txtImpression.ClientID + "editor", "FCKeditorAPI.GetInstance('" + txtImpression.ClientID + "').UpdateLinkedField();");

        txtSpecimen.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtSource.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtDay1.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtResult1.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtDay2.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtResult2.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtDay3.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtResult3.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtDay4.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtResult4.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtClinicalDiagnosis.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtClinicalNotes.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMethodsUsed.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtStainUsed.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtTechnique.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
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
        //for (int i = 0; i < lstValues.Count; i++)
        //{
        //    lblName.Text = lstValues[i].Value;

        //}
        foreach (InvestigationValues invValues in lstValues)
        {

            string[] days = invValues.Value.Split('-');

            if (days.Count() == 0)
            {

                if (invValues.Name == "Specimen")
                {
                    txtSpecimen.Text = invValues.Value;
                }
                if (invValues.Name == "Source")
                {
                    txtSource.Text = invValues.Value;
                }
                if (invValues.Name == "Clinical Diagnosis")
                {
                    txtClinicalDiagnosis.Text = invValues.Value;
                }
                if (invValues.Name == "Clinical Notes")
                {
                    txtClinicalNotes.Text = invValues.Value;
                }
                if (invValues.Name == "Method Used")
                {
                    txtMethodsUsed.Text = invValues.Value;
                }
                if (invValues.Name == "Stain(S) Used")
                {
                    txtStainUsed.Text = invValues.Value;
                }
                if (invValues.Name == "Technique")
                {
                    txtTechnique.Text = invValues.Value;
                }
                if (invValues.Name == "Microscopy")
                {
                    txtGross.Value = invValues.Value;
                }
                if (invValues.Name == "Technique")
                {
                    txtTechnique.Text = invValues.Value;
                }

                if (invValues.Name == "Impression")
                {
                    txtImpression.Value = invValues.Value;
                }
            }
            else
            {

                if (days[0] == "Day 1 ")
                {
                    txtDay1.Text = days[1];
                    txtResult1.Text = invValues.Value.Trim();
                }

                if (days[0] == "Day 2 ")
                {
                    txtDay2.Text = days[1];
                    txtResult2.Text = invValues.Value.Trim();
                }

                if (days[0] == "Day 3 ")
                {
                    txtDay3.Text = days[1];
                    txtResult3.Text = invValues.Value.Trim();
                }


                if (days[0] == "Day 4 ")
                {
                    txtDay4.Text = days[1];
                    txtResult4.Text = invValues.Value.Trim();
                }

            }

        }
    }
    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
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
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);
        Pinv.AutoApproveLoginID = AutoApproveLoginID;
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
    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstInvestigationVal = new List<InvestigationValues>();
        InvestigationValues obj;
        String[] status;
        //obj = new InvestigationValues();
        //obj.InvestigationID = Convert.ToInt32(ControlID);
        //obj.Name = lblTestName.Text;
        //obj.Value = txtTestName.Text;
        //obj.PatientVisitID = VID;
        //obj.CreatedBy = LID;
        //obj.GroupName = GroupName;
        //obj.GroupID = groupID;
        //obj.Orgid = OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        //lstInvestigationVal.Add(obj);
        if (txtSpecimen.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSpecimen.Text;
            obj.Value = txtSpecimen.Text;
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
            obj.SequenceNo = 1;
            lstInvestigationVal.Add(obj);
        }
        if (txtSource.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblSource.Text;
            obj.Value = txtSource.Text;
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
            lstInvestigationVal.Add(obj);
        }

        if (txtDay1.Text != string.Empty && txtResult1.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblDay1.Text + " - " + txtDay1.Text;
            obj.Value = txtResult1.Text;
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
            obj.SequenceNo = 3;
            lstInvestigationVal.Add(obj);


        }

        if (txtDay2.Text != string.Empty && txtResult2.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblDay2.Text + " - " + txtDay2.Text;
            obj.Value = txtResult2.Text;
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
            lstInvestigationVal.Add(obj);


        }

        if (txtDay3.Text != string.Empty && txtResult3.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblDay3.Text + " - " + txtDay3.Text;
            obj.Value = txtResult3.Text;
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
            lstInvestigationVal.Add(obj);


        }

        if (txtDay4.Text != string.Empty && txtResult4.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblDay4.Text + " - " + txtDay4.Text;
            obj.Value = txtResult4.Text;
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
            obj.SequenceNo = 6;
            lstInvestigationVal.Add(obj);


        }





        if (txtClinicalNotes.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblClinicalNotes.Text;
            obj.Value = txtClinicalNotes.Text;
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
            obj.SequenceNo = 7;
            lstInvestigationVal.Add(obj);
        }
        if (txtClinicalDiagnosis.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblClinicalDiagnosis.Text;
            obj.Value = txtClinicalDiagnosis.Text;
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
            obj.SequenceNo = 8;
            lstInvestigationVal.Add(obj);
        }
        if (txtMethodsUsed.Text != string.Empty)
        {

            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMethodUsed.Text;
            obj.Value = txtMethodsUsed.Text;
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
            obj.SequenceNo = 9;
            lstInvestigationVal.Add(obj);
        }
        if (txtStainUsed.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblStainUsed.Text;
            obj.Value = txtStainUsed.Text;
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
            obj.SequenceNo = 10;
            lstInvestigationVal.Add(obj);
        }
        if (txtTechnique.Text != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblTechnique.Text;
            obj.Value = txtTechnique.Text;
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
            obj.SequenceNo = 11;
            lstInvestigationVal.Add(obj);
        }
        if (txtGross.Value != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblMicroscopy.Text;
            obj.Value = txtGross.Value;
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
            obj.SequenceNo = 12;
            lstInvestigationVal.Add(obj);
        }
        if (txtImpression.Value != string.Empty)
        {
            obj = new InvestigationValues();
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.Name = lblImpression.Text;
            obj.Value = txtImpression.Value;
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
            obj.SequenceNo = 13;
            lstInvestigationVal.Add(obj);
        }
        return lstInvestigationVal;
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
        // lblName.Text = lEditValues[0].Name;
        //foreach (var item in lEditValues)
        //{
        //    switch (item.Name)
        //    {
        //        case "Clinical Notes":
        //            txtClinicalNotes.Text = item.Value;
        //            break;

        //        case "Clinical Diagnosis":
        //            txtClinicalDiagnosis.Text = item.Value;
        //            break;

        //        case "Method Used":
        //            txtMethodsUsed.Text = item.Value;
        //            break;

        //        case "Stain(S) Used":
        //            txtStainUsed.Text = item.Value;
        //            break;

        //        case "Technique":
        //            txtTechnique.Text = item.Value;
        //            break;

        //        case "Microscopy":
        //            txtMicroscopy.Text = item.Value;
        //            break;

        //        case "Impression":
        //            txtImpression.Text = item.Value;
        //            break;



        //    }

        //}




        //for (int i = 0; i < lstValues.Count; i++)
        //{
        //    lblName.Text = lstValues[i].Value;

        //}
        foreach (InvestigationValues invValues in lEditValues)
        {

            string[] days = invValues.Name.Split('-');

            if (days.Count() == 1)
            {

                if (invValues.Name == "Specimen")
                {
                    txtSpecimen.Text = invValues.Value;
                }
                if (invValues.Name == "Source")
                {
                    txtSource.Text = invValues.Value;
                }
                if (invValues.Name == "Clinical Diagnosis")
                {
                    txtClinicalDiagnosis.Text = invValues.Value;
                }
                if (invValues.Name == "Clinical Notes")
                {
                    txtClinicalNotes.Text = invValues.Value;
                }
                if (invValues.Name == "Method Used")
                {
                    txtMethodsUsed.Text = invValues.Value;
                }
                if (invValues.Name == "Stain(S) Used")
                {
                    txtStainUsed.Text = invValues.Value;
                }
                if (invValues.Name == "Technique")
                {
                    txtTechnique.Text = invValues.Value;
                }
                if (invValues.Name == "Microscopy")
                {
                    txtGross.Value = invValues.Value;
                }
                if (invValues.Name == "Technique")
                {
                    txtTechnique.Text = invValues.Value;
                }

                if (invValues.Name == "Impression")
                {
                    txtImpression.Value = invValues.Value;
                }
            }
            else
            {

                if (days[0] == "Day 1 ")
                {
                    txtDay1.Text = days[1].Trim();
                    txtResult1.Text = invValues.Value.Trim();
                }

                if (days[0] == "Day 2 ")
                {
                    txtDay2.Text = days[1].Trim();
                    txtResult2.Text = invValues.Value.Trim();
                }

                if (days[0] == "Day 3 ")
                {
                    txtDay3.Text = days[1].Trim();
                    txtResult3.Text = invValues.Value.Trim();
                }


                if (days[0] == "Day 4 ")
                {
                    txtDay4.Text = days[1].Trim();
                    txtResult4.Text = invValues.Value.Trim();
                }

            }

        }

        txtReason.Text = lEditValues[0].Reason;
        txtMedRemarks.Text = lEditValues[0].MedicalRemarks;
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
        pnlenabled.Enabled = true;
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
    private long autoApproveLoginID = -1;
    public long AutoApproveLoginID
    {
        get { return autoApproveLoginID; }
        set { autoApproveLoginID = value; }
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
