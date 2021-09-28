<%@ WebHandler Language="C#" Class="FileHandlerforQMS" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;
using Attune.Solution.QMSBusinessEntities;
using Attune.Solution.QMSBusinessLogic;
using Attune.Podium.Common;
using System.Web.SessionState;


public class FileHandlerforQMS : IHttpHandler, IRequiresSessionState
{
    static string FilesSavePath = string.Empty;
    static string fname = string.Empty;
    
    public void ProcessRequest (HttpContext context) {

        List<QMS_TRFfilemanager> lstFM = new List<QMS_TRFfilemanager>();

        try
        {
            int count = context.Request.Files.Count;
            if (count > 0)
            {

                HttpFileCollection files = context.Request.Files;
                string FileName = "";
                for (int i = 0; i < count; i++)
                {
                    QMS_TRFfilemanager objTRf = new QMS_TRFfilemanager();
                    string FName = "";
                    HttpPostedFile file = files[i];
                    string text = files.AllKeys[i];
                    string[] sarray = text.Split('~');
                    string FilePath = sarray[0];
                    string innerPath = "";
                    string IsDelete = "";
                    for (int j = 0; j < sarray.Length; j++)
                    {
                        if (j == 4)
                        {
                            IsDelete = sarray[j];
                        }
                        else if (j != 0)
                        {
                            if (sarray[j] != null && sarray[j] != "")
                            {
                                innerPath += "\\" + sarray[j];
                            }
                        }

                    }
                    string fileNameOnly = Path.GetFileNameWithoutExtension(file.FileName);
                    string extension = Path.GetExtension(file.FileName);
                    string name = fileNameOnly + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + extension;
                    string newFullPath = FName;

                    objTRf.FileName = file.FileName;
                    objTRf.FilePath = innerPath + "\\" + name;
                    objTRf.FileType = sarray[2];
                    objTRf.IdentifyingID = sarray[3];
                    objTRf.IdentifyingType = sarray[1];
                    objTRf.IsDelete = "N";


                    if (!Directory.Exists(FilePath + innerPath))
                    {
                        Directory.CreateDirectory(FilePath + innerPath);
                    }

                    if (!File.Exists(FilePath + innerPath + '\\' + name))
                    {
                        file.SaveAs(FilePath + innerPath + '\\' + name);
                        context.Response.ContentType = "text/plain";
                    }


                    lstFM.Add(objTRf);
                }
                Filemanager_BL objFIleManager = new Filemanager_BL(new Attune.Solution.QMSBasecClassConvert.QMS_Integration(new BaseClass().ContextInfo).returnContext);
                if (lstFM.Count > 0)
                {
                    objFIleManager.SaveFile_BL(lstFM);
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