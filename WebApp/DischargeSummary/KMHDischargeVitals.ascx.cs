using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_KMHDischargeVitals :BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindDischargeVitals(List<VitalsUOMJoin> lstDischargeVitalsUOMJoin, string HeaderName)
    {
        lblDV.Text = HeaderName;
        if (lstDischargeVitalsUOMJoin.Count > 0)
        {

            decimal sbp, dbp, pulse, weight, sbp1 = 0;

            if (lstDischargeVitalsUOMJoin.Count > 0)
            {

                lblKDV.Text = "";

                for (int i = 0; i < lstDischargeVitalsUOMJoin.Count; i++)
                {

                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "SBP")
                    {
                        if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            sbp = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                            sbp = Math.Ceiling(sbp);
                            sbp1 = sbp;
                        }
                    }
                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "DBP")
                    {
                        if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                        {
                            dbp = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                            dbp = Math.Ceiling(dbp);

                            if (lblKDV.Text == "")
                            {
                                if (sbp1 != 0)
                                {
                                    lblKDV.Text = "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                                }
                                else
                                {
                                    lblKDV.Text = "BP : " + "-/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                                }
                            }
                            else
                            {
                                if (sbp1 != 0)
                                {
                                    lblKDV.Text = lblKDV.Text + "," + "BP : " + sbp1 + "/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                                }
                                else
                                {
                                    lblKDV.Text = lblKDV.Text + "," + "BP : " + "-/" + dbp.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                                }
                            }

                        }
                        else if (sbp1 != 0)
                        {
                            if (lblKDV.Text == "")
                            {
                                lblKDV.Text = "BP : " + sbp1 + "/-" + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                            else
                            {
                                lblKDV.Text = lblKDV.Text + "," + "BP : " + sbp1 + "/-" + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }

                        }
                    }
                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "Temp")
                    {
                        if (lblKDV.Text == "")
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                lblKDV.Text = "Temp : " + lstDischargeVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                lblKDV.Text = lblKDV.Text + "," + "Temp : " + lstDischargeVitalsUOMJoin[i].VitalsValue.ToString() + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }
                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "Weight")
                    {
                        if (lblKDV.Text == "")
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                weight = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                weight = Math.Ceiling(weight);
                                lblKDV.Text = "Weight : " + weight + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                weight = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                weight = Math.Ceiling(weight);
                                lblKDV.Text = lblKDV.Text + "," + "Weight : " + weight + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }
                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "Pulse")
                    {
                        if (lblKDV.Text == "")
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = "Pulse : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = lblKDV.Text + "," + "Pulse : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }

                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "Height")
                    {
                        if (lblKDV.Text == "")
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = "Height : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = lblKDV.Text + "," + "Height : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }

                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "RR")
                    {
                        if (lblKDV.Text == "")
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = "RR : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = lblKDV.Text + "," + "RR : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }

                    if (lstDischargeVitalsUOMJoin[i].VitalsName == "SpO2")
                    {
                        if (lblKDV.Text == "")
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = "SpO2 : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }
                        else
                        {
                            if (lstDischargeVitalsUOMJoin[i].VitalsValue != 0)
                            {
                                pulse = decimal.Parse(lstDischargeVitalsUOMJoin[i].VitalsValue.ToString());
                                pulse = Math.Ceiling(pulse);
                                lblKDV.Text = lblKDV.Text + "," + "SpO2 : " + pulse + " " + lstDischargeVitalsUOMJoin[i].UOMCode;
                            }
                        }

                    }

                }

                if (lblKDV.Text != "")
                {
                    tblKDV.Style.Add("display", "block");
                }
            }

        }
    }
}
