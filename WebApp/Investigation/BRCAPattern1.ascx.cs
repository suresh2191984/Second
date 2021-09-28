using System;
using System.Data;
using System.Collections.Generic;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;
using System.Text;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using System.Xml;
using System.Xml.Linq;
using System.Web.Script.Serialization;

public partial class Investigation_BRCAPattern1 : BaseControl
{
    public Investigation_BRCAPattern1()
        : base("Investigation_BRCAPattern1_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string isAbnormal = string.Empty;
    private string id = string.Empty;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private long patientvid = -1;
    List<ProbesDetails> lstProbesDetails;
    List<ProbesDetails> lstProbesIDs;
    List<PatientInvestigationFiles> lstpatientImages;
    public string Name
    {
        get { return name; }
        set
        {
            name = value;
            lblName.Text = name;
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
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            hidVal.Value = id;
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
   

    #region "Initial"
    protected void Page_Load(object sender, EventArgs e)
    {
        long investigationid = -1;
        if (!string.IsNullOrEmpty(ControlID))
        {
            investigationid = Convert.ToInt32(ControlID);
        }
        if (!Page.IsPostBack)
        {
            long POrgID = -1;
            if (Request.QueryString["POrgID"] != null)
            {
                Int64.TryParse(Request.QueryString["POrgID"], out POrgID);

            }
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientvid);
            }

        }
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
    #endregion

    #region "Events"
    //protected void rptProbes_ItemDataBound(object sender, RepeaterItemEventArgs e)
    //{
    //    if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
    //    {
    //        HtmlInputText Result = (HtmlInputText)e.Item.FindControl("Result");
    //        HtmlInputText txtSignalpattern = (HtmlInputText)e.Item.FindControl("txtSignalpattern");
    //        HtmlInputText txtCountedCells = (HtmlInputText)e.Item.FindControl("txtCountedCells");
    //        HtmlInputText txtResultantcells = (HtmlInputText)e.Item.FindControl("txtResultantcells");
    //        HtmlInputText txtResults = (HtmlInputText)e.Item.FindControl("txtResults");
    //        HtmlInputButton btnDelete = (HtmlInputButton)e.Item.FindControl("btnDelete");
    //        HiddenField hdnInvestigationId = (HiddenField)e.Item.FindControl("hdnInvestigationId");
    //        HiddenField hdnPvisitid = (HiddenField)e.Item.FindControl("hdnPvisitid");
    //        HiddenField hdnOrgID = (HiddenField)e.Item.FindControl("hdnOrgID");
    //        HiddenField hdnResult = (HiddenField)e.Item.FindControl("hdnResult");

    //    }

    //}


    #endregion

    #region "Methods"
    public void loadStatus(List<InvestigationStatus> lstStatus)
    {
        ddlstatus.DataSource = lstStatus;
        ddlstatus.DataTextField = "DisplayText";
        ddlstatus.DataValueField = "StatuswithID";
        ddlstatus.DataBind();
        if (ddlstatus.Items.FindByValue("Pending_1") != null)
        {
            ddlstatus.SelectedValue = "Pending_1";
        }
        else if (ddlstatus.Items.FindByValue("Validate_1") != null)
        {
            ddlstatus.SelectedValue = "Validate_1";
        }
    }
    public InvestigationValues GetResult(long VID)
    {
        InvestigationValues InVestVal = new InvestigationValues();
        InVestVal = new InvestigationValues();
        InVestVal.Name = lblName.Text;
        InVestVal.Status = ddlstatus.SelectedItem.Text;
        InVestVal.InvestigationID = Convert.ToInt32(ControlID);
        InVestVal.Value = CreateXML();
        InVestVal.PatientVisitID = VID;
        InVestVal.GroupID = GroupID;
        InVestVal.GroupName = GroupName;
        InVestVal.Orgid = OrgID;
        InVestVal.CreatedBy = LID;
        return InVestVal;

    }
    public PatientInvestigation GetInvestigations(long Vid)
    {
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        hdnpatientvisitid.Value = Vid.ToString();
        string[] status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.OrgID = Convert.ToInt32(OrgID);//OrgID;        
        if (!String.IsNullOrEmpty(hdnstatusreason.Value))
        {
            Pinv.InvStatusReasonID = Convert.ToInt32(hdnstatusreason.Value.Split('~')[0].ToString());
            Pinv.Reason = hdnstatusreason.Value.Split('~')[1].ToString();
        }
        long LoginID = 0;
        if (!String.IsNullOrEmpty(hdnOpinionUser.Value))
        {
            Int64.TryParse(hdnOpinionUser.Value, out LoginID);
        }
        Pinv.GroupID = groupID;
        Pinv.AccessionNumber = AccessionNumber;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
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
            lstProbesIDs = new List<ProbesDetails>();
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strProbeResult = hdnFishResult.Value;
            List<Dictionary<string, string>> lstProbeResult = new List<Dictionary<string, string>>();
            if (!String.IsNullOrEmpty(strProbeResult))
            {
                lstProbeResult = serializer.Deserialize<List<Dictionary<string, string>>>(strProbeResult);
            }

            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationName", "");
            //Investigation  name node
            xmlNode.InnerText = Name;
            xmlElement.AppendChild(xmlNode);
            //Investigation id node
            xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "InvestigationID", "");
            xmlNode.InnerText = ControlID;
            xmlElement.AppendChild(xmlNode);
            XmlElement xmlElementProbe = xmlDoc.CreateElement("ProbeDetails");
            XmlNode xmlNodeProbe;
            XmlAttribute xmlSignalPattern;
            XmlAttribute xmlCountedNoofcells;
            XmlAttribute xmlResultantNoofcells;
            XmlAttribute xmlResults;

            foreach (Dictionary<string, string> obj in lstProbeResult)
            {
                xmlNodeProbe = xmlDoc.CreateNode(XmlNodeType.Element, "Probe", "");

                xmlSignalPattern = xmlDoc.CreateAttribute("SignalPattern");
                xmlSignalPattern.Value = obj["SignalPattern"];
                xmlNodeProbe.Attributes.Append(xmlSignalPattern);
                //CountedNoofcells
                xmlCountedNoofcells = xmlDoc.CreateAttribute("CountedNoofcells");
                xmlCountedNoofcells.Value = obj["CountedNoofcells"];
                xmlNodeProbe.Attributes.Append(xmlCountedNoofcells);
                //ResultantNoofcells
                xmlResultantNoofcells = xmlDoc.CreateAttribute("ResultantNoofcells");
                xmlResultantNoofcells.Value = obj["ResultantNoofcells"];
                xmlNodeProbe.Attributes.Append(xmlResultantNoofcells);
                //Results
                xmlResults = xmlDoc.CreateAttribute("Results");
                xmlResults.Value = obj["Results"];
                xmlNodeProbe.Attributes.Append(xmlResults);
                xmlElementProbe.AppendChild(xmlNodeProbe);
            }

            xmlElement.AppendChild(xmlElementProbe);
            xmlDoc.DocumentElement.AppendChild(xmlElement);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating xml", ex);
        }
        return xmlDoc.InnerXml;
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
    void loadXmlValue(string xmlTag)
    {
        try
        {
            if (xmlTag != string.Empty)
            {

                XDocument xdoc1 = XDocument.Parse(xmlTag);
                var invid = xdoc1.Element("InvestigationResults").Elements("InvestigationDetails").Elements("InvestigationID")
                            .Select(element => element.Value)
                           .ToList();

                long InvestigationID = Convert.ToInt32(invid[0]);

                lstProbesDetails
                = (from _probe in xdoc1.Element("InvestigationResults").Elements("InvestigationDetails").Elements("ProbeDetails").Elements("Probe")
                   select new ProbesDetails
                   {
                       SignalPattern = _probe.Attribute("SignalPattern").Value,
                       CountedNoofcells = _probe.Attribute("CountedNoofcells").Value,
                       ResultantNoofcells = _probe.Attribute("ResultantNoofcells").Value,
                       Results = _probe.Attribute("Results").Value,

                   }).ToList();



                if (lstProbesDetails.Count > 0)
                {
                    rptProbes1.DataSource = lstProbesDetails;
                    rptProbes1.DataBind();

                }


            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading xml data", ex);
        }
    }

    #endregion
}
