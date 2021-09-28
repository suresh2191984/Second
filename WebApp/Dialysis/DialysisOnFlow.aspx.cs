using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Dialysis_DialysisOnFlow : BasePage
{
    ArrayList al = new ArrayList();
    long visitID = -1;
    long selTaskID = -1;
    long procedureID = -1;
    int onflowCount = 0;
    List<DialysisOnFlow> lstDialysisOnFlow = new List<DialysisOnFlow>();
    protected void Page_Load(object sender, EventArgs e)
    {
    
        txtSBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtDBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtAP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtVP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtTemp.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtBFlow.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtUFRate.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtUFRemoval.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPulse.Attributes.Add("onKeyDown", "return validatenumber(event);");

        if (IsValidEntry())
        {
            pnlVitals.Visible = true;
            if (!IsPostBack)
            {
                LoadControls();
                patientHeader.PatientVisitID = visitID;
                patientHeader.ShowVitalsDetails();
            }
        }
        else
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Invalid credentials. Pl. login and try again";            
        }
    }

    private bool IsValidEntry()
    {
        if (Request.QueryString["vid"] != null && Request.QueryString["tid"] != null && OrgID > 0)
        {
            visitID = Convert.ToInt64(Request.QueryString["vid"]);
            selTaskID = Convert.ToInt64(Request.QueryString["tid"]);

            return true;
        }

        return false;
    }

    /// <summary>
    /// Loads the control dynamically on demand.
    /// </summary>
    /// <param name="TransType">Insert/Update</param>
    /// <param name="pid">PatientID</param>
    private void LoadControls()
    {
        long returnCode = -1;
        string strVitalsname = "";
        string strIDControl = "";
        //string strNameControl = "";
        string strTextControl = "";
        string strUOMControl = "";

        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
        List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();

        try
        {
            returnCode = dbl.GetDialysisOnFlowVitals(OrgID, out lstVitalsUOMJoin);

            if (returnCode == 0)
            {
                foreach (VitalsUOMJoin vuj in lstVitalsUOMJoin)
                {
                    strVitalsname = vuj.VitalsName;
                    strIDControl = "lbl" + strVitalsname + "VitalsID";
                    //strNameControl = "lbl" + strVitalsname + "VitalsName";
                    strTextControl = "txt" + strVitalsname;
                    strUOMControl = "lbl" + strVitalsname + "UOMCode";
                    al.Add(strVitalsname);
                    ((Label)this.FindControl(strIDControl)).Text = vuj.VitalsID.ToString();
                    //((Label)this.FindControl(strNameControl)).Text = vuj.VitalsName;
                    ((Label)this.FindControl(strUOMControl)).Text = vuj.UOMCode;
                    ((TextBox)this.FindControl(strTextControl)).Text = Convert.ToString(vuj.VitalsValue) != "0" ? Convert.ToString(vuj.VitalsValue) : "";
                }
            }

            ViewState.Add("DialysisOnFlow", al);
        }
        catch (Exception e1)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "An error has occured while loading the page.Pl. contact admin";            
            CLogger.LogError("Error in method DialysisOnFlow.LoadControls :", e1);
        }
    }

    public bool GetDialysisVitals(out List<DialysisOnFlowDetails> lstPatientVitals)
    {
        bool blnReturn = true;
        bool isNoInput = true;
        bool hasNegative = false;

        string strVitalsname = "";
        string strIDControl = "";
        string strVitalsValue = "";
        string strTextControl = "";
        string strError = "";

        lstPatientVitals = new List<DialysisOnFlowDetails>();
        DialysisOnFlowDetails patientVitals;

        ArrayList al = (ArrayList)ViewState["DialysisOnFlow"];
        
        try
        {
            for (int i = 0; i <= (al.Count - 1); i++)
            {
                strVitalsname = al[i].ToString();
                strIDControl = "lbl" + strVitalsname + "VitalsID";
                strTextControl = "txt" + strVitalsname;

                patientVitals = new DialysisOnFlowDetails();
                //visitID is alos going to be the same
                patientVitals.PatientVisitID = visitID;
                strVitalsValue = ((TextBox)this.FindControl(strTextControl)).Text;
                //Set the VitalsID value
                patientVitals.VitalsID = Convert.ToInt32(((Label)this.FindControl(strIDControl)).Text);

                if (strVitalsValue != "" && !strVitalsValue.Contains("-"))
                {
                  isNoInput = false;
                  //Set the actual Vitals Value
                  patientVitals.VitalsValue = Convert.ToDecimal(strVitalsValue);
                }
                lstPatientVitals.Add(patientVitals);

                if (strVitalsValue.Contains("-"))
                {
                  blnReturn = false;
                  hasNegative = true;
                }
            }
        }
        catch(Exception ex)
        {
            blnReturn = false;
            strError = strError + "Enter valid value for " + strVitalsname + ".";
            CLogger.LogError("Error while executing GetDialysisVitals:" + strError, ex);
        }

        if (!blnReturn || isNoInput)
        {
            blnReturn = false;
            if (isNoInput)
            {
                //btnSave.Enabled = true;
                strError = "Please enter atleast one value. Negative values are invalid";
            }
            else
            {
                if (hasNegative)
                {
                    strError = "Negative values are invalid" + strError;
                }
            }
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = strError;            
        }

        return blnReturn;
    }

    private bool GetDialysisOnFlow(out DialysisOnFlow dialysisOnFlow)
    {
        bool retval =false;

        dialysisOnFlow = new DialysisOnFlow();

        try
        {
            dialysisOnFlow.PatientVisitID = visitID;
            dialysisOnFlow.CreatedBy = LID;
            dialysisOnFlow.OnFlowDateTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
            dialysisOnFlow.Remarks = txtRemarks.Text;
            dialysisOnFlow.OrgID = OrgID;
            retval = true;
        }
        catch (Exception ex)
        {
            CLogger.LogFatal("Error in DialysisOnflow.GetDialysisOnFlow", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Unable to save Onflow data. Pl. Contact admin.";
            
        }

        return retval;
    }

    private long SaveDialysisOnFlow()
    {
        long returnCode = -1;

        try
        {
            List<DialysisOnFlowDetails> lstDPV = new List<DialysisOnFlowDetails>();
            DialysisOnFlow dialysisOnFlow = new DialysisOnFlow();
            if (GetDialysisVitals(out lstDPV))
            {
                if (GetDialysisOnFlow(out dialysisOnFlow))
                {
                    Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
                    returnCode = dbl.SaveDialysisOnFlow(dialysisOnFlow, lstDPV);
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing SaveDialysisOnFlow", ex);
        }

        return returnCode;
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //btnSave.Enabled = false;
        long returnCode = -1;
        string errorText = "";
        long taskID = -1;
        try
        {
            returnCode = SaveDialysisOnFlow();

            Tasks iTask = GetInsertTask("O");
            Tasks uTask = GetUpdateTask();

            //Make Task Entrynfor Onlfow monitoring
            if (returnCode == 0)
            {
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                errorText = "Unable to update task details. Please contact Admin";
                returnCode = tbl.UpdateAndCreateTask(iTask, uTask,out taskID);
            }

            if (returnCode == 0)
                if (returnCode == 0)
                {
                    Navigation navigation = new Navigation();
                    Role role = new Role();
                    role.RoleID = RoleID;
                    List<Role> userRoles = new List<Role>();
                    userRoles.Add(role);
                    string relPagePath = string.Empty;
                    returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

                    if (returnCode == 0)
                    {
                        Response.Redirect(Request.ApplicationPath + relPagePath, true);
                    }
                }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = errorText;            
            CLogger.LogError("Error while executing btnSave_Click in DialysisOnFlow", ex);
        }
    }

    protected void btnComplete_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string errorText = "";
        long taskID = -1;

        try
        {
            returnCode = SaveDialysisOnFlow();

            Tasks iTask = GetInsertTask("P");
            Tasks uTask = GetUpdateTask();

            //Make Task Entrynfor Onlfow monitoring
            if (returnCode == 0)
            {
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                errorText = "Unable to update task details. Please contact Admin";
                returnCode = tbl.UpdateAndCreateTask(iTask, uTask, out taskID);
            }

            if (returnCode == 0)
            {
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

                if (returnCode == 0)
                {
                    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = errorText;            
            CLogger.LogError("Error while executing btnComplete_Click" + errorText, ex);
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
            tbl.UpdateTask(selTaskID, TaskHelper.TaskStatus.Pending, UID);
           
                Navigation navigation = new Navigation();
                Role role = new Role();
                role.RoleID = RoleID;
                List<Role> userRoles = new List<Role>();
                userRoles.Add(role);
                string relPagePath = string.Empty;
                navigation.GetLandingPage(userRoles, out relPagePath);

               
                    Response.Redirect(Request.ApplicationPath + relPagePath, true);
                
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error Updating Task in DialysisRecord's Cancel button click :", ex);
        }

    }

    #region Task

    private Tasks GetInsertTask(string sType)
    {

        long pid =0;
        string PatientName = string.Empty;
        string MachineName = string.Empty;
        string LastTestTime = string.Empty;

        Int64.TryParse(Request.QueryString["ProcID"], out procedureID);

        Tasks tsk = new Tasks();
        Hashtable htDispText = new Hashtable();
        Hashtable htURL = new Hashtable();

        //htURL.Add("PatientVisitID", visitID.ToString());

        Dialysis_BL dialysisBl = new Dialysis_BL(base.ContextInfo);

        dialysisBl.GetHTParamsForOnFlowTask(visitID, out pid, out PatientName,out MachineName,out LastTestTime);
        dialysisBl.GetDialysisOnflowCount(visitID, out onflowCount);

        if (sType.Equals("P"))
        {
            tsk.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PostDialysis);
            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.OnFlowMonitoring), visitID, 0, pid, PatientName, "",
                procedureID, MachineName, onflowCount, LastTestTime, 0, "", out htDispText, out htURL, 0, "", 0, "");
        }
        else
        {
            tsk.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.OnFlowMonitoring);
            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.OnFlowMonitoring), visitID, 0, pid, PatientName, "",
                procedureID, MachineName, onflowCount, LastTestTime, 0, "", out htDispText, out htURL, 0, "", 0, "");
        }

        tsk.PatientID = pid;
        tsk.PatientVisitID = visitID;
        tsk.OrgID = OrgID;
        tsk.CreatedBy = LID;
        tsk.DispTextFiller = htDispText;
        tsk.URLFiller = htURL;
        return tsk;
    }

    private Tasks GetUpdateTask()
    {
        Tasks tsk = new Tasks();

        tsk.TaskID = selTaskID;
        tsk.TaskStatusID = Convert.ToInt32(TaskHelper.TaskStatus.Completed);
        tsk.ModifiedBy = LID;

        return tsk;
    }

    #endregion
}
