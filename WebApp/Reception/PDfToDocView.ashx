<%@ WebHandler Language="C#" Class="PDfToDocView" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Text;
using System.Net;
using System.IO;
public class PDfToDocView : IHttpHandler {
    long OrgID = 0;
    long LoginID = 0;
    DateTime date = DateTime.Now;
    string url = "";
    public void ProcessRequest (HttpContext context) {
               try
            
        {

            if (context.Request.QueryString["PdfName"] != null)
            {
                OrgID = Convert.ToInt64(context.Request.QueryString["OrgID"]);
                url = Convert.ToString(context.Request.QueryString["url"]);
                date = Convert.ToDateTime(context.Request.QueryString["DateTime"]);
                
                LoginID = Convert.ToInt64(context.Request.QueryString["LoginID"]);

                string[] filename;
                string PDFNAme = context.Request.QueryString["PdfName"].ToString();
                filename = PDFNAme.Split('~');



                byte[] mergedPdf = File.ReadAllBytes("D:\\pdf with image.pdf");
                    //using (System.IO.MemoryStream ms = new System.IO.MemoryStream())
                    //{
                    //    using (iTextSharp.text.Document document = new iTextSharp.text.Document())
                    //    {
                    //        using (iTextSharp.text.pdf.PdfCopy copy = new iTextSharp.text.pdf.PdfCopy(document, ms))
                    //        {
                    //            document.Open();

                    //            for (int i = 0; i <= filename.Length - 1; ++i)
                    //            {
                    //                if (filename[i] != "")
                    //                {
                    //                    iTextSharp.text.pdf.PdfReader reader = new iTextSharp.text.pdf.PdfReader(filename[i]);

                    //                    int n = reader.NumberOfPages;
                    //                    for (int page = 0; page < n; )
                    //                    {
                    //                        copy.AddPage(copy.GetImportedPage(reader, ++page));
                    //                    }
                    //                }
                    //            }
                    //        }
                    //    }
                    //    mergedPdf = ms.ToArray();
                    //}

                    if (mergedPdf.Length > 0)
                    {

                        //string url = url;
                        byte[] requestBuffer = null;
                        string requestJSON;
                        List<allfiles> filearray = new List<allfiles>();
                        List<allfiles> wordfile = new List<allfiles>();
                        //byte[] fromArray = File.ReadAllBytes("D:\\pdf with image.pdf");
                        allfiles objfile = new allfiles();
                        objfile.Filebytes = mergedPdf;
                        objfile.OrgID = OrgID;
                        objfile.LoginID = LoginID;
                        filearray.Add(objfile);

                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        requestJSON = serializer.Serialize(filearray);

                        requestBuffer = Encoding.ASCII.GetBytes(requestJSON);
                        HttpWebRequest webRequest = (HttpWebRequest)WebRequest.Create(url);
                        webRequest.Method = "POST";
                        webRequest.ContentType = "application/JSON";
                        webRequest.ContentLength = requestBuffer.Length;
                        Stream postStream = webRequest.GetRequestStream();
                        postStream.Write(requestBuffer, 0, requestBuffer.Length);
                        postStream.Close();
                        HttpWebResponse webResponse = (HttpWebResponse)webRequest.GetResponse();


                        Stream responseStream = webResponse.GetResponseStream();
                        StreamReader responseReader = new StreamReader(responseStream);
                        string response = responseReader.ReadToEnd();
                        
                        if (webResponse.StatusDescription == "OK")
                        {

                            response = response.Substring(1, response.Length - 2);
                           // response = response.Substring(0, response.Length - 1);
                            byte[] arr = File.ReadAllBytes(response);
                            context.Response.Clear();
                            context.Response.ContentType = "Application/msword";
                            context.Response.AddHeader("content-disposition", "attachment; filename=ClientReport-" + date.ToString("yyyyMMddhhmmtt")+ ".doc");
                            context.Response.BinaryWrite(arr);
                            context.Response.Flush();
                            context.Response.Close();
                            //context.Response.End();
                            context.Response.SuppressContent = true;
                        }
                    }

                   
                
                    
            }
        }
        catch (Exception ex)
        {
            Attune.Kernel.PlatForm.Utility.CLogger.LogError("Error in PatientRegistration: PatientImageHandler ", ex);
        }
    

    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
    public class allfiles
    {
        byte[] filebytes = null;
        long loginID = 0;
        long orgID = 0;
        // string toFileType = string.Empty;
        public byte[] Filebytes
        {
            get { return filebytes; }
            set { filebytes = value; }
        }
        public long LoginID
        {
            get { return loginID; }
            set { loginID = value; }
        }
        public long OrgID
        {
            get { return orgID; }
            set { orgID = value; }
        }


    }
    

}