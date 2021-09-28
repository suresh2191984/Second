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

public partial class CommonControls_DialysisCaseSheet : BaseControl
{
    
   
   
    int complaintID = 0;
    bool isPreDialysis = true;
    string PatientName = string.Empty;
    string Age = "0";
    decimal AmountReceived = 0;
    long PatientID = 0;
    //int OrgID = 1;

    long visitID = 0;
    long pid = 0;
    int taskID = 0;

    decimal tempsbp, tempdbp;

    //public long VisitID
    //{
    //    get { return visitID; }
    //    set { visitID = value; }
    //}
    public long PID
    {
        get { return pid; }
        set { pid = value; }
    }
    public int TaskID
    {
        get { return taskID; }
        set { taskID = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //visitID = Convert.ToInt64(Request.QueryString["pid"]);
        //visitID = 1;
        //taskID = Convert.ToInt32(Request.QueryString["tid"]);
        //complaintID = Convert.ToInt32(Request.QueryString["cid"]);
        //loadDialysisDetails(visitID);

    }

    public void loadDialysisDetails(long visitid)
    {
        visitID = visitid;
        LoadPatientPrescription();
        GetData(visitid);
        long returnCode = -1;
        Dialysis_BL dbl = new Dialysis_BL(base.ContextInfo);
        DialysisRecord dr = new DialysisRecord();
        List<VitalsUOMJoin> vitalsUOMJoin = new List<VitalsUOMJoin>();
        List<Complication> parentComplications = new List<Complication>();
        List<Complication> complications = new List<Complication>();
        
        try
        {
            returnCode = dbl.GetDialysisCaseSheet(visitid, OrgID, out dr, out vitalsUOMJoin,
                out parentComplications, out complications, out PatientID, out PatientName,
                out Age, out AmountReceived);
            if (vitalsUOMJoin.Count > 6 || parentComplications.Count > 0 || complications.Count > 0)
            {
                divDialysisCaseSheet.Visible = true;
                ErrorDisplay1.ShowError = false;
                if (returnCode == 0)
                {
                    LoadDialysisRecord(dr);
                    LoadDialysisVitals(vitalsUOMJoin);
                    LoadComplication(parentComplications, complications);


                }
                SetLabelFormat();
            }
            else
            {
                if (vitalsUOMJoin.Count > 0)
                {
                    ErrorDisplay1.ShowError = true;
                    ErrorDisplay1.Status = "Dialysis is running. Please try when dialysis complete. ";
                    divDialysisCaseSheet.Visible = false;
                }
                else
                {
                    ErrorDisplay1.ShowError = false;
//Commented Because, Patient is not yet sent for Dialysis, only vist has scheduled.
                    //ErrorDisplay1.Status = "There is no dialysis case sheet details available for this patient";
                    divDialysisCaseSheet.Visible = false;
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Dialysis CaseSheet Page_Load ", ex);
            //lblStatus.Text = "Unable to Load Page. Pl. try again later or contact Admin";
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
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
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
        lblRemarks.Text = dr.Remarks;
        lblMachineName.Text = dr.MachineName;
        lblDryWeight.Text = dr.DryWeight.ToString();
        lblComments.Text = dr.Comments;
    }

    private void LoadDialysisVitals(List<VitalsUOMJoin> vitalsUOMJoin)
    {
        string strVitalsname = "";
        string vitalsID;
        string UOMCode;
        string vitalsValue;

      
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

    private void SetLabelFormat()
    {
        lblPreSBP.Text = lblPreSBP.Text.Contains(".") ? lblPreSBP.Text.Remove(lblPreSBP.Text.IndexOf(".")) : lblPreSBP.Text;
        lblPrePulse.Text = lblPrePulse.Text.Contains(".") ? lblPrePulse.Text.Remove(lblPrePulse.Text.IndexOf(".")) : lblPrePulse.Text;
        lblPreDBP.Text = lblPreDBP.Text.Contains(".") ? lblPreDBP.Text.Remove(lblPreDBP.Text.IndexOf(".")) : lblPreDBP.Text;
        lblPreHeparin.Text = lblPreHeparin.Text.Contains(".") ? lblPreHeparin.Text.Remove(lblPreHeparin.Text.IndexOf(".")) : lblPreHeparin.Text;
        lblPreTemp.Text = lblPreTemp.Text.Contains(".") ? lblPreTemp.Text.Remove(lblPreTemp.Text.IndexOf(".") + 2) : lblPreTemp.Text;
        lblPreWeight.Text = lblPreWeight.Text.Contains(".") ? lblPreWeight.Text.Remove(lblPreWeight.Text.IndexOf(".") + 2) : lblPreWeight.Text;
        lblPreWtGain.Text = lblPreWtGain.Text.Contains(".") ? lblPreWtGain.Text.Remove(lblPreWtGain.Text.IndexOf(".") + 2) : lblPreWtGain.Text;
        lblDryWeight .Text =lblDryWeight .Text .Contains (".")?lblDryWeight .Text.Remove (lblDryWeight .Text.IndexOf(".")+2):lblDryWeight .Text ;
        lblMachineName.Text =lblMachineName .Text .Contains (".")?lblMachineName .Text .Remove(lblMachineName .Text .IndexOf (".")+2):lblMachineName.Text;

        lblPostSBP.Text = lblPostSBP.Text.Contains(".") ? lblPostSBP.Text.Remove(lblPostSBP.Text.IndexOf(".")) : lblPostSBP.Text;
        lblPostPulse.Text = lblPostPulse.Text.Contains(".") ? lblPostPulse.Text.Remove(lblPostPulse.Text.IndexOf(".")) : lblPostPulse.Text;
        lblPostDBP.Text = lblPostDBP.Text.Contains(".") ? lblPostDBP.Text.Remove(lblPostDBP.Text.IndexOf(".")) : lblPostDBP.Text;
        lblPostUF.Text = lblPostUF.Text.Contains(".") ? lblPostUF.Text.Remove(lblPostUF.Text.IndexOf(".")) : lblPostUF.Text;
        lblPostTemp.Text = lblPostTemp.Text.Contains(".") ? lblPostTemp.Text.Remove(lblPostTemp.Text.IndexOf(".") + 2) : lblPostTemp.Text;
        lblPostWeight.Text = lblPostWeight.Text.Contains(".") ? lblPostWeight.Text.Remove(lblPostWeight.Text.IndexOf(".") + 2) : lblPostWeight.Text;
        lblComments.Text =lblComments.Text.Contains(".")?lblComments.Text .Remove (lblComments.Text .IndexOf (".")+2):lblComments.Text ;
    }

    DataSet ds1 = new DataSet();
    public void GetData(long patientVisitID)
    {
        long retval = -1;

        OnFlowDialysis_BL dialysisBL = new OnFlowDialysis_BL(base.ContextInfo);
        //List<Dialysis> lstDialysis = new List<Dialysis>();
        DataSet ds1 = new DataSet();
        retval = dialysisBL.GetOnFlowDialysis((long)patientVisitID, out ds1);

        if (retval == -1)
        {
            BindData(ds1);

        }

    }
    DataTable ds = new DataTable();
    DataTable dt = new DataTable();
    DataTable final = new DataTable();
    private void BindData(DataSet ds1)
    {
        grdOnFlowDialysis.Visible = true;
        lblResult.Visible = false;
        lblResult.Text = "";
        ds = ds1.Tables[0];

        string strtemp = string.Empty;
        string count = string.Empty;
        string tempvitalsname = string.Empty;
        dt.Columns.Add("BP (mmHG)");

        foreach (DataRow drnew in ds.Select("", "VitalsName asc"))
        {
            if (strtemp != drnew["VitalsName"].ToString())
            {
                tempvitalsname = Server.HtmlDecode(drnew["VitalsName"].ToString());
                dt.Columns.Add(tempvitalsname);
                strtemp = drnew["VitalsName"].ToString();
            }

        }

        dt.Columns.Add("Remarks");
        dt.Columns.Add("Time Captured");
        string onflowid = string.Empty;
        DataRow newrow = null;


        foreach (DataRow dr in ds.Select("", "DialysisOnFlowID asc"))
        {

            if (onflowid != dr["DialysisOnFlowID"].ToString())
            {
                newrow = dt.NewRow();
                onflowid = dr["DialysisOnFlowID"].ToString();
            }
            foreach (DataRow dr1 in ds.Select("", "DialysisOnFlowID asc"))
            {
                if (onflowid == dr1["DialysisOnFlowID"].ToString())
                {

                    if (dr1["VitalsName"].ToString().StartsWith("SBP"))
                    {
                        tempvalue = Convert.ToDecimal(dr1["VitalsValue"].ToString());
                        tempname = dr1["VitalsName"].ToString();
                        UOMCode = dr1["UOMCode"].ToString();
                        if (dt.Columns.Contains(tempname))
                        {
                            dt.Columns.Remove(tempname);
                        }
                        ValueCount = 1;
                    }
                    if (dr1["VitalsName"].ToString().StartsWith("DBP"))
                    {
                        tempvalue1 = Convert.ToDecimal(dr1["VitalsValue"].ToString());
                        tempname1 = dr1["VitalsName"].ToString();
                        if (dt.Columns.Contains(tempname1))
                        {
                            dt.Columns.Remove(tempname1);
                        }
                        ValueCount = 2;
                    }
                    if (ValueCount != 1 && ValueCount != 2)
                    {
                        newrow[Server.HtmlDecode(dr1["VitalsName"].ToString())] = dr1["VitalsValue"].ToString();
                    }

                    TempRemarks = dr1["Remarks"].ToString();
                    OnflowTime = Convert.ToDateTime(dr1["OnFlowDateTime"].ToString());

                }
                ValueCount = 0;

            }
            if (count != onflowid)
            {

                newrow["Remarks"] = TempRemarks;
                newrow["Time Captured"] = OnflowTime.ToString("hh:mm tt");
                dt.Rows.Add(newrow);
                count = onflowid;

                if (tempvalue != 0 && tempvalue1 != 0)
                {
                    tempsbp = decimal.Parse(tempvalue.ToString());
                    tempsbp = Math.Ceiling(tempsbp);

                    tempdbp = decimal.Parse(tempvalue1.ToString());
                    tempdbp = Math.Ceiling(tempdbp);

                    newrow["BP (mmHG)"] = tempsbp.ToString() + '/' + tempdbp.ToString();
                }
                else if (tempvalue != 0 && tempvalue1 <= 0)
                {
                    newrow["BP (mmHG)"] = tempsbp.ToString() + "(SBP)";
                }
                else if (tempvalue == 0 && tempvalue1 != 0)
                {
                    newrow["BP (mmHG)"] = tempdbp.ToString() + "(DBP)";
                }
                else
                {
                    newrow["BP (mmHG)"] = string.Empty;
                }
            }

            tempvalue = 0;
            tempvalue1 = 0;
        }
        grdOnFlowDialysis.DataSource = dt;
        grdOnFlowDialysis.DataBind();
        string PrintOnflow=GetConfigValue("ViewOnFlow", OrgID);
    }

    DateTime OnflowTime;
    string TempRemarks = string.Empty;
    int ValueCount = 0;
    decimal tempvalue = 0.0m;
    string tempname = string.Empty;
    decimal tempvalue1 = 0.0m;
    string tempname1 = string.Empty;
    string UOMCode = string.Empty;

}
