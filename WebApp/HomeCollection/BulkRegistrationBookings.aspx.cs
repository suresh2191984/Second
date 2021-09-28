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
using System.Globalization;

public partial class HomeCollection_BulkRegistrationBookings : BasePage
{
    public HomeCollection_BulkRegistrationBookings()
        : base("HomeCollection_BulkRegistrationBookings_aspx")
    {
    }

    long returnCode = -1;
    long LocationID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                txtFromDate.Text = OrgTimeZone;
                txtToDate.Text = OrgTimeZone;
                LoadLocations(LID);
            }
           
            hdnOrgID.Value = Convert.ToString(OrgID);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load: ", ex);
        }
    }
    
    protected void LoadLocations(long uroleID)
    {

        string all = "--ALL--";
        PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
        returnCode = patientBL.GetLocation(OrgID, LID, uroleID,out lstLocation);
        ddlLocation.DataSource = lstLocation;

        ddlLocation.DataTextField ="Location";
        ddlLocation.DataValueField ="AddressID";
        ddlLocation.DataBind();

        if (lstLocation.Count == 1)
        {
            ddlLocation.Items.Insert(0, all);
            ddlLocation.Items[0].Selected =true;
            ddlLocation.Items[0].Value = "-1";
        }
        else if (lstLocation.Count == 0 || lstLocation.Count > 1)
        {
            ddlLocation.Items.Insert(0, all);
            ddlLocation.Items[0].Selected =true;
            ddlLocation.Items[0].Value = "-1";
        }
    }
   
    public override void VerifyRenderingInServerForm(Control control)
    {
    
    }
}
