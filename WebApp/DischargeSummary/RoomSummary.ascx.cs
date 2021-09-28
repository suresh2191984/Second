using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_RoomSummary : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void BindBedBookingBDetails(List<BedBooking> lstBedBookinG, string HeaderName)
    {      
        lblTP.Text = HeaderName;
        if (lstBedBookinG.Count > 0)
        {
            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            TableCell cellH5 = new TableCell();
            cellH1.Attributes.Add("align", "center");
            cellH1.Text = "Room Name";
            cellH2.Attributes.Add("align", "center");
            cellH2.Text = "Bed Name";
            cellH3.Attributes.Add("align", "center");
            cellH3.Text = "From Date";
            cellH4.Attributes.Add("align", "center");
            cellH4.Text = "To Date";
            cellH5.Attributes.Add("align", "center");
            cellH5.Text = "Status";
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Cells.Add(cellH5);
            rowH.Font.Bold = true;
            rowH.Style.Add("color", "#000");
            tblPlan.Rows.Add(rowH);

            foreach (var oIPTreatmentPlan in lstBedBookinG)
            {
                TableRow row1 = new TableRow();

                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                TableCell cell5 = new TableCell();
                cell1.Attributes.Add("align", "center");
                cell1.Text = oIPTreatmentPlan.PatientName;
                cell2.Attributes.Add("align", "center");
                cell2.Text = oIPTreatmentPlan.Description;
                cell3.Attributes.Add("align", "center");
                cell3.Text = oIPTreatmentPlan.FromDate.ToString();
                cell4.Attributes.Add("align", "center");
                cell4.Text = oIPTreatmentPlan.ToDate.ToString();
                cell5.Attributes.Add("align", "center");
                cell5.Text = oIPTreatmentPlan.Status; 
               
                row1.Cells.Add(cell1);
                row1.Cells.Add(cell2);
                row1.Cells.Add(cell3);
                row1.Cells.Add(cell4);
                row1.Cells.Add(cell5);

                row1.Style.Add("color", "#000");
                tblPlan.Rows.Add(row1);
            }
        }
    }
}
