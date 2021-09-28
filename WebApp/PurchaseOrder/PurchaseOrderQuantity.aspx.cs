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
using Attune.Kernel.PlatForm.Common;
using Attune.Kernel.PurchaseOrder.BL;
using System.Web.Script.Serialization;

public partial class PurchaseOrder_PurchaseOrderQuantity : Attune_BasePage
{
    public PurchaseOrder_PurchaseOrderQuantity()
        : base("PurchaseOrder_PurchaseOrderQuantity_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    InventoryCommon_BL inventoryBL;
    PurchaseOrder_BL PurchaseOrder_BL;
    List<Users> lstUsers = new List<Users>();
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstCollectedItemsBasket = new List<InventoryItemsBasket>();
    List<InventoryUOM> lstInventoryUOM = new List<InventoryUOM>();
    List<InventoryItemsBasket> lstInventoryItemsBasket2 = new List<InventoryItemsBasket>();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
           
            //tdPORecd.Attributes.Add("display", "block");
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("POs_Display_In_Child", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    tdPORecd.Visible = true;
                }
                //if (lstInventoryConfig[0].ConfigValue == "N")
                //{
                //    tdPORecd.Visible = false;
                //}
            }

            if (Request.QueryString["ID"] != null && Request.QueryString["Edit"] == null)
            {
                string poNO = string.Empty;
                poNO = Request.QueryString["ID"];
                LoadPurchaseOrder(poNO);
                lnkAddMore.PostBackUrl = "PurchaseOrder.aspx?addMore=Y&ID=" + poNO;

                if (Request.QueryString["ACN"] != null)
                {
                    lnkAddMore.PostBackUrl = "PurchaseOrder.aspx?addMore=Y&ID=" + poNO + "&ACN=" + Request.QueryString["ACN"];
                }

               
                
            }
            if (Request.QueryString["copo"] != null)
            {
                string poNO = string.Empty;
                poNO = Request.QueryString["copo"];
                LoadPurchaseOrder(poNO);
                lnkAddMore.PostBackUrl = "PurchaseOrder.aspx?addMore=Y";
                if (Request.QueryString["ACN"] != null)
                {
                    lnkAddMore.PostBackUrl = "PurchaseOrder.aspx?addMore=Y&ACN=" + Request.QueryString["ACN"];
                }

            }

