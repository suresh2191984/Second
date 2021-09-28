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

public partial class InPatient_IPBillSettlementHome : BasePage
{
    public InPatient_IPBillSettlementHome ()
        : base("InPatient\\IPBillSettlementHome.aspx")
    {
    }

    int IPtype;
    static List<ActionMaster> lstActionsMaster = new List<ActionMaster>();
    protected void Page_Load(object sender, EventArgs e)
    {
        ucINPatientSearch.onSearchComplete += new EventHandler(ucINPatientSearch_onSearchComplete);
        TextBox txt = (TextBox)ucINPatientSearch.FindControl("txtDOB");
        txt.Attributes.Add("OnChange", "ExcedDate('" + txt.ClientID.ToString() + "','',0,0);");

        if (!IsPostBack)
        {

            if (RoleID == 1)
            {
             //   PhyHeader1.Visible = true;
               // UsrHeader1.Visible = false;
            }
            else
            {
               // PhyHeader1.Visible = false;
               // UsrHeader1.Visible = true;
            }
            IPtype = Convert.ToInt32(TaskHelper.SearchType.IPSettlement);
            long returnCode = -1;
            Nurse_BL nurseBL = new Nurse_BL(base.ContextInfo);
            List<ActionMaster> lstActionMaster = new List<ActionMaster>(); //List<SearchActions> pages = new List<SearchActions>(); 
            returnCode = new Nurse_BL(base.ContextInfo).GetActions(RoleID, IPtype, out lstActionMaster); //returnCode = nurseBL.GetSearchActionsInPatient(RoleID, IPtype, out pages);
            lstActionsMaster = lstActionMaster.ToList();
            dList.DataSource = lstActionMaster;
            dList.DataTextField = "ActionName";
            //dList.DataValueField = "PageURL";
            dList.DataValueField = "ActionCode";
            dList.DataBind();

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
            long pid = 0;
            string vid = "";
            string sPatientName = "";
            long rCode = -1;
            long rateID = 0;
            string roomStatus = string.Empty;
            pid = ucINPatientSearch.GetSelectedInPatient();
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            List<RoomBookingDetails> lstBookStatus = new List<RoomBookingDetails>();
            long retid = new PatientVisit_BL(base.ContextInfo).GetInPatientVisitDetails(pid, out lstPatientVisit);
            if (lstPatientVisit.Count > 0)
            {
                vid = lstPatientVisit[0].PatientVisitId.ToString();
                //rateID = lstPatientVisit[0].RateID;
                sPatientName = lstPatientVisit[0].Name.ToString();
            }
            #region Get Redirect URL
            QueryMaster objQueryMaster = new QueryMaster();
             
            string RedirectURL = string.Empty;
            string QueryString = string.Empty;
            if (lstActionsMaster.Exists(p => p.ActionCode == dList.SelectedValue))
            {
                QueryString = lstActionsMaster.Find(p => p.ActionCode == dList.SelectedValue).QueryString;
            }
            objQueryMaster.Querystring = QueryString;
            if (OrgID == 26)
            {
                long pBornVisitID = -1;
                rCode = new RoomBooking_BL(base.ContextInfo).GetRoomsListByVisitID(OrgID, Convert.ToInt64(vid), out lstBookStatus, out roomStatus);
                rCode = new Neonatal_BL(base.ContextInfo).CheckIsNewBornBaby(OrgID, Convert.ToInt64(vid), out pBornVisitID);
                if (pBornVisitID <= 0)
                {
                    string sPath = "InPatient\\\\IPBillSettlementHome.aspx.cs_2";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('"+ sPath +"');", true);
                }
                objQueryMaster.RateValue = string.Empty;

                //if (roomStatus == "Occupied")
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                //}
                //else if (pBornVisitID>0)
                //{
                //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP", true);
                //}
                //else
                //{
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This cannot be performed as the Room is not occupied by this patient');", true);
                //}
            }
            else
            {
                objQueryMaster.RateValue = rateID.ToString();
            }
            //else
            //{
            //    Response.Redirect(Helper.GetAppName() + dList.SelectedValue + "?PID=" + pid.ToString() + "&VID=" + vid + "&PNAME=" + sPatientName + "&vType=" + "IP &RateID=" + rateID, true);
            //}            
            objQueryMaster.PatientID = pid.ToString();
            objQueryMaster.PatientVisitID = vid.ToString();
            objQueryMaster.PatientName = sPatientName;
            objQueryMaster.ViewType = "IP";
            Attune.Utilitie.Helper.AttuneUtilitieHelper.GetRedirectURL(objQueryMaster, out RedirectURL);
            if (!String.IsNullOrEmpty(RedirectURL))
            {
                Response.Redirect(RedirectURL, true);
            }
            else
            {
                string sPath = "InPatient\\\\IPBillSettlementHome.aspx.cs_3";
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "", "javascript:alert('"+ sPath +"');", true);
            }
            #endregion

        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void dList_SelectedIndexChanged(object sender, EventArgs e)
    {
    }
}
