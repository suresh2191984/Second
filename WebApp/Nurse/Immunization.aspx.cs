using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using System.Collections;
using System.Security.Cryptography;
using System.Web.Security;
using System.Text;

public partial class Nurse_Immunization : BasePage
{

    public Nurse_Immunization()
        : base("Nurse\\Immunization.aspx")
    {
    }
    long visitID = 0;
    long patientID = 0;
    long returnCode = -1;
    long taskID = -1;
    List<Patient> patientList = new List<Patient>();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            patientID = Convert.ToInt64(Request.QueryString["pid"]);
            visitID = Convert.ToInt64(Request.QueryString["vid"]);
            patientHeader.PatientID = patientID;
            
            if (!IsPostBack)
            {
                #region Retrieve Patient Details

                returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out patientList);
                if (patientList.Count > 0)
                {
                    lblPName.Text = patientList[0].TitleName + ' ' + patientList[0].Name;
                    lblPAge.Text = patientList[0].Age;
                    //string pAgeDWMY = patientList[0].Age.Split(' ')[1];
                    //if (pAgeDWMY == "D")
                    //{
                    //    lblPAge.Text = patientList[0].Age.Split(' ')[0] + " Days";
                    //}
                    //else if (pAgeDWMY == "W")
                    //{
                    //    lblPAge.Text = patientList[0].Age.Split(' ')[0] + " Weeks";
                    //}
                    //else if (pAgeDWMY == "M")
                    //{
                    //    lblPAge.Text = patientList[0].Age.Split(' ')[0] + " Months";
                    //}
                    //else
                    //{
                    //    lblPAge.Text = patientList[0].Age.Split(' ')[0] + " Years";
                    //}

                }

                #endregion

                #region Retrieve Vaccination Details to Immunize

                List<Vaccination> lstVacctoImmunize = new List<Vaccination>();

                returnCode = new Immunize_BL(base.ContextInfo).GetVaccinationtoImmunize(out lstVacctoImmunize);
                if (lstVacctoImmunize.Count > 0)
                {
                    chkImmunize.DataSource = lstVacctoImmunize;
                    chkImmunize.DataTextField = "VaccinationName";
                    chkImmunize.DataValueField = "VaccinationID";
                    chkImmunize.DataBind();
                }

                #endregion

                #region Retrieve Vaccination Details which already immunized

                List<PatientBabyVaccination> lstPBV = new List<PatientBabyVaccination>();
                returnCode = new Immunize_BL(base.ContextInfo).GetPatientBabyVaccListbyPID(patientID, out lstPBV);
                if (lstPBV.Count > 0)
                {
                    Panel2.Style.Add("display", "block");
                    //Panel2.Visible = true;
                    grdDetails.DataSource = lstPBV;
                    grdDetails.DataBind();
                }
                else
                {
                    Panel2.Style.Add("display", "none");
                    //Panel2.Visible = false;
                }

                #endregion
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Nurse/Immunization.aspx", ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int pOrderedCount = -1;
        int flag = -1;
        try
        {
            List<PatientBabyVaccination> lstPBV = new List<PatientBabyVaccination>();
            foreach (ListItem li in chkImmunize.Items)
            {
                PatientBabyVaccination pbv = new PatientBabyVaccination();
                if (li.Selected)
                {
                    pbv.PatientVisitID = visitID;
                    pbv.PatientID = patientID;
                    pbv.VaccinationID = Convert.ToInt32(li.Value);
                    pbv.VaccinationName = li.Text;
                    pbv.ImmunizedPeriod = lblPAge.Text;
                    pbv.CreatedBy = LID;
                    //pbv.ModifiedBy = null;
                    pbv.Paymentstatus = "Ordered";
                    flag = flag + 1;
                    lstPBV.Add(pbv);
                }
            }

            string HidVacc = HdnVaccList.Value;
            foreach (string splitString in HidVacc.Split('^'))
            {
                if (splitString != string.Empty)
                {
                    string[] lineItems = splitString.Split('~');
                    if (lineItems.Length > 0)
                    {
                        PatientBabyVaccination objVacc = new PatientBabyVaccination();
                        objVacc.PatientVisitID = visitID;
                        objVacc.PatientID = patientID;
                        objVacc.VaccinationID = 0;
                        objVacc.VaccinationName = lineItems[0];
                        objVacc.ImmunizedPeriod = lblPAge.Text;
                        objVacc.CreatedBy = LID;
                        objVacc.Paymentstatus = "Ordered";
                        flag = flag + 1;
                        lstPBV.Add(objVacc);
                    }
                }
            }

            if (flag > -1)
            {

                returnCode = new Immunize_BL(base.ContextInfo).InsertPatientBabyVaccination(lstPBV, out pOrderedCount);

                if (pOrderedCount > 0)
                {
                    Tasks task = new Tasks();
                    Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();
                    List<TaskActions> lstTaskAction = new List<TaskActions>();
                    long proID = 0;
                    long createdtaskID = -1;

                    returnCode = new Patient_BL(base.ContextInfo).GetPatientDemoandAddress(patientID, out patientList);
                    Patient patient = new Patient();
                    patient = patientList[0];

                    returnCode = Utilities.GetHashTable((long)TaskHelper.TaskAction.CheckPayment, visitID, 0,
                                patientID, patient.TitleName + " " + patient.Name, "", proID, "", 0, "", 0,
                                "IMU", out dText, out urlVal, 0, patient.PatientNumber, patient.TokenNumber, ""); // Other Id meand Procedure ID

                    task.TaskActionID = (int)TaskHelper.TaskAction.CheckPayment;
                    task.DispTextFiller = dText;
                    task.URLFiller = urlVal;
                    task.PatientID = patientID;
                    task.OrgID = OrgID;
                    task.PatientVisitID = visitID;
                    task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
                    task.CreatedBy = LID;
                    returnCode = taskBL.CreateTask(task, out createdtaskID);

                    long taskkID = -1;
                    taskkID = Convert.ToInt64(Request.QueryString["tid"]);
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskkID, TaskHelper.TaskStatus.Completed, LID);

                    Response.Redirect(@"~\Billing\CheckPayment.aspx?vid=" + visitID + "&pid=" + patientID + "&ptid=" + 0 + "&ftype=" + "IMU" + "&tid=" + createdtaskID + "", true);
                }
                taskID = Convert.ToInt64(Request.QueryString["tid"]);
                returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(taskID, TaskHelper.TaskStatus.Completed, LID);

                List<Role> lstUserRole1 = new List<Role>();
                string path1 = string.Empty;
                Role role1 = new Role();
                role1.RoleID = RoleID;
                lstUserRole1.Add(role1);
                returnCode = new Navigation().GetLandingPage(lstUserRole1, out path1);
                Response.Redirect(Request.ApplicationPath + path1, true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKeyalert", "javascript:alert('Please Choose atleast one Vaccine');", true);
            }

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Immunization.aspx btnSave_Click", ex);
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
}
