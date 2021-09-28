using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data.SqlClient;

public partial class Admin_DesignationRelationship : BasePage
{
    public Admin_DesignationRelationship()
        : base("Admin_DesignationRelationship_aspx")
    {
    }
    List<DesignationMaster> lstDesignationMaster = new List<DesignationMaster>();
    List<RelationshipMaster> lstRealtionshipMaster = new List<RelationshipMaster>();
    List<EmploymentType> lstEmploymentType = new List<EmploymentType>();
    List<EmployerDeptMaster> lstEmployerDeptMaster = new List<EmployerDeptMaster>();
    List<PatientTypeMaster> lstPatientTypeMaster = new List<PatientTypeMaster>();
    List<GradeMaster> lstGradMaster = new List<GradeMaster>();
    List<EmployerMaster> lstEmployerMaster = new List<EmployerMaster>();
    List<EmployerLocationMaster> lstEmployerLocationMaster = new List<EmployerLocationMaster>();
    EmployeeMaster ObjEmployeeMaster = new EmployeeMaster();
    Master_BL masterBL ;
    long returncode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        masterBL = new Master_BL(base.ContextInfo);
        try
        {

            if (!IsPostBack)
            {
                GetEmployeeMasters();
                SetEmployeeRegDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error During Load Page", ex);
        }
    }

    //protected void grdDesignation_PageIndexChanging(object sender, GridViewPageEventArgs e)
    //{
    //    if (e.NewPageIndex != -1)
    //    {
    //        grdDesignation.PageIndex = e.NewPageIndex;
    //    }
    //    GetEmployeeMasters();
    //}


