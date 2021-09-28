using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class DischargeSummary_Diagnose : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindDiagnose(List<PatientComplaint> lstPatientComplaint, long PatientVisitID, string VisitType, List<DischargeConfig> lstAllDischargeConfig,string HeadrName)
    {

        lblDiagnose.Text = HeadrName;
        var NeedDiagnoseWithICD10InDSY = from res in lstAllDischargeConfig
                                         where res.DischargeConfigKey == "NeedDiagnoseWithICD10InDSY"
                                                && res.DischargeConfigValue == "Y"
                                         select res;

        if (NeedDiagnoseWithICD10InDSY.Count() == 0)
        {

            if (lstPatientComplaint.Count > 0)
            {
                trDiagnosis.Style.Add("display", "block");
                foreach (var oPatientComplaint in lstPatientComplaint)
                {

                    TableRow row1 = new TableRow();
                    TableCell cell1 = new TableCell();
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = "<li type=a>" + oPatientComplaint.ComplaintName;
                    row1.Cells.Add(cell1);
                    row1.Style.Add("color", "#000");
                    tbldiagnosis.Rows.Add(row1);
                }
            }

        }
        else
        {
            trICDDiagnosis.Style.Add("display", "block");
            DiagnoseWithICD1.HeaderText = "DIAGNOSIS";
            DiagnoseWithICD1.LoadPatientComplaintWithICD(PatientVisitID , "IP","DSY");
           
        }
    }
}
