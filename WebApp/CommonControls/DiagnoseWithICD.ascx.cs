using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Collections;
using System.Text;


public partial class CommonControls_DiagnoseWithICD : BaseControl
{
    IP_BL objIP_BL;
    List<PatientComplaint> lstPatientComplaint;

    public string FontSize { get; set; }

    public string Height { get; set; }

    public string HeaderText { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

    }


    public void LoadPatientComplaintWithICD(long PatientVisitID, string VisitType, string PageType)
    {
        objIP_BL = new IP_BL(base.ContextInfo);

        lstPatientComplaint=new List<PatientComplaint>();
        objIP_BL.GetPatientComplaintWithICD(PatientVisitID, VisitType,PageType, out lstPatientComplaint);

        if (Height != "")
        {

            tdD.Style.Add("font-size", FontSize);
           
           
        }

        if (lstPatientComplaint.Count > 0)
        {
            //var lstTreatmentPlan = from resPlan in lstOperationIPTreatmentPlan
            //                       where resPlan.StagePlanned == "OPR"
            //                       select resPlan;
            trDiagnosis.Style.Add("display", "block");
            lblHeader.Text = HeaderText;

            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            cellH1.Attributes.Add("align", "left");
            cellH1.Text = "Diagnosis/Medical Problem";
            
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "  " + "ICD 10 Code";

            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);


            rowH.Font.Bold = true;
            rowH.Style.Add("color", "#000");
            tblDiagnoseWithICD.Rows.Add(rowH);

            foreach (var DiagnoseWithICD in lstPatientComplaint)
            {
                TableRow row1 = new TableRow();

                TableCell cell1 = new TableCell();
                TableCell cell2 = new TableCell();


                cell1.Attributes.Add("align", "left");
                cell1.Text = DiagnoseWithICD.ComplaintName;
               
                if (DiagnoseWithICD.ICDCode == "")
                {
                    cell2.Attributes.Add("align", "center");
                    cell2.Text = "";
                }
                else
                {
                    cell2.Attributes.Add("align", "left");
                    cell2.Text =" - "+ DiagnoseWithICD.ICDCode;
                }

                row1.Cells.Add(cell1);
                row1.Cells.Add(cell2);


                row1.Style.Add("color", "#000");
                tblDiagnoseWithICD.Rows.Add(row1);
                if (FontSize != "")
                {
                    tblDiagnoseWithICD.Style.Add("font-size", FontSize);
                    tdD.Style.Add("height", FontSize);
                }
               
            }
        }
    }

}
