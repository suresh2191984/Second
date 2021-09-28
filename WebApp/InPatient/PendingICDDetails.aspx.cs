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

public partial class InPatient_PendingICDDetails : BasePage
{
    List<PatientComplaint> lstPatientComplaint;
    List<PatientComplaint> lstBackgroundProblem;
    List<PatientComplaint> lstPatientComplication;
    List<PatientComplaint> lstOperationComplication;
    List<PatientComplaint> lstCauseOfDeath;
    List<PatientComplaint> lstPhysioCompliant;



    long PatientVisitID = -1;
    string VisitType = string.Empty;
    long returnCode = -1;

    Patient_BL objPatient_BL;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
            BindPendingICDDetails();
            BindPagesToView();
            
        }
    }

   

    private void BindPagesToView()
    {
        List<PatientComplaint> lstPCT = new List<PatientComplaint>();
        List<BackgroundProblem> lstBP = new List<BackgroundProblem>();
        List<PatientComplication> lstPCN = new List<PatientComplication>();
        List<OperationComplication> lstOPC = new List<OperationComplication>();
        List<CauseOfDeath> lstCOD = new List<CauseOfDeath>();
        List<PhysioCompliant> lstPHYC = new List<PhysioCompliant>();
        objPatient_BL = new Patient_BL(base.ContextInfo);
        objPatient_BL.ViewPageByICDCode(PatientVisitID, VisitType,ddlStatus.SelectedValue, out lstPCT, out lstBP, out lstPCN, out lstOPC, out lstCOD, out lstPHYC);

        if (lstPCT.Count > 0)
        {
            foreach (PatientComplaint PCT in lstPCT)
            {
                if (PCT.ComplaintType == "CRC")
                {
                    liAN.Style.Add("display", "block");
                }
                if (PCT.ComplaintType == "DSY")
                {
                    li1DSY.Style.Add("display", "block");
                }
                if (PCT.ComplaintType == "PDI")
                {
                    liPDI.Style.Add("display", "block");
                }
                if (PCT.ComplaintType == "QIC")
                {
                    liPDI.Style.Add("display", "block");
                }
                if (PCT.ComplaintType == "UNF")
                {
                    liPDI.Style.Add("display", "block");
                }
            }
        }


        if (lstBP.Count > 0)
        {
            foreach (BackgroundProblem BP in lstBP)
            {
                if (BP.PreparedAt == "CRCB")
                {
                    liAN.Style.Add("display", "block");
                }
                if (BP.PreparedAt == "CRCO")
                {
                    liAN.Style.Add("display", "block");
                }
                if (BP.PreparedAt == "NNN")
                {
                    liNNN.Style.Add("display", "block");
                }
               
            }
        }

       
        if (lstPCN.Count > 0)
        {
            foreach (PatientComplication PCN in lstPCN)
            {
                if (PCN.ComplicationType == "Birth")
                {
                    liDVN.Style.Add("display", "block");
                }               
            }
        }

        if(lstCOD.Count>0)
        {
            liDeath.Style.Add("display", "block");
        }

        if (lstOPC.Count > 0)
        {
            liOP.Style.Add("display", "block");
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
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        objPatient_BL.GetPendingICDCodes(PatientVisitID, "IP", ddlStatus.SelectedValue, out lstPatientComplaint, out lstBackgroundProblem, out lstPatientComplication, out lstOperationComplication, out lstCauseOfDeath, out lstPhysioCompliant);      

      
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

        if (lstPatientComplicationRes.Count == 0 && lstBackgroundProblemtRes.Count == 0 && lstPatientComplicationRes.Count == 0)
        {
            lblMsg.Visible = true;
        }
        else
        {
            lblMsg.Visible = false;
        }

        PendingICDCodePCT.BindData(lstPatientComplaintRes);
       
        PendingICDCodeBP.HeaderText = "BackgroundProblem";
       
        PendingICDCodeBP.BindData(lstBackgroundProblemtRes);
        PendingICDCodePCN.HeaderText = "Complication";
      
        PendingICDCodePCN.BindData(lstPatientComplicationRes);
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        lstPatientComplaint = new List<PatientComplaint>();
        lstBackgroundProblem = new List<PatientComplaint>();
        lstPatientComplication = new List<PatientComplaint>();
        

        lstPatientComplaint = PendingICDCodePCT.GetPatientComplaint();
        
        lstBackgroundProblem = PendingICDCodeBP.GetPatientComplaint();
     
        lstPatientComplication = PendingICDCodePCN.GetPatientComplaint();


        objPatient_BL = new Patient_BL(base.ContextInfo);
        returnCode=objPatient_BL.UpdatePendingICDCodes(PatientVisitID, "IP", lstPatientComplaint, lstBackgroundProblem, lstPatientComplication);


       
        objPatient_BL.UpdatePatientICDStatus(PatientVisitID);
       

        if (returnCode == 0)
        {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('Changes saved successfully.');", true);

        }

       
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
                Response.Redirect(Request.ApplicationPath  + relPagePath, true);
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
    protected void ddlStatus_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindPendingICDDetails();
       
    }
    protected void lbtnOP_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        string skey = "../Physician/OperationNotesCaseSheet.aspx?vid="
                            + PatientVisitID.ToString()
                            + "&IsPopup=" + "Y"
                            + "&page=" + "ICD" + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
    }
    protected void lbtnAN_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        string skey = "../Physician/IPCaseRecordSheet.aspx?vid="
                           + PatientVisitID.ToString()
                           + "&IsPopup=" + "Y"
                           + "&page=" + "ICD" + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
    }
   
    protected void LinkDSY_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        if (OrgID != 26)
        {

            //string skey = "../Physician/DischargeSummaryCaseSheet.aspx?vid="
            //                  + PatientVisitID.ToString()
            //                  + "&IsPopup=" + "Y"
            //                   + "&vType=" + "IP"
            //                  + "&page=" + "ICD" + "";

            string skey = "../DischargeSummary/DischargeSummaryDynamic.aspx?vid="
                             + PatientVisitID.ToString()
                             + "&IsPopup=" + "Y"
                              + "&vType=" + "IP"
                             + "&page=" + "ICD" + "";

            this.Page.RegisterStartupScript("sky",
              "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
        }
        else
        {
            string skey = "../InPatient/RakshithDischargeSummary.aspx?vid="
                             + PatientVisitID.ToString()
                             + "&IsPopup=" + "Y"
                             + "&vType=" + "IP"
                             + "&page=" + "ICD" + "";

            this.Page.RegisterStartupScript("sky",
              "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
        }
    }
    protected void lbtnDeath_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        string skey = "../InPatient/DeathCaseSheet.aspx?vid="
                                     + PatientVisitID.ToString()
                                     + "&IsPopup=" + "Y"
                                     + "&vType=" + "IP"
                                     + "&page=" + "ICD" + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
    }
    protected void lbtnNNN_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        string skey = "../InPatient/NeonatalCaseSheet.aspx?vid="
                                    + PatientVisitID.ToString()
                                    + "&IsPopup=" + "Y"
                                    + "&vType=" + "IP"
                                    + "&page=" + "ICD" + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
    }
    protected void lbtnDVN_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        string skey = "../InPatient/DeliveryNotes.aspx?vid="
                                            + PatientVisitID.ToString()
                                            + "&IsPopup=" + "Y"
                                            + "&vType=" + "IP"
                                            + "&page=" + "ICD" + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
    }
    protected void lbtnPDI_Click(object sender, EventArgs e)
    {
        Int64.TryParse(Request.QueryString["vid"], out PatientVisitID);
        string skey = "../CaseSheet/ViewCaseSheet.aspx?vid="
                                                    + PatientVisitID.ToString()
                                                    + "&IsPopup=" + "Y"                                                   
                                                    + "&page=" + "ICD" + "";

        this.Page.RegisterStartupScript("sky",
          "<script language='javascript'> window.open('" + skey + "', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');</script>");
    }
}
