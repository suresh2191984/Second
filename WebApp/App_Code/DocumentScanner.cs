using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for DocumentScanner
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
 
public class DocumentScanner : System.Web.Services.WebService
{

    public DocumentScanner()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public void UploadFile(string fileName, byte[] bytes)
    {
         
        string filePath = Server.MapPath(string.Format("~/Uploaded/{0}", fileName));
        File.WriteAllBytes(filePath, bytes);
    }


    [WebMethod]
    public void DeleteFile(string fileName)
    {

        string filePath = Server.MapPath(string.Format("~/Uploaded/{0}", fileName));
        if(File.Exists(filePath))
        {
            File.Delete(filePath);
        }
    }

    [WebMethod]
    public bool CheckFile(string fileName)
    {
        string filePath = Server.MapPath(string.Format("~/Uploaded/{0}", fileName));
        return File.Exists(filePath);
        
    }


}
