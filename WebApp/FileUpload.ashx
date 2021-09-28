<%@ WebHandler Language="C#" Class="FileUpload" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
public class FileUpload : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string sPath = string.Empty;
        string Filename = "";

        //sPath = GetConfigValue("RateDocumentUpload", Convert.ToInt16(context.Request.QueryString["OrgID"]));
        sPath = context.Request.QueryString["Filepath"].ToString();
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            for (int i = 0; i < files.Count; i++)
            {
                HttpPostedFile file = files[i];
                string fname;
                if (HttpContext.Current.Request.Browser.Browser.ToUpper() == "IE" || HttpContext.Current.Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                {
                    string[] testfiles = file.FileName.Split(new char[] { '\\' });
                    fname = testfiles[testfiles.Length - 1];
                }
                else
                {
                    fname = file.FileName;
                }

                // get the file name from the querystring
                if (context.Request.QueryString["Filename"] != null)
                {
                    Filename = context.Request.QueryString["Filename"].ToString();

                    fname = Path.Combine(sPath, Filename);
                    if (!Directory.Exists(sPath))
                    {
                        Directory.CreateDirectory(sPath);
                    }
                    file.SaveAs(fname);
                }
                else
                {
                    fname = Path.Combine(sPath, fname);
                    if (!Directory.Exists(sPath))
                    {
                        Directory.CreateDirectory(sPath);
                    }
                    file.SaveAs(fname);
                }
            }
            context.Response.ContentType = "text/plain";
            context.Response.Write("File Uploaded Successfully!");
        }
        else
        {
            context.Response.Write("Please add file");

        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}