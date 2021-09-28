using System;
using System.Collections.Generic;
using System.Collections;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections.Specialized;

public partial class CommonControls_SecPrescriptionPage : BaseControl
{
    enum Week
    {
        Sunday = 1,
        Monday = 2,
        Tuesday = 3,
        Wednesday = 4,
        Thursday = 5,
        Friday = 6,
        Saturday = 7
    };

    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    public bool loadPatientSecPrintPage()
    {
        //lblMessage.Text = string.Empty;
        long returnCode = -1;
        long pvid = -1;
        long pid = -1;
        Int64.TryParse(Request.QueryString["vid"], out pvid);
        Int64.TryParse(Request.QueryString["pid"], out pid);
        List<Patient> lstPatient = new List<Patient>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<AllPhysicianSchedules> lstPhysicianSchedule = new List<AllPhysicianSchedules>();
        lblPatientAddress.Text = "";
        lblDepartment.Text = "";
        lblAvailablity.Text = "";
        tdSmartPage.Style.Add("display", "none");
        try
        {
            returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(pvid, pid, out lstPatient, out lstSpeciality, out lstPhysicianSchedule);

            if (lstPatient[0].SecuredCode != "")
            { 
                List<Config> lstConfig = new List<Config>();
                int iBillGroupID = 0;
                iBillGroupID = (int)ReportType.OPBill;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    imgBillLogo.ImageUrl = lstConfig[0].ConfigValue == "NA" ? string.Empty : lstConfig[0].ConfigValue;
                    if (imgBillLogo.ImageUrl.Length > 0)
                        imgBillLogo.Visible = true;
                    else
                        imgBillLogo.Visible = false;
                }
                lstConfig = null;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    imgBillLogo.ImageUrl = lstConfig[0].ConfigValue == "NA" ? string.Empty : lstConfig[0].ConfigValue;
                    if (imgBillLogo.ImageUrl.Length > 0)
                        imgBillLogo.Visible = true;
                    else
                        imgBillLogo.Visible = false;
                }
                lstConfig = null;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    tdOrgAddress.Style.Add("font-family", lstConfig[0].ConfigValue == "NA" ? string.Empty : lstConfig[0].ConfigValue);
                }
                lstConfig = null;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Font Size", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    lstConfig[0].ConfigValue = "14pt";
                    tdOrgAddress.Style.Add("font-size", lstConfig[0].ConfigValue == "NA" ? string.Empty : lstConfig[0].ConfigValue);
                }
                lstConfig = null;
                new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);
                if (lstConfig.Count > 0)
                {
                    tdOrgAddress.InnerHtml = lstConfig[0].ConfigValue == "NA" ? string.Empty : lstConfig[0].ConfigValue;
                } 

                lblPatientName.Text = lstPatient[0].Name;
                lblPatientNameText.Text = lstPatient[0].Name;

                lblPatientNo.Text = lstPatient[0].PatientNumber;
                lblPatientNumberText.Text = lstPatient[0].PatientNumber;

                if (lstPatient[0].Age != "0")
                {
                    lblAge_Sex.Text = lstPatient[0].Age.ToString() + " / " + lstPatient[0].SEX;
                    lblAgeSexText.Text = lstPatient[0].Age.ToString() + " / " + lstPatient[0].SEX;
                }
                lblConsultant.Text = lstPatient[0].PhysicianName;
                lblConsultantText.Text = lstPatient[0].PhysicianName;
                lblDateTime.Text = lstPatient[0].VisitDate.ToString();
                lblDateText.Text = Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString("dd/MM/yyyy");
                if (lstPatient[0].Add1 != "")
                {
                    lblPatientAddress.Text += lstPatient[0].Add1 + ",<br/>";
                    lblPatientAddressText.Text += lstPatient[0].Add1 + ",<br/>";
                }
                if (lstPatient[0].Add2 != "")
                {
                    lblPatientAddress.Text += lstPatient[0].Add2 + ",<br/>";
                    lblPatientAddressText.Text += lstPatient[0].Add1 + ",<br/>";
                }
                if (lstPatient[0].Add3 != "")
                {
                    lblPatientAddress.Text += lstPatient[0].Add3 + ",<br/>";
                    lblPatientAddressText.Text += lstPatient[0].Add1 + ",<br/>";
                }
                if (lstPatient[0].City != "")
                {
                    lblPatientAddress.Text += lstPatient[0].City + ".";
                    lblPatientAddressText.Text += lstPatient[0].City + ".";
                }

                lblContactNo.Text = lstPatient[0].ContactNo;
                lblContactNumberText.Text = lstPatient[0].ContactNo;
                if (lstPatient[0].TPAName != "")
                {
                    lblPanelName.Text = lstPatient[0].TPAName;
                    SlblPanelName.Visible = true;
                    lblPanelName.Visible = true;
                    Label1.Visible = true;
                }
                else
                {
                    SlblPanelName.Visible = false;
                    lblPanelName.Visible = false;
                    Label1.Visible = false;
                }
                //sathish---NotifyType Method use for Visit Type instead of _visitType//
                if (lstPatient[0].NotifyType == 0)
                {
                    lblVisitType.Text = pvid + "/" + "OP" + "<br/>";
                }
                else
                {
                    lblVisitType.Text = pvid + "/" + "IP" + "<br/>";
                }
                if (lstSpeciality.Count > 0)
                {
                    bool isFirstrecord = true;
                    for (int i = 0; i < lstSpeciality.Count; i++)
                    {
                        if (isFirstrecord)
                        {
                            lblDepartment.Text += lstSpeciality[i].SpecialityName;
                            isFirstrecord = false;
                        }
                        else { lblDepartment.Text += ", " + lstSpeciality[i].SpecialityName; }
                    }
                }

                Hashtable ht = new Hashtable();

                if (lstPhysicianSchedule.Count > 0)
                {
                    string sun, mon, tue, wed, thu, fri, sat;
                    ArrayList arrWork = new ArrayList();
                    ArrayList arrNonWork = new ArrayList();
                    var list = new List<int>();
                    arrWork.Clear();
                    arrNonWork.Clear();
                    for (int i = 0; i < lstPhysicianSchedule.Count; i++)
                    {
                        sun = lstPhysicianSchedule[i].Sunday;
                        mon = lstPhysicianSchedule[i].Monday;
                        tue = lstPhysicianSchedule[i].Tuesday;
                        wed = lstPhysicianSchedule[i].Wednesday;
                        thu = lstPhysicianSchedule[i].Thursday;
                        fri = lstPhysicianSchedule[i].Friday;
                        sat = lstPhysicianSchedule[i].Saturday;

                        if (!ht.Contains(lstPhysicianSchedule[i].StartTime + "-" + lstPhysicianSchedule[i].EndTime))
                        {

                            if (sun == "Y")
                            {
                                lblAvailablity.Text += "Sunday,";
                            }

                            if (mon == "Y")
                            {
                                lblAvailablity.Text += "Monday,";
                            }

                            if (tue == "Y")
                            {
                                lblAvailablity.Text += "Tuesday,";

                            }

                            if (wed == "Y")
                            {
                                lblAvailablity.Text += "Wednesday,";

                            }

                            if (thu == "Y")
                            {
                                lblAvailablity.Text += "Thursday,";
                            }

                            if (fri == "Y")
                            {
                                lblAvailablity.Text += "Friday,";
                            }

                            if (sat == "Y")
                            {
                                lblAvailablity.Text += "Saturday";
                            }

                            lblAvailablity.Text += "-" + lstPhysicianSchedule[i].StartTime.ToString("h:mm tt") + " to " + lstPhysicianSchedule[i].EndTime.ToString("h:mm tt") + "<br>";
                            ht.Add(lstPhysicianSchedule[i].StartTime + "-" + lstPhysicianSchedule[i].EndTime, sun + mon + tue + wed + thu + fri + sat + sun);

                        }

                    } 
                }
            }
            else
            {
                tblSecPage.Visible = false;
                //lblMessage.Text = "There is no Security Prescription Page";
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Secured Page.ascx", ex);
        }

        return true;
    }

    public void loadPatientSecDetail(List<Patient> lstPatient)
    {
        //lblOrgName.Text = OrgName;

        //trSecCode.Visible = false;
        //lblOrgName.Text = OrgName;
        //trSecCode.Visible = false;
        //lblSecCode.Text = lstPatient[0].SecuredCode;
        lblPatientName.Text = lstPatient[0].Name;
        lblPatientNo.Text = lstPatient[0].PatientNumber;
        if (lstPatient[0].Age != "0")
        {
            lblAge_Sex.Text = lstPatient[0].Age.ToString() + " / " + lstPatient[0].SEX;
        }
        lblConsultant.Text = lstPatient[0].PhysicianName;
        lblDateTime.Text = lstPatient[0].VisitDate.ToString();
        lblPatientAddress.Text = lstPatient[0].Add1 + "<br>" + lstPatient[0].Add2 + "<br>" + lstPatient[0].Add3 + "<br>" + lstPatient[0].City;
        lblContactNo.Text = lstPatient[0].ContactNo;
    }

    public void loadPatientSecDetail(int PhyId)
    {
        PhyId = 0;
        string PType = "P";
        if (PhyId > 0)
        {
            List<AllPhysicianSchedules> lstPhysicianSchedules = new List<AllPhysicianSchedules>();

            long lresult = new Physician_BL(base.ContextInfo).GetAllPhysicianSchedules(OrgID, PhyId, PType, out lstPhysicianSchedules);
            if (lresult == 0)
            {




            }
        }
    }
    //below code added for printing in Quick bill
    public bool loadPatientSecPrintPage(long pid, long pvid)
    {
        //lblMessage.Text = string.Empty;
        long returnCode = -1;
        List<Patient> lstPatient = new List<Patient>();
        List<Speciality> lstSpeciality = new List<Speciality>();
        List<AllPhysicianSchedules> lstPhysicianSchedule = new List<AllPhysicianSchedules>();
        lblPatientAddress.Text = "";
        lblAvailablity.Text = "";
        lblDepartment.Text = "";

        try
        {
            returnCode = new PatientVisit_BL(base.ContextInfo).GetSecuredPPage(pvid, pid, out lstPatient, out lstSpeciality, out lstPhysicianSchedule);
            if (lstPatient.Count > 0)
            {
                if (lstPatient[0].SecuredCode != "")
                {

                    lblPatientName.Text = lstPatient[0].Name;
                    lblPatientNo.Text = lstPatient[0].PatientNumber;
                    if (lstPatient[0].Age != "0")
                    {
                        lblAge_Sex.Text = lstPatient[0].Age.ToString() + " / " + lstPatient[0].SEX;
                    }
                    lblConsultant.Text = lstPatient[0].PhysicianName;
                    lblDateTime.Text = lstPatient[0].VisitDate.ToString();

                    if (lstPatient[0].Add1 != "")
                    {
                        lblPatientAddress.Text += lstPatient[0].Add1 + ",<br/>";
                    }
                    if (lstPatient[0].Add2 != "")
                    {
                        lblPatientAddress.Text += lstPatient[0].Add2 + ",<br/>";
                    }
                    if (lstPatient[0].Add3 != "")
                    {
                        lblPatientAddress.Text += lstPatient[0].Add3 + ",<br/>";
                    }
                    if (lstPatient[0].City != "")
                    {
                        lblPatientAddress.Text += lstPatient[0].City + ".";
                    }
                    lblContactNo.Text = lstPatient[0].ContactNo;
                    if (lstPatient[0].TPAName != "")
                    {
                        lblPanelName.Text = lstPatient[0].TPAName;
                        SlblPanelName.Visible = true;
                        lblPanelName.Visible = true;
                    }
                    else
                    {
                        SlblPanelName.Visible = false;
                        lblPanelName.Visible = false;
                    }
                    if (lstSpeciality.Count > 0)
                    {
                        bool isFirstrecord = true;
                        for (int i = 0; i < lstSpeciality.Count; i++)
                        {
                            if (isFirstrecord)
                            {
                                lblDepartment.Text += lstSpeciality[i].SpecialityName;
                                isFirstrecord = false;
                            }
                            else { lblDepartment.Text += ", " + lstSpeciality[i].SpecialityName; }
                        }
                    }

                    Hashtable ht = new Hashtable();

                    if (lstPhysicianSchedule.Count > 0)
                    {
                        string sun, mon, tue, wed, thu, fri, sat;
                        ArrayList arrWork = new ArrayList();
                        ArrayList arrNonWork = new ArrayList();
                        var list = new List<int>();
                        arrWork.Clear();
                        arrNonWork.Clear();
                        //int i = 0;
                        for (int i = 0; i < lstPhysicianSchedule.Count; i++)
                        {


                            sun = lstPhysicianSchedule[i].Sunday;
                            mon = lstPhysicianSchedule[i].Monday;
                            tue = lstPhysicianSchedule[i].Tuesday;
                            wed = lstPhysicianSchedule[i].Wednesday;
                            thu = lstPhysicianSchedule[i].Thursday;
                            fri = lstPhysicianSchedule[i].Friday;
                            sat = lstPhysicianSchedule[i].Saturday;


                            if (!ht.Contains(lstPhysicianSchedule[i].StartTime + "-" + lstPhysicianSchedule[i].EndTime))
                            {

                                if (sun == "Y")
                                {
                                    lblAvailablity.Text += "Sunday,";
                                }


                                if (mon == "Y")
                                {
                                    lblAvailablity.Text += "Monday,";
                                }


                                if (tue == "Y")
                                {
                                    lblAvailablity.Text += "Tuesday,";

                                }


                                if (wed == "Y")
                                {
                                    lblAvailablity.Text += "Wednesday,";

                                }


                                if (thu == "Y")
                                {
                                    lblAvailablity.Text += "Thursday,";
                                }


                                if (fri == "Y")
                                {
                                    lblAvailablity.Text += "Friday,";
                                }


                                if (sat == "Y")
                                {
                                    lblAvailablity.Text += "Saturday";
                                }



                                lblAvailablity.Text += "-" + lstPhysicianSchedule[i].StartTime.ToString("h:mm tt") + " to " + lstPhysicianSchedule[i].EndTime.ToString("h:mm tt") + "<br>";
                                ht.Add(lstPhysicianSchedule[i].StartTime + "-" + lstPhysicianSchedule[i].EndTime, sun + mon + tue + wed + thu + fri + sat + sun);

                            }



                        }








                    }

                }
                else
                {
                    tblSecPage.Visible = false;
                    //lblMessage.Text = "There is no Security Prescription Page";
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Secured Page.ascx", ex);
        }

        return true;
    }

    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    } 

}
