using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using System.Drawing;
using System.Drawing.Imaging;

using PdfSharp.Drawing;
using PdfSharp.Pdf;
using Attune.Podium.Common;


public partial class SaveScann : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
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
            string pathname = GetConfigValue("TRF_UploadPath", OrgID);
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
            Root = "TRF_Upload" + "-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-" + VisitNumber + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            //ENd///    

                //String[] arrFile = hdnFileValue.Value.Split('^').ToArray();
                //int n = 0;
            String strInfo = HttpContext.Current.Request["UploadedImagesCount"];
             HttpFileCollection files = HttpContext.Current.Request.Files;
              short uploadedImagesCount = Convert.ToInt16(strInfo);
                for (int n = 0; n < uploadedImagesCount; n++)
                {

                    HttpPostedFile uploadfile = files["image_" + n.ToString()];
                    string strImageName = uploadfile.FileName;
              
                        string Picture = System.IO.Path.GetFileNameWithoutExtension(strImageName);
                        string FullName = System.IO.Path.GetFileName(strImageName);
                        string picNameWithoutExt = PID + '_' + VID + '_' + +OrgID;
                        string pictureName = PID + '_' + VID + '_' + OrgID + '_' + Picture;
                        string NotImageFormat = PID + '_' + VID + '_' + OrgID + '_' + FullName;
                        string fileExtension = System.IO.Path.GetExtension(strImageName);
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
                            System.Drawing.Image image = System.Drawing.Image.FromStream(uploadfile.InputStream);
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
                            if (System.IO.Directory.Exists(RootPath))
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
                            returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "TRF_Upload", Root, LID, dt, "Y", 0);
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
                            uploadfile.SaveAs(filePath);
                            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                            int pno = int.Parse(PID.ToString());
                            int Vid = int.Parse(VID.ToString());
                            returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, "TRF_Upload", Root, LID, dt, "Y", 0);
                            //returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, UFilePath,UFilePath+ Root, LID, dt);

                        }


                    }

                
        
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while upload TRF using Uploader Control in Visit search", ex);
        }
    }
}
