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

public partial class PatientVitals : BasePage
{
    public PatientVitals()
        : base("Nurse\\PatientVitals.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }




    int iPatientID = -1;
    string type = "I";
    int NewVitalsSetID = -1;
    long visitID = -1;
    long visitid = -1;
    long returnCode = -1;
    long patientID = -1;
    int VisitType = -1;
    long vType = -1;
    long VitalsCount = -1;


    protected void Page_Load(object sender, EventArgs e)
    {
        bool hasError = false;

        if (Request.QueryString["PID"] == null || Request.QueryString["PID"] == "")
        {
            Response.Redirect("~/Nurse/Home.aspx", true);
        }
        iPatientID = Convert.ToInt32(Request.QueryString["PID"]);
        if (!Page.IsPostBack)
        {
            try
            {
                LoadVitalsType();
                //Prasanna Commented Below
                LoadPatientCondition();
                //LoadSelectOption();
                lblselect.Visible = false;
                drpOption.Style.Add("display", "none");


                //if (Request.QueryString["type"] != null)
                //    type = Convert.ToString(Request.QueryString["type"]);
                //uctlPatientVitals.LoadControls(type, iPatientID);
                //if (type.ToUpper().Equals("U"))
                //{
                //    LoadUpdateData();
                //}
                //Prasanna Ends
                //Prasanna Added Below lines
                Int64.TryParse(Request.QueryString["PID"], out patientID);
                returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID, out vType, out VitalsCount);


                if (visitID > 0)
                {
                    btnFinish.Enabled = true;
                    LoadPatientCondition();
                    hdnVistType.Value = vType.ToString();

                    if (vType == 1)
                    {
                        trVType.Style.Add("display", "block");
                    }

                    if (vType == 1 && VitalsCount > 0)
                    {
                        type = "IPU";
                        uctlPatientVitals.VisitID = visitID;
                        uctlPatientVitals.LoadControls(type, visitID);

                    }
                    else
                    {
                        if (vType == 1 && VitalsCount == 0)
                        {
                            type = "I";
                            uctlPatientVitals.VisitID = visitID;
                            uctlPatientVitals.LoadControls(type, patientID);
                        }
                        else
                        {
                            if (vType == 0 && VitalsCount > 0)
                            {

                                type = "U";
                                uctlPatientVitals.VisitID = visitID;
                                uctlPatientVitals.LoadControls(type, iPatientID);
                            }
                            else
                            {
                                type = "I";
                                uctlPatientVitals.VisitID = visitID;
                                uctlPatientVitals.LoadControls(type, iPatientID);
                            }
                        }
                    }

                    if (type.ToUpper().Equals("U"))
                    {
                        LoadUpdateData();
                    }
                    else
                    {
                        if (type.ToUpper().Equals("IPU"))
                        {
                            LoadUpdateData();
                        }
                    }
                }
                else
                {
                    btnFinish.Enabled = false;
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "There is No visit for this patient.";
                }
                //Prasanna Added lines Ends                
            }
            catch (System.Threading.ThreadAbortException tae)
            {
                string thread = tae.ToString();
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

            //if (hasError)
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "There is some problem capturing vitals. Pl. contact administrator";                
            //    uctlPatientVitals.Visible = false;
            //}
            //else
            //{
            //    ErrorDisplay1.ShowError = true;
            //    ErrorDisplay1.Status = "";
            //}
        }
    }

    private void LoadUpdateData()
    {
        long returnCode = -1;
        long visitID = uctlPatientVitals.VisitID;

        PatientVisit_BL visitBL = new PatientVisit_BL(base.ContextInfo);
        List<PatientVisit> lstPatientVisit = new List<PatientVisit>();

        returnCode = visitBL.GetVisitDetails(visitID, out lstPatientVisit);

        if (returnCode == 0 && lstPatientVisit.Count > 0)
        {
            PatientVisit pv = lstPatientVisit[0];
            txtComments.Text = pv.VisitNotes;
            if (pv.ConditionId != 0)
            {
                PreSelectCondition(pv.ConditionId);
            }
        }
    }

    private void PreSelectCondition(int cid)
    {
        for (int i = 0; i <= ddPatientCondition.Items.Count; i++)
        {
            if (Convert.ToInt32(ddPatientCondition.Items[i].Value) == cid)
            {
                ddPatientCondition.Items[i].Selected = true;
                break;
            }
        }
    }

    private void LoadPatientCondition()
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
            CLogger.LogError("Error while executing LoadPatientCondition", e1);
        }

