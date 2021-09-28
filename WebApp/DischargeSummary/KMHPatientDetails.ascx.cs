using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;


public partial class DischargeSummary_KMHPatientDetails :BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public void BindPatientDetails(List<Patient> lsPatient, List<InPatientAdmissionDetails> lstAdmissionDate, List<InPatientNumber> lstInPatientNumber, List<DischargeSummary> lstDischargeSummary, string PrimaryConsultant, List<RoomMaster> lstRoomMaster, List<PatientAddress> lstPatientAddress)
    {
        if (lsPatient.Count > 0)
        {
            lblNameV.Text = lsPatient[0].Name;
            lblAgeSexV.Text = lsPatient[0].Age + " / " + lsPatient[0].SEX;
            lblBGV.Text = lsPatient[0].BloodGroup;
            lblPIDV.Text = lsPatient[0].PatientNumber;
            lblSPV.Text = lsPatient[0].SpecialityName;
            lblSurgeonV.Text = lsPatient[0].ConsultingSurgeon;

        }


        if (lstInPatientNumber.Count > 0)
        {
            lblIPNOV.Text = lstInPatientNumber[0].IPNumber.ToString();

        }
        if (lstRoomMaster.Count > 0)
        {
            lblUnitV.Text = lstRoomMaster[0].RoomName;
        }

        if (lstAdmissionDate.Count > 0)
        {
            if (lstAdmissionDate[0].AdmissionDate != DateTime.MinValue)
            {
                lblDOAV.Text = lstAdmissionDate[0].AdmissionDate.ToString("dd/MM/yyyy hh:mm tt");
            }
        }

        if (lstDischargeSummary.Count > 0)
        {
            if (lstDischargeSummary[0].DateOfDischarge != DateTime.MinValue)
            {
                lblDODV.Text = lstDischargeSummary[0].DateOfDischarge.ToString("dd/MM/yyyy hh:mm tt");
                lblTODV.Text = lstDischargeSummary[0].DischargeTypeName;
            }

        }

        string MobileNumber = string.Empty;
        string LandLineNumber = string.Empty;
        
        System.Globalization.TextInfo info = new System.Globalization.CultureInfo("en-US", false).TextInfo;

        if (PrimaryConsultant != "")
        {
            lblConsultantV.Text = PrimaryConsultant;
        }


        if (lstPatientAddress.Count > 0)
        {
            string ppermenantAddress = string.Empty;

            foreach (var oPatientAddress in lstPatientAddress)
            {
                if (oPatientAddress.AddressType == "P" && oPatientAddress.Add2 != "")
                {

                    if (oPatientAddress.MobileNumber != "")
                    {
                        MobileNumber = "Mobile No : " + oPatientAddress.MobileNumber;
                    }
                    if (oPatientAddress.LandLineNumber != "")
                    {
                        LandLineNumber = "LandLine No : " + oPatientAddress.LandLineNumber;
                    }
                    ppermenantAddress = oPatientAddress.Add1 + "," + oPatientAddress.Add2 + "," + oPatientAddress.Add3 + "," + oPatientAddress.City + "," + oPatientAddress.PostalCode + "," + oPatientAddress.StateName + "," + oPatientAddress.CountryName + "," + MobileNumber + "," + LandLineNumber;


                }

            }
            string ToLower = info.ToLower(ppermenantAddress);
            string[] PAdd = info.ToTitleCase(ToLower).Split(',');
            string paddress = string.Empty;
            if (PAdd.Length > 1)
            {

                foreach (string sPAdd in PAdd)
                {
                    if (sPAdd != "")
                    {
                        if (paddress == "")
                        {
                            paddress = sPAdd;
                        }
                        else
                        {
                            paddress += " ," +  sPAdd;
                        }
                    }
                }

                TableRow row1 = new TableRow();
                TableCell cell1 = new TableCell();
                cell1.Attributes.Add("align", "left");
                cell1.Text = paddress + ".";
                row1.Cells.Add(cell1);
                row1.Style.Add("color", "#000");
                tblPermenantAddress.Rows.Add(row1);
            }
        }
               
    }
}
