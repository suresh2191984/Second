using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
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

public partial class Reception_OutsourceReceive : BasePage
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
    public Reception_OutsourceReceive()
        : base("Reception_OutsourceReceive_aspx")
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
        
            string Vistid = Request.QueryString["vid"];
            visitID = Convert.ToInt32(Vistid);
            string Patientid = Request.QueryString["pid"];
            patientID = Convert.ToInt32(Patientid);
            PID = patientID;
            hdnpatientid.Value = PID.ToString();
            hdnorgid.Value =Convert.ToString(OrgID);
            hdnlid.Value =Convert.ToString(LID);
            ViewState["PreviousPage"] = Request.UrlReferrer.ToString().Replace("?Ispopup=Y", ""); ;
            hdnconfig.Value = GetConfigValue("TRF_UploadPath", OrgID);
            hdnpno.Value = Request.QueryString["pid"];
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            string VisitID = String.Empty;
            string VisitNumber = String.Empty;
            new Patient_BL(base.ContextInfo).GetPatientVisitNumber(Convert.ToInt64(PID), out VisitID, out VisitNumber);
            hdnvisitid.Value = VisitID;
            hdnvisitnumber.Value = VisitNumber;
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            int Year = dt.Year;
            int Month = dt.Month;
            int Day = dt.Day;
            String Root = String.Empty;
            String RootPath = String.Empty;
            Root = "Outsource_Docs" + "-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            hdnroot.Value = Root;
            LoadGrid(Vistid);

        }


    }

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

    protected void Backbutton_click(object sender, EventArgs e)
    {
        if (ViewState["PreviousPage"] != null)
        {
            Response.Redirect(ViewState["PreviousPage"].ToString() + "?Ispopup=Y");
        }
    }
    //protected void Clear_click(object sender, EventArgs e)
    //{
    //    foreach (GridViewRow row in grdResult.Rows)
    //    {
    //        TextBox ParameterName = (TextBox)row.FindControl("txtreferenceid");
    //        ParameterName.Text = String.Empty;
    //    }

    //}



    protected void Update_Click(object sender, EventArgs e)
    {
        string Vistid = Request.QueryString["vid"];
        string AlertMesg1 = "Updated Successfully";
        string AlertMesg2 = "Please select check box";
        visitID = Convert.ToInt32(Vistid);
        List<OutsourcingDetail> lstOutSourcingDetails = new List<OutsourcingDetail>();
        string strPatientVisitId = string.Empty;
        string strSampleId = string.Empty;
        string strGuid = string.Empty;
        string strSampleStatusID = string.Empty;
        string Status = string.Empty;
        string strInvID = string.Empty;
        string strAccessionNo = string.Empty;
        string strLocID = string.Empty;

        string strOutsourcedTime = string.Empty;
        string strCourierDetails = string.Empty;
        string strAcknowledgement = string.Empty;
        string strSampleTrackerID = string.Empty;
        string strReceivedDateTime = string.Empty;
        DateTime ReceivedDate = DateTime.MaxValue;
        foreach (GridViewRow item in grdResult.Rows)
        {
            CheckBox ChkbxSelect = (CheckBox)item.FindControl("ChkbxSelect");
            if (ChkbxSelect.Checked)
            {
                OutsourcingDetail objoutsourcingdtl = new OutsourcingDetail();
                HiddenField hfVisitId = (HiddenField)item.FindControl("hdnVisitId");
                HiddenField hfSampleId = (HiddenField)item.FindControl("hdnSampleId");
                HiddenField hfGuid = (HiddenField)item.FindControl("hdnGuid");
                //HiddenField hfSampleStatusId = (HiddenField)item.FindControl("hdnInvSampleStatusID");
                HiddenField hfSampleTrakerId = (HiddenField)item.FindControl("hdnSampleTrackerID");
                HiddenField hfInvID = (HiddenField)item.FindControl("hdnInvID");
                HiddenField hfAccessionNo = (HiddenField)item.FindControl("hdnAccessionNo");
                HiddenField hfLocID = (HiddenField)item.FindControl("hdnoutlocid");
                // DropDownList ddlOutLoc = (DropDownList)item.FindControl("ddlOutSourceLoc");
                Label lblOutSourceLoc = (Label)item.FindControl("lblOutSourceLoc");
                HiddenField hdnlblOutSourceLoc = (HiddenField)item.FindControl("hdnlblOutSourceLoc");
                strPatientVisitId = hfVisitId.Value;
                strSampleId = hfSampleId.Value;
                strGuid = hfGuid.Value;
                //  strSampleStatusID = hfSampleStatusId.Value;
                strSampleTrackerID = hfSampleTrakerId.Value;
                strInvID = hfInvID.Value;
                strAccessionNo = hfAccessionNo.Value;
                strLocID = hfLocID.Value;
                Status = "Received";
                objoutsourcingdtl.PatientVisitID = Convert.ToInt64(strPatientVisitId);
                objoutsourcingdtl.SampleID = Convert.ToInt64(strSampleId);
                objoutsourcingdtl.UID = strGuid.ToString();
                //objoutsourcingdtl.InvSampleStatusID = Convert.ToInt32(strSampleStatusID);
                objoutsourcingdtl.SampleTrackerID = Convert.ToInt64(strSampleTrackerID);
                objoutsourcingdtl.InvestigationID = Convert.ToInt64(strInvID);
                objoutsourcingdtl.AccessionNumber = Convert.ToInt64(strAccessionNo);
                objoutsourcingdtl.OutSourcingLocationID = Convert.ToInt64(strLocID);

                TextBox ParameterName = (TextBox)item.FindControl("txtreferenceid");

                
                string REFID = ParameterName.Text;
                objoutsourcingdtl.RefID = REFID;
                lstOutSourcingDetails.Add(objoutsourcingdtl);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg1 + "');", true);

            }
           
        }
        if (lstOutSourcingDetails.Count == 0)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg2 + "');", true);
        }
        returnCode = new PatientVisit_BL(base.ContextInfo).UpdateoutsourceGrid(lstOutSourcingDetails, LID, visitID, ReceivedDate, OrgID, Status);
        LoadGrid(Vistid);
       
    }


    private void LoadGrid(string Vistid)
    {
        long Patientvisitid = Convert.ToInt64(Vistid);
        returnCode = new PatientVisit_BL(base.ContextInfo).OutsourceGrid(Patientvisitid, out lstOutsourcingDetail);

        grdResult.DataSource = lstOutsourcingDetail;
        grdResult.DataBind();
        grdResult.Visible = true;
        if (lstOutsourcingDetail.Count == 0)
        {
            EmptyGrid.Text = "Tests are not available to Receive";
            Update.Visible = false;
            Clear.Visible = false;
        }

    }

    protected void grdResult_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string PID = "0";
        string VID = "0";
        string fileExtension = string.Empty;
        string fileName = string.Empty;
        long returncode = -1;
        long pVisitID = -1;
        //long returnCode = -1;
        int patientid = -1;
        if (Request.QueryString["pid"] != null && Request.QueryString["pid"] != "")
        {
            PID = Request.QueryString["pid"];
        }
        if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "")
        {
            VID = Request.QueryString["vid"];
        }
        Button bts = e.CommandSource as Button;
        
                if (e.CommandName.ToString() == "View")
                {
                    string PictureName = string.Empty;
                    if (e.CommandArgument.ToString() != "")
                    {
                        pVisitID = Convert.ToInt32(VID);
                        patientid = Convert.ToInt32(PID);
                        pathname = GetConfigValue("TRF_UploadPath", OrgID);
                        //long returncode = -1;
                        List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
                        List<TRFfilemanager> lstOutSourceDoc = new List<TRFfilemanager>();
                        try
                        {
                            string Type = "";
                            //LnkOutDoc.Attributes.Add("onclick", "return onClickLnkOutDoc('" + ddlOutsourceDocList.ClientID + "');");
                            returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, Convert.ToInt32(pVisitID), OrgID, Type, out lstFiles);
                            if (lstFiles.Count > 0)
                            {
                                lstOutSourceDoc = lstFiles.FindAll(P => P.IdentifyingType == "Outsource_Docs");
                            }
                            if (lstOutSourceDoc.Count > 0)
                            {
                                if (lstOutSourceDoc.Count == 1)
                                {
                                    trddlOutsourceDoc.Style.Add("display", "none");
                                    //PictureName = lstOutSourceDoc[0].FileUrl.ToString();
                                    PictureName = lstOutSourceDoc[0].FileName.ToString();
                                    fileName = Path.GetFileNameWithoutExtension(PictureName);
                                    fileExtension = Path.GetExtension(PictureName);
                                    string PDFFile = pathname + PictureName;

                                    if (PictureName != "")
                                    {

                                        if (PictureName != "" && fileExtension != ".pdf")
                                        {
                                            if (!String.IsNullOrEmpty(PictureName))
                                            {
                                                mpopOutDoc.Show();
                                                trPicPatient1.Style.Add("display", "block");
                                                trPDF1.Style.Add("display", "none");
                                                imgPatient1.Src = "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID;
                                            }
                                        }
                                        else
                                        {

                                            trPicPatient1.Style.Add("display", "none");
                                            trPDF1.Style.Add("display", "block");
                                            mpopOutDoc.Show();
                                            ifPDF1.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + PictureName + "&OrgID=" + OrgID);
                                        }
                                    }
                                    else
                                    {
                                        trPicPatient1.Style.Add("display", "none");
                                        trPDF1.Style.Add("display", "none");
                                    }
                                }
                                else if (lstOutSourceDoc.Count > 1)
                                {
                                    trPicPatient1.Style.Add("display", "none");
                                    trddlOutsourceDoc.Style.Add("display", "none");
                                    trPDF1.Style.Add("display", "block");
                                    mpopOutDoc.Show();

                                    //ifPDF.Attributes["src"] = "ReportPdf.aspx?pdf=" + filePath;
                                    ifPDF1.Attributes["src"] = "../Investigation/OutSourceDocPdf.aspx?pdf=Outsource&vid=" + Convert.ToInt64(pVisitID);
                                }
                            }
                            else
                            {
                                trPicPatient1.Style.Add("display", "none");
                                trPDF1.Style.Add("display", "none");
                                trddlOutsourceDoc.Style.Add("display", "none");
                            }
                        }
                        catch (Exception ex)
                        {
                            CLogger.LogError("Error in LoadingImage", ex);
                        }
                    }
                }

            }


}
    
