using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Collections;
using System.Text;
using System.Security.Cryptography;

public partial class Admin_SurgeryMaster : BasePage
{
    List<IPTreatmentPlanMaster> lstSurgery;
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindSurgeryList();

        }


    }
    private void BindSurgeryList()
    {

        lstSurgery = new List<IPTreatmentPlanMaster>();

        long returnCode = -1;
        returnCode = new SurgeryPackage_BL(base.ContextInfo).GetSurgerylist(0, out lstSurgery);

        lstboxSurgery.DataSource = lstSurgery;
        lstboxSurgery.DataTextField = "IPTreatmentPlanName";
        lstboxSurgery.DataValueField = "IPTreatmentPlanID";
        lstboxSurgery.DataBind();


        lstboxSurgery.Attributes.Add("onclick", "showItemName()");
        txtSurgeryName.Attributes.Add("onfocus", "hideItemName()");
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string[] SurgeryRaw = hdnSurgery.Value.Split('^');
        List<IPTreatmentPlanMaster> lstIpTreatPlan = new List<IPTreatmentPlanMaster>();
        IPTreatmentPlanMaster objIpTreatPlan;
        
        foreach (string str in SurgeryRaw)
        {
            if (str != "")
            {
                string[] Surgery = str.Split('~');
                objIpTreatPlan = new IPTreatmentPlanMaster();
                objIpTreatPlan.IPTreatmentPlanName = Surgery[1].ToString().Trim();
                objIpTreatPlan.IPTreatmentPlanParentID = 1;
                objIpTreatPlan.OrgID = OrgID;
                objIpTreatPlan.CreatedBy = Convert.ToInt64(LID);
                lstIpTreatPlan.Add(objIpTreatPlan);
            }
        }

        hdnSurgery.Value = "";

        try
        {
                returnCode = new SurgeryPackage_BL(base.ContextInfo).SaveSurgeryMaster(lstIpTreatPlan);
                BindSurgeryList();
            
        }
        catch (Exception er)
        {
            CLogger.LogError("There was a Erroer while Saving Surgery Master (SaveSurgeryMaster) in SurgeryMaster.aspx", er);
        }




    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
        long Returncode = -1;
        try
        {
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            Returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
