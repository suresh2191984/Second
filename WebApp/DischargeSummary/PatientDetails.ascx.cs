using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class DischargeSummary_PatientDetails : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public void BindPatientDetails(List<Patient> lsPatient,string CustomIPNO)
    {
        if (lsPatient[0].SEX == "M")
        {
            if (BloodGroup != "")
            {
                lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "  BloodGroup: " + BloodGroup +","+ "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")";
            }
            else
            {
                lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")" ;
            }

        }
        else if (lsPatient[0].SEX == "F")
        {
            if (BloodGroup != "")
            {
                lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "  BloodGroup: " + BloodGroup +","+ "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")";
            }
            else
            {
                lblPatientDetail.Text = lsPatient[0].Name + "," + lsPatient[0].Age + "/" + lsPatient[0].SEX + "," + "(Patient ID-" + lsPatient[0].PatientNumber.ToString() + ")";

            }
        }


        if (CustomIPNO != "")
        {
            //trCIP.Style.Add("display", "block");
            //lblCIPNoV.Text = CustomIPNO;
            lblPatientDetail.Text = lblPatientDetail.Text + "," + "(IP Number-" + CustomIPNO + ")";
        }
    }

}
