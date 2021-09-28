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
using System.Web.Script.Serialization;

public partial class Investigation_GTTContentPattern : BaseControl
{
    public Investigation_GTTContentPattern()
        : base("Investigation_GTTContentPattern_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private int i = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private string age = string.Empty;
    private string sex = string.Empty;
    private string patientName = string.Empty;
    private string time = string.Empty;
    private string type = string.Empty;
    private string invtype = string.Empty;
    private int sequenceNo = 0;

    //code added on 23-07-2010 QRM - Started
    Investigation_BL InvestigationBL;
    protected override void Render(HtmlTextWriter writer)
    {

        long returnCode = -1;
        List<InvQualitativeResultMaster> lstQualitativeResult = new List<InvQualitativeResultMaster>();
        returnCode = InvestigationBL.GetInvQualitativeResultMaster(out lstQualitativeResult);


        for (int i = 0; i < lstQualitativeResult.Count; i++)
        {
            Page.ClientScript.RegisterForEventValidation(ddlData.UniqueID, lstQualitativeResult[i].QualitativeResultName.ToString());
        }
        base.Render(writer);

    }
    //code added on 23-07-2010 QRM - Completed



    protected void Page_Load(object sender, EventArgs e)
    {
        InvestigationBL = new Investigation_BL(base.ContextInfo);
        
        AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
        AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

        ddlData.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','');appendDDLHdn('" + ddlData.ClientID + "','" + hdnDDL.ClientID + "')");
        ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        txtRefRange.ReadOnly = true;
        txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
        txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
        txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");

        ATag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ATag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ADeltaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ADeltaTag.Attributes.Add("onmouseout", "this.style.color='Red';");

        ABetaTag.Attributes.Add("onmouseover", "this.style.cursor='pointer';this.style.color='Green';");
        ABetaTag.Attributes.Add("onmouseout", "this.style.color='Red';");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");


        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        spanIsAbnormal.Attributes.Add("onclick", "javascript:onChangingIsAbnormal('" + txtIsAbnormal.ClientID + "','" + txtResult.ClientID + "','" + ddlData.ClientID + "','" + hdnXmlContent.ClientID + "','')");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }

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
    /// Set the UOM value
    /// </summary>
    public string UOM
    {
        get { return uom; }
        set
        {
            uom = value;
            lblUOM.Text = uom;
        }
    }
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            accessionNumber = value;
        }
    }
    public long VisitID
    {
        get { return visitID; }
        set
        {
            visitID = value;
        }
    }
    public long PatientID
    {
        get { return patientID; }
        set
        {
            patientID = value;
        }
    }
    public string UID
    {
        get { return uID; }
        set
        {
            uID = value;
        }
    }
    public string Age
    {
        get { return age; }
        set
        {
            lblAge.Text = value;
        }
    }
    public string Sex
    {
        get { return sex; }
        set
        {
            lblSex.Text = value;
        }
    }
    public string PatientName
    {
        get { return patientName; }
        set
        {
            lblPatientName.Text = value;
        }
    }
    public string Time
    {
        get { return time; }
        set
        {
            time = value;
        }
    }
    public string Type
    {
        get { return type; }
        set
        {
            type = value;
        }
    }
    public string Invtype
    {
        get { return invtype; }
        set
        {
            invtype = value;
        }
    }

    private long autoApproveLoginID = -1;
    public long AutoApproveLoginID
    {
        get { return autoApproveLoginID; }
        set { autoApproveLoginID = value; }
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
    /// To get the textbox value
    /// </summary>
    public string Value
    {
        get { return result; }
        set { result = value; }
    }

    /// <summary>
    /// Property to set the maxlength for textbox
    /// </summary>
    public int Maxlength
    {
        get { return maxlength; }
        set
        {
            maxlength = value;
            txtResult.MaxLength = maxlength;
        }
    }
    public int SequenceNo
    {
        get { return sequenceNo; }
        set
        {
            sequenceNo = value;
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


    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            //Modified by Perumal on 23 Jan 2012
            //txtReason.Enabled = value;
            //txtRefRange.Enabled = value;
            //txtResult.Enabled = value;
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
            txtRefRange.ReadOnly = value == false ? true : false;
            txtResult.ReadOnly = value == false ? true : false;

            ddlData.Enabled = value;
            lnkEdit.Visible = true;

        }
    }
    public void BatchWise(bool IsBatchWise)
    {
        if (IsBatchWise)
        {
            tdPatientDetails.Style.Add("display", "table-cell");
            tdInvName.Style.Add("display", "none");
        }
        else
        {
            tdPatientDetails.Style.Add("display", "none");
            tdInvName.Style.Add("display", "table-cell");
        }
    }
    public void PatternType(string PType)
    {
        if (PType=="Blood")
        {
            DFemale.Style.Add("display", "none");
            DMale.Style.Add("display", "block");
        }
        else if (PType == "Urine")
        {
            DFemale.Style.Add("display", "block");
            DMale.Style.Add("display", "none");
        }
        else
        {
            DFemale.Style.Add("display", "block");
            DMale.Style.Add("display", "block");
        }
        Type = PType;
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
    protected void lnkEdit_Click(object sender, EventArgs e)
    {
        if (ViewState["isEdit"] == null)
        {
            ViewState["isEdit"] = true;
        }
        Readonly = true;
    }
    /// <summary>
    /// Method to populate dropdown list
    /// </summary>
    /// <param name="lstData"></param>
    public void LoadData(List<InvestigationValues> lstData)
    {
        hdnddlData.Value = "";
        ddlData.SelectedIndex = 0;
        
        for (i = 0; i < lstData.Count; i++)
        {  
            if (lstData[i].Name == "Source")
            {
                ddlData.Items.Add(lstData[i].Value);
                hdnddlData.Value += lstData[i].Value + "~";
            }
        }
        ddlData.Items.Insert(0, "Select");

    }


    //public void Show(string Sex)
    //{
    //    if (Sex == "M")
    //    {
    //        DFemale.Visible = false;
    //    }
    //}

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

    public List<InvestigationValues> GetResult(long VID)
    {
        String[] status;
        InvestigationValues obj = new InvestigationValues();
        List<InvestigationValues> lInvValues = new List<InvestigationValues>();
        obj.Name = lblName.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.Value = DrawXML();
        obj.UOMCode = lblUOM.Text;
        obj.CreatedBy = LID;
        obj.GroupID = groupID;
        obj.GroupName = GroupName;
        obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        obj.UID = UID;
        lInvValues.Add(obj);
        return lInvValues;
    }
    private string DrawXML()
    {
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

        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
        xmlNode.InnerText = lblUOM.Text;
        xmlElement.AppendChild(xmlNode);

       
        xmlElement.AppendChild(xmlNode);

        xmlDoc.DocumentElement.AppendChild(xmlElement);
        if ((Time != ""))
        {
            if ((txtResult.Text != string.Empty) || (ddlData.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                {
                    if (Time != "")
                    {
                        time += Time;
                    }
                    else
                    {
                        time += " " + ddlData.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = SequenceNo.ToString(); ;
                xmlElement.AppendChild(xmlNode);
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                if (Type == "Blood")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                    xmlNode.InnerText = txtResult.Text != string.Empty ? txtResult.Text : "";
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                else
                {
                    //Clinical Diagnosis
                    if (ddlData.SelectedItem.Text != "Select")
                    {
                        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                        xmlNode.InnerText = ddlData.SelectedItem.Text;
                        xmlElement.AppendChild(xmlNode);
                        xmlDoc.DocumentElement.AppendChild(xmlElement);
                    }
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUOM.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = Invtype;
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

            }
        }
        
        return xmlDoc.InnerXml;
    }
    void LoadXML(string XMLString)
    {
        XmlDocument EditDoc = new XmlDocument();
        EditDoc.LoadXml(XMLString);
        if (EditDoc.GetElementsByTagName("Blood").Count > 0)
        {
            string BloodResult = EditDoc.GetElementsByTagName("Blood").Item(0).InnerText;
            txtResult.Text = BloodResult;
        }
        if (EditDoc.GetElementsByTagName("Urine").Count > 0)
        {
            string UrineResult = EditDoc.GetElementsByTagName("Urine").Item(0).InnerText;
            ddlData.Items.FindByText(UrineResult).Selected = true;
        }

    }



    public PatientInvestigation GetInvestigations(long Vid)
    {
        string[] status;
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        //added for refrence range - begin
        //Pinv.ReferenceRange = hdnXmlContent.Value;
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
        //added for refrence range - ends
        Pinv.Reason = txtReason.Text;
        Pinv.MedicalRemarks = txtMedRemarks.Text;
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        Pinv.AccessionNumber = AccessionNumber;
        Pinv.UID = UID;
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
        Pinv.IsAbnormal = IsAbnormal;
        Pinv.PrintableRange = hdnPrintableRange.Value.Trim().Replace("\n", "<br>");
        Pinv.GroupID = groupID;
        Pinv.LabNo = LabNo;
        Pinv.GroupName = groupName;
        Pinv.AutoApproveLoginID = AutoApproveLoginID;
        Pinv.UID = UID;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        //InvRemarks
        return Pinv;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }

    public void setValues(List<InvestigationValues> lValues)
    {
        ddlData.ClearSelection();
        if (lValues.Count > 0)
        {
            LoadXML(lValues[0].Value);
        }
        lblName.Text = lValues[0].Name;
        txtReason.Text = lValues[0].Reason;
        txtMedRemarks.Text = lValues[0].MedicalRemarks;
        txtDilution.Text = lValues[0].Dilution;

        lblPVisitID.Text = Convert.ToString(PatientVisitID);
        lblPatternID.Text = Convert.ToString(PatternID);
        lblInvID.Text = ControlID;
        lblOrgID.Text = Convert.ToString(POrgid);
        lblPatternClassName.Text = "Investigation_BioPattern2";
        //Delta CheckUp 
        if (isDeltaCheckWant)
        {
            //tdDeltaCheck.Style.Add("display", "block");
            tdBetaCheck.Style.Add("display", "table-cell");
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
        txtResult.Attributes.Add("readOnly", "true");
        txtRefRange.Attributes.Add("readOnly", "true");
        txtReason.Attributes.Add("readOnly", "true");
        txtMedRemarks.Attributes.Add("readOnly", "true");
        txtDilution.Attributes.Add("readOnly", "true");
        ddlData.Enabled = true;
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
    public string Dilution
    {
        get { return txtDilution.Text; }
        set
        {
            txtDilution.Text = value;
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
    private string resultValueType;
    public string ResultValueType
    {
        get { return resultValueType; }
        set
        {
            resultValueType = value;
            if (value.Trim() == "NU")
            {
                txtResult.Attributes.Add("onkeydown", "return validatenumberOnly(event,'" + txtResult.ClientID.ToString() + "');");
            }
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
        if (labTechEditMedRem == "N" && currentRoleName == RoleHelper.LabTech)
        {
            txtMedRemarks.ReadOnly = true;
        }
        else
        {
            txtMedRemarks.ReadOnly = false;
        }
    }

    private string decimalPlaces;
    public string DecimalPlaces
    {
        get { return decimalPlaces; }
        set
        {
            decimalPlaces = value;
            if (!string.IsNullOrEmpty(value))
            {
                //txtResult.Attributes.Add("onkeyup", "return setCompletedStatusValueType(event,'" + GroupName + "','" + txtResult.ClientID.ToString() + "','" + DecimalPlaces + "');");
				txtResult.Attributes.Add("onkeyup", "return setCompletedStatusValueType(event,'" + GroupName + "','" + txtResult.ClientID.ToString() + "');");
            }
            else
            {
                txtResult.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            }
            txtResult.Attributes.Add("onblur", "javascript:validateResult('" + txtResult.ClientID + "','" + hdnXmlContent.ClientID + "','','" + DecimalPlaces + "','" + txtIsAbnormal.ClientID + "','" + AutoApproveLoginID + "');");
        }
    }

    private string isAbnormal = string.Empty;
    public string IsAbnormal
    {
        get { return isAbnormal; }
        set
        {
            isAbnormal = value;
            txtResult.Font.Bold = true;
            txtResult.ForeColor = System.Drawing.Color.Black;
            ddlData.ForeColor = System.Drawing.Color.Black;
            if (isAbnormal == "A")
            {
                txtResult.Attributes.Add("style", "background-color:yellow;");
                ddlData.Attributes.Add("style", "background-color:yellow;");
                txtIsAbnormal.Attributes.Add("style", "background-color:yellow;");
            }
            if (isAbnormal == "L")
            {
                txtResult.Attributes.Add("style", "background-color:LightPink;");
                ddlData.Attributes.Add("style", "background-color:LightPink;");
                txtIsAbnormal.Attributes.Add("style", "background-color:LightPink;");
            }
            if (isAbnormal == "P")
            {
                txtResult.Attributes.Add("style", "background-color:red;");
                ddlData.Attributes.Add("style", "background-color:red;");
                txtIsAbnormal.Attributes.Add("style", "background-color:red;");
            }
        }
    }
    public string PrintableRange
    {
        set
        {
            hdnPrintableRange.Value = value;
        }
    }
    private string labno = string.Empty;
    public string LabNo
    {
        get
        {
            return labno;
        }
        set
        {
            labno = value;
        }
    }
}
