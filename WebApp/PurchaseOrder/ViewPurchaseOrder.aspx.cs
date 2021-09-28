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
using System.IO;
using System.Web.UI.HtmlControls;

public partial class PurchaseOrder_ViewPurchaseOrder : Attune_BasePage
{
    public PurchaseOrder_ViewPurchaseOrder()
        : base("PurchaseOrder_ViewPurchaseOrder_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    long returnCode = -1;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<ProductCategories> lstProductCategories = new List<ProductCategories>();
    InventoryCommon_BL inventoryBL;
    List<Users> lstUsers = new List<Users>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();

    string status = "";
    string purchaseorderno;
    int purchaseorderid = 0;
    int supplierid = 0;
    int roleid = 0;
    long loginID = -1;
    string sessionid = string.Empty;
    string supplieremailid = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            LoadDetails();
            GetinvConfigDtls();
            roleid = RoleID;
            Int64.TryParse(Session["LID"].ToString(), out loginID);
            sessionid = Session.SessionID.ToString();
    if (supplieremailid != "")
            {
                string purchaseemailnotificaton = GetConfigValue("Send_Email_To_Suppliers", OrgID);
                if (purchaseemailnotificaton == "Y" && (ViewState["flag"] == null || ViewState["flag"] != "Y"))
                {
                    //email notification 
                    string strDirectory = AppDomain.CurrentDomain.BaseDirectory;
                    string pathname = strDirectory + @"\PurchaseOrder\";
                    if (System.IO.Directory.Exists(pathname))
                    {
                        // return; if allready exists then it will not create it}
                    }
                    else
                    {
                        System.IO.Directory.CreateDirectory(pathname);
                    }
                    pathname = pathname + purchaseorderno + ".pdf";
                    StringWriter sw = new StringWriter();
                    HtmlTextWriter w = new HtmlTextWriter(sw);
                    Divpo.RenderControl(w);
                    string s = sw.GetStringBuilder().ToString();
                   inventoryBL.PurchaseorderEmailnotification(loginID, OrgID, supplierid, purchaseorderno, pathname, s);
                    ViewState["flag"] = "Y";

                }
            }
        

        }

    }
    public void LoadDetails()
    {
        Role_BL headBL = new Role_BL(base.ContextInfo);
        int sID = 0;
        string poNO = string.Empty;
        string approval = string.Empty;
        sID = Convert.ToInt32(Request.QueryString["sID"]);
        poNO = Request.QueryString["ID"];
        purchaseorderid = Convert.ToInt32(Request.QueryString["ID"]);
        approval = Request.QueryString["Approve"];
        canOrder.Attributes.Add("class", "hide");
        if(Request.QueryString["can"]!=null)
        {
            canOrder.Attributes.Add("class", "displaytr");
        }
        //hypLnkPrint.NavigateUrl = "PrintPurchaseOrder.aspx?sID=" + sID + "&poNO=" + poNO + "";
        try
        {
            inventoryBL.GetPurchaseOrderDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstPurchaseOrders, out lstProductCategories, out lstInventoryItemsBasket);
            
            
            if (lstOrganization.Count > 0 && lstInventoryItemsBasket.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                lblEmail.Text = lstOrganization[0].Email;
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    lblOrgTINNo.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                }
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    lblOrgDLNo.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                }
                supplierid = lstSuppliers[0].SupplierID;
                lblVendorName.Text = lstSuppliers[0].SupplierName;
                lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                lblVendorCity.Text = lstSuppliers[0].City;
                lblVendorPhone.Text = lstSuppliers[0].Phone;
                lblVendorEmail.Text = lstSuppliers[0].EmailID;
                supplieremailid = lstSuppliers[0].EmailID;
                lblVendorContactPerson.Text = lstSuppliers[0].ContactPerson;
                lblVendorTINNo.Text = lstSuppliers[0].GSTIN;
                lblTermsconditions.Text = lstSuppliers[0].Termsconditions;
               

                if (!string.IsNullOrEmpty(lstSuppliers[0].Termsconditions))
                {
                    HtmlGenericControl htmlDiv = new HtmlGenericControl("div");
                    htmlDiv.InnerHtml = lstSuppliers[0].Termsconditions;
                    String plainText = htmlDiv.InnerText;
                    lblTermsconditions.Text = plainText;
                    tblTermsconditions.Attributes.Add("class", "displaytable");
                }
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ShowBankDetails", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    trShowBankDetails.Attributes.Add("class", "show");
                    ShowBankDetails.Text = lstInventoryConfig[0].ConfigValue;
                    ShowBankDetails.Attributes.Add("class", "displaytable");
                }

                lblPODate.Text = lstPurchaseOrders[0].PurchaseOrderDate.ToExternalDate();
                lblPOID.Text = lstPurchaseOrders[0].PurchaseOrderNo.ToString();
                purchaseorderno = lstPurchaseOrders[0].PurchaseOrderNo.ToString();
                hdnApprovePO.Value = lstPurchaseOrders[0].PurchaseOrderID.ToString();
                List<InventoryItemsBasket> iChildCat2 = (from i in lstInventoryItemsBasket
                                                         group i by new { i.ProductID, i.Quantity, i.Unit, i.ID, i.ProductName, i.CategoryName, i.CategoryID,i.Type,i.Discount ,i.Amount,i.Tax,i.Rate,i.UnitSellingPrice,i.ComplimentQTY,i.PurchaseTax,i.ProductCode } into g

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
                                                             Type=g.Key.Type,
                                                             Discount=g.Key.Discount,
                                                             Amount=g.Key.Amount,
                                                             Tax=g.Key.Tax,
                                                             Rate=g.Key.Rate,
                                                             UnitSellingPrice=g.Key.UnitSellingPrice,
                                                             ComplimentQTY=g.Key.ComplimentQTY,
                                                             PurchaseTax=g.Key.PurchaseTax,
                                                             ProductCode = g.Key.ProductCode
                                                         }).Distinct().ToList();
                lstInventoryItemsBasket = iChildCat2.ToList();
                LoadPurchaseOrderItems(lstProductCategories, lstInventoryItemsBasket);

                if (lstPurchaseOrders[0].Comments != "")
                {
                    
                    string displayTool = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_07;
                    displayTool = displayTool == null ? "<b>Note:</b>" : displayTool;
                    commentsTD.InnerHtml = "<hr/>" + "<p style='font-weight: bold;'>" + displayTool + "</p>" + lstPurchaseOrders[0].Comments;
                    //end
                }

                returnCode = new GateWay(base.ContextInfo).GetUserDetail(lstPurchaseOrders[0].CreatedBy, out lstUsers);
                if (lstPurchaseOrders[0].CreatedAt.ToShortDateString() != "01/01/0001")
                {

                    preparedDateTD.InnerText = lstPurchaseOrders[0].CreatedAt.ToExternalDate();
                }
                if (lstUsers != null && lstUsers.Count > 0)
                {
                    
                    preparedByTD.InnerText = lstUsers[0].Name;
                }
                if (lstPurchaseOrders[0].Status == "Approved")
                {
                    if (lstPurchaseOrders[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                    {
                        approvalTR.Style.Add("display", "block");
                        approvedDateTD.InnerText = lstPurchaseOrders[0].ApprovedAt.ToExternalDate();
                    }
                    if (lstPurchaseOrders[0].ApprovedBy != 0)
                    {
                        returnCode = new GateWay(base.ContextInfo).GetUserDetail(lstPurchaseOrders[0].ApprovedBy, out lstUsers);
                        if (lstUsers != null && lstUsers.Count > 0)
                        {
                        approvedByTD.Attributes.Add("class", "show");
                        approvedByTD.InnerText = lstUsers[0].Name;
                        }
                    }
                }

                if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Inprogress && approval == "1")
                {
                    lblStatus.Text = lstPurchaseOrders[0].Status;
                    trApproveBlock.Attributes.Add("class", "displaytr");
                    tprint.Attributes.Add("class", "hide");
                   
                }
                else if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Pending && approval == "1")
                {
                    lblStatus.Text = lstPurchaseOrders[0].Status;
                    trApproveBlock.Attributes.Add("class", "displaytr");
                    tprint.Attributes.Add("class", "hide");
                }
                else if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Inprogress && approval == null)
                {
                    lblStatus.Text = lstPurchaseOrders[0].Status;
                    trApproveBlock.Attributes.Add("class", "hide");
                }
                else if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Cancelled && approval == null)
                {
                    lblStatus.Text = lstPurchaseOrders[0].Status;
                    canOrder.Attributes.Add("class", "hide");
                }
                else 
                {
                    lblStatus.Text = lstPurchaseOrders[0].Status;
                    trApproveBlock.Attributes.Add("class", "hide");
                    tprint.Attributes.Add("class", "displaytb a-center w-100p");
                }
            }
            else
            {
                string Message = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_01;
                if (Message == null)
                {
                    Message="No Matching Records Found!";
                }
                lblMessage.Text = Message;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in ViewPurchaseOrder.aspx.cs", ex);
        }
       
    }

    public void LoadPurchaseOrderItems(List<ProductCategories> lstPO, List<InventoryItemsBasket> lstIIB)
    {
        string ProductName = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_02;
        if (ProductName == null)
        {
            ProductName = "Product Name";
        }

        string Quantity = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_03;
        if (Quantity == null)
        {
            Quantity = "Quantity";
        }

        string Units = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_04;
        if (Units == null)
        {
            Units = "Unit";
        }
        string Description = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_05;
        if (Description == null)
        {
            Description = "Description";
        }
        string Status = Resources.PurchaseOrder_ClientDisplay.PurchaseOrder_ViewPurchaseOrder_aspx_06;
        if (Status == null)
        {
            Status = "Status";
        }
        //Hari's code starts
        string isVATReq = GetConfigValue("IsVATNotApplicable", OrgID);

        //Hari's code ends
        purchaseOrderDetailsTab.Rows.Clear();
        TableRow rowH = new TableRow();
        TableRow rowH1 = new TableRow();
        TableRow rowH2 = new TableRow();
        TableHeaderCell cellH1 = new TableHeaderCell();
        TableHeaderCell cellHs1 = new TableHeaderCell();
        TableHeaderCell cellH2 = new TableHeaderCell();
        TableHeaderCell cellH3 = new TableHeaderCell();
        TableHeaderCell cellH4 = new TableHeaderCell();
        TableHeaderCell cellH6 = new TableHeaderCell();
        TableHeaderCell cellH7 = new TableHeaderCell();
        TableHeaderCell cellH8 = new TableHeaderCell();
        TableHeaderCell cellHs8 = new TableHeaderCell();
        TableHeaderCell cellH9 = new TableHeaderCell();
        TableHeaderCell cellH10 = new TableHeaderCell();
        TableHeaderCell cellH11 = new TableHeaderCell();
        TableHeaderCell cellH12 = new TableHeaderCell();
        TableHeaderCell cellH13 = new TableHeaderCell();
        TableHeaderCell cellH14 = new TableHeaderCell();
        TableHeaderCell cellH15 = new TableHeaderCell();
        TableHeaderCell cellH16 = new TableHeaderCell();
        TableHeaderCell cellH17 = new TableHeaderCell();
        TableHeaderCell cellH18 = new TableHeaderCell();
        TableHeaderCell cellH19 = new TableHeaderCell();
        TableHeaderCell cellH20 = new TableHeaderCell();
        TableHeaderCell cellH21 = new TableHeaderCell();


        cellH1.Attributes.Add("class", "a-center v-middle");
        cellH1.Attributes.Add("rowspan", "3");
        cellH1.Text = ProductName;
        cellH2.Width = Unit.Percentage(15);
        cellH1.Style.Add("border", "1px solid #ddd");
        cellHs1.Attributes.Add("class", "a-center v-middle");
        cellHs1.Attributes.Add("rowspan", "3");
        cellHs1.Text = "HSN Code";
        cellHs1.Width = Unit.Percentage(5);
        cellHs1.Style.Add("border", "1px solid #ddd");
        cellH2.Attributes.Add("class", "a-center v-middle");
        cellH2.Attributes.Add("rowspan", "3");
        cellH2.Text = Quantity;
        cellH2.Width = Unit.Percentage(5);
        cellH2.Style.Add("border", "1px solid #ddd");
        cellH3.Attributes.Add("class", "a-center v-middle");
        cellH3.Attributes.Add("rowspan", "3");
        cellH3.Text = Units;
        cellH3.Width = Unit.Percentage(5);
        cellH3.Style.Add("border", "1px solid #ddd");
		       //cellH3.Style.Add("border-right", "1px solid #000");
        cellH4.Attributes.Add("align", "Center");
        cellH4.Attributes.Add("rowspan", "3");
        cellH4.Text = "Description";
        cellH4.Width = Unit.Percentage(4);
        cellH4.Visible = false;
        cellH4.Style.Add("border", "1px solid #ddd");
        //cellH5.Style.Add("border", "1px solid #ddd");
        cellH6.Attributes.Add("class", "a-center v-middle");
        cellH6.Attributes.Add("rowspan", "3");
        cellH6.Text = "Unit Cost";
        cellH6.Width = Unit.Percentage(5);
        cellH6.Style.Add("border", "1px solid #ddd");
        cellH7.Attributes.Add("class", "a-center v-middle");
        cellH7.Attributes.Add("rowspan", "3");
        cellH7.Text = "Discount(%)";
        cellH7.Width = Unit.Percentage(4);
        cellH7.Style.Add("border", "1px solid #ddd");
        cellH7.Attributes.Add("align", "Center");

        if (isVATReq.Trim() == "Y")
        {
            cellH8.Text = "Tax";
            cellH8.Width = Unit.Percentage(25);
            cellH8.Style.Add("border", "1px solid #ddd");
            cellH8.Attributes.Add("colspan", "4");
        }
        else
        {
            cellH8.Text = "GST(%)";
            cellH8.Width = Unit.Percentage(4);
            cellH8.Style.Add("border", "1px solid #ddd");
            cellH8.Attributes.Add("class", "hide");
            cellH8.Attributes.Add("rowspan", "3");

            cellHs8.Text = "GST(%)";
            cellHs8.Width = Unit.Percentage(25);
            cellHs8.Style.Add("border", "1px solid #ddd");
            cellHs8.Attributes.Add("colspan", "6");
        }
        //added jlp
        cellH9.Attributes.Add("class", "a-center v-middle");
        cellH9.Attributes.Add("rowspan", "3");
        cellH9.Text = "Comp Qty";
        cellH9.Width = Unit.Percentage(7);
        cellH9.Style.Add("border", "1px solid #ddd");
        cellH10.Style.Add("border", "1px solid #ddd");
        cellH10.Attributes.Add("class", "hide");
        cellH10.Attributes.Add("rowspan", "3");
        //end

        cellH10.Attributes.Add("align", "right");
        cellH10.Text = "Purchase Tax(%)";
        cellH10.Width = Unit.Percentage(3);
        cellH11.Attributes.Add("class", "a-center v-middle");
        cellH11.Attributes.Add("rowspan", "3");
        cellH11.Text = "Total";
        cellH11.Width = Unit.Percentage(7);
        cellH11.Style.Add("border", "1px solid #ddd");
        cellH12.Attributes.Add("class", "a-center v-middle");
        cellH12.Attributes.Add("rowspan", "3");
        cellH12.Text = "Total Value";
        cellH12.Width = Unit.Percentage(9);
        cellH12.Style.Add("border", "1px solid #ddd");

        if (isVATReq.Trim() == "Y")
        {
            cellH13.Text = "%";
            cellH13.Style.Add("border", "1px solid #ddd");
            cellH13.Attributes.Add("rowspan","2");
            cellH13.Attributes.Add("colspan", "2");

            cellH14.Text = "Amt";
            cellH14.Style.Add("border", "1px solid #ddd");
            cellH14.Attributes.Add("rowspan", "2");
            cellH14.Attributes.Add("colspan", "2");

        }
        else
        {
            cellH13.Text = "CGST";
            cellH13.Attributes.Add("colspan", "2");
            cellH13.Style.Add("border", "1px solid #ddd");
            cellH14.Text = "SGST";
            cellH14.Attributes.Add("colspan", "2");
            cellH14.Style.Add("border", "1px solid #ddd");
            cellH15.Text = "IGST";
            cellH15.Attributes.Add("colspan", "2");
            cellH15.Style.Add("border", "1px solid #ddd");

            cellH16.Text = "%";
            cellH16.Style.Add("border", "1px solid #ddd");
            cellH17.Text = "Amt";
            cellH17.Style.Add("border", "1px solid #ddd");
            cellH18.Text = "%";
            cellH18.Style.Add("border", "1px solid #ddd");
            cellH19.Text = "Amt";
            cellH19.Style.Add("border", "1px solid #ddd");
            cellH20.Text = "%";
            cellH20.Style.Add("border", "1px solid #ddd");
            cellH21.Text = "Amt";
            cellH21.Style.Add("border", "1px solid #ddd");
        }
        cellH4.Attributes.Add("class", "a-left");
        //cellH4.Style.Add("border-right", "1px solid #000");
        cellH4.Text = Description;
        cellH4.Width = Unit.Percentage(20);
        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellHs1);
        rowH.Cells.Add(cellH2);
        rowH.Cells.Add(cellH3);
        rowH.Cells.Add(cellH6);
        rowH.Cells.Add(cellH7);
        if (isVATReq.Trim() == "Y")
        {
            rowH.Cells.Add(cellH8);
        }
        else
        {
            rowH.Cells.Add(cellH8);
            rowH.Cells.Add(cellHs8);
        }
        rowH.Cells.Add(cellH9);
        rowH.Cells.Add(cellH10);
        rowH.Cells.Add(cellH11);
        rowH.Cells.Add(cellH12);
        rowH.Attributes.Add("class", "gridHeader");
        rowH.Style.Add("border", "1px solid #ddd");
        rowH.Attributes.Add("class", "a-left");
        if (isVATReq.Trim() == "Y")
        {
            rowH1.Cells.Add(cellH13);
            rowH1.Cells.Add(cellH14);
        }
        else
        {
            rowH1.Cells.Add(cellH13);
            rowH1.Cells.Add(cellH14);
            rowH1.Cells.Add(cellH15);

            rowH2.Cells.Add(cellH16);
            rowH2.Cells.Add(cellH17);
            rowH2.Cells.Add(cellH18);
            rowH2.Cells.Add(cellH19);
            rowH2.Cells.Add(cellH20);
            rowH2.Cells.Add(cellH21);
        }
        if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Partial)
        {
            TableCell cellH5 = new TableCell();
            cellH5.Attributes.Add("class", "a-left");
            cellH5.Text = "Status";
            cellH5.Width = Unit.Percentage(20);
            cellH5.Style.Add("border", "1px solid #ddd");
            rowH.Cells.Add(cellH5);
        }

        //rowH.Cells.Add(cellH4);
        //rowH.Font.Bold = true;
        //rowH.Font.Underline = true;
        //rowH.Style.Add("color", "#333");
        purchaseOrderDetailsTab.Rows.Add(rowH);
        purchaseOrderDetailsTab.Rows.Add(rowH1);
        purchaseOrderDetailsTab.Rows.Add(rowH2);
        Label lblTotal = new Label();
        lblTotal.ID = "lblTotal";
        lblTotal.Text = "0.00";
        Label lbl = new Label();
        lbl.ID = "lbl";
        lbl.Text = "Total value : ";
        // foreach (ProductCategories objPC in lstProductCategories)
        // {


        var list = (from basket in lstInventoryItemsBasket
                    // where basket.CategoryID == objPC.CategoryID 
                    orderby basket.ID ascending
                    select basket);



        if (list.Count() > 0)
        {
            TableRow row3 = new TableRow();
            TableCell cell11 = new TableCell();
            foreach (var childList in list)
            {
                TableRow row2 = new TableRow();
                
                TableCell cell1 = new TableCell();
                TableCell cells1 = new TableCell();
                TableCell cell2 = new TableCell();
                TableCell cell3 = new TableCell();
                TableCell cell4 = new TableCell();
                TableCell cell6 = new TableCell();
                TableCell cell7 = new TableCell();
                TableCell cell8 = new TableCell();
                TableCell cells8 = new TableCell();
                TableCell cell9 = new TableCell();
                TableCell cell10 = new TableCell();
                
                TableCell cell12 = new TableCell();
                TableCell cell13 = new TableCell();//sathish

                TableCell cell14 = new TableCell();
                TableCell cell15 = new TableCell();
                TableCell cell16 = new TableCell();
                TableCell cell17 = new TableCell();
                TableCell cell18 = new TableCell();

                cell1.Attributes.Add("class", "a-left");
                cell1.Text = childList.ProductName;
                cell1.Style.Add("border", "1px solid #ddd");
                cells1.Attributes.Add("class", "a-left");
                cells1.Text = childList.ProductCode;
                cells1.Style.Add("border", "1px solid #ddd");
                cell2.Attributes.Add("class", "a-right");
                cell2.Text = childList.Quantity.ToString();
                cell2.Style.Add("border", "1px solid #ddd");
                cell3.Attributes.Add("class", "a-left");
                cell3.Style.Add("border", "1px solid #ddd");
                if (childList.Unit != "")
                {
                    cell3.Text = childList.Unit;
                }
                else
                {
                    cell3.Text = "--";
                }

                cell4.Attributes.Add("class", "a-left");
                cell4.Style.Add("border-right", "1px solid #ddd");
                if (childList.Description != "")
                {
                    cell4.Text = childList.Description;
                }
                else
                {
                    cell4.Text = "--";
                }
                cell6.Attributes.Add("align", "center");
                cell6.Text = childList.Amount.ToString();
                cell6.Attributes.Add("class", "a-right");
                cell6.Style.Add("border", "1px solid #ddd");
                cell7.Attributes.Add("class", "a-right");
                cell7.Text = childList.Discount.ToString();
                cell7.Style.Add("border", "1px solid #ddd");


                cell8.Attributes.Add("class", "a-right hide");
                cell8.Text = childList.Tax.ToString();
                cell8.Style.Add("border", "1px solid #ddd");

                //------------------------------Tax Calculation Part

                long LStateID;
                List<Organization> lstSOrganizationAdd = null;
                string NeedOrgLocationBasedGST = GetConfigValue("NeedOrgLocationBasedGST", OrgID);

                if (NeedOrgLocationBasedGST == "Y")
                {
                    Organization_BL objOrganization_BL = new Organization_BL();
                    objOrganization_BL.getOrganizationAddress(OrgID, ILocationID, out lstSOrganizationAdd);

                    LStateID = lstSOrganizationAdd[0].StateID;
                }
                else
                {
                    LStateID = StateID;
                }

                decimal GSTtaxamount =0;
                decimal IGSTtaxamount = 0;
                decimal GSTTax = 0;
                if (LStateID == lstSuppliers[0].StateId)
                {
                    if (childList.Tax > 0)
                    {
                        if (isVATReq.Trim() == "Y")
                        {
                            GSTtaxamount = Convert.ToDecimal(((((childList.Amount - (childList.Amount * childList.Discount / 100)) * childList.Tax / 100)) * childList.Quantity));
                            GSTTax = Convert.ToDecimal((childList.Tax));
                            cells8.Attributes.Add("class", "a-right");
                            cells8.Attributes.Add("colspan", "2");
                            cells8.Text = GSTTax.ToString("0.00");
                            cells8.Style.Add("border", "1px solid #ddd");
                            

                            cell14.Attributes.Add("class", "a-right");
                            cell14.Attributes.Add("colspan", "2");
                            cell14.Text = GSTtaxamount.ToString("0.00");
                            cell14.Style.Add("border", "1px solid #ddd");
                            
                        }
                        else
                        {
                            GSTtaxamount = Convert.ToDecimal(((((childList.Amount - (childList.Amount * childList.Discount / 100)) * childList.Tax / 100)) * childList.Quantity) / 2);
                            GSTTax = Convert.ToDecimal((childList.Tax) / 2);
                            cells8.Attributes.Add("class", "a-right");
                            cells8.Text = GSTTax.ToString("0.00");
                            cells8.Style.Add("border", "1px solid #ddd");

                            cell14.Attributes.Add("class", "a-right");
                            cell14.Text = GSTtaxamount.ToString("0.00");
                            cell14.Style.Add("border", "1px solid #ddd");

                            cell15.Attributes.Add("class", "a-right");
                            cell15.Text = GSTTax.ToString("0.00");
                            cell15.Style.Add("border", "1px solid #ddd");

                            cell16.Attributes.Add("class", "a-right");
                            cell16.Text = GSTtaxamount.ToString("0.00");
                            cell16.Style.Add("border", "1px solid #ddd");

                            cell17.Attributes.Add("class", "a-right");
                            cell17.Text = "0.00";
                            cell17.Style.Add("border", "1px solid #ddd");
                            
                            cell18.Attributes.Add("class", "a-right");
                            cell18.Text = "0.00";
                            cell18.Style.Add("border", "1px solid #ddd");
                        }
                    }
                }
                else
                {
                    IGSTtaxamount = Convert.ToDecimal(((((childList.Amount - (childList.Amount * childList.Discount / 100)) * childList.Tax / 100)) * childList.Quantity));
                    GSTTax = Convert.ToDecimal((childList.Tax));
                    cells8.Attributes.Add("class", "a-right");
                    cells8.Text = "0.00";
                    cells8.Style.Add("border", "1px solid #ddd");

                    cell14.Attributes.Add("class", "a-right");
                    cell14.Text = "0.00";
                    cell14.Style.Add("border", "1px solid #ddd");

                    cell15.Attributes.Add("class", "a-right");
                    cell15.Text = "0.00";
                    cell15.Style.Add("border", "1px solid #ddd");

                    cell16.Attributes.Add("class", "a-right");
                    cell16.Text = "0.00";
                    cell16.Style.Add("border", "1px solid #ddd");

                    cell17.Attributes.Add("class", "a-right");
                    cell17.Text = GSTTax.ToString("0.00");
                    cell17.Style.Add("border", "1px solid #ddd");
                    
                    cell18.Attributes.Add("class", "a-right");
                    cell18.Text = IGSTtaxamount.ToString("0.00");
                    cell18.Style.Add("border", "1px solid #ddd");
                }
                //cell14.Text = "5000";
                //cell14.Style.Add("border", "1px solid #ddd");
                //cell15.Text = "5%";
                //cell15.Style.Add("border", "1px solid #ddd");
                //cell16.Text = "5000";
                //cell16.Style.Add("border", "1px solid #ddd");
                //cell17.Text = "5%";
                //cell17.Style.Add("border", "1px solid #ddd");
                //cell18.Text = "5000";
                //cell18.Style.Add("border", "1px solid #ddd");

                cell9.Attributes.Add("class", "a-right");
                cell9.Text = childList.ComplimentQTY.ToString();
                cell9.Style.Add("border", "1px solid #ddd");
                cell10.Attributes.Add("class", "a-right hide");
                cell10.Text = childList.PurchaseTax.ToString();
                cell10.Style.Add("border", "1px solid #ddd");
                cell11.Attributes.Add("class", "a-right bold");
                cell11.ColumnSpan = 15;
                lblTotal.Text = (string.Format("{0:N}",Convert.ToDecimal(lblTotal.Text) + Convert.ToDecimal(childList.UnitSellingPrice))).ToString();
                cell11.Controls.Add(lbl);
                lblTotal.Attributes.Add("class", "marginL72");
                cell11.Controls.Add(lblTotal);
                cell11.Style.Add("border", "1px solid #ddd");
                // cell11.Text = "Total Value:";
                //added by jlp
                cell12.Attributes.Add("class", "a-right");
                cell12.Text = childList.Rate.ToString();
                cell12.Style.Add("border", "1px solid #ddd");
                //end

                //cell13.Attributes.Add("align", "right");
                cell13.Attributes.Add("class", "a-right");
                cell13.Text = childList.UnitSellingPrice.ToString();
                cell13.Style.Add("border", "1px solid #ddd");

                cells8.Attributes.Add("class", "a-right");
                //cells8.Attributes.Add("colspan", "2");
                cells8.Text = LStateID == lstSuppliers[0].StateId ? GSTTax.ToString("0.00") : "0.00";
                cells8.Style.Add("border", "1px solid #ddd");


                cell14.Attributes.Add("class", "a-right");
                //cell14.Attributes.Add("colspan", "2");
                cell14.Text = GSTtaxamount.ToString("0.00");
                cell14.Style.Add("border", "1px solid #ddd");

                //sathish
                row2.Cells.Add(cell1);
                row2.Cells.Add(cells1);
                row2.Cells.Add(cell2);
                row2.Cells.Add(cell3);
                row2.Cells.Add(cell6);
                row2.Cells.Add(cell7);
                
                if (isVATReq.Trim() == "Y")
                {
                    row2.Cells.Add(cells8);
                    row2.Cells.Add(cell14);
                }
                else
                {
                    row2.Cells.Add(cell8);
                    row2.Cells.Add(cells8);
                    row2.Cells.Add(cell14);
                    row2.Cells.Add(cell15);
                    row2.Cells.Add(cell16);
                    row2.Cells.Add(cell17);
                    row2.Cells.Add(cell18);
                }
                
                row2.Cells.Add(cell9);
                row2.Cells.Add(cell10);
                
                row2.Cells.Add(cell12);
                row2.Cells.Add(cell13);//sathish
                if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Partial)
                {
                    TableCell cell5 = new TableCell();
                    cell5.Attributes.Add("class", "a-left");
                    cell5.Text = childList.Type.ToString()=="Closed" ? StockOutFlowStatus.Received : StockOutFlowStatus.Cancelled ;
                    cell5.Width = Unit.Percentage(20);
                    row2.Cells.Add(cell5);
                }

                row2.Font.Bold = false;
                //row2.Style.Add("color", "#000000");
                //row2.Style.Add("border", "1px solid #000");
                purchaseOrderDetailsTab.Rows.Add(row2);
                
                // }

            }
            row3.Cells.Add(cell11);
            purchaseOrderDetailsTab.Rows.Add(row3);
        }
    }
    
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
            long orderID = Convert.ToInt64(hdnApprovePO.Value);
            string status = StockOutFlowStatus.Approved;
            returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID,ILocationID);
            if (returnCode == 0)
            {
                LoadDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
        }
    }
    
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            long orderID = Convert.ToInt64(hdnApprovePO.Value);
            string status = StockOutFlowStatus.Cancelled;
            returnCode = inventoryBL.UpdateInventoryApproval("PurchaseOrder", orderID, status, LID, OrgID,ILocationID);
            if (returnCode == 0)
            {
                LoadDetails();
            }
        }
        catch (System.Threading.ThreadAbortException tex)
        {
            string te = tex.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
        }
    }
    
    protected void btnEdit_Click(object sender, EventArgs e)
    {
        try
        {
            if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"PurchaseOrderQuantity.aspx?poId="+hdnApprovePO.Value+"&ACN=" + strACN, true);
            }
            Response.Redirect("PurchaseOrderQuantity.aspx?poId="+hdnApprovePO.Value, true);
         //~/Inventory/PurchaseOrderQuantity.aspx hdnApprovePO.Value
           
          
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewPurchaseOrder.aspx", ex);
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

    protected void GetinvConfigDtls()
    {
        try
        {
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PO Header", OrgID, ILocationID, out lstInventoryConfig);
            bool _flag = false;
            if (lstInventoryConfig.Count > 0)
            {
                imgBillLogo.ImageUrl = lstInventoryConfig[0].ConfigValue.Trim();
                if (!string.IsNullOrEmpty(lstInventoryConfig[0].ConfigValue.Trim()))
                {
                    imgBillLogo.Visible = true;
                }
                else
                {
                    _flag = true;
                }
            }
            else
            {
                _flag = true;
            }
            if (_flag)
            {
                imgBillLogo.Visible = false;
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error at:" + Request.RawUrl + "Message:", ex);
        }
    }

}
