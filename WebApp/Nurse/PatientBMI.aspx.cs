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

public partial class PatientBMI : BasePage
{
    public PatientBMI()
        : base("Nurse\\PatientBMI.aspx")
    {
    }

    long iPatientID = -1;
    string type = "I";
    int NewVitalsSetID = -1;
    long visitID = -1;
    long visitid = -1;
    long returnCode = -1;
    long patientID = -1;
    int VisitType = -1;
    long vType = -1;
    long VitalsCount = -1;
    string pid;

    protected void Page_Load(object sender, EventArgs e)
    {
        bool hasError = false;
        if (Request.QueryString["PID"] == null || Request.QueryString["PID"] == "")
        {
            Response.Redirect("~/Nurse/Home.aspx", true);
        }
        iPatientID = Convert.ToInt64(Request.QueryString["PID"]);
        //iPatientID = 9;
        //visitID = 9;
        pid = iPatientID.ToString();
        patientID = iPatientID;
       if (!Page.IsPostBack)
        {
            try
            {
                returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID, out vType, out VitalsCount);             
                if (visitID > 0)
                {
                    if (vType == 1 && VitalsCount == 0)
                    {
                        type = "I";
                        patientvitals.VisitID = visitID;
                        patientvitals.LoadControls(type, patientID);
                    }
                    else
                    {
                        if (vType == 0 && VitalsCount > 0)
                        {
                            type = "U";
                            patientvitals.VisitID = visitID;
                            patientvitals.LoadControls(type, iPatientID);
                        }
                        else
                        {
                            type = "I";
                            patientvitals.VisitID = visitID;
                            patientvitals.LoadControls(type, iPatientID);
                        }
                    }
                }
                else
                {
                    btnFinish.Enabled = false;
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "There is No visit for this patient.";
                }
                
                //type = "I";
                //patientvitals.VisitID = visitID;
                //patientvitals.LoadControls(type, patientID);
            }
            catch (SqlException sx)
            {
                hasError = true;
                CLogger.LogError("Error while executing Page Load in PatientVitals.aspx(SqlException)", sx);
            }
            catch (ArithmeticException ax)
            {
                hasError = true;
                CLogger.LogError("Error while executing Page Load in PatientVitals.aspx(ArithmeticException)", ax);
            }
            catch (Exception ex)
            {
                hasError = true;
                CLogger.LogError("Error while executing Page Load in PatientVitals.aspx(Exception)", ex);
            }
        }
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {            
        
            //#region Commented Code           
                int iConditionID;
                long returnCode;
                string strNurseNotes = "";
                bool blnRetval = false;
                PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);            
                List<Attune.Podium.BusinessEntities.PatientVitals> lstPatientVitals = new List<Attune.Podium.BusinessEntities.PatientVitals>();
                blnRetval = patientvitals.GetPageValues(out lstPatientVitals);
                returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID, out vType, out VitalsCount);              
                foreach (Attune.Podium.BusinessEntities.PatientVitals patientVitals in lstPatientVitals)
                {
                    patientVitals.PatientID = iPatientID;
                    patientVitals.PatientVisitID = visitID;
                }
                //Prasanna  added Below lines
                //Int64.TryParse(Request.QueryString["PID"], out patientID);
               // returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID, out vType, out VitalsCount);
                //Prasanna  added lines ends
                //if (blnRetval)
                //{
                //    List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                //    //sami  added Below lines
                //    PatientVisit_BL oPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
                //    returnCode = oPatientVisit_BL.GetVisitDetails(visitID, out lstPatientVisit);
                //    foreach (var opatieentVistDetails in lstPatientVisit)
                //    {
                //        VisitType = opatieentVistDetails.VisitType;
                //    }
                //    if (VisitType != 0)
                //    {
                //        long retCode = -1;                      

                //        List<Attune.Podium.BusinessEntities.PatientVitals> lstMaxOfVitalsSetID = new List<Attune.Podium.BusinessEntities.PatientVitals>();                    

                //        foreach (var vitalsetid in lstMaxOfVitalsSetID)
                //        {
                //            NewVitalsSetID = vitalsetid.VitalsSetID;
                //        }
                //        //sami  added  lines ends
                //    }                    
                    // sami added new parameter 'VisitType'    
                    VisitType=0;               
                    returnCode = patientVitalBL.SavePatientVitals(OrgID, VisitType, lstPatientVitals);                    
                    if (returnCode != -1)
                    {
                        Response.Redirect("Home.aspx", true);
                    }
                }
            //}

        
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
            }


    protected void btnClose_Click(object sender, EventArgs e)
    {

        try
        {
            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
}
