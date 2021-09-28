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

public partial class Physician_DialysisRecord : BasePage
{
    ArrayList al = new ArrayList();

    long visitID = 1;
    long pid = 0;
    long selTaskID = 0;
    int complaintID = 0;
    bool isPreDialysis = true;
    long procedureID = -1;
    string PaymentLogic = String.Empty;
    long lprocedureID = -1;
    int onflowCount = 0;
    List<DialysisOnFlow> lstDialysisOnFlow = new List<DialysisOnFlow>();
    ////int OrgID = 1;

    protected void Page_Load(object sender, EventArgs e)
    {        
        txtPreSBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPreDBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPreTemp.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPrePulse.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPreWeight.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtWtGain.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtPreHeparin.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtDryWeight.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtBedName.Attributes.Add("onKeyDown", "return validatenumber(event);");

        txtPostSBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPostDBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPostTemp.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPostPulse.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPostWeight.Attributes.Add("onKeyDown", "return validatenumber(event);");
       // txtComments.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtPostUF.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtBTS.Attributes.Add("onKeyDown", "return validatenumber(event);");
        //txtDialyzer.Attributes.Add("onKeyDown", "return validatenumber(event);");

        tNextHDDate.Attributes.Add("OnChange", "ExcedDate('" + tNextHDDate.ClientID.ToString() + "','',0,1);");
        btnSubmit.Attributes.Add("onClick", "return CheckHDDate();");

        if (Request.QueryString["vid"] != null)
        {
            visitID = Convert.ToInt64(Request.QueryString["vid"]);
            selTaskID = Convert.ToInt64(Request.QueryString["tid"]);

            //visitID = 1;
            //selTaskID = 3;
            //complaintID = 2;
            txtPreWeight.Attributes.Add("OnChange", "javascript:CalcWeightGain();");
        }
         Int64.TryParse(Request.QueryString["ProcID"], out lprocedureID);

        if (!IsPostBack)
        {
            try
            {
                //tNextHDDate.Text = "";

                //Step1: Load Access
                LoadAccesses();

                //Step2: Load Dialysis Record (HDNO, Date, StartTime, etc...)
                LoadDialysisRecord(OrgID, visitID, out isPreDialysis);

                //Step3: Load VitalControls
                LoadControls(OrgID);

                patientHeader.PatientVisitID = visitID;
                patientHeader.ShowVitalsDetails();

                if (!isPreDialysis)
                {
                    if (PaymentLogic == String.Empty)
                    {
                        List<Config> lstConfig = new List<Config>();
                        new GateWay(base.ContextInfo).GetConfigDetails("PRO", OrgID, out lstConfig);
                        if (lstConfig.Count > 0)
                            PaymentLogic = lstConfig[0].ConfigValue.Trim();
                    }
                    if (PaymentLogic == "After")
                    {
                        //chkAdditionalPayments.Visible = false;
                        pnlMiscellaneous.Visible = false;
                    }
                    else
                    {
                        chkAdditionalPayments.Visible = true;
                        pnlMiscellaneous.Visible = true;
                    }
                    //Format the PreDialysis Textboxes
                    FormatText();

                    //Step4: Load Conditions
                    LoadConditions();

                    //Step5: Load Complications
                     LoadComplications();

                     DialysisOnFlow.GetData(visitID, true);
                }
                else
                {
                    //chkAdditionalPayments.Visible = false;
                    pnlMiscellaneous.Visible = false;
                    pnlNextHD.Visible = false;
                    pnlFb.Visible = false;
                    pnlPost.Visible = false;
                    pnlDescription.Visible = false;
                    //pnlfeesentry.Visible = false;
                }
            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while executing Page Load in DialysisRecord.aspx", ex);
                return;
            }
             
        }
    }

    #region Load Dialysis Record

