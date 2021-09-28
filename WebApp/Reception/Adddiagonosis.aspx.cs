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
using System.Runtime.InteropServices;

public partial class Reception_Adddiagonosis : BasePage
{
    public Reception_Adddiagonosis(): base("Reception\\Adddiagonosis.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    List<PatientComplaint> lstPatientComplaint;
    List<PatientComplaint> lstBackgroundProblem;
    List<PatientComplaint> lstPatientComplication;
    List<PatientComplaint> lstOperationComplication;
    List<PatientComplaint> lstCauseOfDeath;
    List<PatientComplaint> lstPhysioCompliant;
    string save_mesge = Resources.AppMessages.Update_Message;


     
    string VisitType = string.Empty;
    long returnCode = -1;
    long visitID = -1;
    Patient_BL objPatient_BL;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
            if (Request.QueryString["vid"] != null)
            {
                Int64.TryParse(Request.QueryString["vid"], out visitID);
                BindPendingICDDetails();
            }

            List<Patient> lstPatient = new List<Patient>();
            objPatient_BL = new Patient_BL(base.ContextInfo);
            objPatient_BL.GetPatientDetailsVisitID(visitID, out lstPatient);
            if(lstPatient.Count > 0)
            {

                foreach (Patient item in lstPatient)
                {
                    lblPatientID.Text = item.PatientID.ToString();
                    lblPatientName.Text = item.Name.ToString();
                    if(item.VisitType != null)
                    lblVisitType.Text = item.VisitType;
                    if (item.SEX == "M")
                        lblPatientSex.Text = "Male";
                    if(item.SEX == "F")
                        lblPatientSex.Text = "Female";
                    lblPatientAge.Text = item.Age;
                    lblPatientAddress.Text = item.Add1 + "," + item.Add2 + "," + item.Add3 ;
                }

            }
            

        }
    }

    private void BindPendingICDDetails()
    {
        lstPatientComplaint = new List<PatientComplaint>();
        lstBackgroundProblem = new List<PatientComplaint>();
        lstPatientComplication = new List<PatientComplaint>();
        lstOperationComplication = new List<PatientComplaint>();
        lstCauseOfDeath = new List<PatientComplaint>();
        lstPhysioCompliant = new List<PatientComplaint>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        Int64.TryParse(Request.QueryString["vid"], out visitID);
        objPatient_BL.GetPendingICDCodes(visitID, "IP", "All", out lstPatientComplaint, out lstBackgroundProblem, out lstPatientComplication, out lstOperationComplication, out lstCauseOfDeath, out lstPhysioCompliant);
        

        PendingICDCodePCT.HeaderText = "Diagnosis";

        var listPC = from Res in lstPatientComplaint
                     orderby Res.ComplaintType
                     select Res;

        List<PatientComplaint> lstPatientComplaintRes = listPC.ToList<PatientComplaint>();

        var listBP = from Res in lstBackgroundProblem
                     orderby Res.ComplaintType
                     select Res;

        List<PatientComplaint> lstBackgroundProblemtRes = listBP.ToList<PatientComplaint>();

        var listPCMP = from Res in lstPatientComplication
                       orderby Res.ComplaintType
                       select Res;

        List<PatientComplaint> lstPatientComplicationRes = listPCMP.ToList<PatientComplaint>();

        PendingICDCodePCT.Mode = "View";
        PendingICDCodePCT.BindData(lstPatientComplaintRes);

        PendingICDCodeBP.HeaderText = "BackgroundProblem";

        PendingICDCodeBP.Mode = "View";
        PendingICDCodeBP.BindData(lstBackgroundProblemtRes);
        PendingICDCodePCN.HeaderText = "Complication";
        PendingICDCodePCN.Mode = "View";
        PendingICDCodePCN.BindData(lstPatientComplicationRes);
        uctrlAddDiagonosis.SetPatientComplaint(lstPatientComplaint);
        uctrlAddDiagonosis.SetPatientBackgroundProblem(lstBackgroundProblem);

    


        
        
        
        
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {

        try
        {
            Navigation navigation = new Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }


    protected void btnFinish_Click(object sender, EventArgs e)
    {
         
         Int64.TryParse(Request.QueryString["vid"], out visitID);

         List<BackgroundProblem> lstBackgroundPrb = new List<BackgroundProblem>();
         List<PatientComplaint> lstPatientComplaint= new List<PatientComplaint>();

         lstBackgroundPrb = uctrlAddDiagonosis.GetPatientBackgroundProblem("NPDI", 0, visitID);
         
         lstPatientComplaint = uctrlAddDiagonosis.GetPatientComplaint("NPDI", visitID);

         objPatient_BL = new Patient_BL(base.ContextInfo);
         long pid = Convert.ToInt64(lblPatientID.Text);

         returnCode = objPatient_BL.SaveAddDiagonasis(visitID, pid, lstBackgroundPrb, lstPatientComplaint,LID);


         if (returnCode> 0)
         {
            
             objPatient_BL.UpdatePatientICDStatus(visitID);
             BindPendingICDDetails();
             if (returnCode >0)
             {

                 ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+save_mesge +"');", true);
                 //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Changes saved successfully.');", true);

             }

         }

    }
}

