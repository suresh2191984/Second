using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using NumberToWord;
using Attune.Solution.BusinessComponent;

public partial class CommonControls_Referrals :BaseControl
{
    Referrals_BL objReferrals_BL ;
    List<Referral> lstReferrals = new List<Referral>();
    public string ReferedDate { get; set; }
    public string PatientURN { get; set; }
    public string ReferedOrg { get; set; }
    public string ReferedLoc { get; set; }
    public string Status { get; set; }
    public string flag { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
    }
    
    public long GetReferalDetails()
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            objReferrals_BL.GetInBoundReferalDetails(OrgID, ILocationID, out lstReferrals);
            grdResult.DataSource = lstReferrals;
            grdResult.DataBind();
            if (lstReferrals.Count>0)
            {
               
                return 1;
            }
            else
            {
                return -1;
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Geting GetInBoundReferalDetails.", Ex);
            return -1;
        }
       
    }

    public long BindOutBoundReferral()
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            objReferrals_BL.SearchOutBoundReferals(OrgID, ILocationID, ReferedDate, PatientURN, ReferedOrg,ReferedLoc, Status, out lstReferrals);
            grdResult.DataSource = lstReferrals;
            grdResult.DataBind();
            if (lstReferrals.Count > 0)
            {
                return 1;
            }
            else
            {
                return -1;
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Geting GetOutBoundReferalDetails.", Ex);
            return -1;
        }
    }

    public long BindInBoundReferral()
    {
        objReferrals_BL = new Referrals_BL(base.ContextInfo);
        try
        {
            objReferrals_BL.SearchInBoundReferals(OrgID, ILocationID, ReferedDate, PatientURN, ReferedOrg, ReferedLoc, Status, out lstReferrals);
            grdResult.DataSource = lstReferrals;
            grdResult.DataBind();
            if (lstReferrals.Count > 0)
            {
                return 1;
            }
            else
            {
                return -1;
            }

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Geting GetOutBoundReferalDetails.", Ex);
            return -1;
        }
    }
    
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Referral Ref= (Referral)e.Row.DataItem;
                LinkButton lnkBookSchedule = (LinkButton)e.Row.FindControl("lnkBookSchedule");

                string strURN = Ref.URN == "" ? "-1" : Ref.URN;
                string strScript = "RowSelectCommon('" + ((RadioButton)e.Row.Cells[1].FindControl("rdSel")).ClientID + "','" + Ref.ReferedByVisitID + "','" + strURN + "','" + Ref.IsPatient + "','" + Ref.ReferralID + "','" + Ref.PatientID + "','" + Ref.ReferralDetailsID + "','" + Ref.ReferedToLocation + "');";
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onmouseover", "this.style.cursor='pointer';");
                ((RadioButton)e.Row.Cells[0].FindControl("rdSel")).Attributes.Add("onclick", strScript);

                //lnkBookSchedule.PostBackUrl = "~/Reception/TrustedSchedules.aspx?pid=" + Ref.PatientID + "&rorg=" + Ref.ReferedToOrgID + "&rfid=" + Ref.ReferralID;
            }
        }
        if (flag == "INBOUND")
        {
            grdResult.Columns[5].Visible = false;
        }
        else
        {
            grdResult.Columns[4].Visible = false;
        }

    }
    
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            if (flag == "INBOUND")
            {
                GetReferalDetails();
            }
            else
            {
                BindOutBoundReferral();
            }
        }
    }

    
}
