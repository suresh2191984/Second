using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class Investigation_ImageAccess : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        long returnCode = -1;
        List<ImageServerDetails> imgServerdetails = new List<ImageServerDetails>();
        returnCode = new IntegrationBL(base.ContextInfo).GetImageServerDetails(OrgID, ILocationID, out imgServerdetails);

        //string portnumber = System.Configuration.ConfigurationManager.AppSettings["ImageServerPort"]; // Get port number from Web.Config

        //string ipaddress = System.Configuration.ConfigurationManager.AppSettings["ImageServerIP"]; ; // Get Ip Address from Web.Config
        string portnumber = string.Empty;

        string ipaddress = string.Empty;

        if (imgServerdetails.Count > 0)
        {
            portnumber = imgServerdetails[0].PortNumber;

            ipaddress = imgServerdetails[0].IpAddress; // Get Ip Address from Web.Config
        }
        string accessionnumber = Request.QueryString["AccessionNumber"];

        string outputstring = "pellucid|" + ipaddress + "|" + portnumber + "|" + accessionnumber;

        //Response.Write(outputstring);
    }
}
