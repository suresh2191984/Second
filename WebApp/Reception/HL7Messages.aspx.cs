using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using iTextSharp.text;
using Attune.Podium.BusinessEntities;
using log4net.Repository.Hierarchy;
using Attune.Podium.Common;
using System.IO;
using System.Configuration;
public partial class Reception_HL7Messages : BasePage
{

    string UploadPathHL7 = string.Empty;
    public Reception_HL7Messages()
        : base("Reception_HL7Messages_aspx")
    {
    }

    #region Variables

    int MessageId = 0;

    string Flag = string.Empty;

    string PathName = string.Empty;

    int gridCheck = 0;
    int lSourceCheck = 0;

    string Location = string.Empty;
    string OtherLocation = string.Empty;
    List<HLMessages> lstHLM = new List<HLMessages>();

    #endregion

    #region Events
    //jegan
    protected void Page_PreRender(object sender, EventArgs e)
    {
        ViewState["CheckRefresh"] = Session["CheckRefresh"];
    }
    //
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (ViewState.Count > 0)
                MessageId = Convert.ToInt32(ViewState["Value"]);
            if (!IsPostBack)
            {
		txtFromPeriod.Text = DateTime.Now.AddHours(-1).ToString("dd-MM-yyyy hh:mm:ss tt");
                txtToPeriod.Text =  DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt");
                //FetchHL7Data(DateTime.Today, DateTime.Today, null, "");
                txtFromPeriod.Enabled = false;
                txtToPeriod.Enabled = false;
                //divLabData.Attributes.Add("style", "display:none");
                divPatientandorder.Attributes.Add("style", "display:none");
                divErrorDetails.Attributes.Add("style", "display:none");
                divHealthLabData.Attributes.Add("style", "display:none");
                //divLabData.Visible = true;
                //divPatientandorder.Visible = false;


                //added for avoid browser refresh ***start**
                Session["CheckRefresh"] =
                Server.UrlDecode(System.DateTime.Now.ToString());
                //end
            }
            Page.Form.Attributes.Add("enctype", "multipart/form-data");

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error in Page_Load", ex);
        }
    }

    protected void HL7MessageFileUploader_Click(object sender, HL7FileUploadCollectionEventArgs e)
    {
        try
        {

            long returncode = -1;

            string PathFileName = string.Empty;

            if (Session["CheckRefresh"].ToString() == ViewState["CheckRefresh"].ToString())
            {

            PathName = GetConfigValue("HL7_UploadPath", OrgID);
            if (!string.IsNullOrEmpty(PathName))
            {
                DateTime dt = new DateTime();
                dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                String Root = String.Empty;
                String RootPath = String.Empty;
                RootPath = PathName + Root;
                //ENd///    
                HttpFileCollection oHttpFileCollection = e.PostedFiles;
                HttpPostedFile oHttpPostedFile = null;
                if (e.HasFiles)
                {

                    for (int n = 0; n < e.Count; n++)
                    {
                        oHttpPostedFile = oHttpFileCollection[n];
                        if (oHttpPostedFile.ContentLength <= 0)
                            {
                                string AlertMsgEmpty = "Please Upload the File";                               
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMsgEmpty + "');", true);
                                return;
                            }
                        else
                        {
                            string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                            string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                            string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                            if (!System.IO.Directory.Exists(RootPath))
                            {
                                System.IO.Directory.CreateDirectory(RootPath);
                            }
                            Response.OutputStream.Flush();

                            string imageExtension = ".HL7";

                            if (imageExtension.Contains(fileExtension.ToUpper()))
                            {

                                if (File.Exists(UploadPathHL7))
                                    File.Delete(UploadPathHL7);

                                Response.OutputStream.Flush();

                                string fileName1 = Path.Combine(PathName, FullName);

                                oHttpPostedFile.SaveAs(fileName1);


                                Master_BL objMaster_BL = new Master_BL(base.ContextInfo);

                                PathFileName = PathName + FullName;

                                returncode = objMaster_BL.SaveHL7MessageFiles(FullName, PathFileName, OrgID, 0, 0, dt, 0);

                            }


                                if (returncode >= 0)
                                {

                                    string PageUrl = string.Empty;
                                    string AlertMesg = "File Uploaded Successfully";
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');", true);
                                    // divPatientandorder.Visible = false;
                                    divPatientandorder.Attributes.Add("style", "display:none");
                                    divErrorDetails.Attributes.Add("style", "display:none");
                                    //Grouptab.ActiveTab = HealthLabDatatab;
                                    divHealthLabData.Attributes.Add("style","display:none");
                                    divOtheLabData.Attributes.Add("style","display:none");
                                    //divLabData.Visible = false;
                                    txtFromPeriod.Text = DateTime.Now.AddHours(-1).ToString("dd-MM-yyyy hh:mm:ss tt");
                                    txtToPeriod.Text = DateTime.Now.ToString("dd-MM-yyyy hh:mm:ss tt");
                                    Session["CheckRefresh"] = Server.UrlDecode(System.DateTime.Now.ToString("dd-MM-yyyy hh:mm:sstt"));

                                }
                                else
                                {
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('File Upload Failed');", true);
                                }
                            }

                        }
                    }
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('File Upload Failed - Upload folder path is not found');", true);
                }
            }
            else
            {
                divHealthLabData.Attributes.Add("style","display:none");
                divPatientandorder.Attributes.Add("style", "display:none");
                divErrorDetails.Attributes.Add("style", "display:none");

                //divPatientandorder.Visible = false;
                //divLabData.Visible = false;
                //Grouptab.ActiveTab = HealthLabDatatab;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7MessageFileUploader_Click", ex);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('File Upload Failed');", true);
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            Flag = "SearchClick";
            DateTime dtGetFromDate = Convert.ToDateTime(DateTime.Now.ToString("dd-MM-yyyy HH:mm:sstt"));
            DateTime dtGetToDate = Convert.ToDateTime(DateTime.Now.ToString("dd-MM-yyyy HH:mm:sstt"));
            dtGetFromDate = Convert.ToDateTime(txtFromPeriod.Text.TrimEnd());
            dtGetToDate = Convert.ToDateTime(txtToPeriod.Text.TrimEnd());
            if (dtGetFromDate.Date <= dtGetToDate.Date)
            {
                gvPatientDetails.PageIndex = gvOrderDetails.PageIndex = gvHealthLabData.PageIndex = 0;
                string Todate = txtToPeriod.Text.TrimEnd();// + " 23:59:59";
                string strTo = txtToPeriod.Text;
                FetchHL7Data(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(txtToPeriod.Text.TrimEnd()), 0, txtPatientExternalVisitId.Text == "" ? "" : txtPatientExternalVisitId.Text.TrimEnd(), txtMessageId.Text.TrimEnd());

                //divLabData.Attributes.Add("style", "display:none");
                //divPatientandorder.Attributes.Add("style", "display:none");
		//divErrorDetails.Attributes.Add("style", "display:none");
                //gvPatientDetails.Attributes.Add("style", "display:none");
                // gvOrderDetails.Attributes.Add("style", "display:none");
                // gvErrorMsg.Attributes.Add("style", "display:none");
                divPatientandorder.Attributes.Add("style","display:none");
                gvPatientDetails.Visible = false;
                gvOrderDetails.Visible = false;
                gvVisitDetails.Visible = false;
                divOtheLabData.Attributes.Add("style","display:none");
                // gvHealthLabData.Visible = true;
                gvErrorMsg.Visible = false;
                //divPatientandorder.Visible = false;
                //Grouptab.ActiveTab = HealthLabDatatab;

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, Page.GetType(), "text", "CheckFromDateToDate()", true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages view at button Search", ex);
        }
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        try
        {
            //divLabData.Attributes.Add("style","display:none");
            //divPatientandorder.Attributes.Add("style", "display:none");
            //gvHealthLabData.DataSource = null;
            //gvHealthLabData.DataBind();
            //gvOtherLabData.DataSource = null;
            //gvOtherLabData.DataBind();
            // txtToPeriod.Text = txtFromPeriod.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm:sstt");

            //start
            divHealthLabData.Attributes.Add("style","display:none");
            divPatientandorder.Attributes.Add("style", "display:none");
            divErrorDetails.Attributes.Add("style", "display:none");
            //divLabData.Visible = false;
            //divPatientandorder.Visible = false;
            //end
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages view at button Search", ex);
        }
    }
    protected void LnkHl7upload_Click(object sender, EventArgs e)
    {

        divHealthLabData.Attributes.Add("style","display:none");
        divPatientandorder.Attributes.Add("style", "display:none");
        divErrorDetails.Attributes.Add("style", "display:none");
       
    }

    protected void gvHealthLabData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            //  string Todate = txtToPeriod.Text.TrimEnd() + " 23:59:59";
            if (e.NewPageIndex != -1)
            {
                gvHealthLabData.PageIndex = e.NewPageIndex;
                // FetchHL7PatientOrderDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
                // btnSearch_Click(sender, e);
                //string Todate = txtToPeriod.Text.TrimEnd() + " 23:59:59";

                FetchHL7Data(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(txtToPeriod.Text.TrimEnd()), 0, txtPatientExternalVisitId.Text == "" ? "" : txtPatientExternalVisitId.Text.TrimEnd(), txtMessageId.Text.TrimEnd());

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvHealthLabData PageIndexChanging", ex);
        }
    }

    protected void gvVisitDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            string Todate = txtToPeriod.Text.TrimEnd();// + " 23:59:59";
            if (e.NewPageIndex != -1)
            {
                gvVisitDetails.PageIndex = e.NewPageIndex;
                FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
                // FetchGetHL7VisitDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvHealthLabData PageIndexChanging", ex);
        }
    }

    protected void gvVisitDetails_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {


            if (e.Row.RowType == DataControlRowType.DataRow)
            {

                string dateTimeofTransaction = e.Row.Cells[3].Text;
                if (dateTimeofTransaction == "01/01/0001 00:00:00" || dateTimeofTransaction == "31/12/9999 23:59:59")
                    e.Row.Cells[3].Text = "";

                string startTime = e.Row.Cells[7].Text;
                if (dateTimeofTransaction == "01/01/0001 00:00:00" || dateTimeofTransaction == "31/12/9999 23:59:59")
                    e.Row.Cells[7].Text = "";

                string endTime = e.Row.Cells[8].Text;
                if (dateTimeofTransaction == "01/01/0001 00:00:00" || dateTimeofTransaction == "31/12/9999 23:59:59")
                    e.Row.Cells[8].Text = "";

                string OrderEffectiveDate = e.Row.Cells[43].Text;
                if (dateTimeofTransaction == "01/01/0001 00:00:00" || dateTimeofTransaction == "31/12/9999 23:59:59")
                    e.Row.Cells[43].Text = "";

                string fillerEffectDate= e.Row.Cells[55].Text;
                if (dateTimeofTransaction == "01/01/0001 00:00:00" || dateTimeofTransaction == "31/12/9999 23:59:59")
                    e.Row.Cells[55].Text = "";

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvHealthLabData_OnRowDataBound", ex);
        }
    }

    protected void gvOtherLabData_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            string Todate = txtToPeriod.Text.TrimEnd();// + " 23:59:59";
            if (e.NewPageIndex != -1)
            {
                gvOtherLabData.PageIndex = e.NewPageIndex;
                FetchHL7Data(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(txtToPeriod.Text.TrimEnd()), 
                    0,
                    txtPatientExternalVisitId.Text == "" ? "" : txtPatientExternalVisitId.Text.TrimEnd(), txtMessageId.Text.TrimEnd());
               // FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
                // FetchHL7PatientOrderDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
              //  btnSearch_Click(sender, e);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvOtherLabData PageIndexChanging", ex);
        }
    }

    protected void gvPatientDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvPatientDetails.PageIndex = e.NewPageIndex;

                string Todate = txtToPeriod.Text.TrimEnd();// + " 23:59:59";

                Int32.TryParse(ViewState["Value"].ToString(),out MessageId);
                FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
                //FetchHL7PatientOrderDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvPatientDetails PageIndexChanging", ex);
        }
    }
    protected void gvErrorMsg_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                gvErrorMsg.PageIndex = e.NewPageIndex;

                string Todate = txtToPeriod.Text.TrimEnd() + " 23:59:59";
                Int32.TryParse(ViewState["Value"].ToString(),out MessageId);
                FetchPatientErrorDetails(Convert.ToInt32(MessageId));
                gvErrorMsg.Visible = true;
            }
            ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "msg", "CalculateHeight()", true); 
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvErrorMsg PageIndexChanging", ex);
        }
    }
    protected void gvPatientDetails_OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                //e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvPatientDetails, "Select$" + e.Row.RowIndex);
                //e.Row.Attributes["style"] = "cursor:pointer";

                Label lblDob = e.Row.FindControl("lblDob") as Label;

                string strDob = lblDob.Text;
                if (strDob == "31/12/9999 23:59:59" || strDob == "01/01/0001 00:00:00" || strDob == "31/12/9999 00:00:00" || strDob=="Dec - 99")
                {
                    lblDob.Text = "";
                }
                else
                {
                    lblDob.Text =Convert.ToDateTime(strDob).ToString("dd/MM/yyyy");
                }

                Label lblDeathDate = e.Row.FindControl("lblDeathDate") as Label;
                string strPDeathDate = lblDeathDate.Text;
                if (strPDeathDate == "31/12/9999 23:59:59" || strPDeathDate == "01/01/0001 00:00:00" || strPDeathDate == "31/12/9999 00:00:00" || strDob == "Dec - 99")
                {
                    lblDeathDate.Text = "";
                }
                Label lblLastUpdatedDate = e.Row.FindControl("lblLastUpdatedDate") as Label;
                string strLastUpdatedDateTime = lblLastUpdatedDate.Text;
                if (strLastUpdatedDateTime == "31/12/9999 23:59:59" || strLastUpdatedDateTime == "01/01/0001 00:00:00" || strLastUpdatedDateTime == "31/12/9999 00:00:00" || strDob == "Dec - 99")
                {
                    lblLastUpdatedDate.Text = "";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvPatientDetails_OnRowDataBound", ex);
        }
    }
    protected void gvErrorMsg_OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        try
        {

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvErrorMsg_OnRowDataBound", ex);
        }
    }
    protected void gvOrderDetails_OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblRequestDate = e.Row.FindControl("lblRequestDate") as Label;
                string strRequestDateTime = lblRequestDate.Text;
                if (strRequestDateTime == "01/01/0001 00:00:00" || strRequestDateTime == "31/12/9999 23:59:59" || strRequestDateTime == "31/12/9999 00:00:00" || strRequestDateTime == "Dec - 99")
                    lblRequestDate.Text = "";

                Label lblObservationDate = e.Row.FindControl("lblObservationStartDate") as Label;
                string strObservationDateTime = lblObservationDate.Text;
                if (strObservationDateTime == "01/01/0001 00:00:00" || strObservationDateTime == "31/12/9999 23:59:59" || strObservationDateTime == "31/12/9999 00:00:00" || strObservationDateTime == "Dec - 99")
                    lblObservationDate.Text = "";

                Label lblObservationEndDate = e.Row.FindControl("lblObservationEndDate") as Label;

                string strObservationEndDateTime = lblObservationEndDate.Text;
                if (strObservationEndDateTime == "01/01/0001 00:00:00" || strObservationEndDateTime == "31/12/9999 23:59:59" || strObservationEndDateTime == "31/12/9999 00:00:00" || strObservationEndDateTime == "Dec - 99")
                    lblObservationEndDate.Text = "";

                Label lblSpecimenReceivedDate = e.Row.FindControl("lblSpecimenReceivedDate") as Label;
                string strSpecimenReceivedDateTime = lblSpecimenReceivedDate.Text;
                if (strSpecimenReceivedDateTime == "01/01/0001 00:00:00" || strSpecimenReceivedDateTime == "31/12/9999 23:59:59" || strSpecimenReceivedDateTime == "31/12/9999 00:00:00" || strSpecimenReceivedDateTime == "Dec - 99")
                    lblSpecimenReceivedDate.Text = "";

                Label lblResults_Rpt_Status_Chng_DateTime = e.Row.FindControl("lblResults_Rpt_Status_Chng_DateTime") as Label;
                string strResultReptChangeDateTime = lblResults_Rpt_Status_Chng_DateTime.Text;
                if (strResultReptChangeDateTime == "01/01/0001 00:00:00" || strResultReptChangeDateTime == "31/12/9999 23:59:59" || strResultReptChangeDateTime == "31/12/9999 00:00:00" || strResultReptChangeDateTime == "Dec - 99")
                    lblResults_Rpt_Status_Chng_DateTime.Text = "";

                Label lblOBRQuantityStartDate = e.Row.FindControl("lblOBRQuantityStartDate") as Label;
                string strOBRQuantity_TimingStartDate = lblOBRQuantityStartDate.Text;
                if (strOBRQuantity_TimingStartDate == "01/01/0001 00:00:00" || strOBRQuantity_TimingStartDate == "31/12/9999 23:59:59" || strOBRQuantity_TimingStartDate == "31/12/9999 00:00:00" || strOBRQuantity_TimingStartDate == "Dec - 99")
                    lblOBRQuantityStartDate.Text = "";

                Label lblLogin_Create_DateTime = e.Row.FindControl("lblLogin_Create_DateTime") as Label;
                string strLoginCreateDate = lblLogin_Create_DateTime.Text;
                if (strLoginCreateDate == "01/01/0001 00:00:00" || strLoginCreateDate == "31/12/9999 23:59:59" || strLoginCreateDate == "31/12/9999 00:00:00" || strLoginCreateDate == "Dec - 99")
                    lblLogin_Create_DateTime.Text = "";

                Label lblScheduled_Date_Time = e.Row.FindControl("lblScheduled_Date_Time") as Label;
                string strScheduledDateTime = lblScheduled_Date_Time.Text;
                if (strScheduledDateTime == "01/01/0001 00:00:00" || strScheduledDateTime == "31/12/9999 23:59:59" || strScheduledDateTime == "31/12/9999 00:00:00" || strScheduledDateTime == "Dec - 99")
                    lblScheduled_Date_Time.Text = "";

                Label lblOBRQuantity_TimingEndDate = e.Row.FindControl("lblOBRQuantity_TimingEndDate") as Label;
                string strOBRQuantity_TimingeEndDate = lblOBRQuantity_TimingEndDate.Text;
                if (strOBRQuantity_TimingeEndDate == "01/01/0001 00:00:00" || strOBRQuantity_TimingeEndDate == "31/12/9999 23:59:59" || strOBRQuantity_TimingeEndDate == "31/12/9999 00:00:00" || strOBRQuantity_TimingeEndDate == "Dec - 99")
                    lblOBRQuantity_TimingEndDate.Text = "";
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "StatusAlert", "CalculateHeight();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvOrderDetails_OnRowDataBound", ex);
        }
    }

    //protected void gvOrderDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    try
    //    {
    //        string Todate = txtToPeriod.Text.TrimEnd();// + " 23:59:59";

    //        if (e.NewPageIndex != -1)
    //        {
    //            gvOrderDetails.PageIndex = e.NewPageIndex;

    //            MessageId = Convert.ToString(ViewState["Value"]);
    //            FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
    //            //FetchHL7PatientOrderDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);

    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in HL7 Messages View at gvOrderDetails_PageIndexChanging", ex);
    //    }
    //}

    protected void gvHealthLabData_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvHealthLabData, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";

                string strTransferDateTime = e.Row.Cells[6].Text;
                if (strTransferDateTime == "01/01/0001 00:00:00" || strTransferDateTime == "31/12/9999 23:59:59")
                    e.Row.Cells[4].Text = "";
                Label lblStatus = e.Row.FindControl("lblStatus") as Label;
                string strStatus = lblStatus.Text;
                if (strStatus != "")
                {
                    if (strStatus == "Sent Successfully" || strStatus=="Success" ||strStatus=="")
                        lblStatus.Text = "Success";
                    else
                        lblStatus.Text = "Failure";

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvHealthLabData_OnRowDataBound", ex);
        }
    }

    protected void gvHealthLabData_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            lSourceCheck = 1;
            Int32.TryParse(((HiddenField)gvHealthLabData.SelectedRow.Cells[1].FindControl("HFMessageId")).Value.ToString(),out MessageId);
            Location = gvHealthLabData.SelectedRow.Cells[8].Text;
            ViewState["Value"] = MessageId;
            //string Todate = txtToPeriod.Text.TrimEnd() + " 23:59:59";         
            if (MessageId>0)
            {
                // divPatientandorder.Visible = true;
                gridCheck = 1;
                FetchHL7Data(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(txtToPeriod.Text.TrimEnd()),
                    MessageId, txtPatientExternalVisitId.Text == "" ? "" : txtPatientExternalVisitId.Text.TrimEnd(), txtMessageId.Text.TrimEnd());

                divPatientandorder.Attributes.Add("style", "display:block");
                FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(txtToPeriod.Text.TrimEnd()), MessageId);
                FetchPatientErrorDetails(Convert.ToInt32(MessageId));
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvHealthLabData_SelectedIndexChanged", ex);
        }
    }

    protected void gvOtherLabData_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.Cells.Count > 0)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(gvOtherLabData, "Select$" + e.Row.RowIndex);
                e.Row.Attributes["style"] = "cursor:pointer";
                if (e.Row.Cells.Count > 1)
                    e.Row.Cells[1].Attributes.Add("style", "display:none");
                Label lblStatus = e.Row.FindControl("lblOrderStatus") as Label;
                if (lblStatus != null)
                {
                    string strStatus = lblStatus.Text;
                if (strStatus == "Success" || strStatus=="Sent Successfully" || strStatus=="")
                        lblStatus.Text = "Success";
                    else
                        lblStatus.Text = "Failure";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvOtherLabData_OnRowDataBound", ex);
        }
    }

    protected void gvOtherLabData_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            MessageId =Convert.ToInt32(((HiddenField)gvHealthLabData.SelectedRow.Cells[0].FindControl("HFMessageId")).Value.ToString());
            OtherLocation = ((HiddenField)gvOtherLabData.SelectedRow.Cells[1].FindControl("hdnOtherLocation")).Value.ToString();
            ViewState["Value"] = MessageId;
            string Todate = txtToPeriod.Text.TrimEnd();// + " 23:59:59";
            if (MessageId>0)
            {
                lSourceCheck = 0;
                //FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
                FetchHL7HealthLabDataDetail(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(txtToPeriod.Text.TrimEnd()), MessageId);
                FetchPatientErrorDetails(Convert.ToInt32(MessageId));
                //FetchHL7PatientDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
                //FetchHL7PatientOrderDetails(Convert.ToDateTime(txtFromPeriod.Text.TrimEnd()), Convert.ToDateTime(Todate), MessageId);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at gvOtherLabData_SelectedIndexChanged", ex);
        }
    }

    //protected void Grouptab_ActiveTabChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        if (Grouptab.ActiveTabIndex == 0)
    //        {
    //            //divPatientandorder.Visible = true;
    //            divPatientandorder.Attributes.Add("style", "display:block");
    //            divErrorDetails.Attributes.Add("style", "display:none");
    //        }
    //        else
    //        {
    //            //divPatientandorder.Visible = false;
    //            divPatientandorder.Attributes.Add("style", "display:none");
    //            divErrorDetails.Attributes.Add("style", "display:none");
    //        }
    //        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:CalculateHeight();", true);
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while changing tab", ex);
    //    }
    //}

    #endregion

    #region Methods

    private void FetchHL7Data(DateTime FromDate, DateTime ToDate, int Id, string ExternalVisitId,string MsgControlID)
    {
        try
        {
            //divPatientandorder.Visible = true;
            long returnCode = -1;
            //List<HLMessages> lstHLM = new List<HLMessages>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            string Todate = ToDate.Date.ToShortDateString() + " 23:59:59";

            if (gridCheck == 0)
            {
                returnCode = masterbl.GetHealthLabData(MsgControlID, FromDate, Convert.ToDateTime(ToDate), ExternalVisitId == "" ? "0" : ExternalVisitId, Id, out lstHLM);
                divOtheLabData.Attributes.Add("style", "display:none");
            if (returnCode == 0 && lstHLM.Count > 0)
            {

                gvHealthLabData.DataSource = lstHLM;//.FindAll(P => P.Location != "" || P.LocationID == -1);
                gvHealthLabData.DataBind();
                gvHealthLabData.Visible = true;
                    //divLabData.Attributes.Add("style", "display:block");
                //divLabData.Visible = true;
                divHealthLabData.Attributes.Add("style", "display:block");
            }
            else
            {
                //gvHealthLabData.Visible = false;
                MessageId = 0;
                ViewState["Value"]  = "0";
                //gvPatientDetails.Visible = false;
                //gvOrderDetails.Visible = false;
                //gvOrderErrorMsg.Visible = false;

                //start
                gvErrorMsg.Visible = false;
                    gvHealthLabData.Visible = false;
                //divPatientandorder.Visible = true;
                //divLabData.Visible = true;
                    //divLabData.Attributes.Add("style", "display:none");
                    divPatientandorder.Attributes.Add("style", "display:none");
                    divHealthLabData.Attributes.Add("style", "display:none");
                    divOtheLabData.Attributes.Add("style", "display:none");
                    //gvHealthLabData.DataSource = null;
                    //gvHealthLabData.DataBind();
                    //gvOtherLabData.DataSource = null;
                    //gvOtherLabData.DataBind();
                //end

                if (Flag != string.Empty && Flag != "")
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:alert('No Matching Records found');", true);
                }
            }
            else
            {
                returnCode = masterbl.GetHealthLabData(MsgControlID, FromDate, Convert.ToDateTime(ToDate), ExternalVisitId == "" ? "0" : ExternalVisitId, Id, out lstHLM);
                if (returnCode == 0 && lstHLM.Count > 0)
                {
                    

                        //gvOtherLabData.DataSource = lstHLM.Where(f => f.Location == "");
                    if (lstHLM.FindAll(P => P.LocationID == 0 && P.Status == "Sent Successfully").Count > 0)
                    {
                        gvOtherLabData.DataSource = lstHLM.FindAll(P => P.LocationID==0 && P.Status=="Sent Successfully");

                        gvOtherLabData.DataBind();

                        divOtheLabData.Attributes.Add("style", "display:block");
                    }
                    else
                        divOtheLabData.Attributes.Add("style","display:none");


                }
                else
                {
                    divOtheLabData.Attributes.Add("style", "display:none");
                }

            }
			ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:CalculateHeight();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at FetchHL7Data", ex);
        }
    }

    private void FetchGetHL7VisitDetails(DateTime FromDate, DateTime ToDate, string Id)
    {
        try
        {
            long returnCode = -1;
            List<HLMessageORCDetails> lstHLM = new List<HLMessageORCDetails>();
            Master_BL objMasterBL = new Master_BL(base.ContextInfo);
            string Todate = ToDate.ToShortDateString() + "23:59:59";
            returnCode = objMasterBL.GetHL7VisitDetails(Convert.ToInt32(Id), FromDate, Convert.ToDateTime(ToDate), out lstHLM);
            if (returnCode == 0 && lstHLM.Count > 0)
            {
                gvVisitDetails.DataSource = lstHLM;
                gvVisitDetails.DataBind();
                gvVisitDetails.Visible = true;
                // gvVisitError.Visible = false;
            }
            else
            {
                gvVisitDetails.Visible = false;

                //gvVisitError.Visible = false;

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7Message Visit at FetchGetHL7VisitDetails", ex);
        }
    }

    private void FetchHL7PatientDetails(DateTime FromDate, DateTime ToDate, string Id)
    {
        try
        {
            long returnCode = -1;
            List<HLMessagePatientIDDetails> lstHLM = new List<HLMessagePatientIDDetails>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            string Todate = ToDate.Date.ToShortDateString() + " 23:59:59";
            returnCode = masterbl.GetHL7PatientDetail(Convert.ToInt32(Id), FromDate, Convert.ToDateTime(Todate), out lstHLM);
            if (returnCode == 0 && lstHLM.Count > 0)
            {
                gvPatientDetails.Visible = true;
                gvPatientDetails.DataSource = lstHLM;
                gvPatientDetails.DataBind();
                //gvPatientDetails.Visible = true;
                gvErrorMsg.Visible = false;
                divPatientandorder.Attributes.Add("style", "display:block");
                divErrorDetails.Attributes.Add("style", "display:none");
            }
            else
            {
                divPatientandorder.Attributes.Add("style", "display:none");
                //divPatientandorder.Visible = false;
                //gvPatientDetails.Visible = false;
                gvErrorMsg.Visible = false;
                divErrorDetails.Attributes.Add("style", "display:none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at FetchHL7PatientDetails", ex);
        }
    }

    private void FetchHL7PatientOrderDetails(DateTime FromDate, DateTime ToDate, string Id)
    {
        try
        {
            long returnCode = -1;
            List<HLMessageOBRDetails> lstHLM = new List<HLMessageOBRDetails>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            string Todate = ToDate.Date.ToShortDateString() + " 23:59:59";
            returnCode = masterbl.GetHL7OrderedDetails(Convert.ToInt32(Id), FromDate, Convert.ToDateTime(Todate), out lstHLM);
            if (returnCode == 0 && lstHLM.Count > 0)
            {
                gvOrderDetails.DataSource = lstHLM;
                gvOrderDetails.DataBind();
                gvOrderDetails.Visible = true;
                // gvOrderErrorMsg.Visible = false;
                divPatientandorder.Attributes.Add("style", "display:block");
            }
            else
            {
                //divPatientandorder.Visible = false;
                divPatientandorder.Attributes.Add("style", "display:none");
                divErrorDetails.Attributes.Add("style", "display:none");

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at FetchHL7PatientOrderDetails", ex);
        }
    }

    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = null;
        try
        {
             hfc = Request.Files;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages TRFFiles", ex);
        }
        return hfc;
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;

        try
        {
            
            long returncode = -1;
            GateWay objGateway = new GateWay(base.ContextInfo);
            List<Config> lstConfig = new List<Config>();

            returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
            if (lstConfig.Count > 0)
                configValue = lstConfig[0].ConfigValue;

            
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error in GetConfigValue - HL7Messages.aspx", ex);
        }
        return configValue;
    }

    private void FetchPatientErrorDetails(int Id)
    {
        try
        {
            long returnCode = -1;
            List<HLMessageErrorDetails> lstHLM = new List<HLMessageErrorDetails>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            returnCode = masterbl.GetErrorMsgByMsgId(Id, out lstHLM);
            if (returnCode == 0 && lstHLM.Count > 0)
            {
                gvErrorMsg.Visible = true;
                if (gridCheck == 1)
                    gvErrorMsg.DataSource = lstHLM.FindAll(P => P.HLMessageTable == "");
                else {
                    if (OtherLocation != "")
                    {
                        gvErrorMsg.DataSource = lstHLM.FindAll(P=>P.HLMessageTable==OtherLocation);
                    }
                }

                gvErrorMsg.DataBind();
                divErrorDetails.Attributes.Add("style", "display:block");
                // tabErrorMessage.Visible = true;
            }
            else
            {
                //  tabErrorMessage.Visible = false;
                gvErrorMsg.Visible = false;
                divErrorDetails.Attributes.Add("style", "display:none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at FetchPatientErrorDetails", ex);
        }
    }
    private void FetchHL7HealthLabDataDetail(DateTime FromDate, DateTime ToDate, int Id)
    {
        try
        {
            long returnCode = -1;
            List<HLMessagePatientIDDetails> lstHLM = new List<HLMessagePatientIDDetails>();
            List<HLMessageORCDetails> lstHLMORC = new List<HLMessageORCDetails>();
            List<HLMessageOBRDetails> lstHLMORD = new List<HLMessageOBRDetails>();
            Master_BL masterbl = new Master_BL(base.ContextInfo);
            string Todate = ToDate.Date.ToShortDateString() + " 23:59:59";
            returnCode = masterbl.GetHL7HealthLabDataDetail(Convert.ToInt32(Id), FromDate, Convert.ToDateTime(Todate), out lstHLM, out lstHLMORC, out lstHLMORD);
            divErrorDetails.Attributes.Add("style", "display:none");
	divPatientandorder.Attributes.Add("style", "display:none");
            if (returnCode == 0 && lstHLM.Count > 0)
            {
                gvPatientDetails.Visible = true;
                gvPatientDetails.DataSource = lstHLM;
                gvPatientDetails.DataBind();
                //gvPatientDetails.Visible = true;
		        TabPanel2.Visible = true;
		divPatientandorder.Attributes.Add("style", "display:block");
				 //gvErrorMsg.Visible = false;
            }
            else
            {
                TabPanel2.Visible = false;
                //divPatientandorder.Visible = false;
                gvPatientDetails.Attributes.Add("style", "display:none");
                 //gvErrorMsg.Visible = false;
            }

            if (returnCode == 0 && lstHLMORC.Count > 0)
            {
                gvVisitDetails.DataSource = lstHLMORC;
                gvVisitDetails.DataBind();
                gvVisitDetails.Visible = true;
		        tabPanelVisitDetails.Visible = true;
		divPatientandorder.Attributes.Add("style", "display:block");
            }
            else
            {
                tabPanelVisitDetails.Visible = false;
                gvVisitDetails.Visible = false;

            }
            if (returnCode == 0 && lstHLMORD.Count > 0)
            {
                //if (lSourceCheck == 1)
                //{
                    gvOrderDetails.DataSource = lstHLMORD;
                    gvOrderDetails.DataBind();
                //}
                if (lSourceCheck == 0)
                {
                    lstHLMORD = lstHLMORD.FindAll(P => P.LocationSource == "O" && P.FolderName == OtherLocation);
                   lstHLMORD.ToList().ForEach(f=>f.Placer_Field1=f.FolderName);
                    gvOrderDetails.DataSource = lstHLMORD;
                    gvOrderDetails.DataBind();
                }
                gvOrderDetails.Visible = true;
                TabPanel3.Visible = true;
                divPatientandorder.Attributes.Add("style", "display:block");
divErrorDetails.Attributes.Add("style", "display:block");
            }
            else
            {
                TabPanel3.Visible = false;
                //divPatientandorder.Visible = false;
                gvOrderDetails.Visible = false;
                //divPatientandorder.Attributes.Add("style", "display:none");
                divErrorDetails.Attributes.Add("style", "display:none");
            }
		ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt", "javascript:CalculateHeight();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in HL7 Messages View at FetchHL7HealthLabDataDetail", ex);
        }
    }
    #endregion



}
