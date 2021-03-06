using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.Common;
using Attune.Podium.TrustedOrg;
using Attune.Podium.BillingEngine;
using System.Web.UI.HtmlControls;
using System.Text;
public partial class Nurse_PatientSearch  : BasePage
{
    int OP; long returnCode = -1; //List<SearchActions> pagesReload = new List<SearchActions>(); 

    public Nurse_PatientSearch()
        : base("Reception_PatientSearch_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    protected void Page_Load(object sender, EventArgs e)
    {

        uctlPatientSearch.onSearchComplete += new EventHandler(uctlPatientSearch_onSearchComplete);
        TextBox txt = (TextBox)uctlPatientSearch.FindControl("txtDOB");
        txt.Attributes.Add("OnChange", "ExcedDate('" + txt.ClientID.ToString() + "','',0,0);");

        if (!IsPostBack)
        {

            if (RoleID == 1)
            {
                //PhyHeader1.Visible = true;
               // UsrHeader1.Visible = false;
            }
            else
            {
               // PhyHeader1.Visible = false;
               // UsrHeader1.Visible = true;
            }
            OP = Convert.ToInt32(TaskHelper.SearchType.OutPatientSearch);
            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            if (IsTrustedOrg == "Y")
            {
                returnCode = nurseBL.GetActionsIsTrusterdOrg(RoleID, OP, out lstActionMaster);
            }
            else
            {
                returnCode = nurseBL.GetActions(RoleID, OP, out lstActionMaster); //returnCode = nurseBL.GetSearchActions(RoleID, OP, out pages); 
            }
            dList.DataSource = lstActionMaster;
            dList.DataTextField = "ActionName";
            dList.DataValueField = "PageURL";
            dList.DataBind();

        }
    }

    protected void uctlPatientSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctlPatientSearch.HasResult)
        {
            aRow.Visible = true;

        }
        //else
        //{
        //    aRow.Visible = false;
        //}
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = uctlPatientSearch.GetSelectedPatient();
            if (validatePage(pid))
            {
                string strRedirect = string.Format("~/Nurse/PatientVitals.aspx?PatientID={0}&type={1}", pid.ToString(), 'U');
                Response.Redirect(strRedirect, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = uctlPatientSearch.GetSelectedPatient();
            if (validatePage(pid))
            {
                string strRedirect = string.Format("~/Nurse/PatientVitals.aspx?PatientID={0}&type={1}", pid.ToString(), 'I');
                Response.Redirect(strRedirect, true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }

    private bool validatePage(long pid)
    {
        string strerror = Resources.Reception_ClientDisplay.Reception_PatientSearch_aspx_01 == null ? "Please Select a Patient" : Resources.Reception_ClientDisplay.Reception_PatientSearch_aspx_01;
        bool retval = true;
        string error = "";
        if (pid <= 0)
        {
            retval = false;
            error = strerror;
        }
        //ErrorDisplay1.ShowError = true;
       // ErrorDisplay1.Status = error;
        return retval;


    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            long pid = 0;
            int patOrgID = -1;

            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            string patientType = string.Empty;

            pid = uctlPatientSearch.GetSelectedPatient();
            string PatientName = string.Empty;
            PatientName = uctlPatientSearch.GetSelectedPatientName();
            patOrgID = uctlPatientSearch.GetSelectedPatientOrgID();
            pbl.pCheckPatientisIPorOP(0, pid, OrgID, out patientType);

            //if (patientType != "Admitted")
            //{
            //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
            //}
            //else
            //{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
            //}

            IP_BL pIP_BL = new IP_BL(base.ContextInfo);
            List<DischargeSummary> lstDischargeSummaryByPatientID = new List<DischargeSummary>();

            pIP_BL.GetPatientDischargeDetailByPatientID(pid, out lstDischargeSummaryByPatientID);


            if (IsTrustedOrg == "Y")
            {
                long pRefOrgPID = -1; // After Inserting the Patient from Other Org
                if (patientType != "Admitted")
                {
                    int pcount;
                    String pageID = dList.SelectedValue.Split('~')[1];
                    returnCode = new TrustedOrg(base.ContextInfo).CheckPageAccess(pageID, OrgID, patOrgID, out pcount);

                    //string NeedRegistration = dList.SelectedValue.Split('~')[1];
                    if (pcount == 0)
                    {
                        //Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
                        uctlPatientSearch.accessinPatientSearchPage(sender, e);
                        string sPath="Reception\\\\PatientSearch.aspx.cs_6";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg("+ sPath +")", true);
                        //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_6").ToString();
                        //if (sUserMsg != null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                        //}
                        //else
                        //{
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action Cannot be Performed as Patient belongs to another Organization');", true);
                        //}
                    }
                    else
                    {
                        string URNo = string.Empty;
                        int pURNORGid = -1;

                        new Patient_BL(base.ContextInfo).CheckURNoAvailablity(pid, out URNo, out pURNORGid);

                        if ((URNo == "") && (pURNORGid == OrgID))
                        {
                            Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
                        }
                        else if ((URNo == "") && (pURNORGid != OrgID))
                        {
                            Response.Redirect(@"../Reception/PatientRegistration.aspx?PID=" + pid.ToString() + "&vType=OP" + "&TORG=Y", true);
                            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Urn not available');", true);
                        }
                        else if ((URNo != "") && (pURNORGid != OrgID))
                        {
                            returnCode = new Patient_BL(base.ContextInfo).InsertPatientFromReferredOrg(pid, OrgID, out pRefOrgPID);
                            //Response.Redirect("PatientVisit.aspx?PID=" + pRefOrgPID.ToString(), true);
                            Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pRefOrgPID.ToString() + "&vType=" + "OP", true);
                            string sPath = "Reception\\\\PatientSearch.aspx.cs_8";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                            
                            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_8").ToString();
                            //if (sUserMsg != null)
                            //{
                            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                            //}
                            //else
                            //{
                            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Move on to Registration & Visit');", true);
                            //}
                        }
                        else if ((URNo != "") && (pURNORGid == OrgID))
                        {
                            Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
                        }
                    }
                }
                else
                {

                    //if (dList.SelectedValue.ToString() == "/Physician/DischargeSummaryCaseSheet.aspx")
                    //{
                    if (dList.SelectedValue.ToString() == "/DischargeSummary/DischargeSummaryDynamic.aspx.aspx")
                    {
                        if (lstDischargeSummaryByPatientID.Count > 0)
                        {
                            string NeedRegistration = dList.SelectedValue.Split('~')[1];
                            if (NeedRegistration == "N")
                            {
                                Response.Redirect(Request.ApplicationPath + dList.SelectedValue.Split('~')[0] + "?pid=" + pid.ToString() + "&vType=" + "OP", true);
                            }
                            else
                            {
                                string sPath="Reception\\\\PatientSearch.aspx.cs_9";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_9").ToString();
                                //if (sUserMsg != null)
                                //{
                                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                                //}
                                //else
                                //{

                                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('Patient registration is needed');", true);
                                //}
                            }
                        }
                        else
                        {
                            string sPath="Reception\\\\PatientSearch.aspx.cs_10";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg("+ sPath +")", true);
                            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_10").ToString();
                            //if (sUserMsg != null)
                            //{
                            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                            //}
                            //else
                            //{

                            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for This patient');", true);
                            //}

                        }

                    }

                    else
                    {
                        string  sPath = "Reception\\\\PatientSearch.aspx.cs_11";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                        //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_11").ToString();
                        //if (sUserMsg != null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                        //}
                        //else
                        //{
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
                        //}

                    }
                }
            }
            else
            {
                List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
                new PatientVisit_BL(base.ContextInfo).GetVisitSearchDetails(pid, "01/01/1950", Convert.ToDateTime(new BasePage().OrgDateTimeZone).ToString(), OrgID, 0, out lstPatientVisit);
                if (dList.SelectedItem.Text == "Print Patient Registration Details")
                {
                    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&OP=Y", true);
                }
                else if (dList.SelectedItem.Text == "Admit Patient")
                {
                    //Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&IP=Y", true);
                    long PatientVisitID = -1;
                    long PatientID = pid;
                    returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                    Response.Redirect(Request.ApplicationPath + "/Reception/InPatientRegistration.aspx?pid=" + PatientID.ToString() + "&vid=" + PatientVisitID, true);

                }



                 //Print Consent Form 
                else if (dList.SelectedItem.Text == "Print Consent Form")
                {
                    //Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&IP=Y", true);
                    long PatientVisitID = -1;
                    long PatientID = pid;
                    returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                    Response.Redirect(Request.ApplicationPath + "/Reception/ConsentFormPrint.aspx?pid=" + PatientID.ToString() + "&vid=" + PatientVisitID, true);

                }
                //Print consent form END 
                //Commented due to Dynamic DichargeSummmary
                //else if (patientType != "Admitted" && dList.SelectedValue.ToString() != "/Physician/DischargeSummaryCaseSheet.aspx")
                //{
                //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "OP", true);
                //}
                else if (dList.SelectedValue.ToString() == "/BloodBank/BloodRequestForm.aspx")
                {
                    long PatientVisitID = -1;
                    long PatientID = pid;
                    returnCode = CreateVisit(returnCode, PatientID, out PatientVisitID);
                    Response.Redirect(Request.ApplicationPath + "/BloodBank/BloodRequestForm.aspx?PID=" + PatientID.ToString() + "&VID=" + PatientVisitID, true);
                }
                else if (patientType != "Admitted" && dList.SelectedValue.ToString() != "/DischargeSummary/DischargeSummaryDynamic.aspx")
                {
                    if (dList.SelectedItem.Text == "Dialysis Case Sheet")
                    {
                        Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&pType=D" + "&vType=" + "OP", true);
                    }
                    else
                    {

                        if (dList.SelectedValue.ToString() == "/Billing/CollectDuePayment.aspx")
                        {
                            long finalBillID = -1;
                            string visittype = "";
                            List<FinalBill> lstDueDetail = new List<FinalBill>();
                            loadDueDetail(OrgID, pid, 0, out finalBillID, out lstDueDetail, out visittype);
                            if (lstDueDetail.Count <= 0)
                            {
                                string sPath = "Reception\\\\PatientSearch.aspx.cs_12";
                                ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);
                                //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_12").ToString();
                                //if (sUserMsg != null)
                                //{
                                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                                //}
                                //else
                                //{
                                //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey18", "javascript:alert('The selected patient does not have any Due');", true);
                                //}
                            }
                            else { Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "OP", true); }

                        }
                        else
                        {
                            Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&PNAME=" + PatientName + "&vType=" + "OP", true);
                            //&PNAME={PatientName} 
                        }
                    }

                }

                else if (patientType == "Admitted" && dList.SelectedValue.ToString() == "/Reception/PatientRegistration.aspx")
                {
                    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "IP", true);
                }
                //else if (patientType == "Admitted" && dList.SelectedValue.ToString() == "/Reception/VisitDetails.aspx")
                //{
                //    Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?PID=" + pid.ToString() + "&vType=" + "IP", true);
                //}
                else
                {
                    //if (dList.SelectedValue.ToString() == "/Physician/DischargeSummaryCaseSheet.aspx")
                    //{
                    if (dList.SelectedValue.ToString() == "/DischargeSummary/DischargeSummaryDynamic.aspx")
                    {
                        if (lstDischargeSummaryByPatientID.Count > 0)
                        {
                            Response.Redirect(Request.ApplicationPath + dList.SelectedValue + "?pid=" + pid.ToString() + "&vType=" + "OP", true);
                        }
                        else
                        {
                            string sPath = "Reception\\\\PatientSearch.aspx.cs_10";
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                            //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_10").ToString();
                            //if (sUserMsg != null)
                            //{
                            //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                            //}
                            //else
                            //{
                            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for This patient');", true);
                            //}
                        }
                    }
                    else
                    {
                        string sPath = "Reception\\\\PatientSearch.aspx.cs_11";
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg(" + sPath + ")", true);
                        //Page.ClientScript.RegisterStartupScript(Type.GetType("System.String"), "addScript", "ShowAlertMsg('" + sPath + "')", true);

                        //string sPath = "Reception\\PatientSearch.aspx.cs_11";
                        //ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "ShowAlertMsg('" + sPath + "')", true);
                        //string sUserMsg = HttpContext.GetGlobalResourceObject("AppMessages", "Reception\\PatientSearch.aspx.cs_11").ToString();
                        //if (sUserMsg != null)
                        //{
                        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "tKey2", "alert('" + sUserMsg + "');", true);
                        //}
                        //else
                        //{
                        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
                        //}
                    }
                }
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {


    }
    public long loadDueDetail(long orgID, long patientID,
       long patientVisitID, out long finalBillID,
       out List<FinalBill> lstDueDetail, out string VisitType)
    {
        long returnCode = -1;
        lstDueDetail = new List<FinalBill>();
        VisitType = "";
        BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
        billingEngineBL.GetDueDetails(orgID, patientID, patientVisitID, out finalBillID, out lstDueDetail, out VisitType);
        return returnCode;
    }
    private long CreateVisit(long returnCode, long PatientID, out long PatientVisitID)
    {
        string needIPNo = string.Empty;
        List<Config> ConfigDetails = new List<Config>();
        DateTime dtFromTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone), dtToTime = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
        int iRetTokenNumber = -1;
        PatientVisit pVisit = new PatientVisit();
        pVisit.VisitType = 1;
        pVisit.PhysicianName = "";
        pVisit.VisitPurposeID = (int)TaskHelper.VisitPurpose.Admission;// Visit Purpose ID for Admission is 9
        pVisit.PhysicianID = -1;
        pVisit.OrgID = OrgID;
        pVisit.PatientID = PatientID;
        pVisit.ReferingPhysicianID = -1;
        pVisit.ReferingPhysicianName = string.Empty;
        pVisit.ReferingSpecialityID = -1;
        pVisit.OrgAddressID = ILocationID;
        pVisit.SpecialityID = -1;
        pVisit.ReferOrgID = -1;

        pVisit.CreatedBy = LID;
        
        pVisit.ParentVisitId = 0;
        pVisit.PriorityID = 0;
        returnCode = new GateWay(base.ContextInfo).GetConfigDetails("NeedIPNumber", OrgID, out ConfigDetails);
        if (ConfigDetails.Count > 0)
            needIPNo = ConfigDetails[0].ConfigValue.Trim();
        List<VisitClientMapping> lst = new List<VisitClientMapping>();
        returnCode = new PatientVisit_BL(base.ContextInfo).SaveVisit(pVisit, out PatientVisitID, PatientID, 0, 0, 0, "", out iRetTokenNumber, dtFromTime, dtToTime, needIPNo, lst);

        return returnCode;
    }
}
