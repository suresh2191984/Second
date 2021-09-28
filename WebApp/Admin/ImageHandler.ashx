<%@ WebHandler Language="C#" Class="ImageHandler" %>

using System;
using System.Web;
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

public class ImageHandler : IHttpHandler ,IReadOnlySessionState
    
      


{
    
    //public void ProcessRequest (HttpContext context) {
    //    context.Response.ContentType = "text/plain";
    //    context.Response.Write("Hello World");
    //}
    


    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "image/jpeg";


        if (context.Request.QueryString["ADDId"] != null)
        {
            int addressid = -1;
            byte[] Logo = new byte[0];
            long returncode = -1;
           
         
            addressid = Convert.ToInt32(context.Request.QueryString["addressid"]);
            
            List<OrganizationAddress> lstOrgLocation = new List<OrganizationAddress>();
            AdminReports_BL masterbl = new AdminReports_BL(new BaseClass().ContextInfo);
            long ddlOrglocation = 0;
            long ADDId = 0;
            int chid = 0;
            ddlOrglocation = Convert.ToInt64(context.Request.QueryString["ddlOrglocation"]);
            ADDId = Convert.ToInt64(context.Request.QueryString["ADDId"]);
            chid = Convert.ToInt32(context.Request.QueryString["chid"]);
            returncode = masterbl.pGetOrganizationLocation(ddlOrglocation, ADDId, chid, out lstOrgLocation);
            Logo = lstOrgLocation[0].Logo;
            MemoryStream memoryStream = new MemoryStream(Logo, false);
            
            System.Drawing.Image imgFromGB = System.Drawing.Image.FromStream(memoryStream);
            imgFromGB.Save(context.Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
        }
    }



    //public void ProcessRequest(HttpContext context)
    //{
    //    long OrgID = 0, ClientId = 0;
    //    if (context.Request.QueryString["OrgID"] != null)
    //    {
    //        OrgID = Convert.ToInt64(context.Request.QueryString["OrgID"]);
    //    }
    //    if (context.Request.QueryString["ClientId"] != null)
    //    {
    //        ClientId = Convert.ToInt64(context.Request.QueryString["ClientId"]);
    //    }

    //    byte[] byteArray;

    //    long returnCode = -1;
    //    Attune.Podium.BusinessEntities.Login login = new Attune.Podium.BusinessEntities.Login();
    //    Role_BL roleBL = new Role_BL(new BaseClass().ContextInfo);
    //    returnCode = roleBL.GetClientLogo(OrgID, ClientId, out login);
    //    byteArray = login.ImageSource;
    //    if (byteArray.Count() > 0)
    //    {
    //        context.Response.ContentType = "image/jpeg";
    //        context.Response.BinaryWrite(byteArray);
    //    }

    //}
    
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}