    private void LoadDialysisRecord(int orgID, long visitID, out bool isPreDialysis)
    {
        long returnCode = -1;
        int hdno = -1;
        decimal prevWt = 0;
        isPreDialysis = true;

        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
        DialysisRecord dialysisRecord= new DialysisRecord();

        try
        {
            returnCode = dbl.GetDialysisRecord(orgID, visitID, out hdno, out pid, out prevWt, out dialysisRecord);

            if (returnCode == 0)
            {
                if (dialysisRecord!=null)
                {
                    DateTime dt = new DateTime();
                    isPreDialysis = false;
                    btnSubmit.Text = "Finish";
                    //Pre-populate PreDialysis details
                    txtHDNo.Text = dialysisRecord.HDNo.ToString();
                    dt = dialysisRecord.HDDate;
                    txtToday.Text = dt.ToString("dd/MM/yyyy");
                    //dt = new DateTime().Add(dialysisRecord.HDStartTime);
                    txtStartTime.Text = dialysisRecord.HDStartTime.ToString("h:mm tt");
                    txtEndTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("h:mm tt");
                    txtBedName.Text = dialysisRecord.MachineName;

                    for (int i = 0; i <= ddAccess.Items.Count; i++)
                    {
                        if (Convert.ToInt16(ddAccess.Items[i].Value) == dialysisRecord.AccessID)
                        {
                            ddAccess.Items[i].Selected = true;
                            break;
                        }
                    }

                    for (int i = 0; i <= ddSide.Items.Count; i++)
                    {
                        if (ddSide.Items[i].Value == dialysisRecord.AccessSide)
                        {
                            ddSide.Items[i].Selected = true;
                            break;
                        }
                    }

                    if(dialysisRecord.WeightGain != null)
                        txtWtGain.Text = dialysisRecord.WeightGain == "0" ? "" : dialysisRecord.WeightGain;
                }
                else
                {
                    isPreDialysis = true;
                    txtHDNo.Text = hdno.ToString();
                    txtToday.Text = DateTime.Today.ToString("dd/MM/yyyy");
                    txtStartTime.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("h:mm tt");
                }

                if (prevWt > 0)
                {
                    txtprevWt.Value = prevWt.ToString();
                }
                else
                {
                    txtprevWt.Value = "0";
                }
            }
            else
            {
                //lblStatus.Text = "An error has occured. Pl. try again later...";
                ErrorDisplay1.Status = "An error has occured. Pl. try again later...";
                ErrorDisplay1.ShowError = true;
                CLogger.LogWarning("GetDialysisRecord returned error status");
            }

        }
        catch (Exception e1)
        {
            CLogger.LogError("Error while executing LoadDialysisRecord method", e1);
        }
    }

    #endregion

    #region Load Access Sites

    private void LoadAccesses()
    {
        long returnCode = -1;

        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
        List<DialysisAccess> lstAccess = new List<DialysisAccess>();

        try
        {
            returnCode = dbl.GetDialysisAccess(out lstAccess);
        }
        catch (Exception e1)
        {
            CLogger.LogError("Error while executing LoadAccesses", e1);
        }

        if (returnCode == 0)
        {
            ddAccess.DataSource = lstAccess;
            ddAccess.DataTextField = "AccessName";
            ddAccess.DataValueField = "AccessID";
            ddAccess.DataBind();
        }

    }

    #endregion

