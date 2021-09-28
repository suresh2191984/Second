<%@ WebHandler Language="C#" Class="QChandler" %>
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

public class QChandler : IHttpHandler
{
    public void ProcessRequest(HttpContext context)
    {
        string filePath = string.Empty;
        try
        {
            string pathname = string.Empty;
            string file = string.Empty;
            string fileExtension = string.Empty;
            string filename = string.Empty;
            if (context.Request.QueryString["PictureName"] != null)
            {
                if (context.Request.QueryString["PictureName"] != "StationaryPdf")
                {
                   
                                        
                    //filePath = ConfigurationManager.AppSettings["UploadPath"] + pathname + context.Request.QueryString["PictureName"];
                    filePath = context.Request.QueryString["PictureName"];
                    file = Path.GetFileNameWithoutExtension(context.Request.QueryString["PictureName"]);
                    fileExtension = Path.GetExtension(filePath);
                    filename = file + fileExtension;
                    string imageExtension = ".GIF,.JPG,.JPEG,.PNG,.TIF,.TIFF,.BMP,.PSD";
                    if (File.Exists(filePath))
                    {
                        if (imageExtension.Contains(fileExtension.ToUpper()))
                        {
                            Image image = Image.FromFile(filePath);
                            context.Response.ContentType = "Image/jpeg";
                            image.Save(context.Response.OutputStream, ImageFormat.Jpeg);
                            image.Dispose();
                        }
                        else
                        {
                            byte[] byteArray = File.ReadAllBytes(filePath);
                            context.Response.Clear();
                            context.Response.ContentType = ReturnExtension(fileExtension.ToLower());
                            context.Response.BinaryWrite(byteArray);
                            context.Response.Flush();
                            context.Response.Close();
                            context.Response.End();

                        }
                    }
                }
                else
                {
                    filePath = context.Request.QueryString["PdfFilePath"];
                    if (File.Exists(filePath))
                    {
                        byte[] byteArray1 = File.ReadAllBytes(filePath);
                        context.Response.Clear();
                        context.Response.ContentType = ReturnExtension(fileExtension.ToLower());
                        context.Response.BinaryWrite(byteArray1);
                        context.Response.Flush();
                        context.Response.Close();
                        context.Response.End();
                    }

                }
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
    private string ReturnExtension(string fileExtension)
    {
        switch (fileExtension)
        {
            case ".htm":
            case ".html":
            case ".log":
                return "text/HTML";
            case ".txt":
                return "text/plain";
            case ".doc":
                return "application/ms-word";
            case ".tiff":
            case ".tif":
                return "image/tiff";
            case ".asf":
                return "video/x-ms-asf";
            case ".avi":
                return "video/avi";
            case ".zip":
                return "application/zip";
            case ".xls":
            case ".csv":
                return "application/vnd.ms-excel";
            case ".gif":
                return "image/gif";
            case ".jpg":
            case "jpeg":
                return "image/jpeg";
            case ".bmp":
                return "image/bmp";
            case ".wav":
                return "audio/wav";
            case ".mp3":
                return "audio/mpeg3";
            case ".mpg":
            case "mpeg":
                return "video/mpeg";
            case ".rtf":
                return "application/rtf";
            case ".asp":
                return "text/asp";
            case ".pdf":
                return "application/pdf";
            case ".fdf":
                return "application/vnd.fdf";
            case ".ppt":
                return "application/mspowerpoint";
            case ".dwg":
                return "image/vnd.dwg";
            case ".msg":
                return "application/msoutlook";
            case ".xml":
            case ".sdxl":
                return "application/xml";
            case ".xdp":
                return "application/vnd.adobe.xdp+xml";
            default:
                return "application/octet-stream";
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
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}