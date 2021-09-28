<%@ WebHandler Language="C#" Class="ClientBatchMaster" %>
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

public class ClientBatchMaster : IHttpHandler
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
                    pathname = GetConfigValue("ClientBatchMasterPDF", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                    filePath = pathname + context.Request.QueryString["PictureName"];
                    if (!System.IO.File.Exists(filePath))
                    {
                        pathname = GetConfigValue("OLD_TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                    }
                    else
                    {
                        pathname = GetConfigValue("ClientBatchMasterPDF", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                    }
                    //filePath = ConfigurationManager.AppSettings["UploadPath"] + pathname + context.Request.QueryString["PictureName"];
                    filePath = pathname + context.Request.QueryString["PictureName"];
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
                            fileExtension = Path.GetExtension(filePath);//---Code add by stalin
                            byte[] byteArray1 = File.ReadAllBytes(filePath);
                            context.Response.Clear();
                            context.Response.ClearContent();//---Code add by stalin
                            context.Response.ContentType = ReturnExtension(fileExtension.ToLower());
                            //context.Response.BinaryWrite(byteArray1);
                            context.Response.WriteFile(filePath);//---Code add by stalin
                            //context.Response.Flush();
                            // context.Response.Close();
                           // context.Response.End();
                            //byte[] byteArray = File.ReadAllBytes(filePath);
                            //context.Response.Clear();
                            //context.Response.ContentType = ReturnExtension(fileExtension.ToLower());
                            //context.Response.BinaryWrite(byteArray);
                            //context.Response.Flush();
                            //context.Response.Close();
                            //context.Response.End();

                        }
                    }
                }
                else
                {
                    filePath = context.Request.QueryString["PdfFilePath"];
                    fileExtension = Path.GetExtension(filePath);//---Code add by stalin
                    byte[] byteArray1 = File.ReadAllBytes(filePath);
                    context.Response.Clear();
                    context.Response.ClearContent();//---Code add by stalin
                    context.Response.ContentType = ReturnExtension(fileExtension.ToLower());
                    //context.Response.BinaryWrite(byteArray1);
                    context.Response.WriteFile(filePath);//---Code add by stalin
                    //context.Response.Flush();
                   // context.Response.Close();
                    context.Response.End();

                }
            }
            else if (context.Request.QueryString["PDFName"] != null)
            {
               
                
                pathname = GetConfigValue("TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                filePath = pathname + context.Request.QueryString["PDFName"];
                fileExtension = Path.GetExtension(context.Request.QueryString["PDFName"]);
                byte[] byteArray1 = File.ReadAllBytes(filePath);
                context.Response.Clear();
                
                context.Response.ContentType = ReturnExtension(fileExtension.ToLower());
                context.Response.BinaryWrite(byteArray1);
                context.Response.Flush();
                context.Response.Close();
                //context.Response.End();
            }
            else if (context.Request.QueryString["Type"] != null)
            {

                String FilePath = GetConfigValue("TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["POrgID"])) + "MultiUploadDocu" + "\\";
                FilePath = FilePath + context.Request.QueryString["FileURL"];
                string FileName = context.Request.QueryString["FileURL"];
                string FormatedFileName = context.Request.QueryString["FileName"];
                System.Web.HttpResponse response = System.Web.HttpContext.Current.Response;
                response.ClearContent();
                response.Clear();
                response.ContentType = "text/plain";
                response.AddHeader("Content-Disposition", "attachment; filename=" + FormatedFileName + ";");
                response.TransmitFile(FilePath);
                response.Flush();
               response.End();
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