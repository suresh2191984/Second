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
using System.Collections.Generic;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_PatientHeader : BaseControl
{
public CommonControls_PatientHeader()
        : base("CommonControls_PatientHeader_ascx")
    {
    }
    bool showvitals = true;
    long patientVisitID = 0;
    long patientID = 0;
    decimal sbp, dbp, pulse;
    long vID = -1;
    long pID = -1;
    Patient_BL patientBL;
    string Cdisplayname_M = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_001;
    string Cdisplayname_F = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_002;
    string Cdisplayname_S = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_003;
    string Cdisplayname_Mr = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_004;
    string Cdisplayname_D = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_005;
    string Cdisplayname_W = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_006;
                
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if ((Request.QueryString["vid"] != null) || (Request.QueryString["pid"] != null))
            {
                Int64.TryParse(Request.QueryString["vid"], out patientVisitID);
                Int64.TryParse(Request.QueryString["pid"], out patientID);
            }
            else
            {
                Int64.TryParse(Convert.ToString(Session["PatientVisitID"]), out patientVisitID);
                Int64.TryParse(Convert.ToString(Session["PatientID"]), out patientID);
            }

            // patientBL = new Patient_BL(base.ContextInfo);
            // List<Patient> lstpatient = new List<Patient>();
            // List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();
            // patientBL.GetPatientVitals(PatientVisitID, patientID, OrgID, out lstpatient, out lstpv);


            // if (lstpatient.Count > 0)
            // {
                // lblName.Text = lstpatient[0].Name;
                // lblTitleName.Text = lstpatient[0].TitleName;
                // lblAge.Text = lstpatient[0].PatientAge;
                // if (lstpatient[0].SEX == "M")
                    // lblSex.Text = Cdisplayname_M;
                // else
                    // lblSex.Text = Cdisplayname_F;
                // vitalsImg.Visible = false;
                // if (lstpatient[0].MartialStatus == "S")
                // {
                    // lblMartial.Text = Cdisplayname_S;
                // }
                // if (lstpatient[0].MartialStatus == "M")
                // {
                    // lblMartial.Text = Cdisplayname_Mr;
                // }
                // if (lstpatient[0].MartialStatus == "D")
                // {
                    // lblMartial.Text = Cdisplayname_D;
                // }
                // if (lstpatient[0].MartialStatus == "W")
                // {
                    // lblMartial.Text = Cdisplayname_W;
                // }
                // if (lstpv.Count > 0)
                // {
                    // vitalsImg.Visible = true;
                    // for (int i = 0; i < lstpv.Count; i++)
                    // {
                        // if (lstpv[i].VitalsName == "SBP")
                        // {
                            // sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                            // sbp = Math.Ceiling(sbp);
                            // if (sbp == 0)
                            // {
                                // lblBPVal.Text = "-";
                            // }
                            // else
                            // {
                                // lblBPVal.Text = sbp.ToString();
                            // }


                        // }
                        // if (lstpv[i].VitalsName == "DBP")
                        // {

                            // dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                            // dbp = Math.Ceiling(dbp);
                            // if (dbp == 0)
                            // {
                                // lblBPVal.Text = lblBPVal.Text + " / " + "-" + " " + lstpv[i].UOMCode;
                            // }
                            // else
                            // {
                                // lblBPVal.Text = lblBPVal.Text + " / " + dbp.ToString() + " " + lstpv[i].UOMCode;
                            // }
                        // }
                        // if (lstpv[i].VitalsName == "RR")
                        // {
                            // if (lstpv[i].VitalsValue == 0)
                            // {
                                // lblTempVal.Text = "-";
                            // }
                            // else
                            // {
                                // lblTempVal.Text = lstpv[i].VitalsValue.ToString("0") + " " + lstpv[i].UOMCode;
                            // }
                        // }
                        // if (lstpv[i].VitalsName == "Pulse")
                        // {
                            // if (lstpv[i].VitalsValue == 0)
                            // {
                                // lblPulseVal.Text = "-";
                            // }
                            // else
                            // {
                                // pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                // pulse = Math.Ceiling(pulse);
                                // lblPulseVal.Text = pulse + " " + lstpv[i].UOMCode;
                            // }
                        // }
                    // }
                // }
                // else
                // {
                    // vitalsImg.Visible = false;
                    // VSummry1.Visible = false;
                    // VSummry2.Visible = false;
                    // VSummry3.Visible = false;

                    // lblBP.Visible = false;
                    // lblBPVal.Visible = false;
                    // lblBPUOMCode.Visible = false;

                    // lblTemp.Visible = false;
                    // lblTempVal.Visible = false;
                    // lblTempUOMCode.Visible = false;

                    // lblPulse.Visible = false;
                    // lblPulseVal.Visible = false;
                    // lblPulseUOMCode.Visible = false;
                // }
            // }
            // else
            // {
                // vitalsImg.Visible = false;
                // VSummry1.Visible = false;
                // VSummry2.Visible = false;
                // VSummry3.Visible = false;

                // lblBP.Visible = false;
                // lblBPVal.Visible = false;
                // lblBPUOMCode.Visible = false;

                // lblTemp.Visible = false;
                // lblTempVal.Visible = false;
                // lblTempUOMCode.Visible = false;

                // lblPulse.Visible = false;
                // lblPulseVal.Visible = false;
                // lblPulseUOMCode.Visible = false;
            // }
        }

        //ShowVitalsDetails();
    }

    public bool ShowVitals
    {
        get { return showvitals; }
        set { showvitals = value; }
    }

    public long PatientVisitID
    {
        get { return patientVisitID; }
        set { patientVisitID = value; }
    }

    public long PatientID
    {
        get { return patientID; }
        set { patientID = value; }
    }
    public void ShowVitalsDetails()
    {
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        List<Patient> lstpatient = new List<Patient>();
        List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();
        patientBL.GetPatientVitals(PatientVisitID, patientID, OrgID, out lstpatient, out lstpv);


        if (lstpatient.Count > 0)
        {
            lblName.Text = lstpatient[0].Name;
            lblAge.Text = lstpatient[0].Age.ToString();
            if (lstpatient[0].SEX == "M")
                lblSex.Text = Cdisplayname_M;
            else
                lblSex.Text = Cdisplayname_F;
            vitalsImg.Visible = false;
            if (lstpv.Count > 0)
            {
                vitalsImg.Visible = true;
                for (int i = 0; i < lstpv.Count; i++)
                {
                    if (lstpv[i].VitalsName == "SBP")
                    {
                        sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        sbp = Math.Ceiling(sbp);
                        lblBPVal.Text = sbp.ToString();
                    }
                    if (lstpv[i].VitalsName == "DBP")
                    {
                        dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        dbp = Math.Ceiling(dbp);
                        lblBPVal.Text = lblBPVal.Text + " / " + dbp.ToString() + " " + lstpv[i].UOMCode; ;
                    }
                    if (lstpv[i].VitalsName == "RR")
                    {
                        lblTempVal.Text = lstpv[i].VitalsValue.ToString() + " " + lstpv[i].UOMCode; ;
                    }
                    if (lstpv[i].VitalsName == "Pulse")
                    {
                        pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                        pulse = Math.Ceiling(pulse);
                        lblPulseVal.Text = pulse + " " + lstpv[i].UOMCode; ;
                    }
                }
            }
            else
            {
                vitalsImg.Visible = false;
                VSummry1.Visible = false;
                VSummry2.Visible = false;
                VSummry3.Visible = false;

                lblBP.Visible = false;
                lblBPVal.Visible = false;
                lblBPUOMCode.Visible = false;

                lblTemp.Visible = false;
                lblTempVal.Visible = false;
                lblTempUOMCode.Visible = false;

                lblPulse.Visible = false;
                lblPulseVal.Visible = false;
                lblPulseUOMCode.Visible = false;
            }
        }
        else
        {
            vitalsImg.Visible = false;
            VSummry1.Visible = false;
            VSummry2.Visible = false;
            VSummry3.Visible = false;

            lblBP.Visible = false;
            lblBPVal.Visible = false;
            lblBPUOMCode.Visible = false;

            lblTemp.Visible = false;
            lblTempVal.Visible = false;
            lblTempUOMCode.Visible = false;

            lblPulse.Visible = false;
            lblPulseVal.Visible = false;
            lblPulseUOMCode.Visible = false;
        }

    }
    public void LoadVitals(List<PatientVitals> vitals)
    {
        for (int i = 0; i <= vitals.Count; i++)
        {
            if (i == 0)
            {
                lblBP.Text = vitals[i].VitalsValue.ToString();
            }
            else if (i == 1)
            {
                lblTemp.Text = vitals[i].VitalsValue.ToString();
            }
            else if (i == 2)
            {
                lblPulse.Text = vitals[i].VitalsValue.ToString();
            }
        }
    }
    public void LoadPatientDetails(long PID, long VisitID)
    {
        if (!IsPostBack)
        {
            GetToolTip();
            PatientVisitID = VisitID;
            PatientID = PID;
            patientBL = new Patient_BL(base.ContextInfo);
            List<Patient> lstpatient = new List<Patient>();
            List<VitalsUOMJoin> lstpv = new List<VitalsUOMJoin>();
            patientBL.GetPatientVitals(VisitID, PatientID, OrgID, out lstpatient, out lstpv);

            if (lstpatient != null && lstpatient.Count > 0)
            {
                lblName.Text = lstpatient[0].Name;
                lblTitleName.Text = lstpatient[0].TitleName;
                lblAge.Text = lstpatient[0].PatientAge;
                lblClient.Text = lstpatient[0].TPAName;
                lblRate.Text = lstpatient[0].TypeName;
                lblPatientNumber.Text = lstpatient[0].PatientNumber;
                if (lstpatient[0].SEX == "M")
                {
                    lblSex.Text = Cdisplayname_M;
                }
                else
                {
                    lblSex.Text = Cdisplayname_F;
                }
                vitalsImg.Visible = false;
                if (lstpatient[0].MartialStatus == "S")
                {
                    lblMartial.Text = Cdisplayname_S;
                }
                if (lstpatient[0].MartialStatus == "M")
                {
                    lblMartial.Text = Cdisplayname_Mr;
                }
                if (lstpatient[0].MartialStatus == "D")
                {
                    lblMartial.Text = Cdisplayname_D;
                }
                if (lstpatient[0].MartialStatus == "W")
                {
                    lblMartial.Text = Cdisplayname_W;
                }
                if (lstpv != null && lstpv.Count > 0)
                {
                    vitalsImg.Visible = true;
                    for (int i = 0; i < lstpv.Count; i++)
                    {
                        switch (lstpv[i].VitalsName)
                        {
                            case "SBP":
                                sbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                sbp = Math.Ceiling(sbp);
                                if (sbp == 0)
                                {
                                    lblBPVal.Text = "-";
                                }
                                else
                                {
                                    lblBPVal.Text = sbp.ToString();
                                }
                                break;

                            case "DBP":
                                dbp = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                dbp = Math.Ceiling(dbp);
                                if (dbp == 0)
                                {
                                    lblBPVal.Text = lblBPVal.Text + " / " + "-" + " " + lstpv[i].UOMCode;
                                }
                                else
                                {
                                    lblBPVal.Text = lblBPVal.Text + " / " + dbp.ToString() + " " + lstpv[i].UOMCode;
                                }
                                break;

                            case "RR":
                                if (lstpv[i].VitalsValue == 0)
                                {
                                    lblTempVal.Text = "-";
                                }
                                else
                                {
                                    lblTempVal.Text = lstpv[i].VitalsValue.ToString("0") + " " + lstpv[i].UOMCode;
                                }
                                break;

                            case "Pulse":
                                if (lstpv[i].VitalsValue == 0)
                                {
                                    lblPulseVal.Text = "-";
                                }
                                else
                                {
                                    pulse = decimal.Parse(lstpv[i].VitalsValue.ToString());
                                    pulse = Math.Ceiling(pulse);
                                    lblPulseVal.Text = pulse + " " + lstpv[i].UOMCode;
                                }
                                break;

                            default:
                                break;

                        }
                    }
                }
                else
                {
                    HideElements();
                }
            }
            else
            {
                HideElements();
            }
        }
    }
    private void GetToolTip()
    {
        Patient_BL pBL = new Patient_BL(base.ContextInfo);
        List<AllergyMaster> Allergy = new List<AllergyMaster>();
        pBL.GetPatientAllergy((int)PatientID, out Allergy);
        string TableHead = "";
        if (Allergy.Count > 0)
        {
            string Cdisplayname_AT = Resources.PatientHeader_ascx_ClientDisplay.PatientHeader_ascx_007;
            string TableDate = "";
            TableHead = "<table  border=\"1\" cellpadding=\"1\"cellspacing=\"1\" style=\"background-color:#fff;>"
             + "<tr style=\"font-weight: bold;text-decoration:underline\"><td><u>" + Cdisplayname_AT + "</u></td><td><u>" + "Allergy Name" + "</u></td></tr>";
            foreach (var Item in Allergy)
            {

                TableDate += "<tr style=\"font-weight: bold\">  <td>" + Item.AllergyType + "</td>"
                            + "<td>" + Item.AllergyName + "</td> </tr>";
            }
            TableHead = TableHead + TableDate + "</table> ";
        }
        if (TableHead != "")
        {
            imgallergy.Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + TableHead + "');return false;");
            imgallergy.Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
            imgallergy.Style.Add("display", "block");
        }
    }
    protected void HideElements()
    {
        vitalsImg.Visible = false;
        VSummry1.Visible = false;
        VSummry2.Visible = false;
        VSummry3.Visible = false;

        lblBP.Visible = false;
        lblBPVal.Visible = false;
        lblBPUOMCode.Visible = false;

        lblTemp.Visible = false;
        lblTempVal.Visible = false;
        lblTempUOMCode.Visible = false;

        lblPulse.Visible = false;
        lblPulseVal.Visible = false;
        lblPulseUOMCode.Visible = false;
    }
}
