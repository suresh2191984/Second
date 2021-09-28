using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.Common;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_QuickBillReferedPhysicianLab : BaseControl
{
    public event System.EventHandler selectedSpeciality;
    public event System.EventHandler selectedConsulting;
    List<Physician> lstPhysician;
    List<ReferingPhysician> lstRefPhysician;
    public string ReferringType { get; set; }
    string Iscorporate = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //
            lblReferringType.Text = ReferringType;
            AutoCompleteExtenderRefPhy.ContextKey = OrgID.ToString();
            //SpecialityVisiblity = true;
            if (!Page.IsPostBack)
            {
                LoadSpecialityName();
                LoadInternalExternal();
                ShowSelectedPhysician();                
            }
            Iscorporate= Session["IsCorporateOrg"].ToString();
            if (Iscorporate == "Y")
            {
                rdoInternal.Checked = false;
                rdoExternal.Checked = false;
            }
        }
        catch (Exception ex)
        {
        }
    }
    public int settabindex(int TabIndexs)
    {
        txtNew.TabIndex = (short)(TabIndexs++);
        //ddlRefPhysician.TabIndex = (short)(TabIndexs++);
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
        ddlRefPhysician.Items.Insert(0, "-----Select-----");
    }
    

    public long GetRefPhyID()
    {
        long refPhyID = 0;
        if (hdnPhysicianValue.Value!="")
        {
            refPhyID = Convert.ToInt64(hdnPhysicianValue.Value.Split('~')[1]);
        }
        return refPhyID;

    }


    public int GetSpeciality()
    {
        int refSpID = 0;
        if (hdnSpecialityValue.Value!="")
        {
            refSpID = Convert.ToInt32(hdnSpecialityValue.Value);
        }
        return refSpID;
    }
    public string GetReferralType()
    {
        string ReferralType = string.Empty;
        if (hdnReferralType.Value != "")
        {
            ReferralType = hdnReferralType.Value;
        }
        return ReferralType;
    }
    public void LoadInternalExternal()
    {
        lstPhysician = new List<Physician>();
        lstRefPhysician = new List<ReferingPhysician>();

        new PatientVisit_BL(base.ContextInfo).GetInternalExternalPhysician(OrgID, out lstPhysician,out lstRefPhysician);
        if (lstPhysician.Count > 0)
        {
            //ListItem li = new ListItem("None", "-1");
            //ddlPhysician.Items.Add(li);
          
            ddlPhysician.DataSource = lstPhysician;
            ddlPhysician.DataTextField = "PhysicianName";
            ddlPhysician.DataValueField = "PhysicianID";
            ddlPhysician.DataBind();
            ddlPhysician.Items.Insert(0, "None");
          
          
        }

        if (lstRefPhysician.Count > 0)
        {
            ddlRefPhysician.DataSource = lstRefPhysician;
            ddlRefPhysician.DataTextField = "PhysicianName";
            ddlRefPhysician.DataValueField = "ReferingPhysicianID";
            ddlRefPhysician.DataBind();
            ddlRefPhysician.Items.Insert(0, "-----Select-----");
            ddlRefPhysician.Items[0].Value = "0";
        }
    }

  
    public string DDLPhysicianSelectedValue
    {
        get { return ddlPhysician.SelectedValue.ToString(); }
        set { ddlPhysician.SelectedValue =  value; }
    }

    public string DDLRefPhysicianSelectedValue
    {
        get { return ddlRefPhysician.SelectedValue.ToString(); }
        set { ddlRefPhysician.SelectedValue = value; }
    }

    public string DDLSpeciality
    {
        get { return ddlSpeciality.SelectedValue.ToString(); }
        set { ddlSpeciality.SelectedValue = value; }
    }

     
    public string SelectedPhysicianID
    {
        get { return  hdnPhysicianValue.Value; }
        set { hdnPhysicianValue.Value = value; }
    }



    public string SelectedSpecialityID
    {
        get { return hdnSpecialityValue.Value; }
        set { hdnSpecialityValue.Value = value; }
    }

    public bool SpecialityVisiblity
    {
        set { if (value == true) { divSpeciality.Attributes.Add("style", "display:block"); } else { divSpeciality.Attributes.Add("style", "display:none"); }; }
    }

    public string GetRefPhyName()
    {
        string  refPhyName = string.Empty;
        if (hdnPhysicianValue.Value != "")
        {
            refPhyName = hdnPhysicianValue.Value.Split('~')[2];
        }
        return refPhyName;

    }
    public string GetRefPhyType()
    {
        string refPhyName = string.Empty;
        if (hdnPhysicianValue.Value != "")
        {
            refPhyName =  hdnPhysicianValue.Value.Split('~')[0];
        }

        if (refPhyName == "I")
        {
            refPhyName = "I";
        }
        else { refPhyName = "E"; }

        return refPhyName;

    }
    private void ShowSelectedPhysician()
    {
        IP_BL ipBL = new IP_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        long VisitID = -1;
        if (Request.QueryString["VID"] != null)
        {
            Int64.TryParse(Request.QueryString["VID"], out VisitID);
            ipBL.GetIPVisitDetails(VisitID, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {

                if (lstPatientVisit[0].PhysicianID > 0)
                {
                     ddlPhysician.SelectedValue = lstPatientVisit[0].PhysicianID.ToString();
                     hdnSelectedPhysician.Value = lstPatientVisit[0].PhysicianID.ToString();
                     rdoInternal.Checked = true;
                     trDDLPanel.Attributes.Add("Style", "display:block");                  
                     divPhysicianName.Attributes.Add("Style", "display:block");
                     divRefPhysicianName.Attributes.Add("Style", "display:none");
                }
                else if (lstPatientVisit[0].ReferingPhysicianID > 0)
                {
                    ddlRefPhysician.SelectedValue = lstPatientVisit[0].ReferingPhysicianID.ToString();
                    hdnSelectedPhysician.Value = lstPatientVisit[0].ReferingPhysicianID.ToString();
                    rdoExternal.Checked = true;
                    trDDLPanel.Attributes.Add("Style", "display:block");
                    divRefPhysicianName.Attributes.Add("Style", "display:block");
                    divPhysicianName.Attributes.Add("Style", "display:none");
                }
            }
        }
    }

    public void ShowSelectedPhysician(long VisitID)
    {
        IP_BL ipBL = new IP_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
        if (Request.QueryString["VID"] != null)
        {
            ipBL.GetIPVisitDetails(VisitID, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {
                if (lstPatientVisit[0].PhysicianID > 0)
                {
                    ddlPhysician.SelectedValue = lstPatientVisit[0].PhysicianID.ToString();
                    txtNew.Text = ddlPhysician.SelectedItem.Text.ToString(); 
                    hdnSelectedPhysician.Value = lstPatientVisit[0].PhysicianID.ToString();
                    rdoInternal.Checked = true;
                    rdoExternal.Checked = false;
                    trDDLPanel.Attributes.Add("Style", "display:block");
                    divPhysicianName.Attributes.Add("Style", "display:block");
                    divRefPhysicianName.Attributes.Add("Style", "display:none");
                    divSpeciality.Attributes.Add("Style", "display:none");
                }
                else if (lstPatientVisit[0].ReferingPhysicianID > 0)
                {
                    ddlRefPhysician.SelectedValue = lstPatientVisit[0].ReferingPhysicianID.ToString();
                    txtNew.Text = ddlRefPhysician.SelectedItem.Text.ToString();
                    hdnSelectedPhysician.Value = lstPatientVisit[0].ReferingPhysicianID.ToString();
                    rdoInternal.Checked = false;
                    rdoExternal.Checked = true;
                    trDDLPanel.Attributes.Add("Style", "display:block");
                    divRefPhysicianName.Attributes.Add("Style", "display:block");
                    divPhysicianName.Attributes.Add("Style", "display:none");
                }
                else
                {
                    rdoExternal.Checked = false;
                    rdoInternal.Checked = false;
                    ddlPhysician.SelectedIndex = -1;
                    ddlRefPhysician.SelectedIndex = -1;
                    trDDLPanel.Attributes.Add("Style", "display:none");
                    divRefPhysicianName.Attributes.Add("Style", "display:none");
                    divPhysicianName.Attributes.Add("Style", "display:none");

                }
            }
        }
    }
}