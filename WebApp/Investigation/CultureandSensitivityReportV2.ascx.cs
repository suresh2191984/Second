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
using System.Web.Script.Serialization;

public partial class Investigation_CultureandSensitivityReportV2 : BaseControl
{
    public Investigation_CultureandSensitivityReportV2()
        : base("Investigation_CultureandSensitivityReportV2_ascx")
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
    string strSelects = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            btnAddStain.Attributes.Add("onclick", "return AddStainResult('" + ddlStainType.ClientID + "','" + txtStainResult.ClientID + "','" + tblStainResult.ClientID + "','" + divTblStainResult.ClientID + "')");
            //txtStainResult.Attributes.Add("onchange", "return onFocusStainResult('" + txtStainResult.ClientID + "');");
            ddlStainType.Attributes.Add("onchange", "return onChangeStainType('" + ddlStainType.ClientID + "','" + hdnInvestigationID.ClientID + "','" + ACEStainResult.ClientID + "','" + divstaintype.ClientID + "');");
            btnOrgADD.Attributes.Add("onclick", "return onChangeOrganismDropDown('" + ddlGrowthOrganisms.ClientID + "','" + hdnInvestigationID.ClientID + "','" + divRowChart.ClientID + "','" + hdnInvestigationList.Value + "');");
          
            ddlGrowthOrganisms.Attributes.Add("onchange", "return ShowHideOtherOrganism('" + ddlGrowthOrganisms.ClientID + "','" + divOtherOrganism.ClientID + "','" + txtOtherOrganism.ClientID + "');");
            if (!string.IsNullOrEmpty(ControlID))
                hdnInvestigationID.Value = ControlID;
            ACESpecimen.ContextKey = ControlID + "~" + "Sample";
            ACEGross.ContextKey = ControlID + "~" + "Gross";
            ACECulture.ContextKey = ControlID + "~" + "Culture";
            ACEResistanceDetected.ContextKey = ControlID + "~" + "ResistanceMechanismDetected";
            //ACEColonyCount.ContextKey = ControlID + "~" + "ColonyCount";

            AutoCompleteExtender1.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
            AutoCompleteExtender2.ContextKey = ControlID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

            //sAutoRname.ContextKey = Convert.ToString(OrgID);
            //aModerate.ContextKey = Convert.ToString(OrgID);
            //atResistant.ContextKey = Convert.ToString(OrgID);
            string filtertxt = "";
            List<PatientPrescription> lstPrescription = new List<PatientPrescription>();
            new Patient_BL().GetInvestigationDrug(Convert.ToInt32(POrgid), filtertxt, out lstPrescription);
            string DName = string.Empty;
            foreach (PatientPrescription pPrescription in lstPrescription)
            {
                DName += DName != string.Empty ? "$" + pPrescription.BrandName : pPrescription.BrandName;
            }
            drugname.Value = DName;
            //List<PatientInvSample> lstInvestigationSampleItem = new List<PatientInvSample>();
            //new Investigation_BL().GetSampleItem(Convert.ToInt32(POrgid), Convert.ToInt32(ControlID), out lstInvestigationSampleItem);
            //if (txtSpecimen.Text == "")
            //    txtSpecimen.Text = lstInvestigationSampleItem[0].SampleDesc;