    #region LoadControls
    /// <summary>
    /// Loads the control dynamically on demand.
    /// </summary>
    /// <param name="TransType">Insert/Update</param>
    /// <param name="pid">PatientID</param>
    public void LoadControls(int orgID)
    {
        long returnCode = -1;

        string strVitalsname = "";
        string vitalsID;
        string UOMCode;
        string vitalsValue;

        string strIDControl = "";
        //string strNameControl = "";
        string strTextControl = "";
        string strUOMControl = "";

        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
        List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();

        try
        {
            if (isPreDialysis)
            {
                returnCode = dbl.GetDialysisVitals(orgID, out lstVitalsUOMJoin);
            }
            else
            {
                returnCode = dbl.GetDialysisVitalsForUpd(orgID, visitID, out lstVitalsUOMJoin);
            }
        }
        catch (Exception e1)
        {
            CLogger.LogError("Error while executing LoadControls", e1);
        }

        if (returnCode == 0)
        {
            foreach (VitalsUOMJoin vuj in lstVitalsUOMJoin)
            {
                strVitalsname = vuj.VitalsName;
                vitalsID = vuj.VitalsID.ToString();
                vitalsValue = Convert.ToString(vuj.VitalsValue) != "0" ? Convert.ToString(vuj.VitalsValue) : "";
                UOMCode = vuj.UOMCode;

                if (strVitalsname != "UF" && strVitalsname != "Heparin")
                {
                    strIDControl = "lblPre" + strVitalsname + "VitalsID";

                    if (this.FindControl(strIDControl) != null)
                    {
                        ((Label)this.FindControl(strIDControl)).Text = vitalsID;
                        strIDControl = "lblPost" + strVitalsname + "VitalsID";

                        ((Label)this.FindControl(strIDControl)).Text = vitalsID;
                        strTextControl = "txtPre" + strVitalsname;

                        if(vuj.SessionType == "0")
                            ((TextBox)this.FindControl(strTextControl)).Text = vitalsValue;
                        strTextControl = "txtPost" + strVitalsname;
                        if(vuj.SessionType == "1")
                            ((TextBox)this.FindControl(strTextControl)).Text = vitalsValue;

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
                        strIDControl = "lblPre" + strVitalsname + "VitalsID";
                        ((Label)this.FindControl(strIDControl)).Text = vitalsID;

                        strTextControl = "txtPre" + strVitalsname;
                        ((TextBox)this.FindControl(strTextControl)).Text = vitalsValue;

                        strUOMControl = "lblPre" + strVitalsname + "UOMCode";
                        ((Label)this.FindControl(strUOMControl)).Text = UOMCode;
                    }
                    else
                    {
                        strIDControl = "lblPost" + strVitalsname + "VitalsID";
                        ((Label)this.FindControl(strIDControl)).Text = vitalsID;

                        strTextControl = "txtPost" + strVitalsname;
                        ((TextBox)this.FindControl(strTextControl)).Text = vitalsValue;

                        strUOMControl = "lblPost" + strVitalsname + "UOMCode";
                        ((Label)this.FindControl(strUOMControl)).Text = UOMCode;
                    }
                }

                lblWtGain.Text = lblPreWeightUOMCode.Text;
                al.Add(strVitalsname);
            }
        }

        ViewState.Add("Vitals", al);
    }

    #endregion

    #region LoadPatientCondition

    private void LoadConditions()
    {
        long returnCode = -1;

        PatientCondition_BL patientConditionBL = new PatientCondition_BL(base.ContextInfo);
        List<PatientCondition> lstPatientCondition = new List<PatientCondition>();

        try
        {
            returnCode = patientConditionBL.GetPatientConditions(out lstPatientCondition);
        }
        catch (Exception e1)
        {
            CLogger.LogError("Error while executing LoadConditions", e1);
        }

        if (returnCode == 0)
        {
            dCond.DataSource = lstPatientCondition;
            dCond.DataTextField = "Condition";
            dCond.DataValueField = "ConditionID";
            dCond.DataBind();
        }

    }

    #endregion

    #region Load Complications

    /// <summary>
    /// Gets the complications for a complaint and loads the three check boxes
    /// </summary>
    /// <param name="compID"></param>
    //void LoadComplications()
    //{
    //    long returnCode = -1;
    //    try
    //    {
    //        Uri_BL URIBL = new Uri_BL(base.ContextInfo);
    //        List<Complication> parent = new List<Complication>();
    //        List<Complication> child = new List<Complication>();

    //        returnCode = URIBL.GetComplicationsByComplaintName("HaemoDialysis", out complaintID, out parent, out child);