            if (Request.QueryString["ID"] != null && Request.QueryString["Edit"] == "Y")
            {
                trApproveBlock.Attributes.Add("class", "show");
                tprint.Attributes.Add("class", "hide");
                LoadPODetails();
            }
            else
            {
                LoadPODetails();
            }
            LoadSuppliers();
            ddlSupplierList.SelectedValue = hdnSName.Value;
            if (Request.QueryString["ID"] != null && Request.QueryString["Edit"] == null)
            {
               // LoadConfig();
                LoadPurchaseOrderItems(lstInventoryItemsBasket2);
            }
            else 
            {
                LoadConfig();
            }
            SetSuppliersDEtails();
            hdnLocationId.Value = InventoryLocationID.ToString();
            hdnOrgAddressID.Value = ILocationID.ToString();
            hdnOrgId.Value = OrgID.ToString();
        }
    }

    private void LoadPODetails()
    {
        try
        {
            string iib = ((HiddenField)PreviousPage.FindControl("iconHid")).Value;
            hdnPurchaseOrderItems.Value = iib;
            TextBox txtPoDate = (TextBox)PreviousPage.FindControl("txtPurchaseOrderDate");
            DropDownList ddlSName = (DropDownList)PreviousPage.FindControl("ddlSupplierList");
            TextBox txtComments = (TextBox)PreviousPage.FindControl("txtComments");
            hdnPoDate.Value = txtPoDate.Text;// +" " + DateTimeUtility.GetServerDate().ToString("HH:mm:ss");
            hdnSName.Value = ddlSName.SelectedValue;
            hdnComments.Value = txtComments.Text;
            if (Request.QueryString["ID"] != null && Request.QueryString["Edit"] != null)
            {
                lnkAddMore.PostBackUrl = "PurchaseOrder.aspx?addMore=Y&ID=" + Request.QueryString["ID"];
            }
            else
            {
                lnkAddMore.PostBackUrl = "PurchaseOrder.aspx?addMore=Y";
            }
            if (!string.IsNullOrEmpty(iib))
            {
                lstInventoryItemsBasket2 = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(iib);
            }
            /* foreach (string splitString in iib.Split('^'))
             {
                 if (splitString != string.Empty)
                 {
                     InventoryItemsBasket obj = new InventoryItemsBasket();

                     string[] lineItems = splitString.Split('~');

                     if (lineItems.Length > 0)
                     {
                         obj.ProductID = Convert.ToInt64(lineItems[0]);
                         obj.ProductName = lineItems[1];
                         obj.CategoryID = Convert.ToInt32(lineItems[2]);
                         obj.Quantity = Convert.ToDecimal(lineItems[3]);
                         obj.Description = lineItems[4];
                         obj.Unit = lineItems[5];
                         obj.CategoryName = lineItems[7];
                         obj.ID = Int64.Parse(lineItems[8]);
                         obj.BatchNo = lineItems[6];
						 obj.Discount = Convert.ToDecimal(lineItems[9]);
                        obj.Amount = Convert.ToDecimal(lineItems[10]);
                        obj.Tax = Convert.ToDecimal(lineItems[11]);
                        obj.ComplimentQTY = Convert.ToDecimal(lineItems[14]);
                        if (!string.IsNullOrEmpty(lineItems[15]))
                        {
                            obj.PurchaseTax = Convert.ToDecimal(lineItems[15]);
                        }
                         lstInventoryItemsBasket2.Add(obj);
                     }
                 }
             }*/
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }

    }

    public void LoadPurchaseOrder(string poNO)
    {
        try
        {
            string approval = string.Empty;
            approval = Request.QueryString["Approve"];
            inventoryBL.GetPurchaseOrderDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstPurchaseOrders, out lstProductCategories, out lstInventoryItemsBasket);

            List<InventoryItemsBasket> iChildCat = (from i in lstInventoryItemsBasket
                                                    group i by new { i.ProductID, i.Quantity, i.Unit, i.ID, i.ProductName,
                                                        i.CategoryName, i.CategoryID, i.LocationID, i.LocationName, i.Description, i.Discount, i.Amount, 
                                                        i.Tax, i.Rate, i.UnitSellingPrice,i.ComplimentQTY,i.PurchaseTax  } into g

                                                        select new InventoryItemsBasket
                                                        {
                                                            ProductID = g.Key.ProductID,
                                                            ProductName = g.Key.ProductName,
                                                            Unit=g.Key.Unit,
                                                            ID=g.Key.ID,
                                                            Quantity=g.Key.Quantity,
                                                            CategoryID=g.Key.CategoryID,
                                                            CategoryName=g.Key.CategoryName,
                                                            LocationID = g.Key.LocationID,
                                                            LocationName = g.Key.LocationName,
                                                        Description = g.Key.Description,
                                                        Discount = g.Key.Discount,
                                                        Amount = g.Key.Amount,
                                                        Tax = g.Key.Tax,
                                                        Rate = g.Key.Rate,
                                                        UnitSellingPrice = g.Key.UnitSellingPrice,
                                                        ComplimentQTY=g.Key.ComplimentQTY,
														PurchaseTax=g.Key.PurchaseTax
                                                        }).Distinct().ToList();
            lstInventoryItemsBasket = iChildCat.ToList();
            
            
            List<InventoryItemsBasket> iChildCat2 = (from i in lstInventoryItemsBasket
                                                     group i by new { i.ProductID, i.Quantity, i.Unit, i.ID, i.ProductName, i.CategoryName, i.CategoryID, 
                                                         i.Discount, i.Amount, i.Tax, i.Rate, i.UnitSellingPrice,i.ComplimentQTY, i.PurchaseTax } into g

                                                    select new InventoryItemsBasket
                                                    {
                                                        ProductID = g.Key.ProductID,
                                                        ProductName = g.Key.ProductName,
                                                        Unit = g.Key.Unit,
                                                        ID = g.Key.ID,
                                                        Quantity = g.Key.Quantity,
                                                        CategoryID = g.Key.CategoryID,
                                                        CategoryName = g.Key.CategoryName,
                                                         Description = Convert.ToString(g.Sum(p => Convert.ToDecimal(p.Description))),
                                                         Discount = g.Key.Discount,
                                                         Amount = g.Key.Amount,
                                                         Tax = g.Key.Tax,
                                                         Rate = g.Key.Rate,
                                                         UnitSellingPrice = g.Key.UnitSellingPrice,
                                                         ComplimentQTY=g.Key.ComplimentQTY,
														 PurchaseTax=g.Key.PurchaseTax
                                                    }).Distinct().ToList();
            lstInventoryItemsBasket2 = iChildCat2.ToList();
            LoadProductList(lstInventoryItemsBasket2);
            hdnPoDate.Value = lstPurchaseOrders[0].PurchaseOrderDate.ToString();
            hdnSName.Value = lstSuppliers[0].SupplierID.ToString();
            hdnComments.Value = lstPurchaseOrders[0].Comments;
            if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Pending && approval == "1")
            {
                trApproveBlock.Attributes.Add("class", "show");
                tprint.Attributes.Add("class", "hide");
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }
        
    }

    public class tempclass
    {
        public long ProductID { get; set; }
        public string ProductName { get; set; }
        public int CategoryID { get; set; }
        public decimal Quantity { get; set; }
        public string Description { get; set; }
        public string Unit { get; set; }
        public string CategoryName { get; set; }
        public long ID { get; set; }
        public string IsStockReceived { get; set; }
        public decimal Discount { get; set; }
		public decimal Amount { get; set; }
		public decimal Tax { get; set; }
		public decimal PurchaseTax { get; set; }
        public decimal ComplimentQTY { get; set; }                  
				
    }
    public void LoadProductList(List<InventoryItemsBasket> lstIIB)
    {
        /* string tempProductList = "";
         foreach (InventoryItemsBasket childList in lstIIB)
         {
             if (Request.QueryString["copo"] != null)
             {
                 
                 tempProductList += childList.ProductID.ToString() + '~' +
                     childList.ProductName + '~' +
                     childList.CategoryID + '~' +
                     childList.CategoryID.ToString() + '~' +
                     childList.Quantity.ToString() + '~' +
                     childList.Description + '~' +
                     childList.Unit + '~' +
                     childList.CategoryName + '~' +
                     0 + '^';
             }
             else
             {
                 tempProductList += childList.ProductID.ToString() + '~' +
                     childList.ProductName + '~' +
                     childList.CategoryID + '~' +
                     childList.CategoryID.ToString() + '~' +
                     childList.Quantity.ToString() + '~' +
                     childList.Description + '~' +
                     childList.Unit + '~' +
                     childList.CategoryName + '~' +
                     childList.ID + '^';
             }
         }*/
        List<tempclass> lsttempclass = (from c in lstIIB
                                        select new tempclass
                                        {
                                            ProductID = c.ProductID,
                                            ProductName = c.ProductName,
                                            CategoryID = c.CategoryID,
                                            Quantity = c.Quantity,
                                            Description = c.Description,
                                            Unit = c.Unit,
                                            CategoryName = c.CategoryName,
                                            ID = c.ID,
                                            IsStockReceived="N",
											Amount=c.Amount,
											Tax=c.Tax,
											ComplimentQTY=c.ComplimentQTY,
											PurchaseTax=c.PurchaseTax
                                        }).ToList();


        hdnPurchaseOrderItems.Value = new JavaScriptSerializer().Serialize(lsttempclass); //tempProductList
    }
    string strUnit = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_10 == null ? "Unit Cost" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_10;
    string strTotal = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_11 == null ? "Total" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_11;
    string strDiscount = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_12 == null ? "Discount" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_12;
    string strSTax = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_13 == null ? "Sales Tax" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_13;
    string strTValue = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_14 == null ? "Total Value" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_14;
    string strCQty = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_15 == null ? "Comp Qty" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_15;
    string strPurTax = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_16 == null ? "Purchase Tax" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_16;
    string strSDetails = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_17 == null ? "Supplier PO Details" : Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_17;

    public void LoadPurchaseOrderItems(List<InventoryItemsBasket> lstIIB)
    {
        string ProductName = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_03;
        if (ProductName == null)
        {
            ProductName = "Product Name";
        }

        string Quantity = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_04 ;
        if (Quantity == null)
        {
            Quantity = "Quantity";
        }

        string Units = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_05;
        if (Units == null)
        {
            Units = "Unit";
        }
        string InHandQty = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_06;
        if (InHandQty == null)
        {
            InHandQty = "In Hand Qty";
        }
        inventoryBL.GetInventoryUOM(out lstInventoryUOM);
        TableRow rowH = new TableRow();
        TableCell cellH1 = new TableCell();
        TableCell cellH2 = new TableCell();
        TableCell cellH3 = new TableCell();
        TableCell cellH4 = new TableCell();
        TableCell cellH5 = new TableCell();
        TableCell cellH6 = new TableCell();
        TableCell cellH7 = new TableCell();
        TableCell cellH8 = new TableCell();
        TableCell cellH9 = new TableCell();
        TableCell cellH10 = new TableCell();
        TableCell cellH11 = new TableCell();
        TableCell cellH12 = new TableCell();
        cellH1.Attributes.Add("class", "a-left");
        cellH1.Text = ProductName;
        cellH1.Width = Unit.Percentage(25);
        cellH2.Attributes.Add("class", "a-right");
        cellH2.Text = Quantity;
        cellH2.Width = Unit.Percentage(9);
        cellH3.Attributes.Add("class", "a-center");
        cellH3.Text = Units;
        cellH3.Width = Unit.Percentage(13);
        cellH4.Attributes.Add("class", "a-center");
        
        cellH4.Text = InHandQty;
        //end
        cellH4.Width = Unit.Percentage(20);
        cellH5.Attributes.Add("align", "center");
        cellH5.Text = strUnit;
        cellH6.Attributes.Add("align", "center");
        cellH6.Text = strTotal;
        cellH7.Attributes.Add("align", "center");
        cellH7.Text = strDiscount + " (%)";
        cellH8.Attributes.Add("class", "a-right hide");
        cellH8.Text = strSTax + " (%)";
        cellH9.Attributes.Add("align", "center");
        cellH9.Text = strTValue;
        cellH10.Attributes.Add("align", "center");
        cellH10.Text = strCQty;
            cellH11.Attributes.Add("align", "center");
            cellH11.Text = strPurTax + " (%)";
            cellH12.Attributes.Add("align", "center");
            cellH12.Text = strSDetails;
        
        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellH2);
        rowH.Cells.Add(cellH3);
        rowH.Cells.Add(cellH5);
        rowH.Cells.Add(cellH6);
        rowH.Cells.Add(cellH7);
        rowH.Cells.Add(cellH8);
        rowH.Cells.Add(cellH9);
        rowH.Cells.Add(cellH10);
