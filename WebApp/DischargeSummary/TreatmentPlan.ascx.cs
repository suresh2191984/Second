using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_TreatmentPlan : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindTreatmentPlan(List<IPTreatmentPlan> lstOperationIPTreatmentPlan,string HeaderName)
    {
        lblTP.Text = HeaderName;
        if (lstOperationIPTreatmentPlan.Count > 0)
        {
            //var lstTreatmentPlan = from resPlan in lstOperationIPTreatmentPlan
            //                       where resPlan.StagePlanned == "DSY"
            //                       select resPlan;

          
            //trplan.Style.Add("display", "none");


            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            cellH1.Attributes.Add("align", "left");
            cellH1.Text = "Type";
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "Treatment Name";
            cellH3.Attributes.Add("align", "left");
            cellH3.Text = "Prosthesis";
            cellH4.Attributes.Add("align", "left");
            cellH4.Text = "TreatmentPlan Date";
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Font.Bold = true;
            rowH.Style.Add("color", "#000");
            tblPlan.Rows.Add(rowH);

            foreach (var oIPTreatmentPlan in lstOperationIPTreatmentPlan)
            {
                TableRow row1 = new TableRow();

                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = oIPTreatmentPlan.ParentName;
                cell2.Attributes.Add("align", "left");
                cell2.Text = oIPTreatmentPlan.IPTreatmentPlanName;
                cell3.Attributes.Add("align", "left");
                cell3.Text = oIPTreatmentPlan.Prosthesis;
                if (oIPTreatmentPlan.TreatmentPlanDate == DateTime.MinValue)
                {
                    cell4.Attributes.Add("align", "left");
                    cell4.Text = "Will Be Scheduled later";
                }
                else
                {
                    cell4.Attributes.Add("align", "left");


                    string[] splitDate = oIPTreatmentPlan.TreatmentPlanDate.ToString().Split(' ');

                    if (splitDate[1] == "00:00:00")
                    {

                        cell4.Text = oIPTreatmentPlan.TreatmentPlanDate.ToString("dd/MM/yyyy");
                    }
                    else
                    {
                        cell4.Text = oIPTreatmentPlan.TreatmentPlanDate.ToString("dd/MM/yyyy hh:mm tt");
                    }
                }
                row1.Cells.Add(cell1);
                row1.Cells.Add(cell2);
                row1.Cells.Add(cell3);
                row1.Cells.Add(cell4);

                row1.Style.Add("color", "#000");
                tblPlan.Rows.Add(row1);
            }



        }
    }

}
