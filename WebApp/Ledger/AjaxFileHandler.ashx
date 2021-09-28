<%@ WebHandler Language="C#" Class="AjaxFileHandler" %>

using System;
using System.Web;
using System.IO;
using System.Configuration;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;


public class AjaxFileHandler : IHttpHandler
{


    public void ProcessRequest(HttpContext context)
    {
        HttpFileCollection files = context.Request.Files;
        HttpPostedFile file;
        string filepath = context.Request.QueryString["fname"];
        string source = context.Request.QueryString["SCRN"];
        string[] list = source.Split('_');
        string CreatePath = string.Empty; // + list[0].ToString();
        if (list[2].ToString() == "INVRCPT")
        {
            CreatePath = filepath + "\\InvoiceLedger\\ReceiptPayment\\" + list[0].ToString();
            for (int i = 0; i < files.Count; i++)
            {
                file = files[i];
                if (!Directory.Exists(CreatePath))
                {
                    Directory.CreateDirectory(CreatePath);
                    if (!Directory.Exists(CreatePath + "\\" + list[1].ToString() + ".JPG"))
                    {
                        file.SaveAs(CreatePath + "\\" + list[0].ToString() + "_" + list[1].ToString() + ".JPG");
                    }

                }
                else if (Directory.Exists(CreatePath))
                {
                    if (!Directory.Exists(CreatePath + "\\" + list[1].ToString() + ".JPG"))
                    {
                        file.SaveAs(CreatePath + "\\" + list[0].ToString() + "_" + list[1].ToString() + ".JPG");
                    }

                }
            }
            context.Response.ContentType = "text/plain";
        }
        if (list[2].ToString() == "INVADV")
        {
            CreatePath = filepath + "\\InvoiceLedger\\AdvancePayment\\" + list[0].ToString();
            for (int i = 0; i < files.Count; i++)
            {
                file = files[i];
                if (!Directory.Exists(CreatePath))
                {
                    Directory.CreateDirectory(CreatePath);
                    if (!Directory.Exists(CreatePath + "\\" + list[1].ToString() + ".JPG"))
                    {
                        file.SaveAs(CreatePath + "\\" + list[0].ToString() + "_" + list[1].ToString() + ".JPG");
                    }

                }
                else if (Directory.Exists(CreatePath))
                {
                    if (!Directory.Exists(CreatePath + "\\" + list[1].ToString() + ".JPG"))
                    {
                        file.SaveAs(CreatePath + "\\" + list[0].ToString() + "_" + list[1].ToString() + ".JPG");
                    }

                }
                //D:\LedgerProofCopy\InvoiceLedger\AdvancePayment

            }
            context.Response.ContentType = "text/plain";
        }
    }


    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
    
     
     