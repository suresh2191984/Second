using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_CourseInHospital : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindCourseInHospital(List<DischargeConfig> lstAllDischargeConfig, string HospitalCourse, IEnumerable<DrugDetails> lstCRC, string HeaderName)
    {
        trCourseHospital.Style.Add("display", "block");
        lblHC.Text = HeaderName;
        ltrHospitalcourse.Text = HospitalCourse;

        var NeedAdmissionPrescriptionInDSY = from res in lstAllDischargeConfig
                                             where res.DischargeConfigKey == "NeedAdmissionPrescriptionInDSY"
                                                    && res.DischargeConfigValue == "N"
                                             select res;

        if (NeedAdmissionPrescriptionInDSY.Count() == 0 && lstCRC.Count() > 0)
        {
           
                // trCRCPresc.Style.Add("display", "block");
                trCRCPresc.Style.Add("display", "none");
         
           

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
                cellH5.Text = "DrugFrequency";
                cellH6.Attributes.Add("align", "left");
                cellH6.Text = "Duration";
                rowH.Cells.Add(cellH1);
                rowH.Cells.Add(cellH2);
                rowH.Cells.Add(cellH3);
                rowH.Cells.Add(cellH4);
                rowH.Cells.Add(cellH5);
                rowH.Cells.Add(cellH6);

                rowH.Font.Bold = true;
                rowH.Style.Add("color", "#000");
                tblCRCPresc.Rows.Add(rowH);
                foreach (var oDrugDetails in lstCRC)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    TableCell cell6 = new TableCell();

                    cell1.Attributes.Add("align", "left");
                    cell1.Text = oDrugDetails.DrugFormulation;
                    cell2.Attributes.Add("align", "left");
                    cell2.Text = oDrugDetails.DrugName;
                    cell3.Attributes.Add("align", "left");
                    cell3.Text = oDrugDetails.Dose;
                    cell4.Attributes.Add("align", "left");
                    cell4.Text = oDrugDetails.ROA;
                    cell5.Attributes.Add("align", "left");
                    cell5.Text = oDrugDetails.DrugFrequency;
                    cell6.Attributes.Add("align", "left");
                    cell6.Text = oDrugDetails.Days;

                    row1.Cells.Add(cell1);
                    row1.Cells.Add(cell2);
                    row1.Cells.Add(cell3);
                    row1.Cells.Add(cell4);
                    row1.Cells.Add(cell5);
                    row1.Cells.Add(cell6);


                    row1.Style.Add("color", "#000");
                    tblCRCPresc.Rows.Add(row1);
                }
            
        }
    }
}
