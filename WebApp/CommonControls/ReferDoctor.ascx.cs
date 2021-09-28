using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_ReferDoctor : BaseControl
{
    //int OrgID = 0;
    public CommonControls_ReferDoctor()
        : base("CommonControls_ReferDoctor_ascx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            loadDoctorsReffered(OrgID);
            ddlDoctor.Focus();
        }
    }

    private void loadDoctorsReffered(int OrgID)
    {
        //PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
        //List<ReferenceOrg> lstRefOrg = new List<ReferenceOrg>();
        //long returnCode = -1;
        //returnCode = visitBL.GetDoctorsReferred(out lstRefOrg);
        //ddlDoctor.DataSource = lstRefOrg;
        //ddlDoctor.DataTextField = "ReferrerName";
        //ddlDoctor.DataValueField = "RefernceOrgID";
        //ddlDoctor.DataBind();
        //ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "Others");

        //to get Doctors list
        PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
        List<Physician> lstPhysician = new List<Physician>();
        long returnCode = -1;
        returnCode = visitBL.GetDoctorsForLab(OrgID, out lstPhysician);
        ddlDoctor.DataSource = lstPhysician;
        ddlDoctor.DataTextField = "PhysicianName";
        //ddlDoctor.DataValueField = "PhysicianID";
        ddlDoctor.DataValueField = "LoginID";
        ddlDoctor.DataBind();
        ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "Others");
        ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "None");
        ddlDoctor.Items.Insert(ddlDoctor.Items.Count, "Self");
    }
}
