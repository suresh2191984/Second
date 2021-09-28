using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_ConsultingName : BaseControl
{
    public event System.EventHandler selectedSpeciality;
    public event System.EventHandler selectedConsulting;
    public CommonControls_ConsultingName()
        : base("CommonControls_ConsultingName_ascx")
    {
    }
	
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            LoadSpecialityName();
        }
        ddlSpeciality.Focus();
    }

    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);

        ddlSpeciality.DataSource = lstSpeciality;
        ddlSpeciality.DataTextField = "SpecialityName";
        ddlSpeciality.DataValueField = "SpecialityID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, "-----Select-----");
       ddlConsultingName.Items.Insert(0, "-----Select-----");
    }
    public void LoadConsultingName()
    {
        if (ddlSpeciality.SelectedItem.Text != "-----Select-----")
        {
            List<Physician> lstPhysician = new List<Physician>();
            new PatientVisit_BL(base.ContextInfo).GetConsultingName(Convert.ToInt64(ddlSpeciality.SelectedItem.Value), OrgID, out lstPhysician);

            ddlConsultingName.DataSource = lstPhysician;
            ddlConsultingName.DataTextField = "PhysicianName";
            ddlConsultingName.DataValueField = "LoginID";
            ddlConsultingName.DataBind();
            ddlConsultingName.Items.Insert(0, "-----Select-----");
        }
        else
        {
            ddlConsultingName.Items.Clear();
           ddlConsultingName.Items.Insert(0, "-----Select-----");
        }

    }
    protected void ddlConsultingName_SelectedIndexChanged(object sender, EventArgs e)
    {
            //DropDownList ddlSelDoc = (DropDownList)sender;

        selectedConsulting(sender, e);
      
    }
    protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        // ScriptManager.RegisterStartupScript(Page, this.GetType(), "speciality", "<script> document.getElementById('divConsultingName').style.display='block' </script>", false);
        LoadConsultingName();
        selectedSpeciality(sender, e);
    }

    
   
     
    
}
