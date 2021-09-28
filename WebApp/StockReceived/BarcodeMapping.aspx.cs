using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;

public partial class StockReceived_BarcodeMapping : Attune_BasePage
{
    public StockReceived_BarcodeMapping()
        : base("StockReceived_BarcodeMapping_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockReceived> lstStockReceived = new List<StockReceived>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<StockReceivedBarcodeMapping> lstStockReceivedBarcodeMapping = new List<StockReceivedBarcodeMapping>();
    List<Users> lstUsers = new List<Users>();
    InventoryCommon_BL inventoryBL;
    protected void Page_Load(object sender, EventArgs e)
    {

        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
            if (!IsPostBack)
            {
                if(Request.QueryString["tid"]!=null)
                {
                    hdnCurrrentTaskID.Value = Request.QueryString["tid"].ToString();
                }
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            //IsNeed Calculation Of Complimentary Quantity Required 
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("NeedCompQtyCalculation", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                
                hdnREQCalcCompQTY.Value = lstInventoryConfig[0].ConfigValue;
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
                }
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("View_MatchingInvoice_Button", OrgID, ILocationID, out lstInventoryConfig);

              //  if (lstInventoryConfig.Count > 0)
              //  {
              //      btnInvoice.Visible = Convert.ToBoolean(lstInventoryConfig[0].ConfigValue);

              //  }
              //  else
              //  {
                    btnInvoice.Visible = false;
              //  }
                LoadDetails();
				string hideTax=GetConfigValue("IsMiddleEast",OrgID);
           		 if (hideTax=="Y")
           		 {
             //   lblSupplierSerTax.Style.Add("display", "none");
            //totalTaxAmt.Style.Add("display", "none");
                    grdResult.Columns[9].Visible = false;
                    grdResult.Columns[10].Visible = false;
           		 }
                
            }
        

    }

    public void LoadProductDetails()
    {

    }

    public void LoadDetails()
    {
        long poNO = 0;
        string approval = string.Empty;
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        if (Request.QueryString["ID"] != null)
        {
            poNO = long.Parse(Request.QueryString["ID"]);
            hdnStockReceivedID.Value = Request.QueryString["ID"].ToString();
        }
        approval = Request.QueryString["Approve"];
        // hypLnkPrint.NavigateUrl = "PrintStockReceived.aspx?poNO=" + poNO + "";
        try
        {
            inventoryBL.GetStockReceivedDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstInventoryItemsBasket,out lstStockReceivedBarcodeMapping);

            if (GetConfigValue("BarCodeMappingBeforeStockReceiveApproval", OrgID) == "Y")
            {
                lstInventoryItemsBasket = (from invItem in lstInventoryItemsBasket
                                           where invItem.Description.Equals("Y")
                                           select invItem).ToList<InventoryItemsBasket>();

            }
            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {

                ddlProductList.DataSource = lstInventoryItemsBasket;
                ddlProductList.DataTextField = "productName";
                ddlProductList.DataValueField = "ID";
                ddlProductList.DataBind();

                ListItem ddlselect = GetMetaData("Select", "0");
                if (ddlselect == null)
                {
                    ddlselect = new ListItem() { Text = "Select", Value = "0" };
                }
                ddlProductList.Items.Insert(0, ddlselect);

               // lblOrgName.Text = lstOrganization[0].Name;
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                   // lblOrgTinno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                   // lblorgDlno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
               // lblStreetAddress.Text = lstOrganization[0].Address;
               // lblCity.Text = lstOrganization[0].City;
               // lblPhone.Text = lstOrganization[0].PhoneNumber;
                if (lstSuppliers.Count > 0)
                {
                    lblVendorName.Text = lstSuppliers[0].SupplierName;
                   // lblVendorTinno.Text = lstSuppliers[0].TinNo;
                 //  lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                   //  lblVendorCity.Text = lstSuppliers[0].City;
                   // lblVendorPhone.Text = lstSuppliers[0].Phone;
                }
                lblSRDate.Text = lstStockReceived[0].StockReceivedDate.ToExternalDate();
                lblPOID.Text = lstStockReceived[0].PurchaseOrderNo;
                if (lstStockReceived[0].InvoiceNo != "" && lstStockReceived[0].InvoiceNo != null)
                {
                    lblInvoiceNo.Text = lstStockReceived[0].InvoiceNo;
                }
                else
                {
                    lblInvoiceNo.Text = "----";
                }
                if (lstStockReceived[0].DCNumber != "" && lstStockReceived[0].DCNumber != null)
                {
                    lblDCNo.Text = lstStockReceived[0].DCNumber;
                }
                else
                {
                    lblDCNo.Text = "----";
                }
                //lblDCNo.Text = lstStockReceived[0].DCNumber;
                if (lstStockReceived != null && lstStockReceived.Count > 0)
                {
                    //lblTotaltax.Text = String.Format("{0:0.00}", lstStockReceived[0].Tax);
                }
                if (lstStockReceived[0].ExciseTaxAmount <= 0)
                {
                   // lbltotalExe.Attributes.Add("class", "hide");
                   // trCess2.Attributes.Add("class", "hide");
                   // trEdCess1.Attributes.Add("class", "hide");
                   // lblcst5.Attributes.Add("class", "hide");
                }

                hdnApproveStockReceived.Value = lstStockReceived[0].StockReceivedID.ToString();
                lblReceivedID.Text = lstStockReceived[0].StockReceivedNo.ToString();
                hdnStatus.Value = lstStockReceived[0].Status;
                lblStatus.Text = lstStockReceived[0].Status;
                string tblBarcode = string.Empty;
                if (lstStockReceivedBarcodeMapping.Count > 0)
                {
                    string StockReceivedDetailsId = ddlProductList.SelectedValue;
                    
                    //int StartNo =  Convert.ToInt32(lstStockReceivedBarcodeMapping[0].Barcode);
                    //int EndNo = Convert.ToInt32(lstStockReceivedBarcodeMapping[lstStockReceivedBarcodeMapping.Count-1].Barcode);

                    //for (int i = StartNo; i <= EndNo; i++)                    
                    //{  
                    for (int i = 0; i < lstStockReceivedBarcodeMapping.Count; i++)
                    {
                       
                        string ProductName = lstInventoryItemsBasket.Find(P => P.ProductID == lstStockReceivedBarcodeMapping[i].ProductID).ProductName.ToString();
                        string Unit = lstStockReceivedBarcodeMapping[i].Unit;
                        string Productkey = lstStockReceivedBarcodeMapping[i].ProductKey;
                        int ProductID = Convert.ToInt32(lstStockReceivedBarcodeMapping[i].ProductID);
                        int UnitSize = lstStockReceivedBarcodeMapping[i].UnitSize;

                        tblBarcode = tblBarcode + "<tr id=row" + i + ">";
                        tblBarcode = tblBarcode + "<td class='hide'><span name='spnProductId'>" + ProductID + "</span></td>";
                        tblBarcode = tblBarcode + "<td><span name='spnProductName'>" + ProductName + "</span></td>";
                        tblBarcode = tblBarcode + "<td onclick='editCell(this);' ><span name='spnBarcode'>" + lstStockReceivedBarcodeMapping[i].Barcode + "</span></td>";
                        tblBarcode = tblBarcode + "<td class='hide'><span name='spnProductKey'>" + Productkey + "</span></td>";
                        tblBarcode = tblBarcode + "<td class='hide'><span name='spnUnitSize'>" + UnitSize + "</span></td>";
                        tblBarcode = tblBarcode + "<td><span name='spnUnit'>" + Unit + "</span></td>";
                        tblBarcode = tblBarcode + "<td class='hide'><span name='spnStockReceivedDetailsId'>" + StockReceivedDetailsId + "</span></td>";
                        tblBarcode = tblBarcode + "<td> <input id=row" + i + " type='button' onclick='fndelete(id);' disabled class='ui-icon ui-icon-trash b-none pointerm pull-left'  /></td>";
                        tblBarcode = tblBarcode + "</tr>";
                    }                    
                    
                }
                for (int j = 0; j < lstInventoryItemsBasket.Count; j++)
                {
                    hdnddlPro.Value += lstInventoryItemsBasket[j].ProductName + '~' + lstInventoryItemsBasket[j].RECQuantity + "#";
                }
                lblTbody.Text = tblBarcode;
                LoadStockReceivedItems(lstInventoryItemsBasket);
            }
            else
            {
                string Message = Resources.StockReceived_ClientDisplay.StockReceived_BarcodeMapping_aspx_13;
                if (Message == null)
                {
                    Message="No Matching Records Found!";
                }
                lblMessage.Text = Message;
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewStockReceived.aspx.cs", ex);
        }
    }
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            long orderID = Convert.ToInt64(hdnApproveStockReceived.Value);
            string status = StockOutFlowStatus.Approved;
            lstInventoryItemsBasket = GetReceivedItems();
            returnCode = inventoryBL.UpdateReceivedInventoryApproval("StockReceive", lstInventoryItemsBasket, orderID, status, LID, OrgID, ILocationID);
            if (returnCode == 0)
            {
                LoadDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewStockReceived.aspx", ex);
        }
    }

