<%@ WebHandler Language="C#" Class="ProbeImagehandler" %>

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

public class ProbeImagehandler : IHttpHandler, IReadOnlySessionState{
    
    public void ProcessRequest (HttpContext context) {
        long InvID = 0, POrgID = 0, VisitId = 0, ImageID = 0;
        
        if (context.Request.QueryString["InvID"] != null)
        {
            InvID = Convert.ToInt64(context.Request.QueryString["InvID"]);
        }
        if (context.Request.QueryString["ImageID"] != null)
        {
            ImageID = Convert.ToInt64(context.Request.QueryString["ImageID"]);
        }
        if (context.Request.QueryString["POrgID"] != null)
        {
            POrgID=Convert.ToInt64(context.Request.QueryString["POrgID"]);
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
        Attune.Podium.BusinessEntities.PatientInvestigationFiles ProbeImages = new Attune.Podium.BusinessEntities.PatientInvestigationFiles();

        returnCode = new Investigation_BL(new BaseClass().ContextInfo).GetImageForProbes(VisitId, InvID, ImageID, POrgID, out ProbeImages);
        byte[] byteArray = ProbeImages.ImageSource;
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