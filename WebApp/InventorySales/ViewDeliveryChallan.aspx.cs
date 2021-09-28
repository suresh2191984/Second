using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventorySales.BL;
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PlatForm.BL;
using System.Collections;
using Attune.Kernel.NumberToWordConversion;


public partial class InventorySales_ViewDeliveryChallan : Attune_BasePage 
{
    long sid = 0;
    long sofd = 0;
    string status = "";
    int CustomerID = 0;
    string Amt = "";
    List<Organization> lstOrganization = new List<Organization>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["SID"] != null)
            {
                sid = long.Parse(Request.QueryString["SID"]);
            }
            if (Request.QueryString["SOFD"] != null)
            {
                sofd = long.Parse(Request.QueryString["SOFD"]);
            }
            if (Request.QueryString["status"] != null)
            {
                status = Request.QueryString["status"];
            }
            if (Request.QueryString["CID"] != null)
            {
                CustomerID = int.Parse(Request.QueryString["CID"]);
            }
            GetInformationDatas();
        }
    }
    public void GetInformationDatas()
    {
        long returncode = 0;
        List<Customers> lstCustomers = new List<Customers>();
        List<StockOutFlowDetails> lstoutflowdetails = new List<StockOutFlowDetails>();
        List<Suppliers> lstsuppliers = new List<Suppliers>();
        List<StockOutFlow> lststkoutflow = new List<StockOutFlow>();
        List<SalesOrders> lstsalesorders  =new List<SalesOrders>();
        InventorySales_BL invbl = new InventorySales_BL(base.ContextInfo);
        List<CustomerLocations> lstCustomerLocation = new List<CustomerLocations>();
        returncode = invbl.GetSalesOrderOutFlowDetails(OrgID, InventoryLocationID, sid, sofd, ILocationID, status, CustomerID,out lststkoutflow,
                                                       out lstoutflowdetails, out lstCustomers, out lstsuppliers, out lstsalesorders, out lstOrganization, out  lstCustomerLocation);

        if (lstOrganization.Count > 0 )
        {

            lblOrgName.Text = lstOrganization[0].Name;
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
                lbltinno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
                lbldruglicenseno1.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            lblStreetAddress.Text = lstOrganization[0].Address;
            lblCity.Text = lstOrganization[0].City;
            //lblPhone.Text = lstOrganization[0].PhoneNumber;
        }

        if (lstCustomers.Count > 0)
        {
            lblnames.Text = lstCustomers[0].CustomerName;
            lbladdrs.Text = lstCustomers[0].Address1;
            lbladdress2.Text = lstCustomers[0].Address2;
            lblcities.Text = lstCustomers[0].City;
            lblstates.Text = lstCustomers[0].City;
            lbltelephones.Text = lstCustomers[0].Phone;
            lblfaxes.Text = lstCustomers[0].FaxNumber;
            lblcst.Text = lstCustomers[0].CSTNo;
            lblsvat.Text = lstCustomers[0].TINNo;
            drupnos.Text = lstCustomers[0].DrugLicenceNo;



        }
        if (lstsalesorders.Count > 0)
        {
            lblInvoiceno.Text = lstsalesorders[0].InvoiceNo;
            lblinvoiceda.Text = lstsalesorders[0].CreatedAt.ToExternalDate();
            lblsaleOrderNo.Text = lstsalesorders[0].SalesOrderNo;
            
        }
        if (lstCustomerLocation.Count > 0)
        {
            lblCustomerLocName.Text = lstCustomers[0].CustomerName;
            lblCustomerName.Text = lstCustomerLocation[0].LocationName;
            lblCustomerLocAddress.Text = lstCustomerLocation[0].Address;
            lblCustomerState.Text = lstCustomers[0].City;
            lblCustomerTelNo.Text = lstCustomers[0].Phone;
            lblLocationFax.Text = lstCustomers[0].FaxNumber;

        }
        
        if (lststkoutflow.Count > 0)
        {
            var tot = "";//lststkoutflow[0].GrandTotal -(lststkoutflow[0].Discount + lststkoutflow[0].Tax+lstoutflowdetails[0].CSTax );
            lblchellan.Text = "";// lststkoutflow[0].DCNo;
            lblTotalSales.Text = "";//lststkoutflow[0].TotalSales.ToString("0.00");
            lbldiscount1.Text = "";//lststkoutflow[0].Discount.ToString("0.00");
            lblvatcst.Text = "";//lststkoutflow[0].Tax.ToString("0.00");
            lbladdlvat.Text = "";//lststkoutflow[0].CSTax .ToString("0.00");
            lblsurcharge.Text = "";//lststkoutflow[0].Surcharge.ToString("0.00");
            lbloctori.Text = "";//lststkoutflow[0].ExciseTaxAmount.ToString("0.00");
            lblGrandTotal.Text = "";//lststkoutflow[0].GrandTotal.ToString("0.00");
            lblTotal.Text = "";//lststkoutflow[0].GrandTotal.ToString("0.00");
            lblRoundOffValue.Text = "";//lststkoutflow[0].RoundOfValue .ToString("0.00");
            lblRoundOffNetTotal.Text = "";//lststkoutflow[0].GrandTotal.ToString("0.00");
            lblinvoicevalue.Text = "";//lststkoutflow[0].GrandTotal.ToString("0.00");

             Attune_NumberToWord num = new Attune_NumberToWord();
             if (Convert.ToDouble(lblinvoicevalue.Text) > 0)
                {
                    if (Convert.ToDouble(lblinvoicevalue.Text) > 0)
                    {
                        Amt = "Amount in Words:" + CurrencyName + "." + Utilities.FormatNumber2Word(num.ConvertToWord (lblinvoicevalue.Text).ToString()) + " " + MinorCurrencyName + " Only";
                    }
                    else
                    {
                        Amt = " Amount in Words: " + CurrencyName + "." + num.ConvertToWord(lblinvoicevalue.Text).ToString() + " Only";
                    }
                }
                else
                {
                    Amt = " Amount in Words " + CurrencyName + ":  " + " Zero Only";
                }
                lblAmountWords.Text = Amt;
           
        }
        if (lstoutflowdetails.Count > 0)
        {
            grdResult.DataSource = lstoutflowdetails;
            grdResult.DataBind();
        }
 
    }
    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            StockOutFlowDetails sofd = (StockOutFlowDetails)e.Row.DataItem;

        }
    }
}