    public List<InventoryItemsBasket> GetReceivedItems()
    {
        foreach (GridViewRow row in grdResult.Rows)
        {
            InventoryItemsBasket newBasket = new InventoryItemsBasket();
            newBasket.ID = Int64.Parse(((HiddenField)row.FindControl("hdnRid")).Value);
            newBasket.ProductID = Convert.ToInt64(((HiddenField)row.FindControl("hdnProductId")).Value);
            newBasket.BatchNo = ((HiddenField)row.FindControl("hdnBatchNo")).Value;
            newBasket.Rate = Convert.ToDecimal(((TextBox)row.FindControl("txtSellingPrice")).Text);
            newBasket.ExpiryDate = DateTimeNow;
            newBasket.Manufacture = DateTimeNow;
            lstInventoryItemsBasket.Add(newBasket);

        }
        return lstInventoryItemsBasket;
    }

    public void LoadStockReceivedItems(List<InventoryItemsBasket> lstIIB)
    {
        grdResult.DataSource = lstIIB;
        grdResult.DataBind();

    }
    protected void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
         
            //lblTotaltax.Text = String.Format("{0:0.00}", TaxAmt);
        }
    }


    protected static string GetDate(object dataItem)
    {
        if (dataItem.ToString() == "Jan-1753")
            return "**";

        return dataItem.ToString();
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"~/InventoryCommon/InventorySearch.aspx?ACN=" + strACN, true);
            }
            Response.Redirect("~/InventoryCommon/InventorySearch.aspx");

        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }
    protected void btnInvoice_Click(object sender, EventArgs e)
    {

        string url = Request.ApplicationPath + @"/StockReceived/MatchingViewStockReceived.aspx?isPopup=Y&ID=" + hdnApproveStockReceived.Value;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDivs", "javascript:ReportPopUP('" + url + "');", true);
        //btnInvoice.OnClientClick = "ReportPopUP('" + url + "');";        
    }
}


