using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_KMHAdmissionVitals : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindAdmissionVitals(List<VitalsUOMJoin> lstVitalsUOMJoin, string HeaderName)
    {
        decimal sbp, dbp, pulse, weight,  sbp1=0;
        lblAdmissionVitals.Text = HeaderName;
        if (lstVitalsUOMJoin.Count > 0)
        {
           
            lblKADMV.Text = "";

            for (int i = 0; i < lstVitalsUOMJoin.Count; i++)
            {

                if (lstVitalsUOMJoin[i].VitalsName == "SBP")
                {
                    if (lstVitalsUOMJoin[i].VitalsValue != 0)
                    {
                        sbp = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                        sbp = Math.Ceiling(sbp);
                        sbp1 = sbp;
                    }
                }
                if (lstVitalsUOMJoin[i].VitalsName == "DBP")
                {
                    if (lstVitalsUOMJoin[i].VitalsValue != 0)
                    {
                        dbp = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                        dbp = Math.Ceiling(dbp);

                        if (lblKADMV.Text == "")
                        {
                            if (sbp1 != 0)
                            {
                                lblKADMV.Text = "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                            }
                            else
                            {
                                lblKADMV.Text = "BP : " + "-/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (sbp1 != 0)
                            {
                                lblKADMV.Text = lblKADMV.Text + "," + "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                            }
                            else
                            {
                                lblKADMV.Text = lblKADMV.Text + "," + "BP : " + "-/" + dbp.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }
                    else if (sbp1 != 0)
                    {
                        if (lblKADMV.Text == "")
                        {
                            lblKADMV.Text = "BP : " + sbp1 + "/-" + lstVitalsUOMJoin[i].UOMCode;
                        }
                        else
                        {
                            lblKADMV.Text = lblKADMV.Text + "," + "BP : " + sbp1 + "/-" + lstVitalsUOMJoin[i].UOMCode;
                        }

                    }
                }
                if (lstVitalsUOMJoin[i].VitalsName == "Temp")
                {
                    if (lblKADMV.Text == "")
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            lblKADMV.Text = "Temp : " + lstVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }
                    else
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            lblKADMV.Text = lblKADMV.Text + "," + "Temp : " + lstVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }

                }
                if (lstVitalsUOMJoin[i].VitalsName == "Weight")
                {
                    if (lblKADMV.Text == "")
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            weight = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            weight = Math.Ceiling(weight);
                            lblKADMV.Text = "Weight : " + weight + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }
                    else
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            weight = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            weight = Math.Ceiling(weight);
                            lblKADMV.Text = lblKADMV.Text + "," + "Weight : " + weight + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }

                }
                if (lstVitalsUOMJoin[i].VitalsName == "Pulse")
                {
                    if (lblKADMV.Text == "")
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = "Pulse : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }
                    else
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = lblKADMV.Text + "," + "Pulse : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }

                }

                if (lstVitalsUOMJoin[i].VitalsName == "Height")
                {
                    if (lblKADMV.Text == "")
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = "Height : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }
                    else
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = lblKADMV.Text + "," + "Height : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }

                }

                if (lstVitalsUOMJoin[i].VitalsName == "RR")
                {
                    if (lblKADMV.Text == "")
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = "RR : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }
                    else
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = lblKADMV.Text + "," + "RR : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }

                }

                if (lstVitalsUOMJoin[i].VitalsName == "SpO2")
                {
                    if (lblKADMV.Text == "")
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = "SpO2 : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }
                    else
                    {
                        if (lstVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            pulse = decimal.Parse(lstVitalsUOMJoin[i].VitalsValue.ToString());
                            pulse = Math.Ceiling(pulse);
                            lblKADMV.Text = lblKADMV.Text + "," + "SpO2 : " + pulse + " " + lstVitalsUOMJoin[i].UOMCode;
                        }
                    }

                }

            }

            if (lblKADMV.Text != "")
            {
                tblKADMV.Style.Add("display", "block");
            }
        }
    }
}