    //        if (returnCode == 0)
    //        {
    //            foreach (Complication p in parent)
    //            {
    //                int pid = p.ComplicationID;
    //                string pname = p.ComplicationName;

    //                var queryHistory = from cmp in child
    //                                   where cmp.ParentID == pid
    //                                   select cmp;

    //                if (pid == 1)
    //                {
    //                    chkG.DataSource = queryHistory;
    //                    chkG.DataTextField = "ComplicationName";
    //                    chkG.DataValueField = "ComplicationID";
    //                    chkG.DataBind();
    //                }
    //                else if (pid == 2)
    //                {
    //                    chkA.DataSource = queryHistory;
    //                    chkA.DataTextField = "ComplicationName";
    //                    chkA.DataValueField = "ComplicationID";
    //                    chkA.DataBind();
    //                }
    //                else if (pid == 3)
    //                {
    //                    chkM.DataSource = queryHistory;
    //                    chkM.DataTextField = "ComplicationName";
    //                    chkM.DataValueField = "ComplicationID";
    //                    chkM.DataBind();
    //                }
    //            }
    //        }
    //        else
    //        {
    //            pnlFb.Visible = false;
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error while executing LoadComplications", ex);
    //    }
    //}


    //13/02/2009
    void LoadComplications()
    {
        long returnCode = -1;
        try
        {
            ProcedureComplications_BL ProcCompBL = new ProcedureComplications_BL(base.ContextInfo);
           
            List<Complication> parent = new List<Complication>();
            List<Complication> child = new List<Complication>();

            returnCode = ProcCompBL.GetComplications(1, out parent, out child);

            if (returnCode == 0)
            {
                foreach (Complication p in parent)
                {
                    int pid = p.ComplicationID;
                    string pname = p.ComplicationName;

                    var queryHistory = from cmp in child
                                       where cmp.ParentID == pid
                                       select cmp;

                    if (pid == 1)
                    {
                        chkG.DataSource = queryHistory;
                        chkG.DataTextField = "ComplicationName";
                        chkG.DataValueField = "ComplicationID";
                        chkG.DataBind();
                    }
                    else if (pid == 2)
                    {
                        chkA.DataSource = queryHistory;
                        chkA.DataTextField = "ComplicationName";
                        chkA.DataValueField = "ComplicationID";
                        chkA.DataBind();
                    }
                    else if (pid == 3)
                    {
                        chkM.DataSource = queryHistory;
                        chkM.DataTextField = "ComplicationName";
                        chkM.DataValueField = "ComplicationID";
                        chkM.DataBind();
                    }
                }
            }
            else
            {
                pnlFb.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing LoadComplications", ex);
        }
    }
    #endregion

    #region Button Click Events

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string ErrorText = "Error Inserting PreDialysis Details. Please try agin later or contact Admin";
        long taskID = -1;
        if (PaymentLogic == String.Empty)
        {
            List<Config> lstConfig = new List<Config>();
            new GateWay(base.ContextInfo).GetConfigDetails("PRO", OrgID, out lstConfig);
            if (lstConfig.Count > 0)
                PaymentLogic = lstConfig[0].ConfigValue.Trim();
        }

        if (btnSubmit.Text == "Save")
        {
            try
            {
                List<DialysisPatientVitals> lstDPV = new List<DialysisPatientVitals>();
                DialysisRecord dialysisRecord = new DialysisRecord();
                

                //Step1: Save Pre-Dialysis Record
                // This includes Dialysis Vitals and Dialysis Record
                if (GetDialysisVitals("Pre", out lstDPV))
                {
                    if (GetDialysisRecord("Pre", out dialysisRecord))
                    {
                        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
                        returnCode = dbl.SavePreDialysisDetails(OrgID, dialysisRecord, lstDPV);

                        //Step2: Make Task Entrynfor Onlfow monitoring
                        if (returnCode == 0)
                        {
                            Tasks iTask = GetInsertTask("Pre");
                            Tasks uTask = GetUpdateTask();
                            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                            ErrorText = "Unable to update task details. Please contact Admin";
                            returnCode = tbl.UpdateAndCreateTask(iTask, uTask, out taskID);
                        }
                    }
                }

                if(returnCode==0)
                    Response.Redirect("~\\Dialysis\\Home.aspx", true);
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }

            catch (Exception ex)
            {
                //lblStatus.Text = ErrorText;
                ErrorDisplay1.Status = ErrorText;
                ErrorDisplay1.ShowError = true;
                CLogger.LogError("Error while executing btnSubmit_click method in DialysisRecord.aspx", ex);
            }
        }
        else if (btnSubmit.Text == "Finish")
        {
            try            {
                List<DialysisPatientVitals> lstPrePatientVitals = new List<DialysisPatientVitals>();
                List<DialysisPatientVitals> lstPostPatientVitals = new List<DialysisPatientVitals>();
                DialysisRecord dialysisRecord = new DialysisRecord();

                //  Step1: Save PostDialysis Details
                //  This includes Updating PreDialysis Vitals, 
                //  Inserting PostDialysis Vitals, Dialysis Record & Complications

                if (GetDialysisVitals("Pre", out lstPrePatientVitals) && GetDialysisVitals("Post", out lstPostPatientVitals))
                {
                    if (GetDialysisRecord("Post", out dialysisRecord))
                    {
                        List<PatientComplication> lstComp = GetSelectedComplications();
                        List<DrugDetails> lstDrugDetails = new List<DrugDetails>();
                        long returnCodes = -1;

                        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
                        dialysisRecord.Remarks = txtPostDialysisRemarks.Text.Trim();
                        //dialysisRecord.DryWeight =Convert.ToInt16 (txtDryWeight.Text);
                        returnCodes = dbl.SavePostDialysisDetails(OrgID, dialysisRecord, lstPrePatientVitals, lstPostPatientVitals, lstComp);
                        Uri_BL uriBL = new Uri_BL(base.ContextInfo);
                        lstDrugDetails = uAd.GetPrescription(visitID);
                        returnCode = uriBL.InsertPatientPrescriptionBulk(lstDrugDetails);
                        if (returnCodes != 0)
                        {
                            displayError("Unable to save prescription. Pl. contact administrator");
                        }
                        //Step2: Make Task Entrynfor Onlfow monitoring
                        if (returnCode == 0)
                        {
                            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
                            ErrorText = "Unable to update task details. Please contact Admin";
                            returnCode = tbl.UpdateTask(selTaskID, TaskHelper.TaskStatus.Completed, UID);
                        }
                    }
                }
                if (returnCode == 0)
                {
                    int status = 0;
                    returnCode = new Tasks_BL(base.ContextInfo).GetCheckCollectionTaskStatus(visitID, out status);
                    Tasks task = new Tasks();
                    Hashtable dText = new Hashtable();
                    Hashtable urlVal = new Hashtable();
                    long createTaskID = -1;

                    //addnlCharges.PatientVisitID = visitID;
                    //addnlCharges.SaveFeesDetails(sender, e);


                    if ((PaymentLogic == "After")||(chkAdditionalPayments.Checked == true))
                    {
                        string redirectURL = "DialysisAdvice.aspx?vid=" + Request.QueryString["vid"] + "&ProcID=" + Request.QueryString["ProcID"] + "&tid=" + Request.QueryString["tid"] + "&fType=" + "PRO";
                        Response.Redirect(redirectURL, true);
                    }
                    else if (PaymentLogic == "Before")
                    {
                        if (status == 0)
                        {
                            returnCode = new Tasks_BL(base.ContextInfo).CreateTask(GetInsertTask("Record"), out createTaskID);
                        }

                        Response.Redirect("~\\Dialysis\\Home.aspx", true);
                    }
                }
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
            }

            catch(Exception ex)
            {
                //lblStatus.Text = ErrorText;
                ErrorDisplay1.Status = ErrorText;
                ErrorDisplay1.ShowError = true;
                CLogger.LogError("Error while executing btnSubmit_Click in DialysisRecord", ex);
            }
        }

    }
    private void displayError(string strError)
    {
        //btnSave.Visible = true;
        ErrorDisplay1.ShowError = true;
        ErrorDisplay1.Status = strError;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Tasks_BL tbl = new Tasks_BL(base.ContextInfo);
            tbl.UpdateTask(selTaskID, TaskHelper.TaskStatus.Pending, UID);
            Response.Redirect("~\\Dialysis\\Home.aspx", true);
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

    #endregion

    #region Read Entered Values

    private bool GetDialysisVitals(string sType, out List<DialysisPatientVitals> lstDiaPatientVitals)
    {
        bool blnReturn = true;
        bool isNoInput = true;
        bool hasNegative = false;

        string strVitalsname = "";
        string strIDControl = "";
        string strVitalsValue = "";
        string strTextControl = "";
        string strError = "";

        //lblStatus.Text = "";

        lstDiaPatientVitals = new List<DialysisPatientVitals>();
        DialysisPatientVitals diaPatientVitals;

        ArrayList al = (ArrayList)ViewState["Vitals"];

        for (int i = 0; i <= (al.Count - 1); i++)
        {
            strVitalsname = al[i].ToString();
            strIDControl = "lbl" + sType + strVitalsname + "VitalsID";
            strTextControl = "txt" + sType + strVitalsname;

            diaPatientVitals = new DialysisPatientVitals();

            if (this.FindControl(strTextControl) != null)
            {
                try
                {
                    strVitalsValue = ((TextBox)this.FindControl(strTextControl)).Text;
                    diaPatientVitals.VitalsID = Convert.ToInt32(((Label)this.FindControl(strIDControl)).Text);
                    diaPatientVitals.PatientVisitID = visitID;
                    diaPatientVitals.SessionType = sType == "Pre" ? "0" : "1";
                    diaPatientVitals.CreatedBy = LID;

                    if (strVitalsValue != "" && !strVitalsValue.Contains("-"))
                    {
                        isNoInput = false;
                        diaPatientVitals.VitalsValue = Convert.ToDecimal(strVitalsValue);
                    }
                }
                catch(Exception ex)
                {
                    blnReturn = false;
                    strError = strError + "Enter valid value for " + strVitalsname + "<br>";
                    CLogger.LogError("Error while executing GetDialysisVitals method", ex);
                }

                lstDiaPatientVitals.Add(diaPatientVitals);

                if (strVitalsValue.Contains("-"))
                {
                    blnReturn = false;
                    hasNegative = true;
                }
            }
        }

        if (!blnReturn || isNoInput)
        {
            blnReturn = false;
            //lblStatus.Text = "";
            if (isNoInput)
            {
                strError = "Please enter atleast one value. Negative values are invalid";
            }
            else
            {
                if (hasNegative)
                {
                    strError = "Negative values are invalid " + strError + "</font>";
                }
            }
            //lblStatus.Text = strError;
            ErrorDisplay1.Status = strError;
            ErrorDisplay1.ShowError = true;
        }

        return blnReturn;
    }

    private bool GetDialysisRecord(string sType, out DialysisRecord dialysisRecord)
    {
        bool blnResult = true;
        dialysisRecord = new DialysisRecord();

        if(sType.Equals("Pre"))
        {
            try
            {
                DateTime today = new DateTime();

                dialysisRecord.PatientVisitID = visitID;

                dialysisRecord.HDNo = Convert.ToInt32(txtHDNo.Text);

                //DateTime.TryParse(txtToday.Text, out today);
                dialysisRecord.HDDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);

                DateTime startTime = new DateTime();
                DateTime.TryParse(txtStartTime.Text, out startTime);
                dialysisRecord.HDStartTime = startTime; //new TimeSpan(startTime.Hour, startTime.Minute, 0);
                
                dialysisRecord.AccessID = Convert.ToInt16(ddAccess.SelectedValue);
                dialysisRecord.AccessSide = ddSide.SelectedValue;
                dialysisRecord.OrgID = OrgID;
                dialysisRecord.WeightGain = txtWtGain.Text;
                dialysisRecord.MachineName = txtBedName.Text;
                dialysisRecord.CreatedBy = LID;
                dialysisRecord.DryWeight = Convert.ToDecimal(txtDryWeight.Text);
               
            }
            catch(Exception ex)
            {
                CLogger.LogError("Error while executing GetDialysisRecord. Invalid inputs. Check the entered values", ex);
                //lblStatus.Text = "Invalid inputs. Pl. check the values you entered";
                ErrorDisplay1.Status = "Invalid inputs. Pl. check the values you entered";
                ErrorDisplay1.ShowError = true;
                blnResult = false;
            }
        }
        else if (sType.Equals("Post"))
        {
            try
            {
                DateTime endTime = new DateTime();
                DateTime.TryParse(txtEndTime.Text, out endTime);
                dialysisRecord.HDEndTime = endTime; //new TimeSpan(endTime.Hour, endTime.Minute, 0);
                dialysisRecord.PostConditionID = Convert.ToInt32(dCond.SelectedValue);
                dialysisRecord.BTS = txtBTS.Text;
                dialysisRecord.DialyserUsed = txtDialyzer.Text;

                DateTime nDate = new DateTime();
                if (tNextHDDate.Text != "")
                {
                    string ampm = ddNAmPm.SelectedValue;
                    int hr = Convert.ToInt32(ddNHour.SelectedValue);
                    DateTime.TryParse(tNextHDDate.Text, out nDate);
                    if (ampm == "PM")
                        hr = hr + 12 == 24 ? 12 : hr + 12;
                    else
                        hr = hr == 12 ? 0 : hr;

                    nDate = new DateTime(nDate.Year, nDate.Month, nDate.Day, hr , Convert.ToInt32(ddNMinutes.SelectedValue), 0);
                    dialysisRecord.NextHDDateTime = nDate;
                    dialysisRecord.Comments = txtComments.Text;
                }

                dialysisRecord.AccessID = Convert.ToInt16(ddAccess.SelectedValue);
                dialysisRecord.AccessSide = ddSide.SelectedValue;
                dialysisRecord.WeightGain = txtWtGain.Text;
                dialysisRecord.ModifiedBy = LID;
                dialysisRecord.PatientVisitID = visitID;
                dialysisRecord.Remarks = txtPostDialysisRemarks.Text.Trim();
                dialysisRecord.Comments = txtComments.Text;
            }
            catch(Exception ex)
            {
                CLogger.LogError("Error while executing GetDialysisRecord. Invalid inputs. Check the entered values ", ex);
                //lblStatus.Text = "Invalid inputs. Pl. check the values you entered";
                ErrorDisplay1.Status = "Invalid inputs. Pl. check the values you entered";
                ErrorDisplay1.ShowError = true;
                blnResult = false;
            }
        }

        return blnResult;
    }

