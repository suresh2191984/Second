<%@ WebHandler Language="C#" Class="ViewCameraImage" %>

using System;
using System.Web;
using System.Net;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Configuration;
using Attune.Kernel.PlatForm.Utility;
public class ViewCameraImage : IHttpHandler
{
    
    public void ProcessRequest (HttpContext context) {
        string filePath = string.Empty;
        try
        {
            if (context.Request.QueryString["FileName"] != null)
            {
                filePath = context.Request.QueryString["FileName"];
                Image image = Image.FromFile(filePath);

                context.Response.ContentType = "Image/jpeg";
                image.Save(context.Response.OutputStream, ImageFormat.Jpeg);
                image.Dispose();
            }           
            else
            {
                throw new ArgumentException("No Parameters Specified");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientRegistration: PatientImageHandler ", ex);
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}