rowH.Cells.Add(cellH11);
rowH.Cells.Add(cellH12);
		//rowH.Cells.Add(cellH4);
		 
        //rowH.Font.Bold = true;
        //rowH.Font.Underline = true;
        //rowH.Style.Add("color", "#333");
        rowH.Attributes.Add("class","gridHeader");
        purchaseOrderDetailsTab.Rows.Add(rowH);
        Label lblTotal = new Label();
        lblTotal.ID = "lblTotal";
        TableRow row3 = new TableRow();
        TableCell cell13 = new TableCell();//Total value alignment v28 jeni
        row3.Cells.Add(cell13);
        foreach (InventoryItemsBasket childList in lstIIB)
        {

            TableRow row2 = new TableRow();

            TextBox txtBoxQ = new TextBox();
            TextBox txtBoxR = new TextBox();
            TextBox txtBoxC = new TextBox();
            DropDownList ddlBoxU = new DropDownList();
            TextBox txtBoxDis = new TextBox();
            TextBox txtBoxT = new TextBox();
            HiddenField hdnID = new HiddenField();
            HiddenField hdnbatch = new HiddenField();
            HiddenField hdnInHand = new HiddenField();
            Label lbltot = new Label();
            Label lbltota = new Label();
            TextBox txtBoxCQ = new TextBox();
            TextBox txtPT = new TextBox();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    TableCell cell6 = new TableCell();
                    TableCell cell7 = new TableCell();
            TableCell cell8 = new TableCell();
            TableCell cell9 = new TableCell();
            TableCell cell10 = new TableCell();
            TableCell cell11 = new TableCell();
            TableCell cell12 = new TableCell();
            //TableCell cell13 = new TableCell();
            TableCell cell14 = new TableCell();
            TableCell cell15 = new TableCell();

            TableCell cell16 = new TableCell();
            cell16.Width = Unit.Percentage(13);
            LinkButton lnkSupplierList = new LinkButton();//sathish
            lnkSupplierList.PostBackUrl = "#";
            lnkSupplierList.Text="Supplier List";
            lnkSupplierList.Attributes.Add("class", "lnkBtn");
			 lnkSupplierList.Attributes.Add("onclick", "return SupplierList('" + childList.ProductID + "');");
                    cell1.Attributes.Add("onmouseover", "this.className='colornw'; showLocationdetails('" + childList.ProductID +"' );");
            cell16.Controls.Add(lnkSupplierList);
            
            lbltot.ID = "TC" + childList.ProductID.ToString();
            lbltota.ID = "TA" + childList.ProductID.ToString();
            if (childList.Rate != null)
                lbltot.Text =Convert.ToString(childList.Rate);
            if(Convert.ToDecimal(childList.UnitSellingPrice).ToString()!="")
                lbltota.Text = Convert.ToString(childList.UnitSellingPrice);
            cell1.Attributes.Add("align", "left");
                    cell1.Text = childList.ProductName;
                    cell1.Attributes.Add("onmouseout", "hideshowLocationdetails();");
                    cell2.Attributes.Add("class", "a-right");
                    txtBoxQ.ID = "Q" + childList.ProductID.ToString();
                    cell2.Controls.Add(txtBoxQ);
                    txtBoxQ.Attributes.Add("onblur", "return Calc();");//shift+tab issue v28 jeni
                    //txtBoxQ.Attributes.Add("onblur", "javascript:checkIsEmpty(this.id);");
                    txtBoxQ.Attributes.Add("onKeyPress", "return ValidateSpecialAndNumeric(this);");
                    txtBoxQ.Attributes.Add("class", "w-80");
                    txtBoxQ.Attributes.Add("class", "w-75 a-right");
                    txtBoxQ.Text = (Convert.ToDouble(childList.Quantity)).ToString("N", System.Threading.Thread.CurrentThread.CurrentUICulture);
                    cell2.Width = Unit.Percentage(9);
                    ddlBoxU.ID = "U" + childList.ProductID.ToString();
                    ddlBoxU.DataSource = lstInventoryUOM;
                    ddlBoxU.DataTextField = "UOMCode";
                    ddlBoxU.DataValueField = "UOMCode";
                    ddlBoxU.DataBind();
            
                    ListItem ddlselect = GetMetaData("Select", "0");
                    if (ddlselect == null)
                    {
                        ddlselect = new ListItem() { Text = "Select", Value = "0" };
                    }
                   /*ddlBoxU.Items.Insert(0, ddlselect);
                     ddlBoxU.Items.Insert(0, GetMetaData("Select", "0"));
                     end
                     ddlBoxU.Items[0].Value = "0";*/
                    if (childList.Unit != "")
                    {
                        if (childList.Unit == "0")
                        {
                            ddlBoxU.Items.Insert(0, GetMetaData("Select", "0"));
                        }
                        else
                        {
                            ddlBoxU.SelectedValue = childList.Unit;
                        }                        
                    }
                    ddlBoxU.Attributes.Add("class", "w-120");
                    cell3.Controls.Add(ddlBoxU);
                    cell4.Attributes.Add("class", "a-center");
                    cell4.Text = childList.Description.ToString();
                    cell4.Width = Unit.Percentage(30);
                    cell4.Attributes.Add("class", "hide");
                    hdnID.ID = "ID" + childList.ProductID.ToString();
                    hdnID.Value = childList.ProductID.ToString();
                    if (childList.ID != 0)
                    {
                        if (Request.QueryString["copo"] != null)
                        {
                            hdnID.Value = "0";
                        }
                        else
                        {
                            hdnID.Value = childList.ID.ToString();
                        }
                        
                    }
                    
                    cell5.Controls.Add(hdnID);
                    cell6.Width = Unit.Percentage(3);
                    hdnbatch.ID = "BAT" + childList.ProductID.ToString();
                    hdnbatch.Value = childList.BatchNo.ToString();
                    cell6.Controls.Add(hdnbatch);
                    hdnInHand.ID = "INH" + childList.ProductID.ToString();
                    hdnInHand.Value = childList.Description.ToString();
                    cell7.Controls.Add(hdnInHand);
            cell8.Attributes.Add("align", "center");
            txtBoxC.ID = "C" + childList.ProductID.ToString();
            cell8.Controls.Add(txtBoxC);
            txtBoxC.Attributes.Add("onblur", "return TotalCalc();");// if (checkIsEmpty(this.id))
           // txtBoxC.Attributes.Add("onKeyDown", "return validateNaN(event);");
            txtBoxC.Style.Add("width", "50px");
            txtBoxC.Style.Add("text-align", "right");
            txtBoxC.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Amount));
            cell8.Width = Unit.Percentage(8);
            cell9.Attributes.Add("align", "right");
            cell9.Controls.Add(lbltot);
            cell10.Attributes.Add("align", "center");
            txtBoxDis.ID = "DIS" + childList.ProductID.ToString();
            cell10.Controls.Add(txtBoxDis);
            txtBoxDis.Attributes.Add("onblur", "return TotalCalc();"); //if (checkIsEmpty(this.id))
           // txtBoxDis.Attributes.Add("onKeyDown", "return validateNaN(event);");
            txtBoxDis.Style.Add("width", "50px");
            txtBoxDis.Style.Add("text-align", "right");
            txtBoxDis.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Discount));
            cell10.Width = Unit.Percentage(8);
            cell11.Attributes.Add("class", "a-right hide");
            txtBoxT.ID = "T" + childList.ProductID.ToString();
            cell11.Controls.Add(txtBoxT);
            txtBoxT.Attributes.Add("onblur", "return TotalCalc();"); //if (checkIsEmpty(this.id))
          //  txtBoxT.Attributes.Add("onKeyDown", "return validateNaN(event);");
            txtBoxT.Style.Add("width", "50px");
            txtBoxT.Style.Add("text-align", "right");
            txtBoxT.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Tax));
            cell11.Width = Unit.Percentage(8);
            cell12.Attributes.Add("align", "right");
            cell12.Controls.Add(lbltota);


            cell13.ColumnSpan = 10;
            cell13.Controls.Add(lblTotal);
            cell13.Width = Unit.Percentage(100);
			cell13.Style.Add("text-align", "right");
            //Added by Jlp
            cell14.Attributes.Add("align", "right");
            txtBoxCQ.ID = "CQ" + childList.ProductID.ToString();
            cell14.Controls.Add(txtBoxCQ);
            txtBoxCQ.Attributes.Add("onblur", "if(checkIsEmpty(this.id))  return TotalCalc();");
            txtBoxCQ.Attributes.Add("onKeyDown", "return validateNaN(event);");
            txtBoxCQ.Style.Add("width", "50px");
            txtBoxCQ.Style.Add("text-align", "right");
            txtBoxCQ.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.ComplimentQTY));
            cell14.Width = Unit.Percentage(8);
            
                cell15.Attributes.Add("align", "center");
                txtPT.ID = "PT" + childList.ProductID.ToString();
                cell15.Controls.Add(txtPT);

                txtPT.Attributes.Add("onblur", "if(checkIsEmpty(this.id))  return TotalCalc();");
                //txtPT.Attributes.Add("onKeyDown", "return validateNaN(event);");
                txtPT.Style.Add("width", "50px");
                txtPT.Style.Add("text-align", "right");
                txtPT.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.PurchaseTax));
            row2.Cells.Add(cell1);
            row2.Cells.Add(cell2);
            row2.Cells.Add(cell3);
            row2.Cells.Add(cell8);
            row2.Cells.Add(cell9);
            row2.Cells.Add(cell10);
            row2.Cells.Add(cell11);
            row2.Cells.Add(cell12);
            
            row2.Cells.Add(cell14);
            
                row2.Cells.Add(cell15);
            //if (Request.QueryString["ID"] != null)
            //{
                row2.Cells.Add(cell4);
            //}
            row2.Cells.Add(cell16);
            row2.Cells.Add(cell5);
            row2.Cells.Add(cell6);
            row2.Cells.Add(cell7);
                    cell5.Attributes.Add("class", "hide");
                    cell6.Attributes.Add("class", "hide");
                    cell7.Attributes.Add("class", "hide");
                    row2.Font.Bold = false;
                    row2.Style.Add("color", "#000000");
                    if (row2.Cells.Count == 7)
                    {
                                 
                        string strtemp = GetToolTip(childList.ProductID);
                        row2.Cells[3].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                        //row2.Cells[3].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                        row2.Cells[3].Attributes.Add("onmouseout", "hideTooltip();");
                        row2.Cells[3].Attributes.Add("color", "att");
                    }
                    purchaseOrderDetailsTab.Rows.Add(row2);

                              
        }
        purchaseOrderDetailsTab.Rows.Add(row3);
    }
    private string GetToolTip(long ProductID)
    {
        List<InventoryItemsBasket> lsttemp = new List<InventoryItemsBasket>();
        lsttemp = lstInventoryItemsBasket.FindAll(p =>p.ProductID==ProductID);
        IEnumerable<InventoryItemsBasket> iChild1 = ( from c in lstInventoryItemsBasket
                                                      where c.ProductID==ProductID
                                                     group c by new
                                                     {
                                                         c.LocationID,
                                                         c.LocationName,
                                                         c.ProductID
                                                     } into g
                                                     select new InventoryItemsBasket
                                                     {
                                                         LocationID = g.Key.LocationID,
                                                         LocationName = g.Key.LocationName,
                                                         Description=Convert.ToString(g.Sum(p => Convert.ToDecimal(p.Description)))
                                                     }).Distinct().ToList();
        List<InventoryItemsBasket> lstIIB=new List<InventoryItemsBasket>();
        lstIIB = iChild1.ToList();
        
        string TableHead = "";
        string TableDate = "";

        string LocationId = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_07;
        if (LocationId == null)
        {
            LocationId = "Location Id";
        }
        string LocationName = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_08;
        if (LocationName == null)
        {
            LocationName = "Location Name";
        }
        string InHandQuantity = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_PurchaseOrderQuantity_aspx_09;
        if (InHandQuantity == null)
        {
            InHandQuantity = "InHand Quantity";
        }
        TableHead = "<table border=\"1\" cellpadding=\"2\"cellspacing=\"2\"><tr style=\"font-weight: bold;\"><td>LocationId</td><td>LocationName</td><td>InHandQuantity</td></tr>";
        foreach (InventoryItemsBasket item in lstIIB)
        {
            TableDate += "<tr>  <td>" + item.LocationID.ToString() + "</td><td>" + item.LocationName + "</td><td>" + item.Description + "</td></tr>";
        }

        return TableHead + TableDate + "</table> ";
    }
    protected void btnGeneratePO_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        string pPONo = string.Empty;
        try
        {
            PurchaseOrders objPO = new PurchaseOrders();
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            objPO.PurchaseOrderDate = Convert.ToDateTime(hdnPoDate.Value);
            objPO.OrgID = OrgID;
            objPO.SupplierID = Convert.ToInt32(hdnSName.Value);
            objPO.CreatedBy = LID;
            objPO.PurchaseOrderNo = "N";
            //if (ChkIsPODisplay.Checked)
            //{
            //    objPO.PurchaseOrderNo = "Y";
            //}
            objPO.OrgAddressID = ILocationID;
            objPO.LocationID = InventoryLocationID;
            objPO.Comments = hdnComments.Value;
            objPO.Status = StockOutFlowStatus.Pending;
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_PO_Approval", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    if (RoleHelper.Admin==RoleName || RoleHelper.InventoryAdmin==RoleName)
                        objPO.Status = StockOutFlowStatus.Approved;
                    else
                        objPO.Status = StockOutFlowStatus.Pending;
                }
                else
                {
                    objPO.Status = StockOutFlowStatus.Approved;
                }
            }
            
            if (Request.QueryString["ID"] != null)
            {
                if (Request.QueryString["ID"] != "ipo")
                {
                    objPO.PurchaseOrderID = Int64.Parse(Request.QueryString["ID"]);
                }
            }
            lstInventoryItemsBasket = GetCollectedItems(); 
            returnCode = new PurchaseOrder_BL(base.ContextInfo).SavePurchaseOrderDetails(objPO, lstInventoryItemsBasket,out pPONo);
            if (returnCode == 0)
            {
                string status = StockOutFlowStatus.Approved;
                returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", objPO.PurchaseOrderID, status, LID, OrgID, ILocationID);

                if (returnCode == 0)
                {
                    if (Request.QueryString["ACN"] != null)
                    {
                        string strACN = Request.QueryString["ACN"];
                        Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + pPONo + "&ACN="+strACN, true);

                    }
                    Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + pPONo + "", true);
                }
                else
                {
                    //ErrorDisplay1.ShowError = true;
                    //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
                    return;
                }
            }
            
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Purchase Order Details.", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
   
    public List<InventoryItemsBasket> GetCollectedItems()
    {
        if (!string.IsNullOrEmpty(hdnPurchaseOrderItems.Value))
        {
            lstCollectedItemsBasket = new JavaScriptSerializer().Deserialize<List<InventoryItemsBasket>>(hdnPurchaseOrderItems.Value);
            lstCollectedItemsBasket.ForEach(p => p.ExpiryDate = DateTimeNow);
            lstCollectedItemsBasket.ForEach(p => p.Manufacture = DateTimeNow);
        }
        /* string[] list=hdnPurchaseOrderItems.Value.Split('^');
         foreach (string listParent in list)
         {
             if (listParent != "")
             {
                 InventoryItemsBasket newBasket = new InventoryItemsBasket();
                 string[] listChild = listParent.Split('~');
                 newBasket.ProductID = Convert.ToInt64(listChild[0]);
                 newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                 newBasket.Description = listChild[4].ToString();
                 newBasket.Unit = listChild[5].ToString();
                
                 newBasket.ExpiryDate = DateTimeNow;
                 newBasket.Manufacture = DateTimeNow;
                 //end
                 newBasket.ID = Int64.Parse(listChild[8]);
                 lstCollectedItemsBasket.Add(newBasket);
             }
         }*/
        return lstCollectedItemsBasket;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Attune_Navigation navigation = new Attune_Navigation();
            Role role = new Role();
            role.RoleID = RoleID;
            List<Role> userRoles = new List<Role>();
            userRoles.Add(role);
            string relPagePath = string.Empty;
            long returnCode = -1;
            returnCode = navigation.GetLandingPage(userRoles, out relPagePath);

            if (returnCode == 0)
            {
                Response.Redirect(Request.ApplicationPath + relPagePath, true);
            }
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

    protected void btnCancelPO_Click(object sender, EventArgs e)
    {
        try
        {
            long returnCode = -1;
            long orderID=0;
            if (Request.QueryString["ID"] != null)
            {
                orderID = Int64.Parse(Request.QueryString["ID"]);
            }
            string status = StockOutFlowStatus.Cancelled;
            returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID, ILocationID);

            if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + orderID + "&ACN=" + strACN, true);

            }

            Response.Redirect(@"../PurchaseOrder/ViewPurchaseOrder.aspx?sID=" + Convert.ToInt32(hdnSName.Value) + "&ID=" + orderID + "", true);


        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
            //ErrorDisplay1.ShowError = true;
            //ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    
    protected void ddlSupplierList_SelectedIndexChanged(object sender, EventArgs e)
    {
        SetSuppliersDEtails();

    }

    private void SetSuppliersDEtails()
    {
        inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);
        var Detalis = from Supplier in lstSuppliers
                      where Supplier.SupplierID == int.Parse(ddlSupplierList.SelectedValue)
                      select Supplier;
        divSupplier.Visible = false;
        foreach (var childList in Detalis)
        {
            divSupplier.Visible = true;
            if (childList.Address2 != string.Empty)
            {
                lblVendorAddress.Text = childList.Address1 + "," + childList.Address2;
            }
            else
            {
                lblVendorAddress.Text = childList.Address1;
            }
            hdnSName.Value = childList.SupplierID.ToString();
            lblVendorCity.Text = childList.City;
            lblVendorPhone.Text = childList.Phone;
            lblEmailID.Text = childList.EmailID;

        }
    }
    
    private void LoadSuppliers()
    {
        try
        {
            inventoryBL.GetSupplierList(OrgID, ILocationID, out lstSuppliers);

            ddlSupplierList.DataSource = lstSuppliers;
            ddlSupplierList.DataTextField = "SupplierName";
            ddlSupplierList.DataValueField = "SupplierID";
            ddlSupplierList.DataBind();
            
            ListItem ddlselect = GetMetaData("Select", "0");
            if (ddlselect == null)
            {
                ddlselect = new ListItem() { Text = "Select", Value = "0" };
            }
            ddlSupplierList.Items.Insert(0, ddlselect);
           // ddlSupplierList.Items.Insert(0, GetMetaData("Select", "0"));
            //end
            ddlSupplierList.Items[0].Value = "0";

        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error While loading Suppliers Details", Ex);
        }

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
            Response.Redirect(@"~/InventoryCommon/InventorySearch.aspx", true);
            
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

  
    private void LoadPreviousDetails()
    {
        try
        {
            PurchaseOrder_BL = new PurchaseOrder_BL(base.ContextInfo);
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            List<PurchaseRequestDetails> lstProduct = new List<PurchaseRequestDetails>();
            List<InventoryItemsBasket> lstInventory = new List<InventoryItemsBasket>();

            string iib = ((HiddenField)PreviousPage.FindControl("iconHid")).Value;

            if(!string.IsNullOrEmpty(iib))
            {
                lstProduct = new JavaScriptSerializer().Deserialize<List<PurchaseRequestDetails>>(iib);
                

                lstProduct = lstProduct.Select(c => { c.OrgID = OrgID; c.SupplierID = Convert.ToInt64(ddlSupplierList.SelectedValue); return c; }).ToList();
                        
                    
                
            }
           /* foreach (string splitString in iib.Split('^'))
            {
                if (splitString != string.Empty)
                {
                    PurchaseRequestDetails obj = new PurchaseRequestDetails();
                    string[] lineItems = splitString.Split('~');

                    if (lineItems.Length > 0)
                    {
                        obj.ProductID = Convert.ToInt64(lineItems[0]);
                        obj.SupplierID = Convert.ToInt64(ddlSupplierList.SelectedValue);
                        obj.OrgID = OrgID;
                        if (lineItems[3] != "0.00")
                        {
                            obj.Quantity = Convert.ToInt64(Convert.ToDecimal((lineItems[3].ToString())));
                        }
                        else
                        { obj.Quantity = 0; }
                        obj.Description = lineItems[4];
                        obj.Unit = lineItems[5];
                        obj.CategoryName = lineItems[7];
                        obj.Discount = Convert.ToDecimal(lineItems[9]);
                        obj.UnitPrice = Convert.ToDecimal(lineItems[10]);
                        obj.Tax = Convert.ToDecimal(lineItems[11]);
                        obj.ComplimentQTY =  Convert.ToDecimal(lineItems[14]);
                        obj.PurchaseTax = Convert.ToDecimal(lineItems[15]);
                        lstProduct.Add(obj);
                    }
                }
            }*/

            //inventoryBL = new Inventory_BL(base.ContextInfo);
            //inventoryBL.GetProductPurchaseOrderDetails(OrgID, ILocationID, lstProduct, out lstInventory);
            PurchaseOrder_BL = new PurchaseOrder_BL(base.ContextInfo);
            PurchaseOrder_BL.GetProductPurchaseOrderDetails(OrgID, ILocationID, lstProduct, out lstInventory);
            #region
            if (lstInventory.Count > 0)
            {
                inventoryBL.GetInventoryUOM(out lstInventoryUOM);
                TableRow rowH = new TableRow();
                TableCell cellH1 = new TableCell();
                TableCell cellH2 = new TableCell();
                TableCell cellH3 = new TableCell();
                TableCell cellH4 = new TableCell();
                TableCell cellH5 = new TableCell();
                TableCell cellH6 = new TableCell();
                TableCell cellH7 = new TableCell();
                TableCell cellH8 = new TableCell();
                TableCell cellH9 = new TableCell();
                TableCell cellH10 = new TableCell();//jlp
                TableCell cellH11 = new TableCell();
                TableCell cellH13 = new TableCell();
                cellH1.Attributes.Add("align", "left");
                cellH1.Text = "Product Name";
                cellH2.Attributes.Add("align", "right");
                cellH2.Text = "Quantity";
                cellH2.Width = Unit.Percentage(9);
                cellH3.Attributes.Add("align", "Center");
                cellH3.Text = "Unit";
                cellH3.Width = Unit.Percentage(8);
                cellH4.Attributes.Add("align", "Center");
                cellH4.Text = "In Hand Qty";
                cellH4.Width = Unit.Percentage(18);
                cellH4.Attributes.Add("class", "hide");
                
                cellH5.Attributes.Add("align", "center");
                cellH5.Text = "Unit Cost";
                cellH6.Attributes.Add("align", "center");
                cellH6.Text = "Total";
                cellH7.Attributes.Add("align", "center");
                cellH7.Text = "Discount(%)";
                cellH8.Attributes.Add("class", "a-right hide");
                cellH8.Text = "Tax(%)";
                cellH9.Attributes.Add("align", "center");
                cellH9.Text = "Total Value";
                cellH10.Attributes.Add("align", "center");
                cellH10.Text = "Comp Qty";
                cellH10.Width = Unit.Percentage(8);

                
                    cellH11.Attributes.Add("align", "center");
                    cellH11.Text = "Purchase Tax(%)";
                    cellH13.Text = "Supplier PO Details";
                rowH.Cells.Add(cellH1);
                rowH.Cells.Add(cellH2);
                rowH.Cells.Add(cellH3);
                rowH.Cells.Add(cellH5);
                rowH.Cells.Add(cellH6);
                rowH.Cells.Add(cellH7);
                rowH.Cells.Add(cellH8);
                rowH.Cells.Add(cellH9);
                rowH.Cells.Add(cellH10);
                
                    rowH.Cells.Add(cellH11);
                    rowH.Cells.Add(cellH13);
                //if (Request.QueryString["ID"] != null)
                //{
                    rowH.Cells.Add(cellH4);
                
               // }
                rowH.Font.Bold = true;
                rowH.Font.Underline = true;
                rowH.Style.Add("color", "#333");
                purchaseOrderDetailsTab.Rows.Add(rowH);
                Label lblTotal = new Label();
                lblTotal.ID = "lblTotal";
                TableRow row3 = new TableRow();
                TableCell cell13 = new TableCell();
                foreach (InventoryItemsBasket childList in lstInventory)
                {

                    TableRow row2 = new TableRow();
                    
                    TextBox txtBoxQ = new TextBox();
                    TextBox txtBoxR = new TextBox();
                    TextBox txtBoxC = new TextBox();
                    DropDownList ddlBoxU = new DropDownList();
                    TextBox txtBoxDis = new TextBox();
                    TextBox txtBoxT = new TextBox();
                    HiddenField hdnID = new HiddenField();
                    HiddenField hdnbatch = new HiddenField();
                    HiddenField hdnInHand = new HiddenField();
                    Label lbltot = new Label();
                    Label lbltota = new Label();
                    TextBox txtBoxCQ = new TextBox();
                    TextBox txtPT = new TextBox();
                    TableCell cell1 = new TableCell();
                    TableCell cell2 = new TableCell();
                    TableCell cell3 = new TableCell();
                    TableCell cell4 = new TableCell();
                    TableCell cell5 = new TableCell();
                    TableCell cell6 = new TableCell();
                    TableCell cell7 = new TableCell();
                    TableCell cell8 = new TableCell();
                    TableCell cell9 = new TableCell();
                    TableCell cell10 = new TableCell();
                    TableCell cell11 = new TableCell();
                    TableCell cell12 = new TableCell();
                    
                    TableCell cell14 = new TableCell();
                    TableCell cell15 = new TableCell();

                    TableCell cell16 = new TableCell();
                    cell16.Width = Unit.Percentage(13);
                    LinkButton lnkSupplierList = new LinkButton();//sathish
                    lnkSupplierList.PostBackUrl = "#";
                    lnkSupplierList.Text = "Supplier List";
                    lnkSupplierList.Attributes.Add("class", "lnkBtn");
                    lnkSupplierList.Attributes.Add("onclick", "return SupplierList('" + childList.ProductID + "');");
                    cell1.Attributes.Add("onmouseover", "this.className='colornw'; showLocationdetails('" + childList.ProductID + "' );");
                    cell16.Controls.Add(lnkSupplierList);
                    lbltot.ID = "TC" + childList.ProductID.ToString();
                    lbltota.ID = "TA" + childList.ProductID.ToString();
                    if (childList.Rate != null)
                        lbltot.Text = Convert.ToString(childList.Rate);
                    if (Convert.ToDecimal(childList.UnitSellingPrice).ToString() != "")
                        lbltota.Text = Convert.ToString(childList.UnitSellingPrice);
                    cell1.Attributes.Add("align", "left");
                    cell1.Text = childList.ProductName;
                    cell1.Attributes.Add("onmouseout", "hideshowLocationdetails();");
                    cell2.Attributes.Add("align", "right");
                    txtBoxQ.ID = "Q" + childList.ProductID.ToString();
                    cell2.Controls.Add(txtBoxQ);
                    txtBoxQ.Attributes.Add("onblur", "return Calc();"); //if (checkIsEmpty(this.id)) 
                    txtBoxQ.Attributes.Add("onKeyDown", "return validateNaN(event);");
                    txtBoxQ.Attributes.Add("class", "w-75 a-right");
                    txtBoxQ.Style.Add("width", "50px");
                    txtBoxQ.Style.Add("text-align", "right");
                    txtBoxQ.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Quantity));
                    cell2.Width = Unit.Percentage(8);
                    ddlBoxU.ID = "U" + childList.ProductID.ToString();
                    ddlBoxU.DataSource = lstInventoryUOM;
                    ddlBoxU.DataTextField = "UOMCode";
                    ddlBoxU.DataValueField = "UOMID";
                    ddlBoxU.DataBind();
                    ddlBoxU.Items.Insert(0, "--Select--");
                    ddlBoxU.Items[0].Value = "0";
                   // if (childList.SellingUnit != "" && ddlBoxU.Items.FindByText(childList.SellingUnit)!=null)
                   // {
                        //ddlBoxU.SelectedItem.Text = childList.SellingUnit;
                       // ddlBoxU.Items.FindByText(childList.Unit).Selected = true;
                   // }
                    if (childList.SellingUnit != "")
                    {
                        if (childList.SellingUnit == "0")
                        {
                            ddlBoxU.Items.Insert(0, GetMetaData("Select", "0"));
                        }
                        else
                        {
                        ddlBoxU.SelectedItem.Text = childList.SellingUnit;
                        }
                    }
                    ddlBoxU.Style.Add("width", "75px");
                    cell3.Controls.Add(ddlBoxU);
                    cell4.Attributes.Add("align", "Center");
                    cell4.Text = childList.Description.ToString();
                    cell4.Width = Unit.Percentage(16);
                    cell4.Attributes.Add("class","hide");
                    hdnID.ID = "ID" + childList.ProductID.ToString();
                    if (childList.ID != 0)
                    {
                        if (Request.QueryString["copo"] != null)
                        {
                            hdnID.Value = "0";
                        }
                        else
                        {
                            hdnID.Value = childList.ID.ToString();
                        }
                        cell5.Controls.Add(hdnID);
                    }
                    cell6.Width = Unit.Percentage(3);
                    hdnbatch.ID = "BAT" + childList.ProductID.ToString();
                    hdnbatch.Value = childList.BatchNo.ToString();
                    cell6.Controls.Add(hdnbatch);
                    
                    hdnInHand.ID = "INH" + childList.ProductID.ToString();
                    hdnInHand.Value = childList.Description.ToString();
                    
                    cell7.Controls.Add(hdnInHand);//hiddensat
                    cell8.Attributes.Add("align", "center");
                    txtBoxC.ID = "C" + childList.ProductID.ToString();
                    cell8.Controls.Add(txtBoxC);
                    txtBoxC.Attributes.Add("onblur", "return TotalCalc();"); //if (checkIsEmpty(this.id)) 
                    // txtBoxC.Attributes.Add("onKeyDown", "return validateNaN(event);");
                    txtBoxC.Style.Add("width", "50px");
                    txtBoxC.Style.Add("text-align", "right");
                    //  txtBoxC.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Amount));
                    txtBoxC.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.UnitCostPrice));
                    cell8.Width = Unit.Percentage(8);
                    cell9.Attributes.Add("align", "right");
                    cell9.Controls.Add(lbltot);
                    cell10.Attributes.Add("align", "center");
                    txtBoxDis.ID = "DIS" + childList.ProductID.ToString();
                    cell10.Controls.Add(txtBoxDis);
                    txtBoxDis.Attributes.Add("onblur", "return TotalCalc();"); //if (checkIsEmpty(this.id))
                    // txtBoxDis.Attributes.Add("onKeyDown", "return validateNaN(event);");
                    txtBoxDis.Style.Add("width", "50px");
                    txtBoxDis.Style.Add("text-align", "right");
                    txtBoxDis.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Discount));
                    cell10.Width = Unit.Percentage(8);
                    cell11.Attributes.Add("class", "a-right hide");
                    txtBoxT.ID = "T" + childList.ProductID.ToString();
                    cell11.Controls.Add(txtBoxT);
                    txtBoxT.Attributes.Add("onblur", "return TotalCalc();"); //if (checkIsEmpty(this.id)) 
                    //  txtBoxT.Attributes.Add("onKeyDown", "return validateNaN(event);");
                    txtBoxT.Style.Add("width", "50px");
                    txtBoxT.Style.Add("text-align", "right");
                    txtBoxT.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.Tax));
                    cell11.Width = Unit.Percentage(8);
                    cell12.Attributes.Add("align", "right");
                    cell12.Controls.Add(lbltota);

                    cell13.Attributes.Add("align", "right");
                    cell13.ColumnSpan = 10;
                    cell13.Controls.Add(lblTotal);
                    cell13.Width = Unit.Percentage(30);
                    //added by jlp
                    txtBoxCQ.ID = "CQ" + childList.ProductID.ToString();
                    cell14.Controls.Add(txtBoxCQ);
                    txtBoxCQ.Attributes.Add("onblur", "return Calc();"); //if (checkIsEmpty(this.id))
                    txtBoxCQ.Attributes.Add("onKeyDown", "return validateNaN(event);");
                    txtBoxCQ.Style.Add("width", "50px");
                    txtBoxCQ.Style.Add("text-align", "right");
                    txtBoxCQ.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.ComplimentQTY));
                    cell14.Width = Unit.Percentage(8);
                        cell15.Attributes.Add("align", "center");
                        txtPT.ID = "PT" + childList.ProductID.ToString();
                        cell15.Controls.Add(txtPT);

                        txtPT.Attributes.Add("onblur", "return TotalCalc();");// if (checkIsEmpty(this.id))  
                       // txtPT.Attributes.Add("onKeyDown", "return validateNaN(event);");
                        txtPT.Style.Add("width", "50px");
                        txtPT.Style.Add("text-align", "right");
                        txtPT.Text = String.Format("{0:0.00}", Convert.ToDouble(childList.PurchaseTax));
                   
                    row2.Cells.Add(cell1);
                    row2.Cells.Add(cell2);
                    row2.Cells.Add(cell3);
                    row2.Cells.Add(cell8);
                    row2.Cells.Add(cell9);
                    row2.Cells.Add(cell10);
                    row2.Cells.Add(cell11);
                    row2.Cells.Add(cell12);
                    
                    row2.Cells.Add(cell14);
                    
                        row2.Cells.Add(cell15);
                    //if (Request.QueryString["ID"] != null)
                    //{
                        row2.Cells.Add(cell4);
                    //}
                    row2.Cells.Add(cell16);
                    row2.Cells.Add(cell5);
                    row2.Cells.Add(cell6);
                    row2.Cells.Add(cell7);
                    cell5.Attributes.Add("class", "hide");
                    cell6.Attributes.Add("class", "hide");
                    cell7.Attributes.Add("class", "hide");
                    row2.Font.Bold = false;
                    row2.Style.Add("color", "#000000");

                    if (row2.Cells.Count == 7)
                    {

                        string strtemp = GetToolTip(childList.ProductID);
                        row2.Cells[3].Attributes.Add("onmouseover", "this.className='colornw';showTooltip(event,'" + strtemp + "');return false;");
                        //row2.Cells[3].Attributes.Add("onmouseout", "this.style.color='Black';hideTooltip();");
                        row2.Cells[3].Attributes.Add("onmouseout", "hideTooltip();");
                        row2.Cells[3].Style.Add("color", "Blue");
                    }
                    purchaseOrderDetailsTab.Rows.Add(row2);
                    


                }
                row3.Cells.Add(cell13);
                purchaseOrderDetailsTab.Rows.Add(row3);


            }//raja
            #endregion
            else
            {
                LoadPurchaseOrderItems(lstInventoryItemsBasket2);
            }


        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }

    }

    protected void LoadConfig()
    {
        try
        {
            PurchaseOrder_BL = new PurchaseOrder_BL(base.ContextInfo);
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("LoadPrevProductDetails", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue == "Y")
                {
                    LoadPreviousDetails();
                }
            }
            else
            {
                LoadPurchaseOrderItems(lstInventoryItemsBasket2);
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("", ex);
        }
    }
}