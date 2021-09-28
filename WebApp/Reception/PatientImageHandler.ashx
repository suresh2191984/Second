<%@ WebHandler Language="C#" Class="PatientImageHandler" %>

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



public class PatientImageHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        string filePath = string.Empty;
        String ImgPath = string.Empty;
        try
        {
            if (context.Request.QueryString["FileName"] != null)
            {

                ImgPath = GetConfigValue("TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                filePath = ImgPath + context.Request.QueryString["FileName"];
                if (!System.IO.File.Exists(filePath))
                {
                    ImgPath = GetConfigValue("OLD_TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                }
                else
                {
                    ImgPath = GetConfigValue("TRF_UploadPath", Convert.ToInt16(context.Request.QueryString["OrgID"]));
                }
                filePath = ImgPath + context.Request.QueryString["FileName"];
               // filePath = ConfigurationManager.AppSettings["PatientPhotoPath"] + context.Request.QueryString["FileName"];
                if (File.Exists(filePath))
                {
                    
                    Image image = Image.FromFile(filePath);
                    context.Response.ContentType = "Image/jpeg";
                    image.Save(context.Response.OutputStream, ImageFormat.Jpeg);
                    image.Dispose();
                }
            }
            //if (context.Request.QueryString["ADD"] != null)
            //{
            //    filePath = context.Request.QueryString["ADD"];
            //    Image image = Image.FromFile(filePath);

            //    context.Response.ContentType = "Image/jpeg";
            //    image.Save(context.Response.OutputStream, ImageFormat.Jpeg);
            //    image.Dispose();
            //}
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

}