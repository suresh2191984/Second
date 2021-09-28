<%@ WebHandler Language="C#" Class="ImageHandler" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Xml;
using Attune.Podium.Common;
using System.IO;
using System.Drawing;
using System.ComponentModel;
using System.Web.SessionState;

public class ImageHandler : IHttpHandler, IReadOnlySessionState{

    public void ProcessRequest(HttpContext context)    {
        long OrgID = 0, LoginID = 0;
        if (context.Request.QueryString["OrgID"] != null)
        {
            OrgID = Convert.ToInt64(context.Request.QueryString["OrgID"]);
        }
        if (context.Request.QueryString["LoginID"] != null)
        {
            LoginID = Convert.ToInt64(context.Request.QueryString["LoginID"]);
        }
        
        byte[] byteArray;
        if (context.Request.QueryString["isBarCode"] == null)
        {
            long returnCode = -1;
            Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
            Role_BL roleBL = new Role_BL(new BaseClass().ContextInfo);
            returnCode = roleBL.GetUserImage(OrgID, LoginID, out login);
            byteArray = login.ImageSource;
            if (byteArray.Count() > 0)
            {
                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite(byteArray);
            }

        }
        if (context.Request.QueryString["isBarCode"] != null)
        {

            string pkey = Convert.ToString(context.Request.QueryString["key"]);
            string pval = Convert.ToString(context.Request.QueryString["val"]);
            bool showCodeString = Convert.ToBoolean(context.Request.QueryString["showCodeString"]);
            BarCodeGenerator barobj = new BarCodeGenerator();
            System.Byte[] imgBarcode = barobj.Code39(pval, 30, showCodeString, pkey);
            byteArray = imgBarcode;
            if (byteArray.Count() > 0)
            {
                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite(byteArray);
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}