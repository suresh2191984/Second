<%@ WebHandler Language="C#" Class="CameraImage" %>
using System;
using System.Web;
using System.Net;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Configuration;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using System.Web.SessionState;

public class CameraImage : IHttpHandler,IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            //string FileFolder = ConfigurationManager.AppSettings["TempPatientPhotoPath"];
            
            //if (!Directory.Exists(FileFolder))
            //{
            //    Directory.CreateDirectory(FileFolder);
            //}
            string pathname = GetConfigValue("TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["OrgID"]));
            StreamReader reader = new StreamReader(HttpContext.Current.Request.InputStream);
            string Data = HttpContext.Current.Server.HtmlEncode(reader.ReadToEnd());
            reader.Close();

            string LoginID = context.Request.QueryString["LoginID"]; 
            DateTime dt = new DateTime();
            dt = Convert.ToDateTime(DateTime.Now);
            //string date = dt.ToString("yyyymmddMMss"); 
            int Year=dt.Year;
            int Month=dt.Month;
            int Day=dt.Day;
            int Hour=dt.Hour;
            int Minute=dt.Minute;
            int Secound=dt.Second; 
            String Root = String.Empty;
            String RootPath = String.Empty;
            //Root = ATTUNE_UPLOAD_FILES\TRF_Upload\ + OrgID + '\' + Year + '\' + Month + '\' + Day + '/' + Visitnumber ;
            Root = "TRF_Upload-" + Convert.ToInt16(context.Request.QueryString["OrgID"]) + "-" + Year + "-" + Month + "-" + Day + "-" + "WebCamera" + "-";
            Root = Root.Replace("-", "\\\\");
            RootPath = pathname + Root;
            if(!Directory.Exists(RootPath))
            {
                Directory.CreateDirectory(RootPath);
            }
            
            //string imgaeName = string.Concat(loginId,"_",orgid, Year , Month , Day , Hour , Minute , Secound , ".jpg");
            string imgaeName = string.Concat(LoginID, "_", Year, Month, Day, Hour, Minute, Secound, ".jpg"); 
            string ImagePath = Path.Combine(RootPath, imgaeName);
            
            //HttpContext.Current.Session["ImagePathName"] = (string)ImagePath.ToString();
            //if (HttpContext.Current.Session["ImagePathName"] != null)
            //{ 
            //    HttpContext.Current.Session["MultipleImage"] = (string)context.Session["ImagePathName"];
            //}
            //if (context.Session["MultipleImage"] != null)
            //{
            //    HttpContext.Current.Session["MultipleImage"] += (string)context.Session["MultipleImage"].ToString() + ",";
            //    HttpContext.Current.Session["ImagePathName"] = null;
            //}


            drawimg(Data.Replace("imgBase64=data:image/png;base64,", String.Empty).Replace("data:image/png;base64,", string.Empty)
                .Replace("data%3aimage%2fpng%3bbase64%", string.Empty), ImagePath);

            context.Response.ContentType = "text/plain";
            context.Response.Write(ImagePath);

            // Image Re-sizing
            byte[] bytestream = null; 
            if (File.Exists(ImagePath))
            {
              bytestream =  File.ReadAllBytes(ImagePath);
            }
            MemoryStream ms = new MemoryStream(bytestream);
            int thumbWidth = 640, thumbHeight = 510;
            System.Drawing.Image image = System.Drawing.Image.FromStream(ms);
            int srcWidth = image.Width;
            int srcHeight = image.Height;
            if (thumbWidth < srcWidth)
            {
                thumbWidth = 640;
            }
            if (thumbHeight < srcHeight)
            {
                thumbHeight = 510;
            }
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
                bmp.Save(ImagePath, ImageFormat.Jpeg);
            } 
            gr.Dispose();
            bmp.Dispose();
            image.Dispose();
            //
            
             
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Capture Image.: Captureimage Handler ", ex);
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
    public void drawimg(string base64, string filename)  // Drawing image from Base64 string.
    {
        using (FileStream fs = new FileStream(filename, FileMode.OpenOrCreate, FileAccess.Write))
        {
            using (BinaryWriter bw = new BinaryWriter(fs))
            {
                byte[] data = Convert.FromBase64String(base64);// Convert.FromBase64String(base64);
                bw.Write(data);
                bw.Close();
            }
        }
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay();
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
}