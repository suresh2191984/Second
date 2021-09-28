using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class DischargeSummary_PatientAddress : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindAddress(List<PatientAddress> lstPatientAddress, List<DischargeConfig> lstAllDischargeConfig,string HeaderName)
    {
        string MobileNumber = string.Empty;
        string LandLineNumber = string.Empty;
        lblAdd.Text = HeaderName;
        System.Globalization.TextInfo info = new System.Globalization.CultureInfo("en-US", false).TextInfo;


        if (lstPatientAddress.Count > 0)
        {
            var NeedPatientAddress = from res in lstAllDischargeConfig
                                     where res.DischargeConfigKey == "NeedPatientAddress"
                                            && res.DischargeConfigValue == "Y"
                                     select res;

            if (NeedPatientAddress.Count() > 0)
            {
                if (lstPatientAddress.Count > 0)
                {

                    var NeedPermenantAddress = from res in lstAllDischargeConfig
                                               where res.DischargeConfigKey == "NeedPermenantAddress"
                                                      && res.DischargeConfigValue == "N"
                                               select res;

                    if (NeedPermenantAddress.Count() == 0)
                    {

                        string ppermenantAddress = string.Empty;

                        foreach (var oPatientAddress in lstPatientAddress)
                        {
                            if (oPatientAddress.AddressType == "P" || oPatientAddress.Add2 != "")
                            {
                           
                                if(oPatientAddress.MobileNumber!="")
                                {
                                    MobileNumber = "Mobile No : " + oPatientAddress.MobileNumber;
                                }
                                if (oPatientAddress.LandLineNumber != "")
                                {
                                    LandLineNumber = "LandLine No : " + oPatientAddress.LandLineNumber;
                                }
                                ppermenantAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + MobileNumber + "," + LandLineNumber;


                            }

                        }
                        string ToLower = info.ToLower(ppermenantAddress);
                        string[] PAdd =info.ToTitleCase(ToLower).Split(',');
                        string paddress = string.Empty;
                        if (PAdd.Length > 1)
                        {
                            trAddress.Style.Add("display", "block");
                            tdPermenantAddress.Style.Add("display", "block");
                            foreach (string sPAdd in PAdd)
                            {
                                if (sPAdd != "")
                                {
                                    if (paddress == "")
                                    {
                                        paddress = sPAdd;
                                    }
                                    else
                                    {
                                        paddress += " ," + sPAdd;
                                    }
                                }
                            }

                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = paddress + ".";
                            row1.Cells.Add(cell1);
                            row1.Style.Add("color", "#000");
                            tblPermenantAddress.Rows.Add(row1);
                        }
                    }
                }

                if (lstPatientAddress.Count > 0)
                {


                    var NeedPresentAddress = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedPresentAddress"
                                                    && res.DischargeConfigValue == "N"
                                             select res;
                    if (NeedPresentAddress.Count() == 0)
                    {
                        string pPresentAddress = string.Empty;
                        foreach (var oPatientAddress in lstPatientAddress)
                        {
                            if (oPatientAddress.AddressType == "C" || oPatientAddress.Add2 != "")
                            {
                                if (oPatientAddress.MobileNumber != "")
                                {
                                    MobileNumber = "Mobile No : " + oPatientAddress.MobileNumber;
                                }
                                if (oPatientAddress.LandLineNumber != "")
                                {
                                    LandLineNumber = "LandLine No : " + oPatientAddress.LandLineNumber;
                                }
                                pPresentAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + MobileNumber + "," +LandLineNumber;
                            }

                        }
                        
                        string ToLower = info.ToLower(pPresentAddress);
                        string[] PAdd = info.ToTitleCase(ToLower).Split(',');
                        string caddress = string.Empty;

                        if (PAdd.Length > 1)
                        {
                            tdPresentAddress.Style.Add("display", "block");
                            foreach (string sPAdd in PAdd)
                            {
                                if (sPAdd != "")
                                {
                                    if (caddress == "")
                                    {
                                        caddress = sPAdd;
                                    }
                                    else
                                    {
                                        caddress += " ," + sPAdd;
                                    }
                                }
                            }

                            TableRow row1 = new TableRow();
                            TableCell cell1 = new TableCell();
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = caddress + ".";
                            row1.Cells.Add(cell1);
                            row1.Style.Add("color", "#000");
                            tblPresentAddress.Rows.Add(row1);
                        }
                    }
                }

            }

        }
    }
}
