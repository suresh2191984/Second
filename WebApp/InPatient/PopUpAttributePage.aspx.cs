using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Xml;

public partial class InPatient_PopUpAttributePage : BasePage
{
    /*--------------------------------------------------------------------------------------
     * Created Date : 23rd Dec 2010 
     * Author Name  : Venkatesh.K
     * Description  : This page has been created for load TPA Attribute Control. Page can be used as popup
     *                page in QuickBill.
    ---------------------------------------------------------------------------------------*/
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            long visitID = -1;
            long patientID = -1;
            long TpaID = -1;
            long ClientID = -1;
            
            Int64.TryParse(Request.QueryString["VID"], out visitID);
            Int64.TryParse(Request.QueryString["PID"], out patientID);
            Int64.TryParse(Request.QueryString["TPAID"], out TpaID);
            Int64.TryParse(Request.QueryString["ClientID"], out ClientID);
            
           
            //if (!IsPostBack)
            //{
                hdnConval.Value = Request.QueryString["Con"];

                if (Request.QueryString["ClientID"] != null && Request.QueryString["ClientID"] != "")
                {
                    LoadClientAttributeControl(patientID, visitID, ClientID);
                }
                
            //}
        }
        catch (Exception ex)
        {
            Attune.Podium.Common.CLogger.LogError("Error in load TPA attrib Control(InPatient_PopUpAttributePage)", ex);
        }
    }

    /// <summary>
    /// Load TPA Attribute Control based on 
    /// </summary>
    /// <param name="PatientID"></param>
    /// <param name="VisitID"></param>
    /// <param name="TpaID"></param>
    
    /// <summary>
    /// Return XML String based on attribute control
    /// </summary>
    /// <returns></returns>
    public string GetXML()
    {
        ArrayList al = new ArrayList();
        ArrayList type = new ArrayList();
        al = (ArrayList)ViewState["ControlId"];
        type = (ArrayList)ViewState["Type"];
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<TpaAttributes></TpaAttributes>");
        XmlNode xmlNode;

        if (al != null)
        {
            if (al.Count > 0)
            {
                for (int i = 0; i < al.Count; i++)
                {
                    if (type[i].ToString() == "1")
                    {

                        InPatient_AttribWithDate ctr = (InPatient_AttribWithDate)this.FindControl(al[i].ToString());
                        XmlElement xmlElement = Doc.CreateElement("AttribDetails");
                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                        xmlNode.InnerText = ctr.ID;
                        xmlElement.AppendChild(xmlNode);

                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                        xmlNode.InnerText = ctr.Name;
                        xmlElement.AppendChild(xmlNode);

                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "Type", "");
                        xmlNode.InnerText = ctr.DataType;
                        xmlElement.AppendChild(xmlNode);

                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                        xmlNode.InnerText = ctr.Text;
                        xmlElement.AppendChild(xmlNode);

                        Doc.DocumentElement.AppendChild(xmlElement);
                    }
                    if (type[i].ToString() == "2")
                    {

                        InPatient_TPAArttibControl ctr = (InPatient_TPAArttibControl)this.FindControl(al[i].ToString());
                        XmlElement xmlElement = Doc.CreateElement("AttribDetails");
                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "ID", "");
                        xmlNode.InnerText = ctr.ID;
                        xmlElement.AppendChild(xmlNode);

                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "Name", "");
                        xmlNode.InnerText = ctr.Name;
                        xmlElement.AppendChild(xmlNode);

                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "Type", "");
                        xmlNode.InnerText = ctr.DataType;
                        xmlElement.AppendChild(xmlNode);

                        xmlNode = Doc.CreateNode(XmlNodeType.Element, "Value", "");
                        xmlNode.InnerText = ctr.Text;
                        xmlElement.AppendChild(xmlNode);

                        Doc.DocumentElement.AppendChild(xmlElement);
                    }
                }
            }
        }
        //Doc.Save(@"d:\a.xml");
        hdnXMLStr.Value = Doc.InnerXml;
        IsColsePOP.Value = "Y";
        return Doc.InnerXml;

    }

    protected void btnAttrip_Click(object sender, EventArgs e)
    {
        hdnXMLStr.Value = GetXML();

    }
    public void CreateControl(string XMLString)
    {
        pnlAttrib.Controls.Clear();
        ArrayList sId = new ArrayList();
        ArrayList type = new ArrayList();
        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml(XMLString);
        string str = Doc.InnerXml;
        int count = Doc.GetElementsByTagName("AttribDetails").Count;
        Control ctrl = null;
        Table tbl = new Table();
        tbl.BorderWidth = Unit.Pixel(1);
        //pnlAttrib.Width = Unit.Pixel(100);
        tbl.Width = Unit.Percentage(100);
        TableRow tr;
        TableCell tc;
        ViewState["Load"] = null;
        ViewState["ControlId"] = null;
        ViewState["Type"] = null;
        foreach (XmlNode xmNode in Doc.GetElementsByTagName("AttribDetails"))
        {
            tr = new TableRow();
            tc = new TableCell();
            if (xmNode["Type"].InnerText == "DateTime")
            {

                TPAMaster TPm = new TPAMaster();
                InPatient_AttribWithDate DtCtrl;
                DtCtrl = (InPatient_AttribWithDate)LoadControl("~/InPatient/AttribWithDate.ascx");
                DtCtrl.Name = xmNode["Name"].InnerText;
                DtCtrl.ID = xmNode["ID"].InnerText;
                DtCtrl.DataType = xmNode["Type"].InnerText;
                DtCtrl.Text = xmNode["Value"].InnerText;
                sId.Add(xmNode["ID"].InnerText);
                type.Add(1);
                ViewState["ControlId"] = sId;
                ViewState["Type"] = type;
                tc.Controls.Add(DtCtrl);
                tr.Cells.Add(tc);
            }
            else
            {
                TPAMaster TPm = new TPAMaster();
                InPatient_TPAArttibControl Cntrl;
                Cntrl = (InPatient_TPAArttibControl)LoadControl("~/InPatient/TPAArttibControl.ascx");
                Cntrl.Name = xmNode["Name"].InnerText;
                Cntrl.ID = xmNode["ID"].InnerText;
                Cntrl.DataType = xmNode["Type"].InnerText;
                Cntrl.Text = xmNode["Value"].InnerText;
                type.Add(2);
                sId.Add(xmNode["ID"].InnerText);
                ViewState["ControlId"] = sId;
                ViewState["Type"] = type;
                tc.Controls.Add(Cntrl);
                tr.Cells.Add(tc);
            }

            tbl.Rows.Add(tr);
        }
        pnlAttrib.Controls.Add(tbl);
        ViewState["Load"] = "true";
    }
    public void LoadClientAttributeControl(long PatientID, long VisitID, long ClientID)
    {


        List<InPatientAdmissionDetails> lstpatients = new List<InPatientAdmissionDetails>();
        List<PatientEmployer> lstEmp = new List<PatientEmployer>();
        List<RTAMLCDetails> lstRTAMLCDetails = new List<RTAMLCDetails>();
        List<VisitClientMapping> lsttempVisitClientMapping = new List<VisitClientMapping>();
        IP_BL objIP_BL = new IP_BL(base.ContextInfo);
        string XMLSTR = string.Empty;
        List<Patient> lPatient = new List<Patient>();
        string type = string.Empty;
        type = Request.QueryString["type"].ToString();
        List<InvClientMaster> lstclientMaster = new List<InvClientMaster>();
        if (ClientID != 0)
        {
            new Patient_BL(base.ContextInfo).GetAdmissionPatientDemoandAddress(PatientID, VisitID, type, out lstpatients, out lstEmp, out lstRTAMLCDetails, out lPatient, out lsttempVisitClientMapping);
            //pnlTPADetails.Style.Add("display", "block");

            if (lsttempVisitClientMapping.Count > 0 && type != "NEW")
            {
                if (lsttempVisitClientMapping[0].ClientAttributes != string.Empty)
                {
                    XMLSTR = lsttempVisitClientMapping[0].ClientAttributes;
                }
                else
                {
                    objIP_BL.GetInvClientAttributes(OrgID, out lstclientMaster);
                    var childItems = from C in lstclientMaster
                                     where C.ClientID == ClientID
                                     select C;
                    if (childItems.Count() > 0)
                    {
                        if (childItems.ElementAt(0).ClientAttributes != null)
                        {
                            XMLSTR = childItems.ElementAt(0).ClientAttributes;
                        }
                    }

                }
            }
            else
            {
               
                objIP_BL.GetInvClientAttributes(OrgID, out lstclientMaster);
                var childItems = from C in lstclientMaster
                                 where C.ClientID== ClientID
                                 select C;

                // XMLSTR = lstTPAMaster[0].TPAAttributes;
                if (childItems.Count() > 0)
                {
                    if (childItems.ElementAt(0).ClientAttributes != null)
                    {
                        XMLSTR = childItems.ElementAt(0).ClientAttributes;
                    }
                }
            }
            //XMLSTR = "<TpaAttributes><AttribDetails><ID>Attrib1</ID><Name>URN.no</Name><Type>Numeric</Type><Value></Value></AttribDetails><AttribDetails><ID>Attrib2</ID><Name>Irn.no</Name><Value></Value><Type>AlphaNumeric</Type></AttribDetails><AttribDetails><ID>Attrib3</ID><Name>Autho Date</Name><Value></Value><Type>DateTime</Type>  </AttribDetails><AttribDetails><ID>Attrib4</ID><Name>Authisation No</Name><Value></Value><Type>DateTime</Type></AttribDetails></TpaAttributes>";

            if (XMLSTR != string.Empty)
            {
                CreateControl(XMLSTR);

            }
        }
        else
        {
            //pnlTPADetails.Style.Add("display", "none");
        }
    }
}
