using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
public partial class Reception_Home : BasePage
{


    public Reception_Home() :
        base("Reception_Home_aspx")
    {
    }

    int OP;
    public string followup_mesge = Resources.AppMessages.Followup_mesge;
    string alert = Resources.Reception_AppMsg.Reception_AddressBook_aspx_02;
    protected void Page_Load(object sender, EventArgs e)
    {
        phySch.TempOrgID = OrgID;
        phySch.LocationID = ILocationID;
        phySch.PostDifferentPage = "Yes";
        try
        {
            //RecHome.Attributes.Add("onload", "pageLoad();");
            txtPatientNo.Attributes.Add("onKeyDown", "return ValidateOnlyNumeric(this);");            
            if (!IsPostBack)
            {
                if (InventoryLocationID == -1)
                {
                    Department1.LoadLocationUserMap();
                }
                LoadTaskPanel();
            }
            //if (txtPatientNo.Text.Length == 0)
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "focus", "<script>document.getElementById('txtPatientNo').focus();</script>", false);
        }
        catch (Exception ex)
        {            
            CLogger.LogError("Error in Reception Home:Page_Load", ex);
        }
    }
    protected void LoadTaskPanel()
    {
        string TimingSampleNeed = GetConfigValue("TimingSample", OrgID);
        if (TimingSampleNeed == "Y")
        {  
            rdoTimingSpecimen.Attributes.Add("style", "display:block");
        }
    }
    private void LoadTitle()
    {       
        
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            OP = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
           // List<PatientQualification> lstQualification = new List<PatientQualification>();
            long returnCode = -1;
            string iPatientNo = "";
            
            List<Patient> lstPatient = new List<Patient>();
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            iPatientNo = txtPatientNo.Text;
            List<PatientVisit> lsttotalPatientCount = new List<PatientVisit>();
            List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
            string ShareType = "Clinical View";
            if (Session["isTrustedOrg"] == "YES")
            {
                returnCode = new TrustedOrg(base.ContextInfo).GetTrustedOrgList(ILocationID, RoleID, ShareType, out lstTOD);
            }
            else
            {
                TrustedOrgDetails TOD = new TrustedOrgDetails();
                TOD.SharingOrgID = OrgID;
                lstTOD.Add(TOD);
            }
            int totalRows = 0;
            
            string fromDate = String.Empty, ToDate = String.Empty;
            
            if (!iPatientNo.Equals("") && iPatientNo.Length > 0)
            {
                //returnCode = patientBL.SearchPatient(iPatientNo, "", "", "", "", "", "", "", OrgID, 10, 0, out totalRows, lstTOD, OP, "", 0, out lstPatient, "", "", "");
                //returnCode = patientBL.SearchPatient(iPatientNo, "", "", "", "", "", "", "", "", OrgID, 0, 0, out totalRows, lstTOD, OP, "", 0,out lstPatient, "", "", "", "", "", "", "");               
                returnCode = patientBL.SearchPatient(iPatientNo, "", "", "", "", "", "", "", "", OrgID, 0, 0, out totalRows, out lsttotalPatientCount, lstTOD, OP, "", 0, out lstPatient, "", "", "", "", "", "", "");               
            }
            else
            {
                RecHome.Attributes.Add("onload", "pageLoadFocus('txtPatientNo');");
            }
            

            if (returnCode == 0 && lstPatient.Count > 0)
            {   
                Response.Redirect("PatientVisit.aspx?PID="+lstPatient[0].PatientID,true);
                returnCode = -1;
                lstPatient.Clear();
            }
            else
            {
               // ErrorDisplay1.ShowError = true;
              //  ErrorDisplay1.Status = "No matching records found";
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error while fetch the patient details.", ex);
            
        }

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        fillgrid("Follow Up Trans");
    }
    protected void gvIPCreditMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (gvIPCreditMain.PageIndex * gvIPCreditMain.PageSize));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }
    }
    protected void gvIPCreditMain_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvIPCreditMain.EditIndex = -1;
            fillgrid("Follow Up Trans");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group Addition", ex);
        }
    }
    protected void gvIPCreditMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvIPCreditMain.PageIndex = e.NewPageIndex;
            fillgrid("Follow Up Trans");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }

    }
    protected void gvIPPhyMain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[0].Text = Convert.ToString((e.Row.RowIndex + 1) + (gvIPPhyMain.PageIndex * gvIPPhyMain.PageSize));
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }
    }
    protected void gvIPPhyMain_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        try
        {
            gvIPPhyMain.EditIndex = -1;
            fillgrid("Follow Up Phy");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group Addition", ex);
        }
    }
    protected void gvIPPhyMain_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            gvIPPhyMain.PageIndex = e.NewPageIndex;
            fillgrid("Follow Up Phy");
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in New Group addition", ex);
        }

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
    #region fillgrid
    protected void fillgrid(string id)
    {
        try
        {
            DateTime fDate = DateTime.Today;
            DateTime tDate = DateTime.Today;
            List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
            if (id != "Follow Up Phy")
            {
                if (ddlFollowUpPeriod.SelectedItem.Value.ToString() == "1")
                {
                    tDate = DateTime.Today.AddDays(1);
                }
                else if (ddlFollowUpPeriod.SelectedItem.Value.ToString() == "2")
                {
                    tDate = DateTime.Today.AddDays(7);
                }
            }
            else
            {
                if (ddlFollowPhy.SelectedItem.Value.ToString() == "1")
                {
                    tDate = DateTime.Today.AddDays(1);
                }
                else if (ddlFollowPhy.SelectedItem.Value.ToString() == "2")
                {
                    tDate = DateTime.Today.AddDays(7);
                }
            }
            int specialityID = 0;
            long phyID = 0;
            long returnCode = -1;
            int visitType = 0;
            List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
            List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
            List<DayWiseCollectionReport> lstPhyIDs = new List<DayWiseCollectionReport>();
            List<Physician> lstPhysician = new List<Physician>();

            string requestType = id;
            returnCode = new Report_BL(base.ContextInfo).GetPatientReport(fDate.ToString("dd/MM/yyyy"), tDate.ToString("dd/MM/yyyy"), OrgID, visitType, requestType, specialityID, phyID, lstSpecialityIds, lstPhyIDs, out lstDWCR, out lstPhysician);
            

                List<DayWiseCollectionReport> lstRpt = (from s in lstDWCR
                                                        group s by new
                                                        {
                                                            s.Address,
                                                            s.Age,
                                                            s.City,
                                                            s.ContactNumber,
                                                            s.DateofAdmission,
                                                            s.DateofSurgery,
                                                            s.PatientID,
                                                            s.PatientName,
                                                            s.PatientNumber,
                                                            s.PatientVisitId,
                                                            s.SpecialityName,
                                                            s.VisitDate,
                                                            s.VisitType
                                                        } into g
                                                        select new DayWiseCollectionReport
                                                        {
                                                            Address = g.Key.Address,
                                                            Age = g.Key.Age,
                                                            City = g.Key.City,
                                                            ContactNumber = g.Key.ContactNumber,
                                                            DateofAdmission = g.Key.DateofAdmission,
                                                            DateofSurgery = g.Key.DateofSurgery,
                                                            PatientID = g.Key.PatientID,
                                                            PatientName = g.Key.PatientName,
                                                            PatientNumber = g.Key.PatientNumber,
                                                            PatientVisitId = g.Key.PatientVisitId,
                                                            SpecialityName = g.Key.SpecialityName,
                                                            VisitDate = g.Key.VisitDate,
                                                            VisitType = g.Key.VisitType
                 
                                                        }).ToList();
                if (id == "Follow Up Trans")
                {
                    lstday = (from s in lstRpt
                              where s.SpecialityName != "Physiotherapy"
                              select new DayWiseCollectionReport
                              {
                                  Address = s.Address,
                                  Age = s.Age,
                                  City = s.City,
                                  ContactNumber = s.ContactNumber,
                                  DateofAdmission = s.DateofAdmission,
                                  DateofSurgery = s.DateofSurgery,
                                  PatientID = s.PatientID,
                                  PatientName = s.PatientName,
                                  PatientNumber = s.PatientNumber,
                                  PatientVisitId = s.PatientVisitId,
                                  SpecialityName = s.SpecialityName,
                                  VisitDate = s.VisitDate,
                                  VisitType = s.VisitType
                              }).ToList();
                    if (lstDWCR.Count > 0)
                    {
                        gvIPCreditMain.Visible = true;
                        gvIPCreditMain.DataSource = lstday;
                        string strConfig = GetConfigValue("IPNoDisplay", OrgID);
                        if (strConfig == "N")
                        {
                            gvIPCreditMain.Columns[3].Visible = false;
                        }
                        else
                        {
                            gvIPCreditMain.Columns[3].Visible = true;
                        }
                        gvIPCreditMain.DataBind();
                    }
                    else
                    {
                        gvIPCreditMain.Visible = false;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:ValidationWindow('" + followup_mesge + "','" + alert + "');", true);
                        //ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Follow up found for the selected dates');", true);
                    }
                }
            
            else if (id == "Follow Up Phy")
            {
                lstday = (from s in lstRpt
                          where s.SpecialityName == "Physiotherapy"
                          select new DayWiseCollectionReport
                          {
                              Address = s.Address,
                              Age = s.Age,
                              City = s.City,
                              ContactNumber = s.ContactNumber,
                              DateofAdmission = s.DateofAdmission,
                              DateofSurgery = s.DateofSurgery,
                              PatientID = s.PatientID,
                              PatientName = s.PatientName,
                              PatientNumber = s.PatientNumber,
                              PatientVisitId = s.PatientVisitId,
                              SpecialityName = s.SpecialityName,
                              VisitDate = s.VisitDate,
                              VisitType = s.VisitType
                          }).ToList();
                if (lstday.Count > 0)
                {
                    gvIPPhyMain.Visible = true;
                    gvIPPhyMain.DataSource = lstday;
                    string strConfig = GetConfigValue("IPNoDisplay", OrgID);
                    if (strConfig == "N")
                    {
                        gvIPPhyMain.Columns[3].Visible = false;
                    }
                    else
                    {
                        gvIPPhyMain.Columns[3].Visible = true;
                    }
                    gvIPPhyMain.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Reception_Home.aspx.cs, btnSubmit_Click()", ex);
        }

    }
    #endregion
    //#region fillgrid
    //protected void fillgrid(string id)
    //{
    //    try
    //    {
    //        DateTime fDate = DateTime.Today;
    //        DateTime tDate = DateTime.Today;
    //        List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
    //        if (ddlFollowUpPeriod.SelectedItem.Value.ToString() == "1")
    //        {
    //            tDate = DateTime.Today.AddDays(1);
    //        }
    //        else if (ddlFollowUpPeriod.SelectedItem.Value.ToString() == "2")
    //        {
    //            tDate = DateTime.Today.AddDays(7);
    //        }
    //        int specialityID = 0;
    //        long phyID = 0;
    //        long returnCode = -1;
    //        int visitType = 0;
    //        List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
    //        List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
    //        List<DayWiseCollectionReport> lstPhyIDs = new List<DayWiseCollectionReport>();
    //        List<Physician> lstPhysician = new List<Physician>();
           
    //            string requestType =id;
    //            returnCode = new Report_BL(base.ContextInfo).GetPatientReport(fDate, tDate, OrgID, visitType, requestType, specialityID, phyID, lstSpecialityIds, lstPhyIDs, out lstDWCR, out lstPhysician);
    //            if (id == "Follow Up Trans")
    //            {
    //                if (lstDWCR.Count > 0)
    //                {
    //                    gvIPCreditMain.Visible = true;
    //                    gvIPCreditMain.DataSource = lstDWCR;
    //                    gvIPCreditMain.DataBind();
    //                }
    //                else
    //                {
    //                    gvIPCreditMain.Visible = false;
    //                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDiv", "javascript:alert('No Follow up found for the selected dates');", true);
    //                }
    //            }
    //            else if (id == "Follow Up Phy")
    //            {

    //                List<DayWiseCollectionReport> lstRpt = (from s in lstDWCR
    //                                                        group s by new
    //                                                        {
    //                                                            s.Address,s.Age,s.City,
    //                                                            s.ContactNumber,s.DateofAdmission,s.DateofSurgery,
    //                                                            s.PatientID,s.PatientName,s.PatientNumber,
    //                                                            s.PatientVisitId,s.SpecialityName,s.VisitDate,s.VisitType
    //                                                        } into g
    //                                                        select new DayWiseCollectionReport
    //                                                        {
    //                                                            Address = g.Key.Address,Age = g.Key.Age,
    //                                                            City = g.Key.City,ContactNumber = g.Key.ContactNumber,
    //                                                            DateofAdmission = g.Key.DateofAdmission,DateofSurgery = g.Key.DateofSurgery,
    //                                                            PatientID = g.Key.PatientID,PatientName = g.Key.PatientName,
    //                                                            PatientNumber = g.Key.PatientNumber,PatientVisitId = g.Key.PatientVisitId,
    //                                                            SpecialityName = g.Key.SpecialityName,VisitDate = g.Key.VisitDate,VisitType = g.Key.VisitType
    //                                                        }).ToList();
    //                lstday = (from s in lstRpt
    //                          where s.SpecialityName == "Physiotherapy"
    //                          select new DayWiseCollectionReport
    //                          {
    //                              Address = s.Address,
    //                              Age = s.Age,
    //                              City = s.City,
    //                              ContactNumber = s.ContactNumber,
    //                              DateofAdmission = s.DateofAdmission,
    //                              DateofSurgery = s.DateofSurgery,
    //                              PatientID = s.PatientID,
    //                              PatientName = s.PatientName,
    //                              PatientNumber = s.PatientNumber,
    //                              PatientVisitId = s.PatientVisitId,
    //                              SpecialityName = s.SpecialityName,
    //                              VisitDate = s.VisitDate,
    //                              VisitType = s.VisitType
    //                          }).ToList();
    //                if (lstday.Count > 0)
    //                {
    //                    gvIPPhyMain.Visible = true;
    //                    gvIPPhyMain.DataSource = lstday;
    //                    gvIPPhyMain.DataBind();
    //                }
    //            }
    //    }
    //    catch (Exception ex)
    //    {
    //        CLogger.LogError("Error in Reception_Home.aspx.cs, btnSubmit_Click()", ex);
    //    }

    //}
    //#endregion
    protected void btnPhyGO_Click(object sender, EventArgs e)
    {
        fillgrid("Follow Up Phy");
        //try
        //{
        //    DateTime fDate = DateTime.Today;
        //    DateTime tDate = DateTime.Today;
        //    List<DayWiseCollectionReport> lstDWCR = new List<DayWiseCollectionReport>();
        //    List<DayWiseCollectionReport> lstDWPH = new List<DayWiseCollectionReport>();
        //    if (ddlFollowPhy.SelectedItem.Value.ToString() == "1")
        //    {
        //        tDate = DateTime.Today.AddDays(1);
        //    }
        //    else if (ddlFollowPhy.SelectedItem.Value.ToString() == "2")
        //    {
        //        tDate = DateTime.Today.AddDays(7);
        //    }
        //    int specialityID = 0;
        //    long phyID = 0;
        //    long returnCode = -1;
        //    int visitType = 0;
        //    List<DayWiseCollectionReport> lstday = new List<DayWiseCollectionReport>();
        //    List<DayWiseCollectionReport> lstSpecialityIds = new List<DayWiseCollectionReport>();
        //    List<DayWiseCollectionReport> lstPhyIDs = new List<DayWiseCollectionReport>();
        //    List<Physician> lstPhysician = new List<Physician>();
           
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error in Reception_Home.aspx.cs, btnSubmit_Click()", ex);
        //}
    }
    
}
