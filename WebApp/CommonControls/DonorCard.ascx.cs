using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Configuration;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;

public partial class CommonControls_DonorCard : BaseControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load Donor Card Page ", ex);
        }
    }
    public bool loadDonorCardPage(string pNo, string Name,string Age,string Sex,string BloodGrp,string Address,string ContactNo)
    {
        long returnCode = -1;
        List<Patient> lstPatient = new List<Patient>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<AllPhysicianSchedules> lstPhysicianSchedule = new List<AllPhysicianSchedules>();
        try
        {
            lblAge_Sex.Text = Age+"/"+Sex;
            lblBloodGrp.Text = BloodGrp;
            lblContactNo.Text = ContactNo;
            lblDonorNo.Text = pNo;
            lblName.Text = Name;
            lblPatientAddress.Text = Address;
            //string imagepath = ConfigurationManager.AppSettings["PatientPhotoPath"];
            //imgDonor.Src = "~Reception/PatientImageHandler.ashx?FileName=" + "C:\\Users\\Public\\Pictures\\Sample Pictures\\Desert.jpg";
            //returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(pvid, pid, out lstPatient, out lstSpeciality, out lstPhysicianSchedule);

            //if (lstPatient[0].SecuredCode != "")
            //{

            //    lblPatientName.Text = lstPatient[0].Name;
            //    lblPatientNo.Text = lstPatient[0].PatientNumber;
            //    if (lstPatient[0].Age != "0")
            //    {
            //        lblAge_Sex.Text = lstPatient[0].Age.ToString() + " / " + lstPatient[0].SEX;
            //    }
            //    lblConsultant.Text = lstPatient[0].PhysicianName;
            //    lblDateTime.Text = lstPatient[0].VisitDate.ToString();

            //    if (lstPatient[0].Add1 != "")
            //    {
            //        lblPatientAddress.Text += lstPatient[0].Add1 + ",<br/>";
            //    }
            //    if (lstPatient[0].Add2 != "")
            //    {
            //        lblPatientAddress.Text += lstPatient[0].Add2 + ",<br/>";
            //    }
            //    if (lstPatient[0].Add3 != "")
            //    {
            //        lblPatientAddress.Text += lstPatient[0].Add3 + ",<br/>";
            //    }
            //    if (lstPatient[0].City != "")
            //    {
            //        lblPatientAddress.Text += lstPatient[0].City + ".";
            //    }
            //    lblContactNo.Text = lstPatient[0].ContactNo;
            //    if (lstPatient[0].TPAName != "")
            //    {
            //        lblPanelName.Text = lstPatient[0].TPAName;
            //        SlblPanelName.Visible = true;
            //        lblPanelName.Visible = true;
            //    }
            //    else
            //    {
            //        SlblPanelName.Visible = false;
            //        lblPanelName.Visible = false;
            //    }
            //    if (lstSpeciality.Count > 0)
            //    {
            //        bool isFirstrecord = true;
            //        for (int i = 0; i < lstSpeciality.Count; i++)
            //        {
            //            if (isFirstrecord)
            //            {
            //                lblDepartment.Text += lstSpeciality[i].SpecialityName;
            //                isFirstrecord = false;
            //            }
            //            else { lblDepartment.Text += ", " + lstSpeciality[i].SpecialityName; }
            //        }
            //    }

            //    Hashtable ht = new Hashtable();

            //    if (lstPhysicianSchedule.Count > 0)
            //    {
            //        string sun, mon, tue, wed, thu, fri, sat;
            //        ArrayList arrWork = new ArrayList();
            //        ArrayList arrNonWork = new ArrayList();
            //        var list = new List<int>();
            //        arrWork.Clear();
            //        arrNonWork.Clear();
            //        //int i = 0;
            //        for (int i = 0; i < lstPhysicianSchedule.Count; i++)
            //        {


            //            sun = lstPhysicianSchedule[i].Sunday;
            //            mon = lstPhysicianSchedule[i].Monday;
            //            tue = lstPhysicianSchedule[i].Tuesday;
            //            wed = lstPhysicianSchedule[i].Wednesday;
            //            thu = lstPhysicianSchedule[i].Thursday;
            //            fri = lstPhysicianSchedule[i].Friday;
            //            sat = lstPhysicianSchedule[i].Saturday;


            //            if (!ht.Contains(lstPhysicianSchedule[i].StartTime + "-" + lstPhysicianSchedule[i].EndTime))
            //            {

            //                if (sun == "Y")
            //                {
            //                    lblAvailablity.Text += "Sunday,";
            //                }


            //                if (mon == "Y")
            //                {
            //                    lblAvailablity.Text += "Monday,";
            //                }


            //                if (tue == "Y")
            //                {
            //                    lblAvailablity.Text += "Tuesday,";

            //                }


            //                if (wed == "Y")
            //                {
            //                    lblAvailablity.Text += "Wednesday,";

            //                }


            //                if (thu == "Y")
            //                {
            //                    lblAvailablity.Text += "Thursday,";
            //                }


            //                if (fri == "Y")
            //                {
            //                    lblAvailablity.Text += "Friday,";
            //                }


            //                if (sat == "Y")
            //                {
            //                    lblAvailablity.Text += "Saturday";
            //                }



            //                lblAvailablity.Text += "-" + lstPhysicianSchedule[i].StartTime.ToString("h:mm tt") + " to " + lstPhysicianSchedule[i].EndTime.ToString("h:mm tt") + "<br>";
            //                ht.Add(lstPhysicianSchedule[i].StartTime + "-" + lstPhysicianSchedule[i].EndTime, sun + mon + tue + wed + thu + fri + sat + sun);

            //            }



            //        }


            //    }

            //}
            //else
            //{
            //    tblSecPage.Visible = false;
            //    //lblMessage.Text = "There is no Security Prescription Page";
            //}
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Secured Page.ascx", ex);
        }

        return true;
    }
}
