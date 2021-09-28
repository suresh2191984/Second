﻿using System;
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
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;
using System.Data;

public partial class Patient_EmegencyPatient : BasePage
{
    string Save_Msg = Resources.AppMessages.Save_Message;
    string Update_Msg = Resources.AppMessages.Update_Message;
    string Delete_Msg = Resources.AppMessages.Delete_Message;
    List<Patient> lstOutPatient = new List<Patient>();

    public Patient_EmegencyPatient()
        : base("Patient\\EmergencyPatient.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            URNControl1.LoadURNtype();
            LoadDropDown();
            LoadMeatData();
            uctPatientVitalsControl.LoadControls("I", 0);
            LoadEmergencySeverity();
        }
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        SavePatient();
        SaveVitals();
        Clear();
        
    }

    public void SavePatient()
    {
        int SeverityOrgMappingID = 0;
        Patient lstPatient = new Patient();
        lstPatient.AccompaniedBy = txtATTName.Text != "" ? txtATTName.Text.Trim() : "";
        lstPatient.Address = txtAddress.Text != "" ? txtAddress.Text.Trim() : "";
        lstPatient.RelationshipID = ddlRelation.SelectedIndex > 0 ? ddlRelation.SelectedValue : "0";
        lstPatient.ContactNo = txtContactNo.Text != "" ? txtContactNo.Text.Trim() : "";
        lstPatient.Name = txtPatientName.Text != "" ? txtPatientName.Text.Trim() : "";
        lstPatient.SEX = ddlSex.SelectedIndex > 0 ? ddlSex.SelectedValue : "";
        lstPatient.AgeUnit = ddlDOBDWMY.SelectedItem.Text;
        lstPatient.AgeValue = txtAge.Text != "" ? Convert.ToInt32(txtAge.Text.Trim()) : 0;        
        lstPatient.Condition = ddlPatientCondition.SelectedIndex > 0 ? ddlPatientCondition.SelectedValue : "0";
        URNTypes objURN = URNControl1.GetURN();
        lstPatient.URNO = objURN.URN;
        lstPatient.URNofId = objURN.URNof;
        lstPatient.URNTypeId = objURN.URNTypeId;
        lstPatient.Comments = txtNotes.Text != "" ? txtNotes.Text.Trim() : "";
        lstPatient.OrgID = OrgID;
        lstPatient.CreatedBy = LID;


        PatientAmbulancedetails lobjAMBFieldValue = new PatientAmbulancedetails();
        List<PatientAmbulancedetails> lstPatientAmbDetails = new List<PatientAmbulancedetails>();
        HiddenField hdnDriverID = (HiddenField)ucAmb.FindControl("hdnDriverID");
        HiddenField hdnAMBID = (HiddenField)ucAmb.FindControl("hdnAMBID");
        HiddenField hdnLocationID = (HiddenField)ucAmb.FindControl("hdnLocationID");
        TextBox txtAmbulanceNo = (TextBox)ucAmb.FindControl("txtAmbulanceNo");
        TextBox txtDriverName = (TextBox)ucAmb.FindControl("txtDriverName");
        TextBox txtLocation = (TextBox)ucAmb.FindControl("txtLocation");
        TextBox txtDistanceKgm = (TextBox)ucAmb.FindControl("txtDistanceKgm");
        TextBox txtDuration = (TextBox)ucAmb.FindControl("txtDuration");
        TextBox txtArrivalFromDate = (TextBox)ucAmb.FindControl("txtArrivalFromDate");
        TextBox txtArrivalToDate = (TextBox)ucAmb.FindControl("txtArrivalToDate");


        lobjAMBFieldValue.AmbulanceID = Convert.ToInt64(hdnAMBID.Value.ToString());
        lobjAMBFieldValue.DriverID = Convert.ToInt64(hdnDriverID.Value.ToString());
        lobjAMBFieldValue.LocationID = Convert.ToInt64(hdnLocationID.Value.ToString());
        lobjAMBFieldValue.Distancekgm = txtDistanceKgm.Text != "" ? Convert.ToInt64(txtDistanceKgm.Text) : 0;
        lobjAMBFieldValue.AmbulancearrivalFromdate = Convert.ToDateTime(txtArrivalFromDate.Text);
        lobjAMBFieldValue.AmbulancearrivalTodate = Convert.ToDateTime(txtArrivalToDate.Text);
        lobjAMBFieldValue.Duration = txtDuration.Text != "" ? Convert.ToInt64(txtDuration.Text) : 0;

        if (lobjAMBFieldValue.AmbulanceID > 0 || lobjAMBFieldValue.DriverID > 0 || lobjAMBFieldValue.LocationID > 0)
        {
            lstPatientAmbDetails.Add(lobjAMBFieldValue);
        }

        hdnDriverID.Value = "0";
        hdnAMBID.Value = "0";
        hdnLocationID.Value = "0";
        txtAmbulanceNo.Text = "";
        txtDriverName.Text = "";
        txtLocation.Text = "";
        txtDistanceKgm.Text = "";
        txtDuration.Text = "";
        txtArrivalFromDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");
        txtArrivalToDate.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy hh:mm tt");

        long returnCode = 0;

        SeverityOrgMappingID = Convert.ToInt16(ddlSeverity.SelectedValue);
        Patient_BL lobjBL = new Patient_BL(base.ContextInfo);
        returnCode = lobjBL.InsertEmegencyPatient(lstPatient,SeverityOrgMappingID, lstPatientAmbDetails, out lstOutPatient);

        

        if (lstOutPatient.Count > 0)
        {
            ModalPopupExtender1.Show();
            lblViewPatientName.Text = lstOutPatient[0].Name;

            lblViewPatientNumber.Text = lstOutPatient[0].PatientNumber;
            hdnPatientid.Value = lstOutPatient[0].PatientID.ToString();
            hdnVistID.Value = lstOutPatient[0].ParentPatientID.ToString();
        }




        //ScriptManager.RegisterStartupScript(this, this.GetType(), "add", "alert('" + Save_Msg + "');", true);


    }
    public void LoadMeatData()
    {
        long returncode = -1;
        string domains = "DateAttributes,Gender,ConditionOnAdmission";
        string[] Tempdata = domains.Split(',');
        string LangCode = "en-GB";
        List<MetaData> lstmetadataInput = new List<MetaData>();
        List<MetaData> lstmetadataOutput = new List<MetaData>();

        MetaData objMeta;

        for (int i = 0; i < Tempdata.Length; i++)
        {
            objMeta = new MetaData();
            objMeta.Domain = Tempdata[i];
            lstmetadataInput.Add(objMeta);
        }

        // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
		returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);
        if (lstmetadataOutput.Count > 0)
        {

            var childItems1 = from child in lstmetadataOutput
                              where child.Domain == "Gender"
                              select child;

            ddlSex.DataSource = childItems1;
            ddlSex.DataTextField = "DisplayText";
            ddlSex.DataValueField = "Code";
            ddlSex.DataBind();
            ddlSex.Items.Insert(0, "--Select--");
            ddlSex.Items[0].Value = "0";
            var childItems = from child in lstmetadataOutput
                             where child.Domain == "DateAttributes"
                             select child;

            ddlDOBDWMY.DataSource = childItems.OrderByDescending(p => p.DisplayText);
            ddlDOBDWMY.DataTextField = "DisplayText";
            ddlDOBDWMY.DataValueField = "Code";
            ddlDOBDWMY.DataBind();
        }

    }

    public void LoadDropDown()
    {
        long retCode = -1;
        Patient_BL patBL;
        patBL = new Patient_BL(base.ContextInfo);
        List<RelationshipMaster> lstRel = new List<RelationshipMaster>();
        retCode = patBL.GetRelationshipMaster(OrgID, out lstRel);

        if (retCode == 0)
        {
            ddlRelation.DataSource = lstRel;
            ddlRelation.DataTextField = "RelationshipName";
            ddlRelation.DataValueField = "RelationshipID";
            ddlRelation.DataBind();
            ddlRelation.Items.Insert(0, "--Select--");
            ddlRelation.Items[0].Value = "0";
        }

        patBL = new Patient_BL(base.ContextInfo);
        List<PatientCondition> lstPatientCondition = new List<PatientCondition>();
        retCode = patBL.getPatientCondition(out lstPatientCondition);

        if (retCode == 0)
        {

            ddlPatientCondition.DataSource = lstPatientCondition;
            ddlPatientCondition.DataTextField = "Condition";
            ddlPatientCondition.DataValueField = "ConditionID";
            ddlPatientCondition.DataBind();
            ddlPatientCondition.Items.Insert(0, "--Select--");
            ddlPatientCondition.Items[0].Value = "0";
        }
    }


    public void Clear()
    {
        txtATTName.Text = "";
        txtAddress.Text = "";
        ddlRelation.SelectedIndex = 0;
        txtContactNo.Text = "";
        txtPatientName.Text = "";
        ddlSex.SelectedIndex = 0;
        txtAge.Text = "";
        ddlPatientCondition.SelectedIndex = 0;
        ddlSex.SelectedIndex = 0;
        txtNotes.Text = "";
        TextBox txtURNo = (TextBox)URNControl1.FindControl("txtURNo");
        DropDownList ddlUrnoOf = (DropDownList)URNControl1.FindControl("ddlUrnoOf");
        DropDownList ddlUrnType = (DropDownList)URNControl1.FindControl("ddlUrnType");
        txtURNo.Text = "";
        ddlUrnoOf.SelectedIndex = 0;
        ddlUrnType.SelectedIndex = 0;

    }
    public void SaveVitals()
    {
        bool blnRetval = false;
        long returnCode;
        int iConditionID;
        long PatientID= Convert.ToInt32(hdnPatientid.Value);
        long VisitID = Convert.ToInt32(hdnVistID.Value);
        PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);
        List<PatientVitals> lstPatientVitals = new List<PatientVitals>();
        blnRetval = uctPatientVitalsControl.GetPageValues(out lstPatientVitals);
        iConditionID = Convert.ToInt32(ddlPatientCondition.SelectedValue);
       
        foreach (PatientVitals patientVitals in lstPatientVitals)
        {
            patientVitals.PatientID = PatientID;
            patientVitals.ConditionID = iConditionID;
            patientVitals.CreatedBy = LID;
            patientVitals.PatientVisitID = VisitID;
        }

        returnCode = patientVitalBL.SavePatientVitals(OrgID, 0, lstPatientVitals);
        
    }

    public void LoadEmergencySeverity()
    {
        long retCode = -1;
        Patient_BL patBL;
        patBL = new Patient_BL(base.ContextInfo);
        List<EmergencySeverityOrgMapping> lstEmergencySeverity = new List<EmergencySeverityOrgMapping>();
        retCode = patBL.GetEmergencySeverity(OrgID, out lstEmergencySeverity);

        if (lstEmergencySeverity.Count > 0)
        {
            ddlSeverity.DataSource = lstEmergencySeverity;
            ddlSeverity.DataTextField = "DisplayText";
            ddlSeverity.DataValueField = "EmergencySeverityOrgMappingID";
            ddlSeverity.DataBind();
            ddlSeverity.Items.Insert(0, "--Select--");
            ddlRelation.Items[0].Value = "0";
        }
    }
}