    private List<PatientComplication> GetSelectedComplications()
    {
        List<PatientComplication> lpc = new List<PatientComplication>();
        PatientComplication pc;
        
        for(int i=0; i<=chkG.Items.Count-1; i++)
        {
            if (chkG.Items[i].Selected)
            {
                pc = new PatientComplication();
                pc.ComplicationID = Convert.ToInt32(chkG.Items[i].Value);
                pc.CreatedBy = LID;
                pc.PatientVisitID = visitID;
                lpc.Add(pc);
            }
        }

        for (int i = 0; i <= chkM.Items.Count - 1; i++)
        {
            if (chkM.Items[i].Selected)
            {
                pc = new PatientComplication();
                pc.ComplicationID = Convert.ToInt32(chkM.Items[i].Value);
                pc.CreatedBy = LID;
                pc.PatientVisitID = visitID;
                lpc.Add(pc);
            }
        }

        for (int i = 0; i <= chkA.Items.Count - 1; i++)
        {
            if (chkA.Items[i].Selected)
            {
                pc = new PatientComplication();
                pc.ComplicationID = Convert.ToInt32(chkA.Items[i].Value);
                pc.CreatedBy = LID;
                pc.PatientVisitID = visitID;
                lpc.Add(pc);
            }
        }

        return lpc;
    }

