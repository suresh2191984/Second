using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;


public partial class CommonControls_PatientVitals2 : BaseControl
{
    string name = string.Empty;
    string age = string.Empty;
    string sex = string.Empty;
    string sbp = string.Empty;
    string dbp = string.Empty;
    string temp = string.Empty;
    string pluse = string.Empty;
    bool showvitals = true;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblName.Text = Name;
        lblAge.Text = Age;
        lblSex.Text = Sex;
        if (showvitals)
        {
            lblBPVal.Text = SBP;
            lblTempVal.Text = Temp;
            lblPulseVal.Text = Pluse;
        }
        else {
            lblBPVal.Text = null;
            lblTempVal.Text = null;
            lblPulseVal.Text = null;
        }
    }
    public string Name
    {
        get { return name; }
        set { name = value; }
    }
    public string Age
    {
        get { return age; }
        set { age = value; }
    }
    public string Sex
    {
        get { return sex; }
        set { sex = value; }
    }
    public string SBP
    {
        get { return sbp; }
        set { sbp = value; }
    }
    public string DBP
    {
        get { return dbp; }
        set { dbp = value; }
    }
    public string Temp
    {
        get { return temp; }
        set { temp = value; }
    }
    public string Pluse
    {
        get { return pluse; }
        set { pluse = value; }
    }

    public bool ShowVitals
    {
        set 
        { 
            showvitals = value;
            ShowHideVitals();
        }
    }

    private void ShowHideVitals()
    {
        if (!showvitals)
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
        //for (int i = 0; i <= vitals.Count; i++)
        //{
        //    if (i == 0)
        //    {
        //        lblSBP.Text = vitals[i].VitalsValue.ToString();
        //    }
        //    else if (i == 1)
        //    {
        //        lblTemp.Text = vitals[i].VitalsValue.ToString();
        //    }
        //    else if (i == 2)
        //    {
        //        lblPulse.Text = vitals[i].VitalsValue.ToString();
        //    }           
        //}
    }
}
