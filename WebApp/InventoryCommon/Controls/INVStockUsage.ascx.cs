using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Data;
using System.Xml;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;

public partial class InventoryCommon_Controls_INVStockUsage : Attune_BaseControl
{
    public InventoryCommon_Controls_INVStockUsage()

        : base("InventoryCommon_Controls_INVStockUsage_ascx")
    { }

    public string iType { get; set; }
    public int iSupplierID { get; set; }
    int QuantityCount = 0;
    long pId = 0;

    List<Attributes> lstAttributes = new List<Attributes>();
    List<ProductAttributes> lstProductAttributes = new List<ProductAttributes>();
    List<AttributeValue> lstTmpAttributeValue = new List<AttributeValue>();
    List<AttributeValue> lstAttributeValue = new List<AttributeValue>();
    DataTable objAttributes = new DataTable();
    DataTable dtUsageAttValues = new DataTable();
    


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                lblType.Text = iType;
                string Message = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_02;
                if (Message == null)
                {
                    Message = "Search the Product List";
                }
                lblmsg.Text = Message;
                divlistProducts.Attributes.Add("class", "hide");
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - StockReturn.aspx", ex);
            }
        }
        if (iType == "Issued Qty")
        {
            tdGrandTotal.Attributes.Add("class", "show");

            if (hdnGrandTotal.Value != "0")
            {
                txtGrandTotal.Text = (Convert.ToDecimal(hdnTotal.Value) + Convert.ToDecimal(hdnGrandTotal.Value)).ToString();
            }
        }
        listBox_click();
    }

    private void listBox_click()
    {
        if (Request["__EVENTARGUMENT"] != null && Request["__EVENTARGUMENT"] == "Change")
        {
            txtQuantity.Text = "";
            txtUnit.Text = "";
            txtBatchNo.Text = "";
            if (listProducts.SelectedValue != "")
            {
                string ProductName = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_03;
                if (ProductName == null)
                {
                    ProductName = "Product Name:";
                }
                LoadProductsBatchNo(Int64.Parse(listProducts.SelectedValue));
                divProductDetails.Attributes.Add("class", "show");
                hdnProductId.Value = listProducts.SelectedValue;
                lblProductName.Text = ProductName + listProducts.SelectedItem.Text;
                lblProductName.Visible = true;
                lblProductName.Font.Bold = true;
                lblTable.Text = tempTable.Value;
                if (iType == "Issued Qty")
                {
                    tdGrandTotal.Attributes.Add("class", "show");
                    txtGrandTotal.Text = (Convert.ToDecimal(hdnTotal.Value) + Convert.ToDecimal(hdnGrandTotal.Value)).ToString();

                }


            }

        }
        listProducts.Attributes.Add("ondblclick", Page.ClientScript.GetPostBackEventReference(listProducts, "Change"));
    }

    //private void LoadProductList()
    //{
    //    List<Products> lstProducts = new List<Products>();
    //    inventoryBL.GetAllProductList(OrgID, ILocationID, out lstProducts);
       
    //    if (lstProducts.Count > 0)
    //    {
    //        listProducts.Visible = true;
    //        lblMsgpro.Text = "Product List (Double click the below list to select the Bacth No.)";
    //        listProducts.DataSource = lstProducts;
    //        listProducts.DataTextField = "ProductName";
    //        listProducts.DataValueField = "ProductID";
    //        listProducts.DataBind();
           
    //    }
    //    else
    //    {
    //        lblmsg.Text = "No matching Product found";
    //        listProducts.Visible = false;
    //    }
    //}

    private void LoadProductsBatchNo(long iProductId)
    {
        try
        {
            hdnProBatchNo.Value = "";
            hdnBatchList.Value = "";
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            new InventoryCommon_BL(base.ContextInfo).GetProductsBatchNo(OrgID, ILocationID,InventoryLocationID, iProductId, out lstInventoryItemsBasket, iSupplierID);

            txtBatchNo.Enabled = true;

            if (lstInventoryItemsBasket.Count > 0)
            {
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "AutoComp", "  AutoCompBacthNo();", true);

                foreach (InventoryItemsBasket item in lstInventoryItemsBasket)
                {
                    hdnProBatchNo.Value += item.BatchNo + "|";
                    hdnBatchList.Value += item.BatchNo + "~" + item.Description + "^";
                    if (lstInventoryItemsBasket.Count == 1)
                    {
                        txtBatchNo.Text = item.BatchNo;
                        txtQuantity.Focus();

                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "HasBatch", "BindQuantity();", true);
                    }
                    else
                    {
                        txtBatchNo.Focus();
                    }

                }
            }
            else
            {
                hdnBatchList.Value = "";
            }
            
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Load Products Batch No - StockReturn.aspx", ex);
         
        }

    }
    
    public List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID = Convert.ToInt64(listChild[0]);
                newBasket.ProductName = listChild[1];
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                if (iType == "Issued Qty")
                {
                    newBasket.Rate = Convert.ToDecimal(listChild[7]);
                    newBasket.Tax = Convert.ToDecimal(listChild[8]);
                    newBasket.CategoryID = int.Parse(listChild[9]);
                    newBasket.UnitPrice = Convert.ToDecimal(listChild[15]);
                   
                }
                //newly added 

                else if (iType == "Damage Qty")
                {
                    newBasket.Rate = Convert.ToDecimal(listChild[7]);
                    newBasket.Tax = Convert.ToDecimal(listChild[8]);
                    newBasket.CategoryID = int.Parse(listChild[9]);
                    newBasket.UnitPrice = Convert.ToDecimal(listChild[15]);
                   
                    //newBasket.UnitPrice = Convert.ToDecimal(listChild[10]);

                }


                else
                {
                   
                    newBasket.Rate = Convert.ToDecimal(listChild[7]);
                    newBasket.Tax = Convert.ToDecimal(listChild[8]);
                    newBasket.CategoryID = int.Parse(listChild[9]);
                  
                   
                }
                //End 
                newBasket.Type = listChild[13];
                newBasket.AttributeDetail = listChild[12];
                newBasket.ExpiryDate = DateTime.Parse(listChild[10]);
                newBasket.UnitPrice = Convert.ToDecimal(listChild[15]);
               
                newBasket.Manufacture = DateTimeNow;
                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        return lstInventoryItemsBasket;
    }
    
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        List<Products> lstProducts = new List<Products>();
        
        try
        {
            if (iType == "Issued Qty")
            {
                tdGrandTotal.Attributes.Add("class", "show");

                if (hdnGrandTotal.Value != "0")
                {
                    txtGrandTotal.Text = (Convert.ToDecimal(hdnTotal.Value) + Convert.ToDecimal(hdnGrandTotal.Value)).ToString();
                }
            }
            divProductDetails.Attributes.Add("class", "hide");
            lblProductName.Text = "";
            lblTable.Text = tempTable.Value;
            new InventoryCommon_BL(base.ContextInfo) .GetSearchProductList(OrgID,ILocationID,InventoryLocationID, txtProduct.Text.Trim(), out lstProducts, iSupplierID);

            foreach (string productID in hdnTaskProducts.Value.Split('^'))
            {
                lstProducts.Remove(lstProducts.Find(p => p.ProductID.ToString() == productID));
            }

            if (lstProducts.Count > 0)
            {

                listProducts.Visible = true;
                divlistProducts.Attributes.Add("class", "show");
                string sPath = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_04;
                if (sPath == null)
                {
                    sPath = "Product List (Double click the below list to select the Bacth No.)";
                }
                lblMsgpro.Text = sPath;
                listProducts.DataSource = lstProducts;
                listProducts.DataTextField = "ProductName";
                listProducts.DataValueField = "ProductID";
                listProducts.DataBind();
            }
            else
            {
                string sMessage = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_05;
                if (sMessage == null)
                {
                    sMessage = "No matching Product found";
                }
                lblMsgpro.Text = sMessage;
                divlistProducts.Attributes.Add("class","hide");
                txtProduct.Focus();
                lblProductName.Text = "";
            }


        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Product  Details", Ex);
        }
        

    }

    public void GetProductList()
    {
        
        List<Products> lstProducts = new List<Products>();
        tdSearch.Visible = false;
        try
        {
            new InventoryCommon_BL(base.ContextInfo).GetSearchProductList(OrgID, ILocationID, InventoryLocationID, txtProduct.Text.Trim(), out lstProducts, iSupplierID);
            if (lstProducts.Count > 0)
            {

                listProducts.Visible = true; divlistProducts.Attributes.Add("class", "show");
                string sPath = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_04;
                if (sPath == null)
                {
                    sPath = "Product List (Double click the below list to select the Bacth No.)";
                }
                lblMsgpro.Text = sPath;
                listProducts.DataSource = lstProducts;
                listProducts.DataTextField = "ProductName";
                listProducts.DataValueField = "ProductID";
                listProducts.DataBind();
            }
            else
            {
                string sMessage = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_05;
                if (sMessage == null)
                {
                    sMessage = "No matching Product found";
                }
                lblMsgpro.Text = sMessage;
                divlistProducts.Attributes.Add("class", "hide");
            }
            
        }
        catch (Exception Ex)
        {

            CLogger.LogError("Error While Searching Product  Details", Ex);
        }

    }
    
    protected void btnAttribute_Click(object sender, EventArgs e)
    {
        try
        {
            if (hdnAction.Value == "Add")
            {
                BindProductAttributes(hdnAttributes.Value, hdnProductId.Value + "~" + txtQuantity.Text + "~" + hdnAttributeDetailTmp.Value, hdnAction.Value);
            }
            else if (hdnAction.Value == "Update")
            {
                BindProductAttributes(hdnAttributes.Value, hdnProductId.Value + "~" + txtQuantity.Text + "~" + hdnAttributeDetailTmp.Value, hdnAttributeDetail.Value, hdnAction.Value);
            }
            lblTable.Text = tempTable.Value;


        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Attribute Details", ex);
        }
    }

    protected void BindProductAttributes(string XmlValues, string strProduct, string actionFlag)
    {
        //long retCode = -1;
        try
        {
            string UnitNo = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_06;
            if (UnitNo == null)
            {
                UnitNo = "UnitNo";
            }

            string ProductId = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_07;
            if (ProductId == null)
            {
                ProductId = "ProductId";
            }

            hdnActionFlag.Value = actionFlag;
            string[] strProd = strProduct.Split('~');
            DataTable attDT1 = new DataTable();
            DataSet dsXml = new DataSet();
            DataSet dsAttVal = new DataSet();
            gvAttributeValues.Visible = false;
            pId = Int64.Parse(strProd[0]);
            if (strProd[1] != "Assign")
            {
                hdnRcvdQty.Value = hdnQty.Value = strProd[1];
                lblReceivedQty.Text = hdnRcvdQty.Value;
                QuantityCount = int.Parse(hdnQty.Value);
               

            }
           
            if (XmlValues != "")
            {
                StringReader stream = new StringReader(XmlValues);
                dsXml.ReadXml(stream);
                if (dsXml.Tables.Count > 0)
                {
                    DataTable dtXml = dsXml.Tables[0];
                    Utilities.ConvertTo(dtXml, out lstProductAttributes);
                    DataColumn Id = objAttributes.Columns.Add(UnitNo);
                    DataColumn pid = objAttributes.Columns.Add(ProductId);
                    Id.AutoIncrement = true;
                    Id.AutoIncrementSeed = 1;
                    pid.DefaultValue = pId;
                    hdnMandatoryFields.Value = "";
                    gvAttributes.DataSource = lstProductAttributes;
                    gvAttributes.DataBind();
                    gvAttributes.Visible = true;
                    ViewState["Attributes"] = objAttributes;
                    DataTable dt = new DataTable();
                    dt = objAttributes.Copy();
                    ViewState["dtTemplate"] = dt;

                    if (actionFlag == "Add" && strProd[2] != "N")
                    {
                        StringReader attStream = new StringReader(strProd[2]);
                        dsAttVal.ReadXml(attStream);
                        if (dsAttVal.Tables.Count > 0)
                        {
                            DataTable dtAttXml = dsAttVal.Tables[0];
                            //dtAttXml.Columns.Remove("IsIssued");
                            //dtAttXml.Columns.Remove("Description");
                            //dtAttXml.AcceptChanges();
                            dtAttXml.Columns[UnitNo].SetOrdinal(0);
                            dtAttXml.Columns[ProductId].SetOrdinal(1);
                            //objAttributes.Merge(dtAttXml, true, MissingSchemaAction.Ignore);
                            ViewState["Attributes"] = dtAttXml;


                        }
                    }
                    if (actionFlag == "Update" && strProd[2] != "N")
                    {
                        StringReader attStream = new StringReader(strProd[2]);
                        dsAttVal.ReadXml(attStream);
                        if (dsAttVal.Tables.Count > 0)
                        {
                            DataTable dtAttXml = dsAttVal.Tables[0];
                            //dtAttXml.Columns.Remove("IsIssued");
                            //dtAttXml.Columns.Remove("Description");
                            //dtAttXml.AcceptChanges();
                            dtAttXml.Columns[UnitNo].SetOrdinal(0);
                            dtAttXml.Columns[ProductId].SetOrdinal(1);
                            //objAttributes.Merge(dtAttXml, true, MissingSchemaAction.Ignore);
                            ViewState["Attributes"] = dtAttXml;

                            gvAttributeValues.DataSource = ViewState["Attributes"]; ;
                            gvAttributeValues.DataBind();
                            gvAttributeValues.Visible = true;
                        }
                    }
                    ModalPopupExtender1.Show();
                }
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On Binding Product Attribute Values - INVAttributeUsage.ascx", ex);
        }
    }

    protected void BindProductAttributes(string XmlValues, string strProduct, string ProductAttrip, string actionFlag)
    {
        //long retCode = -1;
        try
        {
            string UnitNo = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_06;
            if (UnitNo == null)
            {
                UnitNo = "UnitNo";
            }

            string ProductId = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_07;
            if (ProductId == null)
            {
                ProductId = "ProductId";
            } 

            hdnActionFlag.Value = actionFlag;
            string[] strProd = strProduct.Split('~');
            DataTable attDT1 = new DataTable();
            DataSet dsXml = new DataSet();
            DataSet dsAttVal;
            gvAttributeValues.Visible = false;
            pId = Int64.Parse(strProd[0]);
            if (strProd[1] != "Assign")
            {
                hdnRcvdQty.Value = hdnQty.Value = strProd[1];
                lblReceivedQty.Text = hdnRcvdQty.Value;
                QuantityCount = int.Parse(hdnQty.Value);
            }
            //retCode = invBL.GetAttributes(OrgID, out lstAttributes);
            //if (lstAttributes.Count > 0)
            //{
            //    Utilities.ConvertFrom(lstAttributes, out attDT1);
            //}
            if (XmlValues != "")
            {
                StringReader stream = new StringReader(XmlValues);
                dsXml.ReadXml(stream);
                if (dsXml.Tables.Count > 0)
                {
                    DataTable dtXml = dsXml.Tables[0];
                    Utilities.ConvertTo(dtXml, out lstProductAttributes);


                    DataColumn Id = objAttributes.Columns.Add(UnitNo);
                    DataColumn pid = objAttributes.Columns.Add(ProductId);
                    Id.AutoIncrement = true;
                    Id.AutoIncrementSeed = 1;
                    pid.DefaultValue = pId;
                    hdnMandatoryFields.Value = "";
                    gvAttributes.DataSource = lstProductAttributes;
                    gvAttributes.DataBind();
                    gvAttributes.Visible = true;
                    ViewState["Attributes"] = objAttributes;
                    DataTable dt = new DataTable();
                    dt = objAttributes.Copy();
                    ViewState["dtTemplate"] = dt;

                    if (strProd[2] != "N")
                    {

                        StringReader attStream = new StringReader(strProd[2]);
                        dsAttVal = new DataSet();
                        dsAttVal.ReadXml(attStream);
                        if (dsAttVal.Tables.Count > 0)
                        {
                            DataTable dtAttXml = dsAttVal.Tables[0];
                            //dtAttXml.Columns.Remove("IsIssued");
                           // dtAttXml.Columns.Remove("Description");
                            //dtAttXml.AcceptChanges();
                            dtAttXml.Columns[UnitNo].SetOrdinal(0);
                            dtAttXml.Columns[ProductId].SetOrdinal(1);
                            //objAttributes.Merge(dtAttXml, true, MissingSchemaAction.Ignore);
                            ViewState["Attributes"] = dtAttXml;


                        }
                    }
                    if (actionFlag == "Update" && ProductAttrip != "N")
                    {
                        StringReader attStream = new StringReader(ProductAttrip);
                        dsAttVal = new DataSet();
                        dsAttVal.ReadXml(attStream);
                        if (dsAttVal.Tables.Count > 0)
                        {
                            DataTable dtAttXml = dsAttVal.Tables[0];
                            //dtAttXml.Columns.Remove("IsIssued");
                            //dtAttXml.Columns.Remove("Description");
                            //dtAttXml.AcceptChanges();
                            dt.Columns[UnitNo].SetOrdinal(0);
                            dt.Columns[ProductId].SetOrdinal(1);
                            dt.Merge(dtAttXml, true, MissingSchemaAction.Ignore);
                            ViewState["UsageAttributes"] = dt;

                            gvAttributeValues.DataSource = ViewState["UsageAttributes"]; ;
                            gvAttributeValues.DataBind();
                            gvAttributeValues.Visible = true;
                        }
                    }
                    hdnQty.Value = QuantityCount.ToString();
                    ModalPopupExtender1.Show();

                }
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On Binding Product Attribute Values - INVAttributeUsage.ascx", ex);
        }
    }

    private int getRowCount(string strXml)
    {
        int count = 0;
        StringReader attStream = new StringReader(strXml);
        DataSet dsVal = new DataSet();
        dsVal.ReadXml(attStream);
        if (dsVal.Tables.Count > 0)
        {
            count = dsVal.Tables[0].Rows.Count;
        }
        return count;
    }

    private void SetProductAttributes(List<ProductAttributes> lstAttributes)
    {
        string Attributes = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_08;
        if (Attributes == null)
        {
            Attributes = "Attributes";
        }

        string Values = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_09;
        if (Values == null)
        {
            Values = "Values";
        }
        string UnitNo = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_06;
        if (UnitNo == null)
        {
            UnitNo = "UnitNo";
        }
        string Name = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_10;
        if (Name == null)
        {
            Name = "Name";
        }

        //InventoryCommon_Controls_INVStockUsage_ascx_10
        TableRow rowH = new TableRow();
        TableCell cellH1 = new TableCell();
        TableCell cellH2 = new TableCell();
        cellH1.Attributes.Add("class", "a-left");
        cellH1.Text = Attributes;
        cellH1.Width = Unit.Percentage(10);
        cellH2.Attributes.Add("class", "a-left");
        cellH2.Text = Values;
        cellH2.Width = Unit.Percentage(20);
        rowH.Cells.Add(cellH1);
        rowH.Cells.Add(cellH2);
        rowH.Font.Bold = true;
        rowH.Font.Underline = true;
        rowH.Attributes.Add("class", "greycolor");
        // tabAttributes.Rows.Add(rowH);
        objAttributes.Columns.Add(UnitNo);
        foreach (ProductAttributes item in lstAttributes)
        {

            TableRow rowC = new TableRow();
            TextBox txtBoxV = new TextBox();
            TableCell cell1 = new TableCell();
            TableCell cell2 = new TableCell();
            TableCell cell3 = new TableCell();

            cell1.Attributes.Add("class", "a-center");
            cell1.Text = Name + item.AttributeName;
            cell1.Width = Unit.Percentage(10);
            cell2.Attributes.Add("class", "a-left");
            cell2.Width = Unit.Percentage(20);

            txtBoxV.ID = "ID" + item.AttributeID;

            cell2.Controls.Add(txtBoxV);
            cell3.Attributes.Add("class", "a-left");
            if (item.IsMandatory == "Y")
            {
                cell3.Text = "<img src=\"../PlatForm/Images/starbutton.png\" class=\"v-middle\" />";
            }
            else
            {
                cell3.Text = "";
            }
            rowC.Cells.Add(cell1);
            rowC.Cells.Add(cell2);
            rowC.Cells.Add(cell3);
            rowC.Attributes.Add("class", "black");


        }
        ViewState["Attributes"] = objAttributes;

    }

    protected void gvAttributes_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ProductAttributes obj = (ProductAttributes)e.Row.DataItem;
            objAttributes.Columns.Add(obj.AttributeName);
            Image img = (Image)e.Row.FindControl("imgIsMandatory");
            if (obj.IsMandatory == "Y")
            {
                TextBox txtAttributeValues = (TextBox)e.Row.FindControl("txtAttributeValues");
                img.Visible = true;
                hdnMandatoryFields.Value += txtAttributeValues.ClientID + "~";
            }
            if (obj.IsSelected == "N")
            {
                e.Row.Visible = false;
            }


        }
    }

    protected void BtnAdd_Click(object sender, EventArgs e)
    {
        bool flag = false;
        if (hdnActionFlag.Value == "Update")
        {
            hdnQty.Value = (int.Parse(hdnRcvdQty.Value) - gvAttributeValues.Rows.Count).ToString();
        }
        if (hdnQty.Value != null || hdnQty.Value != "0")
        {
            QuantityCount = int.Parse(hdnQty.Value);

        }
        if (QuantityCount > 0)
        {
            flag = BindAttributeValues(hdnActionFlag.Value);
            if (flag == true)
            {
                QuantityCount--;
                hdnQty.Value = QuantityCount.ToString();
            }

        }
        else
        {
            
            hdnQty.Value = QuantityCount.ToString();
            string sPath = Resources.InventoryCommon_AppMsg.InventoryCommon_Controls_INVStockUsage_ascx_01;
            string sError = Resources.InventoryCommon_AppMsg.InventoryCommon_Error;
            if (sPath == null)
            {
                sPath = "Product quantity has been exceeded";
            }
            if (sError == null)
            {
                sError = "Error";
            }
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "QtyExceed", "javascript:ValidationWindow('" + sPath + "','" + sError + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "QtyExceed", "alert('Product quantity has been exceeded');", true);
        }
        dtUsageAttValues = (DataTable)ViewState["UsageAttributes"];
        DataTable dt = new DataTable();
        dt = dtUsageAttValues.Copy();
        if (hdnActionFlag.Value == "Add")
        {
            string IsIssued = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_11;
            if (IsIssued == null)
            {
                IsIssued = "IsIssued";
            }
            string Description = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_12;
            if (Description == null)
            {
                Description = "Description";
            }
            dt.Columns.Remove("IsIssued");
            dt.Columns.Remove("Description");
            dt.AcceptChanges();
        }
        gvAttributeValues.DataSource = dt;
        gvAttributeValues.DataBind();
        gvAttributeValues.Visible = true;
        ModalPopupExtender1.Show();

    }

    protected bool BindAttributeValues(string pFlag)
    {
        bool retFlag = false;
        try
        {

            bool exist = false;
            DataTable tempAttributes = new DataTable();
            DataTable dtAttributes = new DataTable();
            if (ViewState["Attributes"] != null)
            {
                objAttributes = (DataTable)ViewState["Attributes"];
                dtAttributes = objAttributes.Copy();
                tempAttributes = (DataTable)ViewState["dtTemplate"];
                if (ViewState["UsageAttributes"] != null)
                {
                    dtUsageAttValues = (DataTable)ViewState["UsageAttributes"];
                }
                else
                {
                    dtUsageAttValues.Merge(objAttributes);
                    dtUsageAttValues.Clear();
                }
            }
            tempAttributes.Clear();
            DataRow dr;
            dr = tempAttributes.NewRow();
            foreach (DataRow item in dtAttributes.Rows)
            {
                foreach (GridViewRow row in gvAttributes.Rows)
                {
                    Label AttributeName = (Label)row.FindControl("lblAttributes");
                    TextBox txtAttributeValues = (TextBox)row.FindControl("txtAttributeValues");
                    HiddenField hdnIsMandatory = (HiddenField)row.FindControl("hdnIsMandatory");
                    HiddenField hdnValues = (HiddenField)row.FindControl("hdnValues");
                    if (txtAttributeValues.Text == "")
                    {
                        txtAttributeValues.Text = "N/A";
                    }
                    if (item[AttributeName.Text].ToString() == txtAttributeValues.Text)
                    {
                        dr[AttributeName.Text] = txtAttributeValues.Text;
                    }
                }
            }

            tempAttributes.Rows.Add(dr);
            Utilities.ConvertTo(dtAttributes, out lstAttributeValue);
            Utilities.ConvertTo(tempAttributes, out lstTmpAttributeValue);
            if (lstTmpAttributeValue.Count > 0)
            {
                if (lstAttributeValue.Exists(P => P.ProductNo == lstTmpAttributeValue[0].ProductNo && P.SerialNo == lstTmpAttributeValue[0].SerialNo && P.IsIssued=="N"  && P.OtherValue == lstTmpAttributeValue[0].OtherValue))
                {
                    exist = true;
                }
            }
            if (exist)
            {

                dtUsageAttValues.Columns["UnitNo"].SetOrdinal(0);
                Utilities.ConvertTo(dtUsageAttValues, out lstAttributeValue);
                if (lstAttributeValue.Exists(P => P.ProductNo == lstTmpAttributeValue[0].ProductNo && P.SerialNo == lstTmpAttributeValue[0].SerialNo && P.IsIssued == "N"  && P.OtherValue == lstTmpAttributeValue[0].OtherValue))
                {
                    string sPath = Resources.InventoryCommon_AppMsg.InventoryCommon_Controls_INVStockUsage_ascx_02;
                    string sError = Resources.InventoryCommon_AppMsg.InventoryCommon_Error;
                    if (sPath == null)
                    {
                        sPath = "Cannot be added multiple times";
                    }
                    if (sError == null)
                    {
                        sError = "Error";
                    }
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "MultipleAdd", "javascript:ValidationWindow('" + sPath + "','" + sError + "');", true);
                //ScriptManager.RegisterStartupScript(Page, this.GetType(), "MultipleAdd", "alert('Cannot be added multiple times')", true);

                    // Literal1.Text = "Cannot Be Added Multiple Times";
                    // Literal1.Visible = true;
                    retFlag = false;
                }
                else
                {
                    dtUsageAttValues.Merge(tempAttributes, true, MissingSchemaAction.Ignore);
                    ViewState["UsageAttributes"] = dtUsageAttValues;
                    //   Literal1.Text = "Product Detail Exist";
                    //   Literal1.Visible = true;
                    retFlag = true;
                }


            }
            else
            {
                string sPath = Resources.InventoryCommon_AppMsg.InventoryCommon_Controls_INVStockUsage_ascx_03;
                string sError = Resources.InventoryCommon_AppMsg.InventoryCommon_Error;
                if (sPath == null)
                {
                    sPath = "Product Detail Does not Exist";
                }
                if (sError == null)
                {
                    sError = "Error";
                }
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "NotExist", "javascript:ValidationWindow('" + sPath + "','" + sError + "');", true);
               // ScriptManager.RegisterStartupScript(Page, this.GetType(), "NotExist", "alert('Product Detail Does not Exist')", true);
                //Literal1.Text = "Product Detail Doesn't Exist";
                //Literal1.Visible = true;
                ViewState["UsageAttributes"] = dtUsageAttValues;
                retFlag = false;
            }



            #region
            //DataRow dr,dr1;
            //dr = objAttributes.NewRow();
            //dr1 = dtUsageAttValues.NewRow();
            //foreach (GridViewRow item in gvAttributes.Rows)
            //{
            //    Label AttributeName = (Label)item.FindControl("lblAttributes");
            //    TextBox txtAttributeValues = (TextBox)item.FindControl("txtAttributeValues");
            //    HiddenField hdnIsMandatory = (HiddenField)item.FindControl("hdnIsMandatory");
            //    HiddenField hdnValues = (HiddenField)item.FindControl("hdnValues");
            //    dr[AttributeName.Text] = txtAttributeValues.Text;
            //    dr1[AttributeName.Text] = txtAttributeValues.Text;
            //}
            ////DataRow dr1 = dr;
            //dtUsageAttValues.Columns.Remove("UnitNo");
            //dtUsageAttValues.AcceptChanges();
            //dr1.Table.Columns.Remove("UnitNo");
            //dr1.AcceptChanges();

            //foreach (DataRow itemRow in dtUsageAttValues.Rows)
            //{
            //    itemRow.Equals(dr1);

            //}
            //foreach (DataColumn itemTmpCol in dr1.Table.Columns)
            //{

            //    foreach (DataRow itemRow in dtUsageAttValues.Rows)
            //    {
            //        foreach (DataColumn itemCol in itemRow.Table.Columns)
            //        {
            //            if (itemTmpCol[] == itemCol)
            //            {
            //                exist = true;
            //                break;
            //            }
            //        }
            //        if (exist == true)
            //        {
            //            break;
            //        }
            //    }
            //    if (exist == true)
            //    {
            //        break;
            //    }
            //}      
            // dtUsageAttValues.Rows.Add(dr);
            // Utilities.ConvertTo(dtUsageAttValues,out lstTmpProductAttributes);
            //if (pFlag == "Usage")
            //{

            //    if (exist != true)
            //    {
            //        objAttributes.Rows.Add(dr);
            //    }
            //    else
            //    {
            //        Literal1.Text = "Product Detail Already Exist";
            //        Literal1.Visible = true;
            //    }


            //  if (objAttributes.Rows.Contains(dtUsageAttValues.Rows[0]))
            //if(lstProductAttributes.Exists(P=>P.AttributeName==lstTmpProductAttributes[0].AttributeName && P.AttributeValue==lstTmpProductAttributes[0].AttributeValue))
            //{
            //    Literal1.Text = "Product Detail Already Exist";
            //    Literal1.Visible = true;

            //}
            //else
            //{
            //    lstProductAttributes.Add(lstTmpProductAttributes[0]);
            //    Utilities.ConvertFrom(lstProductAttributes, out objAttributes);
            //}
            //}
            #endregion
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On Checking Product Attribute Values - INVAttributeUsage.ascx", ex);
            retFlag = false;
        }
        return retFlag;
    }

    protected void gvAttributeValues_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

        }
    }

    protected void gvAttributeValues_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (ViewState["UsageAttributes"] != null)
        {
            dtUsageAttValues = (DataTable)ViewState["UsageAttributes"];
        }
        if (e.CommandName == "rEdit")
        {
            foreach (DataRow item in dtUsageAttValues.Rows)
            {
                if (item["UnitNo"].ToString() == e.CommandArgument.ToString())
                {
                    break;
                }
            }
        }
        if (e.CommandName == "rDelete")
        {
            if (hdnQty.Value != null)
            {
                QuantityCount = int.Parse(hdnQty.Value);
            }
            foreach (DataRow item in dtUsageAttValues.Rows)
            {
                if (item["UnitNo"].ToString() == e.CommandArgument.ToString())
                {
                    dtUsageAttValues.Rows.Remove(item);
                    QuantityCount++;
                    break;
                }
            }
            hdnQty.Value = QuantityCount.ToString();
            dtUsageAttValues.AcceptChanges();
        }
        ViewState["UsageAttributes"] = dtUsageAttValues;
        gvAttributeValues.DataSource = dtUsageAttValues;
        gvAttributeValues.DataBind();
        ModalPopupExtender1.Show();
    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        try
        {
            string resultEx = string.Empty;
            QuantityCount = int.Parse(hdnQty.Value);
           
            if (ViewState["UsageAttributes"] != null)
            {
                dtUsageAttValues = (DataTable)ViewState["UsageAttributes"];

                hdnAttValue.Value = getProductAttributeValues(dtUsageAttValues);
                hdnExAttrip.Value = getProductExAttributeValues((DataTable)ViewState["Attributes"]);
                ModalPopupExtender1.Hide();
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "getAttrib", "SetAttrib()", true);

            }
           
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error On Adding Product Attribute Values - INVAttributeUsage.ascx", ex);
        }
        finally
        {
            ViewState.Remove("UsageAttributes");
            ViewState.Remove("dtTemplate");
            ViewState.Remove("Attributes");
        }

    }

    protected void btnClose_Click(object sender, EventArgs e)
    {
        ViewState.Remove("UsageAttributes");
        ViewState.Remove("dtTemplate");
        ViewState.Remove("Attributes");
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "getAttrib", "SetAttrib()", true);
        ModalPopupExtender1.Hide();
    }

    public string getProductAttributeValues(DataTable dt)
    {
        string strXml = string.Empty;
        bool pFlag;
        try
        {
            string AttributeValues = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_13;
            if (AttributeValues == null)
            {
                AttributeValues = "AttributeValues";
            }

            string Units = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_14;
            if (Units == null)
            {
                Units = "Units";
            }

            string sIsIssued = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_11;
            if (sIsIssued == null)
            {
                sIsIssued = "IsIssued";
            }
            string sDescription = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_12;
            if (sDescription == null)
            {
                sDescription = "Description";
            }

            XmlDocument xmlDoc = new XmlDocument();
            XmlNode declaration = xmlDoc.CreateNode(XmlNodeType.XmlDeclaration, null, null);
            xmlDoc.AppendChild(declaration);
            XmlElement root;
            root = xmlDoc.CreateElement(AttributeValues);
            xmlDoc.AppendChild(root);
            int i = 1;

            foreach (DataRow item in dt.Rows)
            {

                pFlag = true;
                XmlElement rootElt = xmlDoc.CreateElement(Units);

                root.AppendChild(rootElt);
                foreach (DataColumn col in item.Table.Columns)
                {
                    if (pFlag == true)
                    {
                        XmlAttribute unitAttrib = xmlDoc.CreateAttribute(col.ColumnName);
                        unitAttrib.Value = i.ToString();
                        rootElt.Attributes.Append(unitAttrib);
                        pFlag = false;
                    }
                    else
                    {
                        XmlAttribute prodAttribute = xmlDoc.CreateAttribute(col.ColumnName);
                        prodAttribute.Value = item[col.ColumnName].ToString();
                        rootElt.Attributes.Append(prodAttribute);
                    }
                }
                i++;
                XmlAttribute IsIssued = xmlDoc.CreateAttribute(sIsIssued);
                IsIssued.Value = "Y";
                rootElt.Attributes.Append(IsIssued);

                XmlAttribute Description = xmlDoc.CreateAttribute(sDescription);
                Description.Value = "";
                rootElt.Attributes.Append(Description);

                root.AppendChild(rootElt);
            }
            strXml = xmlDoc.InnerXml;
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing getProductAttributeValues in INVStockUsage", ex);
            return "";
        }
        return strXml;
    }

    public string getProductExAttributeValues(DataTable dt1)
    {
        string strXml = string.Empty;
        bool pFlag;
        try
        {
            string sIsIssued = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_11;
            if (sIsIssued == null)
            {
                sIsIssued = "IsIssued";
            }
            string sDescription = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_12;
            if (sDescription == null)
            {
                sDescription = "Description";
            }
            string UnitNo = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_06;
            if (UnitNo == null)
            {
                UnitNo = "UnitNo";
            }

            string ProductId = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_07;
            if (ProductId == null)
            {
                ProductId = "ProductId";
            }

            string AttributeValues = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_13;
            if (AttributeValues == null)
            {
                AttributeValues = "AttributeValues";
            }

            string Units = Resources.InventoryCommon_ClientDisplay.InventoryCommon_Controls_INVStockUsage_ascx_14;
            if (Units == null)
            {
                Units = "Units";
            }
            DataTable dt = getExdata(dt1, (DataTable)ViewState["UsageAttributes"]);

            dt.Columns[UnitNo].SetOrdinal(0);
            dt.Columns[ProductId].SetOrdinal(1);
            dt.Columns[sDescription].SetOrdinal(dt.Columns.Count - 1);
            dt.Columns[sIsIssued].SetOrdinal(dt.Columns.Count - 2);


            XmlDocument xmlDoc = new XmlDocument();
            XmlNode declaration = xmlDoc.CreateNode(XmlNodeType.XmlDeclaration, null, null);
            xmlDoc.AppendChild(declaration);
            XmlElement root;
            root = xmlDoc.CreateElement(AttributeValues);
            xmlDoc.AppendChild(root);
            int i = 1;



            foreach (DataRow item in dt.Rows)
            {

                pFlag = true;
                XmlElement rootElt = xmlDoc.CreateElement(Units);

                root.AppendChild(rootElt);
                foreach (DataColumn col in item.Table.Columns)
                {
                    if (pFlag == true)
                    {
                        XmlAttribute unitAttrib = xmlDoc.CreateAttribute(col.ColumnName);
                        unitAttrib.Value = i.ToString();
                        rootElt.Attributes.Append(unitAttrib);
                        pFlag = false;
                    }
                    else
                    {
                        XmlAttribute prodAttribute = xmlDoc.CreateAttribute(col.ColumnName);
                        prodAttribute.Value = item[col.ColumnName].ToString();
                        rootElt.Attributes.Append(prodAttribute);
                    }
                }
                i++;


                //XmlAttribute IsIssued = xmlDoc.CreateAttribute("IsIssued");
                //IsIssued.Value = 
                //rootElt.Attributes.Append(IsIssued);

                //XmlAttribute Description = xmlDoc.CreateAttribute("Description");
                //Description.Value = "";
                //rootElt.Attributes.Append(Description);

                root.AppendChild(rootElt);
            }
            strXml = xmlDoc.InnerXml;

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing getProductExAttributeValues in INVStockUsage", ex);
            return "";
        }
        return strXml;
    }

    private DataTable getExdata(DataTable dt1, DataTable objnew)
    {
        DataTable dt = new DataTable();
        List<AttributeValue> lsttempAttributeValue = new List<AttributeValue>();
        Utilities.ConvertTo(dt1, out lstAttributeValue);
        Utilities.ConvertTo(objnew, out lstTmpAttributeValue);

        foreach (AttributeValue item in lstAttributeValue)
        {
            AttributeValue item1 = lstTmpAttributeValue.Find(p => p.ProductNo == item.ProductNo && p.SerialNo == item.SerialNo  && p.OtherValue == lstTmpAttributeValue[0].OtherValue);
            if (item1 != null)
            {
                item1.IsIssued = "Y";
                lsttempAttributeValue.Add(item1);
            }
            else
            {

                item.IsIssued = "N";
                lsttempAttributeValue.Add(item);
            }

        }
        Utilities.ConvertFrom(lsttempAttributeValue, out dt);


        return dt;

    }

}
