<%@ WebHandler Language="C#" Class="DownloadFile" %>

using System;
using System.Web;
using System.Collections.Generic;

public class DownloadFile : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        
        string sPath = string.Empty;
        //sPath = GetConfigValue("RateDocumentUpload", Convert.ToInt16(context.Request.QueryString["OrgID"]));
        sPath = context.Request.QueryString["Filepath"].ToString();
        string file = "";

        // get the file name from the querystring
        if (context.Request.QueryString["Filename"] != null)
        {
            file = context.Request.QueryString["Filename"].ToString();
        }
        string filename = sPath + "\\" + file;
        //   string filename = context.Server.MapPath(file);
        System.IO.FileInfo fileInfo = new System.IO.FileInfo(filename);

        try
        {
            if (fileInfo.Exists)
            {
                context.Response.Clear();
                context.Response.AddHeader("Content-Disposition", "attachment;filename=\"" + fileInfo.Name + "\"");
                context.Response.AddHeader("Content-Length", fileInfo.Length.ToString());
                context.Response.ContentType = "application/octet-stream";
                context.Response.TransmitFile(fileInfo.FullName);
                context.Response.Flush();
            }
            else
            {
                throw new Exception("File not found");
            }
        }
        catch (Exception ex)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write(ex.Message);
        }
        finally
        {
            context.Response.End();
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}