    private Tasks GetInsertTask(string sType)
    {
        string PatientName = string.Empty;
        string MachineName = string.Empty;
        string LastTestTime = string.Empty;
        Tasks tsk = new Tasks();
        Hashtable htDispText = new Hashtable();
        Hashtable htURL = new Hashtable();

        Int64.TryParse(Request.QueryString["ProcID"],out procedureID);

        //htURL.Add("PatientVisitID", visitID.ToString());

        //htURL.Add("ComplaintID", complaintID.ToString());

        Dialysis_BL dialysisBl = new Dialysis_BL(base.ContextInfo);

        if (onflowCount == 0)
        {
            dialysisBl.GetDialysisOnflowCount(visitID, out onflowCount);
        }

        if (sType.Equals("Pre"))
        {
            dialysisBl.GetHTParamsForOnFlowTask(visitID, out pid, out PatientName, out MachineName, out LastTestTime);
            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.OnFlowMonitoring), visitID, 0, pid, PatientName, "",
                procedureID, MachineName, onflowCount, LastTestTime, 0, "", out htDispText, out htURL, 0, "", 0, "");
            tsk.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.OnFlowMonitoring);
        }
        else if (sType.Equals("Record"))
        {
            dialysisBl.GetHTParamsForOnFlowTask(visitID, out pid, out PatientName, out MachineName, out LastTestTime);
            Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.HandoverDialysisCaseSheet), visitID, 0, pid, PatientName, "",
            procedureID, MachineName, onflowCount, LastTestTime, 0, "", out htDispText, out htURL, 0, "", 0, "");
            tsk.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.HandoverDialysisCaseSheet);
        }
        else
        {
            dialysisBl.GetHTParamsForPostDialysisTask(visitID, out pid, out PatientName);
            Utilities.TaskAction(Convert.ToInt64(TaskHelper.TaskAction.PostDialysis), visitID, PatientName, onflowCount, out htDispText, out htURL);

            tsk.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.PostDialysis);
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

    #region Set TextBox Formats
    
    private void FormatText()
    {
        txtPreSBP.Text = txtPreSBP.Text.Contains(".") ? txtPreSBP.Text.Remove(txtPreSBP.Text.IndexOf(".")) : txtPreSBP.Text;
        txtPrePulse.Text = txtPrePulse.Text.Contains(".") ? txtPrePulse.Text.Remove(txtPrePulse.Text.IndexOf(".")) : txtPrePulse.Text;
        txtPreDBP.Text = txtPreDBP.Text.Contains(".") ? txtPreDBP.Text.Remove(txtPreDBP.Text.IndexOf(".")) : txtPreDBP.Text;
        txtPreHeparin.Text = txtPreHeparin.Text.Contains(".") ? txtPreHeparin.Text.Remove(txtPreHeparin.Text.IndexOf(".")) : txtPreHeparin.Text;
        txtPreTemp.Text = txtPreTemp.Text.Contains(".") ? txtPreTemp.Text.Remove(txtPreTemp.Text.IndexOf(".") + 2) : txtPreTemp.Text;
        txtPreWeight.Text = txtPreWeight.Text.Contains(".") ? txtPreWeight.Text.Remove(txtPreWeight.Text.IndexOf(".") + 2) : txtPreWeight.Text;
        txtWtGain.Text = txtWtGain.Text.Contains(".") ? txtWtGain.Text.Remove(txtWtGain.Text.IndexOf(".") + 2) : txtWtGain.Text;
    }

    #endregion
}
