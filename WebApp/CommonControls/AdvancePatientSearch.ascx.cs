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

public partial class CommonControls_AdvancePatientSearch : BaseControl
{

    Hashtable hsTable = new Hashtable();
    string strBillFromDate = string.Empty;
    string strBillToDate = string.Empty;
    string strPatientNumber = string.Empty;
    string strClientID = string.Empty;
    string defaultText = string.Empty;
    string IsNeedExternalVisitIdWaterMark = string.Empty;
    List<AdvanceClientDetails> lstCollectionsHistory = new List<AdvanceClientDetails>();
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Form.DefaultButton = btnSearch.UniqueID;
        if (!IsPostBack)
        {
            AutoCompleteExtender1.ContextKey = "3";
            LoadLocation();
        }

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
        string[] words =null;
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
        

        string type = ddlocations.SelectedItem.ToString();
        //string fromdate = txtFromDate.Text;
        //string todate = txtToDate.Text;
        string fromdate = hdnFromDate.Value.ToString();
        string todate = hdnToDate.Value.ToString();
        returnCode = patientBL.SearchAdvancePatientDetails(OrgID, ClientCode, ClientName, type, fromdate, todate, out lstCollectionsHistory);

        grdResult.DataSource = lstCollectionsHistory;
        grdResult.DataBind();
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
         * */
    }

    protected void grdResult_RowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        var amt = lstCollectionsHistory.Sum(p => p.amount);
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            //GRAND TOTAL.
            Label lblGrandTotal = (Label)e.Row.FindControl("lbltotal");
            lblGrandTotal.Text = amt.ToString();
        }
        
    }

    protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        /*
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - Start
            currentPageNo = e.NewPageIndex;
            // Added by Perumal on 29 Oct 2011 - End
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
            trlegend.Style.Add("display", "block");
            int iPhysicianID = -1;
            List<BillSearch> billSearch = new List<BillSearch>();

        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        strPatientName = txtPatientName.Text;
        string[] ArrayPName = strPatientName.Split('-');
        strPatientName = ArrayPName[0] == "" ? "" : ArrayPName[0].ToString();
        string VisitNumber = string.Empty;
        int LocationID = Convert.ToInt32(ddlocations.SelectedValue);
        if (ddlRegisterDate.SelectedItem.Text != "--Select--")
        {
            if ((txtFromDate.Text != "" && txtToDate.Text != ""))
            {
                strBillFromDate = txtFromDate.Text;
                strBillToDate = txtToDate.Text;
            }
            else if (txtFromPeriod.Text != "" && txtToPeriod.Text != "")
            {
                strBillFromDate = txtFromPeriod.Text;
                strBillToDate = txtToPeriod.Text;
            }
            else if(ddlRegisterDate.SelectedItem.Text == "Today")
            {
                strBillFromDate = OrgTimeZone;
                strBillToDate = OrgTimeZone; 
            }
        }
        else
        {
            strBillFromDate = "";
            strBillToDate = "";
        }
        
        strBillNo = txtBillNo.Text;
            if (hdnPhysicianID.Value!= "0")
            {
                iPhysicianID = Convert.ToInt32(hdnPhysicianID.Value.Split('^')[1]);
            }
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
            returnCode = patientBL.SearchBillOptionDetails(strBillNo, strBillFromDate, strBillToDate, strPatientName, iPhysicianID, OrgID, strPatientNumber, strClientID, VisitNumber, BarcodeNumber, out billSearch, PageSize, currentPageNo, out totalRows, LocationID);
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
            if (currentPageNo == 1)
            {
                btnPrevious.Enabled = false;

                if (Int32.Parse(lblTotal.Text) > 1)
                {
                    btnNext.Enabled = true;
                }
                else
                    btnNext.Enabled = false;
            }
            else
            {
                btnPrevious.Enabled = true;

                if (currentPageNo == Int32.Parse(lblTotal.Text))
                    btnNext.Enabled = false;
                else btnNext.Enabled = true;
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
            trlegend.Style.Add("display", "none");  
        }
            onSearchComplete(this, e);
        }
        catch (Exception ex)
        {
            CLogger.LogError("error", ex);
        }
         * */
    }
    public void LoadLocation()
    {

        PatientVisit_BL PatientVisit_BL = new PatientVisit_BL(base.ContextInfo);
        List<OrganizationAddress> lstOrganizationAddress = new List<OrganizationAddress>();
        List<OrganizationAddress> LoginLoc = new List<OrganizationAddress>();
        List<OrganizationAddress> ParentLoc = new List<OrganizationAddress>();
        PatientVisit_BL.GetLocation(OrgID, LID, 0, out lstOrganizationAddress);
        if (lstOrganizationAddress.Count > 0)
        {
            if (CID > 0)
            {
                LoginLoc = lstOrganizationAddress.FindAll(P => P.AddressID == ILocationID).ToList();
                ParentLoc = (from lst in lstOrganizationAddress
                             join lst1 in LoginLoc on lst.AddressID equals lst1.ParentAddressID
                             select lst).ToList();
                LoginLoc = LoginLoc.Concat(ParentLoc).ToList<OrganizationAddress>();
                ddlocations.DataSource = LoginLoc;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
            else
            {
                ddlocations.DataSource = lstOrganizationAddress;
                ddlocations.DataValueField = "AddressID";
                ddlocations.DataTextField = "Location";
                ddlocations.DataBind();
            }
        }
        ddlocations.Items.Insert(0, "--Select--");
        ddlocations.Items[0].Value = "0";
        ddlocations.SelectedValue = Convert.ToString(ILocationID);
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
    private void clear()
    {
        
        grdResult.DataSource = null;
        grdResult.DataBind();

    }
}
