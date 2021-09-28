using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_Advice :BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void BindAdvice(List<PatientAdvice> lstPatientAdvice, List<GeneralAdvice> lstGeneralAdvice, string HeaderName,string NeedGeneralAdvice)
    {
        lblAdvice.Text = HeaderName;
        lblAdvice.Visible = false;
        if (lstPatientAdvice.Count > 0)
        {
            foreach (var oPatientAdvice in lstPatientAdvice)
            {
                string Description = oPatientAdvice.Description;
                TableRow row = new TableRow();
                TableCell cell = new TableCell();
                cell.Attributes.Add("align", "left");
                if (Description.Split('-')[0] == "G")
                {
                    tdGeneral.Style.Add("display", "block");
                    tdGeneralValue.Style.Add("display", "block");
                    cell.Text = oPatientAdvice.Description.Split('-')[1];
                    row.Cells.Add(cell);
                    row.Style.Add("color", "#000");
                    tblAdvice.Rows.Add(row);
                }
                if (Description.Split('-')[0] == "N")
                {
                    tdNutritionH.Style.Add("display", "block");
                    tdNutValue.Style.Add("display", "block");
                    cell.Text = oPatientAdvice.Description.Split('-')[1];
                    row.Cells.Add(cell);                    
                    row.Style.Add("color", "#000");
                    tblNutAdv.Rows.Add(row);
                }
                
            }

        }
        if (NeedGeneralAdvice == "Y")
        {
            if (lstGeneralAdvice.Count > 0)
            {
                trGeneralAdvice.Style.Add("display", "block");

                foreach (var oGeneralAdvicet in lstGeneralAdvice)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + oGeneralAdvicet.AdviceName;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tblGeneralAdvice.Rows.Add(row1);
                }
            }
        }
    }
}
