using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_DischargePrescription : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindDischargePrescription(IEnumerable<DrugDetails> lstDsy,string HeaderName)
    {


        lblDP.Text = HeaderName;
        TableRow rowH = new TableRow();
        TableCell cellH1 = new TableCell();
        TableCell cellH2 = new TableCell();
        TableCell cellH3 = new TableCell();
        TableCell cellH4 = new TableCell();
        TableCell cellH5 = new TableCell();
        TableCell cellH6 = new TableCell();
        TableCell cellH7 = new TableCell();
        cellH1.Attributes.Add("align", "left");
        cellH1.Text = "Formulation";
        cellH2.Attributes.Add("align", "left");
        cellH2.Text = "Drug Name";
        cellH3.Attributes.Add("align", "left");
        cellH3.Text = "Dose";
        cellH4.Attributes.Add("align", "left");
        cellH4.Text = "ROA";
        cellH5.Attributes.Add("align", "left");        
        cellH5.Text = "Drug Frequency";
        //cellH5.Attributes.Add("width", "50");
        cellH6.Attributes.Add("align", "left");
        cellH6.Text = "Duration";
        cellH7.Attributes.Add("align", "left");
        cellH7.Text = "Instruction";
        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellH2);
        rowH.Cells.Add(cellH3);
        rowH.Cells.Add(cellH4);
        rowH.Cells.Add(cellH5);
        rowH.Cells.Add(cellH6);
        rowH.Cells.Add(cellH7);
        rowH.Font.Bold = true;
        rowH.Style.Add("color", "#000");
        tblprescription.Rows.Add(rowH);
        foreach (var oDrugDetails in lstDsy)
        {

            TableRow row1 = new TableRow();
            TableCell cell1 = new TableCell();
            TableCell cell2 = new TableCell();
            TableCell cell3 = new TableCell();
            TableCell cell4 = new TableCell();
            TableCell cell5 = new TableCell();
            TableCell cell6 = new TableCell();
            TableCell cell7 = new TableCell();
            cell1.Attributes.Add("align", "left");
            cell1.Text = oDrugDetails.DrugFormulation;
            cell2.Attributes.Add("align", "left");
            cell2.Text = oDrugDetails.DrugName;
            cell3.Attributes.Add("align", "left");
            cell3.Text = oDrugDetails.Dose;
            cell4.Attributes.Add("align", "left");
            cell4.Text = oDrugDetails.ROA;
            cell5.Attributes.Add("align", "left");
            //cell5.Attributes.Add("width", "50");
            cell5.Text = oDrugDetails.DrugFrequency;
            cell6.Attributes.Add("align", "left");
            cell6.Text = oDrugDetails.Days;
            cell7.Attributes.Add("align", "left");
            cell7.Text = oDrugDetails.Instruction.ToString();
            row1.Cells.Add(cell1);
            row1.Cells.Add(cell2);
            row1.Cells.Add(cell3);
            row1.Cells.Add(cell4);
            row1.Cells.Add(cell5);
            row1.Cells.Add(cell6);
            row1.Cells.Add(cell7);


            row1.Style.Add("color", "#000");
            tblprescription.Rows.Add(row1);
        }
    }

}
