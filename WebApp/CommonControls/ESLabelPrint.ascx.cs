using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_ESLabelPrint : BaseControl 
{
    long patientID = -1;
    long visitID = -1;
    long returnCode = -1;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Int64.TryParse(Request.QueryString["PID"], out patientID);
            Int64.TryParse(Request.QueryString["VID"], out visitID);
            List<Patient> lstPatient = new List<Patient>();
            returnCode = new IP_BL(base.ContextInfo).GetInPatientRegDetail(patientID, visitID, out lstPatient);
            System.Globalization.TextInfo info = new System.Globalization.CultureInfo("en-US", false).TextInfo;

            if (lstPatient.Count > 0)
            {

                string pAdd = string.Empty;
                string ConsultingSurgeon = lstPatient[0].ConsultingSurgeon == null ? "-" : lstPatient[0].ConsultingSurgeon;
                string ReferingPhysicianName = lstPatient[0].ReferingPhysicianName == null ? "-" : lstPatient[0].ReferingPhysicianName;

                if ((lstPatient[0].Address) != null)
                {
                    foreach (string Add in info.ToLower(lstPatient[0].Address).Split(','))
                    {
                        if (Add != " ")
                        {
                            if (pAdd == string.Empty)
                            {
                                pAdd = Add;
                            }
                            else
                            {
                                pAdd += ',' + Add;
                            }
                        }
                    }
                }
                if (lstPatient.Count > 0)
                {
                    //style='display:block'
                    StringBuilder strLblPrint = new StringBuilder();
                    strLblPrint.AppendFormat("<table  runat='server' cellspacing='0' style=\"font-size:12px; width:287px; height:144px;\">");
                    strLblPrint.AppendFormat("<tr><td style=\"width:100px;\"  valign=\"top\">Name</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + info.ToTitleCase(info.ToLower(lstPatient[0].Name)) + "</td><tr>");
                    strLblPrint.AppendFormat("<tr><td>Patient No</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + lstPatient[0].PatientNumber + "</td><tr>");
                    strLblPrint.AppendFormat("<tr><td>Age/Sex</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + lstPatient[0].Age + '/' + lstPatient[0].SEX + "</td><tr>");
                    strLblPrint.AppendFormat("<tr><td style=\"vertical-align:top;\">Address</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + info.ToTitleCase(pAdd) + "</td><tr>");
                    strLblPrint.AppendFormat("<tr><td>Contact No</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + lstPatient[0].ContactNo + "</td><tr>");
                    strLblPrint.AppendFormat("<tr><td>Consulting Surgeon</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + info.ToTitleCase(info.ToLower(ConsultingSurgeon)) + "</td><tr>");
                    strLblPrint.AppendFormat("<tr><td>ReferringPhysican</td><td nowrap=\"nowrap\" style=\"width:187px;\">" + info.ToTitleCase(info.ToLower(ReferingPhysicianName)) + "</td><tr></table>");
                    lblPrint.Text = strLblPrint.ToString();

                }
            }
        }

    }
}
