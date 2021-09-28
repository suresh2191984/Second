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
using Attune.Podium.BusinessEntities;
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
using System.Linq;

public partial class Dialysis_DialysisCaseSheet : BasePage
{
    long visitID = 0;
    long pid = 0;
    long selTaskID = 0;
    int complaintID = 0;
    bool isPreDialysis = true;
    string PatientName = string.Empty;
    string Age = "0";
    decimal AmountReceived = 0;
    long PatientID = 0;
    //int OrgID = 1;
    protected void Page_Load(object sender, EventArgs e)
    {
        visitID = Convert.ToInt64(Request.QueryString["vid"]);
        //visitID = 1;
        selTaskID = Convert.ToInt64(Request.QueryString["tid"]);
        complaintID = Convert.ToInt32(Request.QueryString["cid"]);
        LoadPatientPrescription();
        long returnCode = -1;
        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
        DialysisRecord dr = new DialysisRecord();
        List<VitalsUOMJoin> vitalsUOMJoin = new List<VitalsUOMJoin>();
        List<Complication> parentComplications = new List<Complication>();
        List<Complication> complications = new List<Complication>();

        try
        {
            returnCode = dbl.GetDialysisCaseSheet(visitID, OrgID, out dr, out vitalsUOMJoin, 
                out parentComplications, out complications,out PatientID, out PatientName, 
                out Age, out AmountReceived);

            if (returnCode == 0)
            {
                lblPatientName.Text = PatientName;
                lblAge.Text = Age.ToString();
                LoadDialysisRecord(dr);
                LoadDialysisVitals(vitalsUOMJoin);
                LoadComplication(parentComplications, complications);
                GetPayment(visitID);
                        
            }
            SetLabelFormat();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Dialysis CaseSheet Page_Load ", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "Unable to Load Page. Pl. try again later or contact Admin";
            
        }
            
    }

    public void LoadPatientPrescription()
    {

        long returnCode = -1;
        PatientPrescription_BL pBL = new PatientPrescription_BL(base.ContextInfo);
        List<PatientPrescription> pTreatment = new List<PatientPrescription>();
        returnCode = pBL.GetTreatment(visitID,"", out pTreatment);

        Treatment.loadData(pTreatment);


    }

    private long GetPayment(long pVisit)
    {
        long returnCode = -1;
        Payment_BL payBL = new Payment_BL(base.ContextInfo);
        List<PatientPayments> patPay = new List<PatientPayments>();
        returnCode = payBL.GetPaymentDetails(pVisit, out patPay);
        if(patPay.Count>0)
        {
            prnbal.Text =  patPay[0].Balance.ToString();
            lCA.Text = patPay[0].Amount.ToString();
            lTA.Text = (patPay[0].Balance + patPay[0].Amount).ToString();            
        }
        return returnCode;
        
    }

    private void LoadDialysisRecord(DialysisRecord dr)
    {
        //DateTime dt1 = new DateTime(2008,12,12,dr.HDStartTime.Hours,dr.HDStartTime.Minutes,dr.HDStartTime.Seconds);

        lblHDNo.Text = dr.HDNo.ToString();
        lblToday.Text = dr.HDDate.ToString("d");
        lblStartTime.Text = dr.HDStartTime.ToString("h:mm tt");

        //dt1 = new DateTime(2008, 12, 12, dr.HDEndTime.Hours, dr.HDEndTime.Minutes, dr.HDEndTime.Seconds);

        lblEndTime.Text = dr.HDEndTime.ToString("h:mm tt"); //string.Format("{0:t}", dr.HDEndTime);
        //dt1 = dr.NextHDDateTime;
        lblNextHD.Text = dr.NextHDDateTime.ToString("dd/MM/yyyy h:mm tt");
        lblAccessSide.Text = dr.AccessSide == "L" ? "Left" : "Right";
        lblAccessSite.Text = dr.AccessName;
        lblBTS.Text = dr.BTS;
        lblDialyzer.Text = dr.DialyserUsed;
        lblPreWtGain.Text = dr.WeightGain;
    }