    protected void btnSaveDesign_Click(object sender, EventArgs e)
    {
        ObjEmployeeMaster.Name = txtDesignation.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "D";
        if (hdnDesignationID.Value != "" & hdnDesignationID.Value !=",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnDesignationID.Value);
        else
            ObjEmployeeMaster.ID = 0;
        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divDesign.Attributes.Add("Style", "display:block");
    }
    protected void btnSaveRelation_Click(object sender, EventArgs e)
    {
        ObjEmployeeMaster.Name = txtRelationship.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "R";
        if (hdnRealtionID.Value != "" & hdnRealtionID.Value != ",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnRealtionID.Value);
        else
            ObjEmployeeMaster.ID = 0;
        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divRelation.Attributes.Add("Style", "display:block");
    }
    protected void btnSaveEmployementTypeName_Click(object sender, EventArgs e)
    {
        ObjEmployeeMaster.Name = txtEmployementTypeName.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "E";
        if (hdnEmployementTypeID.Value != "" & hdnEmployementTypeID.Value != ",")
        {
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnEmployementTypeID.Value);
        }
        else
        {
            ObjEmployeeMaster.ID = 0;
        }
        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divEmploymentType.Attributes.Add("Style", "display:block");
    }
    protected void btnSaveEmpDeptName_Click(object sender, EventArgs e)
    {

        ObjEmployeeMaster.Name = txtEmpDeptName.Text;
        ObjEmployeeMaster.Code = txtDeptCode.Text;
        string TypeName = "M";
        if (hdnEmpDeptID.Value != "" & hdnEmpDeptID.Value != ",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnEmpDeptID.Value);
        else
            ObjEmployeeMaster.ID = 0;

        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divEmployerDeptMaster.Attributes.Add("Style", "display:block");
    }


    protected void btnSavePatientType_Click(object sender, EventArgs e)
    {
        
        ObjEmployeeMaster.Name = txtPatientType.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "P";
        if (hdnPatientTypeID.Value != "" & hdnPatientTypeID.Value != ",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnPatientTypeID.Value);
        else
            ObjEmployeeMaster.ID = 0;
        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divPatienttypeMaster.Attributes.Add("Style", "display:block");
    }


    protected void btnSavegrade_Click(object sender, EventArgs e)
    {

        ObjEmployeeMaster.Name = txtGradeName.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "G";
        if (hdnGradeID.Value != "" & hdnGradeID.Value != ",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnGradeID.Value);
        else
            ObjEmployeeMaster.ID = 0;

        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divGradeMaster.Attributes.Add("Style", "display:block");
    }


    protected void btnSaveOfficeName_Click(object sender, EventArgs e)
    {

        ObjEmployeeMaster.Name = txtOfficeName.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "O";
        if (hdnOfficeID.Value != "" & hdnOfficeID.Value != ",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnOfficeID.Value);
        else
            ObjEmployeeMaster.ID = 0;

        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divOfficeName.Attributes.Add("Style", "display:block");
    }

    protected void btnSaveOfficeLocation_Click(object sender, EventArgs e)
    {

        ObjEmployeeMaster.Name = txtOfficeLocation.Text;
        ObjEmployeeMaster.Code = "";
        string TypeName = "L";
        if (hdnOfficeLocationID.Value != "" & hdnOfficeLocationID.Value != ",")
            ObjEmployeeMaster.ID = Convert.ToInt32(hdnOfficeLocationID.Value);
        else
            ObjEmployeeMaster.ID = 0;

        InsertEmployeeMaster(TypeName, ObjEmployeeMaster.Name, ObjEmployeeMaster.ID, ObjEmployeeMaster.Code);
        GetEmployeeMasters();
        SetEmployeeRegDetails();
        divOfficeLacation.Attributes.Add("Style", "display:block");
    }

    private void InsertEmployeeMaster(string TName, string Name, long ID, string Code)
    {
        try
        {
            long returncode = -1;
            ObjEmployeeMaster.Name = Name;
            ObjEmployeeMaster.ID = Convert.ToInt32(ID);
            returncode = masterBL.InsertEmployeeMaster(OrgID, TName, ObjEmployeeMaster, LID);
            hdnDesignationID.Value = "";
            hdnRealtionID.Value = "";
            hdnEmployementTypeID.Value = "";
            hdnEmpDeptID.Value = "";
            hdnPatientTypeID.Value = "";
            hdnGradeID.Value = "";
            hdnOfficeID.Value = "";
            hdnOfficeLocationID.Value = "";
            divDesign.Attributes.Add("Style", "display:none");
            divRelation.Attributes.Add("Style", "display:none");
            divEmploymentType.Attributes.Add("Style", "display:none");
            divEmployerDeptMaster.Attributes.Add("Style", "display:none");
            divPatienttypeMaster.Attributes.Add("Style", "display:none");
            divGradeMaster.Attributes.Add("Style", "display:none");
            divOfficeName.Attributes.Add("Style", "display:none");
            divOfficeLacation.Attributes.Add("Style", "display:none");
            divEmployeeRegistration.Attributes.Add("Style", "display:none");
            GetEmployeeMasters();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "reset rdo", "javascript:SelectMaster();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Insert Employee details in InsertEmployeeMaster()", ex);
        }
    }
    private void GetEmployeeMasters()
    {
        try
        {
            long returnCode = -1;
            long EmpID = 0;
            long ExID = 0;
            returnCode = masterBL.GetEmployeeMasters(OrgID,
                                                    out lstDesignationMaster,
                                                    out lstRealtionshipMaster,
                                                    out lstEmploymentType,
                                                    out lstEmployerDeptMaster,
                                                    out lstPatientTypeMaster,
                                                    out lstGradMaster,
                                                    out lstEmployerMaster,
                                                    out lstEmployerLocationMaster,
                                                    out EmpID,
                                                    out ExID
                                                    );
            grdDesignation.DataSource = lstDesignationMaster;
            grdDesignation.DataBind();

            grdRelation.DataSource = lstRealtionshipMaster;
            grdRelation.DataBind();

            grdEmploymentType.DataSource = lstEmploymentType;
            grdEmploymentType.DataBind();

            grdEmployerDeptMaster.DataSource = lstEmployerDeptMaster;
            grdEmployerDeptMaster.DataBind();

            grdPatientTypeMaster.DataSource = lstPatientTypeMaster;
            grdPatientTypeMaster.DataBind();

            grdGradeMaster.DataSource = lstGradMaster;
            grdGradeMaster.DataBind();

            grdOfficeName.DataSource = lstEmployerMaster;
            grdOfficeName.DataBind();

            grdOfficeLocation.DataSource = lstEmployerLocationMaster;
            grdOfficeLocation.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Get Employee details in GetEmployeeMasters()", ex);
        }
    }

    private void SetEmployeeRegDetails()
    {
        ddlDesignation.DataTextField = "DesignationName";
        ddlDesignation.DataValueField = "DesignationID";
        ddlDesignation.DataSource = lstDesignationMaster;
        ddlDesignation.DataBind();
        ddlDesignation.Items.Insert(0, "---Select---");

        ddlEmployementType.DataTextField = "EmployementTypeName";
        ddlEmployementType.DataValueField = "EmployementTypeID";
        ddlEmployementType.DataSource = lstEmploymentType;
        ddlEmployementType.DataBind();
        ddlEmployementType.Items.Insert(0, "---Select---");

        ddlDepartment.DataTextField = "EmpDeptName";
        ddlDepartment.DataValueField = "EmpDeptID";
        ddlDepartment.DataSource = lstEmployerDeptMaster;
        ddlDepartment.DataBind();
        ddlDepartment.Items.Insert(0, "---Select---");

        ddlEmployerLocation.DataTextField = "EmployerLocationName";
        ddlEmployerLocation.DataValueField = "EmployerLocationID";
        ddlEmployerLocation.DataSource = lstEmployerLocationMaster;
        ddlEmployerLocation.DataBind();
        ddlEmployerLocation.Items.Insert(0, "---Select---");

        ddlEmployerName.DataTextField = "EmployerName";
        ddlEmployerName.DataValueField = "EmployerID";
        ddlEmployerName.DataSource = lstEmployerMaster;
        ddlEmployerName.DataBind();
        ddlEmployerName.Items.Insert(0, "---Select---");

        LoadSampleCollectionZones();

        GetEmployeeRegistration();

    }



    protected void btnSaveEmpRegistration_Click(object sender, EventArgs e)
    {
        try
        {
            List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
            EmployeeRegMaster objEmpRegMaster = new EmployeeRegMaster();
                string usrMsg5 = Resources.Admin_AppMsg.Admin_DesignationRelationship_aspx_15 == null ? "Created Successfully" : Resources.Admin_AppMsg.Admin_DesignationRelationship_aspx_15;
                string usrMsg6 = Resources.Admin_ClientDisplay.Admin_DesignationRelationship_aspx_01 == null ? "Updated Successfully" : Resources.Admin_ClientDisplay.Admin_DesignationRelationship_aspx_01;
            long returnCode = -1;
            objEmpRegMaster.EmployeeNumber = txtEmployementTypeNo.Text;
            objEmpRegMaster.Name = txtEmpName.Text;
            if (txtJoinDate.Text.Trim() != "")
            {
                objEmpRegMaster.DOJ = Convert.ToDateTime(txtJoinDate.Text);
            }
            else
            {
                objEmpRegMaster.DOJ = Convert.ToDateTime("01-01-1999");
            }
            if (ddlEmployerName.SelectedIndex >0)
            {
                objEmpRegMaster.EmployerID = Convert.ToInt64(ddlEmployerName.SelectedItem.Value);
            }
            if (ddlEmployementType.SelectedIndex > 0)
            {
                objEmpRegMaster.EmployementTypeID = Convert.ToInt64(ddlEmployementType.SelectedItem.Value);
            }
            if (ddlDepartment.SelectedIndex >0)
            {
                objEmpRegMaster.DeptID = Convert.ToInt64(ddlDepartment.SelectedItem.Value);
            }
            if (ddlDesignation.SelectedIndex > 0)
            {
                objEmpRegMaster.DesignationID = Convert.ToInt64(ddlDesignation.SelectedItem.Value);
            }
            objEmpRegMaster.Qualification = txtQualification.Text;
            if (ddlEmployerLocation.SelectedIndex >0)
            {
                objEmpRegMaster.EmployerLocationID = Convert.ToInt64(ddlEmployerLocation.SelectedItem.Value);
            }
            objEmpRegMaster.OrgID = OrgID;
            objEmpRegMaster.CreatedBy = LID;
            if (ddlZone.SelectedIndex >0)
            {
                objEmpRegMaster.ZoneID = Convert.ToInt64(ddlZone.SelectedItem.Value);
            }
            objEmpRegMaster.MobileNo = string.Empty;
            if (txtMobile.Text.Trim() != string.Empty)
            {
                objEmpRegMaster.MobileNo = txtMobile.Text.Trim();
            }
            objEmpRegMaster.LandlineNo = string.Empty;
            if (txtLandLine.Text.Trim() != string.Empty)
            {
                objEmpRegMaster.LandlineNo = txtLandLine.Text.Trim();
            }
            objEmpRegMaster.EMail = string.Empty;
            if (txtEmail.Text.Trim() != string.Empty)
            {
                objEmpRegMaster.EMail = txtEmail.Text.Trim();
            }

            decimal DiscountLimit = 0;
            String DiscountPeriod = string.Empty;
            DateTime DiscountValidFrom = DateTime.MaxValue;
            DateTime DiscountValidTo = DateTime.MaxValue;
            decimal.TryParse(txtDiscountLimit.Text, out DiscountLimit);
            if (DiscountLimit > 0)
            {
                DiscountPeriod = "Monthly";
            }
            if (txtFromPeriod.Text != "")
            {
                DateTime.TryParse(txtFromPeriod.Text, out DiscountValidFrom);
            }
            if (txtToPeriod.Text != "")
            {
                DateTime.TryParse(txtToPeriod.Text, out DiscountValidTo);
                DiscountValidTo = DiscountValidTo.AddHours(23).AddMinutes(59).AddSeconds(59).AddMilliseconds(999);
            }
            objEmpRegMaster.DiscountValidFrom = DiscountValidFrom;
            objEmpRegMaster.DiscountValidTo = DiscountValidTo;
            objEmpRegMaster.DiscountLimit = DiscountLimit;
            objEmpRegMaster.DiscountPeriod = DiscountPeriod; 

            lstEmployeeRegMaster.Add(objEmpRegMaster);

            returnCode = masterBL.SaveEmpRegistration(lstEmployeeRegMaster);
            divEmployeeRegistration.Attributes.Add("Style", "display:block");
            string txtDispSave = Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01 == null ? "Save" : Resources.Admin_ClientDisplay.Admin_Analyzer_aspx_01;
            //btnSaveEmpReg.Text = "Save";
                string Information = Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02 == null ? "Information" : Resources.Admin_AppMsg.Admin_TestInvestigation_aspx_02;
            btnSaveEmpReg.Text = txtDispSave;
                if (hdnbtnSaveEmpReg.Value == txtDispSave)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + usrMsg5 + "','" + Information + "');", true);

                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "srchmas", "javascript:ValidationWindow('" + usrMsg6 + "','" + Information + "');", true);
                   
                }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear values", "javascript:ResetEmpReg();", true); 
            GetEmployeeRegistration();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "reset rdo", "javascript:SelectMaster();", true);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error During btnSaveEmpRegistration_Click", ex);
        }
    }

