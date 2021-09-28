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
using Attune.Podium.BillingEngine;
using System.Security.Cryptography;
using System.Web.UI.HtmlControls;


public partial class CommonControls_EmployerRegDetail : BaseControl
{


    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            GetEmployeeMasters();
            AutoCompleteUrnNO.ContextKey = "Y";
            LoadMetaData(); // andrews
        }

    }
    // andrews
    long returncode;
    public void LoadMetaData()
    {
        string Select = Resources.CommonControls_ClientDisplay.CommonControls_EmployerRegDetail_ascx_01 == null ? "---Select One---" : Resources.CommonControls_ClientDisplay.CommonControls_EmployerRegDetail_ascx_01;
     

        try
        {
            string domains = "BloodGrp"; // andrews add - BloodGrp only
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
                var childItems3 = from child in lstmetadataOutput
                                  where child.Domain == "BloodGrp"
                                  select child;
                ddBloodGrp.DataSource = childItems3;
                ddBloodGrp.DataTextField = "DisplayText";
                ddBloodGrp.DataValueField = "Code";
                ddBloodGrp.DataBind();
                ddBloodGrp.Items.Insert(0, Select);

            }

        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
        }
    }
    //andrews
    public void GetEmployeeMasters()
    {
        long returnCode = -1;
        List<DesignationMaster> lstDesignationMaster = new List<DesignationMaster>();
        List<RelationshipMaster> lstRealtionshipMaster = new List<RelationshipMaster>();
        List<RelationshipMaster> lstExtendedMaster = new List<RelationshipMaster>();
        List<EmploymentType> lstEmploymentType = new List<EmploymentType>();
        List<EmployerDeptMaster> lstEmployerDeptMaster = new List<EmployerDeptMaster>();
        List<PatientTypeMaster> lstPatientTypeMaster = new List<PatientTypeMaster>();
        List<GradeMaster> lstGradeMaster = new List<GradeMaster>();
        List<EmployerMaster> lstEmployerMaster = new List<EmployerMaster>();
        List<EmployerLocationMaster> lstEmployerLocationMaster = new List<EmployerLocationMaster>();
        EmployeeMaster ObjEmployeeMaster = new EmployeeMaster();
        Master_BL masterBL = new Master_BL(base.ContextInfo);
        long EmpID = 0;
        long ExternalID = 0;
        long ExtendedID = 0;
        returnCode = masterBL.GetEmployeeMasters(OrgID,
                                                out lstDesignationMaster,
                                                out lstRealtionshipMaster,
                                                out lstEmploymentType,
                                                out lstEmployerDeptMaster,
                                                out lstPatientTypeMaster,
                                                out lstGradeMaster,
                                                out lstEmployerMaster,
                                                out lstEmployerLocationMaster,
                                                out EmpID,
                                                out ExternalID
                                                );

        if (lstEmployerDeptMaster.Count > 0)
            ExtendedID = Convert.ToInt64(lstEmployerDeptMaster[0].CreatedBy);
        var templist = (from val in lstRealtionshipMaster
                        where val.RelationType.Trim() == "D"
                        select new
                        {
                            val.RelationshipID,
                            val.RelationshipName,
                            val.Relation,
                            val.RelationType,
                        }).Distinct().ToList();


        var templist1 = (from val in lstRealtionshipMaster
                         where val.RelationType.Trim() == "E"
                         select new
                         {
                             val.RelationshipID,
                             val.RelationshipName,
                             val.Relation,
                             val.RelationType,
                         }).Distinct().ToList();

        if (lstDesignationMaster.Count > 0)
        {
            ddlDesignation.DataTextField = "DesignationName";
            ddlDesignation.DataValueField = "DesignationID";
            ddlDesignation.DataSource = lstDesignationMaster;
            ddlDesignation.DataBind();
           ddlDesignation.Items.Insert(0, "---Select---");
        }
        if (templist.Count > 0)
        {
            ddlRelation.DataTextField = "RelationshipName";
            ddlRelation.DataValueField = "RelationshipID";
            ddlRelation.DataSource = templist;
            ddlRelation.DataBind();
            ddlRelation.Items.Insert(0, "---Select---");
        }
        if (lstRealtionshipMaster.Count > 0)
        {
            ddlRelation1.DataTextField = "RelationshipName";
            ddlRelation1.DataValueField = "RelationshipName";
            ddlRelation1.DataSource = lstRealtionshipMaster;
            ddlRelation1.DataBind();
            ddlRelation1.Items.Insert(0, "---Select---");
        }
        if (lstEmploymentType.Count > 0)
        {
            ddlEmployementType.DataTextField = "EmployementTypeName";
            ddlEmployementType.DataValueField = "EmployementTypeID";
            ddlEmployementType.DataSource = lstEmploymentType;
            ddlEmployementType.DataBind();
            ddlEmployementType.Items.Insert(0, "---Select---");
        }
        if (lstEmployerDeptMaster.Count > 0)
        {
            ddlDepartment.DataTextField = "EmpDeptName";
            ddlDepartment.DataValueField = "EmpDeptID";
            ddlDepartment.DataSource = lstEmployerDeptMaster;
            ddlDepartment.DataBind();
            ddlDepartment.Items.Insert(0, "---Select---");
        }
        if (lstGradeMaster.Count > 0)
        {
            ddlGrade.DataTextField = "GradeName";
            ddlGrade.DataValueField = "GradeID";
            ddlGrade.DataSource = lstGradeMaster;
            ddlGrade.DataBind();
            ddlGrade.Items.Insert(0, "---Select---");
        }
        if (lstPatientTypeMaster.Count > 0)
        {
            ddlPatientType.DataTextField = "PatientTypeName";
            ddlPatientType.DataValueField = "PatientTypeID";
            ddlPatientType.DataSource = lstPatientTypeMaster;
            ddlPatientType.DataBind();
            ddlPatientType.Items.Insert(0, "---Select---");
        }

        if (templist1.Count > 0)
        {
            ddlExtended.DataTextField = "RelationshipName";
            ddlExtended.DataValueField = "RelationshipID";
            ddlExtended.DataSource = templist1;
            ddlExtended.DataBind();
            ddlExtended.Items.Insert(0, "---Select---");
        }

        if (lstEmployerMaster.Count > 0)
        {
            ddlEmployerName.DataTextField = "EmployerName";
            ddlEmployerName.DataValueField = "EmployerID";
            ddlEmployerName.DataSource = lstEmployerMaster;
            ddlEmployerName.DataBind();
            ddlEmployerName.Items.Insert(0, "---Select---");
        }
        if (lstEmployerLocationMaster.Count > 0)
        {
            ddlEmployerLocation.DataTextField = "EmployerLocationName";
            ddlEmployerLocation.DataValueField = "EmployerLocationID";
            ddlEmployerLocation.DataSource = lstEmployerLocationMaster;
            ddlEmployerLocation.DataBind();
            ddlEmployerLocation.Items.Insert(0, "---Select---");
        }
        if (EmpID > 0)
        {
            hdnEmployeeNo.Value = "SYS" + EmpID.ToString();
        }
        if (ExternalID > 0)
        {
            hdnExternalID.Value = "EX" + ExternalID.ToString();
        }
        if (ExtendedID > 0)
        {
            hdnExtendedID.Value = ExtendedID.ToString();
        }

    }
    public List<EmployeeRegMaster> GetDetail(out List<EmployeeRegMaster> lstEmDetails)
    {
        string Type, Qualification, EmpTypeNumber = string.Empty;
        DateTime doj = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        EmployeeRegMaster erm = new EmployeeRegMaster();
        lstEmDetails = new List<EmployeeRegMaster>();
        long EmpTypeID = -1, DeptID = -1, GradeID = -1, DesignID = -1, EmployerID = -1, EmployerLocationID = -1, EmpID = -1;
        if (Convert.ToInt32(ddlPatientType.SelectedValue) == 1)
        {
            Type = "Emp";
            Qualification = txtQualification.Text;
            doj = txtJoinDate.Text == "" ? doj : Convert.ToDateTime(txtJoinDate.Text);
            EmpTypeID = ddlEmployementType.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployementType.SelectedValue);
            EmpTypeNumber = txtEmployementTypeNo.Text;
            DeptID = ddlDepartment.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlDepartment.SelectedValue);
            GradeID = ddlGrade.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlGrade.SelectedValue);
            DesignID = ddlDesignation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlDesignation.SelectedValue);
            EmployerID = ddlEmployerName.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployerName.SelectedValue);
            EmployerLocationID = ddlEmployerLocation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployerLocation.SelectedValue);

            erm.Type = Type;
            erm.Qualification = Qualification.ToUpper();
            erm.DOJ = doj;
            erm.EmployementTypeID = EmpTypeID;
            erm.EmployementTypeNumber = EmpTypeNumber;
            erm.DeptID = DeptID;
            erm.GradeID = GradeID;
            erm.DesignationID = DesignID;
            erm.EmployerID = EmployerID;
            erm.EmployerLocationID = EmployerLocationID;
            erm.OrgID = OrgID;
            erm.EmpID = hdnEmpID.Value == "" ? -1 : Convert.ToInt64(hdnEmpID.Value);
            lstEmDetails.Add(erm);
        }
        else if (Convert.ToInt32(ddlPatientType.SelectedValue) == 2)
        {
            string Extype = string.Empty;
            int slen = txtEmployerID.Text.Length;
            if (slen > 3)
                Extype = txtEmployerID.Text.Substring(0, 2);
            else
                Extype = txtEmployerID.Text;

            if (Extype == "EX")
            {
                Type = "EXDep";
            }
            else
            {
                Type = "Dep";
            }
                Qualification = ddlRelation.SelectedItem.Text;
                doj = txtJoinDate.Text == "" ? doj : Convert.ToDateTime(txtJoinDate.Text);
                EmpTypeID = ddlEmployementType.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployementType.SelectedValue);
                EmpTypeNumber = txtEmployerID.Text;
                DeptID = ddlDepartment.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlDepartment.SelectedValue);
                GradeID = ddlGrade.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlGrade.SelectedValue);
                DesignID = ddlDesignation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlDesignation.SelectedValue);
                //EmployerID = ddlEmployerName.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployerName.SelectedValue);
                EmployerLocationID = ddlEmployerLocation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployerLocation.SelectedValue);
                EmployerID = ddlRelation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlRelation.SelectedValue);

                erm.Type = Type;
                erm.Qualification = Qualification.ToUpper();
                erm.DOJ = doj;
                erm.EmployementTypeID = EmpTypeID;
                erm.EmployementTypeNumber = EmpTypeNumber;
                erm.DeptID = DeptID;
                erm.GradeID = GradeID;
                erm.DesignationID = DesignID;
                erm.EmployerID = EmployerID;
                erm.EmployerLocationID = EmployerLocationID;
                erm.OrgID = OrgID;
                erm.EmpID = hdnEmpID.Value == "" ? -1 : Convert.ToInt64(hdnEmpID.Value);
                lstEmDetails.Add(erm);
        }
        else if (Convert.ToInt32(ddlPatientType.SelectedValue) == 3)
        {
            string Extype = string.Empty;
            int slen = txtEmployerID.Text.Length;
            if (slen > 3)
                Extype = txtEmployerID.Text.Substring(0, 2);
            else
                Extype = txtEmployerID.Text;
            if (Extype == "EX")
            {
                Type = "EXExt";
            }
            else
            {
                Type = "Ext";
            }
            Qualification = ddlExtended.SelectedItem.Text;
            DateTime date = DateTime.MaxValue;
            doj = txtJoinDate.Text == "" ? doj : Convert.ToDateTime(txtJoinDate.Text);
            EmpTypeID = ddlEmployementType.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployementType.SelectedValue);
            EmpTypeNumber = txtEmployerID.Text;
            DeptID = ddlDepartment.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlDepartment.SelectedValue);
            GradeID = ddlGrade.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlGrade.SelectedValue);
            DesignID = ddlDesignation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlDesignation.SelectedValue);
            //EmployerID = ddlEmployerName.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployerName.SelectedValue);
            EmployerLocationID = ddlEmployerLocation.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlEmployerLocation.SelectedValue);
            EmployerID = ddlExtended.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlExtended.SelectedValue);

            erm.Type = Type;
            erm.Qualification = Qualification.ToUpper();
            erm.DOJ = doj;
            erm.EmployementTypeID = EmpTypeID;
            erm.EmployementTypeNumber = EmpTypeNumber;
            erm.DeptID = DeptID;
            erm.GradeID = GradeID;
            erm.DesignationID = DesignID;
            erm.EmployerID = EmployerID;
            erm.EmployerLocationID = EmployerLocationID;
            erm.OrgID = OrgID;
            erm.EmpID = hdnEmpID.Value == "" ? -1 : Convert.ToInt64(hdnEmpID.Value);
            lstEmDetails.Add(erm);
        }
        else if (Convert.ToInt32(ddlPatientType.SelectedValue) == 4)
        {
            Type = "External";
            EmpTypeID = ddlPatientType.SelectedItem.Text == "---Select---" ? 0 : Convert.ToInt64(ddlPatientType.SelectedValue);
            EmpTypeNumber = txtExternalnumber.Text;
            erm.Type = Type;
            erm.Qualification = "";
            erm.DOJ = doj;
            erm.EmployementTypeID = EmpTypeID;
            erm.EmployementTypeNumber = EmpTypeNumber;
            erm.DeptID = 0;
            erm.GradeID = 0;
            erm.DesignationID = 0;
            erm.EmployerID = 0;
            erm.EmployerLocationID = 0;
            erm.OrgID = OrgID;
            erm.EmpID = 0;
            lstEmDetails.Add(erm);
        }
        return lstEmDetails;

    }

    public void LoadEmployeeDetails(long PatientID, string PatientName, string EmployeeNumber, int OrgID)
    {
        Patient_BL pbl = new Patient_BL(base.ContextInfo);
        long returnCode = -1;
        List<EmployeeRegMaster> lstEmpRegDetails = new List<EmployeeRegMaster>();
        returnCode = pbl.GetEmployerList(PatientID, PatientName, EmployeeNumber, OrgID, out lstEmpRegDetails);
        if (lstEmpRegDetails.Count > 0)
        {
            if (lstEmpRegDetails[0].EmpID == 2)
            {
                ddlPatientType.SelectedValue = "2";
                //ddlPatientType.SelectedValue = lstEmpRegDetails[0].EmployerLocationID.ToString();
                ddlRelation.SelectedValue = lstEmpRegDetails[0].EmployementTypeID.ToString();
                txtEmployerID.Text = lstEmpRegDetails[0].EmployementTypeNumber.ToString();

            }
            else if (lstEmpRegDetails[0].EmpID == 3)
            {
                ddlPatientType.SelectedValue = "3";
                //ddlPatientType.SelectedValue = lstEmpRegDetails[0].EmployerLocationID.ToString();
                ddlExtended.SelectedValue = lstEmpRegDetails[0].EmployementTypeID.ToString();
                txtEmployerID.Text = lstEmpRegDetails[0].EmployementTypeNumber.ToString();

            }
            else if (lstEmpRegDetails[0].EmpID == 4)
            {
                ddlPatientType.SelectedValue = "4";
                //ddlPatientType.SelectedValue = lstEmpRegDetails[0].EmployerLocationID.ToString();
                //ddlExtended.SelectedValue = lstEmpRegDetails[0].EmployementTypeID.ToString();
                txtExternalnumber.Text = lstEmpRegDetails[0].EmployementTypeNumber.ToString();

            }
            else
            {
                txtJoinDate.Text = lstEmpRegDetails[0].DOJ.ToString("dd/MM/yyyy");
                txtQualification.Text = lstEmpRegDetails[0].Qualification;
                if (lstEmpRegDetails[0].DeptID.ToString() != "0")
                    ddlDepartment.SelectedValue = lstEmpRegDetails[0].DeptID.ToString();
                if (lstEmpRegDetails[0].DesignationID.ToString() != "0")
                    ddlDesignation.SelectedValue = lstEmpRegDetails[0].DesignationID.ToString();
                if (lstEmpRegDetails[0].GradeID.ToString() != "0")
                    ddlGrade.SelectedValue = lstEmpRegDetails[0].GradeID.ToString();
                if (lstEmpRegDetails[0].EmployerID.ToString() != "0")
                    ddlEmployerName.SelectedValue = lstEmpRegDetails[0].EmployerID.ToString();
                if (lstEmpRegDetails[0].EmployerLocationID.ToString() != "0")
                    ddlEmployerLocation.SelectedValue = lstEmpRegDetails[0].EmployerLocationID.ToString();
                if (lstEmpRegDetails[0].EmployementTypeID.ToString() != "0")
                    ddlEmployementType.SelectedValue = lstEmpRegDetails[0].EmployementTypeID.ToString();
                ddlPatientType.SelectedValue = "1";
                if (lstEmpRegDetails[0].EmployementTypeID.ToString() != "0")
                    ddlEmployementType.SelectedValue = lstEmpRegDetails[0].EmployementTypeID.ToString();
                txtEmployementTypeNo.Text = lstEmpRegDetails[0].EmployementTypeNumber.ToString();

            }
        }
    }

    protected void lblFetchEmpDetail_Click(object sender, EventArgs e)
    {
        string pname = string.Empty;
        string EmpNumber = string.Empty;
        long retCode = -1;
        long PatientID = 0;
        EmpNumber = TextBoxURN.Text;
        Patient_BL PatBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstPatient = new List<Patient>();
        if (EmpNumber != "")
            retCode = PatBL.GetEMPPatientListForRegis("", EmpNumber, OrgID, out lstPatient);
        //string[] SplitPatient = lstPatient[0].Comments.Split('~');
        if (lstPatient.Count > 0)
        {
            hdnEmpdetails.Value = lstPatient[0].Comments;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:EmpDetails1('" + hdnEmpdetails.Value + "');", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:EmpDetailClar('');", true);
            string sPath = "CommonControls\\\\EmployerRegDetail.ascx.cs_16";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "');", true);
    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Please Check The Employee Number');", true);
            txtEmployementTypeNo.Text = EmpNumber;
        }
        //if (EmpNumber.ToString() != "")
        //{
        //    LoadEmployeeDetails(PatientID, pname, EmpNumber, OrgID);
        //}
        //else
        //{
        //    txtJoinDate.Text = "";
        //    txtQualification.Text = "";
        //    ddlDepartment.SelectedItem.Text = "---Select---";
        //    ddlEmployementType.SelectedItem.Text = "---Select---";
        //    ddlDesignation.SelectedItem.Text = "---Select---";
        //    ddlGrade.SelectedItem.Text = "---Select---";
        //    ddlEmployerName.SelectedItem.Text = "---Select---"; 
        //    ddlEmployerLocation.SelectedItem.Text = "---Select---"; 
        //    ddlPatientType.SelectedValue = "1";
        //    ddlEmployementType.SelectedItem.Text = "---Select---";
        //    txtEmployementTypeNo.Text = "";

        //}

    }
    protected void btnCheckNo_Click(object sender, EventArgs e)
    {
        string pname = string.Empty;
        long retCode = -1;
        Patient_BL PatBL = new Patient_BL(base.ContextInfo);
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
        retCode = PatBL.GetEmployeeNumber(OrgID, txtEmployementTypeNo.Text + "~" + "Emp", ddlEmployerName.SelectedValue == "---Select---" ? -1 : Convert.ToInt32(ddlEmployerName.SelectedValue), out lstEmployeeRegMaster);
        if (lstEmployeeRegMaster.Count > 0)
        {
            txtEmployementTypeNo.Focus();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Emp", "javascript:CheckEmployeeNumber('" + 1 + "');", true);
        }
        else
        {
            txtJoinDate.Focus();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Emp", "javascript:CheckEmployeeNumber('" + 0 + "');", true);
        }
    }
    protected void btnCheckNo1_Click(object sender, EventArgs e)
    {
        string pname = string.Empty;
        long retCode = -1;
        Patient_BL PatBL = new Patient_BL(base.ContextInfo);
        List<EmployeeRegMaster> lstEmployeeRegMaster = new List<EmployeeRegMaster>();
        retCode = PatBL.GetEmployeeNumber(OrgID, txtEmployerID.Text + "~" + "E", ddlExtended.SelectedValue == "---Select---" ? -1 : Convert.ToInt32(ddlExtended.SelectedValue), out lstEmployeeRegMaster);
        if (lstEmployeeRegMaster.Count > 0)
        {
            txtEmployerID.Focus();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Emp", "javascript:CheckExtentedNumber('" + 1 + "');", true);
        }
        else
        {
            txtEmployerID.Focus();
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Emp", "javascript:CheckExtentedNumber('" + 0 + "');", true);
        }
    }
    protected void lblFetchEmpDetails_Click(object sender, EventArgs e)
    {
        string pname = string.Empty;
        string EmpNumber = string.Empty;
        long retCode = -1;
        long PatientID = 0;
        EmpNumber = TextBoxURN.Text;
        Patient_BL PatBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstPatient = new List<Patient>();
        if (EmpNumber != "")
            retCode = PatBL.GetEMPPatientListForRegis("", EmpNumber, OrgID, out lstPatient);
        //string[] SplitPatient = lstPatient[0].Comments.Split('~');
        if (lstPatient.Count > 0)
        {
            hdnEmpdetails.Value = lstPatient[0].Comments;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "skeyShowDuplicate", "javascript:EmpDetails('" + hdnEmpdetails.Value + "');", true);

        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey1", "javascript:EmpDetailClar('');", true);
            string sPath = "CommonControls\\\\EmployerRegDetail.ascx.cs_1";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "');", true);
           // ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Please Check The Employee Number');", true);
            txtEmployerID.Text = EmpNumber;
        }
    }
       
    protected void btnOk1_Click(object sender, EventArgs e)
    {
        List<Familytree> lstfamilytree = new List<Familytree>();
        string dtoRemove = string.Empty;
        string familytree = string.Empty;
        if (hdnDeleted.Value != null)
        {
            dtoRemove = hdnDeleted.Value.ToString();
        }
        if (hdnpatient.Value != null)
            familytree = hdnpatient.Value.ToString();
        string sNewDatas = "";
        bool bDeleted = false;
        foreach (string row in familytree.Split('|'))
        {
            bDeleted = false;
            foreach (string removedrow in dtoRemove.Split('|'))
            {
                if (row.Trim() == removedrow.Trim())
                {
                    bDeleted = true;
                }
            }
            if (bDeleted != true)
            {
                sNewDatas += row.ToString() + "|";
            }
        }
        foreach (string row in sNewDatas.Split('|'))
        {

            if (row.Trim().Length != 0)
            {
                Familytree FTree = new Familytree();

                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];

                    switch (colName)
                    {
                        //var chkBoxName = "EXTERNAME^" + ExternalName + "~EXTERNALID^" + ExternalID + "~EXTERNALPATIENTID^" + ExternalPatientID 
                        //+ "~DEPENDENTSNAME^" + DependentsName + "~DEPENTENTDID^" + DependentsID + "~DEPENTENTSPATIENTID^" 
                        //+ DependentsPatientID + "~RELATIONTYPE^" + RelationType + "";
                        case "EXTERNAME":
                            FTree.ExternalName = colValue;
                            break;
                        case "EXTERNALID":
                            FTree.ExternalNoumber = colValue;
                            break;
                        case "EXTERNALPATIENTID":
                            FTree.ExternalPatientID = Convert.ToInt64(colValue.Trim());
                            break;
                        case "DEPENDENTSNAME":
                            FTree.DependentsName = colValue;
                            break;
                        case "DEPENTENTDID":
                            FTree.DependentsNoumber = colValue;
                            break;
                        case "DEPENTENTSPATIENTID":
                            FTree.DependentsPatientID = Convert.ToInt64(colValue.Trim()); ;
                            break;
                        case "RELATIONTYPE":
                            FTree.DependentsType = colValue;
                            break;
                    };
                }
                FTree.CreatedBy = LID;
                lstfamilytree.Add(FTree);
            }
        }
        long returnCode = -1;
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        if (lstfamilytree.Count > 0)
        {
            returnCode = patientBL.InsertFamilytree(OrgID, lstfamilytree);
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:FnIsvalid1('" + returnCode + "');", true);
        }
        else
        {
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:FnIsvalid1('" + -1 + "');", true);
        }
    }
   
}


