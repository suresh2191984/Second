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

public partial class Investigation_FishResultPattern1 : BaseControl
{
    public Investigation_FishResultPattern1()
        : base("Investigation_FishResultPattern1_ascx")
    {
    }
    private string name = string.Empty;
    private string uom = string.Empty;
    private string result = string.Empty;
    private string isAbnormal = string.Empty;
    private string id = string.Empty;
    private int maxlength = 0;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private long patientvid = -1;

    List<ProbesDetails> lstProbesDetails;
    List<ProbesDetails> lstProbesIDs;
    List<PatientInvestigationFiles> lstpatientImages;
    List<InvestigationBulkData> lstInvestigationBulkData;
    List<InvestigationBulkData> lstInvBulkDataResultsType;
    List<InvestigationBulkData> lstInvBulkDataResults;
    //public static DataTable dt;
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
        BindProbesDropdown(investigationid);
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
    }
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
        //List<InvestigationValues> lstVal = new List<InvestigationValues>();


        InVestVal = new InvestigationValues();
        InVestVal.Name = lblName.Text;
        InVestVal.Status = ddlstatus.SelectedItem.Text;
        InVestVal.InvestigationID = Convert.ToInt32(ControlID);
        InVestVal.Value = CreateXML();
        //InVestVal.Name = "Image Uploader";        
        InVestVal.PatientVisitID = VID;
        InVestVal.GroupID = GroupID;
        InVestVal.GroupName = GroupName;
        InVestVal.Orgid = OrgID;
        InVestVal.CreatedBy = LID;
        //lstVal.Add(InVestVal);

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

            //FishResults Details

            XmlElement xmlElementProbe = xmlDoc.CreateElement("ProbeDetails");
            XmlNode xmlNodeProbe;
            XmlAttribute xmlProbeName;
            XmlAttribute xmlProbeID;
            //XmlAttribute xmlResultTypeID;
            XmlAttribute xmlResultType;
            XmlAttribute xmlSignalPattern;
            XmlAttribute xmlCountedNoofcells;
            XmlAttribute xmlResultantNoofcells;
            XmlAttribute xmlResults;
            XmlAttribute xmlImages;
            XmlAttribute xmlDescription;
            foreach (Dictionary<string, string> obj in lstProbeResult)
            {
                xmlNodeProbe = xmlDoc.CreateNode(XmlNodeType.Element, "Probe", "");
                //ProbeID
                xmlProbeID = xmlDoc.CreateAttribute("ProbeID");
                xmlProbeID.Value = obj["ProbeID"];
                xmlNodeProbe.Attributes.Append(xmlProbeID);
                //ProbeName
                xmlProbeName = xmlDoc.CreateAttribute("ProbeName");
                xmlProbeName.Value = obj["ProbeName"];
                xmlNodeProbe.Attributes.Append(xmlProbeName);
                //ResultTypeID
                //xmlResultTypeID = xmlDoc.CreateAttribute("ResultTypeID");
                //xmlResultTypeID.Value = obj["ResultTypeID"];
                //xmlNodeProbe.Attributes.Append(xmlResultTypeID);
                //ResultType
                xmlResultType = xmlDoc.CreateAttribute("ResultType");
                xmlResultType.Value = obj["ResultType"];
                xmlNodeProbe.Attributes.Append(xmlResultType);
                //SignalPattern
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
                //Images
                xmlImages = xmlDoc.CreateAttribute("Images");
                xmlImages.Value = obj["Images"];
                xmlNodeProbe.Attributes.Append(xmlImages);
                //Description
                xmlDescription = xmlDoc.CreateAttribute("Description");
                xmlDescription.Value = obj["Description"];

                string ProbeName1 = string.Empty;
                //foreach (var item in lstProbeResult)
                //{
                if (xmlProbeID.Value != "" && xmlImages.Value.Contains(":").ToString() != "")
                {
                    ProbesDetails Prob = new ProbesDetails();

                    //ProbesDetails ProbeDetails = new ProbesDetails();
                    ProbeName1 = xmlProbeName.Value.ToString();
                    Prob.ProbeName = ProbeName1;
                    lstProbesIDs.Add(Prob);
                }

                //}

                xmlNodeProbe.Attributes.Append(xmlDescription);

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
    public HttpFileCollection ProbeFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }
    public List<PatientInvestigationFiles> GetInvestigationFiles(long PatientVisitID, out bool Flag)
    {

        Flag = true;

        byte[] fileByte = new byte[byte.MinValue];
        HttpFileCollection hfc = ProbeFiles();
        HttpPostedFile hpf = null;
        List<PatientInvestigationFiles> PtFiles1 = new List<PatientInvestigationFiles>();
        PatientInvestigationFiles pFiles1 = null;
        for (int i = 0; i < hfc.Count; i++)
        {

            hpf = hfc[i];
            if (hpf.ContentLength <= 0)
                continue;
            else
            {
                if (hpf.ContentLength > 0)
                {

                    using (var binaryReader = new BinaryReader(hpf.InputStream))
                    {
                        fileByte = binaryReader.ReadBytes(hpf.ContentLength);
                    }
                    pFiles1 = new PatientInvestigationFiles();
                    pFiles1.PatientVisitID = PatientVisitID;
                    pFiles1.ImageSource = fileByte;
                    pFiles1.FilePath = lstProbesIDs[i].ProbeName.ToString();
                    pFiles1.CreatedBy = LID;
                    pFiles1.OrgID = OrgID;
                    pFiles1.InvestigationID = Convert.ToInt32(ControlID);
                    PtFiles1.Add(pFiles1);

                }
            }

        }

        return PtFiles1;
    }
    public void SetInvestigationValueForEdit(List<InvestigationValues> InvestigationData)
    {
        try
        {
            if (InvestigationData.Count > 0)
            {
                loadXmlValue(InvestigationData[0].Value);
            }
            //txtReason.Text = InvestigationData[0].Reason;
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
                ProbeImages(InvestigationID);



                lstProbesDetails
                = (from _probe in xdoc1.Element("InvestigationResults").Elements("InvestigationDetails").Elements("ProbeDetails").Elements("Probe")
                   select new ProbesDetails
                   {

                       ProbeID = Convert.ToInt64(_probe.Attribute("ProbeID").Value),
                       ProbeName = _probe.Attribute("ProbeName").Value,
                       //ResultTypeID = Convert.ToInt32(_probe.Attribute("ResultTypeID").Value),
                       ResultType = _probe.Attribute("ResultType").Value,
                       SignalPattern = _probe.Attribute("SignalPattern").Value,
                       CountedNoofcells = _probe.Attribute("CountedNoofcells").Value,
                       ResultantNoofcells = _probe.Attribute("ResultantNoofcells").Value,
                       Results = _probe.Attribute("Results").Value,
                       Images = _probe.Attribute("Images").Value,
                       Description = _probe.Attribute("Description").Value


                   }).ToList();

                for (int i = 0; i < lstProbesDetails.Count; i++)
                {
                    for (int j = 0; j < lstpatientImages.Count; j++)
                    {
                        if (lstProbesDetails[i].Images == lstpatientImages[j].FilePath)
                        {
                            lstProbesDetails[i].Images = lstpatientImages[j].FilePath;
                            lstProbesDetails[i].ImageSource = lstpatientImages[j].ImageSource;
                            lstProbesDetails[i].ProbeImageID = lstpatientImages[j].ImageID;
                            lstProbesDetails[i].OrgID = lstpatientImages[j].OrgID;
                            lstProbesDetails[i].InvestigationID = lstpatientImages[j].InvestigationID;
                            lstProbesDetails[i].PVisitId = lstpatientImages[j].PatientVisitID;
                            break;
                        }
                    }
                }


                if (lstProbesDetails.Count > 0)
                {
                    rptProbes.DataSource = lstProbesDetails;
                    rptProbes.DataBind();

                }


            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading xml data", ex);
        }
    }
    public void ProbeImages(long invid)
    {
        try
        {

            long returncode = -1;
            long POrgID = -1;

            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            hdninvid.Value = invid.ToString();
            lstpatientImages = new List<PatientInvestigationFiles>();
            if (Request.QueryString["POrgID"] != null)
            {
                Int64.TryParse(Request.QueryString["POrgID"], out POrgID);

            }
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientvid);

            }

            if (patientvid != null && invid != null)
            {
                returncode = InvestigationBL.ProbeImagesForPatientVisits(patientvid, invid, POrgID, out lstpatientImages);
            }
            BindProbesDropdown(invid);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while ProbeImages Getting ", ex);
        }
    }
    public void BindProbesDropdown(long invid)
    {
        try
        {
            long returncode = -1;
            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            lstInvestigationBulkData = new List<InvestigationBulkData>();
            lstInvBulkDataResultsType = new List<InvestigationBulkData>();
            lstInvBulkDataResults = new List<InvestigationBulkData>();
            returncode = InvestigationBL.GetProbeNames(invid, out lstInvestigationBulkData);
            lstInvBulkDataResultsType = (from i in lstInvestigationBulkData.FindAll(p => p.InvestigationID == invid)
                                         where i.Name == "ResultsType"
                                         select new InvestigationBulkData { InvestigationID = i.InvestigationID, Name = i.Value, Value = Convert.ToString(i.Value) }).ToList();
            lstInvBulkDataResults = (from i in lstInvestigationBulkData.FindAll(p => p.InvestigationID == invid)
                                     where i.Name == "Results"
                                     select new InvestigationBulkData { InvestigationID = i.InvestigationID, Name = i.Value, Value = Convert.ToString(i.Value), ResultID = i.ResultID }).ToList();
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();

            List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
            List<NameValuePair> lstNameValueResult = new List<NameValuePair>();

            lstNameValuePair = (from bulk in lstInvBulkDataResults
                                select new NameValuePair { Name = bulk.Value, Value = Convert.ToString(bulk.ResultID) }).ToList();
            lstNameValueResult = (from bulk in lstInvBulkDataResultsType
                                  select new NameValuePair { Name = bulk.Value, Value = Convert.ToString(bulk.Value) }).ToList();
            hdnProbes.Value = oJavaScriptSerializer.Serialize(lstNameValuePair);
            hdnResultType.Value = oJavaScriptSerializer.Serialize(lstNameValueResult);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while BindProbesDropdown ", ex);
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
    protected void rptProbes_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            HtmlSelect Probes = (HtmlSelect)e.Item.FindControl("Probes");
            HtmlInputText Result = (HtmlInputText)e.Item.FindControl("Result");
            HtmlInputText txtSignalpattern = (HtmlInputText)e.Item.FindControl("txtSignalpattern");
            HtmlInputText txtCountedCells = (HtmlInputText)e.Item.FindControl("txtCountedCells");
            HtmlInputText txtResultantcells = (HtmlInputText)e.Item.FindControl("txtResultantcells");
            HtmlInputText txtResults = (HtmlInputText)e.Item.FindControl("txtResults");
            HtmlInputFile ImgUpload = (HtmlInputFile)e.Item.FindControl("ImgUpload");
            //HiddenField hdnIssummary = (HiddenField)e.Item.FindControl("hdnIssummary");
            HtmlInputButton btnDelete = (HtmlInputButton)e.Item.FindControl("btnDelete");
            HtmlInputHidden ProbeID = (HtmlInputHidden)e.Item.FindControl("ProbeID");
            //HtmlInputHidden ResultTypeID = (HtmlInputHidden)e.Item.FindControl("ResultTypeID");
            HiddenField HiddenProbeImageID = (HiddenField)e.Item.FindControl("HiddenProbeImageID");
            HiddenField hdnInvestigationId = (HiddenField)e.Item.FindControl("hdnInvestigationId");
            HiddenField hdnPvisitid = (HiddenField)e.Item.FindControl("hdnPvisitid");
            HiddenField hdnOrgID = (HiddenField)e.Item.FindControl("hdnOrgID");
            HiddenField hdnProbeName = (HiddenField)e.Item.FindControl("hdnProbeName");
            HiddenField hdnProbeid = (HiddenField)e.Item.FindControl("hdnProbeid");
            HiddenField hdnResult = (HiddenField)e.Item.FindControl("hdnResult");
            //HtmlInputCheckBox Issummary = (HtmlInputCheckBox)e.Item.FindControl("Issummary");




            Label imagpath = (Label)e.Item.FindControl("imagpath");
            System.Web.UI.WebControls.Image Probeimage = (System.Web.UI.WebControls.Image)e.Item.FindControl("Probeimage");
            Probeimage.ImageUrl = "ProbeImagehandler.ashx?InvID=" + hdnInvestigationId.Value + "&VisitId=" + hdnPvisitid.Value + "&POrgID=" + hdnOrgID.Value + "&ImageID=" + HiddenProbeImageID.Value;
            // txtDescription.Attributes.Add("onkeyup", "javascript:setCompletedStatus('" + GroupName + "',this.id);");
            //if (hdnIssummary.Value == "True")
            //{
            //    Issummary.Checked = true;
            //}
            //else
            //{
            //    Issummary.Checked = false;
            //}

            if (lstInvBulkDataResults != null && lstInvBulkDataResults.Count > 0)
            {
                Probes.DataSource = lstInvBulkDataResults;
                Probes.DataTextField = "Value";
                Probes.DataValueField = "ResultID";
                Probes.DataBind();
                Probes.Value = hdnProbeid.Value;

            }
            //if (lstInvBulkDataResultsType != null && lstInvBulkDataResultsType.Count > 0)
            //{
            //    Result.DataSource = lstInvBulkDataResultsType;
            //    Result.DataTextField = "Value";
            //    Result.DataValueField = "Value";
            //    Result.DataBind();
            //    Result.Value = hdnResult.Value;

            //}
        }

    }
}
