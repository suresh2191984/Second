using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;
using System.Runtime.InteropServices;

public partial class Admin_ManagePackage : BasePage
{
    long returnCode = -1;
    long returncodes = -1;
    List<InvestigationMaster> lstInvestigations = new List<InvestigationMaster>();
    List<InvGroupMaster> lstGroups = new List<InvGroupMaster>();
    List<InvGroupMaster> lstPackagesTemp = new List<InvGroupMaster>();
    List<InvPackageMapping> lstCollectedDefaultPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstCollectedPackageMapping = new List<InvPackageMapping>();
    List<InvPackageMapping> lstDeletedPackageMapping = new List<InvPackageMapping>();
    List<Speciality> lstCollectedSpeciality = new List<Speciality>();
    List<ProcedureMaster> lstCollectedProcedures = new List<ProcedureMaster>();
    List<GeneralHealthCheckUpMaster> lstGeneralHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();
    List<GeneralHealthCheckUpMaster> lstCollectedHealthCheckUpMaster = new List<GeneralHealthCheckUpMaster>();

    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            List<AdditionalTubeMapping> lstAdditionalTubeMapping = new List<AdditionalTubeMapping>();
            PackageProfileControl.CollectPackageContent(out lstPackagesTemp, out lstCollectedDefaultPackageMapping, out lstCollectedPackageMapping, out lstCollectedSpeciality, out lstCollectedProcedures, out lstDeletedPackageMapping, out lstCollectedHealthCheckUpMaster);                      
            returnCode = new Investigation_BL(base.ContextInfo).UpdatePackageContent(lstCollectedDefaultPackageMapping, lstDeletedPackageMapping, OrgID, lstAdditionalTubeMapping);
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
           // PackageProfileControl.LoadPackageData();
            returncodes = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returncodes == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving UpdatePackageContent", ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);
            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
}
