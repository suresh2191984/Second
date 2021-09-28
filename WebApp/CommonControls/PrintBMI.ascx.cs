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

public partial class CommonControls_PrintBMI : BaseControl
{
    ArrayList al = new ArrayList();
    long visitID = -1;
    long patientID = -1;
    string type = "U";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {            
            if (!IsPostBack)
            {
                //patientID = Convert.ToInt32(Request.QueryString["PID"]);
                //type = Convert.ToString(Request.QueryString["type"]);
                //if (type != null)
                //{
                //    LoadControls(type, patientID);
                //}
            }
        }
        catch (Exception ex)
        {

        }
    }

    public void LoadControls(string TransType, long pid)
    {
        ViewState["VitalsForUI"] = null;
        patientID = 9;
        visitID = 9;
        long returnCode = -1;
        string strVitalsname = "";
        string strIDControl = "";
        string strNameControl = "";
        string strTextControl = "";
        string strUOMControl = "";
        string vitalsGroup = "GENERAL";
        PatientVitals_BL patientVitalsBL = new PatientVitals_BL(base.ContextInfo);
        List<VitalsUOMJoin> lstVitalsUOMJoin = new List<VitalsUOMJoin>();
        try
        {
            
             if (TransType.ToUpper().Equals("U"))
            {
                returnCode = patientVitalsBL.GetVitalsForUpdate(pid, OrgID, out visitID, out lstVitalsUOMJoin);
            }
            
        }
        catch (Exception e1)
        {
            CLogger.LogError("Error", e1);
            //Audit code goes here
        }
        if (returnCode == 0)
        {
            VisitID = visitID;
            foreach (VitalsUOMJoin vuj in lstVitalsUOMJoin)
            {
                strVitalsname = vuj.VitalsName;
                strIDControl = "lbl" + strVitalsname + "VitalsID";
                strNameControl = "lbl" + strVitalsname + "VitalsName";
                strTextControl = "lbl" + strVitalsname;
                strUOMControl = "lbl" + strVitalsname + "UOMCode";

                if (this.FindControl(strIDControl) != null)
                {
                    if (vuj.VitalsGroup.ToUpper().Equals("GENERAL"))
                    {
                        al.Add(strVitalsname);

                        ((Label)this.FindControl(strIDControl)).Text = vuj.VitalsID.ToString();
                        ((Label)this.FindControl(strNameControl)).Text = vuj.VitalsName;
                        ((Label)this.FindControl(strUOMControl)).Text = vuj.UOMCode;
                        //((TextBox)this.FindControl(strTextControl)).Text = Convert.ToString(vuj.VitalsValue) != "0" ? Convert.ToString(vuj.VitalsValue) : "";
                        if (vuj.VitalsName == "SBP" || vuj.VitalsName == "DBP" || vuj.VitalsName == "RR" || vuj.VitalsName == "Pulse")
                        {
                            ((Label)this.FindControl(strTextControl)).Text = vuj.VitalsValue > 0 ? Convert.ToString(Convert.ToInt32(vuj.VitalsValue)) : "";
                        }
                        else
                        {
                            ((Label)this.FindControl(strTextControl)).Text = vuj.VitalsValue > 0 ? Convert.ToString(vuj.VitalsValue) : "";
                        }
                    }
                }
            }
        }
        ViewState.Add("VitalsForUI", al);
    }

    public long VisitID
    {
        get
        {
            return visitID;
        }
        set
        {
            visitID = value;
        }
    }
    public bool GetPageValues(long vid, bool isMandatory, out int NoOfEntries, out List<PatientVitals> lstPatientVitals)
    {
        bool blnReturn = true;
        //bool isNoInput = isMandatory;
        bool hasNegative = false;
        NoOfEntries = 0;
        string strVitalsname = "";
        string strIDControl = "";
        string strVitalsValue = "";
        string strTextControl = "";
        string strError = "";
        pnlError.Visible = false;
        lstPatientVitals = new List<PatientVitals>();
        PatientVitals patientVitals;
        ArrayList al = (ArrayList)ViewState["VitalsForUI"];
        for (int i = 0; i <= (al.Count - 1); i++)
        {
            strVitalsname = al[i].ToString();
            strIDControl = "lbl" + strVitalsname + "VitalsID";
            strTextControl = "txt" + strVitalsname;
            patientVitals = new PatientVitals();
            try
            {
                strVitalsValue = ((TextBox)this.FindControl(strTextControl)).Text;
                patientVitals.VitalsID = Convert.ToInt32(((Label)this.FindControl(strIDControl)).Text);
                patientVitals.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                patientVitals.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                patientVitals.PatientVisitID = vid;
                patientVitals.CreatedBy = LID;
                if (strVitalsValue != "" && !strVitalsValue.Contains("-"))
                {
                    //if(isNoInput==false)
                    //    isNoInput = !isNoInput;
                    NoOfEntries += 1;
                    patientVitals.VitalsValue = Convert.ToDecimal(strVitalsValue);
                }
            }
            catch
            {
                blnReturn = false;
                strError = strError + " <%=Resources.ClientSideDisplayTexts.CommonControls_PrintBMI_Entervalidval %>  " + strVitalsname + "<br>";
            }
            lstPatientVitals.Add(patientVitals);
            if (strVitalsValue.Contains("-"))
            {
                blnReturn = false;
                hasNegative = true;
            }
        }
        if (!blnReturn)
        {
            blnReturn = false;
            pnlError.Visible = true;
            //if (isNoInput)
            //{
            //    strError = "<font color='Red' size='1px'>Please enter atleast one value<br>Negative values are invalid</font>";
            //}
            //else
            //{
            if (hasNegative)
            {
                strError = "<font color='Red' size='1px'> " + "<%=Resources.ClientSideDisplayTexts.CommonControls_PrintBMI_Negvalareinvalid %>" + "<br>" + strError + "</font>";
            }
            else
            {
                strError = "<font color='Red' size='1px'>" + strError + "</font>";
            }
            //}
            lblError.Text = strError;
            lblError.Mode = LiteralMode.PassThrough;
        }
        return blnReturn;
    }

    public bool GetPageValues(out List<PatientVitals> lstPatientVitals)
    {
        bool blnReturn = true;
        bool isNoInput = true;
        bool hasNegative = false;
        string strVitalsname = "";
        string strIDControl = "";
        string strVitalsValue = "";
        string strTextControl = "";
        string strError = "";
        pnlError.Visible = false;
        lstPatientVitals = new List<PatientVitals>();
        PatientVitals patientVitals;
        ArrayList al = (ArrayList)ViewState["VitalsForUI"];
        for (int i = 0; i <= (al.Count - 1); i++)
        {
            strVitalsname = al[i].ToString();
            strIDControl = "lbl" + strVitalsname + "VitalsID";
            strTextControl = "txt" + strVitalsname;
            patientVitals = new PatientVitals();
            try
            {
                strVitalsValue = ((TextBox)this.FindControl(strTextControl)).Text;
                patientVitals.VitalsID = Convert.ToInt32(((Label)this.FindControl(strIDControl)).Text);
                patientVitals.ModifiedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                patientVitals.CreatedAt = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                patientVitals.PatientVisitID = VisitID;
                patientVitals.CreatedBy = LID;
                if (strVitalsValue != "" && !strVitalsValue.Contains("-"))
                {
                    isNoInput = false;
                    patientVitals.VitalsValue = Convert.ToDecimal(strVitalsValue);
                }
            }
            catch
            {
                blnReturn = false;
                strError = strError + "<%=Resources.ClientSideDisplayTexts.CommonControls_PrintBMI_Entervalidval %> " + strVitalsname + "<br>";
            }
            lstPatientVitals.Add(patientVitals);
            if (strVitalsValue.Contains("-"))
            {
                blnReturn = false;
                hasNegative = true;
            }
        }
        if (!blnReturn || isNoInput)
        {
            blnReturn = false;
            pnlError.Visible = true;
            if (isNoInput)
            {
                strError = "<font color='Red' size='1px'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_PrintBMI_plsenteroneval %>" + "<br>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_PrintBMI_Negvalareinvalid %>" + "</font>";
            }
            else
            {
                if (hasNegative)
                {
                    strError = "<font color='Red' size='1px'> " + "<%=Resources.ClientSideDisplayTexts.CommonControls_PrintBMI_Negvalareinvalid %>" + "<br>" + strError + "</font>";
                }
                else
                {
                    strError = "<font color='Red' size='1px'>" + strError + "</font>";
                }
            }
            lblError.Text = strError;
            lblError.Mode = LiteralMode.PassThrough;
        }
        return blnReturn;
    }
}
