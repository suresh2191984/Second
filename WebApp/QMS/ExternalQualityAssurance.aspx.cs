using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;
using System.IO;
using System.Security.Cryptography;
using System.Web.Services;
using System.Collections;
using System.Web.Caching;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web.Script.Serialization;
using Attune.Podium.FileUpload;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Solution.QMSBusinessLogic;

public partial class ExternalQualityAssurance : BasePage
{
    public string dt;
    protected void Page_Load(object sender, EventArgs e)
    {
        //string pathname = GetConfigValue("TRF_UploadPath", OrgID);
       // hdnFilePath.Value = pathname;
        //DateTime dt = new DateTime();
        //     dt = Convert.ToDateTime(OrgDateTimeZone);
        //     int Year = dt.Year;
        //        int Month = dt.Month;
        //     int Day = dt.Day;
        //     String Root = String.Empty;
        //     String RootPath = String.Empty;
            
        //     Root = "TRF_Upload-" + OrgID + "-" + Year + "-" + Month + "-" + Day + "-";
        //     Root = Root.Replace("-", "\\\\");
        //     RootPath = pathname + Root;
             //hdnRootPath.Value = RootPath;
         
     


    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;

        GateWay objGateway = new GateWay(new BaseClass().ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public HttpFileCollection TRFFiles()
    {
        HttpFileCollection hfc = HttpContext.Current.Request.Files;
        return hfc;
    }

}

