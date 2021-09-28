using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Linq;
using System.Xml;
using Attune.Podium.BillingEngine;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using Attune.Podium.PerformingNextAction;

public partial class ClinicalTrial_VisitEpisodeMaster : BasePage
{

    ClinicalTrail_BL CT_BL;

    protected void Page_Load(object sender, EventArgs e)
    {
        CT_BL = new ClinicalTrail_BL(base.ContextInfo);
        // txtEpisodeName.Focus();
        // btnExit.Focus();
        if (!IsPostBack)
        {
            long Eid = -1;
            string Res = string.Empty;
            SetContext();
            LoadMetaData();
            GetGroupValues();
            txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,1);");
            // txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','',0,0);");
            //txtToPeriod.Attributes.Add("onchange", "ExcedDate('" + txtToPeriod.ClientID.ToString() + "','txtToPeriod',0,1);"); 
            if ((!string.IsNullOrEmpty(Request.QueryString["Eid"])))
            {
                Eid = Convert.ToInt64(Request.QueryString["Eid"].ToString());
                List<Episode> lstEpisodeMaster = new List<Episode>();
                List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
                List<ProductEpisodeVisitMapping> lstProductDetails = new List<ProductEpisodeVisitMapping>();
                List<SiteEpisodeVisitMapping> lstSiteDetails = new List<SiteEpisodeVisitMapping>();
                CT_BL.GetEpisodeDetails(OrgID, "", Eid, out lstEpisodeMaster, out lstEpisodeVisitDetails, out lstProductDetails, out lstSiteDetails);
                //if (lstEpisodeMaster.Count > 0)
                //{
                gvclientmaster.DataSource = lstEpisodeMaster;
                gvclientmaster.DataBind();
                //}
            }
            else
            {
                GetClientDetails();
            }

            ScriptManager1.RegisterPostBackControl(btnFinish);
        }
    }
    public void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "ClientAttributeType,SubjectAllocation,CTStudyPhase,EpisodeVisitType,DateAttributes,Study Source";
            string[] Tempdata = domains.Split(',');
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaData(lstmetadataInput, out lstmetadataOutput);
            if (returncode == 0)
            {
                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "ClientAttributeType"
                                     orderby child.MetaDataID ascending
                                     select child;
                    if (childItems.Count() > 0)
                    {
                        ddlClientTypes.DataSource = childItems;
                        ddlClientTypes.DataTextField = "DisplayText";
                        ddlClientTypes.DataValueField = "Code";
                        ddlClientTypes.DataBind();
                    }
                    childItems = from child in lstmetadataOutput
                                 where child.Domain == "SubjectAllocation"
                                 orderby child.MetaDataID ascending
                                 select child;
                    if (childItems.Count() > 0)
                    {
                        ddlSiteWiseSubject.DataSource = childItems;
                        ddlSiteWiseSubject.DataTextField = "DisplayText";
                        ddlSiteWiseSubject.DataValueField = "Code";
                        ddlSiteWiseSubject.DataBind();

                        ddlVisitWiseSubject.DataSource = childItems;
                        ddlVisitWiseSubject.DataTextField = "DisplayText";
                        ddlVisitWiseSubject.DataValueField = "Code";
                        ddlVisitWiseSubject.DataBind();
                    }

                    childItems = from child in lstmetadataOutput
                                 where child.Domain == "CTStudyPhase"
                                 orderby child.MetaDataID ascending
                                 select child;
                    if (childItems.Count() > 0)
                    {
                        ddlCTStudyPhase.DataSource = childItems;
                        ddlCTStudyPhase.DataTextField = "DisplayText";
                        ddlCTStudyPhase.DataValueField = "Code";
                        ddlCTStudyPhase.DataBind();
                        ddlCTStudyPhase.Items.Insert(0, "--Select--");
                        ddlCTStudyPhase.Items[0].Value = "0";
                    }
                    childItems = from child in lstmetadataOutput
                                 where child.Domain == "EpisodeVisitType"
                                 orderby child.MetaDataID ascending
                                 select child;
                    if (childItems.Count() > 0)
                    {
                        ddlVisitType.DataSource = childItems;
                        ddlVisitType.DataTextField = "DisplayText";
                        ddlVisitType.DataValueField = "Code";
                        ddlVisitType.DataBind();
                        ddlVisitType.Items.Insert(0, "--Select--");
                        ddlVisitType.Items[0].Value = "0";
                    }
                    childItems = from child in lstmetadataOutput
                                 where child.Domain == "DateAttributes" && child.Code != "Y"
                                 orderby child.MetaDataID ascending
                                 select child;
                    if (childItems.Count() > 0)
                    {
                        ddlTimedType.DataSource = childItems;
                        ddlTimedType.DataTextField = "DisplayText";
                        ddlTimedType.DataValueField = "Code";
                        ddlTimedType.DataBind();

                    }
                    childItems = from child in lstmetadataOutput
                                 where child.Domain == "Study Source"
                                 orderby child.MetaDataID ascending
                                 select child;
                    if (childItems.Count() > 0)
                    {
                        ddlStudySource.DataSource = childItems;
                        ddlStudySource.DataTextField = "DisplayText";
                        ddlStudySource.DataValueField = "Code";
                        ddlStudySource.DataBind();

                    }
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);

        }
    }

    protected void btnFinishSample_Click(object sender, EventArgs e)
    {
        hdnEpisodeID.Value = Convert.ToString(123456);

        // TRFImageUpload.btnUpload_Click(sender, e);
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<SiteEpisodeVisitMapping> lstSiteEpisodeVisitMapping = new List<SiteEpisodeVisitMapping>();
        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
        List<ProductEpisodeVisitMapping> lstKitVisitDetails = new List<ProductEpisodeVisitMapping>();
        Episode lstEpisodeDetails = new Episode();
        string Attributes = string.Empty;
        string EpisodeStatus = string.Empty;
        string LifeStatus = string.Empty;
        long EpisodeID = -1;
        long EpID = hdnEpisodeID.Value == "" ? -1 : Convert.ToInt64(hdnEpisodeID.Value);


        lstEpisodeVisitDetails = CreateEpisodeVisitList(out lstSiteEpisodeVisitMapping, out lstKitVisitDetails);
        lstEpisodeDetails = CreateEpisodeDetails();
        EpisodeStatus = (ddlEpisodeStatus.Enabled) == true ? ddlEpisodeStatus.SelectedValue : "Pending";
        LifeStatus = ddlEpisodeLifeStatus.SelectedValue;
        returnCode = CT_BL.SaveEpisodeMaster(lstEpisodeDetails, lstEpisodeVisitDetails, lstSiteEpisodeVisitMapping, lstKitVisitDetails, OrgID, EpisodeStatus, LifeStatus, out EpisodeID);
        if (EpisodeID > 0)
        {
            Createtask(EpisodeID);
        }
        if (ChkTRFImage.Checked == true)
        {
            hdnEpisodeID.Value = Convert.ToString(EpisodeID);

            TRFImageUpload.btnUpload_Click(sender, e);
        }

        string AlertMesg = string.Empty;
        if (returnCode == 0)
        {
            if (EpID > 0)
            {
                AlertMesg = "Episode Updated sucessfully!";
            }
            else
            {
                AlertMesg = "Episode Added sucessfully!";
            }
        }
        else
        {
            if (EpID > 0)
            {
                AlertMesg = "Episode Updated Failed!";
            }
            else
            {
                AlertMesg = "Episode Added Failed!";
            }
        }
        string PageUrl = Request.ApplicationPath + @"/ClinicalTrial/VisitEpisodeMaster.aspx?IsPopup=Y";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"../ClinicalTrial/VisitEpisodeMaster.aspx?", true);
    }

    string CustomiseAttributeString(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        int count = Doc.GetElementsByTagName("AttribDetails").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("AttribDetails"))
        {
            HdnText += xmNode["Name"].InnerText + "~" + xmNode["Type"].InnerText + "~" + xmNode["Value"].InnerText + "~" + xmNode["ShowIn"].InnerText + "^";
        }
        return HdnText;
    }

    public string CreateEpisodeAttributesXML()
    {

        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<EpisodeAttributes></EpisodeAttributes>");
        XmlNode xmlNode;
        int x = 0;
        foreach (string O in hdnClientAttributes.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string Id = string.Empty;
                string name = string.Empty;
                string type = string.Empty;
                string value = string.Empty;
                string ShowIn = string.Empty;
                Id = x.ToString();
                x++;
                if (O.Split('~')[0] != string.Empty)
                {
                    name = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    type = O.Split('~')[1];
                }
                if (O.Split('~')[2] != string.Empty)
                {
                    value = O.Split('~')[2];
                }
                if (O.Split('~')[3] != string.Empty)
                {
                    ShowIn = O.Split('~')[3];
                }
                XmlElement xmlElement = Doc.CreateElement("AttribDetails");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = type;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                xmlNode.InnerText = value;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ShowIn", "");
                xmlNode.InnerText = ShowIn;
                xmlElement.AppendChild(xmlNode);

                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        return Doc.InnerXml;

    }

    public string CustomiseKitDetails(string XMLString)
    {
        string HdnText = string.Empty;

        string KitDetail = XMLString.Split('|')[0];

        string XMLKIT = string.Empty;
        foreach (string Str in XMLString.Split('^'))
        {
            if (Str != "")
            {
                string NewKit = string.Empty;
                int i = 0;
                int count = Str.Split('|').Count();
                foreach (string Str1 in Str.Split('|'))
                {
                    if (Str1 != "")
                    {
                        if (i == 5)
                        {
                            NewKit += CustomiseKitDetailsString(Str1) + "|" + CustomiseKitDetailsStringShow(Str1) + "|";
                        }
                        //else if (i == 8)
                        //{
                        //    NewKit += Str1;
                        //}
                        else if (i == count - 1)
                        {
                            NewKit += Str1;
                        }
                        else
                        {
                            NewKit += Str1 + "|";
                        }
                        i++;
                    }
                }
                XMLKIT += NewKit + "^";
            }

        }
        return XMLKIT;
    }
    public string CustomiseKitDetailsString(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        int count = Doc.GetElementsByTagName("KitDetails").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("KitDetail"))
        {
            HdnText += xmNode["ID"].InnerText + "~" + xmNode["Name"].InnerText + "~" + xmNode["Value"].InnerText + "@";
        }
        return HdnText;
    }
    public string CustomiseKitDetailsStringShow(string XMLString)
    {
        string HdnText = string.Empty;
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;

        int count = Doc.GetElementsByTagName("KitDetails").Count;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("KitDetail"))
        {
            HdnText += xmNode["Name"].InnerText + " : " + xmNode["Value"].InnerText + "(Nos) " + "<br>";
        }
        return HdnText;
    }
    public string CreateKitDetailsXML(string DelimiterValue)
    {
        //syed
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<KitDetails></KitDetails>");
        XmlNode xmlNode;
        int x = 0;
        foreach (string O in DelimiterValue.Split('@'))
        {
            if (O != string.Empty)
            {
                string Id = string.Empty;
                string name = string.Empty;
                string type = string.Empty;
                string value = string.Empty;
                string ShowIn = string.Empty;
                // Id = x.ToString();

                if (O.Split('~')[0] != string.Empty)
                {
                    Id = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    name = O.Split('~')[1];
                }
                if (O.Split('~')[2] != string.Empty)
                {
                    value = O.Split('~')[2];
                }

                XmlElement xmlElement = Doc.CreateElement("KitDetail");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                xmlNode.InnerText = value;
                xmlElement.AppendChild(xmlNode);

                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        return Doc.InnerXml;

    }

    public string CreateClientSiteAttributeXML()
    {
        //syed
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<ClientSiteAttributes></ClientSiteAttributes>");
        XmlNode xmlNode;
        int x = 0;
        foreach (string O in hdnChildClientID.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string Id = string.Empty;
                string name = string.Empty;

                // Id = x.ToString();

                if (O.Split('~')[0] != string.Empty)
                {
                    Id = O.Split('~')[0];
                }
                if (O.Split('~')[1] != string.Empty)
                {
                    name = O.Split('~')[1];
                }

                XmlElement xmlElement = Doc.CreateElement("ClientSiteAttribute");
                xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                xmlNode.InnerText = Id;
                xmlElement.AppendChild(xmlNode);

                xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                xmlNode.InnerText = name;
                xmlElement.AppendChild(xmlNode);

                Doc.DocumentElement.AppendChild(xmlElement);
            }
        }
        return Doc.InnerXml;

    }
    public string CustomiseClientSiteAttributesShow(string XMLString)
    {
        string HdnText = string.Empty;
        if (!string.IsNullOrEmpty(XMLString))
        {
            XmlDocument Doc = new XmlDocument();
            Doc.LoadXml(XMLString);
            string str = Doc.InnerXml;

            int count = Doc.GetElementsByTagName("ClientSiteAttributes").Count;
            foreach (XmlNode xmNode in Doc.GetElementsByTagName("ClientSiteAttribute"))
            {
                HdnText += xmNode["ID"].InnerText + "^";
            }
        }
        return HdnText;
    }
    public List<EpisodeVisitDetails> CreateEpisodeVisitList(out List<SiteEpisodeVisitMapping> lstSiteEpisodeVisitMapping, out List<ProductEpisodeVisitMapping> lstKitVisitDetails)
    {
        List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
        List<SiteEpisodeVisitMapping> lstSiteMapping = new List<SiteEpisodeVisitMapping>();
        List<ProductEpisodeVisitMapping> lstKitVisitDetail = new List<ProductEpisodeVisitMapping>();
        int NoOfVisit = 0;
        foreach (string listParent in hdnAddressDetails.Value.Split('^'))
        {
            if (listParent != "")
            {
                NoOfVisit++;
                EpisodeVisitDetails det = new EpisodeVisitDetails();

                string gUID = string.Empty;
                long EpisodeVisitId = -1;
                string[] listChild = listParent.Split('|');
                if (!string.IsNullOrEmpty(hdnEpisodeID.Value) && hdnEpisodeID.Value != "-1")
                {
                    det.EpisodeID = Convert.ToInt64(hdnEpisodeID.Value);
                }
                else
                {
                    hdnEpisodeID.Value = "-1";
                    det.EpisodeID = -1;
                }
                if (listChild[14] == "NEWVISIT")
                {
                    gUID = Guid.NewGuid().ToString();
                }
                else
                {
                    gUID = listChild[14].Trim();
                }
                if (listChild[15] == "-1")
                {
                    EpisodeVisitId = -1;
                }
                else
                {
                    EpisodeVisitId = Convert.ToInt64(listChild[15]);
                }
                det.EpisodeVisitName = listChild[0];
                det.TimedNo = Convert.ToInt32(listChild[2]);
                det.TimedType = listChild[8];
                det.EpisodeVisitNumber = Convert.ToInt32(listChild[4]);
                // det.PackageDetails = CreateKitDetailsXML(listChild[5]);
                //det.PackageDetails = CreateKitDetails(listChild[5], gUID, out lstKitDetails);
                //det.IsMandatory = listChild[7];
                det.IsMandatory = listChild[7] == "Yes" ? "Y" : "N";
                det.FeeID = Convert.ToInt64(listChild[9]);
                det.FeeType = "PKG";

                if (listChild[10] != "Proportional")
                {
                    var Sites = listChild[10].Split('@');
                    for (int j = 0; j < Sites.Count() - 1; j++)
                    {
                        var Site = Sites[j].Split('~');
                        SiteEpisodeVisitMapping SiteMap = new SiteEpisodeVisitMapping();
                        SiteMap.EpisodeVisitId = NoOfVisit;
                        SiteMap.SiteID = Convert.ToInt64(Site[0]);
                        SiteMap.NoOfSubjects = Convert.ToInt32(Site[2]);
                        SiteMap.Guid = gUID;
                        SiteMap.EpisodeVisitId = EpisodeVisitId;
                        SiteMap.SiteVisitMapID = Convert.ToInt64(Site[3]);
                        lstSiteMapping.Add(SiteMap);
                    }
                }


                foreach (string O in listChild[5].Split('@'))
                {
                    if (O != string.Empty)
                    {
                        ProductEpisodeVisitMapping KitDetails = new ProductEpisodeVisitMapping();
                        string Id = string.Empty;
                        string name = string.Empty;
                        string type = string.Empty;
                        string value = string.Empty;
                        string ProductVisitMapID = string.Empty;
                        if (O.Split('~')[0] != string.Empty)
                        {
                            Id = O.Split('~')[0];
                        }
                        if (O.Split('~')[1] != string.Empty)
                        {
                            name = O.Split('~')[1];
                        }
                        if (O.Split('~')[2] != string.Empty)
                        {
                            value = O.Split('~')[2];
                        }
                        if (O.Split('~')[3] != string.Empty)
                        {
                            ProductVisitMapID = O.Split('~')[3];
                        }
                        KitDetails.ProductID = Convert.ToInt64(Id);
                        KitDetails.ProductType = "KIT";
                        KitDetails.Value = Convert.ToInt32(value);
                        KitDetails.Guid = gUID;
                        KitDetails.EpisodeVisitId = EpisodeVisitId;
                        KitDetails.ProductVisitMapID = Convert.ToInt64(ProductVisitMapID);
                        lstKitVisitDetail.Add(KitDetails);
                    }
                }

                det.Guid = gUID;
                det.EpisodeVisitId = EpisodeVisitId;
                det.VisitType = Convert.ToInt32(listChild[13]);
                lstEpisodeVisitDetails.Add(det);
            }
        }
        lstSiteEpisodeVisitMapping = lstSiteMapping;
        lstKitVisitDetails = lstKitVisitDetail;
        hdnNoOfVisit.Value = NoOfVisit.ToString();

        return lstEpisodeVisitDetails;
    }
    public Episode CreateEpisodeDetails()
    {
        Episode lstEpisodeDetails = new Episode();

        if (!string.IsNullOrEmpty(hdnEpisodeID.Value))
        {
            lstEpisodeDetails.EpisodeID = Convert.ToInt64(hdnEpisodeID.Value);
        }
        else
        {
            lstEpisodeDetails.EpisodeID = -1;
        }

        lstEpisodeDetails.EpisodeName = txtEpisodeName.Text;
        lstEpisodeDetails.OrgID = OrgID;
        lstEpisodeDetails.ClientID = Convert.ToInt64(hdnOwnClientID.Value);
        lstEpisodeDetails.StudyTypeID = Convert.ToInt32(ddlEpisodeType.SelectedValue);
        lstEpisodeDetails.EpisodeNumber = txtEpisodeNo.Text;
        //  lstEpisodeDetails.ClientSiteAttribute = CreateClientSiteAttributeXML();
        if (!string.IsNullOrEmpty(txtFromPeriod.Text))
        {
            // lstEpisodeDetails.StartDate = Convert.ToDateTime(txtFromPeriod.Text);
            lstEpisodeDetails.Fdate = txtFromPeriod.Text;
        }
        else
        {
            // lstEpisodeDetails.StartDate = DateTime.MinValue;
            lstEpisodeDetails.Fdate = "";
        }

        if (!string.IsNullOrEmpty(txtToPeriod.Text))
        {
            //lstEpisodeDetails.EndDate = Convert.ToDateTime(txtToPeriod.Text);
            lstEpisodeDetails.Tdate = txtToPeriod.Text;
        }
        else
        {
            //lstEpisodeDetails.EndDate = DateTime.MinValue;
            lstEpisodeDetails.Tdate = "";
        }


        lstEpisodeDetails.Attributes = CreateEpisodeAttributesXML();// hdnClientAttributes.Value;// CreateEpisodeAttributesXML();
        lstEpisodeDetails.NoOfPatient = (string.IsNullOrEmpty(txtNoOfPatient.Text)) ? 0 : Convert.ToInt32(txtNoOfPatient.Text);
        lstEpisodeDetails.ISAdhoc = chkAdhoc.Checked ? "Y" : "N";
        lstEpisodeDetails.OrgLocationID = ILocationID;
        lstEpisodeDetails.CreatedBy = LID;
        lstEpisodeDetails.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        lstEpisodeDetails.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        lstEpisodeDetails.SiteWiseSubjectAllocation = Convert.ToInt32(ddlSiteWiseSubject.SelectedValue);
        lstEpisodeDetails.VisitWiseSubjectAllocation = Convert.ToInt32(ddlVisitWiseSubject.SelectedValue);

        //lstEpisodeDetails.SiteWiseSubjectAllocation = string.IsNullOrEmpty(hdnSetSiteSubjectAllocation.Value) ? 1 : Convert.ToInt32(hdnSetSiteSubjectAllocation.Value);
        //lstEpisodeDetails.VisitWiseSubjectAllocation = string.IsNullOrEmpty(hdnVisitWiseSubject.Value) ? 1 : Convert.ToInt32(hdnVisitWiseSubject.Value);

        lstEpisodeDetails.StudyPhaseID = Convert.ToInt32(ddlCTStudyPhase.SelectedValue);
        lstEpisodeDetails.NoofSitting = Convert.ToInt32(hdnNoOfVisit.Value);
        lstEpisodeDetails.StudyDesign = txtStudyDesign.Text;
        lstEpisodeDetails.TherapeuticVlaue = txtTherapeuticArea.Text;
        lstEpisodeDetails.StudySource = ddlStudySource.SelectedValue;
        lstEpisodeDetails.ReferenceLab = txtReferenceLab.Text;
        lstEpisodeDetails.IsUndefinedScreening = chkUndefinedScreening.Checked ? "Y" : "N";
        if (chkUndefinedScreening.Checked)
        {
            lstEpisodeDetails.ScreeningSubjects = 0;
        }
        else
        {
            lstEpisodeDetails.ScreeningSubjects = string.IsNullOrEmpty(txtscrSubjects.Text) == true ? 0 : Convert.ToInt32(txtscrSubjects.Text);
        }
        lstEpisodeDetails.NoOfSites = string.IsNullOrEmpty(txtSiteCount.Text) == true ? 0 : Convert.ToInt32(txtSiteCount.Text);
        return lstEpisodeDetails;
    }
    public void SetContext()
    {
        AutoCompleteExtenderPkg.ContextKey = "PKG" + "~" + OrgID.ToString() + "~" + "-1" + "~" + "OP" + "~" + "-1" + "~" + "Y" + "~" + "MGRATES";
        AutoCompleteProduct.ContextKey = "Kit";
        //AutoCompleteExtenderClientName.ContextKey = "CHILDCLIENT";
        AutoCompleteExtenderEpisodeName.ContextKey = "STY";
        AutoCompleteExtenderSiteName.ContextKey = "SIT";
        AutoCompleteExtenderEpisodeSearch.ContextKey = "STY";
    }
    public void ClearFields()
    {
        txtTherapeuticArea.Text = string.Empty;
        txtClientName.Text = "";
        ddlEpisodeType.SelectedIndex = 0;
        txtEpisodeName.Text = "";
        txtEpisodeNo.Text = "";
        txtFromPeriod.Text = "";
        txtToPeriod.Text = "";
        ddlClientTypes.SelectedIndex = 0;

        txtNoOfPatient.Text = "";
        chkAdhoc.Checked = false;

        txtVisitName.Text = "";
        txtPkgName.Text = "";
        txtTimedValue.Text = "";
        ddlTimedType.SelectedIndex = 0;
        txtVisitNo.Text = "";
        txtKitName.Text = "";
        txtNoOfKit.Text = "1";
        chkmandatory.Checked = false;

        hdnAddressDetails.Value = "";
        hdnEpisodeID.Value = "";
        hdnClientID.Value = "";
        hdnPackageID.Value = "";
        hdnNoOfVisit.Value = "";
        hdnAddressDetails.Value = "";
        hdnClientAttributes.Value = "";
        hdnOwnClientID.Value = "";

        //dvAtt1.Attributes.Add("style", "display:block");
        //dvAtt2.Attributes.Add("style", "display:none");
        //divLocation.Attributes.Add("style", "display:none");

        //tblClientAttributes.Attributes.Add("style", "display:none");
        //tblClientDetail.Attributes.Add("style", "display:none");

        txtKitName.Text = "";
        txtNoOfKit.Text = "";
        hdnKitDetails.Value = "";
        hdnKitID.Value = "";
        hdnKitTempTable1.Value = "";
        hdnKitTempTable2.Value = "";
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "KitTable", "GenerateKitDetailTable();", true);
        hdnAddressDetails.Value = "";
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AddressDetailss", "GenerateTable();", true);
        hdnClientAttributes.Value = "";
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AttributeTable", "GenerateEpisodeAttributesTable();", true);

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "AttributeTableDIV", "showNewDIV();", true);



    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        // ClearFields();
        GetClientDetails();
    }

    protected void btnExit_Click(object sender, EventArgs e)
    {
        Response.Redirect(@"../Admin/Home.aspx?", true);
    }
    public void GetClientDetails()
    {
        try
        {
            List<Episode> lstEpisodeMaster = new List<Episode>();
            List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
            List<ProductEpisodeVisitMapping> lstProductDetails = new List<ProductEpisodeVisitMapping>();
            List<SiteEpisodeVisitMapping> lstSiteDetails = new List<SiteEpisodeVisitMapping>();
            lstEpisodeMaster.Clear();
            long returncode = -1;
            int ClientID = 0;
            string EpisodeName = string.Empty;
            EpisodeName = txtClientNameSrch.Text;


            CT_BL.GetEpisodeDetails(OrgID, EpisodeName, -1, out lstEpisodeMaster, out lstEpisodeVisitDetails, out lstProductDetails, out lstSiteDetails);
            //if (lstEpisodeMaster.Count > 0)
            //{
            gvclientmaster.DataSource = lstEpisodeMaster;
            gvclientmaster.DataBind();

            //}

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while getting client - Invoicemaster.aspx", ex);
        }
    }
    protected void gvclientmaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            gvclientmaster.PageIndex = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
    }
    protected void gvclientmaster_RowDataCommand(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }
    protected void gvclientmaster_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onmouseover", "this.className='colornw'");
                e.Row.Attributes.Add("onmouseout", "this.className='colorpaytype1'");

                //e.Row.Cells[2].Attributes.Add("onmouseover", "this.className='colornw'");
                // e.Row.Cells[2].Attributes.Add("onmouseout", "this.className='colorpaytype1'");
                e.Row.Cells[0].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[1].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[2].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[3].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[4].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[5].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[6].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[7].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[8].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[9].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));
                e.Row.Cells[10].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "Select$" + e.Row.RowIndex));

                //e.Row.Cells[11].Attributes.Add("onmouseover", "this.style.cursor='pointer';this.className='hover'");
                //e.Row.Cells[11].Attributes.Add("onmouseout", "this.className='hout'");

                e.Row.Cells[12].Attributes.Add("onclick", this.Page.ClientScript.GetPostBackClientHyperlink(this.gvclientmaster, "ChangeStatus$" + e.Row.RowIndex));
            }

            Episode si = (Episode)e.Row.DataItem;
            string HIDstr = "";
            string strScript = "";
            string data = "";
            //e.Row.Cells[2].Attributes.Add("onmouseover", "this.style.cursor='pointer';this.className='hover'");
            //e.Row.Cells[2].Attributes.Add("onmouseout", "this.className='hout'");

            LinkButton lnkbtn = (LinkButton)e.Row.FindControl("btnEdit");

            Episode BMaster = (Episode)e.Row.DataItem;

            HiddenField ChildhdnGridEStatus = (HiddenField)e.Row.FindControl("hdnGridEStatus");
            DropDownList childddlGridEpisodeStatus = (DropDownList)e.Row.FindControl("ddlGridEpisodeStatus");


            childddlGridEpisodeStatus.SelectedValue = BMaster.LifeStatus;

            //if (si.ClientName.ToUpper() == "GENERAL")
            //{
            //    hdnclientnames.Value = "GENERAL";
            //    e.Row.Enabled = false;
            //}

        }
    }
    protected void gvclientmaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            List<Episode> lstEpisodeMaster = new List<Episode>();
            List<AddressDetails> lstAddress = new List<AddressDetails>();
            List<EpisodeVisitDetails> lstEpisodeVisitDetails = new List<EpisodeVisitDetails>();
            List<ProductEpisodeVisitMapping> lstProductDetails = new List<ProductEpisodeVisitMapping>();
            List<SiteEpisodeVisitMapping> lstSiteDetails = new List<SiteEpisodeVisitMapping>();
            lstEpisodeMaster.Clear();
            long returncode = -1;

            int EpisodeID = 0;
            string EpisodeName = string.Empty;
            if (e.CommandName == "Select")
            {
                int rowIndex = -1;
                rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow grow = gvclientmaster.Rows[rowIndex];
                EpisodeID = Convert.ToInt32(gvclientmaster.DataKeys[rowIndex][0].ToString());
                //   EpisodeName = gvclientmaster.DataKeys[rowIndex][1].ToString();



                // rowIndex = Convert.ToInt32(e.CommandArgument);
                // GridViewRow grow = grdResult.Rows[rowIndex];
                // hdnorderid.Value = grdResult.DataKeys[rowIndex][0].ToString();


                //ClientID = Convert.ToInt32(e.CommandArgument);
                ////int index = ((rowIndex) + (gvclientmaster.PageIndex * gvclientmaster.PageCount));
                //ClientID = Convert.ToInt32(gvclientmaster.DataKeys[rowIndex][0]); 
                //Convert.ToInt32(grdResult.DataKeys[rowIndex][1].ToString();

                lstEpisodeMaster.Clear();

                CT_BL.GetEpisodeDetails(OrgID, EpisodeName, EpisodeID, out lstEpisodeMaster, out lstEpisodeVisitDetails, out lstProductDetails, out lstSiteDetails);

                // returncode = masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);

                //if (e.CommandName == "ClientEdit")
                if (lstEpisodeMaster.Count > 0)
                {
                    var s = lstEpisodeMaster.Find(p => p.EpisodeID == EpisodeID);

                    ClearFields();

                    txtClientName.Text = s.ClientName;
                    ddlEpisodeType.SelectedValue = s.StudyTypeID.ToString();
                    txtEpisodeName.Text = s.EpisodeName;
                    txtEpisodeNo.Text = s.EpisodeNumber;
                    txtSponsor.Text = s.ClientName;
                    if (DateTime.Compare(s.StartDate, DateTime.MinValue) == 1)
                    {
                        txtFromPeriod.Text = s.StartDate.ToString() == "01/01/1900 00:00:00" ? "" : s.StartDate.ToString();
                    }
                    if (DateTime.Compare(s.EndDate, DateTime.MinValue) == 1)
                    {
                        txtToPeriod.Text = s.EndDate.ToString() == "01/01/1900 00:00:00" ? "" : s.EndDate.ToString();
                    }
                    //txtFromPeriod.Text = DateTime.Compare(s.StartDate, DateTime.MinValue) == 1 ? "" : s.StartDate.ToString();
                    //txtToPeriod.Text = DateTime.Compare(s.EndDate, DateTime.MinValue) == 1 ? "" : s.EndDate.ToString();

                    txtNoOfPatient.Text = s.NoOfPatient.ToString();
                    chkAdhoc.Checked = s.ISAdhoc.Trim() == "Yes" ? true : false;
                    hdnOwnClientID.Value = s.ClientID.ToString();
                    hdnEpisodeID.Value = s.EpisodeID.ToString();
                    ddlEpisodeLifeStatus.SelectedValue = s.LifeStatus;
                    ddlEpisodeStatus.SelectedValue = s.EpisodeStatus;
                    hdnEpisodeStatus.Value = s.EpisodeStatus;
                    txtStudyDesign.Text = s.StudyDesign;
                    txtTherapeuticArea.Text = s.TherapeuticVlaue;
                    ddlStudySource.SelectedValue = s.StudySource;
                    txtscrSubjects.Text = s.ScreeningSubjects.ToString();
                    txtReferenceLab.Text = s.ReferenceLab;
                    txtSiteCount.Text = s.VisitCount.ToString();
                    ddlCTStudyPhase.SelectedValue = s.StudyPhaseID.ToString();
                    chkUndefinedScreening.Checked = s.IsUndefinedScreening == "Y" ? true : false;
                    txtscrSubjects.Text = s.IsUndefinedScreening == "Y" ? "∞" : s.ScreeningSubjects.ToString();
                    txtscrSubjects.Enabled = s.IsUndefinedScreening == "Y" ? false : true;

                    //if (s.VisitDetails.Contains("&lt;"))
                    //{
                    //    s.VisitDetails = s.VisitDetails.Replace("&lt;", "<");
                    //}
                    //if (s.VisitDetails.Contains("&gt;"))
                    //{
                    //    s.VisitDetails = s.VisitDetails.Replace("&gt;", ">");
                    //}
                    //if (s.VisitDetails.Contains("&amp;lt;br&amp;gt;"))
                    //{
                    //    s.VisitDetails = s.VisitDetails.Replace("&amp;lt;br&amp;gt;", " <br> ");
                    //}

                    //  hdnAddressDetails.Value = CustomiseKitDetails(s.VisitDetails);
                    CustomiseKitDetails(lstEpisodeVisitDetails, lstProductDetails, lstSiteDetails);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "AddressDetailss", "GenerateTable();", true);
                    hdnClientAttributes.Value = CustomiseAttributeString(s.Attributes);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "AttributeTable", "GenerateEpisodeAttributesTable();", true);
                    btnFinish.Text = "Update";
                    if ((!string.IsNullOrEmpty(Request.QueryString["Eid"])) && (!string.IsNullOrEmpty(Request.QueryString["tid"])))
                    {
                        ddlEpisodeStatus.Enabled = true;
                        ddlEpisodeLifeStatus.Enabled = true;
                        tdApproveRemarks1.Attributes.Add("style", "display:block");
                        tdApproveRemarks2.Attributes.Add("style", "display:block");
                    }

                    hdnChildClientList.Value = s.ClientSiteAttribute;// s.ChildAttribute;
                    //8~SYED CRO###
                    var ParentClientList = s.ChildAttribute.Split('~');
                    txtClientName.Text = ParentClientList[1];
                    hdnClientID.Value = ParentClientList[0];
                    string IsFromTable = "Y";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "ClientSiteAttributes", "CreateChildClientList('" + IsFromTable + "');", true);
                    // tempChkChildIDs.Value = CustomiseClientSiteAttributesShow(s.ClientSiteAttribute);
                    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "ClientSiteAttributes", "CreateChildClientListTableFromPast();", true);

                    dvApproved.Attributes.Add("style", "display:block");

                    txtEpisodeNo.ReadOnly = true;
                    txtClientName.ReadOnly = true;
                    long ClientID = 0;
                    ClientID = Convert.ToInt64(hdnClientID.Value);
                    CT_BL.GetSitewiseContactList(ClientID, EpisodeID, Convert.ToInt32(OrgID), out lstAddress);
                    grdSitewiseContactList.DataSource = lstAddress;
                    grdSitewiseContactList.DataBind();
                    ddlSiteWiseSubject.SelectedValue = s.SiteWiseSubjectAllocation.ToString();
                    ddlVisitWiseSubject.SelectedValue = s.VisitWiseSubjectAllocation.ToString();
                    if (s.SiteWiseSubjectAllocation == 2 || s.VisitWiseSubjectAllocation == 2)
                    {
                        tdSite.Attributes.Add("style", "block");
                    }
                    #region command
                    //Chkisdeleted.Visible = true;
                    //txtClientCode.Text = s.ClientCode;
                    //hdnId.Value = s.ClientID.ToString();
                    //txtClientName.Text = s.ClientName;
                    //txtContactPersons.Text = s.ContactPerson;
                    //ddlClientType.SelectedValue = s.ClientTypeID.ToString();
                    //hdnAddressDetails.Value = s.AddressDetails;
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "AddressDetailss", "GenerateTable();", true);
                    //chkisapproval.Checked = s.ApprovalRequired.Trim() == "Y" ? true : false;
                    //chkloginneed.Checked = s.IsLoginNeeded.Trim() == "Y" ? true : false;
                    //chkIsLocked.Checked = s.BlockedClient.Trim() == "Y" ? true : false;
                    //Chkisdeleted.Checked = s.IsDeleted.Trim() == "Y" ? true : false;
                    //Chkiscash.Checked = s.ISCash.Trim() == "Y" ? true : false;
                    //txtpathlogist.Text = s.Pathologist;
                    //txtsalesmancode.Text = s.SalesManName;
                    //hdntxtsalesmancode.Value = s.SalesManID.ToString();
                    //txtsapcode.Text = s.SapCode;
                    //txtzone.Text = s.ZoneName;
                    //hdntxtzoneID.Value = s.ZonalID.ToString();
                    //txtServiceTaxNo.Text = s.ServiceTaxNo;
                    //txtcstno.Text = s.CstNo;
                    //txtContactPersons.Text = s.ContactPerson;
                    //txtCreditDays.Text = s.CreditDays.ToString();
                    //txtcreditlimit.Text = s.CreditLimit.ToString();
                    //if (s.ParentClientName != "" && s.ParentClientName != null)
                    //{
                    //    isparentclient.Attributes.Add("style", "display:block");
                    //    txtparentClient.Text = s.ParentClientName;
                    //    chkisparent.Checked = true;
                    //}
                    //else
                    //{
                    //    isparentclient.Attributes.Add("style", "display:none");
                    //}
                    //hdnParentClientID.Value = s.ParentClientID.ToString();
                    //txtgracedays.Text = s.GraceDays.ToString();
                    //txtgracelimit.Text = s.GraceLimit.ToString();
                    //drpBusinessType.SelectedValue = s.CustomerType.ToString();
                    //drpreportformat.SelectedValue = s.ReportTemplateID.ToString();
                    //txtPanNo.Text = s.PanNo;
                    //txtcollectioncenter.Text = s.CollectionCenter;
                    //hdncollectioncenterid.Value = s.CollectionCenterID.ToString();
                    //fckInvDetailss.Value = s.Termsconditions;
                    //ddlClientType.SelectedValue = s.ClientTypeID.ToString();
                    //lbidcode.Attributes.Add("style", "display:block");
                    //txtclcode.Attributes.Add("style", "display:block");
                    //txtClientCode.Enabled = false;
                    //foreach (string txt in s.DespatchMode.Split('^'))
                    //{
                    //    foreach (ListItem item in chkDespatch.Items)
                    //    {

                    //        if (item.Value.Trim() == txt.Trim())
                    //        {
                    //            item.Selected = true;
                    //        }
                    //    }
                    //}
                    //foreach (string txt in s.ClientAttributes.Split('^'))
                    //{
                    //    foreach (ListItem item in chkClientAttributes.Items)
                    //    {

                    //        if (item.Value.Trim() == txt.Trim())
                    //        {
                    //            item.Selected = true;
                    //        }
                    //    }
                    //}

                    //foreach (string txt in s.ClientPayment.Split('^'))
                    //{
                    //    foreach (ListItem item in chkPaymentMode.Items)
                    //    {

                    //        if (item.Value.Trim() == txt.Trim())
                    //        {
                    //            item.Selected = true;
                    //        }
                    //    }
                    //}

                    //if (s.Attributes != "")
                    //{
                    //    string datas = CustomiseString(s.Attributes);
                    //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "xmlattrib", "LoadOrdItemsCorp('" + datas + "');", true);
                    //}
                    #endregion

                }
            }
            if (e.CommandName == "ChangeStatus")
            {

                int rowIndexS = -1;
                rowIndexS = Convert.ToInt32(e.CommandArgument);
                EpisodeID = Convert.ToInt32(gvclientmaster.DataKeys[rowIndexS][0].ToString());
                EpisodeName = gvclientmaster.DataKeys[rowIndexS][1].ToString();

                GridViewRow row = gvclientmaster.Rows[rowIndexS];
                DropDownList childddlGridEpisodeStatus = (DropDownList)row.FindControl("ddlGridEpisodeStatus");
                string EpisodeLifeStatus = childddlGridEpisodeStatus.SelectedValue;

                CT_BL.UpdateEpisodeLifeStatus(EpisodeID, EpisodeLifeStatus, OrgID, LID);
                GetClientDetails();
            }
            SetFocus(btnFinish);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Editing Client Attributes.", ex);

        }


    }
    private long SaveTRFPicture(string Pnumber, string ClientID)
    {
        string pathname = GetConfigValue("TRF_UploadPath", OrgID);
        long returncode = -1;
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            string VisitID = string.Empty;
            String VisitNumber = String.Empty;

            new Patient_BL(base.ContextInfo).GetPatientVisitNumber(Convert.ToInt64(Pnumber), out VisitID, out VisitNumber);

            //Modified / By Arivalagan K//
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;
            //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf
            String Root = String.Empty;
            String RootPath = String.Empty;
            //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            Root = "UnKnown-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            //ENd///


            HttpFileCollection hfc = Request.Files;
            //HttpFileCollection hf1= HttpContext.Current.Request.Files;
            // HttpFileCollection hfc = TRFFiles();

            for (int i = 0; i < hfc.Count; i++)
            {
                if (hfc.AllKeys[i] == "FileUpload1")
                {
                    HttpPostedFile hpf = hfc[i];
                    if (hpf.ContentLength > 0)
                    {

                        string fileName = Path.GetFileNameWithoutExtension(hpf.FileName);
                        string fileExtension = Path.GetExtension(hpf.FileName);
                        //string imagePathname = ConfigurationManager.AppSettings["UploadPath"];
                        //string imagePath = imagePathname + pathname;
                        string imagePath = pathname;
                        string picNameWithoutExt = Pnumber + '_' + ClientID + '_' + OrgID + '_' + fileName;
                        string pictureName = string.Empty;
                        string filePath = string.Empty;
                        Response.OutputStream.Flush();
                        string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                        foreach (string path in fileNames)
                        {
                            File.Delete(path);
                        }
                        string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            pictureName = picNameWithoutExt + ".jpg";
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            int thumbWidth = 640, thumbHeight = 480;
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
                            //bmp.Save(filePath, ImageFormat.Jpeg);
                            if (System.IO.Directory.Exists(RootPath))
                            {
                                bmp.Save(filePath, ImageFormat.Jpeg);
                            }
                            // hpf.SaveAs(filePath,ImageFormat.Jpeg);
                            //hdnPatientImageName.Value = pictureName;
                            gr.Dispose();
                            bmp.Dispose();
                            image.Dispose();
                        }
                        else
                        {
                            pictureName = picNameWithoutExt + fileExtension;
                            //filePath = imagePath + pictureName;
                            filePath = RootPath + pictureName;
                            hpf.SaveAs(filePath);
                        }
                        ClinicalTrail_BL CT_BL = new ClinicalTrail_BL(base.ContextInfo);
                        long EID = Int64.Parse(Pnumber.ToString());
                        int CID = int.Parse(ClientID.ToString());
                        // returncode = CT_BL.SaveEpisodeTRFDetails(pictureName,fileName, EID, OrgID);
                        //hdnPatientImageName.Value = pictureName;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading LabRefOrgAddress Details.", ex);

        }
        return returncode;

    }
    //public HttpFileCollection TRFFiles()
    //{
    //    HttpFileCollection hfc = Request.Files;
    //    return hfc;
    //}
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    protected void EpisodeFileUpload_Click(object sender, FileUploadCollectionEventArgs e)
    {
        long EpisodeID = Convert.ToInt64(hdnEpisodeID.Value);

        string EpiID = hdnEpisodeID.Value;
        string Cid = hdnClientID.Value;
        long returncode = -1;
        string pathname = GetConfigValue("TRF_UploadPath", OrgID);
        HttpFileCollection oHttpFileCollection = e.PostedFiles;
        HttpPostedFile oHttpPostedFile = null;
        if (e.HasFiles)
        {
            for (int n = 0; n < e.Count; n++)
            {
                oHttpPostedFile = oHttpFileCollection[n];
                if (oHttpPostedFile.ContentLength <= 0)
                    continue;
                else
                {
                    // oHttpPostedFile.SaveAs(pathname + System.IO.Path.GetFileName(oHttpPostedFile.FileName));


                    string imagePath = pathname;
                    string FileType = string.Empty;

                    string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                    string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                    string picNameWithoutExt = EpiID + '_' + Cid + '_' + +OrgID;
                    string pictureName = EpiID + '_' + Cid + '_' + OrgID + '_' + Picture;
                    string NotImageFormat = EpiID + '_' + Cid + '_' + OrgID + '_' + FullName;
                    string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                    string filePath = imagePath + NotImageFormat;

                    foreach (string str in hdnFileValue.Value.Trim().Split('^'))
                    {
                        string[] FileName = str.Split('~');

                        if (FullName == FileName[0])
                        {
                            FileType = FileName[1];
                        }
                    }
                    Response.OutputStream.Flush();

                    string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                    if (imageExtension.Contains(fileExtension.ToUpper()))
                    {
                        pictureName = pictureName + ".jpg";
                        filePath = imagePath + pictureName;
                        int thumbWidth = 640, thumbHeight = 480;
                        System.Drawing.Image image = System.Drawing.Image.FromStream(oHttpPostedFile.InputStream);
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
                        bmp.Save(filePath, ImageFormat.Jpeg);
                        gr.Dispose();
                        bmp.Dispose();
                        image.Dispose();
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(EpiID.ToString());
                        int Vid = int.Parse(Cid.ToString());


                        returncode = CT_BL.SaveEpisodeTRFDetails(pictureName, FullName, EpisodeID, FileType, OrgID);
                    }
                    else
                    {
                        oHttpPostedFile.SaveAs(filePath);
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(EpiID.ToString());
                        int Vid = int.Parse(Cid.ToString());


                        returncode = CT_BL.SaveEpisodeTRFDetails(pictureName, FullName, EpisodeID, FileType, OrgID);

                    }

                    if (returncode >= 0)
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('File Uploaded Successfully');", true);
                        divUpload.Style.Add("Display", "none");
                    }
                }

            }
        }
    }

    public void Createtask(long EpisodeID)
    {
        List<Episode> lstEpisodeMaster = new List<Episode>();
        CT_BL.GetEpisodeTaskDetails(OrgID, EpisodeID, out lstEpisodeMaster);
        if (lstEpisodeMaster.Count > 0)
        {
            if (lstEpisodeMaster[0].TaskID > 0)
            {
                long taskID = lstEpisodeMaster[0].TaskID;
                string Remarks = txtApproveRemarks.Text;// hdnRemarks.Value;
                if (hdnEpisodeStatus.Value != lstEpisodeMaster[0].EpisodeStatus)
                {
                    switch (lstEpisodeMaster[0].EpisodeStatus)
                    {
                        case "Pending":
                            new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, Remarks);
                            break;
                        case "Approved":
                            new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, LID, Remarks);
                            SendSMS();
                            break;
                        case "Cancel":
                            new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Completed, LID, Remarks);
                            break;
                    }
                }
                if (lstEpisodeMaster[0].EpisodeStatus == "Pending" && lstEpisodeMaster[0].TaskStatusID == 5 && ddlEpisodeStatus.Enabled == true)
                {
                    new Tasks_BL(base.ContextInfo).UpdateCurrentTask(taskID, TaskHelper.TaskStatus.Pending, LID, "");
                }
            }
            else
            {

                long returncode = -1;
                Tasks task = new Tasks();
                Hashtable dText = new Hashtable();
                Hashtable urlVal = new Hashtable();
                string EpisodeName = lstEpisodeMaster[0].EpisodeName;
                string EpisodeNo = lstEpisodeMaster[0].EpisodeNumber;

                long createTaskID = -1;
                List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
                returncode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.Approval), EpisodeID, EpisodeName, "EPI", EpisodeNo
                             , out dText, out urlVal);
                task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.EpisodeApprovel);
                task.DispTextFiller = dText;
                task.URLFiller = urlVal;
                task.RoleID = RoleID;
                task.OrgID = OrgID;
                task.PatientVisitID = EpisodeID;
                task.PatientID = EpisodeID;
                task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                task.CreatedBy = LID;
                task.RefernceID = "";
                task.Type = "EPI";
                //Create task               
                returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
                string display = string.Empty;
            }
        }
        //returncode = new Investigation_BL(base.ContextInfo).GetWayToMethodKit(RoleID, OrgID, deptID, out display);

    }
    protected void btnTaskFinish_Click(object sender, EventArgs e)
    {
        // Createtask();
    }
    public void GetGroupValues()
    {
        long returnCode = -1;
        try
        {
            Master_BL obj = new Master_BL(base.ContextInfo);
            List<ClientAttributes> lstclientattrib = new List<ClientAttributes>();
            List<MetaValue_Common> lstmetavalue = new List<MetaValue_Common>();
            List<ActionManagerType> lstactiontype = new List<ActionManagerType>();
            List<InvReportMaster> lstrptmaster = new List<InvReportMaster>();
            returnCode = obj.GetGroupValues(OrgID, out lstmetavalue, out lstactiontype, out lstclientattrib, out lstrptmaster);

            if (lstmetavalue.Count > 0)
            {
                lstmetavalue.RemoveAll(p => p.Code != "BT");
                ddlEpisodeType.DataSource = lstmetavalue;
                ddlEpisodeType.DataTextField = "Value";
                ddlEpisodeType.DataValueField = "MetaValueID";
                ddlEpisodeType.DataBind();
                ddlEpisodeType.Items.Insert(0, "--Select--");
                ddlEpisodeType.Items[0].Value = "0";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error Occured to get Client Attributes", ex);
        }
    }
    public void CustomiseKitDetails(List<EpisodeVisitDetails> lstEpisodeVisitDetails, List<ProductEpisodeVisitMapping> lstProductDetails, List<SiteEpisodeVisitMapping> lstSiteDetails)
    {
        List<EpisodeVisitDetails> ob1 = new List<EpisodeVisitDetails>();
        List<ProductEpisodeVisitMapping> ob2 = new List<ProductEpisodeVisitMapping>();
        List<SiteEpisodeVisitMapping> ob3 = new List<SiteEpisodeVisitMapping>();


        string EpisodeVisitDetailsData = string.Empty;

        foreach (EpisodeVisitDetails Obj in lstEpisodeVisitDetails)
        {
            string EpisodeVisitName = string.Empty;
            string PackageName = string.Empty;
            string TimedDisplayText = string.Empty;
            string TimedType = string.Empty;
            string IsMandatory = string.Empty;
            string VisitTypeDisplayText = string.Empty;
            string Guid = string.Empty;
            int TimedNo = 0;
            int VisitType = 0;
            int EpisodeVisitNumber = 0;
            long FeeID = -1;
            string ProductEpisodeVisitMappingData = string.Empty;
            string SiteEpisodeVisitMappingData = string.Empty;
            string ProductEpisodeVisitMappingDisplayTest = string.Empty;
            string SiteEpisodeVisitMappingDisplayTest = string.Empty;
            long EpisodeVisitId = -1;


            ob2 = lstProductDetails.FindAll(p => p.Guid == Obj.Guid).ToList();
            foreach (ProductEpisodeVisitMapping Obj2 in ob2)
            {
                string ProductName = string.Empty;
                long ProductID = -1;
                int Value = 0;
                long ProductVisitMapID = -1;
                ProductName = Obj2.ProductName;
                ProductID = Obj2.ProductID;
                Value = Obj2.Value;
                ProductVisitMapID = Obj2.ProductVisitMapID;
                ProductEpisodeVisitMappingData += ProductID.ToString() + "~" + ProductName + "~" + Value.ToString() + "~" + ProductVisitMapID.ToString() + "@";
                ProductEpisodeVisitMappingDisplayTest += ProductName + ":" + Value.ToString() + " Subjects(Nos) <br>";
            }

            ob3 = lstSiteDetails.FindAll(p => p.Guid == Obj.Guid).ToList();
            foreach (SiteEpisodeVisitMapping Obj3 in ob3)
            {
                string ClientName = string.Empty;
                long SiteID = -1;
                int NoOfSubjects = 0;
                long SiteVisitMapID = -1;
                ClientName = Obj3.ClientName;
                SiteID = Obj3.SiteID;
                NoOfSubjects = Obj3.NoOfSubjects;
                SiteVisitMapID = Obj3.SiteVisitMapID;
                SiteEpisodeVisitMappingData += SiteID.ToString() + "~" + ClientName + "~" + NoOfSubjects.ToString() + "~" + SiteVisitMapID.ToString() + "@";
                SiteEpisodeVisitMappingDisplayTest += ClientName + ":" + NoOfSubjects.ToString() + " Nos) <br>";
            }
            EpisodeVisitId = Obj.EpisodeVisitId;
            EpisodeVisitName = Obj.EpisodeVisitName;
            PackageName = Obj.PackageName;
            TimedDisplayText = Obj.TimedDisplayText;
            TimedType = Obj.TimedType;
            IsMandatory = Obj.IsMandatory == "Y" ? "Yes" : "No";
            VisitTypeDisplayText = Obj.VisitTypeDisplayText;
            Guid = Obj.Guid;
            TimedNo = Obj.TimedNo;
            VisitType = Obj.VisitType;
            EpisodeVisitNumber = Obj.EpisodeVisitNumber;
            FeeID = Obj.FeeID;
            ProductEpisodeVisitMappingData = string.IsNullOrEmpty(ProductEpisodeVisitMappingData) == true ? "" : ProductEpisodeVisitMappingData;
            SiteEpisodeVisitMappingData = string.IsNullOrEmpty(SiteEpisodeVisitMappingData) == true ? "Proportional" : SiteEpisodeVisitMappingData;
            ProductEpisodeVisitMappingDisplayTest = string.IsNullOrEmpty(ProductEpisodeVisitMappingDisplayTest) == true ? "" : ProductEpisodeVisitMappingDisplayTest;
            SiteEpisodeVisitMappingDisplayTest = string.IsNullOrEmpty(SiteEpisodeVisitMappingDisplayTest) == true ? "Proportional" : SiteEpisodeVisitMappingDisplayTest;

            EpisodeVisitDetailsData += EpisodeVisitName + "|" + PackageName + "|" + TimedNo.ToString() + "|" + TimedDisplayText + "|" +
                EpisodeVisitNumber.ToString() + "|" + ProductEpisodeVisitMappingData + "|" + ProductEpisodeVisitMappingDisplayTest + "|" + IsMandatory + "|" +
                TimedType + "|" + FeeID + "|" + SiteEpisodeVisitMappingData + "|" + SiteEpisodeVisitMappingDisplayTest + "|" + VisitTypeDisplayText + "|" + VisitType.ToString() + "|" + Guid.ToString() + "|" + EpisodeVisitId.ToString() + "^";
        }
        if (!string.IsNullOrEmpty(EpisodeVisitDetailsData))
        {
            hdnAddressDetails.Value = EpisodeVisitDetailsData;
        }
    }

    public long SendSMS()
    {
        long retrunCode = -1;
        List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
        ActionManager am = new ActionManager(base.ContextInfo);
        List<NotificationAudit> NotifyAudit = new List<NotificationAudit>();
        PageContextkey PC = new PageContextkey();
        long LoginID = -1;
        LoginID = LID;
        PC.PatientID = LoginID;
        PC.RoleID = Convert.ToInt64(RoleID);
        PC.OrgID = OrgID;
        PC.ButtonName = btnFinish.ID;
        PC.ButtonValue = btnFinish.Text;
        PC.ID = Convert.ToInt64(hdnEpisodeID.Value);
        PC.PageID = 0;// Convert.ToInt64(hdnProtocalID.Value);
        PC.ContextType = "StudyApp";
        lstpagecontextkeys.Add(PC);
        retrunCode = am.PerformingMultipleNextStep(lstpagecontextkeys);
        return retrunCode;
    }
}