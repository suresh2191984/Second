using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Data;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.ExcelExportManager;
using System.IO;
using Attune.Podium.TrustedOrg;
using System.Collections;

public partial class Admin_PatientDashBoard : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
    protected void ddlCountry_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCountry.SelectedValue == "1")
        {
            ddlState.Items.Insert(1, new ListItem("TamilNadu", "1"));
        }       
        if (ddlCountry.SelectedValue == "0")
        {
            if (ddlState.Items.Count > 1)
            {
                ddlState.Items.RemoveAt(1);
            }
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    { 
        if (ddlCountry.SelectedIndex == 1 && ddlState.SelectedIndex == 1)
        {
            prnReport.Style.Add("display", "block");
        }
        else
        {
            prnReport.Style.Add("display", "none");
        }
            
        
    }
}
