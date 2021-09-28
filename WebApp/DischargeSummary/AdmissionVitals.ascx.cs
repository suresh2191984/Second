using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_AdmissionVitals : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindAdmissionVitals(List<VitalsUOMJoin> lstVitalsUOMJoin,string HeaderName)
    {
        lblAdmissionVitals.Text = HeaderName;
        if (lstVitalsUOMJoin.Count > 0)
        {
            string Vitalsname = string.Empty;
            string Vitalsvalue = string.Empty;
            string Vitalsunit = string.Empty;

            foreach (var oVitalsUOMJoin in lstVitalsUOMJoin)
            {
                if (Vitalsname == string.Empty)
                {
                    Vitalsname = oVitalsUOMJoin.VitalsName;
                }
                else
                {
                    Vitalsname += "," + oVitalsUOMJoin.VitalsName;
                }
                if (Vitalsvalue == string.Empty)
                {
                    Vitalsvalue = oVitalsUOMJoin.VitalsValue.ToString();
                }
                else
                {
                    Vitalsvalue += "," + oVitalsUOMJoin.VitalsValue.ToString();
                }
                if (Vitalsunit == string.Empty)
                {
                    Vitalsunit = oVitalsUOMJoin.UOMCode;
                }
                else
                {
                    Vitalsunit += "," + oVitalsUOMJoin.UOMCode;
                }
            }

            string[] resVitalsname = Vitalsname.Split(',');
            string[] resVitalsvalue = Vitalsvalue.Split(',');
            string[] resVitalsunit = Vitalsunit.Split(',');



            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();
            TableCell cellH5 = new TableCell();
            TableCell cellH6 = new TableCell();
            TableCell cellH7 = new TableCell();
            TableCell cellH8 = new TableCell();
            cellH1.Attributes.Add("align", "left");
            cellH1.Text = resVitalsname[0];
            cellH2.Attributes.Add("align", "left");
            cellH2.Text = resVitalsname[1];
            cellH3.Attributes.Add("align", "left");
            cellH3.Text = resVitalsname[2];
            cellH4.Attributes.Add("align", "left");
            cellH4.Text = resVitalsname[3];
            cellH5.Attributes.Add("align", "left");
            cellH5.Text = resVitalsname[4];
            cellH6.Attributes.Add("align", "left");
            cellH6.Text = resVitalsname[5];
            cellH7.Attributes.Add("align", "left");
            cellH7.Text = resVitalsname[6];
            cellH8.Attributes.Add("align", "left");
            cellH8.Text = resVitalsname[7];
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            rowH.Cells.Add(cellH5);
            rowH.Cells.Add(cellH6);
            rowH.Cells.Add(cellH7);
            rowH.Cells.Add(cellH8);
            rowH.Font.Bold = true;
            rowH.Style.Add("color", "#000");
            tblgeneralExamination.Rows.Add(rowH);


            TableRow row1 = new TableRow();
            TableCell cell1 = new TableCell();
            TableCell cell2 = new TableCell();
            TableCell cell3 = new TableCell();
            TableCell cell4 = new TableCell();
            TableCell cell5 = new TableCell();
            TableCell cell6 = new TableCell();
            TableCell cell7 = new TableCell();
            TableCell cell8 = new TableCell();
            if (resVitalsvalue[0] != "0.00")
            {
                cell1.Attributes.Add("align", "left");
                cell1.Text = resVitalsvalue[0] + " " + resVitalsunit[0];
            }
            else
            {
                cell1.Text = "-";
            }
            if (resVitalsvalue[1] != "0.00")
            {
                //cell2.Attributes.Add("align", "left");
                //cell2.Text = resVitalsvalue[1] + " " + resVitalsunit[1];
                cell2.Attributes.Add("align", "left");
                string SBP = resVitalsvalue[1];
                string[] resSBP = SBP.Split('.');
                cell2.Text = resSBP[0] + " " + resVitalsunit[1];
            }
            else
            {
                cell2.Text = "-";
            }
            if (resVitalsvalue[2] != "0.00")
            {
                //cell3.Attributes.Add("align", "left");
                //cell3.Text = resVitalsvalue[2] + " " + resVitalsunit[2];

                cell3.Attributes.Add("align", "left");
                string DBP = resVitalsvalue[2];
                string[] resDBP = DBP.Split('.');
                cell3.Text = resDBP[0] + " " + resVitalsunit[2];
            }
            else
            {
                cell3.Text = "-";
            }
            if (resVitalsvalue[3] != "0.00")
            {
                //cell4.Attributes.Add("align", "left");
                //cell4.Text = resVitalsvalue[3] + " " + resVitalsunit[3];
                cell4.Attributes.Add("align", "left");
                string Pulse = resVitalsvalue[3];
                string[] resPulse = Pulse.Split('.');
                cell4.Text = resPulse[0] + " " + resVitalsunit[3];
            }
            else
            {
                cell4.Text = "-";
            }

            if (resVitalsvalue[4] != "0.00")
            {
                cell5.Attributes.Add("align", "left");
                cell5.Text = resVitalsvalue[4] + " " + resVitalsunit[4];
            }
            else
            {
                cell5.Text = "-";
            }
            if (resVitalsvalue[5] != "0.00")
            {
                cell6.Attributes.Add("align", "left");
                cell6.Text = resVitalsvalue[5] + " " + resVitalsunit[5];
            }
            else
            {
                cell6.Text = "-";
            }

            if (resVitalsvalue[6] != "0.00")
            {
                cell7.Attributes.Add("align", "left");
                cell7.Text = resVitalsvalue[6] + " " + resVitalsunit[6];
            }
            else
            {
                cell7.Text = "-";
            }

            if (resVitalsvalue[7] != "0.00")
            {
                //cell8.Attributes.Add("align", "left");
                //cell8.Text = resVitalsvalue[7] + " " + resVitalsunit[7];
                cell8.Attributes.Add("align", "left");
                string RR = resVitalsvalue[7];
                string[] resRR = RR.Split('.');
                cell8.Text = resRR[0] + " " + resVitalsunit[7];
            }
            else
            {
                cell8.Text = "-";
            }

            row1.Cells.Add(cell1);
            row1.Cells.Add(cell2);
            row1.Cells.Add(cell3);
            row1.Cells.Add(cell4);
            row1.Cells.Add(cell5);
            row1.Cells.Add(cell6);
            row1.Cells.Add(cell7);
            row1.Cells.Add(cell8);
            row1.Style.Add("color", "#000");
            tblgeneralExamination.Rows.Add(row1);

        }
    }
}