    private void LoadDialysisVitals(List<VitalsUOMJoin> vitalsUOMJoin)
    {
        string strVitalsname = "";
        string vitalsID;
        string UOMCode;
        string vitalsValue;

        string strIDControl = "";
        string strValueControl = "";
        string strUOMControl = "";

        if (vitalsUOMJoin.Count > 0)
        {
            foreach (VitalsUOMJoin vuj in vitalsUOMJoin)
            {
                strVitalsname = vuj.VitalsName;
                vitalsID = vuj.VitalsID.ToString();
                vitalsValue = Convert.ToString(vuj.VitalsValue) != "0" ? Convert.ToString(vuj.VitalsValue) : "";
                UOMCode = vuj.UOMCode;

                if (strVitalsname != "UF" && strVitalsname != "Heparin")
                {
                    strValueControl = "lblPre" + strVitalsname;

                    if (this.FindControl(strValueControl) != null)
                    {
                        if (vuj.SessionType == "0")
                            ((Label)this.FindControl(strValueControl)).Text = vitalsValue;
                        strValueControl = "lblPost" + strVitalsname;
                        if (vuj.SessionType == "1")
                            ((Label)this.FindControl(strValueControl)).Text = vitalsValue;

                        strUOMControl = "lblPre" + strVitalsname + "UOMCode";
                        ((Label)this.FindControl(strUOMControl)).Text = UOMCode;
                        strUOMControl = "lblPost" + strVitalsname + "UOMCode";
                        ((Label)this.FindControl(strUOMControl)).Text = UOMCode;
                    }
                }
                else
                {
                    if (strVitalsname == "Heparin")
                    {
                        strValueControl = "lblPre" + strVitalsname;
                        if (this.FindControl(strValueControl) != null)
                        {
                            ((Label)this.FindControl(strValueControl)).Text = vitalsValue;

                            strUOMControl = "lblPre" + strVitalsname + "UOMCode";
                            ((Label)this.FindControl(strUOMControl)).Text = UOMCode;
                        }
                    }
                    else
                    {
                        strValueControl = "lblPost" + strVitalsname;
                        if (this.FindControl(strValueControl) != null)
                        {
                            ((Label)this.FindControl(strValueControl)).Text = vitalsValue;

                            strUOMControl = "lblPost" + strVitalsname + "UOMCode";
                            ((Label)this.FindControl(strUOMControl)).Text = UOMCode;
                        }
                    }
                }

                if (lblPreWtGain.Text != "")
                {
                    lblWtGain.Text = lblPreWeightUOMCode.Text;
                }
                else
                {
                    lblWtGain.Text = "&nbsp;";
                }
            }
        }
    }

    private void LoadPatientPrescription(List<PatientPrescription> prescription)
    {
        long returnCode = -1;
        Physician_BL pbl = new Physician_BL(base.ContextInfo);
        List<DrugDetails> drugDetails = new List<DrugDetails>();
        returnCode = pbl.GetPatientPrescription(visitID, out drugDetails);

        if (returnCode == 0 & drugDetails.Count > 0)
        {
            //advMedicine.SetPrescription(drugDetails);
        }
    }

