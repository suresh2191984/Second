using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_History : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindHistory(List<PatientHistory> lstPatientHistory, List<Patient> lsPatient, List<PatientHistoryExt> lstPatientHistoryExt,string HeaderName)
    {
        lblH.Text = HeaderName;
        if (lstPatientHistoryExt.Count > 0)
        {
            if (lstPatientHistoryExt[0].DetailHistory != "")
            {
                trDH.Style.Add("display", "block");
                ltrDetailHistory.Text = lstPatientHistoryExt[0].DetailHistory;
            }
        }

        if (lstPatientHistory.Count > 0)
        {
           
            TableRow row2 = new TableRow();
            TableCell cell2 = new TableCell();
            cell2.Attributes.Add("align", "left");
            string PatientHistory = string.Empty;
            string Age = string.Empty;
            trH.Style.Add("display", "block");
            foreach (var oPatientHistory in lstPatientHistory)
            {
                if (PatientHistory == string.Empty)
                {

                    if (oPatientHistory.HistoryName != string.Empty)
                    {
                        if (oPatientHistory.Description != " ")
                        {
                            PatientHistory = oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
                        }
                        else
                        {
                            PatientHistory = oPatientHistory.HistoryName;
                        }
                    }

                }

                else
                {

                    if (oPatientHistory.HistoryName != string.Empty)
                    {
                        if (oPatientHistory.Description != " ")
                        {
                            PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName + "(" + oPatientHistory.Description + ")";
                        }
                        else
                        {
                            PatientHistory = PatientHistory + " , " + oPatientHistory.HistoryName;
                        }
                    }

                }

            }

            if (lsPatient.Count > 0)
            {

                string[] Age1 = lsPatient[0].Age.Split(' ');
                if (lsPatient[0].SEX == "M")
                {
                    if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                    {
                        Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "Man presented with history of" + " ";
                    }
                    else
                    {
                        Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old Boy presented with history of" + " ";

                    }

                }
                else if (lsPatient[0].SEX == "F")
                {
                    if (int.Parse(Age1[0]) > 18 && Age1[1] == "Year(s)")
                    {
                        Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "lady presented with history of" + " ";
                    }
                    else
                    {
                        Age = lsPatient[0].Name + "," + lsPatient[0].Age + "  " + "old girl presented with history of" + " ";

                    }
                }
            }
            cell2.Text = Age + PatientHistory + ".";


            row2.Cells.Add(cell2);
            row2.Style.Add("color", "#000");
            tblHistory.Rows.Add(row2);

        }
    }
}
