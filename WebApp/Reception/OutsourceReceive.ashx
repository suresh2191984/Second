<%@ WebHandler Language="C#" Class="OutsourceReceive" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using Attune.Podium.Common;
using System.Web.SessionState;
using Attune.Solution.BusinessComponent;
using System.Drawing;
using System.Drawing.Imaging;
using PdfSharp;
using PdfSharp.Pdf;
using PdfSharp.Drawing;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Data;
using Attune.Podium.TrustedOrg;
using Attune.Podium.FileUpload;





public class OutsourceReceive : IHttpHandler,IRequiresSessionState
{
    static string FilesSavePath = string.Empty;
    static string fname = string.Empty;
    
    public void ProcessRequest (HttpContext context) {

      //  List<TRFfilemanager> lstFM = new List<TRFfilemanager>();
       

        try
        {
            int count = context.Request.Files.Count;
            if (count > 0)
            {

                HttpFileCollection files = context.Request.Files;
               // string FileName = "";
                for (int i = 0; i < count; i++)
                {
                  //  QMS_TRFfilemanager objTRf = new QMS_TRFfilemanager();
                   // string FName = "";
                    HttpPostedFile file = files[i];
                    string text = files.AllKeys[i];
                    string[] sarray = text.Split('~');
                    string FilePath = sarray[0];
                    int pno =Convert.ToInt32(sarray[7]);
                    int Vid = Convert.ToInt32(sarray[0]);
                    int accessionno=Convert.ToInt32(sarray[6]);
                   

                    DateTime dt = new DateTime();
                    dt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                    int Year = dt.Year;
                    int Month = dt.Month;
                    int Day = dt.Day;
                    
                    
                    String Root = String.Empty;
                    Root = "Outsource_Docs" + "-" + sarray[3] + "-" + Year + "-" + Month + "-" + Day + "-" + sarray[1] + "-";
                    Root = Root.Replace("-", "\\\\");
                    string RootPath = sarray[5] + Root;
                    //Root = sarray[2];
                    int OrgID = Convert.ToInt32(sarray[3]);
                    long LID = Convert.ToInt32(sarray[4]);
                    string Picture = System.IO.Path.GetFileNameWithoutExtension(file.FileName);
                    string FullName = System.IO.Path.GetFileName(file.FileName);
                    //string picNameWithoutExt = pno + '_' + Vid + '_' + OrgID;
                    string pictureName = pno + "_" + Vid + "_" + OrgID + "_" + Picture;
                    string NotImageFormat = pno + "_" + Vid + "_" + OrgID + "_" + FullName;
                    string fileExtension = System.IO.Path.GetExtension(file.FileName);
                    //string filePath = imagePath + NotImageFormat;
                    string filePath = RootPath + NotImageFormat;
                    if (!System.IO.Directory.Exists(RootPath))
                    {
                        System.IO.Directory.CreateDirectory(RootPath);
                    }
                   // context.Response.OutputStream.Flush();

                            string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                            if (imageExtension.Contains(fileExtension.ToUpper()))
                            {
                                pictureName = pictureName + ".jpg";

                                //filePath = imagePath + pictureName;
                                filePath = RootPath + pictureName;

                                int thumbWidth = 640, thumbHeight = 480;
                                System.Drawing.Image image = System.Drawing.Image.FromStream( file.InputStream);
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



                                if (System.IO.Directory.Exists(RootPath))
                                {
                                    bmp.Save(filePath, ImageFormat.Jpeg);
                                }
                                
                                gr.Dispose();
                                bmp.Dispose();
                                //image.Dispose();
                                Patient_BL patientBL = new Patient_BL();

                                // returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, UFilePath, UFilePath + Root, LID, dt);
                                long returncode = patientBL.SaveTRFDetails(pictureName, pno, Vid, OrgID, 0, "Outsource_Docs", Root, LID, dt, "Y",accessionno);
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
                                //string AlertMesg = "File Uploaded Successfully";
                                
                               

                            }
                            else
                            {
                                file.SaveAs(filePath);

                                Patient_BL patientBL = new Patient_BL();

                                long returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, "Outsource_Docs", Root, LID, dt, "Y",accessionno);
                                //returncode = patientBL.SaveTRFDetails(NotImageFormat, pno, Vid, OrgID, 0, UFilePath,UFilePath+ Root, LID, dt);
                                //string AlertMesg = "File Uploaded Successfully";
                                //ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", "alert('" + AlertMesg + "');", true);
                            }
                    
                    
                   
                   
                   
                  
                   
                }
                
             
                   
                   



            }
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error in filehandler_QMS", ex);
        }
            
           
        }
    
 
   
    
    
    
    public bool IsReusable {
        get {
            return false;
        }
    }

}