    private void SetLabelFormat()
    {
        lblPreSBP.Text = lblPreSBP.Text.Contains(".") ? lblPreSBP.Text.Remove(lblPreSBP.Text.IndexOf(".")) : lblPreSBP.Text;
        lblPrePulse.Text = lblPrePulse.Text.Contains(".") ? lblPrePulse.Text.Remove(lblPrePulse.Text.IndexOf(".")) : lblPrePulse.Text;
        lblPreDBP.Text = lblPreDBP.Text.Contains(".") ? lblPreDBP.Text.Remove(lblPreDBP.Text.IndexOf(".")) : lblPreDBP.Text;
        lblPreHeparin.Text = lblPreHeparin.Text.Contains(".") ? lblPreHeparin.Text.Remove(lblPreHeparin.Text.IndexOf(".")) : lblPreHeparin.Text;
        lblPreTemp.Text = lblPreTemp.Text.Contains(".") ? lblPreTemp.Text.Remove(lblPreTemp.Text.IndexOf(".") + 2) : lblPreTemp.Text;
        lblPreWeight.Text = lblPreWeight.Text.Contains(".") ? lblPreWeight.Text.Remove(lblPreWeight.Text.IndexOf(".") + 2) : lblPreWeight.Text;
        lblPreWtGain.Text = lblPreWtGain.Text.Contains(".") ? lblPreWtGain.Text.Remove(lblPreWtGain.Text.IndexOf(".") + 2) : lblPreWtGain.Text;

        lblPostSBP.Text = lblPostSBP.Text.Contains(".") ? lblPostSBP.Text.Remove(lblPostSBP.Text.IndexOf(".")) : lblPostSBP.Text;
        lblPostPulse.Text = lblPostPulse.Text.Contains(".") ? lblPostPulse.Text.Remove(lblPostPulse.Text.IndexOf(".")) : lblPostPulse.Text;
        lblPostDBP.Text = lblPostDBP.Text.Contains(".") ? lblPostDBP.Text.Remove(lblPostDBP.Text.IndexOf(".")) : lblPostDBP.Text;
        lblPostUF.Text = lblPostUF.Text.Contains(".") ? lblPostUF.Text.Remove(lblPostUF.Text.IndexOf(".")) : lblPostUF.Text;
        lblPostTemp.Text = lblPostTemp.Text.Contains(".") ? lblPostTemp.Text.Remove(lblPostTemp.Text.IndexOf(".") + 2) : lblPostTemp.Text;
        lblPostWeight.Text = lblPostWeight.Text.Contains(".") ? lblPostWeight.Text.Remove(lblPostWeight.Text.IndexOf(".") + 2) : lblPostWeight.Text;
    }

    private void LoadComplication(List<Complication> parentComplications, List<Complication> complications)
    {
        foreach (Complication p in parentComplications)
        {
            int pid = p.ComplicationID;
            string pname = p.ComplicationName;

            var queryHistory = from cmp in complications
                               where cmp.ParentID == pid
                               select cmp;

            if (pid == 1)
            {
                bltG.DataSource = queryHistory;
                bltG.DataTextField = "ComplicationName";
                bltG.DataValueField = "ComplicationID";
                bltG.DataBind();
                lblbltG.Visible = false;
            }
            else if (pid == 2)
            {
                bltA.DataSource = queryHistory;
                bltA.DataTextField = "ComplicationName";
                bltA.DataValueField = "ComplicationID";
                bltA.DataBind();
                lblbltA.Visible = false;
            }
            else if (pid == 3)
            {
                bltM.DataSource = queryHistory;
                bltM.DataTextField = "ComplicationName";
                bltM.DataValueField = "ComplicationID";
                bltM.DataBind();
                lblbltM.Visible = false;
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string errorText = "Unable to insert payment details. Pl. try again later or contact administrator";
        long returnCode = -1;
        decimal Amount = 0;
        string redirectURL = "";

        try
        {
            Payment_BL payBL = new Payment_BL(base.ContextInfo);
            PatientPayments pp = new PatientPayments();
            decimal.TryParse(tAR.Text, out Amount);
            pp.PatientVisitID = visitID;
            pp.PatientID = PatientID;
            pp.AmountReceived = Amount;
            returnCode = payBL.InsertAmoutPaid(pp);

            if (returnCode == 0)
            {
                errorText = "Unable to update task. Pl. try again later or contact administrator";
                Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                returnCode = tbl.UpdateTask(selTaskID, TaskHelper.TaskStatus.Completed, UID);
            }

            if (returnCode == 0)
            {
                redirectURL = "~/Dialysis/DialysisCaseSheetPrint.aspx?vid=" + visitID.ToString();
                Response.Redirect(redirectURL, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError(errorText, ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = errorText;            
        }

    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/Reception/Home.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

}
