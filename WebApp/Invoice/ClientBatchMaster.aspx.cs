using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.TrustedOrg;
using System.IO;
using System.Data;
using System.Xml;
using System.Xml.Xsl;
using System.Collections;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using PdfSharp;
using PdfSharp.Pdf;
using PdfSharp.Drawing;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using iTextSharp.tool.xml;
using iTextSharp.tool.xml.html;
using iTextSharp.tool.xml.parser;
using iTextSharp.tool.xml.css;
using iTextSharp.tool.xml.pipeline.html;
using iTextSharp.tool.xml.pipeline.css;
using iTextSharp.tool.xml.pipeline.end;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.Text;

public partial class Invoice_ClientBatchMaster : BasePage
{
    int PatientVisitId = 0;
    int startRowIndex = 1;
    int currentPageNo = 1;
    int _pageSize = 10;
    int totalRows = 0;
    int totalpage = 0;
    public int PageSize
    {
        get { return _pageSize; }
        set { _pageSize = value; }
    }
    long PID = -1;
    long returnCode = -1;
    long patientID = -1;
    long visitID = 0;
    string vType = string.Empty;
    long pvisitID = 0;
    string pPatientName = string.Empty;
    string pPatientNo = string.Empty;
    int OP, IP;
    string pVisitType = string.Empty;
    long FinalbillId = 0;
    string BillNumber = string.Empty;
    string Visitno = string.Empty;
    string Gen = string.Empty;
    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
    List<ActionMaster> lstActionMaster = new List<ActionMaster>();
    List<PatientVisit> lsttotalPatientCount = new List<PatientVisit>();
    List<OutsourcingDetail> lstOutsourcingDetail = new List<OutsourcingDetail>();
    List<TRFfilemanager> lstTRFFilemanager = new List<TRFfilemanager>();
    string pathname = string.Empty;
    string ExternalVisitSearch = string.Empty;
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    public Invoice_ClientBatchMaster()
        : base("Invoice_ClientBatchMaster_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    [STAThread]
    protected void Page_Load(object sender, EventArgs e)
    {

        //FileUpload1.Attributes["onchange"] = "UploadFile(this)";
        

        if (!Page.IsPostBack)
        {
            
            hdnOrgID.Value = OrgID.ToString();
            AutoCompleteExtenderClientCorp.ContextKey = "CLI";
            AutoCompleteExtender1.ContextKey = "CLI";
            AutoCompleteExtender10.ContextKey = "-2";
            AutoCompleteExtender3.ContextKey = "Tem~0~~~~";
            
          //  AutoCompleteExtender3.ContextKey = OrgID.ToString();
           // LoadTestname();
            LoadMetaData();
            long ClientID = -1;
            string LoginRoleName = string.Empty;
            LoginRoleName = RoleName;
            hdnloginRoleName.Value = LoginRoleName;
            if (LoginRoleName == "Client")
              {
                LoadClientRole();
                Int64.TryParse(Session["CID"].ToString(), out ClientID);
                   if (CID > 0)
                       {
                         LoadDefaultClientNameBasedOnOrgLocation();
                       }
             }
            
        }
        
    }

    private void LoadMetaData()
    {
        try
        {
            long returncode = -1;
            string domains = "WellnessReportStatus";
            string[] Tempdata = domains.Split(',');
            string LangCode = "en-GB";
            // string LangCode = string.Empty;
            List<MetaData> lstmetadataInput = new List<MetaData>();
            List<MetaData> lstmetadataOutput = new List<MetaData>();

            MetaData objMeta;

            for (int i = 0; i < Tempdata.Length; i++)
            {
                objMeta = new MetaData();
                objMeta.Domain = Tempdata[i];
                lstmetadataInput.Add(objMeta);

            }

            //returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
            returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

            if (lstmetadataOutput.Count > 0)
            {
                var childItems = from child in lstmetadataOutput
                                 where child.Domain == "WellnessReportStatus" //orderby child .MetaDataID
                                 select child;
                ddlstatusbatch.DataSource = childItems;
                ddlstatusbatch.DataTextField = "DisplayText";
                ddlstatusbatch.DataValueField = "Code";
                ddlstatusbatch.DataBind();
                ddlstatusbatch.Items.Insert(0, "-----Select-----");
                ddlstatusbatch.Items[0].Value = "0";
            }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while  loading Search Type  Meta Data ", ex);

        }
    }
    public void LoadClientRole()
    {
        try
        {

            pnlCommercials.Style.Add("display", "none");
            

        }
        catch (Exception ex)
        {

        }
    }
    public void LoadDefaultClientNameBasedOnOrgLocation()
    {

        long lresutl = -1;
        BillingEngine BillingBl = new BillingEngine(new BaseClass().ContextInfo);
        List<InvClientMaster> lstClientNames = new List<InvClientMaster>();
        string prefixText = string.Empty;
        string pType = string.Empty;
        long refhospid = -1;
        long CID = -1;
        Int64.TryParse(Session["CID"].ToString(), out CID);
        if (CID > 0)
        {
            pType = "CLP";
            refhospid = CID;
        }
        else
        {
            pType = "CLI";
            refhospid = -1;
        }
        lresutl = BillingBl.GetRateCardForBilling(prefixText, OrgID, pType, refhospid, out lstClientNames);
        if (lstClientNames.Count > 0)
        {
            
            if (Cliclientname.Text == string.Empty)
            {
                Cliclientname.Text = lstClientNames[0].ClientName;
                Cliclientname.Enabled = false;
            }
            if (txtClientCodeSrch.Text == string.Empty)
            {
                txtClientCodeSrch.Text = lstClientNames[0].ClientCode;
                txtClientCodeSrch.Enabled = false;
            }

            


        }
    }




    string strSelects = Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_07 == null ? "------SELECT------" : Resources.Lab_ClientDisplay.Lab_TransferSampleCollection_aspx_07;
    //private void LoadTestname()
    //{
    //   // InvestigationMaster invmas = new InvestigationMaster();
    //    List<InvestigationMaster> Testname=new List<InvestigationMaster>();
    //    returnCode = new Referrals_BL(base.ContextInfo).GetTestname(OrgID, out Testname);
    //    if (Testname.Count > 0)
    //    {
    //        ddltransferloc.DataSource = Testname;
    //        ddltransferloc.DataTextField = "DisplayText";
    //        ddltransferloc.DataValueField = "InvestigationID";
    //        ddltransferloc.DataBind();
    //        ddltransferloc.Items.Insert(0, strSelects.Trim());
    //        ddltransferloc.Items[0].Value = "-1";
            
    //    }
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








    protected void Save_Click(object sender, EventArgs e)
    {
        int Clientid;
        string Batchidtxt;
        int Testnameid=0;
        DateTime Fromdatetext;
        DateTime Todatetext;
        string Billingid = string.Empty;
        string TestType ="";
        
       // Clientid = hdnClientID.Value;
        Clientid = Convert.ToInt32(hdnClientID.Value);
        Batchidtxt = txtBatchID.Text;

        if (hdnInvID.Value != "0")
        {
            Testnameid = Convert.ToInt32(hdnInvID.Value);
            TestType = hdnInvType.Value;
        }
       
       // Testnametxt = txtTestName.Text;
        Fromdatetext = (Fromdate.Text.Trim().ToLower() == "dd/mm/yyyy" || Fromdate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(Fromdate.Text.Trim());
        Todatetext = (Todate.Text.Trim().ToLower() == "dd/mm/yyyy" || Todate.Text.Trim() == "") ? Convert.ToDateTime("01/01/1753") : Convert.ToDateTime(Todate.Text.Trim());
        Billingid = TxtBillingID.Text;

        Master_BL masterbl = new Master_BL(base.ContextInfo);
        returnCode = masterbl.insertClientBatchMaster(Batchidtxt, Fromdatetext, Todatetext, Convert.ToInt32(Billingid), Clientid, Testnameid, OrgID, LID, TestType);
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "alert('saved successfully.');", true);
        ClearFields(); 
    }

    public void ClearFields()
    {
        txtClient.Text = String.Empty;
        txtBatchID.Text = String.Empty;
        Fromdate.Text = String.Empty;
        Todate.Text = String.Empty;
        TxtBillingID.Text = String.Empty;
        hdnInvID.Value = "0";
        hdnInvType.Value = "";
        TextBox1.Text = "";
        
    }
    
}


   


    
