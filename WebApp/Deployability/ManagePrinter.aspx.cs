using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.Script.Services;
using System.Data;
using System.Data.SqlClient;
using System.ServiceModel.Web;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using Attune.Podium.NewInstanceCreation;
public partial class Deployability_ManagePrinter : BasePage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadLocation();
        LoadOrgan();
       
    }
    public void LoadLocation()
    {
        long returnCode = -1;
        try
        {
            PatientVisit_BL patientBL = new PatientVisit_BL(base.ContextInfo);
            List<OrganizationAddress> lstLocation = new List<OrganizationAddress>();
            returnCode = patientBL.GetLocation(OrgID, LID, 0, out lstLocation);
            if (lstLocation.Count > 0)
            {
                ddlLocation.DataSource = lstLocation;
                ddlLocation.DataTextField = "Location";
                ddlLocation.DataValueField = "AddressID";
                ddlLocation.DataBind();
                ddlLocation.Items.Insert(0, "--Select--");
                ddlLocation.Items[0].Value = "0";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in Get ClientType", ex);
        }
    }

    private void LoadOrgan()
    {
        try
        {
            List<Organization> lstOrgList = new List<Organization>();
            AdminReports_BL objBl = new AdminReports_BL(base.ContextInfo);
            objBl.GetSharingOrganizations(OrgID, out lstOrgList);
            if (lstOrgList.Count > 0)
            {
                var childItems = from child in lstOrgList
                                 where child.OrgID == OrgID
                                 select child;
                ddlSelectOrg.DataSource = childItems;
                ddlSelectOrg.DataTextField = "Name";
                ddlSelectOrg.DataValueField = "OrgID";
                ddlSelectOrg.DataBind();
                ddlSelectOrg.Items.Insert(0, "--Select--");
                ddlSelectOrg.Items[0].Value = "0";
                ddlSelectOrg.Focus();
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load TrustedOrg details", ex);
        }
    }

    [WebMethod(EnableSession = true)]
    [System.Web.Script.Services.ScriptMethod()]
    public static void AddNewPrinter(int OrgID, int OrgAddressID, String PrinterName, bool IsColorPrinter, bool IsActive, long AutoPrinterID)
    {
        long returncode = -1;
        Deployability_BL Deployability_BL = new Deployability_BL(new BaseClass().ContextInfo);
        
        try
        {
            returncode = Deployability_BL.InsertLocationPrintMapDetails(OrgID, OrgAddressID, PrinterName, IsColorPrinter, IsActive, AutoPrinterID);
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdLocationPrinter Save", ex);
        }
    }
    [WebMethod(EnableSession = true)]
    public static string GetPrinterLocation(int OrgID)
    {
        try
        {
            long returnCode = -1;
            Deployability_BL DeployabilityBL = new Deployability_BL();
            List<LocationPrintMap> lAddress = new List<LocationPrintMap>();
            returnCode = DeployabilityBL.GetAllLocationPrinter(OrgID, 0, out lAddress);

            JavaScriptSerializer js = new JavaScriptSerializer();
            string strout = js.Serialize(lAddress);
            return strout;
        }
        catch (Exception ex)
        {
            return "Error:" + ex;
        }
    }
    [WebMethod(EnableSession = true)]
    public static void RemovePrinterLocation(int OrgId, int OrgAddressID, string PrinterName)
    {
        long returnCode = -1;
        try
        {
            Deployability_BL DeployabilityBL = new Deployability_BL();
            returnCode = DeployabilityBL.RemoveLocationPrintMapDetails(OrgId, OrgAddressID, PrinterName);

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in grdLocationPrinter_RowDelete Event()", ex);
        }
    }
    
 }

