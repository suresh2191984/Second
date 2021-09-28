using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using System.Collections;
using System.Data;
using Attune.Podium.Common;

public partial class CommonControls_AdvanceClientSearch : BaseControl
{

    Hashtable hsTable = new Hashtable();
    string strPatientNumber = string.Empty;
    string strClientID = string.Empty;
    string defaultText = string.Empty;
    List<AdvanceClientDetails> lstCollectionsHistory = new List<AdvanceClientDetails>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "3";
            string lsConfigValue = GetConfigValue("SHOWFEESPLIT", OrgID);
            Page.Form.DefaultButton = btnSearch.UniqueID;
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
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        /*
        try
        {
            clear();
            long returnCode = -1;
            Page.Form.DefaultButton = btnSearch.UniqueID;
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            string Client = txtClientNameSrch.Text;
            string[] words = null;
            string ClientCode = String.Empty;
            string ClientName = String.Empty;
            
            if (Client == "")
            {

                ClientName = "";
            }
            else
            {
                words = Client.Split(':');
                ClientCode = words[0].ToString();
                ClientName = words[1].ToString();
                ClientName = ClientName.TrimStart();
            }
            
            string type = ddlType.SelectedValue.ToString();
            //string fromdate = txtFromDate.Text;
            //string todate = txtToDate.Text;
            string fromdate = hdnFromDate.Value.ToString();
            string todate = hdnToDate.Value.ToString();
            returnCode = patientBL.SearchAdvanceClientDetails(OrgID, ClientCode, ClientName, type, fromdate, todate, out lstCollectionsHistory);
            if (type == "Refund")
            {
                gridRefund.DataSource = lstCollectionsHistory;
                gridRefund.DataBind();
            }
            else
            {
                grdResult.DataSource = lstCollectionsHistory;
                grdResult.DataBind();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in PatientExaminationPackage", ex);
        }
         * */
    }
    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        /*
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            currentPageNo = e.NewPageIndex;
            btnSearch_Click(sender, e);
        }
         * */
    }
    private void LoadGrid(EventArgs e, int currentPageNo, int PageSize)
    {
        /*
        try
        {
            if (txtVisitNo.Text.Trim() == defaultText.Trim())
            {
                txtVisitNo.Text = "";
            }
            long returnCode = -1;
            
            
            List<BillSearch> billSearch = new List<BillSearch>();
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        string VisitNumber = string.Empty;
        int LocationID = Convert.ToInt32(ddlocations.SelectedValue);
        strPatientNumber = txtPatientNumber.Text;
            if (CID > 0)
            {
                strClientID = CID.ToString();
            }
            else
            {
                strClientID = (hdnClientID.Value.Split('|')[0]).ToString();
            }
        VisitNumber = txtVisitNo.Text;
        string BarcodeNumber = String.Empty;
        try
        {
            //returnCode = patientBL.SearchBillOptionDetails(strBillNo, strBillFromDate, strBillToDate, strPatientName, iPhysicianID, OrgID, strPatientNumber, strClientID, VisitNumber, BarcodeNumber, out billSearch, PageSize, currentPageNo, out totalRows, LocationID);
        }
        catch
        {
        }

        if (billSearch.Count > 0)
        {
            GrdFooter.Style.Add("display", "block");
            totalpage = totalRows;
            lblTotal.Text = CalculateTotalPages(totalRows).ToString();
            if (hdnCurrent.Value == "")
            {
                lblCurrent.Text = currentPageNo.ToString();
            }
            else
            {
                lblCurrent.Text = hdnCurrent.Value;
                currentPageNo = Convert.ToInt32(hdnCurrent.Value);
            }
        }
        else
            GrdFooter.Style.Add("display", "none");

        if (returnCode == 0 && billSearch.Count > 0)
        {
            grdResult.Visible = true;
            lblResult.Visible = false;
            lblResult.Text = "";
            grdResult.DataSource = billSearch;
            grdResult.DataBind();
            HasResult = true; 
        }
        else
        {
            HasResult = false;
            grdResult.Visible = false;
            lblResult.Visible = true;
            lblResult.Text = "No matching records found"; 
        }
            onSearchComplete(this, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
        */
    }
    private void clear()
    {
        gridRefund.DataSource = null;
        gridRefund.DataBind();
        grdResult.DataSource = null;
        grdResult.DataBind();

    }
}