        if (returnCode == 0)
        {
            ddPatientCondition.DataSource = lstPatientCondition;
            ddPatientCondition.DataTextField = "Condition";
            ddPatientCondition.DataValueField = "ConditionID";
            ddPatientCondition.DataBind();
        }



    }

    private void LoadSelectOption()
    {
        long returnCode = -1;

        PatientVitals_BL patientvitalsBL = new PatientVitals_BL(base.ContextInfo);
        List<VitalsPageOptions> lstVitalsPageOption = new List<VitalsPageOptions>();

        try
        {
            returnCode = patientvitalsBL.GetSelectOption(OrgID, out lstVitalsPageOption);
        }
        catch (Exception e1)
        {
            CLogger.LogError("Error while executing LoadPatientCondition", e1);
        }

        if (returnCode == 0)
        {
            drpOption.DataSource = lstVitalsPageOption;
            drpOption.DataTextField = "ActionName";
            drpOption.DataValueField = "PageID";
            drpOption.DataBind();
            drpOption.Items.Insert(0, new ListItem("-----Select-----", "-1"));
            drpOption.Items.Insert(lstVitalsPageOption.Count + 1, new ListItem("None", "0"));
        }

    }


    private void LoadVitalsType()
    {
        long returnCode = -1;

        PatientVitals_BL patientvitalsBL = new PatientVitals_BL(base.ContextInfo);
        List<VitalsType> lstVitalsType = new List<VitalsType>();

        try
        {
            returnCode = patientvitalsBL.GetVitalsType(OrgID, out lstVitalsType);
        }
        catch (Exception e1)
        {
            CLogger.LogError("Error while executing LoadVitalsType", e1);
        }

        if (returnCode == 0)
        {
            ddlVitalsType.DataSource = lstVitalsType;
            ddlVitalsType.DataTextField = "VitalsTypeName";
            ddlVitalsType.DataValueField = "VitalsTypeID";
            ddlVitalsType.DataBind();
            ddlVitalsType.Items.Insert(0, "---Select---");
            ddlVitalsType.Items[0].Value = "0";
        }

    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        try
        {
            #region Commented Code

            //            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            //            int iConditionID;
            //            long returnCode;
            //            string strNurseNotes = "";
            //            bool blnRetval = false;

            //            PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);

            //            iConditionID = Convert.ToInt32(ddPatientCondition.SelectedValue);
            //            strNurseNotes = txtComments.Text;

            //            List<Attune.Podium.BusinessEntities.PatientVitals> lstPatientVitals = new List<Attune.Podium.BusinessEntities.PatientVitals>();
            //            blnRetval = uctlPatientVitals.GetPageValues(out lstPatientVitals);

            ////Prasanna  added Below lines

            //            Int64.TryParse(Request.QueryString["PID"], out patientID);
            //            returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID);
            ////Prasanna  added lines ends
            //            if (blnRetval)
            //            {
            //                foreach (Attune.Podium.BusinessEntities.PatientVitals patientVitals in lstPatientVitals)
            //                {
            //                    patientVitals.PatientID = iPatientID;
            //                    patientVitals.ConditionID = iConditionID;
            //                    patientVitals.CreatedBy = LID;
            //                    patientVitals.NurseNotes = strNurseNotes;
            ////Prasanna  added Below lines
            //                    patientVitals.PatientVisitID = visitID;
            ////Prasanna  added lines ends
            //                }

            //                returnCode = patientVitalBL.SavePatientVitals(OrgID, lstPatientVitals);
            //                if (Request.QueryString["tid"] != null)
            //                {
            //                    long ptaskID = Int64.Parse(Request.QueryString["tid"].ToString());
            //                    returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.Completed, UID);
            //                }
            //                if (returnCode == 0)
            //                {
            //                    Response.Redirect("Home.aspx", true);
            //                }
            //            }
            #endregion

            //if (drpOption.SelectedItem.Text != "None")
            //{
            //    //Response.Redirect("~/Nurse/Home.aspx", true);

            //    DateTime temp = Convert.ToDateTime(new BasePage().OrgDateTimeZone).Date;
            //    PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);
            //    patientVitalBL.GetANCPatientVisitID(iPatientID, temp, out visitid);

            //    if (visitid != -1)
            //    {

            //        Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            //        int iConditionID;
            //        long returnCode;
            //        string strNurseNotes = "";
            //        bool blnRetval = false;

            //        //PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);

            //        iConditionID = Convert.ToInt32(ddPatientCondition.SelectedValue);
            //        strNurseNotes = txtComments.Text;

            //        List<Attune.Podium.BusinessEntities.PatientVitals> lstPatientVitals = new List<Attune.Podium.BusinessEntities.PatientVitals>();
            //        blnRetval = uctlPatientVitals.GetPageValues(out lstPatientVitals);

            //        //Prasanna  added Below lines

            //        Int64.TryParse(Request.QueryString["PID"], out patientID);
            //        returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID);
            //        //Prasanna  added lines ends
            //        if (blnRetval)
            //        {
            //            foreach (Attune.Podium.BusinessEntities.PatientVitals patientVitals in lstPatientVitals)
            //            {
            //                patientVitals.PatientID = iPatientID;
            //                patientVitals.ConditionID = iConditionID;
            //                patientVitals.CreatedBy = LID;
            //                patientVitals.NurseNotes = strNurseNotes;
            //                //Prasanna  added Below lines
            //                patientVitals.PatientVisitID = visitID;
            //                //Prasanna  added lines ends
            //            }

            //            returnCode = patientVitalBL.SavePatientVitals(OrgID, lstPatientVitals);
            //            if (Request.QueryString["tid"] != null)
            //            {
            //                long ptaskID = Int64.Parse(Request.QueryString["tid"].ToString());
            //                returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.Completed, UID);
            //            }
            //            if (returnCode == 0)
            //            {
            //                //Response.Redirect(@"../ANC/BaselineScreeningHistoryOld.aspx?vid=" + visitid + "&pid=" + iPatientID + "", true);
            //                //Response.Redirect(@"../ANC/BaseLineHistory.aspx?vid=" + visitid + "&pid=" + iPatientID + "", true);
            //            }
            //        }
            //    }
            //    //else
            //}
            //else
            //{
            Tasks_BL taskBL = new Tasks_BL(base.ContextInfo);
            int iConditionID;
            long returnCode;
            string strNurseNotes = "";
            bool blnRetval = false;

            PatientVitals_BL patientVitalBL = new PatientVitals_BL(base.ContextInfo);

            iConditionID = Convert.ToInt32(ddPatientCondition.SelectedValue);
            strNurseNotes = txtComments.Text;

            List<Attune.Podium.BusinessEntities.PatientVitals> lstPatientVitals = new List<Attune.Podium.BusinessEntities.PatientVitals>();
            blnRetval = uctlPatientVitals.GetPageValues(out lstPatientVitals);

            //Prasanna  added Below lines

            Int64.TryParse(Request.QueryString["PID"], out patientID);
            returnCode = new PatientVitals_BL(base.ContextInfo).GetVisitStatusForVitals(patientID, out visitID, out vType, out VitalsCount);
            //Prasanna  added lines ends
            if (blnRetval)
            {

                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                //sami  added Below lines
                PatientVisit_BL oPatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
                returnCode = oPatientVisit_BL.GetVisitDetails(visitID, out lstPatientVisit);
                foreach (var opatieentVistDetails in lstPatientVisit)
                {
                    VisitType = opatieentVistDetails.VisitType;
                }
                if (VisitType != 0)
                {
                    long retCode = -1;

                    IP_BL oIP_BL = new IP_BL(base.ContextInfo);

                    List<Attune.Podium.BusinessEntities.PatientVitals> lstMaxOfVitalsSetID = new List<Attune.Podium.BusinessEntities.PatientVitals>();

                    retCode = oIP_BL.GetMaxOfVitalsSetID(visitID, out lstMaxOfVitalsSetID);

                    foreach (var vitalsetid in lstMaxOfVitalsSetID)
                    {
                        NewVitalsSetID = vitalsetid.VitalsSetID;
                    }
                    //sami  added  lines ends
                }

                foreach (Attune.Podium.BusinessEntities.PatientVitals patientVitals in lstPatientVitals)
                {
                    patientVitals.PatientID = iPatientID;
                    patientVitals.ConditionID = iConditionID;
                    patientVitals.CreatedBy = LID;
                    patientVitals.NurseNotes = strNurseNotes;
                    //Prasanna  added Below lines
                    patientVitals.PatientVisitID = visitID;
                    //Prasanna  added lines ends

                    //sami  added Below lines
                    if (VisitType == 0)
                    {
                        patientVitals.VitalsSetID = 0;
                    }

                    else
                    {

                        patientVitals.VitalsSetID = NewVitalsSetID;
                    }
                    if (hdnVistType.Value == "1")
                    {
                        patientVitals.VitalsType = ddlVitalsType.SelectedItem.Text;
                        patientVitals.VitalsTypeID = Convert.ToInt64(ddlVitalsType.SelectedValue);

                    }
                    //sami  added lines ends
                }

                // sami added new parameter 'VisitType'                               
                returnCode = patientVitalBL.SavePatientVitals(OrgID, VisitType, lstPatientVitals);
                if (Request.QueryString["tid"] != null)
                {
                    long ptaskID = Int64.Parse(Request.QueryString["tid"].ToString());
                    returnCode = taskBL.UpdateTask(ptaskID, TaskHelper.TaskStatus.Completed, UID);
                }
                if (returnCode != -1)
                {
                    Response.Redirect("Home.aspx", true);
                }
            }
            //}

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
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
