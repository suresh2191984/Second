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
using System.Web.UI.HtmlControls;
using System.Text;

public partial class Investigation_OrganismDrugPatternWithLevel : BaseControl
{
    public Investigation_OrganismDrugPatternWithLevel()
        : base("Investigation_OrganismDrugPatternWithLevel_ascx")
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














    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            lnkEdit.Visible = true;
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

    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            accessionNumber = value;
        }
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
    private string uID = string.Empty;
    public string UID
    {
        get { return uID; }
        set
        {
            uID = value;
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
        #region "Initial"
    string select = Resources.Investigation_AppMsg.Investigation_OrganismDrugPattern_ascx_13 == null ? "--Select--" : Resources.Investigation_AppMsg.Investigation_OrganismDrugPattern_ascx_13;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            btnOrgADD.Attributes.Add("onclick", "return onChangeOrganismDropDown('" + ddlGrowthOrganisms.ClientID + "','" + hdnInvestigationID.ClientID + "','" + txtOtherOrganism.ClientID + "','" + divOtherOrganism.ClientID + "','" + hdnOrganismCount.ClientID + "','" + divTblOrgans.ClientID + "','" + hidVal.ClientID + "','" + GroupName + "',this.id);");
            ddlGrowthOrganisms.Attributes.Add("onchange", "return ShowHideOtherOrganism('" + ddlGrowthOrganisms.ClientID + "','" + divOtherOrganism.ClientID + "','" + txtOtherOrganism.ClientID + "');");
            hdnInvestigationID.Value = ControlID + GroupID;

            ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
            ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
            ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in page load", ex);
        }
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
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlstatus.DataSource = lstStatus;
        ddlstatus.DataTextField = "DisplayText";
        ddlstatus.DataValueField = "StatuswithID";
        ddlstatus.DataBind();
        string SelString = lstStatus.Find(O => O.StatuswithID.Contains("_1")).StatuswithID;
        if (ddlstatus.Items.FindByValue(SelString) != null)
        {
            ddlstatus.SelectedValue = SelString;
        }
    }
    public InvestigationValues GetResult(long VID)
    {
        InvestigationValues obj = new InvestigationValues();
        try
        {
            string[] status;
            obj = new InvestigationValues();
            obj.Name = lblName.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.Value = CreateXML();
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.Orgid = Convert.ToInt32(POrgid);
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            obj.ModifiedBy = LID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            obj.UID = UID;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting results", ex);
        }
        return obj;
    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        string[] status;
        try
        {
            Pinv.InvestigationID = Convert.ToInt64(ControlID);
            Pinv.PatientVisitID = Vid;
            status = ddlstatus.SelectedValue.Split('_');
            Pinv.Status = status[0].ToString();
            Pinv.OrgID = Convert.ToInt32(POrgid);
            Pinv.UID = UID;
            Pinv.LabNo = LabNo;
            if (hdnstatusreason.Value != "")
            {
                Pinv.InvStatusReasonID = Convert.ToInt32(hdnstatusreason.Value.Split('~')[0].ToString());
                Pinv.Reason = hdnstatusreason.Value.Split('~')[1].ToString();
            }
            long LoginID = 0;
            if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
            {
                Int64.TryParse(hdnOpinionUser.Value, out LoginID);
            }
            Pinv.LoginID = LoginID;
            Pinv.GroupID = groupID;
            Pinv.UID = UID;
            Pinv.LabNo = LabNo;
            Pinv.AccessionNumber = AccessionNumber;
            hdnstatusreason.Value = "";
            hdnOpinionUser.Value = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting patient investigation", ex);
        }
        return Pinv;
    }
    public string CreateXML()
    {
        XmlDocument xmlDoc = new XmlDocument();
        XmlElement xmlElement;
        XmlNode xmlNode;
        xmlDoc.LoadXml("<InvestigationResults></InvestigationResults>");
        xmlElement = xmlDoc.CreateElement("InvestigationDetails");
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strOrganDetails = hdnLstOrganisums.Value;
            List<Dictionary<string, string>> lstOrganDetails = new List<Dictionary<string, string>>();
            if (!String.IsNullOrEmpty(strOrganDetails))
            {
                lstOrganDetails = serializer.Deserialize<List<Dictionary<string, string>>>(strOrganDetails);
            }
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationName", "");

            //Investigation  name node
            xmlNode.InnerText = Name;
            xmlElement.AppendChild(xmlNode);

            //Investigation id node
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationID", "");
            xmlNode.InnerText = ControlID;
            xmlElement.AppendChild(xmlNode);

            XmlElement xmlElementOrgan = xmlDoc.CreateElement("OrganDetails");
            XmlNode xmlNodeOrgan;
            XmlAttribute xmlOrganAttrName;
            XmlAttribute xmlOrganAttrDrugName;
            XmlAttribute xmlOrganAttrSensitivity;
            XmlAttribute xmlOrganAttrZone;
            XmlAttribute xmlOrganAttrFamily;
            XmlAttribute xmlOrganAttrNameSeq;
            XmlAttribute xmlOrganAttrFamilySeq;
            /* BEGIN | sabari | 20181129 | Dev | Culture Report */
            XmlAttribute xmlOrganAttrLevelName;
            XmlAttribute xmlOrganAttrLevelID;
            XmlAttribute xmlOrganAttrDrugID;
            /* END | sabari | 20181129 | Dev | Culture Report */
            string organismFound = string.Empty;

            foreach (Dictionary<string, string> obj in lstOrganDetails)
            {
                xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", "");

                xmlOrganAttrName = xmlDoc.CreateAttribute("Name");
                xmlOrganAttrName.Value = obj["OrganName"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrName);

                if (organismFound == string.Empty)
                {
                    organismFound = obj["OrganName"];
                }
                else
                {
                    if (!organismFound.Contains(obj["OrganName"]))
                    {
                        organismFound = organismFound + ", " + obj["OrganName"];
                    }
                }

                xmlOrganAttrDrugName = xmlDoc.CreateAttribute("DrugName");
                xmlOrganAttrDrugName.Value = obj["DrugName"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugName);



                xmlOrganAttrNameSeq = xmlDoc.CreateAttribute("NameSeq");
                xmlOrganAttrNameSeq.Value = obj["NameSeq"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrNameSeq);

                xmlOrganAttrFamily = xmlDoc.CreateAttribute("Family");
                xmlOrganAttrFamily.Value = obj["Family"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamily);

                xmlOrganAttrFamilySeq = xmlDoc.CreateAttribute("FamilySeq");
                xmlOrganAttrFamilySeq.Value = obj["FamilySeq"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrFamilySeq);

                xmlOrganAttrSensitivity = xmlDoc.CreateAttribute("Sensitivity");
                xmlOrganAttrSensitivity.Value = obj["Sensitivity"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrSensitivity);

                /* BEGIN | sabari | 20181129 | Dev | Culture Report */
                xmlOrganAttrLevelName = xmlDoc.CreateAttribute("LevelName");
                xmlOrganAttrLevelName.Value = obj["LevelName"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrLevelName);

                xmlOrganAttrLevelID = xmlDoc.CreateAttribute("LevelID");
                xmlOrganAttrLevelID.Value = obj["LevelID"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrLevelID);

                xmlOrganAttrDrugID = xmlDoc.CreateAttribute("DrugID");
                xmlOrganAttrDrugID.Value = obj["DrugID"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrDrugID);
                /* END | sabari | 20181129 | Dev | Culture Report */

                xmlOrganAttrZone = xmlDoc.CreateAttribute("Zone");
                xmlOrganAttrZone.Value = obj["Zone"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrZone);

                xmlElementOrgan.AppendChild(xmlNodeOrgan);

            }
            xmlElement.AppendChild(xmlElementOrgan);

            if (!String.IsNullOrEmpty(txtOtherOrganism.Text.Trim()))
            {
                if (organismFound == string.Empty)
                {
                    organismFound = txtOtherOrganism.Text.Trim();
                }
                else
                {
                    organismFound = organismFound + ", " + txtOtherOrganism.Text.Trim();
                }
            }
            //Organism Isolated
            if (!String.IsNullOrEmpty(organismFound.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "OrganismIsolated", "");
                xmlNode.InnerText = organismFound.Trim();
                xmlElement.AppendChild(xmlNode);
            }
            xmlDoc.DocumentElement.AppendChild(xmlElement);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating xml", ex);
        }
        return xmlDoc.InnerXml;

    }
    void loadXmlValue(string xmlTag)
    {
        try
        {
            if (xmlTag != string.Empty)
            {
                string reportStatus = string.Empty;
                XmlDocument xmlEditdoc = new XmlDocument();
                xmlEditdoc.LoadXml(xmlTag);
                string organismFound = string.Empty;
                XmlNodeList lstOrganismFound = xmlEditdoc.GetElementsByTagName("OrganismIsolated");
                if (lstOrganismFound != null && lstOrganismFound.Count > 0)
                {
                    organismFound = lstOrganismFound.Item(0).InnerText;
                }
                List<string> lstOrganismIsolated = new List<string>();
                if (!String.IsNullOrEmpty(organismFound.Trim()))
                {
                    organismFound = organismFound.Replace(", ", ",");
                    lstOrganismIsolated = organismFound.Split(',').ToList();
                }
                XmlNodeList lstOrganDetails = xmlEditdoc.GetElementsByTagName("Organ");
                if (lstOrganDetails != null && lstOrganDetails.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();
                    XmlNodeList xnNameList = xmlEditdoc.SelectNodes("/InvestigationResults/InvestigationDetails/OrganDetails/Organ/@Name");
                    List<string> lstOrganName = new List<string>();
                    foreach (XmlNode n in xnNameList)
                    {
                        if (!lstOrganName.Contains(n.Value))
                        {
                            lstOrganName.Add(n.Value);
                        }
                    }
                    foreach (string item in lstOrganName)
                    {
                        lstOrganismIsolated.Remove(item);
                        XmlNodeList xnList = xmlEditdoc.SelectNodes("/InvestigationResults/InvestigationDetails/OrganDetails/Organ[@Name='" + item + "']");
                        if (xnList != null && xnList.Count > 0)
                        {
                            XmlDocument xDoc = new XmlDocument();
                            xDoc.LoadXml("<OrganDetails></OrganDetails>");
                            XmlNode nodeDest;
                            foreach (XmlNode xn in xnList)
                            {
                                nodeDest = xDoc.ImportNode(xn, true);
                                xDoc.DocumentElement.AppendChild(nodeDest);
                            }
                            sb.Append("LoadXMLDrugList('" + item + "','" + xDoc.InnerXml + "','" + ControlID + GroupID + "','" + hdnOrganismCount.ClientID + "','" + divTblOrgans.ClientID + "');");
                        }
                    }
                    if (sb.Length > 0)
                    {
                        if (IsPostBack)
                        {
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "LoadOrganisumXMLData" + this.ClientID, sb.ToString(), true);
                            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "SetCompletedStatus" + this.ClientID, "setCompletedStatus('" + GroupName + "','" + ddlstatus.ClientID + "');", true);
                        }
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadOrganisumXMLData" + this.ClientID, sb.ToString(), true);
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "SetCompletedStatus" + this.ClientID, "setCompletedStatus('" + GroupName + "','" + ddlstatus.ClientID + "');", true);
                    }
                }
                //if (lstOrganismIsolated != null && lstOrganismIsolated.Count > 0)
                //{
                //    divOtherOrganism.Style.Add("display", "block");
                //    txtOtherOrganism.Text = lstOrganismIsolated[0].Trim();
                //    ddlGrowthOrganisms.SelectedValue = "Other";
                //}
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading xml data", ex);
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
    }
    
    public void LoadOrganism(long invID)
    {
        try
        {
            Investigation_BL inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
            List<OrganismMaster> lstOrganismMaster = new List<OrganismMaster>();
            inv_BL.GetOrganismList(invID, out lstOrganismMaster);

            if (lstOrganismMaster.Count > 0)
            {
                var Value = lstOrganismMaster.Where(X => X.IsActive == true).ToList();
                if (Value != null && Value.Count > 0)
                {
                    ddlGrowthOrganisms.DataTextField = "Name";
                    ddlGrowthOrganisms.DataValueField = "ID";
                    ddlGrowthOrganisms.DataSource = Value;
                    ddlGrowthOrganisms.DataBind();
                }
            }
            ddlGrowthOrganisms.Items.Insert(0, new ListItem(select, "0"));
            ddlGrowthOrganisms.Items.Add(new ListItem("Other", "Other"));
            ddlGrowthOrganisms.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading organisum", ex);
        }
    }
    public void SetInvestigationValueForEdit(List<InvestigationValues> InvestigationData)
    {
        try
        {
            if (InvestigationData.Count > 0)
            {
                loadXmlValue(InvestigationData[0].Value);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while setting investigation values", ex);
        }
    }

    #endregion

   
}
