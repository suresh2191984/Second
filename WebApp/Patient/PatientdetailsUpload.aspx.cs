using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using System.Drawing;
using System.Drawing.Imaging;
using Attune.Podium.FileUpload;
using PdfSharp;
using PdfSharp.Pdf;
using PdfSharp.Drawing;
using System.IO;
using System.Net;

public partial class Patient_PatientdetailsUpload : BasePage
{

    public Patient_PatientdetailsUpload()
        : base("Patient_PatientdetailsUpload_aspx")
    {
    }

   
    List<TRFfilemanager> lstTRFFilemanager = new List<TRFfilemanager>();

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    string pathname = string.Empty;
    long returnCode = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ViewState["PreviousPage"] = Request.UrlReferrer.ToString().Replace("?Ispopup=Y", ""); ;
            UploadedDetails();
            LoadTRFimagedetails();
        } 

    }
    public void LoadTRFimagedetails()
    {
        try
        {
            long returncode = -1;
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
            List<TRFfilemanager> lstTRF = new List<TRFfilemanager>();
            string pathname = String.Empty;
            int patientid = 0;
            int visitid = 0;
            string Type = "";
            string VisitID = String.Empty;
            string VisitNumber = String.Empty;
            string filepath = String.Empty;
            ifDisplayPdf.Visible = false;// Hide the Iframe
            if (Request.QueryString["pid"] != null && Request.QueryString["pid"] != "")
            {
                patientid = Convert.ToInt32(Request.QueryString["pid"]);
            }
            if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "")
            {
                visitid = Convert.ToInt32(Request.QueryString["vid"]);
            }
            new Patient_BL(base.ContextInfo).GetPatientVisitNumber(patientid, out VisitID, out VisitNumber);
            returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientid, visitid, OrgID, Type, out lstFiles);
            if (lstFiles.Count > 0)
            {
                lstTRF = lstFiles.FindAll(P => P.IdentifyingType == "TRF_Upload");
            } 
            if (lstTRF.Count > 0)
            {
                for (int i = 0; i < lstTRF.Count; i++)
                {
                    lstTRF[i].FileUrl = lstTRF[i].FileName;
                    lstTRF[i].RefID = VisitNumber;// 
                    lstTRF[i].VisitID = visitid;// 
                    lstTRF[i].PatientID = patientid;// 
                    lstTRF[i].FileName = Path.GetFileName(lstTRF[i].FileName); 
                    grdviewTRF.DataSource = lstTRF;
                    grdviewTRF.DataBind();
                    //ifDisplayPdf.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + filepath + "&OrgID=" + OrgID);  
                }
            }
            else if (lstTRF.Count == 0)
            {
                grdviewTRF.DataSource = null;
                grdviewTRF.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Load TRF image details in Visit search", ex);
        }
    } 
    public void UploadedDetails()
    {
        long PatientID = 0;
        long visitID = 0;
        string pathname = string.Empty;
        string PictureName = string.Empty;
        string Type = "Outsource_Docs";
        if (Request.QueryString["pid"] != null && Request.QueryString["pid"] != "")
        {
            PatientID = Convert.ToInt64(Request.QueryString["pid"]);
        }
        if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "")
        {
            visitID =Convert.ToInt64(Request.QueryString["vid"]);
        }
        long ReturnCode = -1;
        List<TRFfilemanager> lstTRf = new List<TRFfilemanager>();
        pathname = GetConfigValue("TRF_UploadPath", OrgID);

       

        Master_BL MBL = new Master_BL(base.ContextInfo);

        ReturnCode = MBL.GetOutsourceDocDetails(PatientID, visitID, OrgID, Type, out lstTRf);

        if (lstTRf.Count > 0)
        {
          pnlParent.Attributes.Add("style", "block");
            chkDocs.DataSource = lstTRf;
            chkDocs.DataTextField = "FileName";
            chkDocs.DataValueField = "FileID";
            chkDocs.DataBind();
            chkDocs.Visible = true;
            chkDocAll.Visible = true;
        }
        else
        {
            pnlParent.Attributes.Add("style", "display:none");
        }

    }
    protected void PatientFileUploader_Click(object sender,PatientFileUploadCollectionEventArgs e)
    {
        try
        {
            Patient_BL Patient_BL = new Patient_BL(base.ContextInfo);
            string PID = "0";
            string VID = "0";
            if (Request.QueryString["pid"] != null && Request.QueryString["pid"] != "")
            {
                PID = Request.QueryString["pid"];
            }
            if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "")
            {
                VID = Request.QueryString["vid"];
            }
            long returncode = -1;
            pathname = GetConfigValue("TRF_UploadPath", OrgID);
            string VisitID = string.Empty;
            String VisitNumber = String.Empty;

        new Patient_BL(base.ContextInfo).GetPatientVisitNumber(Convert.ToInt64(PID), out VisitID, out VisitNumber);

         
        //Modified / By Arivalagan K//
        DateTime dt = new DateTime();
        dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        int Year = dt.Year;
        int Month = dt.Month;
        int Day = dt.Day;
        //Root Path =D:\ATTUNE_UPLOAD_FILES\TRF_Upload\67\2013\10\9\123456\14_A.pdf
        String Root = String.Empty;
        String RootPath = String.Empty;
        //String UFilePath=String.Empty;
        //String[] UFname;


        //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
        Root =hdnFileType.Value+"-"+OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
        Root = Root.Replace("-", "\\\\");
        RootPath = pathname + Root;
        //ENd///    
        HttpFileCollection oHttpFileCollection = e.PostedFiles;
        HttpPostedFile oHttpPostedFile = null;
        if (e.HasFiles)
        {
            //String[] arrFile = hdnFileValue.Value.Split('^').ToArray();
            //int n = 0;
            for (int n = 0; n < e.Count; n++)
            {
                //if (arrFile[n] != "") {
                //    UFname = arrFile[n].Split('~').ToArray();
                //    if (UFname[1]!= "")
                //    {
                //        UFilePath = Convert.ToString(UFname[1]);
                //    }
                //}
                //RootPath = pathname + UFilePath + Root;

                oHttpPostedFile = oHttpFileCollection[n];
                if (oHttpPostedFile.ContentLength <= 0)
                    continue;
                else
                {
                    // oHttpPostedFile.SaveAs(pathname + System.IO.Path.GetFileName(oHttpPostedFile.FileName));


                    //string imagePath = pathname;
                    string Picture = System.IO.Path.GetFileNameWithoutExtension(oHttpPostedFile.FileName);
                    string FullName = System.IO.Path.GetFileName(oHttpPostedFile.FileName);
                    string picNameWithoutExt = PID + '_' + VID + '_' + +OrgID;
                    string pictureName = PID + '_' + VID + '_' + OrgID + '_' + Picture;
                    string NotImageFormat = PID + '_' + VID + '_' + OrgID + '_' + FullName;
                    string fileExtension = System.IO.Path.GetExtension(oHttpPostedFile.FileName);
                    //string filePath = imagePath + NotImageFormat;
                    string filePath = RootPath + NotImageFormat;
                    if (!System.IO.Directory.Exists(RootPath))
                    {
                        System.IO.Directory.CreateDirectory(RootPath);
                    }
                    Response.OutputStream.Flush();

                    string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                    if (imageExtension.Contains(fileExtension.ToUpper()))
                    {
                        pictureName = pictureName + ".jpg";

                        //filePath = imagePath + pictureName;
                        filePath = RootPath + pictureName;

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
                        if(System.IO.Directory.Exists(RootPath))
                        {
                            bmp.Save(filePath, ImageFormat.Jpeg);
                        }
                        gr.Dispose();
                        bmp.Dispose();
                        image.Dispose();
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(PID.ToString());
                        int Vid = int.Parse(VID.ToString());
                        // returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, UFilePath, UFilePath + Root, LID, dt);
                        returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, hdnFileType.Value, Root, LID, dt,"Y",0);
                        string source = filePath;
                        string destinaton = filePath.Replace(".jpg", ".pdf");

                        PdfDocument doc = new PdfDocument();
                        doc.Pages.Add(new PdfPage());
                        XGraphics xgr = XGraphics.FromPdfPage(doc.Pages[0]);
                        XImage img = XImage.FromFile(source);
                        doc.Pages[0].Width = XUnit.FromPoint(img.Size.Width);

                        doc.Pages[0].Height = XUnit.FromPoint(img.Size.Height);

                        xgr.DrawImage(img, 0, 0, img.Size.Width, img.Size.Height);

                        //xgr.DrawImage(img, 0, 0, img.Size.Width, img.Size.Height);
                        doc.ViewerPreferences.FitWindow = true;

                        doc.Options.NoCompression = true;
                        //oHttpPostedFile.SaveAs(filePath);
                        doc.Save(destinaton);
                    }
                    else
                    {
                        oHttpPostedFile.SaveAs(filePath);
                        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                        int pno = int.Parse(PID.ToString());
                        int Vid = int.Parse(VID.ToString());
                        returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, hdnFileType.Value, Root, LID, dt,"Y",0);
                        //returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, UFilePath,UFilePath+ Root, LID, dt);

                    }

                    if (returncode >= 0)
                    {
                        string PageUrl = string.Empty;
                        string AlertMesg = "File Uploaded Successfully";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');", true);
                        UploadedDetails();
                            LoadTRFimagedetails();
                    }
                }

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while upload TRF using Uploader Control in Visit search", ex);
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
    protected void btdGoBack_Click(object sender, EventArgs e)
    {
        if (ViewState["PreviousPage"] != null)	 
        {
            Response.Redirect(ViewState["PreviousPage"].ToString() + "?Ispopup=Y");
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        long ReturnCode = -1;
        long PatientID = 0;
        long visitID = 0;
        String pathname = string.Empty;
        String PictureName = string.Empty;
        String VisitID = string.Empty;
        String FilePath = String.Empty;
        String OrgDate = OrgDateTimeZone;


        pathname = GetConfigValue("TRF_UploadPath", OrgID);
        if (Request.QueryString["pid"] != null && Request.QueryString["pid"] != "")
        {
            PatientID = Convert.ToInt64(Request.QueryString["pid"]);
        }
        if (Request.QueryString["vid"] != null && Request.QueryString["vid"] != "")
        {
            visitID = Convert.ToInt64(Request.QueryString["vid"]);
            VisitID = Request.QueryString["vid"];
        }
        new Patient_BL(base.ContextInfo).GetPatientFileFath(PatientID, VisitID, out FilePath);
        Master_BL MBL = new Master_BL(base.ContextInfo);
        foreach (ListItem lst in chkDocs.Items)
        {
            if (lst.Selected)
            {
                TRFfilemanager trf = new TRFfilemanager();
                trf.FileID = Convert.ToInt32(lst.Value);
                trf.FileName = lst.Text;
                trf.PatientID = PatientID;
                trf.VisitID = visitID;
                trf.OrgID = OrgID;
                trf.Createdat = Convert.ToDateTime(OrgDate);
                trf.IdentifyingID = 0;
                trf.IdentifyingType = "Outsource_Docs";
                trf.Isactive = "N";
                lstTRFFilemanager.Add(trf);

                //if (File.Exists(pathname + FilePath + lst.Text))
                //{
                //    PictureName = pathname + FilePath + lst.Text;
                //    File.Delete(PictureName);

                //}
            }
        }

        ReturnCode = MBL.DeleteOutsourceDocDetails(lstTRFFilemanager);

        if (ReturnCode >= 0)
        {            
            string PageUrl = string.Empty;
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "alert('File Uploaded Successfully');", true);
            string AlertMesg = "Selected Docs Deleted Successfully";
            //if (ViewState["PreviousPage"] != null)
            //{
            //    PageUrl = ViewState["PreviousPage"].ToString() + "?IsPopup=Y";
            //}
            //else
            //{
            //    PageUrl = Request.ApplicationPath + @"/Patient/PatientdetailsUpload.aspx?IsPopup=Y";
            //}
            //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');window.location ='" + PageUrl + "';", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');", true);
            UploadedDetails();
        }

    }
    protected void grdviewTRF_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            try
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string patientID = commandArgs[0];
                string VisitID = commandArgs[1];
                string FileUrl = commandArgs[2];
                HtmlControl frame1 = (HtmlControl)this.FindControl("ifDisplayPdf");
                frame1.Attributes.Add("src", "../Reception/TRFImagehandler.ashx?PictureName=" + FileUrl + "&OrgID=" + OrgID);
                frame1.Visible = true;
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while view TRF Image in Visit Search:", ex);
            }
        }
        if (e.CommandName == "Remove")
        {
            try
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                int patientID = Convert.ToInt32(commandArgs[0]);
                int VisitID = Convert.ToInt32(commandArgs[1]);
                string FileID = string.Concat("Remove", ",", commandArgs[2]);
                long returncode = -1;
                List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
                //This is for Update pupose Not select because not need to write BAL and DAL at all.
                returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientID, VisitID, OrgID, FileID, out lstFiles);
                LoadTRFimagedetails();
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while delete/remove in visit search", ex);
            }
        }
        if (e.CommandName == "Download")
        {
            try
            {
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                int patientID = Convert.ToInt32(commandArgs[0]);
                int VisitID = Convert.ToInt32(commandArgs[1]);
                string FileID = string.Concat("Download", ",", commandArgs[2]);
                long returncode = -1;
                List<TRFfilemanager> lstFiles = new List<TRFfilemanager>();
                //This is for Select purpose because not need to write BAL and DAL at all.
                returncode = new Patient_BL(base.ContextInfo).GetTRFimageDetails(patientID, VisitID, OrgID, FileID, out lstFiles);
                pathname = GetConfigValue("TRF_UploadPath", OrgID);
                if (lstFiles.Count == 1)
                {
                    string GetImagePath = string.Concat(pathname, lstFiles[0].FileName);
                    string AttachmentName = Path.GetFileName(lstFiles[0].FileName);
                    var webClient = new WebClient();
                    byte[] imageBytes = webClient.DownloadData(GetImagePath);
                    Response.Buffer = true;
                    Response.ClearHeaders();
                    Response.ClearContent();
                    Response.ContentType = "image/jpg";
                    Response.AddHeader("Content-Length", imageBytes.Length.ToString());
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + AttachmentName);
                    Response.Flush();
                    Response.BinaryWrite(imageBytes);
                    Response.End();
                }
            }
            catch (Exception Ex)
            {
                CLogger.LogError("Exception while download TRF Image in Visit Search", Ex);
            } 
            
        }
    } 
}
