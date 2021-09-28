using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Attune.Podium.BillingEngine;
public partial class Admin_TaskReAssign : BasePage
{
    public Admin_TaskReAssign()
        : base("Admin_TaskReAssign_aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    long roleID = -1;
    string roleName = string.Empty;
    string paymentLogic = string.Empty; string feeType = string.Empty; long billDetailID = -1;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtTaskDate.Attributes.Add("onchange", "ExcedDate('" + txtTaskDate.ClientID.ToString() + "','',0,0); ExcedDate('" + txtTaskDate.ClientID.ToString() + "','txtTaskDate',1,1);");
        try
        {
            if (!IsPostBack)
            {

                txtTaskDate.Text = OrgTimeZone;

                DateTime fDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                DateTime tDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                List<Tasks> lstTasks = new List<Tasks>();
                List<Role> lstRole = new List<Role>();
                string strddlRoleName = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_05 == null ? "Select" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_05;
                returnCode = new Role_BL(base.ContextInfo).GetRoleName(OrgID, out lstRole);
                if (lstRole.Count > 0)
                {
                    ddlRoleName.Visible = true;
                    ddlRoleName.DataSource = lstRole;
                    ddlRoleName.DataTextField = "IntegrationName";
                    ddlRoleName.DataValueField = "RoleID";
                    ddlRoleName.DataBind();
                    ddlRoleName.Items.Insert(0, strddlRoleName);
                    //ddlRoleName.Items.Insert(0, "Select");
                    ddlRoleName.Items[0].Value = "0";

                    divSpeciality.Style.Add("display", "none");
                    divUsers.Style.Add("display", "none");
                    divButton.Style.Add("display", "none");
                    chkAssignToRole.Style.Add("display", "none");
                    string sPath = "Admin\\\\TaskReAssign.aspx.cs_8";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAllAlert1", "javascript:ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAllAlert1", "javascript:alert('Please Filter the Task(s) by Role before reassigining');", true);
                }
                else
                {
                    ddlRoleName.Visible = false;
                }

                //BindTasks();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin/TaskReAssign", ex);
        }
    }

    private void BindTasks()
    {
        DateTime taskDate = Convert.ToDateTime(txtTaskDate.Text);
        DateTime tDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

        List<Tasks> lstTasks = new List<Tasks>();
        List<Role> lstRole = new List<Role>();

        returnCode = new Tasks_BL(base.ContextInfo).GetTasktobeReAssign(txtPatientName.Text, OrgID, 0, taskDate, tDate, out lstTasks);
        if (lstTasks.Count > 0)
        {
            grdTasks.Visible = true;
            grdTasks.DataSource = lstTasks;
            grdTasks.DataBind();
            lblWarning.Visible = true;
        }
        else
        {
            grdTasks.Visible = false;
            lblWarning.Visible = true;
        }
    }

    protected void ddlRoleName_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            List<Tasks> lstTasks = new List<Tasks>();

            DateTime taskDate = Convert.ToDateTime(txtTaskDate.Text);
            DateTime tDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            string strbtnSelect = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_01 == null ? "Select All Tasks" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_01;
            roleID = Convert.ToInt32(ddlRoleName.SelectedValue.ToString());
            roleName = ddlRoleName.SelectedItem.Text;
            returnCode = new Tasks_BL(base.ContextInfo).GetTasktobeReAssign(txtPatientName.Text, OrgID, roleID, taskDate, tDate, out lstTasks);
            if (lstTasks.Count > 0)
            {
                lblMessage.Visible = false;
                lblWarning.Visible = true;
                grdTasks.Visible = true;
                grdTasks.DataSource = lstTasks;
                grdTasks.DataBind();
                if (roleID == 0)
                {
                    btnSelect.Visible = false;
                    btnSelect.Text = strbtnSelect;
                    //btnSelect.Text = "Select All Tasks";
                    string sPath = "Admin\\\\TaskReAssign.aspx.cs_8";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAllAlert2", "javascript:ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAllAlert2", "javascript:alert('Please Filter the Task(s) by Role before reassigining');", true);

                    divSpeciality.Style.Add("display", "none");
                    divUsers.Style.Add("display", "none");
                    divButton.Style.Add("display", "none");
                }
                else
                {
                    //btnSelect.Visible = true;
                    btnSelect.Text = strbtnSelect;

                    if (roleName == "Physician")
                    {
                        List<Speciality> lstSpeciality = new List<Speciality>();

                        divSpeciality.Style.Add("display", "block");
                        divUsers.Style.Add("display", "none");
                        divButton.Style.Add("display", "none");

                        returnCode = new Speciality_BL(base.ContextInfo).GetSpeciality(OrgID, out lstSpeciality);
                        string strddlspeciality = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06;
                        if (lstSpeciality.Count > 0)
                        {
                            ddlspeciality.DataSource = lstSpeciality;
                            ddlspeciality.DataTextField = "SpecialityName";
                            ddlspeciality.DataValueField = "SpecialityID";
                            ddlspeciality.DataBind();
                            ddlspeciality.Items.Insert(0, strddlspeciality);
                            //ddlspeciality.Items.Insert(0, "--Select--");
                            ddlspeciality.Items[0].Value = "0";
                        }
                    }
                    else
                    {
                        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
                        returnCode = new Role_BL(base.ContextInfo).GetUsersAgainstRole(roleID, out lstOrgUsers);
                        string strddlUsers = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06;
                        if (lstOrgUsers.Count > 0)
                        {
                            ddlUsers.DataSource = lstOrgUsers;
                            ddlUsers.DataTextField = "Name";
                            ddlUsers.DataValueField = "LoginID";
                            ddlUsers.DataBind();
                            ddlUsers.Items.Insert(0, strddlUsers);
                            //ddlUsers.Items.Insert(0, "--Select--");
                            ddlUsers.Items[0].Value = "0";

                            divUsers.Style.Add("display", "block");
                            divButton.Style.Add("display", "block");
                        }
                        else
                        {
                            divUsers.Style.Add("display", "none");
                            divButton.Style.Add("display", "none");
                        }
                        divSpeciality.Style.Add("display", "none");

                    }
                }
            }
            else
            {
                string strlblMessage = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_02== null ? "No Matching Records Found" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_02;
                divSpeciality.Style.Add("display", "none");
                divUsers.Style.Add("display", "none");
                divButton.Style.Add("display", "none");

                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAlert", "javascript:alert('There is No Task for the Selected Role');", true);
                lblMessage.Visible = true;
                lblMessage.Text = strlblMessage;
                //lblMessage.Text = "No Matching Records Found";
                chkAssignToRole.Style.Add("display", "none");
                grdTasks.Visible = false;
                btnSelect.Visible = false;
                lblWarning.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin/TaskReAssign", ex);
        }

    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            List<Tasks> lstTasks = new List<Tasks>();

            DateTime taskDate = Convert.ToDateTime(txtTaskDate.Text);
            DateTime tDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            chkAssignToRole.Style.Add("display", "block");
            roleID = Convert.ToInt32(ddlRoleName.SelectedValue.ToString());
            roleName = ddlRoleName.SelectedItem.Text;
            returnCode = new Tasks_BL(base.ContextInfo).GetTasktobeReAssign(txtPatientName.Text, OrgID, roleID, taskDate, tDate, out lstTasks);
            if (lstTasks.Count > 0)
            {
                string strbtnSelect = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_01 == null ? "Select All Tasks" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_01;
                lblMessage.Visible = false;
                lblWarning.Visible = true;
                chkAssignToRole.Checked = false;
                grdTasks.Visible = true;
                grdTasks.DataSource = lstTasks;
                grdTasks.DataBind();
                if (roleID == 0)
                {
                    btnSelect.Visible = false;
                    btnSelect.Text = strbtnSelect; 
                   // btnSelect.Text = "Select All Tasks";
                    string sPath = "Admin\\\\TaskReAssign.aspx.cs_8";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAllAlert2", "javascript:ShowAlertMsg('" + sPath + "');", true);
                    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAllAlert2", "javascript:alert('Please Filter the Task(s) by Role before reassigining');", true);

                    divSpeciality.Style.Add("display", "none");
                    divUsers.Style.Add("display", "none");
                    divButton.Style.Add("display", "none");
                }
                else
                {
                    //btnSelect.Visible = true;
                    btnSelect.Text = strbtnSelect; 
                    //btnSelect.Text = "Select All Tasks";

                    if (roleName == "Physician")
                    {


                        divSpeciality.Style.Add("display", "block");
                        divUsers.Style.Add("display", "none");
                        divButton.Style.Add("display", "none");

                        //returnCode = new Speciality_BL(base.ContextInfo).GetSpeciality(OrgID, out lstSpeciality);
                        List<PhysicianSpeciality> lstPhySpeciality = new List<PhysicianSpeciality>();
                        List<Speciality> lstSpeciality = new List<Speciality>();
                        new PatientVisit_BL(base.ContextInfo).GetSpecialityAndSpecialityName(OrgID, out lstPhySpeciality, 0, out lstSpeciality);
                        string strddlspeciality = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06;
                        if (lstSpeciality.Count > 0)
                        {
                            ddlspeciality.DataSource = lstSpeciality;
                            ddlspeciality.DataTextField = "SpecialityName";
                            ddlspeciality.DataValueField = "SpecialityID";
                            ddlspeciality.DataBind();
                            ddlspeciality.Items.Insert(0, strddlspeciality);
                            //ddlspeciality.Items.Insert(0, "--Select--");
                            ddlspeciality.Items[0].Value = "0";
                        }
                    }
                    else
                    {
                        List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
                        returnCode = new Role_BL(base.ContextInfo).GetUsersAgainstRole(roleID, out lstOrgUsers);
                        string strddlUsers = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06;
                        if (lstOrgUsers.Count > 0)
                        {
                            ddlUsers.DataSource = lstOrgUsers;
                            ddlUsers.DataTextField = "Name";
                            ddlUsers.DataValueField = "LoginID";
                            ddlUsers.DataBind();
                            ddlUsers.Items.Insert(0, strddlUsers);
                           // ddlUsers.Items.Insert(0, "--Select--");
                            ddlUsers.Items[0].Value = "0";

                            divUsers.Style.Add("display", "block");
                            divButton.Style.Add("display", "block");
                        }
                        else
                        {
                            divUsers.Style.Add("display", "none");
                            divButton.Style.Add("display", "none");
                        }
                        divSpeciality.Style.Add("display", "none");

                    }
                }
            }
            else
            {
                divSpeciality.Style.Add("display", "none");
                divUsers.Style.Add("display", "none");
                divButton.Style.Add("display", "none");
                string strlblMessage = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_02 == null ? "No Matching Records Found" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_02;
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyAlert", "javascript:alert('There is No Task for the Selected Role');", true);
                lblMessage.Visible = true;
                lblMessage.Text = strlblMessage;
                //lblMessage.Text = "No Matching Records Found";
                chkAssignToRole.Style.Add("display", "none");
                grdTasks.Visible = false;
                btnSelect.Visible = false;
                lblWarning.Visible = true;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin/TaskReAssign", ex);
        }
    }
    protected void ddlspeciality_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string strddlUsers = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_06;
            if (ddlspeciality.SelectedItem.Text != "--Select--")
            {
                List<Physician> lstPhysician = new List<Physician>();
                new PatientVisit_BL(base.ContextInfo).GetConsultingName(Convert.ToInt64(ddlspeciality.SelectedItem.Value), OrgID, out lstPhysician);

                divUsers.Style.Add("display", "block");
                divButton.Style.Add("display", "block");
                
                ddlUsers.DataSource = lstPhysician;
                ddlUsers.DataTextField = "PhysicianName";
                ddlUsers.DataValueField = "LoginID";
                ddlUsers.DataBind();
                ddlUsers.Items.Insert(0, strddlUsers);
               // ddlUsers.Items.Insert(0, "--Select--");
            }
            else
            {
                ddlUsers.Items.Clear();
                ddlUsers.Items.Insert(0, strddlUsers);
                //ddlUsers.Items.Insert(0, "--Select--");
                divUsers.Style.Add("display", "none");
                divButton.Style.Add("display", "none");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Admin/TaskReAssign", ex);
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        int flag = 0;
        int specialityID = -1;
        long assignedLID = 0;
        int UpdatetaskStatusID = -1;
        long ptaskID = -1;
        decimal existingFee = -1; decimal newFee = -1;
        List<Tasks> lstTasks = new List<Tasks>();

        Tasks task = new Tasks(); Tasks taskPayment = new Tasks();
        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable();
        List<TaskActions> lstTaskAction = new List<TaskActions>();
        List<Patient> lstPatient = new List<Patient>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);

        PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);

        if (ddlRoleName.SelectedItem.Text == "Physician")
        {
            specialityID = Convert.ToInt32(ddlspeciality.SelectedValue.ToString());
            assignedLID = Convert.ToInt64(ddlUsers.SelectedValue.ToString());
        }
        else if ((ddlRoleName.SelectedItem.Text != "Physician") && (chkAssignToRole.Checked == false))
        {
            specialityID = 0;
            assignedLID = Convert.ToInt64(ddlUsers.SelectedValue.ToString());
        }
        else
        {
            if ((ddlRoleName.SelectedItem.Text != "Physician") && (chkAssignToRole.Checked == true))
            {
                specialityID = 0;
                assignedLID = 0;
            }
        }


        foreach (GridViewRow gr in grdTasks.Rows)
        {
            if (((RadioButton)gr.FindControl("rdTasks")).Checked == true)
            {
                Tasks t = new Tasks();  //For Update the Task
                Tasks t1 = new Tasks(); //For Creating New Task
                Label lbTaskID = (Label)gr.FindControl("lblTaskID");
                Label lbPVisitID = (Label)gr.FindControl("lblVisitD");
                Label lbPatientID = (Label)gr.FindControl("lblPatientID");
                Label lbSpecialityID = (Label)gr.FindControl("lblSpecialityID");
                Label lbAssignedTo = (Label)gr.FindControl("lblAssignedTo");

                long lTaskID = Convert.ToInt64(lbTaskID.Text);
                //    lAssignedTo = Convert.ToInt64(lbAssignedTo.Text);
                long lAssignedTo = Convert.ToInt64(lbAssignedTo.Text);
                long lPVisitID = Convert.ToInt64(lbPVisitID.Text);
                long pid = Convert.ToInt64(lbPatientID.Text);
                long sid = Convert.ToInt32(lbSpecialityID.Text);

                t.TaskID = lTaskID;
                t.AssignedTo = lAssignedTo;
                t.PatientVisitID = lPVisitID;

                lstTasks.Add(t);

                flag = flag + 1;

                returnCode = patientBL.GetPatientDemoandAddress(pid, out lstPatient);
                Patient patient = new Patient();
                patient = lstPatient[0];

                long purpID = 1;
                long otherID = specialityID;
                string physicianName = ddlUsers.SelectedItem.Text;
                returnCode = pvisitBL.GetTaskActionID(OrgID, purpID, otherID, out lstTaskAction);

                TaskActions taskAction = new TaskActions();
                if (ddlRoleName.SelectedItem.Text == "Physician")
                {

                    if (sid != specialityID)
                    {

                        for (int i = 0; i < lstTaskAction.Count; i++)
                        {
                            taskAction = lstTaskAction[i];

                            returnCode = Utilities.GetHashTable(taskAction.TaskActionID, lPVisitID, assignedLID,
                                                      pid, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "",
                                                      0, "", out dText, out urlVal, 0,
                                                      patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                            task.TaskActionID = taskAction.TaskActionID;
                            task.DispTextFiller = dText;
                            task.URLFiller = urlVal;
                            task.PatientID = pid;

                            if ((task.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.PerformDiagnosis)) || (task.TaskActionID == Convert.ToInt32(TaskHelper.TaskAction.PerformANCDiagnosis)))
                            {
                                task.AssignedTo = assignedLID;
                            }
                            else
                            {
                                task.AssignedTo = 0;
                            }
                            task.OrgID = OrgID;
                            task.PatientVisitID = lPVisitID;
                            task.SpecialityID = specialityID;
                            task.CreatedBy = LID;

                            UpdatetaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.REASSIGNED);
                            returnCode = new Tasks_BL(base.ContextInfo).ReAssiginingTask(specialityID, assignedLID, LID, UpdatetaskStatusID, lstTasks, task, out ptaskID, out billDetailID);
                            if (returnCode == 0)// && OrgID == 0)
                            {
                                #region Task for Payment

                                feeType = "CON"; payLogic(feeType, out paymentLogic);

                                if (paymentLogic == "Before")
                                {
                                    returnCode = new Tasks_BL(base.ContextInfo).CheckforPaymentTaskReAssigned(assignedLID, lPVisitID, billDetailID, out existingFee, out newFee);

                                    if (newFee > existingFee)
                                    {
                                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, lPVisitID, assignedLID,
                                        pid, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0,
                                        "", ptaskID, feeType, out dText, out urlVal, billDetailID,
                                        patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                                        taskPayment.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                                        taskPayment.DispTextFiller = dText;
                                        taskPayment.URLFiller = urlVal;
                                        taskPayment.PatientID = pid;
                                        //taskPayment.RoleID = RoleID;
                                        taskPayment.OrgID = OrgID;
                                        taskPayment.PatientVisitID = lPVisitID;
                                        taskPayment.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                        taskPayment.CreatedBy = LID;

                                        returnCode = taskBL.CreateTask(taskPayment, out ptaskID);
                                    }
                                    else if (newFee < existingFee)
                                    {
                                        returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, lPVisitID, assignedLID,
                                                                    pid, patient.TitleName + " " + patient.Name,
                                                                    physicianName, otherID, "", 0, "", ptaskID,
                                                                    feeType, out dText, out urlVal, billDetailID,
                                                                    patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                                        taskPayment.TaskActionID = (int)TaskHelper.TaskAction.Refund;
                                        taskPayment.DispTextFiller = dText;
                                        taskPayment.URLFiller = urlVal;
                                        taskPayment.PatientID = pid;
                                        //taskPayment.RoleID = RoleID;
                                        taskPayment.OrgID = OrgID;
                                        taskPayment.PatientVisitID = lPVisitID;
                                        taskPayment.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                        taskPayment.CreatedBy = LID;

                                        returnCode = taskBL.CreateTask(taskPayment, out ptaskID);
                                    }
                                    else
                                    {
                                        long errCode = -1;
                                        returnCode = new BillingEngine(base.ContextInfo).UpdateBillReAssigned(lPVisitID, 0, billDetailID, LID, 1, out errCode);
                                    }
                                }
                                #endregion
                            }
                        }
                    }
                    else
                    {
                        taskAction = lstTaskAction[0];

                        returnCode = Utilities.GetHashTable(taskAction.TaskActionID, lPVisitID, assignedLID,
                                                  pid, patient.TitleName + " " + patient.Name, physicianName,
                                                  otherID, "", 0, "", 0, "", out dText, out urlVal, 0
                                                  , patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                        task.TaskActionID = taskAction.TaskActionID;
                        task.DispTextFiller = dText;
                        task.URLFiller = urlVal;
                        task.PatientID = pid;

                        task.AssignedTo = assignedLID;

                        task.OrgID = OrgID;
                        task.PatientVisitID = lPVisitID;
                        task.SpecialityID = specialityID;
                        task.CreatedBy = LID;

                        UpdatetaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.REASSIGNED);
                        returnCode = new Tasks_BL(base.ContextInfo).ReAssiginingTask(specialityID, assignedLID, LID, UpdatetaskStatusID, lstTasks, task, out ptaskID, out billDetailID);
                        if (returnCode == 0)// && OrgID == 0)
                        {
                            #region Task for Payment

                            feeType = "CON"; payLogic(feeType, out paymentLogic);

                            if (paymentLogic == "Before")
                            {
                                returnCode = new Tasks_BL(base.ContextInfo).CheckforPaymentTaskReAssigned(assignedLID, lPVisitID, billDetailID, out existingFee, out newFee);

                                if (newFee > existingFee)
                                {
                                    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, lPVisitID, assignedLID,
                                    pid, patient.TitleName + " " + patient.Name, physicianName, otherID, "", 0, "", ptaskID,
                                    feeType, out dText, out urlVal, billDetailID,
                                    patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                                    taskPayment.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                                    taskPayment.DispTextFiller = dText;
                                    taskPayment.URLFiller = urlVal;
                                    taskPayment.PatientID = pid;
                                    //taskPayment.RoleID = RoleID;
                                    taskPayment.OrgID = OrgID;
                                    taskPayment.PatientVisitID = lPVisitID;
                                    taskPayment.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                    taskPayment.CreatedBy = LID;

                                    returnCode = taskBL.CreateTask(taskPayment, out ptaskID);
                                }
                                else if (newFee < existingFee)
                                {
                                    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.Refund, lPVisitID, assignedLID,
                                    pid, patient.TitleName + " " + patient.Name,
                                    physicianName, otherID, "", 0, "", ptaskID,
                                    feeType, out dText, out urlVal, billDetailID, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                                    taskPayment.TaskActionID = (int)TaskHelper.TaskAction.Refund;
                                    taskPayment.DispTextFiller = dText;
                                    taskPayment.URLFiller = urlVal;
                                    taskPayment.PatientID = pid;
                                    //taskPayment.RoleID = RoleID;
                                    taskPayment.OrgID = OrgID;
                                    taskPayment.PatientVisitID = lPVisitID;
                                    taskPayment.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                                    taskPayment.CreatedBy = LID;

                                    returnCode = taskBL.CreateTask(taskPayment, out ptaskID);
                                }
                                else
                                {
                                    long errCode = -1;
                                    returnCode = new BillingEngine(base.ContextInfo).UpdateBillReAssigned(lPVisitID, 0, billDetailID, LID, 1, out errCode);
                                }
                            }
                            #endregion
                        }
                    }
                }
                else
                {
                    UpdatetaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Pending);
                    returnCode = new Tasks_BL(base.ContextInfo).ReAssiginingTask(specialityID, assignedLID, LID, UpdatetaskStatusID, lstTasks);
                }

            }
        }
        if (flag > 0)
        {


            BindTasks();

            divSpeciality.Style.Add("display", "none");
            divUsers.Style.Add("display", "none");
            divButton.Style.Add("display", "none");
            ddlRoleName.SelectedValue = "0";
            string strlblMessage1 = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_03 == null ? "Task has been re-assigned successfully" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_03;
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyTaskAlertSucess", "javascript:alert('Task has been re-assigned successfully');", true);
            lblMessage.Visible = true;
           // lblMessage.Text = "Task has been re-assigned successfully";
            lblMessage.Text = strlblMessage1;
            chkAssignToRole.Style.Add("display", "none");
            btnSelect.Visible = false;
        }
        else
        {
            string sPath = "Admin\\\\TaskReAssign.aspx.cs_11";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyTaskAlert", "javascript:ShowAlertMsg('" + sPath + "');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyTaskAlert", "javascript:alert('Select alteast one task to Re Assign');", true);
        }
    }
    protected void btnSelect_Click(object sender, EventArgs e)
    {
        //btnSelect.Visible = true;
        string strbtnSelect = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_01 == null ? "Select All Tasks" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_01;
        string strlblMessage2 = Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_04 == null ? "Un Select All Tasks" : Resources.Admin_ClientDisplay.Admin_TaskReassisn_aspx_04;
        if (btnSelect.Text == "Select All Tasks")
        {
            foreach (GridViewRow gr in grdTasks.Rows)
            {
                ((CheckBox)gr.FindControl("chkTasks")).Checked = true;
            }
            btnSelect.Text = strlblMessage2;
            //btnSelect.Text ="Un Select All Tasks;
        }
        else
        {
            foreach (GridViewRow gr in grdTasks.Rows)
            {
                ((CheckBox)gr.FindControl("chkTasks")).Checked = false;
            }
            btnSelect.Text = strbtnSelect;
            //btnSelect.Text = "Select All Tasks";
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        List<Role> lstUserRole1 = new List<Role>();
        string path1 = string.Empty;
        Role role1 = new Role();
        role1.RoleID = RoleID;
        lstUserRole1.Add(role1);
        returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
        Response.Redirect(Request.ApplicationPath + path1, true);
    }

    private void payLogic(string fType, out string payLogic)
    {
        payLogic = string.Empty;
        List<Config> lstConfig = new List<Config>();
        new GateWay(base.ContextInfo).GetConfigDetails(feeType, OrgID, out lstConfig);
        if (lstConfig.Count > 0)
            payLogic = lstConfig[0].ConfigValue.Trim();
    }
    protected void grdTasks_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string strScript = "SelectTaskReAssign('" + ((RadioButton)e.Row.Cells[1].FindControl("rdTasks")).ClientID + "');";
            ((RadioButton)e.Row.Cells[0].FindControl("rdTasks")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
            ((RadioButton)e.Row.Cells[0].FindControl("rdTasks")).Attributes.Add("onclick", strScript);
        }
    }
}
