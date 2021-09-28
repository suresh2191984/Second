using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_ReferedPhysician : BaseControl
{
    public event System.EventHandler selectedSpeciality;
    public event System.EventHandler selectedConsulting;
/*   ---------------------------------------------------------------------------------------
 *   Date            Worker                        Work Description
 *   ---------------------------------------------------------------------------------------
    Dec-27-2010      Venkatesh.K                   Add two properties to set the specality and referring physicain name from page
 ---------------------------------------------------------------------------------------    */

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            AddingRefPhysician.DDL = ddlConsultingName;
            if (!Page.IsPostBack)
            {
                LoadSpecialityName();
                LoadConsultingName();

            }

        }
        catch (Exception ex)
        {
        }
    }
    public int settabindex(int TabIndexs)
    {
        txtNew.TabIndex = (short)(TabIndexs++);
        ddlConsultingName.TabIndex = (short)(TabIndexs++);
        ddlSpeciality.TabIndex = (short)(TabIndexs++);
        return TabIndexs;
    }
    public void LoadSpecialityName()
    {
        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);

        List<Speciality> lstTempSpeciality = (from tmp in lstSpeciality
                                              select new Speciality
                                              {
                                                  SpecialityID = tmp.SpecialityID,
                                                  SpecialityName = tmp.SpecialityName.Split(':')[0]
                                              }).ToList();
        ddlSpeciality.DataSource = lstTempSpeciality;
        ddlSpeciality.DataTextField = "SpecialityName";
        ddlSpeciality.DataValueField = "SpecialityID";
        ddlSpeciality.DataBind();
        ddlSpeciality.Items.Insert(0, "-----Select-----");
        ddlSpeciality.SelectedValue = SpecalityID.ToString();
        
    }
    public void LoadConsultingName()
    {
        List<ReferingPhysician> lstPhysician = new List<ReferingPhysician>();
        new Patient_BL(base.ContextInfo).GetReferingPhysician("", OrgID, out lstPhysician);
        ddlConsultingName.DataSource = lstPhysician;
        ddlConsultingName.DataTextField = "PhysicianName";
        ddlConsultingName.DataValueField = "ReferingPhysicianID";
        ddlConsultingName.DataBind();
        ddlConsultingName.Items.Insert(0, "-----Select-----");
        ddlConsultingName.SelectedValue = RefferringPhysicianID.ToString();
    }
    //protected void ddlConsultingName_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    //DropDownList ddlSelDoc = (DropDownList)sender;

    //    selectedConsulting(sender, e);

    //}
    //protected void ddlSpeciality_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    // ScriptManager.RegisterStartupScript(Page, this.GetType(), "speciality", "<script> document.getElementById('divConsultingName').style.display='block' </script>", false);
    //    LoadConsultingName();
    //    selectedSpeciality(sender, e);
    //}

    public long GetRefPhyID()
    {
        long refPhyID = 0;
        if (ddlConsultingName.SelectedValue != "-----Select-----")
        {
            refPhyID = Convert.ToInt64(ddlConsultingName.SelectedValue);
        }
        return refPhyID;

    }


    public int GetSpeciality()
    {
        int refSpID = 0;
        if (ddlSpeciality.SelectedValue != "-----Select-----")
        {
            refSpID = Convert.ToInt32(ddlSpeciality.SelectedValue);
        }
        return refSpID;

    }
    /// <summary>
    /// Use this property for get or set refering Physicain ID
    /// </summary>
    private long _selectedValue = 0;
    [System.ComponentModel.Browsable(false)]
    public long RefferringPhysicianID
    {
        get
        {
            //_selectedValue = Convert.ToInt64(ddlConsultingName.SelectedValue);
            return _selectedValue;
        }
        set 
        {
            _selectedValue = value;
        }
    }
    /// <summary>
    /// Use this property for get or set Speciality for referring Physician
    /// </summary>
    private int _SpecalityID = 0;
    public int SpecalityID
    {
        get
        {
            //_SpecalityID = Convert.ToInt32(ddlSpeciality.SelectedValue);
            return _SpecalityID;
        }
        set
        {
            _SpecalityID = value;
        }
    }
    /// <summary>
    /// Use this property for getting reffering physcian Name
    /// </summary>
    private string _RefferingPhyName = string.Empty;

    public string RefferingPhyName
    {
        get
        {
            if (ddlConsultingName.SelectedItem.Value != "0")
            {
                _RefferingPhyName = ddlConsultingName.SelectedItem.Text;
            }
            return _RefferingPhyName;
        }
        //set { _RefferingPhyName = value; }
    }


}
