using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Web.Services;
using System.Web.UI.HtmlControls;
using Attune.Kernel.PlatForm.Utility;
using System.IO;
using System.Drawing;
using System.Xml.Serialization;
using System.Xml;
using System.Text;

public partial class Waters_SampleScheduling : BasePage
{

    public Waters_SampleScheduling()
        : base("Waters_SampleScheduling_aspx")
    {
    }


    int startRowIndex = 1;
    int currentPageNo = 1;
    int _pageSize = 10;

    int totalRows = 0;
    int totalpage = 0;

    string Fromdate = string.Empty;
    string Todate = string.Empty;
    string QuotationNo = string.Empty;
    int ClientID = -1;
    int TestID = -1;
    string SampleType = string.Empty;
    int _SamColPerson = -1;
    string SampStatus = string.Empty;
    string WinAlert = Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10 == null ? "Alert" : Resources.Lab_AppMsg.Lab_BatchSheet_aspx_10;


    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }

    public int SamColPerson
    {
        get { return _SamColPerson; }
        set { _SamColPerson = value; }
    }



    protected void Page_Load(object sender, EventArgs e)
    {
       


        if (!IsPostBack)
        {
            hndLocationID.Value = ILocationID.ToString();
            pnlSampleTime.Visible = false;
            GrdResult.Visible = false;
            LoadMeatData();

            txtFrom.Text = OrgTimeZone;
            txtTo.Text = OrgTimeZone;
            Session["EditFlag1"] = null;
        }
        string gender = "M";
        string FeeType = "COM";
        AutoCompleteExtender3.ContextKey = FeeType + "~" + OrgID.ToString() + "~" + 0.ToString() + "~" + hndLocationID.Value.ToString() + "~" + gender;
        AutoCompleteExtenderClientName.ContextKey = OrgID.ToString();
        AutoCompletetxtQuotationNo.ContextKey = OrgID.ToString() + "~Qss_QNum";
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "TempDateandTime", "TempDateandTime();", true);
        AutoCompleteSampType.ContextKey = OrgID.ToString() + "~SampType";
        grdSampleSchedule.EditIndex = -1;
        //if (txtFrom.Text.Length == 0 && txtTo.Text.Length == 0)
        //{
        //    txtFrom.Text = DateTime.Now.ToString("dd/MM/yyyy");
        //    txtTo.Text = DateTime.Now.ToString("dd/MM/yyyy");
        //}
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Confirms that an HtmlForm control is rendered for the specified ASP.NET
           server control at run time. */
        return;
    }
    #region "Events"
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        SetCtlValuesForSearch();
        LoadSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus, currentPageNo);
        //  LoadSampleSchedule();
    }


    protected void grdSampleSchedule_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        grdSampleSchedule.EditIndex = -1;
        // LoadSampleSchedule();
        //   SetCtlValuesForSearch();


        Session["EditFlag1"] = null;
       
        if (hdnCurrent.Value == "")
        {
            hdnCurrent.Value = "1";
        }
        loadsampleschedulepage(Convert.ToInt32(lblCurrent.Text.ToString()), Convert.ToInt32(lblTotal.Text));
       
        //  LoadSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus, Convert.ToInt32(lblCurrent.Text.ToString()));
    }

    protected void grdSampleSchedule_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        long returnCode = -1;

        long QuotationID = 0;

        Session["EditFlag1"] = null;
        long RowID = Convert.ToInt64(((Label)grdSampleSchedule.Rows[e.RowIndex].FindControl("lblRowID")).Text.Trim());
        TextBox txtgrdSampleID = ((TextBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("txtSampleId"));

        
        String   OriginalSampID = ((Label)grdSampleSchedule.Rows[e.RowIndex].FindControl("lblOrnlSampID")).Text.ToString().Trim();



        Waters_BL objBL = new Waters_BL(base.ContextInfo);
        string SampleID = txtgrdSampleID.Text.ToString();
        DropDownList CollectionPerson = ((DropDownList)grdSampleSchedule.Rows[e.RowIndex].FindControl("drpSamColPerson"));
        if (SampleID.Length > 0 && CollectionPerson.SelectedIndex != 0)
        {
           int Isexist=0;
           objBL.pGetSampIDCheck(SampleID, out Isexist);
           CollectionPerson.CssClass = "";


           if (SampleID.Equals(OriginalSampID))
           {
               txtgrdSampleID.CssClass = "";

               string ScheduleTime = ((TextBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("txtScheduleTime")).Text.Trim();
               string TestingAddress = ""; //((TextBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("txtTestAddress")).Text.Trim();
               string txtSelectedPerson = ((DropDownList)grdSampleSchedule.Rows[e.RowIndex].FindControl("drpSamColPerson")).Text.Trim();
               string UpdateSampStatus = ((DropDownList)grdSampleSchedule.Rows[e.RowIndex].FindControl("drpSampStatus")).SelectedValue.ToString().Trim();
               CheckBox ChkBoxRows = (CheckBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("grdChkBox");
               ChkBoxRows.Checked = true;
               if (CheckForSampleGrdChange(grdSampleSchedule.Rows[e.RowIndex]) == 1)
               {
                   returnCode = objBL.UpdateSampleSchedule(RowID, SampleID, ScheduleTime, TestingAddress, Convert.ToInt64(txtSelectedPerson), UpdateSampStatus);
               }
               grdSampleSchedule.EditIndex = -1;

               if (hdnCurrent.Value == "")
               {
                   hdnCurrent.Value = "1";
               }
               loadsampleschedulepage(Convert.ToInt32(lblCurrent.Text.ToString()), Convert.ToInt32(lblTotal.Text));
           }

           else
           {

               if (Isexist == 0)
               {
                   txtgrdSampleID.CssClass = "";

                   string ScheduleTime = ((TextBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("txtScheduleTime")).Text.Trim();
                   string TestingAddress = ""; //((TextBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("txtTestAddress")).Text.Trim();
                   string txtSelectedPerson = ((DropDownList)grdSampleSchedule.Rows[e.RowIndex].FindControl("drpSamColPerson")).Text.Trim();
                   string UpdateSampStatus = ((DropDownList)grdSampleSchedule.Rows[e.RowIndex].FindControl("drpSampStatus")).SelectedValue.ToString().Trim();
                   CheckBox ChkBoxRows = (CheckBox)grdSampleSchedule.Rows[e.RowIndex].FindControl("grdChkBox");
                   ChkBoxRows.Checked = true;
                   if (CheckForSampleGrdChange(grdSampleSchedule.Rows[e.RowIndex]) == 1)
                   {
                       returnCode = objBL.UpdateSampleSchedule(RowID, SampleID, ScheduleTime, TestingAddress, Convert.ToInt64(txtSelectedPerson), UpdateSampStatus);
                       ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('Saved successfully.');", true);

                   }
                   grdSampleSchedule.EditIndex = -1;

                   if (hdnCurrent.Value == "")
                   {
                       hdnCurrent.Value = "1";
                   }
                   loadsampleschedulepage(Convert.ToInt32(lblCurrent.Text.ToString()), Convert.ToInt32(lblTotal.Text));
               }
               else
               {
                   txtgrdSampleID.CssClass = "Invalid";
                   ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('SampleID already exists');", true);
                   grdSampleSchedule.EditIndex = e.RowIndex;
                   
                   //alert("SampleID already exists");
               }

           }
        }
        else if (SampleID.Length <= 0)
        {

            txtgrdSampleID.CssClass = "Invalid";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Provide Sample Id');", true);
            grdSampleSchedule.EditIndex = e.RowIndex;

        }
        else
        {
            txtgrdSampleID.CssClass = "";
            CollectionPerson.CssClass = "Invalid";
            grdSampleSchedule.EditIndex = e.RowIndex;
        }
    }

    protected void grdSampleSchedule_RowEditing(object sender, GridViewEditEventArgs e)
    {
        grdSampleSchedule.EditIndex = e.NewEditIndex;
        int rowIndex = e.NewEditIndex;
        loadsampleschedulepage(Convert.ToInt32(lblCurrent.Text.ToString()), Convert.ToInt32(lblTotal.Text));
        TextBox txtgrdSampID = ((TextBox)grdSampleSchedule.Rows[rowIndex].FindControl("txtSampleId"));
        txtgrdSampID.Enabled = true;
        DropDownList CollectionPerson = ((DropDownList)grdSampleSchedule.Rows[rowIndex].FindControl("drpSamColPerson"));
        DropDownList ddlstatus = ((DropDownList)grdSampleSchedule.Rows[rowIndex].FindControl("drpSampStatus"));
        CollectionPerson.Attributes.Add("onchange", "changestatus('" + CollectionPerson.ClientID + "','" + ddlstatus.ClientID + "')");
        Session["EditFlag1"] = "1";



    }


    protected void grdSampleSchedule_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                TextBox txtgrdSampID = ((TextBox)e.Row.FindControl("txtSampleId"));

                txtgrdSampID.Attributes.Add("onkeypress", "SpecialCharRestriction(event); LimitTextValidation( this ,14); ");

                //txtgrdSampID.Enabled = false;

                DropDownList CollectionPerson = ((DropDownList)e.Row.FindControl("drpSamColPerson"));

                string AllotedCollector = ((Label)e.Row.FindControl("lblSampColPersonID")).Text;


                CollectionPerson.SelectedIndex = CollectionPerson.Items.IndexOf(CollectionPerson.Items.FindByValue(AllotedCollector));


                if (CollectionPerson.SelectedIndex == 0)
                {
                    CollectionPerson.Items.Insert(0, new ListItem("---Select---", "-1"));
                    CollectionPerson.SelectedIndex = 0;
                }

                DropDownList ddlSampStatus = ((DropDownList)e.Row.FindControl("drpSampStatus"));

                Label OriginalStatus = ((Label)e.Row.FindControl("lblSampStatus"));


                ddlSampStatus.SelectedIndex = ddlSampStatus.Items.IndexOf(ddlSampStatus.Items.FindByValue(OriginalStatus.Text));


                //if (ddlSampStatus.SelectedItem.Value == "Received" || ddlSampStatus.SelectedItem.Value == "Canceled")
                if (ddlSampStatus.SelectedItem.Value == "Canceled")
                {
                    ddlSampStatus.Enabled = false;
                }


                if (ddlSampStatus.SelectedItem.Value == "Assigned")
                {
                    ddlSampStatus.Items.Remove("Unassigned");
                }

                if (ddlSampStatus.SelectedItem.Value == "Unassigned")
                {
                    ddlSampStatus.Items.Remove("Received");
                }

                if (ddlSampStatus.SelectedItem.Value == "Received")
                {

                    ddlSampStatus.Items.Remove("Assigned");
                    ddlSampStatus.Items.Remove("Unassigned");
                    //ddlSampStatus.Items.Remove("Received");
                
                }




            }

        }
        catch (Exception Ex)
        {
            //report error
        }
    }


    protected void chkApplyAll_CheckedChanged(object sender, EventArgs e)
    {

        string SampColPersonID = hdnAssignCollPerson.Value.ToString();
        string CollectionDate = txtSampleSchTime.Text.ToString();
        string[] RowIDs = new string[] { };
        string CommonStatus = ddlCommonstatus.SelectedValue;


        if (SampColPersonID.Length > 0 || CollectionDate.Length > 0 || CommonStatus.Length > 0 )
        {
            foreach (GridViewRow row in grdSampleSchedule.Rows)
            {

                CheckBox ChkBoxRows = (CheckBox)row.FindControl("grdChkBox");
                if (ChkBoxRows.Checked == true)
                {

                    DropDownList CollectionPerson = ((DropDownList)row.FindControl("drpSamColPerson"));
                    TextBox grdCollectionTime = ((TextBox)row.FindControl("txtScheduleTime"));
                    DropDownList SampStatus = ((DropDownList)row.FindControl("drpSampStatus"));
                    if (CommonStatus == "Received")
                    {
                        if (SampStatus.SelectedValue == "Assigned")
                        {
                            SampStatus.SelectedValue = CommonStatus;
                        }
                    }

                    if (CommonStatus == "Assigned")
                    {
                        if (SampStatus.SelectedValue == "Unassigned")
                        {
                            SampStatus.SelectedValue = CommonStatus;
                            if (SampColPersonID.Length > 0)
                            {
                                CollectionPerson.SelectedIndex = CollectionPerson.Items.IndexOf(CollectionPerson.Items.FindByValue(SampColPersonID));
                            }
                            
                        }
                    }

                    if (CommonStatus == "Canceled")
                    {
                        SampStatus.SelectedValue = CommonStatus;

                    }
                    // SampStatus.SelectedValue = CommonStatus;

                    if (CollectionDate.Length > 3 && CommonStatus !="Received")
                    {
                        grdCollectionTime.Text = CollectionDate;
                    }

                   

                }
            }
        }




        chkApplyAll.Checked = false;
        hdnAssignCollPerson.Value = "";
        txtSampleSchTime.Text = "";
        ddlCommonstatus.SelectedValue = "-1";
        txtSampleColPerson.Text = "";
        Session["EditFlag1"] = "0";

    }



    protected void chkboxSelectAll_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox ChkBoxHeader = (CheckBox)grdSampleSchedule.HeaderRow.FindControl("chkSelectAll");
        foreach (GridViewRow row in grdSampleSchedule.Rows)
        {
            CheckBox ChkBoxRows = (CheckBox)row.FindControl("grdChkBox");
            if (ChkBoxHeader.Checked == true)
            {
                ChkBoxRows.Checked = true;
            }
            else
            {
                ChkBoxRows.Checked = false;
            }
        }
    }


    #endregion


    #region "Methods"


    private void SetCtlValuesForSearch()
    {
        Fromdate = txtFrom.Text.ToString();
        Todate = txtTo.Text.ToString();
        QuotationNo = txtQuotationNo.Text.ToString();
        ClientID = Convert.ToInt32(hdnClientId.Value);
        TestID = Convert.ToInt32(hdnSelectedTestID.Value.ToString()); ;
        SampleType = txtSampleType.Text.ToString();
        SamColPerson = Convert.ToInt32(hdnSampleColPersonValSearch.Value);
        SampStatus = drpStatus.SelectedValue.ToString();



        if (txtTestName.Text.ToString().Length > 0)
            TestID = Convert.ToInt32(hdnSelectedTestID.Value.ToString());
        else
            TestID = -1;


        if (txtSampleType.Text.ToString().Length > 0)
            SampleType = txtSampleType.Text.ToString();
        else
            SampleType = "-1";


        //if (lblCurrent.Text.ToString().Length > 0)
        //    currentPageNo = Convert.ToInt32(lblCurrent.Text.ToString());
        //else
        //    currentPageNo = 1;

        if (txtQuotationNo.Text.ToString().Length > 0)
            QuotationNo = txtQuotationNo.Text.ToString();
        else
            QuotationNo = "-1";


        if (txtClientName.Text.ToString().Length > 0)
            ClientID = Convert.ToInt32(hdnClientId.Value.ToString());
        else
            ClientID = -1;






        // startRowIndex = 1;
        //   hdnCurrent.Value = startRowIndex.ToString();
        //   LoadGrid(e, startRowIndex, PageSize);
        // lblCurrent.Text = currentPageNo.ToString();
    }


    public List<MetaData> GetSampleStatus()
    {
        long returncode = -1;
        string domains = "WaterSampleStatus";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();
        try
        {

            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }


        return lstmetadataOutput;

    }


    public void LoadMeatData()
    {
        try
        {
            long returncode = -1;
            string domains = "WaterSampleStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();
            MetaData objMeta;
            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);
            }
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "WaterSampleStatus"
                                 select child;
                if (childItems.Count() > 0)
                {
                    drpStatus.DataSource = childItems;
                    drpStatus.DataTextField = "DisplayText";
                    drpStatus.DataValueField = "Code";
                    drpStatus.DataBind();
                    drpStatus.Items.Insert(0, "ALL");
                    drpStatus.Items[0].Value = "-1";
                }

            }

            var childItems1 = from child in lstmetadataOutput
                              where child.Domain == "WaterSampleStatus" && child.Code != "Unassigned" 
                              select child;

            if (childItems1.Count() > 0)
            {

                ddlCommonstatus.DataSource = childItems1;
                ddlCommonstatus.DataTextField = "DisplayText";
                ddlCommonstatus.DataValueField = "Code";
                ddlCommonstatus.DataBind();
                ddlCommonstatus.Items.Insert(0, "--Select--");
                ddlCommonstatus.Items[0].Value = "-1";
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading LoadMeatData() in Test Master", ex);
        }
    }


    public List<Users> GetSampleCollectors()
    {
        List<Users> lstSampleCollectors = new List<Users>();
        long returnCode = -1;


        Waters_BL ObjBL = new Waters_BL(base.ContextInfo);

        //

        if (hdnCollectionPerson.Value.Length < 1)
        {



            //   Waters_BL ObjBL = new Waters_BL(base.ContextInfo);


            returnCode = ObjBL.GetSampleCollectors("ALL", 1, out lstSampleCollectors);

            if (lstSampleCollectors.Count > 0)
            {
                hdnCollectionPerson.Value = "";
                XmlSerializer ser = new XmlSerializer(lstSampleCollectors.GetType());
                StringBuilder sb = new StringBuilder();
                System.IO.StringWriter writer = new System.IO.StringWriter(sb);
                ser.Serialize(writer, lstSampleCollectors); 	// Here Classes are converted to XML String. 
                // This can be viewed in SB or writer.
                // Above XML in SB can be loaded in XmlDocument object
                XmlDocument doc = new XmlDocument();
                hdnCollectionPerson.Value = sb.ToString();

                //hdnCollectionPerson.Value = lstSampleCollectors.ToArray().ToString();


            }



        }
        else
        {
            //  lstSampleCollectors =List<Users> hdnCollectionPerson.Value.ToString();


            XmlSerializer serializer = new XmlSerializer(typeof(List<Users>), new XmlRootAttribute("Users"));
            StringReader stringReader = new StringReader(hdnCollectionPerson.Value.ToString());

            //  List<Users> CollectorList = (List<Users>)serializer.Deserialize(stringReader);

            Users Cat = new Users();
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(hdnCollectionPerson.Value.ToString());
            XmlNodeReader reader = new XmlNodeReader(doc.DocumentElement);

            var list = doc.DocumentElement.SelectNodes("Users");
            //Root.Elements("id")
            //               .Select(element => element.Value)
            //               .ToList();
          //  XmlNodeList List = doc.SelectNodes("Users");
           
            foreach (XmlNode value in list)
            {
                Users LocObj = new Users();

                LocObj.Name =(string) value.SelectSingleNode("Name").InnerText;
                LocObj.UserID = Convert.ToInt32(value.SelectSingleNode("UserID").InnerText);
                lstSampleCollectors.Add(LocObj);
            }

           // XmlSerializer ser = new XmlSerializer(Cat.GetType());
           // object obj = (Users)ser.Deserialize(reader);
            //// Then you just need to cast obj into whatever type it is, e.g.:
            //Category myObj = (Category)obj;
            // Now Ser
        }


//




     //   returnCode = ObjBL.GetSampleCollectors("ALL", 1, out lstSampleCollectors);



        return lstSampleCollectors;
    }



    private int CalculateTotalPages(double totalRows)
    {

        int totalPages = (int)Math.Ceiling(totalRows / PageSize);

        return totalPages;
    }

    protected void Btn_Previous_Click(object sender, EventArgs e)
    {



        //hdnCurrent.Value = "";
        //lblCurrent.Text = "2";
        if (Session["EditFlag1"] != "1")
        {
            if (hdnCurrent.Value != "")
            {
                currentPageNo = Int32.Parse(hdnCurrent.Value) - 1;
                hdnCurrent.Value = currentPageNo.ToString();
            }
            else
            {
                currentPageNo = Int32.Parse(lblCurrent.Text) - 1;
                hdnCurrent.Value = currentPageNo.ToString();
            }

        loadsampleschedulepage(currentPageNo, PageSize);
        txtpageNo.Text = "";
        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Kindly update or cancel for the above edited values');", true);
        }
    }
    protected void Btn_Next_Click(object sender, EventArgs e)
    {


        if (Session["EditFlag1"] != "1")
        {

        if (hdnCurrent.Value != "")
        {

            currentPageNo = Int32.Parse(hdnCurrent.Value) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }
        else
        {
            currentPageNo = Int32.Parse(lblCurrent.Text) + 1;
            hdnCurrent.Value = currentPageNo.ToString();
        }


        loadsampleschedulepage(currentPageNo, PageSize);

        txtpageNo.Text = "";

        }
        else
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Kindly update or cancel for the above edited values');", true);
        }


    }
    protected void btnGo_Click(object sender, EventArgs e)
    {
        if (Session["EditFlag1"] != "1")
        {
        hdnCurrent.Value = txtpageNo.Text;
        int PageGO = Convert.ToInt32(txtpageNo.Text.ToString());
        currentPageNo = PageGO;


        if (PageGO >= 1)
        {
            loadsampleschedulepage(PageGO, PageSize);
            if (PageGO > Convert.ToInt32(lblTotal.Text))
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "ALt", "javascript:alert('Enter Correct Page Number');", true);
            }
        }

        
