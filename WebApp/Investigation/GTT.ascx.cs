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

public partial class Investigation_GTT : BaseControl
{
    public Investigation_GTT()
        : base("Investigation_GTT_ascx")
    {
    }
    List<string> lString = new List<string>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Loadtime();
            if (hdnFirstLoad.Value != "0")
            {
                LoadMinutes();
            }
            string temp = "javascript:LoadOrdItems('" + tblResult.ClientID + "');";
            ScriptManager.RegisterStartupScript(this, typeof(Page), "LoadOrdItems", temp, true);
            DrawXML();

            txtRefRange.Attributes.Add("onkeyup", "setCompletedStatus('" + GroupName + "',this.id)");
            ddlstatus.Attributes.Add("onchange", "ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
            txtRefRange.ReadOnly = true;
            txtRefRange.Attributes.Add("onfocus", "javascript:expandBox(this.id);");
            txtRefRange.Attributes.Add("onblur", "javascript:collapseBox(this.id);");
            ddlstatus.Attributes.Add("onchange", "javascript:CheckIfEmpty(this.id,'txtValue');changedstatus(this.id,'" + ddlStatusReason.ClientID + "');ChangeGroupStatus('" + GroupName + "',this.id,'');ShowStatusReason(this.id);");
            ddlOpinionUser.Attributes.Add("onchange", "javascript:onChangeOpinionUser(this.id,'" + hdnOpinionUser.ClientID + "');");
            LoadMetaData();
        }
    }
    public void Loadtime()
    {
        //if ((ddlTime1.Items.Count == 0) ||

        //       (ddlTime1.Items.Count == 0) ||
        //       (ddlTime2.Items.Count == 0) ||
        //       (ddlTime3.Items.Count == 0) ||
        //       (ddlTime4.Items.Count == 0) ||
        //       (ddlTime5.Items.Count == 0) ||
        //       (ddlTime6.Items.Count == 0) ||
        //       (ddlTime7.Items.Count == 0))
        //{
        //ddlTime1.Items.Clear();
        //ddlTime2.Items.Clear();
        //ddlTime3.Items.Clear();
        //ddlTime4.Items.Clear();
        //ddlTime5.Items.Clear();
        //ddlTime6.Items.Clear();
        //ddlTime7.Items.Clear();

        int i;
        DateTime dt = Convert.ToDateTime("12:00 am");
        DateTime time = DateTime.MinValue;
        DateTime value = DateTime.MinValue;

        ddlTime1.Items.Insert(0, "Hrs");
        ddlTime0.Items.Insert(0, "Hrs");
        ddlTime2.Items.Insert(0, "Hrs");
        ddlTime3.Items.Insert(0, "Hrs");
        ddlTime4.Items.Insert(0, "Hrs");
        ddlTime5.Items.Insert(0, "Hrs");
        ddlTime6.Items.Insert(0, "Hrs");
        ddlTime7.Items.Insert(0, "Hrs");

        for (i = 0; i <= 12; i++)
        {
            ddlTime1.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime0.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime2.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime3.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime4.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime5.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime6.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));
            ddlTime7.Items.Insert(i, new ListItem(i.ToString(), i.ToString()));

            dt = dt.AddMinutes(30);
        }

        //}
    }
    public void LoadMinutes()
    {
        int i;
        DateTime dt = Convert.ToDateTime("00 am");

        ddlMin1.Items.Clear();
        ddlMin0.Items.Clear();
        ddlMin2.Items.Clear();
        ddlMin3.Items.Clear();
        ddlMin4.Items.Clear();
        ddlMin5.Items.Clear();
        ddlMin6.Items.Clear();
        ddlMin7.Items.Clear();
        //DateTime time = DateTime.MinValue;
        //DateTime value = DateTime.MinValue;
        //for (i = 0; i < 12; i++)
        //{
        //    ddlMin1.Items.Insert(i,dt.ToString("mm.FF"));
        //    ddlMin2.Items.Insert(i,dt.ToString("mm.FF"));
        //    ddlMin3.Items.Insert(i,dt.ToString("mm.FF"));
        //    ddlMin4.Items.Insert(i,dt.ToString("mm.FF"));
        //    ddlMin5.Items.Insert(i,dt.ToString("mm.FF"));
        //    ddlMin6.Items.Insert(i,dt.ToString("mm.FF"));
        //    ddlMin7.Items.Insert(i,dt.ToString("mm.FF"));
        //    dt = dt.AddMinutes(10);
        //}
        for (i = 300; i >= 0; i = i - 30)
        //for (i = 0; i < 180; i=i+30)
        {
            int j = 0;


            ddlMin1.Items.Insert(j, i.ToString());
            ddlMin0.Items.Insert(j, i.ToString());
            ddlMin2.Items.Insert(j, i.ToString());
            ddlMin3.Items.Insert(j, i.ToString());
            ddlMin4.Items.Insert(j, i.ToString());
            ddlMin5.Items.Insert(j, i.ToString());
            ddlMin6.Items.Insert(j, i.ToString());
            ddlMin7.Items.Insert(j, i.ToString());
            j++;
            //dt = dt.AddMinutes(10);
        }
        ddlMin1.Items.Insert(0, "Mins");
        ddlMin0.Items.Insert(0, "Mins");
        ddlMin2.Items.Insert(0, "Mins");
        ddlMin3.Items.Insert(0, "Mins");
        ddlMin4.Items.Insert(0, "Mins");
        ddlMin5.Items.Insert(0, "Mins");
        ddlMin6.Items.Insert(0, "Mins");
        ddlMin7.Items.Insert(0, "Mins");
    }
    string name = string.Empty;
    private long accessionNumber = 0;


      public long AccessionNumber
       {
        get { return accessionNumber; }
        set
        {
            hdnAccessionNumber.Value = Convert.ToString(value);
            accessionNumber = value;
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

    //public string UOM
    //{
    //    get { return uom; }
    //    set
    //    {
    //        uom = value;
    //        lblUnit.Text = uom;
    //    }
    //}

    string id = string.Empty;
    public string ControlID
    {
        get { return id; }
        set
        {
            id = value;
            //hidVal.Value = id;
        }
    }
    //public string Value
    //{
    //    get { return result; }
    //    set { result = value; }
    //}


    //public int Maxlength
    //{
    //    get { return maxlength; }
    //    set
    //    {
    //        maxlength = value;
    //        txtValue.MaxLength = maxlength;
    //    }
    //}

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

    string editTxtValue = string.Empty;


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
        InvestigationValues obj = new InvestigationValues();
        List<InvestigationValues> lInvValues = new List<InvestigationValues>();
        String[] status;
        obj.Name = lblName.Text;
        obj.InvestigationID = Convert.ToInt32(ControlID);
        obj.PatientVisitID = VID;
        obj.Value = DrawXML();
        obj.UOMCode = lblUom1.Text;
        obj.CreatedBy = LID;
        obj.GroupID = groupID;
        obj.GroupName = GroupName;
        obj.Orgid = Convert.ToInt32(POrgid);// OrgID;
        //obj.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        obj.Status = status[0].ToString();
        obj.PackageID = PackageID;
        obj.PackageName = PackageName;
        lInvValues.Add(obj);
        return lInvValues;
    }

    public PatientInvestigation GetInvestigations(long Vid)
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19 == null ? "-----Select-----" : Resources.Investigation_ClientDisplay.Investigation_WorkListFromVisitToVisit_aspx_19;
        List<PatientInvestigation> lstPInv = new List<PatientInvestigation>();
        PatientInvestigation Pinv = null;
        string[] status;
        Pinv = new PatientInvestigation();
        Pinv.InvestigationID = Convert.ToInt64(ControlID);
        Pinv.PatientVisitID = Vid;
        //Pinv.Status = ddlstatus.SelectedItem.Text;
        status = ddlstatus.SelectedValue.Split('_');
        Pinv.Status = status[0].ToString();
        Pinv.OrgID = Convert.ToInt32(POrgid);// OrgID;
        Pinv.AccessionNumber = AccessionNumber;	
        Pinv.ReferenceRange = txtRefRange.Text;
        if (Pinv.ReferenceRange.Trim() != "")
        {
            Pinv.ReferenceRange = Pinv.ReferenceRange.Trim().Replace("\n", "<br>");
        }
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
        return Pinv;
    }

    public void setAttributes(string id)
    {
        //txtReason.Attributes.Add("onfocus", "Clear('" + id + "_txtReason');");
        //txtReason.Attributes.Add("onblur", "setComments('" + id + "_txtReason');");
        //txtRefRange.Attributes.Add("onfocus", "Clear('" + id + "_txtRefRange');");
        //txtRefRange.Attributes.Add("onblur", "setComments('" + id + "_txtRefRange');");
    }
    public void LoadDataForEdit(List<InvestigationValues> lEditInvestigation)
    {
        lblName.Text = lEditInvestigation[0].Name;
        if (lEditInvestigation.Count > 0)
        {
            LoadXML(lEditInvestigation[0].Value);
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
    public void LoadData(List<InvestigationValues> LoadValues)
    {
        ddlData1.DataSource = LoadValues;
        ddlData1.DataTextField = "Value";
        ddlData1.DataBind();
        ddlData1.Items.Insert(0, "Select");

        ddlData0.DataSource = LoadValues;
        ddlData0.DataTextField = "Value";
        ddlData0.DataBind();
        ddlData0.Items.Insert(0, "Select");

        ddlData2.DataSource = LoadValues;
        ddlData2.DataTextField = "Value";
        ddlData2.DataBind();
        ddlData2.Items.Insert(0, "Select");

        ddlData3.DataSource = LoadValues;
        ddlData3.DataTextField = "Value";
        ddlData3.DataBind();
        ddlData3.Items.Insert(0, "Select");

        ddlData4.DataSource = LoadValues;
        ddlData4.DataTextField = "Value";
        ddlData4.DataBind();
        ddlData4.Items.Insert(0, "Select");

        ddlData5.DataSource = LoadValues;
        ddlData5.DataTextField = "Value";
        ddlData5.DataBind();
        ddlData5.Items.Insert(0, "Select");

        ddlData6.DataSource = LoadValues;
        ddlData6.DataTextField = "Value";
        ddlData6.DataBind();
        ddlData6.Items.Insert(0, "Select");

        ddldata7.DataSource = LoadValues;
        ddldata7.DataTextField = "Value";
        ddldata7.DataBind();
        ddldata7.Items.Insert(0, "Select");
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
        xmlNode.InnerText = lblUom1.Text;
        xmlElement.AppendChild(xmlNode);

        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "GlucoseValue", "");
        xmlNode.InnerText = txtGlucose.Text + " " + lblGlucoseUOM.Text;
        xmlElement.AppendChild(xmlNode);

        xmlDoc.DocumentElement.AppendChild(xmlElement);

        //1st row
        if ((ddlMin1.SelectedItem.Text != "Mins"))
        {
            if ((txtBox.Text != string.Empty) || (ddlData1.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime1.SelectedItem.Text != "Hrs")
                {
                    //time = ddlTime1.SelectedItem.Text;

                    if (ddlMin1.SelectedItem.Text != "Mins")
                    {
                        //time += ":" + ddlMin1.SelectedItem.Text + " Min";
                        time += ddlMin1.SelectedItem.Text + " Mins";
                        //+ DropDownList1.SelectedItem.Text; ;
                    }
                    else
                    {
                        time += " " + DropDownList1.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "1";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = txtBox.Text != string.Empty ? txtBox.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData1.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData1.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                //Clinical Notes
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = lblFasting.Text;
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

            }
        }


        //0th row

        if ((ddlMin0.SelectedItem.Text != "Mins"))
        {
            if ((TextBox0.Text != string.Empty) || (ddlData0.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime2.SelectedItem.Text != "Hrs")
                {
                    //time = ddlTime2.SelectedItem.Text;

                    if (ddlMin0.SelectedItem.Text != "Mins")
                    {
                        time += ddlMin0.SelectedItem.Text + " Mins";
                        //time += ":" + ddlMin2.SelectedItem.Text + " Min";
                        //+DropDownList2.SelectedItem.Text;
                    }
                    else
                    {
                        time += " " + DropDownList0.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "0";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = TextBox0.Text != string.Empty ? TextBox0.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData2.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData0.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUOM0.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }

        //2st row

        if ((ddlMin2.SelectedItem.Text != "Mins"))
        {
            if ((TextBox1.Text != string.Empty) || (ddlData2.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime2.SelectedItem.Text != "Hrs")
                {
                    //time = ddlTime2.SelectedItem.Text;

                    if (ddlMin2.SelectedItem.Text != "Mins")
                    {
                        time += ddlMin2.SelectedItem.Text + " Mins";
                        //time += ":" + ddlMin2.SelectedItem.Text + " Min";
                        //+DropDownList2.SelectedItem.Text;
                    }
                    else
                    {
                        time += " " + DropDownList2.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "2";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = TextBox1.Text != string.Empty ? TextBox1.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData2.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData2.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }

        //3rd Row

        if ((ddlMin3.SelectedItem.Text != "Mins"))
        {
            if ((TextBox2.Text != string.Empty) || (ddlData3.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime3.SelectedItem.Text != "Hrs")
                {
                    //time = ddlTime3.SelectedItem.Text;

                    if (ddlMin3.SelectedItem.Text != "Mins")
                    {
                        time += ddlMin3.SelectedItem.Text + " Mins";
                        //time += ":" + ddlMin3.SelectedItem.Text + " Min";
                        //+DropDownList3.SelectedItem.Text;
                    }
                    else
                    {
                        time += " " + DropDownList3.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "3";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = TextBox2.Text != string.Empty ? TextBox2.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData3.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData3.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }

        //4th Row
        if ((ddlMin4.SelectedItem.Text != "Mins"))
        {
            if ((TextBox3.Text != string.Empty) || (ddlData4.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime4.SelectedItem.Text != "Hrs")
                {
                    // time = ddlTime4.SelectedItem.Text;

                    if (ddlMin4.SelectedItem.Text != "Mins")
                    {
                        //time += ":" + ddlMin4.SelectedItem.Text + " Min";
                        time += ddlMin4.SelectedItem.Text + " Mins";
                        //+DropDownList4.SelectedItem.Text;
                    }
                    else
                    {
                        time += " " + DropDownList4.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "4";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = TextBox3.Text != string.Empty ? TextBox3.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData4.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData4.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }
        //5th Row
        if ((ddlMin5.SelectedItem.Text != "Mins"))
        {
            if ((TextBox4.Text != string.Empty) || (ddlData5.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime5.SelectedItem.Text != "Hrs")
                {
                    // time = ddlTime5.SelectedItem.Text;

                    if (ddlMin5.SelectedItem.Text != "Mins")
                    {
                        //time += ":" + ddlMin5.SelectedItem.Text + " Min";
                        time += ddlMin5.SelectedItem.Text + " Mins";
                        //+DropDownList5.SelectedItem.Text;
                    }
                    else
                    {
                        time += " " + DropDownList5.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "5";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = TextBox4.Text != string.Empty ? TextBox4.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData5.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData5.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }


        //6th Row

        if ((ddlMin6.SelectedItem.Text != "Mins"))
        {
            if ((TextBox5.Text != string.Empty) || (ddlData6.SelectedItem.Text != "Select"))
            {
                string time = string.Empty;
                //if (ddlTime6.SelectedItem.Text != "Hrs")
                {
                    // time = ddlTime6.SelectedItem.Text;

                    if (ddlMin6.SelectedItem.Text != "Mins")
                    {
                        // time += ":" + ddlMin6.SelectedItem.Text + " Min";
                        time += ddlMin6.SelectedItem.Text + " Mins";
                        //+DropDownList6.SelectedItem.Text;
                    }
                    else
                    {
                        time += " " + DropDownList6.SelectedItem.Text;
                    }
                }
                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = "6";
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = time;
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = TextBox5.Text != string.Empty ? TextBox5.Text : "";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                if (ddlData6.SelectedItem.Text != "Select")
                {
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                    xmlNode.InnerText = ddlData6.SelectedItem.Text;
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);
            }
        }

        if (hdnGtt.Value == string.Empty)
        {
            //7th row
            if ((ddlMin7.SelectedItem.Text != "Mins"))
            {
                //if ((TextBox6.Text != string.Empty) || (ddldata7.SelectedItem.Text != "Select"))
                {
                    string time = string.Empty;
                    if (ddlTime7.SelectedItem.Text != "Hrs")
                    {
                        // time = ddlTime7.SelectedItem.Text;

                        if (ddlMin5.SelectedItem.Text != "Mins")
                        {
                            time += ddlMin7.SelectedItem.Text + " Mins";
                            // time += ":" + ddlMin7.SelectedItem.Text + " Min";
                            //+DropDownList7.SelectedItem.Text;
                        }
                        else
                        {
                            time += " " + DropDownList7.SelectedItem.Text;
                        }
                    }
                    xmlElement = xmlDoc.CreateElement("GttValue");
                    //microscopy node
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                    xmlNode.InnerText = "7";
                    xmlElement.AppendChild(xmlNode);

                    //reportstatus node
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                    xmlNode.InnerText = time;
                    xmlElement.AppendChild(xmlNode);

                    //culture report node
                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                    xmlNode.InnerText = TextBox6.Text != string.Empty ? TextBox6.Text : "";
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);

                    //Clinical Diagnosis
                    if (ddldata7.SelectedItem.Text != "Select")
                    {
                        xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                        xmlNode.InnerText = ddldata7.SelectedItem.Text;
                        xmlElement.AppendChild(xmlNode);
                        xmlDoc.DocumentElement.AppendChild(xmlElement);
                    }

                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                    xmlNode.InnerText = lblUom1.Text;
                    xmlElement.AppendChild(xmlNode);

                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                    xmlNode.InnerText = "N";
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);

                    xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                    xmlNode.InnerText = "PP";
                    xmlElement.AppendChild(xmlNode);
                    xmlDoc.DocumentElement.AppendChild(xmlElement);
                }
            }
        }
        //2~12:55 Am~3~+^

        string XtraRow = hdnGtt.Value;

        foreach (string Value in XtraRow.Split('^'))
        {
            if (Value != string.Empty)
            {
                string[] aar = new string[3];
                aar = Value.Split('~');

                int incSno = xmlDoc.GetElementsByTagName("GttValue").Count;

                xmlElement = xmlDoc.CreateElement("GttValue");
                //microscopy node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
                xmlNode.InnerText = Convert.ToString(incSno + 1);
                xmlElement.AppendChild(xmlNode);

                //reportstatus node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
                xmlNode.InnerText = Value.Split('~')[1];
                xmlElement.AppendChild(xmlNode);

                //culture report node
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
                xmlNode.InnerText = Value.Split('~')[2];
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                //Clinical Diagnosis
                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
                xmlNode.InnerText = Value.Split('~')[3];
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
                xmlNode.InnerText = lblUom1.Text;
                xmlElement.AppendChild(xmlNode);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
                xmlNode.InnerText = "N";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Type", "");
                xmlNode.InnerText = "PP";
                xmlElement.AppendChild(xmlNode);
                xmlDoc.DocumentElement.AppendChild(xmlElement);

            }
        }

        //string Refrange = "<RefRange><GttValue><SeqNo>1</SeqNo><Time></Time><Blood>1n</Blood></GttValue><GttValue><SeqNo>2</SeqNo><Time></Time><Blood>23n</Blood></GttValue></RefRange>";
        XmlDocument xmlRef = new XmlDocument();
        XmlDocument chk = new XmlDocument();
        chk.LoadXml(xmlDoc.InnerXml);
        //if (RefRange != string.Empty)
        //{
        //    xmlRef.LoadXml(RefRange);
        //    for (int i = 0; i < xmlRef.GetElementsByTagName("GttValue").Count; i++)
        //    {
        //        string RefRangeSeqNo = xmlRef.GetElementsByTagName("GttValue").Item(i).ChildNodes.Item(0).InnerText;
        //        for (int j = 0; j < chk.GetElementsByTagName("GttValue").Count; j++)
        //        {
        //            string SelectedSeqNo = chk.GetElementsByTagName("GttValue").Item(j).ChildNodes.Item(0).InnerText;
        //            if (RefRangeSeqNo == SelectedSeqNo)
        //            {
        //                xmlElement = xmlDoc.CreateElement("GttValue");
        //                //microscopy node
        //                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "SeqNo", "");
        //                xmlNode.InnerText = SelectedSeqNo;
        //                xmlElement.AppendChild(xmlNode);

        //                //reportstatus node
        //                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Time", "");
        //                xmlNode.InnerText = chk.GetElementsByTagName("GttValue").Item(j).ChildNodes.Item(1).InnerText;
        //                xmlElement.AppendChild(xmlNode);

        //                //culture report node
        //                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Blood", "");
        //                xmlNode.InnerText = xmlRef.GetElementsByTagName("GttValue").Item(i).ChildNodes.Item(2).InnerText;
        //                xmlElement.AppendChild(xmlNode);
        //                xmlDoc.DocumentElement.AppendChild(xmlElement);

        //                //Clinical Diagnosis
        //                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "Urine", "");
        //                xmlNode.InnerText = ddlData1.SelectedItem.Text;
        //                xmlElement.AppendChild(xmlNode);
        //                xmlDoc.DocumentElement.AppendChild(xmlElement);

        //                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "UomID", "");
        //                xmlNode.InnerText = lblUom1.Text;
        //                xmlElement.AppendChild(xmlNode);

        //                xmlNode = xmlDoc.CreateNode(XmlNodeType.Element, "DefaultValue", "");
        //                xmlNode.InnerText = "Y";
        //                xmlElement.AppendChild(xmlNode);
        //                xmlDoc.DocumentElement.AppendChild(xmlElement);
        //                break;

        //            }
        //        }
        //    }
        //}
        //xmlDoc.Save(@"d:\a.xml");
        return xmlDoc.InnerXml;
    }

    void LoadXML(string XMLString)
    {
        //<InvestigationResults><InvestigationDetails><InvestigationName>Gamma Glutamyl Transpeptidase (GGT) </InvestigationName><InvestigationID>4780</InvestigationID><UomID>mg/dl</UomID><GlucoseValue>10 gm</GlucoseValue></InvestigationDetails><GttValue><SeqNo>1</SeqNo><Time>1:00 Am</Time><Blood>1</Blood><Urine>+</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>Fasting</Type></GttValue>
        //<GttValue><SeqNo>2</SeqNo><Time>2:05 Am</Time><Blood>2</Blood><Urine>++</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>PP</Type></GttValue><GttValue><SeqNo>3</SeqNo><Time>3:10 Am</Time><Blood>3</Blood><Urine>+++</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>PP</Type></GttValue>
        //<GttValue><SeqNo>4</SeqNo><Time>4:15 Am</Time><Blood>4</Blood><Urine>++++</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>PP</Type></GttValue><GttValue><SeqNo>5</SeqNo><Time>5:20 Am</Time><Blood>5</Blood><Urine>+</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>PP</Type></GttValue><GttValue><SeqNo>6</SeqNo><Time>7:25 Am</Time><Blood>6</Blood><Urine>++</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>PP</Type></GttValue><GttValue><SeqNo>6</SeqNo><Time>8:30 Am</Time><Blood>7</Blood><Urine>+++</Urine><UomID>mg/dl</UomID><DefaultValue>N</DefaultValue><Type>PP</Type></GttValue><GttValue><SeqNo>1</SeqNo><Time>1:00 Am</Time><Blood>1n</Blood><Urine>+</Urine><UomID>mg/dl</UomID><DefaultValue>Y</DefaultValue></GttValue><GttValue><SeqNo>2</SeqNo><Time>2:05 Am</Time><Blood>23n</Blood><Urine>+</Urine><UomID>mg/dl</UomID><DefaultValue>Y</DefaultValue></GttValue></InvestigationResults>

        Loadtime();
        LoadMinutes();

        if (XMLString != string.Empty)
        {
            hdnFirstLoad.Value = "0";
        }


        XmlDocument EditDoc = new XmlDocument();
        EditDoc.LoadXml(XMLString);
        string glucose = EditDoc.GetElementsByTagName("GlucoseValue").Item(0).InnerText;
        txtGlucose.Text = glucose.Split()[0];
        string hidValueTest = string.Empty;
        //for(int i=0; i< EditDoc.GetElementsByTagName("GttValue").Count; i++)
        //{
        //    EditDoc.get
        //}
        int i = 8;
        foreach (XmlElement xmlNode in EditDoc.GetElementsByTagName("GttValue"))
        {
            if (xmlNode.ChildNodes[5].InnerText != "Y")
            {

                //string secs = xmlNode.ChildNodes[1].InnerText.Split(':')[1].Split()[0];
                //string time = xmlNode.ChildNodes[1].InnerText.Split(':')[0];
                //string session = xmlNode.ChildNodes[1].InnerText.Split(':')[1].Split()[1];
                string secs = xmlNode.ChildNodes[1].InnerText.Split(' ')[0];
                //string time = xmlNode.ChildNodes[1].InnerText.Split(':')[0];
                //string session = xmlNode.ChildNodes[1].InnerText.Split(':')[1].Split()[1];
                string bloodValue = xmlNode.ChildNodes[2].InnerText;
                string Urine = xmlNode.ChildNodes[3].InnerText;
                //string time = xmlNode.ChildNodes[1].InnerText;
                switch (xmlNode.ChildNodes[0].InnerText)
                {
                    case "0":
                        //ddlTime2.ClearSelection();
                        ddlMin0.ClearSelection();
                        //DropDownList2.ClearSelection();
                        ddlData0.ClearSelection();

                        //ddlTime2.Items.FindByText(time).Selected = true;
                        //ddlTime2.SelectedValue = time;
                        //ddlMin2.Items.FindByValue(secs).Selected = true;
                        ddlMin0.Items.FindByValue(secs).Selected = true;
                        //DropDownList2.Items.FindByText(session).Selected = true;
                        TextBox0.Text = bloodValue;
                        ddlData0.Items.FindByText(Urine).Selected = true;

                        break;
                    case "1":
                        //ddlTime1.ClearSelection();
                        ddlMin1.ClearSelection();
                        //DropDownList1.ClearSelection();
                        ddlData1.ClearSelection();

                        //ddlTime1.Items.FindByText(time).Selected = true;
                        ddlMin1.Items.FindByValue(secs).Selected = true;
                        //DropDownList1.Items.FindByText(session).Selected = true;
                        txtBox.Text = bloodValue;
                        ddlData1.Items.FindByText(Urine).Selected = true;
                        break;
                    case "2":
                        //ddlTime2.ClearSelection();
                        ddlMin2.ClearSelection();
                        //DropDownList2.ClearSelection();
                        ddlData2.ClearSelection();

                        //ddlTime2.Items.FindByText(time).Selected = true;
                        //ddlTime2.SelectedValue = time;
                        //ddlMin2.Items.FindByValue(secs).Selected = true;
                        ddlMin2.Items.FindByValue(secs).Selected = true;
                        //DropDownList2.Items.FindByText(session).Selected = true;
                        TextBox1.Text = bloodValue;
                        ddlData2.Items.FindByText(Urine).Selected = true;

                        break;
                    case "3":
                        //ddlTime3.ClearSelection();
                        ddlMin3.ClearSelection();
                        //DropDownList3.ClearSelection();
                        ddlData3.ClearSelection();

                        //ddlTime3.Items.FindByText(time).Selected = true;
                        ddlMin3.Items.FindByValue(secs).Selected = true;
                        //DropDownList3.Items.FindByText(session).Selected = true;

                        TextBox2.Text = bloodValue;
                        ddlData3.Items.FindByText(Urine).Selected = true;

                        break;
                    case "4":
                        //ddlTime4.ClearSelection();
                        ddlMin4.ClearSelection();
                        //DropDownList1.ClearSelection();
                        ddlData4.ClearSelection();
                        //ddlTime4.Items.FindByText(time).Selected = true;
                        ddlMin4.Items.FindByValue(secs).Selected = true;
                        //DropDownList4.Items.FindByText(session).Selected = true;

                        TextBox3.Text = bloodValue;
                        ddlData4.Items.FindByText(Urine).Selected = true;
                        break;
                    case "5":
                        //ddlTime5.ClearSelection();
                        ddlMin5.ClearSelection();
                        //DropDownList5.ClearSelection();
                        ddlData5.ClearSelection();
                        //ddlTime5.Items.FindByText(time).Selected = true;
                        ddlMin5.Items.FindByValue(secs).Selected = true;
                        //DropDownList5.Items.FindByText(session).Selected = true;

                        TextBox4.Text = bloodValue;
                        ddlData5.Items.FindByText(Urine).Selected = true;
                        break;
                    case "6":
                        //ddlTime6.ClearSelection();
                        ddlMin6.ClearSelection();
                        //DropDownList6.ClearSelection();
                        ddlData6.ClearSelection();
                        //ddlTime6.Items.FindByText(time).Selected = true;
                        ddlMin6.Items.FindByValue(secs).Selected = true;
                        //DropDownList6.Items.FindByText(session).Selected = true;

                        TextBox5.Text = bloodValue;
                        ddlData6.Items.FindByText(Urine).Selected = true;

                        break;
                    case "7":
                        //ddlTime7.ClearSelection();
                        ddlMin7.ClearSelection();
                        //DropDownList7.ClearSelection();
                        ddldata7.ClearSelection();
                        //ddlTime7.Items.FindByText(time).Selected = true;
                        ddlMin7.Items.FindByValue(secs).Selected = true;
                        //DropDownList7.Items.FindByText(session).Selected = true;
                        TextBox6.Text = bloodValue;
                        ddldata7.Items.FindByText(Urine).Selected = true;

                        break;

                    default:
                        i = i + 1;
                        //2~12:55 Am~3~+^
                        hidValueTest = i + "~" + xmlNode.ChildNodes[1].InnerText + "~" + xmlNode.ChildNodes[2].InnerText + "~" + xmlNode.ChildNodes[3].InnerText + "^";
                        break;
                }
            }
        }
        hdnGtt.Value = hidValueTest;
        string temp = "javascript:LoadOrdItems('" + tblResult.ClientID + "');";
        ScriptManager.RegisterStartupScript(this, typeof(Page), "Load", temp, true);

    }
    
    public bool IsEditPattern()
    {
        return Convert.ToBoolean(hdnReadonly.Value);
    }

    public void MakeReadOnly(string patterID)
    {
        ATag.Visible = true;
        hdnReadonly.Value = "true";

        txtRefRange.Attributes.Add("readOnly", "true");

        txtGlucose.Attributes.Add("readOnly", "true");
        txtBox.Attributes.Add("readOnly", "true");
        TextBox0.Attributes.Add("readOnly", "true");
        TextBox1.Attributes.Add("readOnly", "true");
        TextBox2.Attributes.Add("readOnly", "true");
        TextBox3.Attributes.Add("readOnly", "true");
        TextBox4.Attributes.Add("readOnly", "true");
        TextBox5.Attributes.Add("readOnly", "true");
        TextBox6.Attributes.Add("readOnly", "true");

        ddlTime0.Enabled = false;
        ddlTime0.Font.Bold = true;
        ddlTime1.Enabled = false;
        ddlTime1.Font.Bold = true;
        ddlTime2.Enabled = false;
        ddlTime2.Font.Bold = true;
        ddlTime3.Enabled = false;
        ddlTime3.Font.Bold = true;
        ddlTime4.Enabled = false;
        ddlTime4.Font.Bold = true;
        ddlTime5.Enabled = false;
        ddlTime5.Font.Bold = true;
        ddlTime6.Enabled = false;
        ddlTime6.Font.Bold = true;

        ddlMin0.Enabled = false;
        ddlMin0.Font.Bold = true;
        ddlMin1.Enabled = false;
        ddlMin1.Font.Bold = true;
        ddlMin2.Enabled = false;
        ddlMin2.Font.Bold = true;
        ddlMin3.Enabled = false;
        ddlMin3.Font.Bold = true;
        ddlMin4.Enabled = false;
        ddlMin4.Font.Bold = true;
        ddlMin5.Enabled = false;
        ddlMin5.Font.Bold = true;
        ddlMin6.Enabled = false;
        ddlMin6.Font.Bold = true;
        ddlMin7.Enabled = false;
        ddlMin7.Font.Bold = true;

        DropDownList0.Enabled = false;
        DropDownList0.Font.Bold = true;
        DropDownList1.Enabled = false;
        DropDownList1.Font.Bold = true;
        DropDownList2.Enabled = false;
        DropDownList2.Font.Bold = true;
        DropDownList3.Enabled = false;
        DropDownList3.Font.Bold = true;
        DropDownList4.Enabled = false;
        DropDownList4.Font.Bold = true;
        DropDownList5.Enabled = false;
        DropDownList5.Font.Bold = true;
        DropDownList6.Enabled = false;
        DropDownList6.Font.Bold = true;
        DropDownList7.Enabled = false;
        DropDownList7.Font.Bold = true;

        ddlData0.Enabled = false;
        ddlData0.Font.Bold = true;
        ddlData1.Enabled = false;
        ddlData1.Font.Bold = true;
        ddlData2.Enabled = false;
        ddlData2.Font.Bold = true;
        ddlData3.Enabled = false;
        ddlData3.Font.Bold = true;
        ddlData4.Enabled = false;
        ddlData4.Font.Bold = true;
        ddlData5.Enabled = false;
        ddlData5.Font.Bold = true;
        ddlData6.Enabled = false;
        ddlData6.Font.Bold = true;
        ddldata7.Enabled = false;
        ddldata7.Font.Bold = true;

        //ddlstatus.Enabled = false;
        ddlstatus.Font.Bold = true;
        //ddlStatusReason.Enabled = false;
        ddlStatusReason.Font.Bold = true;

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



    public void LoadMetaData()
    {
        string strSelect = Resources.Investigation_ClientDisplay.Investigation_FluidAnalysisCytologyPattern_ascx == null ? "--Select--" : Resources.Investigation_ClientDisplay.Investigation_FluidAnalysisCytologyPattern_ascx;

        try
        {
            long returncode = -1;
            string domains = "Pattern_ampm";
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
                                 where child.Domain == "Pattern_ampm"
                                 select child;
                DropDownList1.DataSource = childItems;
                DropDownList1.DataTextField = "DisplayText";
                DropDownList1.DataValueField = "Code";
                DropDownList1.DataBind();

                DropDownList0.DataSource = childItems;
                DropDownList0.DataTextField = "DisplayText";
                DropDownList0.DataValueField = "Code";
                DropDownList0.DataBind();

                DropDownList2.DataSource = childItems;
                DropDownList2.DataTextField = "DisplayText";
                DropDownList2.DataValueField = "Code";
                DropDownList2.DataBind();

                DropDownList3.DataSource = childItems;
                DropDownList3.DataTextField = "DisplayText";
                DropDownList3.DataValueField = "Code";
                DropDownList3.DataBind();

                DropDownList4.DataSource = childItems;
                DropDownList4.DataTextField = "DisplayText";
                DropDownList4.DataValueField = "Code";
                DropDownList4.DataBind();


                DropDownList5.DataSource = childItems;
                DropDownList5.DataTextField = "DisplayText";
                DropDownList5.DataValueField = "Code";
                DropDownList5.DataBind();


                DropDownList6.DataSource = childItems;
                DropDownList6.DataTextField = "DisplayText";
                DropDownList6.DataValueField = "Code";
                DropDownList6.DataBind();


                DropDownList7.DataSource = childItems;
                DropDownList7.DataTextField = "DisplayText";
                DropDownList7.DataValueField = "Code";
                DropDownList7.DataBind();


                

                


                


            }
            ddlStatusReason.Items.Insert(0, strSelect);
            ddlOpinionUser.Items.Insert(0, strSelect);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
            //edisp.Visible = true;
            // ErrorDisplay1.ShowError = true;
            // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
}
