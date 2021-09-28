using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;
public partial class DischargeSummary_SystemicExamination :BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindSystemicExamination(List<PatientExamination> lstPatientExamination,string HeaderName)
    {
        lblSE.Text = HeaderName;
        foreach (var oPatientExamination in lstPatientExamination)
        {
          
            TableRow row1 = new TableRow();
            TableCell cell1 = new TableCell();
            cell1.Attributes.Add("align", "left");
            if (oPatientExamination.Description != "")
            {
                cell1.Text = oPatientExamination.ExaminationName + " - " + oPatientExamination.Description;

            }


            row1.Cells.Add(cell1);
            row1.Style.Add("color", "#000");
            tblSystamaticExamination.Rows.Add(row1);
        }
    }

    public void BindMusculoskeletal(long VisitID, int OrgID)
    {
        Musculoskeletal1.BindMusculoskeletal(VisitID, OrgID);
    }


}
