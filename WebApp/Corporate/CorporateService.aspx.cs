using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BusinessEntities;
using System.Configuration;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
public partial class Corporate_CorporateService : BasePage
{
    string type;
    long retval = -1;
    long returnCode = -1;
    long visitID = -1;
    long pvisitID = -1;


    protected void Page_Load(object sender, EventArgs e)
    {
        uctrlBillSearch.onSearchComplete += new EventHandler(uctrlBillSearch_onSearchComplete);
        if (!IsPostBack)
        {
            BindDropDownValues();
            if (RoleID == 1)
            {
                physicianHeader.Visible = true;
                userHeader.Visible = false;
            }
            else
            {
                physicianHeader.Visible = false;
                userHeader.Visible = true;
            }
       }
    }
    protected void uctrlBillSearch_onSearchComplete(object sender, EventArgs e)
    {
        if (uctrlBillSearch.HasResult)
        {
            aRow.Visible = true;
        }
        else
        {
            aRow.Visible = false;
        }
    }
    private bool validatePage(long bid)
    {
        bool retval = true;
        string error = "";
        if (bid <= 0)
        {
            retval = false;
            error = "Please Select a Bill";
        }
        ErrorDisplay1.ShowError = true;
        ErrorDisplay1.Status = error;
        return retval;
    }
    protected void bGo_Click(object sender, EventArgs e)
    {
        try
        {
            Patient_BL pbl = new Patient_BL(base.ContextInfo);
            string patientType = string.Empty;
            long vid = Convert.ToInt64(hdnVID.Value);
            long pid = Convert.ToInt64(hdnPID.Value);
            long FinalBillID = 0;
            long BillNo = 0;
            Int64.TryParse(hdnBID.Value, out FinalBillID);
            Int64.TryParse(hdnBillNo.Value, out BillNo);


            string purpose = hdnVisitDetail.Value;

            pbl.pCheckPatientisIPorOP(vid, pid, OrgID, out patientType);

            if (patientType != "Admitted" || purpose != "Add Bill Items")
            {
                string[] temp = hdnVisitTypeCredit.Value.Split('~');
                string pagename = string.Empty;
                if (hdnVisitDetail.Value != "Print Bill")
                {
                    if (hdnVisitDetail.Value == "View Bill")
                        pagename = "?vid=" + hdnVID.Value + "&pagetype=BP&bid=" + FinalBillID + "&billNo=" + BillNo + "";
                    else if (hdnVisitDetail.Value == "Add Bill Items")
                        pagename = "?vid=" + hdnVID.Value + " &pid=" + hdnPID.Value + "&pagetype=ABI&bid=" + FinalBillID + "";
                    else if (hdnVisitDetail.Value == "Cancel Services")
                        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&PNumber=" + hdnPNumber.Value + "&bid=" + FinalBillID + "&btype=RFD" + "&billno=" + hdnBillNumber.Value;
                    else if (hdnVisitDetail.Value == "Cancel Bill")
                        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=CAN";
                    else if (hdnVisitDetail.Value == "Add Service Code")
                        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=ASC";

                    else if (hdnVisitDetail.Value == "Pharmacy Consolidated Bill")
                        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=ASC";
                    //==================================
                    else if (hdnVisitDetail.Value == "View Pharma Consolidated Bill")
                        pagename = "?VID=" + hdnVID.Value + "&PID=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&btype=ASC";

                    else if (dList.SelectedItem.ToString() == "EditIPBillSettlement")

                        pagename = "?vid=" + hdnVID.Value + "&pid=" + hdnPID.Value + "&pname=" + hdnPNAME.Value + "&bid=" + FinalBillID + "&vType=" + temp[0] + "&EIPBill=" + "Edit" + "&IsCredit=" + temp[1];

                    //===================================

                    Response.Redirect(Request.ApplicationPath + dList.SelectedItem.Value + pagename, true);
                }
                else
                {
                    int iBillGroupID = 0;
                    iBillGroupID = (int)ReportType.OPBill;
                    List<Config> lstConfig = new List<Config>();
                    new GateWay(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Dynamic Print", OrgID, ILocationID, out lstConfig);

                    if (lstConfig.Count > 0 && lstConfig[0].ConfigValue == "Y")
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:PrintDynamic();", true);
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "print", "javascript:PrintReport();", true);
                    }

                }

            }
            else
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "tKey2", "javascript:alert('This action cannot be performed for inpatients');", true);
            }
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }

    protected void BindDropDownValues()
    {
        List<BillSearchActions> lstVisitSearchAction = new List<BillSearchActions>();
        retval = new BillingEngine(base.ContextInfo).GetBillSearchActions(RoleID, out lstVisitSearchAction);
        if (lstVisitSearchAction.Count > 0)
        {
            dList.DataSource = lstVisitSearchAction;
            dList.DataTextField = "ActionName";
            dList.DataValueField = "PageURL";
            dList.DataBind();
        }
    }
}
