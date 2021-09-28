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
using System.Xml;
using System.Xml.Linq;
using System.Web.Script.Serialization;

public partial class Investigation_CultureandSensitivityReportV1 : BaseControl
{

    public Investigation_CultureandSensitivityReportV1()
        : base("Investigation_CultureandSensitivityReportV1_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private string controlName = string.Empty;
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
    string tid;
    public string TID
    {
        get { return tid; }
        set
        {
            tid = value;
            //sAutoRname.TargetControlID = tid + "_txtSensitive";

        }
    }
    public string ControlName
    {
        get { return controlName; }
        set
        {
            controlName = value;

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
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            txtReason.Enabled = value;
            lnkEdit.Visible = true;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtReason.BackColor = System.Drawing.Color.RosyBrown;
            txtReason.ForeColor = System.Drawing.Color.Black;
            txtMedRemarks.BackColor = System.Drawing.Color.RosyBrown;
            txtMedRemarks.ForeColor = System.Drawing.Color.Black;
            //ddlSample.Enabled = value == true ? true : false;
            //ddlSample.BackColor = System.Drawing.Color.RosyBrown;
            //ddlSample.ForeColor = System.Drawing.Color.Black;
            txtSource.ReadOnly = value == false ? true : false;
            txtSource.BackColor = System.Drawing.Color.RosyBrown;
            txtSource.ForeColor = System.Drawing.Color.Black;
            ddlData.BackColor = System.Drawing.Color.RosyBrown;
            ddlData.ForeColor = System.Drawing.Color.Black;
            txtClinicalDiagnosis.ReadOnly = value == false ? true : false;
            txtClinicalDiagnosis.BackColor = System.Drawing.Color.RosyBrown;
            txtClinicalDiagnosis.ForeColor = System.Drawing.Color.Black;
            //txtClinicalNotes.ReadOnly = value == false ? true : false;
            //txtClinicalNotes.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalNotes.ForeColor = System.Drawing.Color.Black;
            //txtMicroscopy.ReadOnly = value == false ? true : false;
            txtMicroscopy.BackColor = System.Drawing.Color.RosyBrown;
            txtMicroscopy.ForeColor = System.Drawing.Color.Black;
            //txtCultureReport.ReadOnly = value == false ? true : false;
            txtCultureReport.BackColor = System.Drawing.Color.RosyBrown;
            txtCultureReport.ForeColor = System.Drawing.Color.Black;
            //ddlGrowth.Enabled = value == true ? true : false;
            ddlGrowth.BackColor = System.Drawing.Color.RosyBrown;
            ddlGrowth.ForeColor = System.Drawing.Color.Black;
            //ddlGrowthStatus.BackColor = System.Drawing.Color.RosyBrown;
            //ddlGrowthStatus.ForeColor = System.Drawing.Color.Black;
            //txtColonyCount.ReadOnly = value == false ? true : false;
            //ddlColonyCount.Enabled = value == true ? true : false;
            //ddlColonyCount.BackColor = System.Drawing.Color.RosyBrown;
            //ddlColonyCount.ForeColor = System.Drawing.Color.Black;
            //ddlOrganismName.Enabled = value == true ? true : false;
            ddlOrganismName.BackColor = System.Drawing.Color.RosyBrown;
            ddlOrganismName.ForeColor = System.Drawing.Color.Black;
            //txtOrgan.ReadOnly = value == false ? true : false;
            //txtOrgan.BackColor = System.Drawing.Color.RosyBrown;
            //txtOrgan.ForeColor = System.Drawing.Color.Black;
            ddlstatus.BackColor = System.Drawing.Color.RosyBrown;

            //tblOrganismFirstLine.Enabled = value == true ? true : false;
            //tblOrganismSecondLine.Enabled = value == true ? true : false;
            //tblOrganismThirdLine.Enabled = value == true ? true : false;
            //tblOrganismForthLine.Enabled = value == true ? true : false;
            // txtRefRange.BackColor = System.Drawing.Color.RosyBrown;

        }
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
    //public void LoadDataForEdit(List<InvestigationValues> lEditValues)
    //{
    //    lblName.Text = lEditValues[0].Name;
    //    foreach (var item in lEditValues)
    //    {
    //        switch (item.Name)
    //        {
    //            case "Sample Name":
    //                txtSample.Text = item.Value;
    //                break;

    //            case "Source":
    //                txtSource.Text = item.Value;
    //                break;

    //            case "ReportStatus":
    //                ddlData.Text = item.Value;
    //                break;

    //            case "Clinical Diagnosis":
    //                txtClinicalDiagnosis.Text = item.Value;
    //                break;

    //            case "Clinical Notes":
    //                txtClinicalNotes.Text = item.Value;
    //                break;

    //            case "Microscopy &lt;br&gt; &nbsp; Gram's stain":
    //                txtMicroscopy.Text = item.Value;
    //                break;

    //            case "CultureReport":
    //                txtCultureReport.Text = item.Value;
    //                break;

    //            case "Growth":
    //                txtGrowth.Text = item.Value;
    //                break;

    //            case "Growth Status":
    //                ddlGrowthStatus.Text = item.Value;
    //                break;

    //            case "Colony Count":
    //                txtColonyCount.Text = item.Value;
    //                break;

    //            case "No of Organism Found":
    //                txtOrgan.Text = item.Value;
    //                break;               

    //        }

    //    }
    //}
    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        txtCultureReport.Attributes.Add("readOnly", "true");
        txtSource.Attributes.Add("readOnly", "true");
        //txtReason.Attributes.Add("readOnly", "true");
        //txtMedRemarks.Attributes.Add("readOnly", "true");
        txtReason.BackColor = System.Drawing.Color.RosyBrown;
        txtReason.ForeColor = System.Drawing.Color.Black;
        txtMedRemarks.BackColor = System.Drawing.Color.RosyBrown;
        txtMedRemarks.ForeColor = System.Drawing.Color.Black;
        //ddlSample.BackColor = System.Drawing.Color.RosyBrown;
        //ddlSample.ForeColor = System.Drawing.Color.Black;       
        txtSource.BackColor = System.Drawing.Color.RosyBrown;
        txtSource.ForeColor = System.Drawing.Color.Black;
        txtCultureReport.BackColor = System.Drawing.Color.RosyBrown;
        txtCultureReport.ForeColor = System.Drawing.Color.Black;
        ddlGrowth.BackColor = System.Drawing.Color.RosyBrown;
        ddlGrowth.ForeColor = System.Drawing.Color.Black;
        //ddlColonyCount.BackColor = System.Drawing.Color.RosyBrown;
        //ddlColonyCount.ForeColor = System.Drawing.Color.Black; 
        ddlOrganismName.BackColor = System.Drawing.Color.RosyBrown;
        ddlOrganismName.ForeColor = System.Drawing.Color.Black;
        ddlstatus.BackColor = System.Drawing.Color.RosyBrown;

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
    private string currentRoleName = string.Empty;
    public string CurrentRoleName
    {
        get { return currentRoleName; }
        set
        {
            currentRoleName = value;
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


    #region "Initial"

    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        //sAutoRname.ContextKey = Convert.ToString(Convert.ToInt32(POrgid));
        //aModerate.ContextKey = Convert.ToString(Convert.ToInt32(POrgid));
        //atResistant.ContextKey = Convert.ToString(Convert.ToInt32(POrgid));
        string filtertxt = "";
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        new Patient_BL(base.ContextInfo).GetInvestigationDrug(Convert.ToInt32(POrgid), filtertxt, out lstPrescription);
        string DName = string.Empty;
        foreach (PatientPrescription pPrescription in lstPrescription)
        {
            DName += DName != string.Empty ? "$" + pPrescription.BrandName : pPrescription.BrandName;
        }
        drugname.Value = DName;
        List<PatientInvSample> lstInvestigationSampleItem = new List<PatientInvSample>();
        long patientVisitID = -1;
        Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
        /////////////////karthick///////////////////
        new Investigation_BL().GetSampleItem(Convert.ToInt32(POrgid), Convert.ToInt32(ControlID), patientVisitID, out lstInvestigationSampleItem);
        txtSource.Text = lstInvestigationSampleItem[0].SampleDesc;
        if (!IsPostBack)
        {
            Table tblFirstLine = (Table)FindControl("tblOrganismFirstLine");
            Table tblSecondLine = (Table)FindControl("tblOrganismSecondLine");
            Table tblThirdLine = (Table)FindControl("tblOrganismThirdLine");
            Table tblForthLine = (Table)FindControl("tblOrganismForthLine");
            BindSensitivityEvent(tblFirstLine, "First_Line");
            BindSensitivityEvent(tblSecondLine, "Second_Line");
            BindSensitivityEvent(tblThirdLine, "Third_Line");
            BindSensitivityEvent(tblForthLine, "Forth_Line");

        }
        hlnkAdd.Attributes.Add("onclick", "changeSourceName(this.id,'" + ddlGrowth.ClientID + "','Growth')");
        hlnkAdd.Attributes.Add("onmouseover", "this.style.cursor='hand'");
        ddlData.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtSource.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtCultureReport.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMicroscopy.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        ddlstatus.Attributes.Add("onchange", "ShowStatusReason(this.id);");

        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }

    #endregion

    #region "Events"
    protected void btnOrgADD_Click(object sender, EventArgs e)
    {
        if (ddlOrganismName.SelectedValue != "Select")
        {

            LoadXMLDrugList(ddlOrganismName.SelectedValue, "ButtonClick");



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

    #endregion

    #region "Methods"
    public void clearDrugList()
    {

        ArrayList line = new ArrayList { "First_Line", "Second_Line", "Third_Line", "Forth_Line" };

        for (int i = 0; i < line.Count; i++)
        {


            for (int j = 1; j <= 10; j++)
            {

                string txtdrugId = "txt" + line[i] + "DrugName" + j;
                string txtZoneId = "txt" + line[i] + "Zone" + j;
                string ddlSensitivityId = "tc" + line[i] + "ddlSensitivity" + j;
                TextBox txtDrugName = (TextBox)FindControl(txtdrugId);
                txtDrugName.Text = "";

                TextBox txtZoneName = (TextBox)FindControl(txtZoneId);
                txtZoneName.Text = "";

                DropDownList ddlSensitivity = (DropDownList)FindControl(ddlSensitivityId);
                ddlSensitivity.SelectedValue = "Select";


            }


        }


    }
    public void LoadXMLDrugList(string xmlDrugList, string type)
    {
        XmlDocument xmlAddOrg = new XmlDocument();
        xmlAddOrg.LoadXml(xmlDrugList);
        clearDrugList();
        int DrugCount = xmlAddOrg.GetElementsByTagName("Organ").Count;
        int drugFirstLinecount = 0;
        int drugSecondLinecount = 0;
        int drugThirdLinecount = 0;
        int drugForthLinecount = 0;
        bool selectorganisum = true;
        for (int i = 0; i < DrugCount; i++)
        {
            string OrgnismSeq = xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(0).Value;
            string OrgnismName = xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(1).Value;
            int LineSeq = Convert.ToInt32(xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(2).Value);
            string LineName = xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(3).Value.Replace(' ', '_');
            string DrugName = xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(4).Value;
            string Zone = string.Empty;
            string Sensitivity = string.Empty;
            if (xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(5) != null)
            {
                Zone = xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(5).Value;
            }
            if (xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(6) != null)
            {
                Sensitivity = xmlAddOrg.GetElementsByTagName("Organ")[i].Attributes.Item(6).Value;
            }

            if (type == "LoadData")
            {
                foreach (ListItem itm in ddlOrganismName.Items)
                {
                    itm.Selected = false;
                    if (itm.Text == OrgnismName && selectorganisum == true)
                    {
                        itm.Selected = true;
                        selectorganisum = false;
                    }
                }
            }


            if (LineSeq == 1)
            {
                drugFirstLinecount++;
                string txtdrugId = "txt" + LineName + "DrugName" + drugFirstLinecount;
                string txtZoneId = "txt" + LineName + "Zone" + drugFirstLinecount;
                string ddlSensitivityId = "tc" + LineName + "ddlSensitivity" + drugFirstLinecount;
                TextBox txtDrugName = (TextBox)FindControl(txtdrugId);
                txtDrugName.Text = DrugName;


                TextBox txtZoneName = (TextBox)FindControl(txtZoneId);
                txtZoneName.Text = Zone;


                DropDownList ddlSensitivity = (DropDownList)FindControl(ddlSensitivityId);
                if (Sensitivity != "")
                {
                    if (Sensitivity == "Resistive")
                    {
                        ddlSensitivity.SelectedValue = "Resistant";
                    }
                    else
                    {
                        ddlSensitivity.SelectedValue = Sensitivity;
                    }
                }
                else { ddlSensitivity.SelectedValue = "Select"; }


            }

            if (LineSeq == 2)
            {
                drugSecondLinecount++;
                string txtdrugId = "txt" + LineName + "DrugName" + drugSecondLinecount;
                string txtZoneId = "txt" + LineName + "Zone" + drugSecondLinecount;
                string ddlSensitivityId = "tc" + LineName + "ddlSensitivity" + drugSecondLinecount;
                TextBox txtDrugName = (TextBox)FindControl(txtdrugId);
                txtDrugName.Text = DrugName;

                TextBox txtZoneName = (TextBox)FindControl(txtZoneId);
                txtZoneName.Text = Zone;

                DropDownList ddlSensitivity = (DropDownList)FindControl(ddlSensitivityId);
                if (Sensitivity != "")
                {
                    if (Sensitivity == "Resistive")
                    {
                        ddlSensitivity.SelectedValue = "Resistant";
                    }
                    else
                    {
                        ddlSensitivity.SelectedValue = Sensitivity;
                    }

                }
                else { ddlSensitivity.SelectedValue = "Select"; }


            }
            if (LineSeq == 3)
            {
                drugThirdLinecount++;
                string txtdrugId = "txt" + LineName + "DrugName" + drugThirdLinecount;
                string txtZoneId = "txt" + LineName + "Zone" + drugThirdLinecount;
                string ddlSensitivityId = "tc" + LineName + "ddlSensitivity" + drugThirdLinecount;
                TextBox txtDrugName = (TextBox)FindControl(txtdrugId);
                txtDrugName.Text = DrugName;

                TextBox txtZoneName = (TextBox)FindControl(txtZoneId);
                txtZoneName.Text = Zone;

                DropDownList ddlSensitivity = (DropDownList)FindControl(ddlSensitivityId);
                if (Sensitivity != "")
                {
                    if (Sensitivity == "Resistive")
                    {
                        ddlSensitivity.SelectedValue = "Resistant";
                    }
                    else
                    {
                        ddlSensitivity.SelectedValue = Sensitivity;
                    }
                }
                else { ddlSensitivity.SelectedValue = "Select"; }


            }
            if (LineSeq == 4)
            {
                drugForthLinecount++;
                string txtdrugId = "txt" + LineName + "DrugName" + drugForthLinecount;
                string txtZoneId = "txt" + LineName + "Zone" + drugForthLinecount;
                string ddlSensitivityId = "tc" + LineName + "ddlSensitivity" + drugForthLinecount;
                TextBox txtDrugName = (TextBox)FindControl(txtdrugId);
                txtDrugName.Text = DrugName;

                TextBox txtZoneName = (TextBox)FindControl(txtZoneId);
                txtZoneName.Text = Zone;

                DropDownList ddlSensitivity = (DropDownList)FindControl(ddlSensitivityId);
                if (Sensitivity != "")
                {
                    if (Sensitivity == "Resistive")
                    {
                        ddlSensitivity.SelectedValue = "Resistant";
                    }
                    else
                    {
                        ddlSensitivity.SelectedValue = Sensitivity;
                    }
                }
                else { ddlSensitivity.SelectedValue = "Select"; }


            }



        }
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "NotifyLoadingDrug", "reloadauto();", true);
    }
    public void BindSensitivityEvent(Table tblID, string linename)
    {

        Table tbll = (Table)tblID;
        TextBox Drugtbox;
        DropDownList SensitivityDDL;
        int rowNo = -1;
        foreach (TableRow tr in tbll.Rows)
        {


            rowNo++;
            string textID = string.Empty;
            foreach (TableCell tc in tr.Cells)
            {



                foreach (Control c in tc.Controls)
                {
                    if (c.GetType() == typeof(TextBox))
                    {
                        Drugtbox = (TextBox)c;


                        if (Drugtbox.ID.Contains("txt" + linename + "Zone" + rowNo))
                        {

                            Drugtbox.Attributes.Add("onblur", "Addmm('" + Drugtbox.ClientID + "');");
                            Drugtbox.Attributes.Add("onfocus", "Removemm('" + Drugtbox.ClientID + "');");
                            textID = Drugtbox.ClientID;
                        }

                    }


                    if (c.GetType() == typeof(DropDownList))
                    {
                        SensitivityDDL = (DropDownList)c;


                        if (SensitivityDDL.ID.Contains("tc" + linename + "ddlSensitivity" + rowNo))
                        {


                            SensitivityDDL.Attributes.Add("onchange", "ChangeNoZone('" + SensitivityDDL.ClientID + "','" + textID + "');");

                        }
                    }
                }
            }
        }
    }
    public void LoadData(List<InvestigationValues> lstData)
    {
        ddlData.Items.Add(new ListItem("Select", "0"));
        ddlGrowth.Items.Add(new ListItem("Select", "0"));
        //ddlColonyCount.Items.Add(new ListItem("Select", "0"));
        //ddlSample.Items.Add(new ListItem("Select", "0"));

        foreach (InvestigationValues invValues in lstData)
        {
            if (invValues.Name == "Reporting Status")
            {
                ddlData.Items.Add(invValues.Value);
            }
            else if (invValues.Name == "Growth")
            {
                ddlGrowth.Items.Add(invValues.Value);
            }
            //else if (invValues.Name == "Sample")
            //{
            //    ddlSample.Items.Add(invValues.Value);
            //}
            else if (invValues.Name == "Culture Report")
            {
                txtCultureReport.Text = invValues.Value;
            }
            //else if (invValues.Name == "ColonyCount")
            //{
            //    ddlColonyCount.Items.Add(invValues.Value);
            //}

        }

        // ddlData.SelectedIndex = 0;
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
    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstValues = new List<InvestigationValues>();
        InvestigationValues obj = new InvestigationValues();
        String[] status;
        //if ((ddlData.SelectedItem.Text != "Select") || (txtCultureReport.Text != string.Empty) || (txtMicroscopy.Text != string.Empty) || (hresistantto.Value != string.Empty))
        //{
        obj = new InvestigationValues();
        obj.Name = lblName.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.Value = CreateXML();
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
        obj.GroupName = GroupName;
        obj.GroupID = groupID;
        obj.CreatedBy = LID;
        obj.ModifiedBy = LID;
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lstValues.Add(obj);
        //}
        return lstValues;
    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        string strSel = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;

        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.ReportStatus = ddlData.SelectedItem.Text;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.AccessionNumber = AccessionNumber;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        if (ddlStatusReason.Items.Count > 0)
        {
            Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == strSel.Trim() ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
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

        //sAutoRname.TargetControlID = this.FindControl(id.Split('_')[0] + "_txtSensitive").ClientID;
        //mSAutoBrandname.TargetControlID = id.Split('_')[0] + "_txtMSensitive";
        //sRAutoName.TargetControlID = id.Split('_')[0] + "_txtResistant";

        //sAutoRname.TargetControlID = id.Split('_')[0] + "_txtSensitive";
        //mSAutoBrandname.TargetControlID = id.Split('_')[0] + "_txtMSensitive";
        //sRAutoName.TargetControlID = id.Split('_')[0] + "_txtResistant";
    }
    public string CreateXML()
    {

        //OrganName:E-coli~RID:1~sTO:Sens^
        //OrganName:E-coli~RID:2~rTO:RES^
        //OrganName:E-coli~RID:3~mTO:MOD^

        XmlDocument xmlDoc = new XmlDocument();
        XmlElement xmlElement;
        XmlElement xmlElementOrgansim;
        XmlNode xmlNode;
        XmlNode xmlNodeOrgan;
        xmlDoc.LoadXml("<InvestigationResults></InvestigationResults>");
        xmlElement = xmlDoc.CreateElement("InvestigationDetails");
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationName", "");

        //Investigation  name node
        xmlNode.InnerText = Name;
        xmlElement.AppendChild(xmlNode);

        //Investigation id node
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationID", "");
        xmlNode.InnerText = ControlID;
        xmlElement.AppendChild(xmlNode);

        //microscopy node
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Microscopy", "");
        xmlNode.InnerText = txtMicroscopy.Text;
        xmlElement.AppendChild(xmlNode);

        //reportstatus node
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ReportStatus", "");
        xmlNode.InnerText = ddlData.SelectedItem.Text == "Select" ? "" : ddlData.SelectedItem.Text;
        xmlElement.AppendChild(xmlNode);

        //culture report node
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "CultureReport", "");
        xmlNode.InnerText = txtCultureReport.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //Clinical Diagnosis
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ClinicalDiagnosis", "");
        xmlNode.InnerText = txtClinicalDiagnosis.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        ////Clinical Notes
        //xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ClinicalNotes", "");
        //xmlNode.InnerText = txtClinicalNotes.Text;
        //xmlElement.AppendChild(xmlNode);
        //xmlDoc.DocumentElement.AppendChild(xmlElement);

        //if (ddlSample.SelectedItem.Text != "Select")
        //{
        //    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SampleName", "");
        //    xmlNode.InnerText = ddlSample.SelectedItem.Text;
        //    xmlElement.AppendChild(xmlNode);
        //    xmlDoc.DocumentElement.AppendChild(xmlElement);
        //}

        //Source

        if (txtSource.Text != "")
        {
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Source", "");
            xmlNode.InnerText = txtSource.Text;
            xmlElement.AppendChild(xmlNode);
            xmlDoc.DocumentElement.AppendChild(xmlElement);
        }

        //Growth
        if (ddlGrowth.SelectedItem.Text != "Select")
        {
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Growth", "");
            xmlNode.InnerText = ddlGrowth.SelectedItem.Text;
            xmlElement.AppendChild(xmlNode);
            xmlDoc.DocumentElement.AppendChild(xmlElement);
        }


        //Growth Status
        //xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "GrowthStatus", "");
        //xmlNode.InnerText = ddlGrowthStatus.SelectedItem.Text == "Select" ? "" : ddlGrowthStatus.SelectedValue; //ddlGrowthStatus.SelectedValue.ToString(); 
        //xmlElement.AppendChild(xmlNode);
        //xmlDoc.DocumentElement.AppendChild(xmlElement);


        ////Colony Count
        //if (ddlColonyCount.SelectedItem.Text != "Select")
        //{
        //    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ColonyCount", "");
        //    xmlNode.InnerText = ddlColonyCount.SelectedItem.Text;
        //    xmlElement.AppendChild(xmlNode);
        //    xmlDoc.DocumentElement.AppendChild(xmlElement);
        //}

        //OrganName:e-COLI~RID:1~sTO:amp^
        //OrganName:e-COLI~RID:2~rTO:amoxylin^
        //OrganName:e-COLI~RID:3~rTO:amp1^

        //OrganName:e-COLI2~RID:4~rTO:amoxylin^
        //OrganName:e-COLI2~RID:5~sTO:amp^
        //OrganName:e-COLI2~RID:6~rTO:amp1^



        //Organ Detaila

        xmlElementOrgansim = xmlDoc.CreateElement("OrganDetails");

        Table tblFirstLine = (Table)FindControl("tblOrganismFirstLine");
        Table tblSecondLine = (Table)FindControl("tblOrganismSecondLine");
        Table tblThirdLine = (Table)FindControl("tblOrganismThirdLine");
        Table tblForthLine = (Table)FindControl("tblOrganismForthLine");
        ControlCollection cc = new ControlCollection(Page);
        cc.Add(tblFirstLine); cc.Add(tblSecondLine); cc.Add(tblThirdLine); cc.Add(tblForthLine);
        ArrayList line = new ArrayList { "First_Line", "Second_Line", "Third_Line", "Forth_Line" };
        int i = 0;
        int lineNo = 1;
        foreach (Control tblC in cc)
        {

            Table tbll = (Table)tblC;





            TextBox Drugtbox;
            xmlNodeOrgan = null;
            DropDownList SensitivityDDL;
            int rowNo = -1;
            foreach (TableRow tr in tbll.Rows)
            {

                int drugcount = 0;
                bool addDrug = false;
                rowNo++;
                foreach (TableCell tc in tr.Cells)
                {



                    foreach (Control c in tc.Controls)
                    {
                        if (drugcount == 0) { xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", ""); drugcount = 1; }

                        if (c.GetType() == typeof(TextBox))
                        {
                            Drugtbox = (TextBox)c;

                            if (Drugtbox.ID.Contains("txt" + line[i] + "DrugName" + rowNo))
                            {

                                if ("" != Drugtbox.Text)
                                {

                                    addDrug = true;
                                    XmlAttribute xmlattribNameSeq = xmlDoc.CreateAttribute("NameSeq");
                                    xmlattribNameSeq.Value = "1";
                                    xmlNodeOrgan.Attributes.Append(xmlattribNameSeq);

                                    XmlAttribute xmlattribName = xmlDoc.CreateAttribute("Name");
                                    xmlattribName.Value = ddlOrganismName.SelectedItem.Text;
                                    xmlNodeOrgan.Attributes.Append(xmlattribName);

                                    XmlAttribute xmlattribLine = xmlDoc.CreateAttribute("Line");
                                    xmlattribLine.Value = lineNo.ToString();
                                    xmlNodeOrgan.Attributes.Append(xmlattribLine);

                                    XmlAttribute xmlattribLineName = xmlDoc.CreateAttribute("LineName");
                                    xmlattribLineName.Value = line[i].ToString().Replace('_', ' '); ;
                                    xmlNodeOrgan.Attributes.Append(xmlattribLineName);

                                    XmlAttribute xmlattribDrugName = xmlDoc.CreateAttribute("DrugName");
                                    xmlattribDrugName.Value = Drugtbox.Text;
                                    xmlNodeOrgan.Attributes.Append(xmlattribDrugName);

                                }
                            }

                            if (Drugtbox.ID.Contains("txt" + line[i] + "Zone" + rowNo))
                            {

                                if ("" != Drugtbox.Text)
                                {

                                    XmlAttribute xmlattribLineZone = xmlDoc.CreateAttribute("Zone");
                                    xmlattribLineZone.Value = Drugtbox.Text;
                                    xmlNodeOrgan.Attributes.Append(xmlattribLineZone);

                                }
                            }

                        }
                        if (c.GetType() == typeof(DropDownList))
                        {
                            SensitivityDDL = (DropDownList)c;

                            if (SensitivityDDL.ID.Contains("tc" + line[i] + "ddlSensitivity" + rowNo))
                            {

                                if ("Select" != SensitivityDDL.SelectedItem.Text)
                                {


                                    XmlAttribute xmlattribLineSensitivity = xmlDoc.CreateAttribute("Sensitivity");
                                    xmlattribLineSensitivity.Value = SensitivityDDL.SelectedValue.ToString();
                                    xmlNodeOrgan.Attributes.Append(xmlattribLineSensitivity);

                                }
                            }


                        }

                    }
                }
                if (drugcount == 1 && addDrug == true)
                {
                    xmlElementOrgansim.AppendChild(xmlNodeOrgan);
                }

            }
            i++;
            lineNo++;

        }



        //xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", "");
        //XmlAttribute xmlattrib = xmlDoc.CreateAttribute("NameSeq");
        //xmlattrib.Value = "1";
        //xmlNodeOrgan.Attributes.Append(xmlattrib);
        //xmlElementOrgansim.AppendChild(xmlNodeOrgan);


        xmlDoc.LastChild.FirstChild.AppendChild(xmlElementOrgansim);


        //xmlDoc.LastChild.FirstChild.AppendChild(xmlElementOrgansim);



        return xmlDoc.InnerXml;

    }
    void loadXmlValue(string xmlTag)
    {
        //OrganName:e-COLI~RID:1~sTO:amp^
        //OrganName:e-COLI~RID:2~rTO:amoxylin^
        //OrganName:e-COLI~RID:3~rTO:amp1^

        //OrganName:e-COLI2~RID:4~rTO:amoxylin^
        //OrganName:e-COLI2~RID:5~sTO:amp^
        //OrganName:e-COLI2~RID:6~rTO:amp1^
        //lblraw.Text = xmlTag;
        if (xmlTag != string.Empty)
        {
            string reportStatus, btnID, sensitivity = string.Empty;
            string moderate = string.Empty, resistant = string.Empty, organismName, dhidValue = string.Empty;
            int organismCount, rowID = 0;
            string drug = string.Empty;
            XmlDocument xmlEditdoc = new XmlDocument();
            xmlEditdoc.LoadXml(xmlTag);
            reportStatus = string.Empty;
            if (xmlEditdoc.GetElementsByTagName("ReportStatus").Item(0) != null)
            {
                reportStatus = xmlEditdoc.GetElementsByTagName("ReportStatus").Item(0).InnerText;
            }
            txtMicroscopy.Text = string.Empty;
            if (xmlEditdoc.GetElementsByTagName("Microscopy").Item(0) != null)
            {
                txtMicroscopy.Text = xmlEditdoc.GetElementsByTagName("Microscopy").Item(0).InnerText;
            }
            ddlData.ClearSelection();
            if (reportStatus != string.Empty)
            {
                ddlData.Items.FindByText(reportStatus).Selected = true;
            }
            txtCultureReport.Text = string.Empty;
            if (xmlEditdoc.GetElementsByTagName("CultureReport").Item(0) != null)
            {
                txtCultureReport.Text = xmlEditdoc.GetElementsByTagName("CultureReport").Item(0).InnerText;
            }
            txtClinicalDiagnosis.Text = string.Empty;
            if (xmlEditdoc.GetElementsByTagName("ClinicalDiagnosis").Item(0) != null)
            {
                txtClinicalDiagnosis.Text = xmlEditdoc.GetElementsByTagName("ClinicalDiagnosis").Item(0).InnerText;
            }
            //txtClinicalNotes.Text = xmlEditdoc.GetElementsByTagName("ClinicalNotes").Item(0).InnerText;
            //bool selectdrp1 = true;
            //if (xmlEditdoc.GetElementsByTagName("SampleName").Item(0) != null)
            //{
            //    selectdrp1 = true;
            //    foreach (ListItem itm in ddlSample.Items)
            //    {
            //        itm.Selected = false;
            //        if (itm.Text == xmlEditdoc.GetElementsByTagName("SampleName").Item(0).InnerText && selectdrp1 == true)
            //        {
            //            itm.Selected = true;
            //            selectdrp1 = false;
            //        }
            //    }

            //}
            txtSource.Text = string.Empty;
            if (xmlEditdoc.GetElementsByTagName("Source").Item(0) != null)
            {

                txtSource.Text = xmlEditdoc.GetElementsByTagName("Source").Item(0).InnerText;

            }

            string growth = string.Empty;
            if (xmlEditdoc.GetElementsByTagName("Growth").Item(0) != null)
            {
                growth = xmlEditdoc.GetElementsByTagName("Growth").Item(0).InnerText;
            }

            if (growth != string.Empty)
            {
                ddlGrowth.Items.FindByText(growth).Selected = true;
            }
            //bool selectdrp3 = true;
            //if (xmlEditdoc.GetElementsByTagName("Growth").Item(0) != null)
            //{


            //    selectdrp3 = true;
            //    foreach (ListItem itm in ddlGrowth.Items)
            //    {
            //        itm.Selected = false;
            //        if (itm.Text == xmlEditdoc.GetElementsByTagName("Growth").Item(0).InnerText && selectdrp3 == true)
            //        {
            //            itm.Selected = true;
            //            selectdrp3 = false;
            //        }
            //    }

            //}
            //ddlGrowthStatus.SelectedValue = xmlEditdoc.GetElementsByTagName("GrowthStatus").Item(0).InnerText;
            //bool selectdrp4 = true;
            //if (xmlEditdoc.GetElementsByTagName("ColonyCount").Item(0) != null)
            //{

            //    selectdrp4 = true;
            //    foreach (ListItem itm in ddlColonyCount.Items)
            //    {
            //        itm.Selected = false;
            //        if (itm.Text == xmlEditdoc.GetElementsByTagName("ColonyCount").Item(0).InnerText && selectdrp4 == true)
            //        {
            //            itm.Selected = true;
            //            selectdrp4 = false;
            //        }
            //    }


            //}
            btnID = btnOrgADD.ClientID;
            organismCount = xmlEditdoc.GetElementsByTagName("Organ").Count;

            if (organismCount > 0)
            {

                LoadXMLDrugList(xmlTag, "LoadData");

                //txtOrgan.Text = organismCount.ToString();
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), btnOrgADD.ClientID, "javascript:AddControl('" + btnOrgADD.ClientID + "');", true);

            }



        }
    }
    public void LoadOrganism(int Orgid, long ResultID, string ResultName, string TemplateType)
    {

        Investigation_BL inv_BL = new Investigation_BL(base.ContextInfo);
        List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
        inv_BL.GetInvestigationResultTemplateByID(Orgid, ResultID, ResultName, TemplateType, out lResultTemplate);

        ddlOrganismName.DataTextField = "ResultName";
        ddlOrganismName.DataValueField = "ResultValues";
        ddlOrganismName.DataSource = lResultTemplate;
        ddlOrganismName.DataBind();

        ddlOrganismName.Items.Insert(0, new ListItem("Select", "0"));
        ddlOrganismName.Items.Insert(1, new ListItem("Mycobacterium tuberculosis", "1"));
        ddlOrganismName.Items.Insert(2, new ListItem("Mycobacterium bovis", "2"));
        ddlOrganismName.SelectedValue = "0";



    }
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
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
    public void SetInvestigationValueForEdit(List<InvestigationValues> InvestigationData)
    {
        if (InvestigationData.Count > 0)
        {
            // lblName.Text = InvestigationData[0].Name;
            if (!IsPostBack)
            {

                loadXmlValue(InvestigationData[0].Value);
                txtReason.Text = InvestigationData[0].Reason;
                txtMedRemarks.Text = InvestigationData[0].MedicalRemarks;
            }

        }

    }
    #endregion

}



