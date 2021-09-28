using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Configuration;
using System.IO;

public partial class Lab_Barcodeprint :BasePage
{
    string gUID = string.Empty;
    long vid = -1;
    long returncode = -1;
    List<OrderedInvestigations> lstbarcode = new List<OrderedInvestigations>();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
            if (Request.QueryString["gUID"] != null)
            {
                gUID = Request.QueryString["gUID"].ToString();
            }
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"].ToString(), out vid);
            }
            returncode = new Investigation_BL(base.ContextInfo).pGetbarcodePrint(vid,OrgID,gUID, out lstbarcode);

            if (lstbarcode.Count > 0)
                {
                    grdbarcode.DataSource = lstbarcode;
                    grdbarcode.DataBind();
                    //Panel3.Visible = true;
                }

             
            
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in investigation result capture on page_load", ex);
        }

    }
    protected void btnclose_click(object sender, EventArgs e)
    {
        Response.Redirect("~/Lab/Home.aspx");
    }
}
