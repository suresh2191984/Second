<%@ WebHandler Language="C#" Class="DeviceFiles" %>

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Globalization;
using System.Web.SessionState;
using Attune.Podium.BusinessEntities;
using System.Web.Script.Serialization;
public class DeviceFiles : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request.Files.Count > 0)
        {
            //string strJson = new StreamReader(context.Request["SaveAnalyzer"]).ReadToEnd();

            ////deserialize the object
            //InvInstrumentMaster objUsr = Deserialize<InvInstrumentMaster>(strJson);
            int i = 0;
            HttpFileCollection files = context.Request.Files;
            int roleID = Convert.ToInt32(files.AllKeys[1]);
            int orgID = Convert.ToInt32(files.AllKeys[2]);
            String SaveAnalyzer = files.AllKeys[3];
            DateTime MaintenanceDoneDate = Convert.ToDateTime(files.AllKeys[4]);
            DateTime MaintenanceDueDate =Convert.ToDateTime( files.AllKeys[5]);
            DateTime CalibrationDoneDate =Convert.ToDateTime( files.AllKeys[6]);
            DateTime CalibrationDueDate = Convert.ToDateTime(files.AllKeys[7]);
            HttpPostedFile file = files[i];
            string filename = file.FileName;
            
            //long returncode = -1;
            //int count = 1;
            ////string foldername = context.Server.MapPath(FilesSavePath + ClientName);
            //if (!Directory.Exists(foldername))
            //{
            //    Directory.CreateDirectory(foldername);
            //}
            //string fname = foldername + "\\" + file.FileName;

            //string date = DateTime.Now.ToString("yyyy_MM_dd_HH_mm_ss ", CultureInfo.InvariantCulture);
            //string modifieddate = date.Date.ToString().Replace(":", "_").Replace('-', '_');
            //string fileNameOnly = Path.GetFileNameWithoutExtension(fname);
            //string extension = Path.GetExtension(fname);
            //string path = Path.GetDirectoryName(fname);
            //string newFullPath = fname;
            //string tempFileName = string.Format("{0}_{1}{2}", VendorName, Machinemodel, extension);
            //newFullPath = Path.Combine(path, tempFileName).Replace(@"\", @"\\");
            //// DeviceFiles_BL obj = new DeviceFiles_BL(new BaseUDT().ContextInfo);
            ////returncode = obj.insert_FileDetails(tempFileName, newFullPath, vendorID, VendorModel, ClientID, flag);
            //if (returncode >= 2)
            //{
            //    if (!File.Exists(newFullPath))
            //    {
            //        file.SaveAs(newFullPath);
            //        context.Response.ContentType = "text/plain";
            //        context.Response.Write("File(s) uploaded successfully!");
            //    }
            //    else
            //    {
            //        string date = DateTime.Now.ToString("yyyy_MM_dd_HH_mm_ss ", CultureInfo.InvariantCulture);
            //        tempFileName = string.Format("{0}_{1}_{2}{3}", VendorName, Machinemodel, date, extension);
            //        newFullPath = Path.Combine(path, tempFileName).Replace(@"\", @"\\");
            //        file.SaveAs(newFullPath);
            //        context.Response.ContentType = "text/plain";
            //        context.Response.Write("File(s) uploaded successfully!");

            //    }
            //}
            //else
            //{
            //    flag = "U";
            //    context.Response.ContentType = "text/plain";
            //    context.Response.Write("File Already exists for this machine!Do you want to override?");
            //}

        }



        else
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("File already exists!Do you want to upload again?");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public T Deserialize<T>(string context)
    {
        string jsonData = context;

        //cast to specified objectType
        var obj = (T)new JavaScriptSerializer().Deserialize<T>(jsonData);
        return obj;
    }

}