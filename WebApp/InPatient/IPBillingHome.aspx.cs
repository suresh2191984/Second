using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using System.Collections;
using Attune.Podium.Common;
using System.Web.UI.HtmlControls;
using System.Text.RegularExpressions;
using Attune.Utilitie.Helper;

public partial class InPatient_IPBillingHome : BasePage
{
    public InPatient_IPBillingHome()
        : base("InPatient\\IPBillingHome.aspx")
    {
    }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }


    Hashtable hsTable = new Hashtable();
    public event EventHandler onSearchComplete;
    int IPtype;
    long visitID = 0;
    long returnCode = 0;
    int IP;
    List<Patient> lstPatient = new List<Patient>();
    Patient_BL patientBL ;
    string needDischargePat = "N";
    List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
    string roomStatus = string.Empty;
    List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    string a = string.Empty;
    long pid = 0;
    string vid = "";
    long rateID = 0;
    string sPatientName = "";
    string patientNumber = string.Empty;
    string strPatientName = string.Empty;
    string strDOB = string.Empty;
    string inPatientNo = string.Empty;
    string strCellNo = string.Empty;
    string strRoomNo = string.Empty;
    string strPurpose = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        patientBL = new Patient_BL(base.ContextInfo);

        ucINPatientSearch.onSearchComplete += new EventHandler(ucINPatientSearch_onSearchComplete);
        TextBox txtdob = (TextBox)ucINPatientSearch.FindControl("txtDOB");
        txtdob.Attributes.Add("OnChange", "ExcedDate('" + txtdob.ClientID.ToString() + "','',0,0);");
        string Name = ucINPatientSearch.StrPatientName;
        if (RoleID == 1)
        {
            PhyHeader1.Visible = true;
            UsrHeader1.Visible = false;
        }
        else
        {
            PhyHeader1.Visible = false;
            UsrHeader1.Visible = true;
        }
        IPtype = Convert.ToInt32(TaskHelper.SearchType.IPPayments);
        long returnCode = -1;
        Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
        List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
        //returnCode = nurseBL.GetSearchActionsInPatient(RoleID, IPtype, out pages);


        if (!IsPostBack)
        {
            string strConfigKey = "IsSurgeryAdvance";
            string configValue = GetConfigValue(strConfigKey, OrgID);

            //if (configValue == "N")
            //{
            //    var lstAction = from Res in lstActionMaster
            //                    where Res.ActionName != "Collect Surgery Advance"
            //                    select Res;
            //    dList.DataSource = lstAction;
            //    dList.DataTextField = "ActionName";
            //    dList.DataValueField = "PageURL";
            //    dList.DataBind();
            //}
            //else
            //{
            //    dList.DataSource = lstActionMaster;
            //    dList.DataTextField = "ActionName";
            //    dList.DataValueField = "PageURL";
            //    dList.DataBind();
            //}
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IPtype, out lstActionMaster);
            #region Load Action Menu to Drop Down List
            if (lstActionMaster.Count > 0)
            {
                #region Add View State ActionList
                string temp = string.Empty;
                foreach (ActionMaster objActionMaster in lstActionMaster)
                {
                    temp += (objActionMaster.ActionCode + '~' + objActionMaster.QueryString + '^').ToString();
                }
                ViewState.Add("ActionList", temp);
                #endregion
                //lstActionsMaster = lstActionMaster.ToList();
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
            #endregion

            if (ucINPatientSearch.HasResult)
            {
                aRow.Visible = true;

            }
            else
            {
                aRow.Visible = false;
            }
        }
    }



    protected void ucINPatientSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (ucINPatientSearch.HasResult)
        {
            aRow.Visible = true;

        }
        else
        {
            aRow.Visible = false;
        }
    }

    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {

            long rCode = -1;
            strPatientName = ucINPatientSearch.StrPatientName;
            strDOB = ucINPatientSearch.StrDOB;
            inPatientNo = ucINPatientSearch.InPatientNo;
            strCellNo = ucINPatientSearch.StrCellNo;
            strRoomNo = ucINPatientSearch.StrRoomNo;
            strPurpose = ucINPatientSearch.StrPurpose;
            a = dList.SelectedItem.Text;
            pid = ucINPatientSearch.GetSelectedInPatient();
            patientNumber = ucINPatientSearch.GetSelectedPatientNumber();
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();
            QueryMaster objQueryMaster = new QueryMaster();

            string RedirectURL = string.Empty;
            long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(pid, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {
                vid = lstPatientVisit[0].PatientVisitId.ToString();
                //rateID = lstPatientVisit[0].RateID;
                sPatientName = lstPatientVisit[0].Name.ToString();
            }
            if (OrgID == 26)
            {
                rCode = new RoomBooking_BL(base.ContextInfo).GetRoomsListByVisitID(OrgID, Convert.ToInt64(vid), out lstBookStatus, out roomStatus);
                long pBornVisitID = -1;
                rCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(vid), out pBornVisitID);
                string QueryString = string.Empty;
                //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
                //{
                //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
                //}
                #region View State Action List
                string ActCode = dList.SelectedValue;
                string ActionList = ViewState["ActionList"].ToString();
                foreach (string CompareList in ActionList.Split('^'))
                {
                    if (CompareList.Split('~')[0] == ActCode)
                    {
                        QueryString = CompareList.Split('~')[1];
                        break;
                    }
                }
                #endregion
                if (pBornVisitID > 0)
                {
                    if (!string.IsNullOrEmpty(QueryString))
                    {
                        objQueryMaster.Querystring = QueryString;
                        objQueryMaster.PatientID = pid.ToString();
                        objQueryMaster.PatientVisitID = vid.ToString();
                        objQueryMaster.PatientName = sPatientName.ToString();
                        objQueryMaster.SPatientName = strPatientName.ToString();
                        objQueryMaster.DateOfBirth = strDOB.ToString();
                        objQueryMaster.PatientNumber = inPatientNo.ToString();
                        objQueryMaster.CellNo = strCellNo.ToString();
                        objQueryMaster.RoomNo = strRoomNo.ToString();
                        objQueryMaster.Purpose = strPurpose.ToString();
                        objQueryMaster.ViewType = "";
                        if (roomStatus == "Occupied")
                        {
                            objQueryMaster.ADMCancelStatus = "Y";
                        }
                        else
                        {
                            objQueryMaster.ADMCancelStatus = "";
                        }
                        AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                        if (!String.IsNullOrEmpty(RedirectURL))
                        {
                            Response.Redirect(RedirectURL, true);
                        }
                        else
                        {
                            string sPath = "InPatient\\\\IPBillingHome.aspx.cs_3";
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +"')", true);
                        }
                    }
                    else
                    {
                        string sPath = "InPatient\\\\IPBillingHome.aspx.cs_3";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +"')", true);
                    }
                }
                else
                {
                    string sPath = "InPatient\\\\IPBillingHome.aspx.cs_2";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ sPath +"');", true);
                }

                //if (roomStatus == "Occupied" && dList.SelectedItem.Text != "Cancel Admission" )
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" +strPurpose + "&vType=" + "IP&BP=N", true);
                //}
                //else if (dList.SelectedItem.Text == "Cancel Admission")
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&ADMC=" + "Y" + "&vType=" + "IP&BP=N", true);

                //}
                //else if (pBornVisitID > 0)
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&vType=" + "IP&BP=N", true);
                //}               
                //else
                //{
                //    //((HtmlInputHidden)ucINPatientSearch.FindControl("pid")).Value = pid.ToString();
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed as the Room is not occupied by this patient');", true);
                //}
            }
            else
            {
                string QueryString = string.Empty;
                //if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
                //{
                //    QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
                //}
                #region View State Action List
                string ActCode = dList.SelectedValue;
                string ActionList = ViewState["ActionList"].ToString();
                foreach (string CompareList in ActionList.Split('^'))
                {
                    if (CompareList.Split('~')[0] == ActCode)
                    {
                        QueryString = CompareList.Split('~')[1];
                        break;
                    }
                }
                #endregion
                if (!string.IsNullOrEmpty(QueryString))
                {
                    objQueryMaster.Querystring = QueryString;
                    objQueryMaster.PatientID = pid.ToString();
                    objQueryMaster.PatientVisitID = vid.ToString();
                    objQueryMaster.PatientName = sPatientName.ToString();
                    objQueryMaster.SPatientName = strPatientName.ToString();
                    objQueryMaster.DateOfBirth = strDOB.ToString();
                    objQueryMaster.PatientNumber = inPatientNo.ToString();
                    objQueryMaster.CellNo = strCellNo.ToString();
                    objQueryMaster.RoomNo = strRoomNo.ToString();
                    objQueryMaster.Purpose = strPurpose.ToString();
                    objQueryMaster.ADMCancelStatus = "Y";
                    objQueryMaster.RateValue = rateID.ToString();
                    objQueryMaster.ViewType = "";
                    objQueryMaster.IPBPValue = "N";
                    objQueryMaster.DDLvalue = dList.SelectedItem.Text;
                    objQueryMaster.PatNumber = patientNumber.ToString();

                    AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
                    if (!String.IsNullOrEmpty(RedirectURL))
                    {
                        Response.Redirect(RedirectURL, true);
                    }
                    else
                    {
                        string sPath = "InPatient\\\\IPBillingHome.aspx.cs_3";
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +"')", true);
                    }
                }
                else
                {
                    string sPath = "InPatient\\\\IPBillingHome.aspx.cs_3";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +"')", true);
                }

                //if (dList.SelectedItem.Text == "Cancel Admission")
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&ADMC=" + "Y" + "&RateID=" + rateID + "&vType=" + "IP&BP=N", true);

                //}
                //else
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&RateID=" + rateID + "&vType=" + "IP&BP=N" + "&PNumber=" + patientNumber + "&ddl=" + a, true);
                //}

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
