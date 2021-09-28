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


public partial class Investigation_CultureandSensitivityReport : BaseControl
{
    public Investigation_CultureandSensitivityReport()
        : base("Investigation_CultureandSensitivityReport_ascx")
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
    string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;


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
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;            
            lnkEdit.Visible = true;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            //txtReason.BackColor = System.Drawing.Color.RosyBrown;
            //txtReason.ForeColor = System.Drawing.Color.Black;
            txtSample.ReadOnly = value == false ? true : false;
            //txtSample.BackColor = System.Drawing.Color.RosyBrown;
            //txtSample.ForeColor = System.Drawing.Color.Black;
            txtSource.ReadOnly = value == false ? true : false;
            //txtSource.BackColor = System.Drawing.Color.RosyBrown;
            //txtSource.ForeColor = System.Drawing.Color.Black;
            //ddlData.BackColor = System.Drawing.Color.RosyBrown;
            //ddlData.ForeColor = System.Drawing.Color.Black;
            txtClinicalDiagnosis.ReadOnly = value == false ? true : false;
            //txtClinicalDiagnosis.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalDiagnosis.ForeColor = System.Drawing.Color.Black;
            txtClinicalNotes.ReadOnly = value == false ? true : false;
            //txtClinicalNotes.BackColor = System.Drawing.Color.RosyBrown;
            //txtClinicalNotes.ForeColor = System.Drawing.Color.Black;
            txtMicroscopy.ReadOnly = value == false ? true : false;
            //txtMicroscopy.BackColor = System.Drawing.Color.RosyBrown;
            //txtMicroscopy.ForeColor = System.Drawing.Color.Black;
            txtCultureReport.ReadOnly = value == false ? true : false;
            //txtCultureReport.BackColor = System.Drawing.Color.RosyBrown;
            //txtCultureReport.ForeColor = System.Drawing.Color.Black;
            txtGrowth.ReadOnly = value == false ? true : false;
            //txtGrowth.BackColor = System.Drawing.Color.RosyBrown;
            //txtGrowth.ForeColor = System.Drawing.Color.Black;
            //ddlGrowthStatus.BackColor = System.Drawing.Color.RosyBrown;
            //ddlGrowthStatus.ForeColor = System.Drawing.Color.Black;
            txtColonyCount.ReadOnly = value == false ? true : false;
            //txtColonyCount.BackColor = System.Drawing.Color.RosyBrown;
            //txtColonyCount.ForeColor = System.Drawing.Color.Black;
            txtOrgan.ReadOnly = value == false ? true : false;
            //txtOrgan.BackColor = System.Drawing.Color.RosyBrown;
            //txtOrgan.ForeColor = System.Drawing.Color.Black;
            //ddlstatus.BackColor = System.Drawing.Color.RosyBrown;


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

    

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        //sAutoRname.ContextKey = Convert.ToString(OrgID);
        //aModerate.ContextKey = Convert.ToString(OrgID);
        //atResistant.ContextKey = Convert.ToString(OrgID);
        string filtertxt = "";
        List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
        new Patient_BL(base.ContextInfo).GetInvestigationDrug(Convert.ToInt32(POrgid), filtertxt, out lstPrescription);
        string DName = string.Empty;
        foreach (PatientPrescription pPrescription in lstPrescription)
        {
            DName += DName != string.Empty ? "$" + pPrescription.BrandName : pPrescription.BrandName;
        }
        drugname.Value = DName;