            ddlData.Attributes.Add("onchange", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");

            txtMedRemarks.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtMedRemarks.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            txtReason.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtReason.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
            ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in page load", ex);
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

    public void LoadData(List<InvestigationValues> lstData)
    {
        List<InvestigationValues> lstReportingStatus = (from rs in lstData
                                                        where rs.Name == "Reporting Status"
                                                        select rs).Distinct().ToList();
        if (lstReportingStatus != null && lstReportingStatus.Count > 0)
        {
            ddlData.DataSource = lstReportingStatus;
            ddlData.DataTextField = "Value";
            ddlData.DataValueField = "Value";
            ddlData.DataBind();
        }
        List<InvestigationValues> lstStainType = (from rs in lstData
                                                  where rs.Name == "Stain Type"
                                                  select rs).Distinct().ToList();
        if (lstStainType != null && lstStainType.Count > 0)
        {
            ddlStainType.DataSource = lstStainType;
            ddlStainType.DataTextField = "Value";
            ddlStainType.DataValueField = "Value";
            ddlStainType.DataBind();
            ddlStainType.Items.Insert(0, strSelects.Trim());

        }
        ddlData.Items.Insert(0, new ListItem("Select", "0"));        
        ddlStainType.Items.Add(new ListItem("Other", "Other"));       
        ddlData.SelectedIndex = 0;
        ddlStainType.SelectedIndex = 0;
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

    public string GetStatus()
    {
        string status = string.Empty;
        try
        {
            status = hdnStaus.Value;
        }
        catch
        {

        }
        return status;
    }

    public List<InvestigationValues> GetResult(long VID)
    {
        List<InvestigationValues> lstValues = new List<InvestigationValues>();
        try
        {
            InvestigationValues obj = new InvestigationValues();
            string[] status;
            obj = new InvestigationValues();
            obj.Name = lblName.Text;
            obj.InvestigationID = Convert.ToInt32(ControlID);
            obj.PatientVisitID = VID;
            obj.Value = CreateXML();
            //obj.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            obj.Status = status[0].ToString();
            obj.Orgid = Convert.ToInt32(POrgid);
            obj.GroupName = GroupName;
            obj.GroupID = groupID;
            obj.CreatedBy = LID;
            obj.ModifiedBy = LID;
            obj.PackageID = PackageID;
            obj.PackageName = PackageName;
            lstValues.Add(obj);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting results", ex);
        }
        return lstValues;
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
            Pinv.ReportStatus = ddlData.SelectedItem.Text;
            //Pinv.Status = ddlstatus.SelectedItem.Text;
            status = ddlstatus.SelectedValue.Split('_');
            Pinv.Status = status[0].ToString();
            Pinv.Reason = txtReason.Text;
            Pinv.MedicalRemarks = txtMedRemarks.Text;
            MedicalRemarks = txtMedRemarks.Text;
            Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
            Pinv.AccessionNumber = AccessionNumber;
            if (ddlStatusReason.Items.Count > 0)
            {
                Pinv.InvStatusReasonID = (ddlStatusReason.SelectedValue == strSelects.Trim() ? 0 : Convert.ToInt32(ddlStatusReason.SelectedValue));
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting patient investigation", ex);
        }
        return Pinv;
    }

    public void setAttributes(string id)
    {
        txtReason.Attributes.Add("onfocus", "Clear('" + id + "');");
        txtReason.Attributes.Add("onblur", "setComments('" + id + "');");
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
            string strStainResult = hdnLstStainResult.Value;
            string strOrganDetails = hdnLstOrganisums.Value;
            List<Dictionary<string, string>> lstStainResult = new List<Dictionary<string, string>>();
            List<Dictionary<string, string>> lstOrganDetails = new List<Dictionary<string, string>>();
            if (!String.IsNullOrEmpty(strStainResult))
            {
                lstStainResult = serializer.Deserialize<List<Dictionary<string, string>>>(strStainResult);
            }
            if (!String.IsNullOrEmpty(strOrganDetails))
            {
                lstOrganDetails = serializer.Deserialize<List<Dictionary<string, string>>>(strOrganDetails);
            }
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationName", "");

            //Investigation  name node
            if (!string.IsNullOrEmpty(Name))
                xmlNode.InnerText = Name;
            else
                xmlNode.InnerText = hdnInvestigationName.Value;
            xmlElement.AppendChild(xmlNode);

            //Investigation id node
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationID", "");
            if (!string.IsNullOrEmpty(ControlID))
                xmlNode.InnerText = ControlID;
            else
                xmlNode.InnerText = hdnInvestigationID.Value;
            xmlElement.AppendChild(xmlNode);

            //Report Status
            if (ddlData.SelectedIndex > 0)
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ReportStatus", "");
                xmlNode.InnerText = ddlData.SelectedItem.Value;
                xmlElement.AppendChild(xmlNode);
            }

            //Specimen
            if (!String.IsNullOrEmpty(txtSpecimen.Text.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SampleName", "");
                xmlNode.InnerText = txtSpecimen.Text.Trim();
                xmlElement.AppendChild(xmlNode);
            }

            //Clinical History
            if (!String.IsNullOrEmpty(txtClinicalHistory.Text.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ClinicalHistory", "");
                xmlNode.InnerText = txtClinicalHistory.Text.Trim();
                xmlElement.AppendChild(xmlNode);
            }

            //Gross
            if (!String.IsNullOrEmpty(txtGross.Text.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Gross", "");
                xmlNode.InnerText = txtGross.Text.Trim();
                xmlElement.AppendChild(xmlNode);
            }

            //Culture

            if (!String.IsNullOrEmpty(txtCulture.Text.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "CultureReport", "");
                xmlNode.InnerText = txtCulture.Text.Trim();
                xmlElement.AppendChild(xmlNode);
            }

            //Resistance Detected
            if (!String.IsNullOrEmpty(txtResistanceDetected.Text.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ResistanceDetected", "");
                xmlNode.InnerText = txtResistanceDetected.Text.Trim();
                xmlElement.AppendChild(xmlNode);
            }

            //Colony Count
            //if (!String.IsNullOrEmpty(txtColonyCount.Text.Trim()))
            //{
            //    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "ColonyCount", "");
            //    xmlNode.InnerText = txtColonyCount.Text.Trim();
            //    xmlElement.AppendChild(xmlNode);
            //}
            //xmlDoc.DocumentElement.AppendChild(xmlElement);

            //Stain Details

            XmlElement xmlElementStain = xmlDoc.CreateElement("StainDetails");
            XmlNode xmlNodeStain;
            XmlAttribute xmlStainAttrType;
            XmlAttribute xmlStainAttrResult;
            string staintype = string.Empty;
            foreach (Dictionary<string, string> obj in lstStainResult)
            {
                xmlNodeStain = xmlDoc.CreateNode(XmlNodeType.Element, "Stain", "");

                xmlStainAttrType = xmlDoc.CreateAttribute("Type");
                xmlStainAttrType.Value = obj["StainType"];
                xmlNodeStain.Attributes.Append(xmlStainAttrType);

                xmlStainAttrResult = xmlDoc.CreateAttribute("Result");
                xmlStainAttrResult.Value = obj["StainResult"];
                xmlNodeStain.Attributes.Append(xmlStainAttrResult);

                xmlElementStain.AppendChild(xmlNodeStain);

            }

            xmlElement.AppendChild(xmlElementStain);

            XmlElement xmlElementOrgan = xmlDoc.CreateElement("OrganDetails");
            XmlNode xmlNodeOrgan;
            XmlAttribute xmlOrganAttrName;
            XmlAttribute xmlOrganAttrDrugName;
            XmlAttribute xmlOrganAttrSensitivity;
            XmlAttribute xmlOrganAttrZone;
            XmlAttribute xmlOrganAttrFamily;
            XmlAttribute xmlOrganAttrNameSeq;
            XmlAttribute xmlOrganAttrFamilySeq;
            XmlAttribute xmlOrganColCount;
            XmlNode xmlNodeCcount;
            string organismFound = string.Empty;
            string ColonyCount = string.Empty;
           
            foreach (Dictionary<string, string> obj in lstOrganDetails)
            {
                xmlNodeOrgan = xmlDoc.CreateNode(XmlNodeType.Element, "Organ", "");

                xmlOrganAttrName = xmlDoc.CreateAttribute("Name");
                xmlOrganAttrName.Value = obj["OrganName"];
                xmlNodeOrgan.Attributes.Append(xmlOrganAttrName);
                xmlOrganColCount = xmlDoc.CreateAttribute("ColonyCount");
                xmlOrganColCount.Value = obj["ColonyCount"];
                xmlNodeOrgan.Attributes.Append(xmlOrganColCount);

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
            if (!String.IsNullOrEmpty(txtOtherstaintype.Text.Trim()))
            {
                if (staintype == string.Empty)
                {
                    staintype = txtOtherstaintype.Text.Trim();
                }
                else
                {
                    staintype = staintype + ", " + txtOtherstaintype.Text.Trim();
                }
            }
            //Organism Isolated
            if (!String.IsNullOrEmpty(organismFound.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "OrganismIsolated", "");
                xmlNode.InnerText = organismFound.Trim() ;               
                xmlElement.AppendChild(xmlNode);
            }
            if (!String.IsNullOrEmpty(staintype.Trim()))
            {
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "StainIsolated", "");
                xmlNode.InnerText = staintype.Trim();
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
                XmlNodeList lstReportStatus = xmlEditdoc.GetElementsByTagName("ReportStatus");
                if (ddlData.Items.Count > 0)
                {
                    ddlData.ClearSelection();
                    if (lstReportStatus != null && lstReportStatus.Count > 0)
                    {
                        reportStatus = lstReportStatus.Item(0).InnerText;
                        ddlData.Items.FindByText(reportStatus).Selected = true;
                    }
                    else
                    {
                        ddlData.SelectedIndex = 0;
                    }
                }
                txtSpecimen.Text=string.Empty;
                XmlNodeList lstSampleName = xmlEditdoc.GetElementsByTagName("SampleName");
                if(lstSampleName != null && lstSampleName.Count > 0)
                {
                    txtSpecimen.Text = lstSampleName.Item(0).InnerText;
                }
                txtClinicalHistory.Text = string.Empty;
                XmlNodeList lstClinicalHistory = xmlEditdoc.GetElementsByTagName("ClinicalHistory");
                if(lstClinicalHistory != null && lstClinicalHistory.Count > 0)
                {
                    txtClinicalHistory.Text = lstClinicalHistory.Item(0).InnerText;
                }
                txtGross.Text = string.Empty;
                XmlNodeList lstGross = xmlEditdoc.GetElementsByTagName("Gross");
                if(lstGross != null && lstGross.Count > 0)
                {
                    txtGross.Text = lstGross.Item(0).InnerText;
                }
                txtCulture.Text = string.Empty;
                XmlNodeList lstCulture = xmlEditdoc.GetElementsByTagName("CultureReport");
                if(lstCulture != null && lstCulture.Count > 0)
                {
                    txtCulture.Text = lstCulture.Item(0).InnerText;
                }
                txtResistanceDetected.Text = string.Empty;
                XmlNodeList lstResistanceDetected = xmlEditdoc.GetElementsByTagName("ResistanceDetected");
                if (lstResistanceDetected != null && lstResistanceDetected.Count > 0)
                {
                    txtResistanceDetected.Text = lstResistanceDetected.Item(0).InnerText;
                }
                //txtColonyCount.Text = string.Empty;
                //XmlNodeList lstColonyCount = xmlEditdoc.GetElementsByTagName("ColonyCount");
                //if (lstColonyCount != null && lstColonyCount.Count > 0)
                //{
                //    txtColonyCount.Text = lstColonyCount.Item(0).InnerText;
                //}
                XmlNodeList lstStainDetails = xmlEditdoc.GetElementsByTagName("Stain");
                if (lstStainDetails != null && lstStainDetails.Count > 0)
                {
                    XmlDocument xStainDoc = new XmlDocument();
                    xStainDoc.LoadXml("<StainDetails></StainDetails>");
                    XmlNode nodeStainDest;
                    foreach (XmlNode xn in lstStainDetails)
                    {
                        nodeStainDest = xStainDoc.ImportNode(xn, true);
                        xStainDoc.DocumentElement.AppendChild(nodeStainDest);
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadStainXMLData" + this.ClientID, "LoadAllStainResult('" + xStainDoc.InnerXml + "','" + tblStainResult.ClientID + "','" + divTblStainResult.ClientID + "');", true);
                }
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
                string staintype = string.Empty;
                XmlNodeList lststaintype = xmlEditdoc.GetElementsByTagName("StainIsolated");
                if (lststaintype != null && lststaintype.Count > 0)
                {
                    staintype = lststaintype.Item(0).InnerText;
                }
                List<string> lststainisolated = new List<string>();
                if (!String.IsNullOrEmpty(staintype.Trim()))
                {
                    staintype = staintype.Replace(", ", ",");
                    lststainisolated = staintype.Split(',').ToList();
                }
                XmlNodeList lstOrganDetails = xmlEditdoc.GetElementsByTagName("Organ");
                if(lstOrganDetails != null && lstOrganDetails.Count > 0)
                {
                    StringBuilder sb = new StringBuilder();

                    foreach(ListItem item in ddlGrowthOrganisms.Items)
                    {
                        lstOrganismIsolated.Remove(item.Text);
                        XmlNodeList xnList = xmlEditdoc.SelectNodes("/InvestigationResults/InvestigationDetails/OrganDetails/Organ[@Name='" + item.Text + "']");
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
                            sb.Append("LoadXMLDrugList('" + item.Text + "','" + xDoc.InnerXml + "','" + hdnInvestigationID.ClientID + "','" + divRowChart.ClientID + "');");
                        }
                    }
                    if (sb.Length > 0)
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadOrganisumXMLData" + this.ClientID, sb.ToString(), true);
                    }
                }
                if (lstOrganismIsolated != null && lstOrganismIsolated.Count > 0)
                {
                    divOtherOrganism.Style.Add("display", "block");
                    txtOtherOrganism.Text = lstOrganismIsolated[0].Trim();
                    ddlGrowthOrganisms.SelectedValue = "Other";
                }
                if (lststainisolated != null && lststainisolated.Count > 0)
                {
                    //divstaintype.Style.Add("display", "block");
                    //txtOtherstaintype.Text = lststainisolated[0].Trim();
                    //ddlStainType.SelectedValue = "Other";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading xml data", ex);
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
            txtReason.Text = InvestigationData[0].Reason;
            txtMedRemarks.Text = InvestigationData[0].MedicalRemarks;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while setting investigation values", ex);
        }
    }
    bool readOnly = false;
    public bool Readonly
    {
        set
        {
            lnkEdit.Visible = true;            
            txtReason.ReadOnly = value == false ? true : false;
            txtMedRemarks.ReadOnly = value == false ? true : false;
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

    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
        //txtReason.Attributes.Add("readOnly", "true");         
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
    public long AccessionNumber
    {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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

    public void LoadOrganism(int Orgid, long ResultID, string ResultName, string TemplateType)
    {
        try
        {
            Investigation_BL inv_BL = new Investigation_BL(new BaseClass().ContextInfo);
            List<InvResultTemplate> lResultTemplate = new List<InvResultTemplate>();
            inv_BL.GetInvestigationResultTemplateByID(Orgid, ResultID, ResultName, TemplateType, out lResultTemplate);

            ddlGrowthOrganisms.DataTextField = "ResultName";
            ddlGrowthOrganisms.DataValueField = "ResultValues";
            ddlGrowthOrganisms.DataSource = lResultTemplate;
            ddlGrowthOrganisms.DataBind();

            ddlGrowthOrganisms.Items.Insert(0, new ListItem("Select", "0"));
            ddlGrowthOrganisms.Items.Add(new ListItem("Other", "Other"));
            ddlGrowthOrganisms.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading organisum", ex);
        }
    }
    public void setContextkey(string invID, string invName)
    {
        try
        {
            hdnInvestigationID.Value = invID;
            hdnInvestigationName.Value = invName;
            ACESpecimen.ContextKey = invID + "~" + "Sample";
            ACEGross.ContextKey = invID + "~" + "Gross";
            ACECulture.ContextKey = invID + "~" + "Culture";
            ACEResistanceDetected.ContextKey = invID + "~" + "ResistanceMechanismDetected";
            //ACEColonyCount.ContextKey = invID + "~" + "ColonyCount";

            AutoCompleteExtender1.ContextKey = invID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();
            AutoCompleteExtender2.ContextKey = invID.ToString() + "~" + "INV" + "~" + OrgID.ToString() + "~" + RoleID.ToString();

            List<PatientInvSample> lstInvestigationSampleItem = new List<PatientInvSample>();
            /////////////////karthick///////////////////
            long patientVisitID = -1;
            Int64.TryParse(Request.QueryString["vid"], out patientVisitID);

            new Investigation_BL().GetSampleItem(Convert.ToInt32(POrgid), Convert.ToInt32(ControlID), patientVisitID, out lstInvestigationSampleItem);
            if (txtSpecimen.Text != "")
                txtSpecimen.Text = lstInvestigationSampleItem[0].SampleDesc;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while setContextkey on CultureandSensitivityReportV2", ex);
        }
    }
}
