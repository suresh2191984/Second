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
public partial class Reception_DayCare : BasePage
{
    public Reception_DayCare()
        : base("Reception\\DayCare.aspx")
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
    Patient_BL patientBL;
    string needDischargePat = "N";
    List<TrustedOrgDetails> lstTOD = new List<TrustedOrgDetails>();
    string roomStatus = string.Empty;
    List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();
    //static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
          patientBL = new Patient_BL(base.ContextInfo);
        ucDaycarePatientSearch.onSearchComplete += new EventHandler(ucDaycarePatientSearch_onSearchComplete);
        TextBox txtdob = (TextBox)ucDaycarePatientSearch.FindControl("txtDOB");
        txtdob.Attributes.Add("OnChange", "ExcedDate('" + txtdob.ClientID.ToString() + "','',0,0);");
        string Name = ucDaycarePatientSearch.StrPatientName;
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
        IPtype = Convert.ToInt32(TaskHelper.SearchType.DayCare);
        long returnCode = -1;
        Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
        List<ActionMaster> lstActionMaster = new List<ActionMaster>(); 
        returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IPtype, out lstActionMaster); 
        if (!IsPostBack)
        {            
            string strConfigKey = "IsSurgeryAdvance";
            string configValue = GetConfigValue(strConfigKey, OrgID);
            if (configValue == "N")
            {
                var lstAction = from Res in lstActionMaster
                                where Res.ActionName != "Collect Surgery Advance"
                                select Res;
                //lstActionsMaster = lstActionMaster.ToList();
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
                    dList.DataSource = lstAction;
                    dList.DataTextField = "ActionName";
                    dList.DataValueField = "ActionCode";
                    dList.DataBind();
                }
            }
            else
            {
                dList.DataSource = lstActionMaster;
                dList.DataTextField = "ActionName";
                dList.DataValueField = "ActionCode";
                dList.DataBind();
            }
            if (ucDaycarePatientSearch.HasResult)
            {
                aRow.Visible = true;
            }
            else
            {
                aRow.Visible = false;
            }
        }
    }



    protected void ucDaycarePatientSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (ucDaycarePatientSearch.HasResult)
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
            string a = dList.SelectedItem.Text;
            long pid = 0;
            string vid = "";
            long EpiId = 0;
            string sPatientName = "";
            long rCode = -1;
            string roomStatus = string.Empty;
            string patientNumber = string.Empty;
            string strPatientName = string.Empty;
            string strDOB = string.Empty;
            string inPatientNo = string.Empty;
            string strCellNo = string.Empty;
            string strRoomNo = string.Empty;
            string strPurpose = string.Empty;
            string strVisitId = string.Empty;

            string striscredit = ucDaycarePatientSearch.GetCreditBill().ToString();
            strPatientName = ucDaycarePatientSearch.StrPatientName;
            strDOB = ucDaycarePatientSearch.StrDOB;
            inPatientNo = ucDaycarePatientSearch.InPatientNo;
            strCellNo = ucDaycarePatientSearch.StrCellNo;
            strRoomNo = ucDaycarePatientSearch.StrRoomNo;
            strPurpose = ucDaycarePatientSearch.StrPurpose;
            vid = ucDaycarePatientSearch.GetSelectedPatientVisit().ToString();
            pid = ucDaycarePatientSearch.GetSelectedInPatient();
            long rateID = ucDaycarePatientSearch.GetSelectedPatientRateID();
            // EpiId =ucDaycarePatientSearch.
            patientNumber = ucDaycarePatientSearch.GetSelectedPatientNumber();
            List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();

            //Day Care Inventory Billing


            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            int OrgAddid = 0;
            //int OrgAddid = ILocationID;
            //new GateWay(base.ContextInfo).GetInventoryConfigDetails("Locations_BasedOn_Org", OrgID, ILocationID, out lstInventoryConfig);
            //if (lstInventoryConfig.Count > 0)
            //{
            //    if (lstInventoryConfig[0].ConfigValue == "Y")
            //    {
            //        OrgAddid = 0;
            //    }
            //    else
            //    {
            //        OrgAddid = ILocationID;
            //    }
            //}

            List<Locations> lstLocationName = new List<Locations>();
            new SharedInventory_BL(base.ContextInfo).GetInvLocationDetail(OrgID, OrgAddid, out lstLocationName);
            lstLocationName.Remove(lstLocationName.Find(P => P.LocationID != InventoryLocationID));
            string BP = "";

            //if (dList.SelectedItem.Text != "Collect Pharmacy Advance")
            //{
            //    if (lstLocationName[0].LocationTypeCode == "POD")
            //    {
            //        if (dList.SelectedItem.Text == "Pharmacy Settlement")
            //        {
            //            if (striscredit == "Y")
            //            {
            //                Response.Redirect("CreditInventoryDueClearance.aspx?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=IP&pod=Y", true);
            //            }
            //            else
            //                Response.Redirect(Helper.GetAppName() + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=IP&pod=Y", true);
            //        }
            //        else
            //            Response.Redirect(Helper.GetAppName() + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=IP&pod=Y", true);
            //    }

            //    else
            //    {
            //        if (dList.SelectedItem.Text == "Pharmacy Settlement" || dList.SelectedItem.Text == "Clear Dues" )
            //        {
            //            if (striscredit == "Y")
            //            {
            //                Response.Redirect("CreditInventoryDueClearance.aspx?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=IP&pod=Y", true);
            //            }
            //            else
            //                Response.Redirect(Helper.GetAppName() + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=IP&pod=N", true);
            //        }
            //        else
            //            Response.Redirect(Helper.GetAppName() + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=DayCare&pod=N&BP=Y&RateID=" + rateID, true);
            //    }
            //}

            //else
            //{
            //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue.Split('~')[0] + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
            //}

            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
             
            string RedirectURL = string.Empty;
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
            objQueryMaster.Querystring = QueryString;
            objQueryMaster.PatientID = pid.ToString();
            objQueryMaster.Surgery = "N"; 
            objQueryMaster.PatientVisitID = vid.ToString();
            objQueryMaster.PatientName = sPatientName.ToString();
            if (lstLocationName[0].LocationTypeCode == "POD")
            {
                objQueryMaster.PODValue = "Y";
                if (striscredit == "Y")
                {
                    objQueryMaster.CreditValue = "Y";
                }
                else
                {
                    objQueryMaster.CreditValue = "N";
                }
            }
            else
            {
                objQueryMaster.PODValue = "N";
                if (striscredit == "Y")
                {
                    objQueryMaster.CreditValue = "Y";
                    objQueryMaster.PODValue = "Y";
                }
                else
                {
                    objQueryMaster.CreditValue = "N";
                }
            }
            objQueryMaster.RateValue = rateID.ToString();
            if (OrgID == 26)
            {
                rCode = new RoomBooking_BL(base.ContextInfo).GetRoomsListByVisitID(OrgID, Convert.ToInt64(vid), out lstBookStatus, out roomStatus);
                long pBornVisitID = -1;
                rCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(vid), out pBornVisitID);
                objQueryMaster.SPatientName = strPatientName.ToString();
                objQueryMaster.DateOfBirth = strDOB.ToString();
                objQueryMaster.InPatientNo = inPatientNo.ToString();
                objQueryMaster.CellNo = strCellNo.ToString();
                objQueryMaster.RoomNo = strRoomNo.ToString();
                objQueryMaster.Purpose = strPurpose.ToString();
                objQueryMaster.ViewType = "IP";
                objQueryMaster.IPBPValue = "N";
                if (roomStatus == "Occupied")
                {
                    objQueryMaster.ADMCancelStatus = "N";
                }
                else if (dList.SelectedItem.Text == "Cancel Admission")
                {
                    objQueryMaster.ADMCancelStatus = "Y";
                }
                else if (pBornVisitID <= 0)
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed for this Episode,Bill is not created for this Episode');", true);
                }
            }
            else
            {
                objQueryMaster.SPatientName = strPatientName.ToString();
                objQueryMaster.DateOfBirth = strDOB.ToString();
                objQueryMaster.InPatientNo = inPatientNo.ToString();
                objQueryMaster.CellNo = strCellNo.ToString();
                objQueryMaster.RoomNo = strRoomNo.ToString();
                objQueryMaster.Purpose = strPurpose.ToString();
                objQueryMaster.ViewType = "IP";
                objQueryMaster.IPBPValue = "N";
                if (dList.SelectedItem.Text == "Cancel Admission")
                {
                    objQueryMaster.ADMCancelStatus = "Y";
                }
                else
                {
                    int VisId = 0;
                    if (vid != "")
                    {
                        VisId = Convert.ToInt32(vid);
                    }
                    if (VisId == 0)
                    {
                        if (dList.SelectedItem.Text == "Create/Edit Episode")
                        {
                            objQueryMaster.PatientNumber = patientNumber.ToString();
                            objQueryMaster.DDLvalue = a.ToString();
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed for this Episode,Bill is not created for this Episode');", true);
                        }
                    }
                    else
                    {
                        objQueryMaster.PatientNumber = patientNumber.ToString();
                        objQueryMaster.DDLvalue = a.ToString();
                    }
                }
            }
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('URL Not Found');", true);
            }
            #endregion
            // END Day Care Inventory Billing

            //if (OrgID == 26)
            //{
            //rCode = new RoomBooking_BL(base.ContextInfo).GetRoomsListByVisitID(OrgID, Convert.ToInt64(vid), out lstBookStatus, out roomStatus);
            //long pBornVisitID = -1;
            //rCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(vid), out pBornVisitID);
            //if (roomStatus == "Occupied" && dList.SelectedItem.Text != "Cancel Admission")
            //{
            //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&vType=" + "IP&BP=N", true);
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
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed for this Episode,Bill is not created for this Episode');", true);
            //}
            //}
            //else
            //{
            //    if (dList.SelectedItem.Text == "Cancel Admission")
            //    {
            //        Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&ADMC=" + "Y" + "&vType=" + "IP&BP=N", true);
            //    }
            //    else
            //    {
            //        int VisId = 0;
            //        if (vid != "")
            //        {
            //            VisId = Convert.ToInt32(vid);
            //        }
            //        if (VisId == 0)
            //        {
            //            if (dList.SelectedItem.Text == "Create/Edit Episode")
            //            {
            // Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&vType=" + "IP&BP=N" + "&DayCare=DayCare" + "&PNumber=" + patientNumber + "&ddl=" + a , true);
            //Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&vType=" + "IP&BP=N" +  "&PNumber=" + patientNumber + "&ddl=" + a, true);
            ////}
            ////else
            ////{
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed for this Episode,Bill is not created for this Episode');", true);
            //    }
            //}
            //else
            //{

            //Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&SPN=" + strPatientName + "&SDOB=" + strDOB + "&SPID=" + inPatientNo + "&SCELL=" + strCellNo + "&SRM=" + strRoomNo + "&SPRP=" + strPurpose + "&vType=" + "IP&BP=N" +  "&PNumber=" + patientNumber + "&ddl=" + a, true);
            //}
            //}            
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