else
        {

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Kindly update or cancel for the above edited values');", true);
        }
            txtpageNo.Text = "";


    }
    }

    private void LoadSampleSchedule(string Fromdate, string Todate, string QuotationNo, int ClientName, int TestID, string SampleType, int SamColPerson, string SampStatus, int currentPageNo)
    {

        long returnCode = -1;
        txtpageNo.Text = "";
        hdnCurrent.Value = "";
        currentPageNo = 1;


        Waters_BL ObjBL = new Waters_BL(base.ContextInfo);
        List<SampleSchedule> lstOSampleSchedule = new List<SampleSchedule>();
        returnCode = ObjBL.GetSampleSchedule(Fromdate, Todate, QuotationNo, ClientName, TestID, SampleType, SamColPerson, SampStatus, OrgID, currentPageNo, PageSize, out totalRows, out lstOSampleSchedule);

        if (lstOSampleSchedule.Count == 0)
        {
            pnlSampleTime.Visible = false;
            GrdResult.Visible = true;

        }
        else
        {
            pnlSampleTime.Visible = true;
            GrdResult.Visible = false;
        }
        if (lstOSampleSchedule.Count > 0)
        {
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();

            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }

            if (currentPageNo == 1)
            {
                Btn_Previous.Enabled = false;

                if (int.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;

            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }
            var lstSampleSchedule = lstOSampleSchedule.OrderBy(s => s.QuotationID);
            grdSampleSchedule.DataSource = lstSampleSchedule;
            grdSampleSchedule.DataBind();
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();


        }




    }

    public void loadsampleschedulepage(int currentpageno, int pagesize)
    {
        SetCtlValuesForSearch();
        long returnCode = -1;
        //returnCode = new PatientVisit_BL(base.ContextInfo).GetPatientVisit(patientID,0, OrgID,Convert.ToInt32(pVisitType), out lstPatientVisit, out pPatientName, out pPatientNo);

        int VisitID = 0;
        Waters_BL ObjBL = new Waters_BL(base.ContextInfo);
        List<SampleSchedule> lstOSampleSchedule = new List<SampleSchedule>();
        returnCode = ObjBL.GetSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus, OrgID, currentpageno, PageSize, out totalRows, out lstOSampleSchedule);


        if (lstOSampleSchedule.Count > 0)
        {
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();

            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentpageno = Convert.ToInt32(hdnCurrent.Value);
            }

            if (currentpageno == 1)
            {
                Btn_Previous.Enabled = false;

                if (int.Parse(lblTotal.Text) > 1)
                {
                    Btn_Next.Enabled = true;
                }
                else
                    Btn_Next.Enabled = false;

            }

            else
            {
                Btn_Previous.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    Btn_Next.Enabled = false;
                else Btn_Next.Enabled = true;
            }


            //dcapture.visible = true;
            //dcaption.visible = true;
            var lstSampleSchedule = lstOSampleSchedule.OrderBy(s => s.QuotationID);
            grdSampleSchedule.DataSource = lstSampleSchedule;
            grdSampleSchedule.DataBind();
            //if (reportdate == "y")
            //{
            //    gridview1.columns[5].visible = true;
            //}

        }

    }



    public void UpdateSampleColPerson(string[] SelectedCheckBox, string CollectionPerson)
    {


        //AssignCollPerson

    }

    public void loadgridtoexcel()
    {
        try
        {
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            List<ClientMaster> lstinvmasters = new List<ClientMaster>();
            lstinvmasters.Clear();
            long returncode = -1;
            Waters_BL ObjBL = new Waters_BL(base.ContextInfo);
            //uy t  btnFinish.Text = UpdateButton;
            // long ClientID = 0;
            //ClientID = clientid;
            List<SampleSchedule> lstOSampleSchedule = new List<SampleSchedule>();
            returncode = ObjBL.GetSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus, OrgID, currentPageNo, PageSize, out totalRows, out lstOSampleSchedule);
            //     returncode = masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);
            if (lstOSampleSchedule.Count > 0)
            {
                //DataTable table = ConvertListToDataTable(lstinvmasters);
                grdSampleSchedule.DataSource = lstOSampleSchedule;
                grdSampleSchedule.AllowPaging = false;
                grdSampleSchedule.DataBind();
                ExportToExcel();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Exporting Excel", ex);
        }

    }
    public void ExportToExcel()
    {

        try
        {

            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(OrgDateTimeZone);
            string attachment = "attachment; filename=" + "ClientMaster" + dt + ".xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.ContentType = "application/ms-excel";
            Response.Charset = "";
            this.EnableViewState = false;
            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter oHtmlTextWriter = new System.Web.UI.HtmlTextWriter(oStringWriter);
            grdSampleSchedule.Visible = true;
            grdSampleSchedule.RenderControl(oHtmlTextWriter);
            Response.Write(oStringWriter.ToString());
            Response.Output.Write(oStringWriter.ToString());
            Response.Flush();
            Response.End();


        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Exporting Excel", ioe);
        }

    }

    #endregion



    protected void btngrdSave_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        long RowID = -1;
        string SampleID = "";
        string ScheduleTime = "";
        string TestingAddress = "";
        string strCollectionPerson = "";
        string SampleStatus = "";
        int Isexist = 0;
        string Dummy = Session["EditFlag1"].ToString();

        List<SampleSchedule> UpdateList = new List<SampleSchedule>();
        Waters_BL objBL = new Waters_BL(base.ContextInfo);
        if (Session["EditFlag1"] != "1")
        {
            foreach (GridViewRow grdRows in grdSampleSchedule.Rows)
            {
                SampleSchedule SampleScheduleEntity = new SampleSchedule();
                RowID = Convert.ToInt64(((Label)grdRows.FindControl("lblRowID")).Text.Trim());
                CheckBox ChkBoxRows = (CheckBox)grdRows.FindControl("grdChkBox");
                TextBox txtgrdSampID = ((TextBox)grdRows.FindControl("txtSampleId"));
                if (ChkBoxRows.Checked == true)
                {
                    if (RowID != -1)
                    {

                        


                    SampleID = txtgrdSampID.Text.Trim();


                    // CollectionPerson = ((DropDownList)grdRows.FindControl("drpSamColPerson")).Text.Trim();

                    DropDownList CollectionPerson = (DropDownList)grdRows.FindControl(("drpSamColPerson"));
                    DropDownList Status = (DropDownList)grdRows.FindControl(("drpSampStatus"));
                    txtgrdSampID.CssClass = "";
                    CollectionPerson.CssClass = "";
                    if (SampleID.Length > 0 && CollectionPerson.SelectedIndex != 0)
                    {
                        CollectionPerson.CssClass = "";
                        if (Status.SelectedValue == "Assigned")
                        {

                            objBL.pGetSampIDCheck(SampleID, out Isexist);
                        }
                        else {
                            Isexist = 0;
                        
                        }

                        if (Isexist == 0)
                        {
                            txtgrdSampID.CssClass = "";


                            ScheduleTime = ((TextBox)grdRows.FindControl("txtScheduleTime")).Text.Trim();
                            //  TestingAddress = ((TextBox)grdRows.FindControl("txtTestAddress")).Text.Trim();
                            strCollectionPerson = CollectionPerson.Text.Trim();
                            SampleStatus = ((DropDownList)grdRows.FindControl("drpSampStatus")).Text.Trim();

                            SampleScheduleEntity.RowID = RowID;
                            SampleScheduleEntity.SampleID = SampleID;
                            SampleScheduleEntity.ScheduledTime = Convert.ToDateTime(ScheduleTime);
                            SampleScheduleEntity.Status = SampleStatus;
                            SampleScheduleEntity.CollectedBy = Convert.ToInt32(CollectionPerson.SelectedValue);
                            CollectionPerson.CssClass.Replace("Invalid", "");
                            txtgrdSampID.CssClass.Replace("Invalid", "");

                            if (CheckForSampleGrdChange(grdRows) == 1)
                            {

                                UpdateList.Add(SampleScheduleEntity);
                            }
                        }
                        else
                        {
                            txtgrdSampID.CssClass = "Invalid";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Enter Sample ID','" + WinAlert + "');", true);
                        }
                    }
                    else if (SampleID.Length <= 0)
                    {

                            txtgrdSampID.CssClass = "Invalid";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Enter Sample ID','" + WinAlert + "');", true);
                        }
                        else
                        {
                            txtgrdSampID.CssClass = "";
                            CollectionPerson.CssClass = "Invalid";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Alert", "javascript:ValidationWindow('Enter Collection Person','" + WinAlert + "');", true);
                        }
                    }
                }
                else
                {
                    txtgrdSampID.CssClass = "";
                }


        }

        if (UpdateList.Count > 0)
        {
            

                returnCode = objBL.UpdateSampleSchedule_Bulk(UpdateList);
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('Saved successfully.');", true);
                //  loadsampleschedulepage(Convert.ToInt32(hdnCurrent.Value), Convert.ToInt32(lblTotal.Text));
                //  LoadSampleSchedule();
                loadsampleschedulepage(Convert.ToInt32(lblCurrent.Text.ToString()), Convert.ToInt32(lblTotal.Text));
            }
            
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "javascript:alert('Kindly update or cancel for the above edited values');", true);
        }

    }







    protected void btnConverttoXL_Click(object sender, ImageClickEventArgs e)
    {
        ExportToExcel_1();
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {
        txtFrom.Text = "";
        txtTo.Text = "";
        txtQuotationNo.Text = "";
        txtClientName.Text = "";
        hdnSelectedTestID.Value = "-1"; ;
        hdnClientId.Value = "-1";
        txtSampleType.Text = "";
        hdnSampleColPersonValSearch.Value = "-1";
        drpStatus.SelectedIndex = 0;
        hdnSelectedTestID.Value = "-1";
        txtSampleType.Text = "";
        txtSamColPerson.Text = "";
        txtTestName.Text = "";



    }




    protected void ExportToExcel_1()
    {




        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=SampleSchedule_" + DateTime.Now.ToString("dd-MM-yyyy HH-mm") + "_.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";


        Master_BL masterbl = new Master_BL(base.ContextInfo);
        List<ClientMaster> lstinvmasters = new List<ClientMaster>();
        lstinvmasters.Clear();
        long returncode = -1;
        Waters_BL ObjBL = new Waters_BL(base.ContextInfo);
        //uy t  btnFinish.Text = UpdateButton;
        // long ClientID = 0;
        //ClientID = clientid;
        List<SampleSchedule> lstOSampleSchedule = new List<SampleSchedule>();
        SetCtlValuesForSearch();
        //  returncode = ObjBL.GetSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus,OrgID, currentPageNo, PageSize, out totalRows, out lstOSampleSchedule);


        returncode = ObjBL.GetSampleSchedule(Fromdate, Todate, QuotationNo, ClientID, TestID, SampleType, SamColPerson, SampStatus, OrgID, currentPageNo, -1, out totalRows, out lstOSampleSchedule);
        //     returncode = masterbl.GetInvoiceClientDetails(OrgID, ILocationID, txtClientNameSrch.Text, txtClientCodeSrch.Text, ClientID, out lstinvmasters);
        if (lstOSampleSchedule.Count > 0)
        {
            //DataTable table = ConvertListToDataTable(lstinvmasters);
            grdSampleSchedule.DataSource = lstOSampleSchedule;
            grdSampleSchedule.AllowPaging = false;
            grdSampleSchedule.DataBind();
            grdSampleSchedule.Columns[0].Visible = false;
            grdSampleSchedule.Columns[13].Visible = false;
            grdSampleSchedule.Columns[14].Visible = false;
        }


        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);

            //To Export all pages
            grdSampleSchedule.AllowPaging = false;
            //   this.BindGrid();

            grdSampleSchedule.HeaderRow.BackColor = Color.White;

            //TableCell cell;

            for (int i = 0; i < grdSampleSchedule.Columns.Count ; i++)
            {
                GridViewRow row = grdSampleSchedule.Rows[i];
                //row.Cells[13].BackColor = grdSampleSchedule.HeaderStyle.BackColor;
                grdSampleSchedule.HeaderRow.Cells[13].Visible = false;
                grdSampleSchedule.HeaderRow.Cells[14].Visible = false;

            }

            foreach (TableCell cell in grdSampleSchedule.HeaderRow.Cells)
            {
                cell.BackColor = grdSampleSchedule.HeaderStyle.BackColor;
            }
            foreach (GridViewRow row in grdSampleSchedule.Rows)
            {
                row.BackColor = Color.White;
                foreach (TableCell cell in row.Cells)
                {
                    if (row.RowIndex % 2 == 0)
                    {
                        cell.BackColor = grdSampleSchedule.AlternatingRowStyle.BackColor;
                        row.Cells[14].Visible = false;
                        row.Cells[12].Visible = false;
                    }
                    else
                    {
                        cell.BackColor = grdSampleSchedule.RowStyle.BackColor;
                        row.Cells[13].Visible = false;
                    }
                    cell.CssClass = "textmode";
                    List<Control> controls = new List<Control>();

                    //Add controls to be removed to Generic List
                    foreach (Control control in cell.Controls)
                    {
                        controls.Add(control);
                    }

                    //Loop through the controls to be removed and replace then with Literal
                    foreach (Control control in controls)
                    {
                        switch (control.GetType().Name)
                        {
                            case "HyperLink":
                                cell.Controls.Add(new Literal { Text = (control as HyperLink).Text });
                                break;
                            case "TextBox":
                                cell.Controls.Add(new Literal { Text = (control as TextBox).Text });
                                break;
                            case "LinkButton":
                                cell.Controls.Add(new Literal { Text = (control as LinkButton).Text });
                                break;
                            case "CheckBox":
                                cell.Controls.Add(new Literal { Text = (control as CheckBox).Text });
                                break;
                            case "RadioButton":
                                cell.Controls.Add(new Literal { Text = (control as RadioButton).Text });
                                break;
                            case "Label":
                                if ((control.ID.ToString() == "lblFieldTest") || (control.ID.ToString() == "lblTestAddress"))
                                    cell.Controls.Add(new Literal { Text = (control as Label).Text });
                                break;


                            case "DropDownList":
                                if ((control as DropDownList).SelectedItem.Value != "-1")
                                    cell.Controls.Add(new Literal { Text = (control as DropDownList).SelectedItem.Text });
                                break;
                        }
                        cell.Controls.Remove(control);
                    }
                }
            }

            grdSampleSchedule.RenderControl(hw);

            //style to format numbers to string
            string style = @"<style> .textmode { } </style>";
            Response.Write(style);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }



    private int CheckForSampleGrdChange(GridViewRow grdRows)
    {

        long returnCode = -1;
        long RowID = -1;
        string SampleID = "";
        string ScheduleTime = "";
        string TestingAddress = "";
        string strCollectionPerson = "";
        string SampleStatus = "";


        SampleSchedule SampleScheduleEntity = new SampleSchedule();
        RowID = Convert.ToInt64(((Label)grdRows.FindControl("lblRowID")).Text.Trim());
        CheckBox ChkBoxRows = (CheckBox)grdRows.FindControl("grdChkBox");
        if (ChkBoxRows.Checked == true)
        {
            if (RowID != -1)
            {
                TextBox txtgrdSampID = ((TextBox)grdRows.FindControl("txtSampleId"));
                Label txtOrgSampID = ((Label)grdRows.FindControl("lblOrnlSampID"));
                SampleID = txtgrdSampID.Text.Trim();
                TextBox txtgrdShcTime = ((TextBox)grdRows.FindControl("txtScheduleTime"));
                Label lblgrdShcTime = ((Label)grdRows.FindControl("lblOrnlSTime"));
                DropDownList CollectionPerson = (DropDownList)grdRows.FindControl(("drpSamColPerson"));
                Label lblOrgColPerson = ((Label)grdRows.FindControl("lblSampColPersonID"));
                SampleStatus = ((DropDownList)grdRows.FindControl("drpSampStatus")).Text.Trim();
                Label lblorgStatus = ((Label)grdRows.FindControl("lblSampStatus"));


                if ((txtgrdSampID.Text != txtOrgSampID.Text) || (txtgrdShcTime.Text != lblgrdShcTime.Text) || (CollectionPerson.SelectedValue != lblOrgColPerson.Text) ||
                    (SampleStatus != lblorgStatus.Text))
                    return 1;


            }
        }





        return 0;
    }

    protected void btngrdClear_Click(object sender, EventArgs e)
    {
        try {

            grdSampleSchedule.DataSource = null;
            grdSampleSchedule.DataBind();
            pnlSampleTime.Visible = false;
            txtFrom.Text = OrgTimeZone;
            txtTo.Text = OrgTimeZone;
            drpStatus.SelectedValue = "-1";

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while btngrdSave_Click In Sample Scheduling", ex);
        
        }





    }
}
