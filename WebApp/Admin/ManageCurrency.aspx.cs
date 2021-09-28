using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;
using System.IO;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using System.Collections.Generic;
using Attune.Podium.Common;
using Zayko.Finance;

public partial class Admin_ManageCurrency : BasePage, ICallbackEventHandler
{
    public Admin_ManageCurrency()
        : base("Admin_ManageCurrency_aspx")
    {

    }
    string UsrMsgsele = Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_03 == null ? "--Select--" : Resources.Admin_ClientDisplay.Admin_TestInvestigation_aspx_03;
    long returnCode = -1;
    int BaseCurrencyID = -1;
    string BaseCurrencyCode = string.Empty;
    Master_BL masterBL;
    private string strOutput;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            masterBL = new Master_BL(base.ContextInfo);
            ClientScriptManager csm = Page.ClientScript;
            String callbackRef = csm.GetCallbackEventReference(this, "arg", "fnGetOutputFromServer", "");
            String callbackScript = "function fnCallServerMethod(arg, context) {" + callbackRef + "; }";
            csm.RegisterClientScriptBlock(this.GetType(), "fnCallServerMethod", callbackScript, true);
            if (!IsPostBack)
            {
               
                LoadCurrencyMaster();
                LoadCurrencyMasterForMapping();
                LoadCurrencyForRateConversion();
            //     for(int i = 0; i < CurrencyList.Count; i++)
            //{
            //    ddlCode.Items.Add(CurrencyList.Descriptions[i]);
            //    ddlCode.Items[i].Value = CurrencyList.Codes[i];
             
               
            //}
                
            }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ManageCurrency.aspx:Page_Load", ex);
        }
    }
    public void RaiseCallbackEvent(String clientArgs) 
    { 
        string str = clientArgs;
        FilterGrid(str); 
    }    
    public string GetCallbackResult() 
    {
        return strOutput; 
    }
    public void LoadCurrencyMaster()
    {
        try
        {
            List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
            masterBL.GetCurrencyForOrg(OrgID, out BaseCurrencyID, out BaseCurrencyCode, out lstCurrencyMaster);
            hdnBaseCurrencyCode.Value = BaseCurrencyCode;
            ddlBaseCurrency.DataSource = lstCurrencyMaster;
            ddlBaseCurrency.DataTextField = "CurrencyName";
            ddlBaseCurrency.DataValueField = "CurrencyID";
            ddlBaseCurrency.DataBind();
            ddlBaseCurrency.Items.Insert(0,UsrMsgsele);
            ddlBaseCurrency.SelectedValue = BaseCurrencyID.ToString();

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Currency Master in ManageCurrency.aspx", ex);
        }

    }
    public System.Data.DataTable GetCurrencyMasterDataTable(List<CurrencyMaster> lstCurrMaster)
    {
        System.Data.DataTable dt = new DataTable();
        DataColumn dbCol1 = new DataColumn("CurrencyID");
        DataColumn dbCol2 = new DataColumn("CurrencyCode");
        DataColumn dbCol3 = new DataColumn("CurrencyName");

        dt.Columns.Add(dbCol1);
        dt.Columns.Add(dbCol2);
        dt.Columns.Add(dbCol3);

        DataRow dr;

        foreach (CurrencyMaster objCurrMaster in lstCurrMaster)
        {
            dr = dt.NewRow();
            dr["CurrencyID"] = objCurrMaster.CurrencyID;
            dr["CurrencyCode"] = objCurrMaster.CurrencyCode;
            dr["CurrencyName"] = objCurrMaster.CurrencyName;
            dt.Rows.Add(dr);
        }
        return dt;
    }
    public void LoadCurrencyMasterForMapping()
    {
        try
        {
            List<CurrencyMaster> lstCurrencyMaster = new List<CurrencyMaster>();
            masterBL.GetCurrencyForOrgMapping(OrgID, out lstCurrencyMaster);
            DataTable DtCurrencyMaster = GetCurrencyMasterDataTable(lstCurrencyMaster);
            this.ViewState["CurrencyMasterTable"] = DtCurrencyMaster;

            if (lstCurrencyMaster.Count > 0)
            {
                grdCurrency.DataSource = lstCurrencyMaster;
                grdCurrency.DataBind();
                btnAddCurrency.Visible = true;
                grdCurrency.Visible = true;
            }
            else
            {
                grdCurrency.Visible = false;
                btnAddCurrency.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Currency Master for Mapping in ManageCurrency.aspx", ex);
        }

    }
    private void FilterGrid(string CurrName)    
    {        
        string SearchText = string.Empty;
        DataTable dt = (DataTable)this.ViewState["CurrencyMasterTable"];
        DataView dv = dt.DefaultView;
        dv.RowFilter = "CurrencyName Like '%" + CurrName + "%'";
        grdCurrency.DataSource = dv;
        grdCurrency.DataBind();
        
        using (StringWriter sw = new StringWriter())        
        {            
            using (HtmlTextWriter htw = new HtmlTextWriter(sw))
            {
                grdCurrency.RenderControl(htw); 
                htw.Flush(); 
                strOutput = sw.ToString(); 
            }   
        }   
    }
    public void LoadCurrencyForRateConversion()
    {
        try
        {
            List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
            //"N" its return WithOut BaseCurr;
            masterBL.GetCurrencyForRateConversion(OrgID,"N", out lstCurrOrgMapp);
            if (lstCurrOrgMapp.Count > 0)
            {
                grdCurrencyConversion.DataSource = lstCurrOrgMapp;
                grdCurrencyConversion.DataBind();
                btnSaveRate.Visible = true;
                grdCurrencyConversion.Visible = true;
            }
            else
            {
                grdCurrencyConversion.Visible = false;
                btnSaveRate.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while loading Currency for Rate Conversion in ManageCurrency.aspx", ex);
        }

    }
    protected void btnBaseCurrency_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlBaseCurrency.SelectedValue != "0")
            {
                BaseCurrencyID = Convert.ToInt32(ddlBaseCurrency.SelectedValue);
                masterBL.SaveBaseCurrency(OrgID, BaseCurrencyID);
            }
            LoadCurrencyMaster();
            LoadCurrencyMasterForMapping();
            LoadCurrencyForRateConversion();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while saving Base Currency in ManageCurrency.aspx", ex);
        }
    }
    protected void grdCurrency_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{

        //    // HiddenField hdn = (HiddenField)e.Row.FindControl("hdnvalue");
        //    CheckBox chk = (CheckBox)e.Row.FindControl("chkBox");
        //    hdn.Value += chk.ClientID + '~';
        //}
        e.Row.Cells[0].Visible = false;
      
    }
    protected void grdCurrencyConversion_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string onlineRate = string.Empty;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lblOnlineRate");
            TextBox txt = (TextBox)e.Row.FindControl("txtConversionRate");
            CheckBox chkBox1 = (CheckBox)e.Row.FindControl("chkBoxRate");
            HiddenField hdn1 = (HiddenField)e.Row.FindControl("hdnRate1");
            HiddenField hdn2 = (HiddenField)e.Row.FindControl("hdnRate2");
            onlineRate = ConvertCurrencies(e.Row.Cells[1].Text);
            if (onlineRate !="")
            {
            lbl.Text = onlineRate;
            }
                else{
                    lbl.Text = hdn1.Value;
                    lbl.ForeColor = System.Drawing.Color.Red;
                }
            hdn2.Value = lbl.Text;
            string str = "javascript:setOnlineRate(" + chkBox1.ClientID + "," + hdn1.ClientID + "," + txt.ClientID + "," + hdn2.ClientID + ");";
            chkBox1.Attributes.Add("OnClick", str);
        }
        e.Row.Cells[0].Visible = false;
        e.Row.Cells[1].Visible = false;
    }
    protected void btnAddCurrency_Click(object sender, EventArgs e)
    {
        try
        {
            List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
            foreach (GridViewRow row in grdCurrency.Rows)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("chkBox");
                HiddenField hdn = (HiddenField)row.FindControl("hdnRate3");
                if (chkBox.Checked)
                {
                    CurrencyOrgMapping currOrgMapp = new CurrencyOrgMapping();
                    //currOrgMapp.CurrencyID = Convert.ToInt32(row.Cells[0].Text);
                    currOrgMapp.CurrencyID = Convert.ToInt32(hdn.Value);
                    currOrgMapp.OrgID = OrgID;
                    currOrgMapp.IsBaseCurrency = "N";
                    currOrgMapp.ConversionRate = 0;
                    lstCurrOrgMapp.Add(currOrgMapp);
                }
            }
            returnCode = masterBL.SaveOtherCurrency(lstCurrOrgMapp);
            LoadCurrencyMaster();
            LoadCurrencyMasterForMapping();
            LoadCurrencyForRateConversion();
            txtSearchCurrName.Text = "";
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Adding other Currencies to Organisation in ManageCurrency.aspx", ex);
        }
    }
    protected void btnSaveRate_Click(object sender, EventArgs e)
    {
        List<CurrencyOrgMapping> lstCurrOrgMapp = new List<CurrencyOrgMapping>();
        foreach (GridViewRow row in grdCurrencyConversion.Rows)
        {
            CheckBox chkBox = (CheckBox)row.FindControl("chkBoxCurrency");
            TextBox txt = (TextBox)row.FindControl("txtConversionRate");
           
                CurrencyOrgMapping currOrgMapp = new CurrencyOrgMapping();
                currOrgMapp.CurrencyID = Convert.ToInt32(row.Cells[0].Text);
                currOrgMapp.OrgID = OrgID;
                currOrgMapp.IsBaseCurrency = "N";
                currOrgMapp.ConversionRate = Convert.ToDecimal(txt.Text);
                if (chkBox.Checked)
                {
                    currOrgMapp.RemoveCurrency = 'Y';
                }
                else
                {
                    currOrgMapp.RemoveCurrency = 'N';
                }
                lstCurrOrgMapp.Add(currOrgMapp);
          
        }
        returnCode = masterBL.UpdateOtherCurrency(lstCurrOrgMapp);
        LoadCurrencyMaster();
        LoadCurrencyMasterForMapping();
        LoadCurrencyForRateConversion();
    }

    protected void refreshImg_Click(object sender, EventArgs e)
    {
        LoadCurrencyForRateConversion();
    }

    protected string ConvertCurrencies(string currencyCode)
    {
        string x = string.Empty;
        string y = string.Empty;
        string z = string.Empty;
        CurrencyConverter cc = new CurrencyConverter();
        try
        {

            if (ConnectionExists())
            {
                CurrencyData cd = cc.GetCurrencyData(currencyCode, hdnBaseCurrencyCode.Value);
                //LabelResFrom.Text = cd.BaseCode;
                //LabelResTo.Text = cd.TargetCode;
                //LabelResPrice.Text = cd.Rate.ToString();
                //LabelResDate.Text = cd.TradeDate.ToString();
                //LabelResMin.Text = cd.Min.ToString();
                //LabelResMax.Text = cd.Max.ToString();
                x = cd.BaseCode;
                y = cd.TargetCode;
                z = cd.Rate.ToString();
            }
        }
        catch (Exception ex)
        {

            CLogger.LogError("Error while Reading Online Rates for Currencies in ManageCurrency.aspx", ex);
        }
        return z;
    }
    bool ConnectionExists()
    {
        try
        {
            System.Net.Sockets.TcpClient clnt = new System.Net.Sockets.TcpClient("www.google.com", 80);
            clnt.Close();
            return true;
        }
        catch (System.Exception ex)
        {
            return false;
        }
    }
}
