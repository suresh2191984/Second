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
    
    public void ProcessRequest (HttpContext context) {


        long InvID=0, OrgId=0, VisitId=0;
        if (context.Request.QueryString["InvID"] != null)
        {
            InvID = Convert.ToInt64(context.Request.QueryString["InvID"]);
        }
        if (context.Request.QueryString["OrgId"] != null)
        {
            OrgId = Convert.ToInt64(context.Request.QueryString["OrgId"]);
        }
        if (context.Request.QueryString["VisitId"] != null)
        {
            VisitId = Convert.ToInt64(context.Request.QueryString["VisitId"]);
        }
        else
        {
            throw new ArgumentException("No parameter specified");
        }

       

        long returnCode = 0;
         
        Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetImageForApproval(OrgId, VisitId, InvID, out login);
        byte[] byteArray = login.ImageSource;
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