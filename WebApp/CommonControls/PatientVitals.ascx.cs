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

public partial class CommonControls_PatientVitals : BaseControl
{
    ArrayList al = new ArrayList();
    long visitID = -1;
    long patientID = -1;
    string type = string.Empty;
    decimal lngHeight = 0;
    decimal lngWeight = 0;
    decimal decWaist = 0;
    decimal decHip = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        txtTemp.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtPulse.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtHeight.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtWeight.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtSpO2.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtSBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtDBP.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtSBP.Attributes.Add("onKeyUp", "PreSBPKeyPress();");
        txtRR.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtBMI.Style.Add("display", "none");
        lblBMIVitalsName.Style.Add("display", "none");
        txtWaistCircumference.Attributes.Add("onKeyDown", "return validatenumber(event);");
        txtHipCircumference.Attributes.Add("onKeyDown", "return validatenumber(event);");
        if (!IsPostBack)
        {
            patientID = Convert.ToInt32(Request.QueryString["PID"]);
            type = Convert.ToString(Request.QueryString["type"]);
            if (type != null)
            {
                LoadControls(type, patientID);
            }
        }
    }

    /// <summary>
    /// Loads the control dynamically on demand.
    /// </summary>
    /// <param name="TransType">Insert/Update</param>
    /// <param name="pid">PatientID</param>
    public void LoadControls(string TransType, long pid)
    {
        ViewState["VitalsForUI"] = null;

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
            if (TransType.ToUpper().Equals("I"))
            {
                returnCode = patientVitalsBL.GetVitalsForUI(OrgID, vitalsGroup, out lstVitalsUOMJoin);
            }
            else if (TransType.ToUpper().Equals("U"))
            {
                returnCode = patientVitalsBL.GetVitalsForUpdate(pid, OrgID, out visitID, out lstVitalsUOMJoin);
            }
            else if (TransType.ToUpper().Equals("IPU"))
            {
                returnCode = patientVitalsBL.GetInPatientVitalsForUpdate(pid, OrgID, out visitID, out lstVitalsUOMJoin);
            }
            else if (TransType.ToUpper().Equals("CRCU"))
            {
                returnCode = patientVitalsBL.GetIPCaseRecordVitalsForUpdate(pid, OrgID, out visitID, out lstVitalsUOMJoin);

            }
            else if (TransType.ToUpper().Equals("NNU"))//Neonatal Notes
            {
                returnCode = patientVitalsBL.GetNeonatalNotesVitalsForUpdate(pid, OrgID, out visitID, out lstVitalsUOMJoin);

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
            string strWHR = string.Empty;
            string strBMI = string.Empty;
            foreach (VitalsUOMJoin vuj in lstVitalsUOMJoin)
            {
                strVitalsname = vuj.VitalsName;
                strIDControl = "lbl" + strVitalsname + "VitalsID";
                strNameControl = "lbl" + strVitalsname + "VitalsName";
                strTextControl = "txt" + strVitalsname;
                strUOMControl = "lbl" + strVitalsname + "UOMCode";
                lblWaistCircumferenceVitalsName.Text = "Waist Circumference";
                lblHipCircumferenceVitalsName.Text = "Hip Circumference";
                lblWHRVitalsName.Text = "WHR";


                if (this.FindControl(strIDControl) != null)
                {
                    if (vuj.VitalsGroup.ToUpper().Equals("GENERAL"))
                    {
                        al.Add(strVitalsname);

                        ((Label)this.FindControl(strIDControl)).Text = vuj.VitalsID.ToString();
                        ((Label)this.FindControl(strNameControl)).Text = vuj.VitalsName;
                        if (strVitalsname.Length > 5)
                        {
                            string sam = strVitalsname.Substring(0, 5);
                            string sam1 = strVitalsname.Substring(0, 3);
                            if (strVitalsname.Substring(0, 5) == "Waist")
                            {
                                ((Label)this.FindControl(strNameControl)).Text = strVitalsname.Substring(0, 5) + " " + strVitalsname.Substring(5, (strVitalsname.Length - 5));
                            }
                        }
                        if (strVitalsname.Length > 4)
                        {
                            if (strVitalsname.Substring(0, 3) == "Hip")
                            {
                                ((Label)this.FindControl(strNameControl)).Text = strVitalsname.Substring(0, 3) + " " + strVitalsname.Substring(3, (strVitalsname.Length - 3));
                            }
                        }
                        ((Label)this.FindControl(strUOMControl)).Text = vuj.UOMCode;
                        //((TextBox)this.FindControl(strTextControl)).Text = Convert.ToString(vuj.VitalsValue) != "0" ? Convert.ToString(vuj.VitalsValue) : "";
                        if (vuj.VitalsName == "SBP" || vuj.VitalsName == "DBP" || vuj.VitalsName == "RR" || vuj.VitalsName == "Pulse")
                        {
                            ((TextBox)this.FindControl(strTextControl)).Text = vuj.VitalsValue > 0 ? Convert.ToString(Convert.ToInt32(vuj.VitalsValue)) : "";
                        }
                        else
                        {
                            ((TextBox)this.FindControl(strTextControl)).Text = vuj.VitalsValue > 0 ? Convert.ToString(vuj.VitalsValue) : "";
                            if (vuj.VitalsName == "WaistCircumference")
                            {
                                decWaist = Convert.ToDecimal(vuj.VitalsValue);
                            }
                            if (vuj.VitalsName == "HipCircumference")
                            {
                                decHip = Convert.ToDecimal(vuj.VitalsValue);
                            }
                            if (decHip != 0 && decWaist != 0)
                            {
                                decimal decWHR = decWaist / decHip;
                                strWHR = decWHR.ToString("#.##");
                                lblWHRValueVitalsName.Text = " : " + strWHR;
                                txtWHR.Text = strWHR;
                                //((TextBox)this.FindControl(strTextControl)).Text = strWHR;
                                decWaist = 0;
                                decHip = 0;
                            }
                            if (strTextControl == "txtWHR")
                            {
                                ((TextBox)this.FindControl(strTextControl)).Text = strWHR;
                            }
                            if (vuj.VitalsName == "Height")
                            {
                                lngHeight = Convert.ToDecimal(vuj.VitalsValue);
                            }
                            if (vuj.VitalsName == "Weight")
                            {
                                lngWeight = Convert.ToDecimal(vuj.VitalsValue);
                            }
                            if (lngWeight != 0 && lngHeight != 0)
                            {
                                decimal lngdiv = lngHeight / 100;
                                lngdiv = lngWeight / (lngdiv * lngdiv);
                                strBMI = lngdiv.ToString("#.##");
                                lblBMIValueVitalsName.Text = " : " + strBMI;
                                txtBMI.Text = strBMI;
                                lngHeight = 0;
                                lngWeight = 0;
                                txtBMI.Style.Add("display", "block");
                                lblBMIVitalsName.Style.Add("display", "block");
                            }
                            if (strTextControl == "txtBMI")
                            {
                                ((TextBox)this.FindControl(strTextControl)).Text = strBMI;
                            }
                        }
                    }
                }
            }
            txtBMI.Text = strBMI;
            txtWHR.Text = strWHR;
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

        // pnlError.Visible = false;

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
                strError = strError + "<%=Resources.ClientSideDisplayTexts.CommonControls_PatientVitals_Entervalidvaluefor %>" + strVitalsname + "<br>";
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
            //pnlError.Visible = true;
            //if (isNoInput)
            //{
            //    strError = "<font color='Red' size='1px'>Please enter atleast one value<br>Negative values are invalid</font>";
            //}
            //else
            //{
            if (hasNegative)
            {
                strError = "<font color='Red' size='1px'> " + "<%=Resources.ClientSideDisplayTexts.CommonControls_PatientVitals_negvalueinvalid %>" + " <br>" + strError + "</font>";
            }
            else
            {
                strError = "<font color='Red' size='1px'>" + strError + "</font>";
            }
            //}
            //lblError.Text = strError;
            //lblError.Mode = LiteralMode.PassThrough;
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

        // pnlError.Visible = false;

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
                strError = strError + "<%=Resources.ClientSideDisplayTexts.CommonControls_PatientVitals_Entervalidvaluefor %> " + strVitalsname + "<br>";
            }
            DateTime EnterDate = DateTime.MaxValue;

            if (txtValidate.Text.Trim() != "")
            {
                DateTime.TryParse(txtValidate.Text.Trim(), out EnterDate);
                patientVitals.EnterDate = EnterDate;
            }
            else
            {
                patientVitals.EnterDate = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
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
            // pnlError.Visible = true;
            if (isNoInput)
            {
                strError = "<font color='Red' size='1px'>" + " <%=Resources.ClientSideDisplayTexts.CommonControls_PatientVitals_plsenterval %> " + " <br>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_PatientVitals_negvalueinvalid %>" + "</font>";
            }
            else
            {
                if (hasNegative)
                {
                    strError = "<font color='Red' size='1px'>" + "<%=Resources.ClientSideDisplayTexts.CommonControls_PatientVitals_negvalueinvalid %>" + "<br>" + strError + "</font>";
                }
                else
                {
                    strError = "<font color='Red' size='1px'>" + strError + "</font>";
                }
            }
            //lblError.Text = strError;
            //lblError.Mode = LiteralMode.PassThrough;
        }
        return blnReturn;
    }

}
