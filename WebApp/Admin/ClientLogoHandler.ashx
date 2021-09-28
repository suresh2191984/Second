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



   public class ImageHandler : IHttpHandler, IReadOnlySessionState
    {   
      
        public void ProcessRequest(HttpContext context)
        {
            long OrgID = 0, ClientId = 0;
            if (context.Request.QueryString["OrgID"] != null)
            {
                OrgID = Convert.ToInt64(context.Request.QueryString["OrgID"]);
            }
            if (context.Request.QueryString["ClientId"] != null)
            {
                ClientId = Convert.ToInt64(context.Request.QueryString["ClientId"]);
            }

            byte[] byteArray;

            long returnCode = -1;
            Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
            Role_BL roleBL = new Role_BL(new BaseClass().ContextInfo);
            returnCode = roleBL.GetClientLogo(OrgID, ClientId, out login);
            byteArray = login.ImageSource;
            if (byteArray.Count() > 0)
            {
                context.Response.ContentType = "image/jpeg";
                context.Response.BinaryWrite(byteArray);
            }

       }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}