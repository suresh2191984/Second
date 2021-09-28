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

public partial class Investigation_Tablepatternautopopulate : BaseControl
{
    public Investigation_Tablepatternautopopulate()
        : base("Investigation_Tablepatternautopopulate_ascx")
    {
    }

    private string uom = string.Empty;
    private string result = string.Empty;
    private string isAbnormal = string.Empty;
    private string id = string.Empty;
    private string name = string.Empty;
    private long accessionNumber = 0;
    private long visitID = 0;
    private long patientID = 0;
    private string uID = string.Empty;
    private long patientvid = -1;
    long investigationid = -1;
    List<PatientInvestigationFiles> lstpatientImages;
    List<InvestigationBulkData> lstInvestigationBulkData;

    protected void Page_Load(object sender, EventArgs e)
    {


        {
            investigationid = Convert.ToInt32(ControlID);
            hdnInvestigationId.Value = investigationid.ToString();
            long POrgID = -1;
            if (Request.QueryString["POrgID"] != null)
            {
                Int64.TryParse(Request.QueryString["POrgID"], out POrgID);
                hdnOrgID.Value = POrgID.ToString();
            }
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientvid);
                hdnPvisitid.Value = patientvid.ToString();
            }
        }
       // ddlstatus.SelectedIndex = 0;
        if (!Page.IsPostBack)
        {

            long POrgID = -1;
            if (Request.QueryString["POrgID"] != null)
            {
                Int64.TryParse(Request.QueryString["POrgID"], out POrgID);
                hdnOrgID.Value = POrgID.ToString();
            }
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out patientvid);
                hdnPvisitid.Value = patientvid.ToString();
            }

        }
        BindDropdown(investigationid);
        ScriptManager.RegisterStartupScript(this, GetType(), this.ClientID, "DynamicTable(" + investigationid + "," + hdnOrgID.Value + "," + hdnPvisitid.Value + ",'" + this.ClientID + "');", true);
        // ScriptManager.RegisterStartupScript(this, GetType(), this.ClientID, "javascript:AddGeneralPattern('" + tbl.ClientID + "','" + this.ClientID + "','" + GroupName + "',this.id);", true);
        //BtnAdd.Attributes.Add("onclick", "javascript:NewGeneralPattern('" + tbl.ClientID + "','" + this.ClientID + "','" + GroupName + "',this.id);");
        BtnAdd.Attributes.Add("onclick", "javascript:NewGeneralPattern('" + tbl.ClientID + "','" + this.ClientID + "',this.id);");
        ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
        ddlStatusReason.Attributes.Add("onchange", "javascript:checkreasonifempty(this.id,'" + hdnstatusreason.ClientID + "');");
        ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");


    }
    public InvestigationValues GetResult(long VID)
    {
        InvestigationValues InVestVal = new InvestigationValues();
        InVestVal = new InvestigationValues();
        InVestVal.Name = lblName.Text;
        string[] status = ddlstatus.SelectedValue.Split('_');
        InVestVal.Status = status[0].ToString();
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
        Pinv.LoginID = LoginID;
        Pinv.GroupID = groupID;
        hdnstatusreason.Value = "";
        hdnOpinionUser.Value = "";
        return Pinv;
    }
    public string CreateXML()
    {
        XmlDocument xmlDoc = new XmlDocument();
        XmlElement xmlTable1Element;
        List<XmlElement> lstTable1XmlElement = new List<XmlElement>();
        xmlDoc.LoadXml("<InvestigationResults></InvestigationResults>");
        XmlAttribute xmlAttribute;
        try
        {
            JavaScriptSerializer serializer = new JavaScriptSerializer();
            string strGenResult = hdnGeneral.Value;
            List<List<string>> lstGenResult = new List<List<string>>();
            if (!String.IsNullOrEmpty(strGenResult))
            {
                lstGenResult = serializer.Deserialize<List<List<string>>>(strGenResult);
            }
            int cellCount = 1;
            int rowCount = 1;
            foreach (List<string> rows in lstGenResult)
            {
                cellCount = 1;
                foreach (string cell in rows)
                {
                    xmlTable1Element = xmlDoc.CreateElement("Item");

                    xmlAttribute = xmlDoc.CreateAttribute("Value");
                    xmlAttribute.Value = string.IsNullOrEmpty(cell) ? string.Empty : cell;
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    xmlAttribute = xmlDoc.CreateAttribute("RowNo");
                    xmlAttribute.Value = rowCount.ToString();
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    xmlAttribute = xmlDoc.CreateAttribute("ColumnNo");
                    xmlAttribute.Value = cellCount.ToString();
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    xmlAttribute = xmlDoc.CreateAttribute("ColumnCount");
                    xmlAttribute.Value = rows.Count.ToString();
                    xmlTable1Element.Attributes.Append(xmlAttribute);

                    cellCount = cellCount + 1;
                    xmlDoc.DocumentElement.AppendChild(xmlTable1Element);
                }
                rowCount = rowCount + 1;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while creating xml", ex);
        }
        return xmlDoc.InnerXml;
    }

    public HttpFileCollection HPVFiles()
    {
        HttpFileCollection hfc = Request.Files;
        return hfc;
    }
    public List<PatientInvestigationFiles> GetInvestigationFiles(long PatientVisitID, out bool Flag)
    {
        Flag = true;
        byte[] fileByte = new byte[byte.MinValue];
        HttpFileCollection hfc = HPVFiles();
        HttpPostedFile hpf = null;
        List<PatientInvestigationFiles> PtFiles1 = new List<PatientInvestigationFiles>();
        PatientInvestigationFiles pFiles1 = null;
        List<NameValuePair> lstNameValuePair = new List<NameValuePair>();
        JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
        string strProbeResult = hdnImageList.Value;
        if (hdnImageList.Value != string.Empty)
        {
            lstNameValuePair = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnImageList.Value);
            List<NameValuePair> lstImgWidthHeight = new List<NameValuePair>();
            lstImgWidthHeight = oJavaScriptSerializer.Deserialize<List<NameValuePair>>(hdnimghtwidth.Value);

            string imageFilePath = string.Empty;
            string patternid = string.Empty;
            int thumbWidth = 0;
            int thumbHeight = 0;
            bool flag = false;
            for (int i = 0; i < hfc.Count; i++)
            {
                hpf = hfc[i];

                flag = false;

                foreach (NameValuePair lst in lstImgWidthHeight)
                {
                    if (lst.ParentID == "image")
                    {
                        thumbHeight = int.Parse(lst.Name);
                        thumbWidth = int.Parse(lst.Value);
                    }
                }
                foreach (NameValuePair o in lstNameValuePair)
                {
                    if (o.Name == hfc.Keys[i])
                    {
                        imageFilePath = o.Value;
                        patternid = o.ParentID;
                        flag = true;
                    }
                }
                if (flag == true)
                {
                    if (hpf.ContentLength <= 0)
                        continue;
                    else
                    {
                        if (hpf.ContentLength > 0)
                        {
                            if (thumbHeight > 0 && thumbWidth > 0)
                            {
                                MemoryStream ms = new MemoryStream();
                                System.Drawing.Image image = System.Drawing.Image.FromStream(hpf.InputStream);
                                int srcWidth = image.Width;
                                int srcHeight = image.Height;
                                if (thumbWidth > srcWidth)
                                    thumbWidth = srcWidth;
                                if (thumbHeight > srcHeight)
                                    thumbHeight = srcHeight;
                                Bitmap bmp = new Bitmap(thumbWidth, thumbHeight);
                                System.Drawing.Graphics gr = System.Drawing.Graphics.FromImage(bmp);
                                gr.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
                                gr.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
                                gr.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.High;
                                gr.PixelOffsetMode = System.Drawing.Drawing2D.PixelOffsetMode.HighQuality;
                                System.Drawing.Rectangle rectDestination = new System.Drawing.Rectangle(0, 0, thumbWidth, thumbHeight);
                                gr.DrawImage(image, rectDestination, 0, 0, srcWidth, srcHeight, GraphicsUnit.Pixel);
                                bmp.Save(ms, ImageFormat.Jpeg);
                                fileByte = ms.ToArray();
                                gr.Dispose();
                                bmp.Dispose();
                                image.Dispose();
                                ms.Dispose();
                            }
                            else
                            {
                                using (var binaryReader = new BinaryReader(hpf.InputStream))
                                {
                                    fileByte = binaryReader.ReadBytes(hpf.ContentLength);
                                }
                            }
                            pFiles1 = new PatientInvestigationFiles();
                            pFiles1.PatientVisitID = PatientVisitID;
                            pFiles1.ImageSource = fileByte;
                            pFiles1.ImageID = Convert.ToInt64(patternid);
                            pFiles1.FilePath = imageFilePath;
                            pFiles1.CreatedBy = LID;
                            pFiles1.OrgID = OrgID;
                            pFiles1.InvestigationID = Convert.ToInt32(ControlID);
                            PtFiles1.Add(pFiles1);
                        }
                    }
                }
            }
        }
        return PtFiles1;
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
    public void SetInvestigationValueForEdit(List<InvestigationValues> InvestigationData)
    {
        try
        {
            if (InvestigationData.Count > 0)
            {
                loadXmlValue(InvestigationData[0].Value, InvestigationData[0].InvestigationID);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while setting investigation values", ex);
        }
    }
    void loadXmlValue(string xmlTag, long investigationid)
    {
        try
        {
            if (xmlTag != string.Empty)
            {
                XmlDocument xdoc1 = new XmlDocument();
                xdoc1.LoadXml(xmlTag);
                bool isTableExists;
                BindDropdown(investigationid);
                GenPtnImages(investigationid);
                JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
                List<List<string>> lstTable = new List<List<string>>();
                List<string> oTable = new List<string>();
                Int32 rowNo = 0;
                Int32 xmlRowNo = 0;
                XmlNodeList lstTable2Items = xdoc1.SelectNodes("/InvestigationResults/Item");
                if (lstTable2Items != null && lstTable2Items.Count > 0)
                {
                    isTableExists = true;
                    lstTable = new List<List<string>>();
                    oTable = new List<string>();
                    rowNo = 0;
                    xmlRowNo = 0;
                    foreach (XmlNode xmlNode in lstTable2Items)
                    {
                        Int32.TryParse(xmlNode.Attributes["RowNo"].Value, out xmlRowNo);
                        if (rowNo != xmlRowNo)
                        {
                            if (oTable.Count > 0)
                            {
                                lstTable.Add(oTable);
                            }
                            oTable = new List<string>();
                            rowNo = xmlRowNo;
                        }
                        oTable.Add(xmlNode.Attributes["Value"].Value);
                    }
                    if (oTable.Count > 0)
                    {
                        lstTable.Add(oTable);
                    }
                    hdnBindData.Value = oJavaScriptSerializer.Serialize(lstTable);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading xml data", ex);
        }
    }
    public void GenPtnImages(long invid)
    {
        try
        {
            long returncode = -1;
            long POrgID = -1;
            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            hdninvid.Value = invid.ToString();
            lstpatientImages = new List<PatientInvestigationFiles>();
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
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
                List<PatientInvestigationFiles> lstResult = (from R in lstpatientImages
                                                             select new PatientInvestigationFiles
                                                             {
                                                                 ImageID = R.ImageID,
                                                                 FilePath = R.FilePath
                                                             }).ToList();
                string maxFilePath = lstpatientImages.Max(P => P.FilePath);
                if (!string.IsNullOrEmpty(maxFilePath))
                {
                    hdnMaxFilePath.Value = maxFilePath;
                }
                hdnImgSourceDetails.Value = oJavaScriptSerializer.Serialize(lstResult);
            }
            BindDropdown(invid);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while GenPtnImages Getting ", ex);
        }
    }
    public void BindDropdown(long invid)
    {
        try
        {
            long returncode = -1;
            Investigation_BL InvestigationBL = new Investigation_BL(base.ContextInfo);
            lstInvestigationBulkData = new List<InvestigationBulkData>();
            returncode = InvestigationBL.GetProbeNames(invid, out lstInvestigationBulkData);
            JavaScriptSerializer oJavaScriptSerializer = new JavaScriptSerializer();
            hdnGeneralPattern.Value = oJavaScriptSerializer.Serialize(lstInvestigationBulkData.FindAll(p=>p.OrgID==OrgID));
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while BindDropdown ", ex);
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
    private string isAutoValidate = "N";
    public string IsAutoValidate
    {
        get { return isAutoValidate; }
        set
        {
           // hdnIsAutoValidate.Value = value;
            isAutoValidate = value;
        }
    }
    protected void ddlstatus_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void hdnReadonly_ValueChanged(object sender, EventArgs e)
    {

    }
}
