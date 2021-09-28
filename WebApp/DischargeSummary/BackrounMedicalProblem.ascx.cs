using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
public partial class DischargeSummary_BackrounMedicalProblem : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindBackrounMedicalProblem(List<DischargeSummary> lstDischargeSummary, List<IPComplaint> lstNegativeIPComplaint, List<BackgroundProblem> lstBackgroundProblem,string HeaderName)
    {

        lblBMP.Text = HeaderName;
        if (lstDischargeSummary.Count > 0)
        {
            if (lstDischargeSummary[0].PrintNegativeHistory == "N")
            {

                trNegativeHistory.Style.Add("display", "none");

            }
            else
            {
                if (lstNegativeIPComplaint.Count > 0)
                {

                    trNegativeHistory.Style.Add("display", "block");
                    string NegaitiveHis = string.Empty;
                    foreach (var oNegativeIPComplaint in lstNegativeIPComplaint)
                    {
                        if (NegaitiveHis == string.Empty)
                        {
                            NegaitiveHis = oNegativeIPComplaint.ComplaintName;
                        }
                        else
                        {
                            NegaitiveHis += ", " + oNegativeIPComplaint.ComplaintName;
                        }
                    }

                    lblBackgroundProblems.Text = "No history of" + " " + NegaitiveHis + ".";
                }
            }
        }



        if (lstBackgroundProblem.Count > 0)
        {
          
            foreach (var oBackgroundProblem in lstBackgroundProblem)
            {
                TableRow row1 = new TableRow();
                TableCell cell1 = new TableCell();
                if (oBackgroundProblem.Description != "")
                {
                    if (oBackgroundProblem.ComplaintName == "Stroke(CVA)")
                    {
                        string[] PStroke = oBackgroundProblem.Description.Split('^');
                        if (PStroke[0].Contains('/'))
                        {
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[0] + "," + PStroke[1];
                        }
                        else
                        {
                            cell1.Attributes.Add("align", "left");
                            cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + PStroke[1];
                        }

                    }
                    else
                    {
                        cell1.Attributes.Add("align", "left");
                        cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName + " - " + oBackgroundProblem.Description;
                    }
                }
                else
                {
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + oBackgroundProblem.ComplaintName;
                }
                row1.Cells.Add(cell1);
                row1.Style.Add("color", "#000");
                tblBackgroundProblems.Rows.Add(row1);
            }
        }


    }
}
