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

public partial class Investigation_MicroStainPattern : BaseControl
{
    public Investigation_MicroStainPattern()
        : base("Investigation_MicroStainPattern_ascx")
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

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            btnAddStain.Attributes.Add("onclick", "return AddStainResult('" + ddlStainType.ClientID + "','" + txtStainResult.ClientID + "','" + tblStainResult.ClientID + "','" + divTblStainResult.ClientID + "','" + ACEStainResult.ClientID + "','" + txtOtherstaintype.ClientID + "','" + divstaintype.ClientID + "','" + GroupName + "','" + hdnSelectedRowIndex.ClientID + "',this.id);");
            ddlStainType.Attributes.Add("onchange", "return onChangeStainType('" + ddlStainType.ClientID + "','" + hdnInvestigationID.ClientID + "','" + ACEStainResult.ClientID + "','" + divstaintype.ClientID + "');");
            hdnInvestigationID.Value = ControlID;

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

    #region "Methods"
    public void LoadData(List<InvestigationValues> lstData)
    {
        List<InvestigationValues> lstStainType = (from rs in lstData
                                                  where rs.Name == "Stain Type"
                                                  select rs).Distinct().ToList();
        if (lstStainType != null && lstStainType.Count > 0)
        {
            ddlStainType.DataSource = lstStainType;
            ddlStainType.DataTextField = "Value";
            ddlStainType.DataValueField = "Value";
            ddlStainType.DataBind();
        }
        ddlStainType.Items.Insert(0, new ListItem("Select", "0"));
        ddlStainType.Items.Add(new ListItem("Other", "Other"));
        ddlStainType.SelectedIndex = 0;
    }
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
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }
    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";
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
            string strStainResult = hdnLstStainResult.Value;
            List<Dictionary<string, string>> lstStainResult = new List<Dictionary<string, string>>();
            if (!String.IsNullOrEmpty(strStainResult))
            {
                lstStainResult = serializer.Deserialize<List<Dictionary<string, string>>>(strStainResult);
            }
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationName", "");

            //Investigation  name node
            xmlNode.InnerText = Name;
            xmlElement.AppendChild(xmlNode);

            //Investigation id node
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationID", "");
            xmlNode.InnerText = ControlID;
            xmlElement.AppendChild(xmlNode);

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
                    hdnLstStainResultXML.Value = xStainDoc.InnerXml;
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "LoadStainXMLData" + this.ClientID, "LoadAllStainResult('" + hdnLstStainResultXML.ClientID + "','" + tblStainResult.ClientID + "','" + divTblStainResult.ClientID + "','" + hdnSelectedRowIndex.ClientID + "','" + ddlStainType.ClientID + "','" + txtStainResult.ClientID + "','" + txtOtherstaintype.ClientID + "','" + divstaintype.ClientID + "','" + ACEStainResult.ClientID + "');", true);
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
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while setting investigation values", ex);
        }
    }
    #endregion

   
}