    protected void GetEmployeeRegistration()
    {
        try
        {
            List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
            long returnCode = -1;
            returnCode = masterBL.GetEmployeeRegistration(OrgID, out lstEmployeeRegMaster);
            grdEmpReg.DataSource = lstEmployeeRegMaster;
            grdEmpReg.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error During GetEmployeeRegistration", ex);
        }
    }

    private void LoadSampleCollectionZones()
    {
        try
        {
            Master_BL objMasterBL = new Master_BL(base.ContextInfo);
            long returnCode = -1;
            List<Localities> lstGroupValues = new List<Localities>();
            returnCode = objMasterBL.GetSampleCollectionZones(OrgID, out lstGroupValues);
            if (lstGroupValues.Count > 0)
            {
                ddlZone.DataTextField = "Locality_Value";
                ddlZone.DataValueField = "Locality_ID";
                ddlZone.DataSource = lstGroupValues;
                ddlZone.DataBind();
            }
            ddlZone.Items.Insert(0, "---Select---");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while LoadSampleCollectionZones()", ex);
        }
    }

    protected void grdEmpReg_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            if (e.NewPageIndex != -1)
            {
                grdEmpReg.PageIndex = e.NewPageIndex;
            }
            GetEmployeeMasters();
            SetEmployeeRegDetails();
            divEmployeeRegistration.Attributes.Add("Style", "display:block");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "clear values", "javascript:ResetEmpReg();", true); 
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error occured in grdEmpReg_PageIndexChanging()", ex);
        }
    }
}
