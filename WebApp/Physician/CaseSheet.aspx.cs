using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class Physician_CaseSheet : BasePage
{
    string strCS = "";
    long patientID = -1;
    long patientVisitID = -1;

    /************** About String Parameters **********************/
    /*
     * {0} ==> Salutation + Name
     * {1} ==> Age
     * {2} ==> man/lady
     * {3} ==> PatientHistory
     * {4} ==> Examinations 
     * {5} ==> Investigation List
     * {6} ==> Salutation + Name
     * {7} ==> ComplaintName
     */

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //patientID = Convert.ToInt32(Request.QueryString["pid"].ToString());
            patientVisitID = Convert.ToInt32(Request.QueryString["tid"].ToString());
            //patientVisitID = 1;
            LoadPatientPrescription();
            //if (patientID > 0 && patientVisitID > 0)
            //{
            //    DisplayCaseSheet();
            //    DisplayPrescription();
            //}
        }
        
    }

    private void DisplayPrescription()
    {
        long returnCode = -1;
        Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
        List<DrugDetails> lstDD = new List<DrugDetails>();

        try
        {
            returnCode = physicianBL.GetPatientPrescription(patientVisitID, out lstDD);

            if (returnCode == 0 && lstDD.Count > 0)
            {
                //grdDP.Visible = true;
                //grdDP.DataSource = lstDD;
                //grdDP.DataBind();
            }
            else
            {
                //grdDP.Visible = false;
            }

        }
        catch(Exception ex)
        {
            CLogger.LogError("Error while executing DisplayPrescription", ex);
        }
    }

    protected void grdDP_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.Cells[0].FindControl("lblRowNum");
            lbl.Text = (e.Row.RowIndex+1).ToString();
        }
    }

    private void DisplayCaseSheet()
    {
        long returnCode = -1;
        Physician_BL physicianBL = new Physician_BL(base.ContextInfo);
        List<Patient> lstP = new List<Patient>();
        List<Examination> lstE = new List<Examination>();
        List<Investigation> lstI = new List<Investigation>();
        List<History> lstH = new List<History>();
        List<Complaint> lstC = new List<Complaint>();

        strCS = @"<B><I>{0}</I></B>, {1} yrs old {2} presented with {3} was found to have {4}.
                  Investigations revealed the following: <br><br> {5} <br>
                  <B><I>{6}</I></B> was diagnosed to have <I>{7}</I>";
        string str0 = "";
        string str1 = "";
        string str2 = "";
        string str3 = "";
        string str4 = "";
        string str5 = "";
        string str6 = "";

        try
        {
            returnCode = physicianBL.GetCaseSheetData(patientID, patientVisitID, out lstP, out lstC, out lstI, out lstE, out lstH);

            if (lstP != null)
            {
                str0 = lstP[0].TitleName + lstP[0].Name;
                str1 = lstP[0].Age.ToString();
                str2 = ((lstP[0].SEX.ToUpper() =="M") ? "man" : "lady");
                
            }
            if (lstH != null)
            {
                str3 = GetHistoryString(lstH);
            }
            if (lstE != null)
            {
                str4 = GetExaminationString(lstE);
            }
            if (lstI != null)
            {
                str5 = GetInvestigationString(lstI);
            }
            if (lstC != null)
            {
                str6 = GetComplaintString(lstC);
            }
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = string.Format(strCS, str0, str1, str2, str3, str4, str5, str0, str6);            
        }
        catch(Exception ex)
        {
            CLogger.LogError("Error while executing DisplayCaseSheet", ex);
            //lblCS.Text = "<Center><H3><B> Unable to display CaseSheet. Pl. try later </B></H3></Center>";
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "<Center><H3><B> Unable to display CaseSheet. Pl. try later </B></H3></Center>";
            
        }
    }


    private string GetHistoryString(List<History> lstH)
    {
        string strH ="<I>";
        int iLoop = 1;
        int iCnt = lstH.Count;

        foreach (History h in lstH)
        {
            if (iCnt == 1)
            {
                strH = strH + h.HistoryName + "</I>";
            }
            else
            {
                if (iLoop == iCnt && iCnt != 1)
                {
                    strH = strH.Substring(0,strH.Length-2) + "</I> and <I>" + h.HistoryName + "</I>";
                }
                else
                {
                    strH = strH + h.HistoryName + ", ";
                }
            }
            iLoop += 1;
        }
        return strH;
    }

    private string GetExaminationString(List<Examination> lstE)
    {
        string strE = "<I>";
        int iLoop = 1;
        int iCnt = lstE.Count;

        foreach (Examination e in lstE)
        {
            if (iCnt == 1)
            {
                strE = strE + e.ExaminationName + "</I>";
            }
            else
            {
                if (iLoop == iCnt && iCnt != 1)
                {
                    strE = strE.Substring(0, strE.Length - 2) + "</I> and <I>" + e.ExaminationName + "</I>";
                }
                else
                {
                    strE = strE + e.ExaminationName + ", ";
                }
            }
            iLoop += 1;
        }
        return strE;
    }

    private string GetComplaintString(List<Complaint> lstC)
    {
        string strC = "<I>";
        int iLoop = 1;
        int iCnt = lstC.Count;

        foreach (Complaint e in lstC)
        {
            if (iCnt == 1)
            {
                strC = strC + e.ComplaintName +"</I>";
            }
            else
            {
                if (iLoop == iCnt && iCnt != 1)
                {
                    strC = strC.Substring(0, strC.Length - 2) + "</I> and <I>" + e.ComplaintName + "</I>";
                }
                else
                {
                    strC = strC + e.ComplaintName + ", ";
                }
            }
            iLoop += 1;
        }
        return strC;
    }

    //private string GetInvestigationString(List<Investigation> lstI)
    //{
    //    string strI = "<I>";
    //    int iLoop = 1;
    //    int iCnt = lstI.Count;

    //    foreach (Investigation e in lstI)
    //    {
    //        if (iCnt == 1)
    //        {
    //            strI = strI + e.InvestigationName +"</I>";
    //        }
    //        else
    //        {
    //            if (iLoop == iCnt && iCnt != 1)
    //            {
    //                strI = strI.Substring(0, strI.Length - 2) + "</I> and <I>" + e.InvestigationName + "</I>";
    //            }
    //            else
    //            {
    //                strI = strI + e.InvestigationName + ", ";
    //            }
    //        }
    //        iLoop += 1;
    //    }
    //    return strI;
    //}

    private string GetInvestigationString(List<Investigation> lstI)
    {
        string strI = "<I>";
        //int iLoop = 1;
        //foreach (Investigation e in lstI)
        //{
        //    strI = strI + iLoop.ToString() + "<b>.</b>" + e.Name + "<br>";
        //    iLoop += 1;
        //}

        //strI = strI + "</I>";
        return strI;
    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        try
        {
            Session["PatientVisitID"] = null;

            Response.Redirect("Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    public void LoadPatientPrescription()
    {

        long returnCode = -1;
        PatientPrescription_BL pBL = new PatientPrescription_BL(base.ContextInfo);
        List<PatientPrescription> pTreatment = new List<PatientPrescription>();
        returnCode = pBL.GetTreatment(patientVisitID,"", out pTreatment);

        PatientPrescription1.loadData(pTreatment);


    }
}
