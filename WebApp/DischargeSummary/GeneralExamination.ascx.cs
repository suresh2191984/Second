using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_GeneralExamination : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public int BindGeneralExamination(List<PatientExamination> lstPatientExamination, List<DischargeSummary> lstDischargeSummary, List<Examination> lstNegativeExamination,string HeaderName)
    {
        int Res = 0;
        lblGE.Text=HeaderName;
        {
            TableRow row2 = new TableRow();
            TableCell cell2 = new TableCell();
            cell2.Attributes.Add("align", "left");
            string pSwollen = string.Empty;
            string resSwollen = string.Empty;
            foreach (var oPatientExamination in lstPatientExamination)
            {

                if (oPatientExamination.Description == "")
                {
                    if (oPatientExamination.ExaminationName.Contains("Swollen"))
                    {
                        if (pSwollen == string.Empty)
                        {
                            pSwollen = oPatientExamination.ExaminationName;
                        }
                        else
                        {
                            pSwollen = pSwollen + "," + oPatientExamination.ExaminationName;
                        }

                    }
                    else
                    {
                        if (oPatientExamination.ExaminationName != "CVS" && oPatientExamination.ExaminationName != "RS" && oPatientExamination.ExaminationName != "ABD" && oPatientExamination.ExaminationName != "CNS" && oPatientExamination.ExaminationName != "P/R" && oPatientExamination.ExaminationName != "Genitalia" && oPatientExamination.ExaminationName != "Others")

                            cell2.Text = oPatientExamination.ExaminationName + " ," + cell2.Text;
                    }
                }

            }

            string[] splitSwollen = pSwollen.Split(',');
            if (splitSwollen.Length > 1)
            {
                foreach (var pSwollenitems in splitSwollen)
                {
                    string[] rowSplit = pSwollenitems.Split(' ');
                    if (rowSplit[2] == "Lymph")
                    {
                        if (resSwollen == string.Empty)
                        {
                            resSwollen = "Swollen Lymph Nodes" + "(" + rowSplit[1];
                        }
                        else
                        {
                            resSwollen = resSwollen + "," + rowSplit[1];
                        }

                    }
                }

                cell2.Text = cell2.Text + resSwollen + ")" + "+";
            }

            else
            {
                if (splitSwollen.Length == 1)
                {
                    resSwollen = splitSwollen[0];
                    cell2.Text = cell2.Text + resSwollen;
                }
                else if (splitSwollen.Length == 0)
                {
                    cell2.Text = cell2.Text;
                }

            }


            if (lstNegativeExamination.Count > 0)
            {
                lblGeneralExam.Text = "";


                string Febrile = string.Empty;

                var lstFebrile = from res in lstNegativeExamination
                                 where res.ExaminationName == "Febrile"
                                 select res;

                if (lstFebrile.Count() > 0)
                {
                    Febrile = "Afebrile";
                }
                string NegaitiveSigns = string.Empty;
                foreach (var oNegativeExamination in lstNegativeExamination)
                {
                    if (NegaitiveSigns == string.Empty)
                    {
                        if (oNegativeExamination.ExaminationName != "Febrile")
                        {
                            NegaitiveSigns = oNegativeExamination.ExaminationName;
                        }
                    }
                    else
                    {
                        if (oNegativeExamination.ExaminationName != "Febrile")
                        {
                            NegaitiveSigns += ", " + oNegativeExamination.ExaminationName;
                        }
                    }
                }

                // new GateWay(base.ContextInfo).GetDischargeConfigDetails("NeedNegativeExamInDSY", OrgID, out lstDischargeConfig);

                //var NeedNegativeExamInDSY = from res in lstAllDischargeConfig
                //                            where res.DischargeConfigKey == "NeedNegativeExamInDSY"
                //                                        && res.DischargeConfigValue == "N"
                //                            select res;
                if (lstDischargeSummary.Count > 0)
                {
                    if (lstDischargeSummary[0].PrintNegativeExam == "N")
                    {

                        trNegativeExam.Style.Add("display", "None");

                    }
                    else
                    {
                        Res = 1;
                        trNegativeExam.Style.Add("display", "block");
                        if (NegaitiveSigns != "" && Febrile != "")
                        {
                            lblGeneralExam.Text = Febrile + ",  " + "No signs of" + " " + NegaitiveSigns + ".";
                        }

                        if (NegaitiveSigns != "" && Febrile == "")
                        {
                            lblGeneralExam.Text = "No signs of" + " " + NegaitiveSigns + ".";
                        }
                        if (NegaitiveSigns == "" && Febrile != "")
                        {
                            lblGeneralExam.Text = Febrile + " .";
                        }
                    }

                }



                if (cell2.Text != "")
                {
                    Res = 1;
                    row2.Cells.Add(cell2);
                    row2.Style.Add("color", "#000");
                    tblGeneralExam.Rows.Add(row2);
                }




            }

        }

        return Res;
    }
}
