using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;

public partial class CommonControls_ProcedureName : BaseControl
{
    public event System.EventHandler selectedIndexProcedure;
    public event System.EventHandler selectedIndexPhysicianByProcedure;

    public CommonControls_ProcedureName()
        : base("CommonControls_ProcedureName_ascx")
    {
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
           GetProcedureData();
           ddlPhysicianByProcedure.Items.Insert(0, "---------Select--------");
        }
        ddlProcedureName.Focus();
    }

    
    public void GetProcedureData()
    {
        long returnCode = -1;
        List<ProcedureMaster> lstProceduremaster = new List<ProcedureMaster>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetProcedureName(OrgID, out lstProceduremaster);

        ddlProcedureName.DataSource = lstProceduremaster;
        ddlProcedureName.DataTextField = "ProcedureName";
        ddlProcedureName.DataValueField = "ProcedureID";
        ddlProcedureName.DataBind();

        ddlProcedureName.Items.Insert(0, "---------Select--------");
        
    }

    public void GetPhysicianNameByProcedure()
    {
        if (ddlProcedureName.SelectedItem.Text != "---------Select--------")
        {
            long returnCode = -1;
            List<Physician> lstPhysicianByProcedure = new List<Physician>();
            returnCode = new PatientVisit_BL(base.ContextInfo).GetPhysicianByProcedure(OrgID, Convert.ToInt64(ddlProcedureName.SelectedItem.Value), out lstPhysicianByProcedure);
            if (lstPhysicianByProcedure.Count > 0)
            {
                lblDrName.Visible = true;
                ddlPhysicianByProcedure.Visible = true;

                ddlPhysicianByProcedure.DataSource = lstPhysicianByProcedure;
                ddlPhysicianByProcedure.DataTextField = "PhysicianName";
                ddlPhysicianByProcedure.DataValueField = "PhysicianID";
                ddlPhysicianByProcedure.DataBind();
                ddlPhysicianByProcedure.Items.Insert(0, "---------Select--------");
            }
            else
            {
                //lblDrName.Visible = false;
                ddlPhysicianByProcedure.Visible = false;
            }
        }
        else
        {
            ddlPhysicianByProcedure.Items.Clear();
            ddlPhysicianByProcedure.Items.Insert(0, "---------Select--------");
        }

    }
    protected void ddlProcedureName_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetPhysicianNameByProcedure();
        selectedIndexProcedure(sender, e);
    }

    protected void ddlPhysicianByProcedure_SelectedIndexChanged(object sender, EventArgs e)
    {
        selectedIndexPhysicianByProcedure(sender, e);
    }
}
