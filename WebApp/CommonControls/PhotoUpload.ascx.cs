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
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Linq;

public partial class CommonControls_PhotoUpload : BaseControl
{
    //CommonControls_EmployerRegDetail objcntrl;
    string picExtension = string.Empty;

    public CommonControls_PhotoUpload()
        : base("Reception_VisitDetails_aspx")
    {
    }

  

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnadd_Click(object sender, EventArgs e)
    {
        string picExtension = string.Empty;
        bool isSavePicture = false;
        if (IsCorporateOrg != "Y")
        {
            GetPictureExtension(out picExtension, out isSavePicture);
        }
        string EmpTypeNumber = string.Empty;
        if (IsCorporateOrg == "Y")
        {

            if (isSavePicture)
                SavePicture(EmpTypeNumber, picExtension);
        }
        else
        {

            SavePicture(Convert.ToString(hdnPATNO.Value), picExtension);
        }

    }

    private void GetPictureExtension(out string picExtension, out bool isSavePicture)
    {
        picExtension = string.Empty;
        isSavePicture = false;
        if (chkRemovePhoto.Checked)
        {
            isSavePicture = true;
        }
        else if (PhotoUpload.PostedFile != null && PhotoUpload.PostedFile.ContentLength > 0)
        {
            picExtension = ".jpeg";
            isSavePicture = true;
        }
        else
        {
            picExtension = Path.GetExtension(hdnPatientImageName.Value);
        }
    }

    string AlertType = Resources.CommonControls_AppMsg.CommonControls_Header_Alert == null ? "Alert" : Resources.CommonControls_AppMsg.CommonControls_Header_Alert;
    string strPhotoUploadSuccess = Resources.Reception_AppMsg.CommonControls_PhotoUpload_ascx_01 == null ? "Photo Uploaded Successfully" : Resources.Reception_AppMsg.CommonControls_PhotoUpload_ascx_01;
    string strUploadFileType = Resources.Reception_AppMsg.CommonControls_PhotoUpload_ascx_02 == null ? "Please upload this file types only" : Resources.Reception_AppMsg.CommonControls_PhotoUpload_ascx_02;
    private void SavePicture(string number, string picExtension)
    {
        long ReturnCode = -1;
        try
        {
		    //***********Comented by Arivalagan KK For Creating Dynamic Folder Struture*******//
            //string imagePath = ConfigurationManager.AppSettings["PatientPhotoPath"];
            //string picNameWithoutExt = number.Replace('/', '_') + '_' + OrgID;
            //string pictureName = number.Replace('/', '_') + '_' + OrgID + picExtension;
            //string filePath = imagePath + pictureName;

            //Response.OutputStream.Flush();

            //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
            //foreach (string path in fileNames)
            //{
            //    File.Delete(path);
            //}
            if (chkRemovePhoto.Checked)
            {
                imgPatient.Src = "~/Images/ProfileDefault.jpg";
                hdnPatientImageName.Value = string.Empty;
                divRemovePhoto.Style.Add("display", "none");
            }
            else if (PhotoUpload.PostedFile != null && PhotoUpload.PostedFile.ContentLength > 0)
            {

                //Modified / By Arivalagan K//
                String pathname = String.Empty;
                String fileName = Path.GetFileNameWithoutExtension(PhotoUpload.PostedFile.FileName);
                String fileExtension = Path.GetExtension(PhotoUpload.PostedFile.FileName);
                String imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                if (imageExtension.Contains(fileExtension.ToUpper()))
                {
                    pathname = GetConfigValue("TRF_UploadPath", OrgID);
                    Patient_BL BAL = new Patient_BL(base.ContextInfo);
                    int orgid = OrgID;
                    long patientid = Convert.ToUInt32(hdnPATID.Value);
                    DateTime dt = new DateTime();
                    
                    dt = Convert.ToDateTime(OrgDateAndTime);
                    //dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                    int Year = dt.Year;
                    int Month = dt.Month;
                    int Day = dt.Day;

                    //Root Path =:\ATTUNE_UPLOAD_FILES\PatientPhoto_Upload\67\2013\10\9\123456\14_A.pdf

                    String Root = String.Empty;
                    String RootPath = String.Empty;
                    String filePath = String.Empty;

                    String VisitID = string.Empty;
                    String VisitNumber = String.Empty;

                    new Patient_BL(base.ContextInfo).GetPatientVisitNumber(patientid, out VisitID, out VisitNumber);


                    //Root = ATTUNE_UPLOAD_FILES\Patient_PhotoUpload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
                    Root = "Patinet_Images-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
                    Root = Root.Replace("-", "\\\\");
                    RootPath = pathname + Root;
                    //ENd///

                    // string imagePath = ConfigurationManager.AppSettings["PatientPhotoPath"];
                    string picNameWithoutExt = number.Replace('/', '_') + '_' + OrgID;
                    string pictureName = number.Replace('/', '_') + '_' + OrgID + picExtension;
                    //string filePath = imagePath + pictureName;
                    filePath = RootPath + pictureName;
                    Response.OutputStream.Flush();
                    if (!System.IO.Directory.Exists(RootPath))
                    {
                        System.IO.Directory.CreateDirectory(RootPath);
                    }
                    //string[] fileNames = Directory.GetFiles(imagePath, picNameWithoutExt + ".*");
                    string[] fileNames = Directory.GetFiles(RootPath, picNameWithoutExt + ".*");
                    foreach (string path in fileNames)
                    {
                        File.Delete(path);
                    }
                    int thumbWidth = 130, thumbHeight = 154;
                    System.Drawing.Image image = System.Drawing.Image.FromStream(PhotoUpload.PostedFile.InputStream);
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
                    hdnPatientImageName.Value = pictureName;
                    gr.Dispose();
                    bmp.Dispose();
                    image.Dispose();
                    
                    //ReturnCode = BAL.SavePatientphoto(picExtension, orgid, patientid);
                    ReturnCode = BAL.SavePatientphoto(Root+pictureName, orgid, patientid);
                    if (ReturnCode >= 0)
                    {
                        chkUploadPhoto.Checked = false;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "ValidationWindow('" + strPhotoUploadSuccess.Trim() + "','"+ AlertType +"');", true);
                    }

                }
                else {
                    chkUploadPhoto.Checked = false;
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "add", "ValidationWindow('" + strUploadFileType.Trim() + "(.GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD)','"+ AlertType +"');", true);
                
                }
                
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Unable to upload photo ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in photo upload. Please contact system administrator.";
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

}