        ddlData.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtClinicalDiagnosis.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtClinicalNotes.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMicroscopy.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtCultureReport.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtOrgan.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtReason.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
        txtMedRemarks.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");

        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        LoadMetaData();
    }
    #endregion

    #region "Events"
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
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }
    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        txtReason.Attributes.Add("readOnly", "true");
        txtSample.Attributes.Add("readOnly", "true");
        txtSource.Attributes.Add("readOnly", "true");
        txtClinicalDiagnosis.Attributes.Add("readOnly", "true");
        txtClinicalNotes.Attributes.Add("readOnly", "true");
        txtMicroscopy.Attributes.Add("readOnly", "true");
        txtCultureReport.Attributes.Add("readOnly", "true");
        txtGrowth.Attributes.Add("readOnly", "true");
        txtColonyCount.Attributes.Add("readOnly", "true");
        txtOrgan.Attributes.Add("readOnly", "true");

    }
    public void LoadData(List<InvestigationValues> lstData)
    {
        ddlData.Items.Add(new ListItem("Select", "0"));
        foreach (InvestigationValues invValues in lstData)
        {
            if (invValues.Name == "Reporting Status")
            {
                ddlData.Items.Add(invValues.Value);
            }
            else if (invValues.Name == "Culture Report")
            {
                txtCultureReport.Text = invValues.Value;
            }
            else if (invValues.Name == "Microscopy")
            {
                txtMicroscopy.Text = invValues.Value;
            }
        }

        ddlData.SelectedIndex = 0;
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
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        Pinv.ReportStatus = ddlData.SelectedItem.Text;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
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
        XmlNode xmlNode;
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
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, lblReportStatus.Text, "");
        xmlNode.InnerText = ddlData.SelectedItem.Text == "Select" ? "" : ddlData.SelectedItem.Text;
        xmlElement.AppendChild(xmlNode);

        //culture report node
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, lblCultureReport.Text, "");
        xmlNode.InnerText = txtCultureReport.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //Clinical Diagnosis
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ClinicalDiagnosis", "");
        xmlNode.InnerText = txtClinicalDiagnosis.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //Clinical Notes
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ClinicalNotes", "");
        xmlNode.InnerText = txtClinicalNotes.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SampleName", "");
        xmlNode.InnerText = txtSample.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //Source

        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Source", "");
        xmlNode.InnerText = txtSource.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //Growth
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Growth", "");
        xmlNode.InnerText = txtGrowth.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);


        //Growth Status
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "GrowthStatus", "");
        xmlNode.InnerText = ddlGrowthStatus.SelectedItem.Text == "Select" ? "" : ddlGrowthStatus.SelectedValue; //ddlGrowthStatus.SelectedValue.ToString(); 
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);


        //Colony Count
        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ColonyCount", "");
        xmlNode.InnerText = txtColonyCount.Text;
        xmlElement.AppendChild(xmlNode);
        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //OrganName:e-COLI~RID:1~sTO:amp^
        //OrganName:e-COLI~RID:2~rTO:amoxylin^
        //OrganName:e-COLI~RID:3~rTO:amp1^

        //OrganName:e-COLI2~RID:4~rTO:amoxylin^
        //OrganName:e-COLI2~RID:5~sTO:amp^
        //OrganName:e-COLI2~RID:6~rTO:amp1^

        string sensitive = string.Empty;
        string moderate = string.Empty;
        string resistant = string.Empty;
        string organismName = string.Empty;

        string tagName = "";
        foreach (string str in hresistantto.Value.Split('^'))
        {

            if (str != "")
            {

                if (xmlDoc.GetElementsByTagName("OrganDetails").Count != 0)
                {
                    bool addTag = false;
                    for (int i = 0; i < xmlDoc.GetElementsByTagName("OrganName").Count; i++)
                    {
                        addTag = false;
                        tagName = str.Split(':')[1].Split('~')[0];
                        XmlNode newNode;
                        newNode = xmlDoc.GetElementsByTagName("OrganName").Item(i);//;.ChildNodes.Item(0).FirstChild;
                        if (newNode.InnerText != tagName)
                        {
                            //xmlElement = xmlDoc.CreateElement(tagName);
                            addTag = true;
                        }
                        else
                        {
                            break;
                        }
                    }
                    if (addTag != false)
                    {
                        tagName = str.Split(':')[1].Split('~')[0];
                        xmlElement = xmlDoc.CreateElement("OrganDetails");
                        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "OrganName", "");
                        xmlNode.InnerText = str.Split(':')[1].Split('~')[0];
                        xmlElement.AppendChild(xmlNode);
                        //xmlDoc.ParentNode.AppendChild(xmlElement);
                        xmlDoc.LastChild.FirstChild.AppendChild(xmlElement);

                        for (int i = 0; i < xmlDoc.GetElementsByTagName("OrganDetails").Count; i++)
                        {
                            XmlDocument doc = new XmlDocument();
                            XmlNode newNode;
                            newNode = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Item(0).FirstChild;
                            if (newNode.InnerText == tagName)
                            {
                                if (xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Count == 1)
                                {

                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SensitiveTo", "");
                                    xmlNode.InnerText = "";
                                    //xmlElement.AppendChild(xmlNode);
                                    xmlDoc.DocumentElement.AppendChild(xmlNode);
                                    xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);

                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ModerateTo", "");
                                    xmlNode.InnerText = "";
                                    //xmlElement.AppendChild(xmlNode);
                                    //xmlDoc.FirstChild[tagName].AppendChild(xmlNode);
                                    //xmlDoc.DocumentElement.AppendChild(xmlNode);
                                    xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);


                                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ResistantTo", "");
                                    xmlNode.InnerText = "";
                                    //xmlElement.AppendChild(xmlNode);
                                    //xmlDoc.FirstChild[tagName].AppendChild(xmlNode);
                                    //xmlDoc.DocumentElement.AppendChild(xmlNode);
                                    xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);
                                }
                            }
                        }
                    }
                    //int cnt = xmlDoc.GetElementsByTagName(tagName).Count;
                }
                else
                {
                    //xmlElement = xmlDoc.CreateElement(tagName);
                    tagName = str.Split(':')[1].Split('~')[0];
                    xmlElement = xmlDoc.CreateElement("OrganDetails");
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "OrganName", "");
                    xmlNode.InnerText = str.Split(':')[1].Split('~')[0];
                    xmlElement.AppendChild(xmlNode);
                    //xmlDoc.ParentNode.AppendChild(xmlElement);
                    xmlDoc.LastChild.FirstChild.AppendChild(xmlElement);

                    for (int i = 0; i < xmlDoc.GetElementsByTagName("OrganDetails").Count; i++)
                    {
                        XmlDocument doc = new XmlDocument();
                        XmlNode newNode;
                        newNode = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Item(0).FirstChild;
                        if (newNode.InnerText == tagName)
                        {
                            if (xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Count == 1)
                            {
                                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SensitiveTo", "");
                                xmlNode.InnerText = "";
                                //xmlElement.AppendChild(xmlNode);
                                xmlDoc.DocumentElement.AppendChild(xmlNode);
                                xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);

                                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ModerateTo", "");
                                xmlNode.InnerText = "";
                                xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);


                                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ResistantTo", "");
                                xmlNode.InnerText = "";
                                xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);

                            }

                        }
                    }

                }
                string innerTextValue = string.Empty;
                foreach (string strValue in str.Split('~'))
                {
                    string chkValue = strValue.Split(':')[0];

                    switch (chkValue)
                    {

                        case "sTO":
                            for (int i = 0; i < xmlDoc.GetElementsByTagName("OrganDetails").Count; i++)
                            {
                                XmlDocument doc = new XmlDocument();
                                XmlNode newNode;
                                newNode = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Item(0).FirstChild;
                                if (newNode.InnerText == tagName)
                                {
                                    innerTextValue = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[1].InnerText;

                                    if (xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Count == 1)
                                    {

                                        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SensitiveTo", "");
                                        xmlNode.InnerText = innerTextValue == string.Empty ? strValue.Split(':')[1] : "," + strValue.Split(':')[1];
                                        //xmlElement.AppendChild(xmlNode);
                                        xmlDoc.DocumentElement.AppendChild(xmlNode);
                                        xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);

                                        // xmlDoc.LastChild.FirstChild["SensitiveTo"].InnerText = "hAI TST";
                                    }
                                    else
                                    {
                                        xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[1].InnerText += innerTextValue == string.Empty ? strValue.Split(':')[1] : "," + strValue.Split(':')[1];
                                    }
                                }
                            }
                            break;
                        case "mTO":
                            for (int i = 0; i < xmlDoc.GetElementsByTagName("OrganDetails").Count; i++)
                            {
                                XmlDocument doc = new XmlDocument();
                                XmlNode newNode;
                                newNode = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Item(0).FirstChild;
                                if (newNode.InnerText == tagName)
                                {
                                    innerTextValue = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[2].InnerText;
                                    if (xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Count == 1)
                                    {

                                        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ModerateTo", "");
                                        xmlNode.InnerText = innerTextValue == string.Empty ? strValue.Split(':')[1] : "," + strValue.Split(':')[1];
                                        //xmlElement.AppendChild(xmlNode);
                                        //xmlDoc.FirstChild[tagName].AppendChild(xmlNode);
                                        //xmlDoc.DocumentElement.AppendChild(xmlNode);
                                        xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);
                                    }
                                    else
                                    {
                                        xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[2].InnerText += innerTextValue == string.Empty ? strValue.Split(':')[1] : "," + strValue.Split(':')[1];

                                    }
                                }
                            }
                            break;
                        case "rTO":
                            for (int i = 0; i < xmlDoc.GetElementsByTagName("OrganDetails").Count; i++)
                            {
                                XmlDocument doc = new XmlDocument();
                                XmlNode newNode;
                                newNode = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Item(0).FirstChild;
                                if (newNode.InnerText == tagName)
                                {
                                    innerTextValue = xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[3].InnerText;
                                    if (xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes.Count == 1)
                                    {

                                        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ResistantTo", "");
                                        xmlNode.InnerText = innerTextValue == string.Empty ? strValue.Split(':')[1] : "," + strValue.Split(':')[1];
                                        //xmlElement.AppendChild(xmlNode);
                                        //xmlDoc.FirstChild[tagName].AppendChild(xmlNode);
                                        //xmlDoc.DocumentElement.AppendChild(xmlNode);
                                        xmlDoc.GetElementsByTagName("OrganDetails").Item(i).InsertAfter(xmlNode, xmlDoc.GetElementsByTagName("OrganDetails").Item(i).LastChild);
                                    }
                                    else
                                    {
                                        xmlDoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[3].InnerText += innerTextValue == string.Empty ? strValue.Split(':')[1] : "," + strValue.Split(':')[1];
                                    }

                                }
                            }
                            //xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ResistantTo", "");
                            //xmlNode.InnerText = strValue.Split(':')[1];
                            ////xmlElement.AppendChild(xmlNode);
                            ////xmlDoc.FirstChild[tagName].AppendChild(xmlNode);
                            ////xmlDoc.DocumentElement.AppendChild(xmlNode);
                            //xmlDoc.LastChild.FirstChild.AppendChild(xmlNode);

                            break;
                        default:
                            break;
                    };
                }
            }
        }
        // xmlDoc.Save(Server.MapPath("gb1.xml"));

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
            reportStatus = xmlEditdoc.GetElementsByTagName("ReportStatus").Item(0).InnerText;
            txtMicroscopy.Text = xmlEditdoc.GetElementsByTagName("Microscopy").Item(0).InnerText;
            ddlData.ClearSelection();
            if (reportStatus != string.Empty)
            {
                ddlData.Items.FindByText(reportStatus).Selected = true;
            }
            txtCultureReport.Text = xmlEditdoc.GetElementsByTagName("CultureReport").Item(0).InnerText;
            txtClinicalDiagnosis.Text = xmlEditdoc.GetElementsByTagName("ClinicalDiagnosis").Item(0).InnerText;
            txtClinicalNotes.Text = xmlEditdoc.GetElementsByTagName("ClinicalNotes").Item(0).InnerText;
            txtSample.Text = xmlEditdoc.GetElementsByTagName("SampleName").Item(0).InnerText;
            txtSource.Text = xmlEditdoc.GetElementsByTagName("Source").Item(0).InnerText;
            txtGrowth.Text = xmlEditdoc.GetElementsByTagName("Growth").Item(0).InnerText;
            ddlGrowthStatus.SelectedValue = xmlEditdoc.GetElementsByTagName("GrowthStatus").Item(0).InnerText;
            txtColonyCount.Text = xmlEditdoc.GetElementsByTagName("ColonyCount").Item(0).InnerText;
            btnID = btnOrgADD.ClientID;
            organismCount = xmlEditdoc.GetElementsByTagName("OrganDetails").Count;

            if (organismCount > 0)
            {
                txtOrgan.Text = organismCount.ToString();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), btnOrgADD.ClientID, "javascript:AddControl('" + btnOrgADD.ClientID + "');", true);

            }

            for (int i = 0; i < organismCount; i++)
            {
                foreach (XmlNode item in xmlEditdoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes)
                {
                    organismName = xmlEditdoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[0].InnerText;
                    switch (item.Name)
                    {
                        case "SensitiveTo":
                            foreach (var sDrug in item.InnerText.Split(','))
                            {
                                if (sDrug != string.Empty)
                                {
                                    rowID = rowID + 1;
                                    drug = "sTo:" + sDrug + "^";
                                    dhidValue += "OrganName:" + organismName + "~RID:" + rowID + "~sTO:" + sDrug + "^";
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), lblName.Text + rowID.ToString(), "javascript:LoadSensitivity('" + btnOrgADD.ClientID + "_" + i + "','" + sDrug + "','" + rowID + "','" + organismName + "');", true);
                                }

                            }
                            break;
                        case "ModerateTo":
                            foreach (var mDrug in item.InnerText.Split(','))
                            {
                                if (mDrug != string.Empty)
                                {
                                    rowID = rowID + 1;
                                    drug += "mTo:" + mDrug + "^";
                                    dhidValue += "OrganName:" + organismName + "~RID:" + rowID + "~mTO:" + mDrug + "^";
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), lblName.Text + rowID.ToString(), "javascript:LoadModerate('" + btnOrgADD.ClientID + "_" + i + "','" + mDrug + "','" + rowID + "','" + organismName + "');", true);
                                }

                            }
                            break;
                        case "ResistantTo":
                            foreach (var rDrug in item.InnerText.Split(','))
                            {
                                if (rDrug != string.Empty)
                                {
                                    rowID = rowID + 1;
                                    drug += "rTo:" + rDrug + "^";
                                    dhidValue += "OrganName:" + organismName + "~RID:" + rowID + "~rTO:" + rDrug + "^";
                                    ScriptManager.RegisterStartupScript(Page, this.GetType(), lblName.Text + rowID.ToString(), "javascript:LoadResistance('" + btnOrgADD.ClientID + "_" + i + "','" + rDrug + "','" + rowID + "','" + organismName + "');", true);
                                }
                            }
                            break;
                    };
                }

                //foreach (string rValue in drug.Split('^'))
                //{

                //    organismName = xmlEditdoc.GetElementsByTagName("OrganDetails").Item(i).ChildNodes[0].InnerText;

                //    if (rValue != string.Empty)
                //    {
                //        rowID = rowID + 1;
                //        string[] drugName = rValue.Split(':');
                //        switch (drugName[0])
                //        {
                //            case "sTo":
                //                dhidValue += "OrganName:" + organismName + "~RID:" + rowID + "~sTO:" + drugName[1] + "^";
                //                ScriptManager.RegisterStartupScript(Page, this.GetType(), rowID.ToString(), "javascript:LoadSensitivity('" + btnOrgADD.ClientID + "_" + i + "','" + drugName[1] + "','" + rowID + "','" + organismName + "');", true);
                //                break;
                //            case "mTo":
                //                dhidValue += "OrganName:" + organismName + "~RID:" + rowID + "~mTO:" + drugName[1] + "^";
                //                ScriptManager.RegisterStartupScript(Page, this.GetType(), rowID.ToString(), "javascript:LoadModerate('" + btnOrgADD.ClientID + "_" + i + "','" + drugName[1] + "','" + rowID + "','" + organismName + "');", true);

                //                break;
                //            case "rTo":
                //                dhidValue += "OrganName:" + organismName + "~RID:" + rowID + "~rTO:" + drugName[1] + "^";
                //                ScriptManager.RegisterStartupScript(Page, this.GetType(), rowID.ToString(), "javascript:LoadResistance('" + btnOrgADD.ClientID + "_" + i + "','" + drugName[1] + "','" + rowID + "','" + organismName + "');", true);
                //                break;
                //        };
                //    }
                //}
            }
            hresistantto.Value = dhidValue;

        }
    }
    public void SetInvestigationValueForEdit(List<InvestigationValues> InvestigationData)
    {
        if (InvestigationData.Count > 0)
        {
            // lblName.Text = InvestigationData[0].Name;
            loadXmlValue(InvestigationData[0].Value);
        }
        txtReason.Text = InvestigationData[0].Reason;
        txtMedRemarks.Text = InvestigationData[0].MedicalRemarks;
    }

    public void LoadMetaData()
    {
       // string strSelect = Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_ascx_01 == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_ascx_01;


        ddlOpinionUser.Items.Insert(0, strSelect);
        try
        {
            long returncode = -1;
            string domains = "Pattern_GrowthStatus";
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
                                 where child.Domain == "Pattern_GrowthStatus"
                                 select child;
                ddlGrowthStatus.DataSource = childItems;
                ddlGrowthStatus.DataTextField = "DisplayText";
                ddlGrowthStatus.DataValueField = "Code";
                ddlGrowthStatus.DataBind();
                ddlGrowthStatus.SelectedValue = strSelect;          
            }



        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
    #endregion

}
