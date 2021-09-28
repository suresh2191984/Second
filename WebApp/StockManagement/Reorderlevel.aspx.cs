using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.IO;
using System.Text;
using System.Data;
using System.Web.UI.HtmlControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.InventoryCommon.BL;

public partial class StockManagement_Reorderlevel : Attune_BasePage
{
    public StockManagement_Reorderlevel()
        : base("StockManagement_Reorderlevel_aspx")
   {
   }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    ArrayList al = new ArrayList();
    protected void Page_Load(object sender, EventArgs e)
    {
        LoadCountOrderedQty();
        //if (ViewState["SelectedProds"] != null)
        //{
        //    al = (ArrayList)ViewState["SelectedProds"];
        //}
        //if (!IsPostBack)
        //{
        ////{
        ////    LoadStockInHand();
        //    //ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:GetReorderLevelDetails(); ", true);

        //}
        // btnBillShow.PostBackUrl = "~/Inventory/SuplierPurchaseOrder.aspx";
    }
    private void LoadCountOrderedQty()
    {
       // string ProductName = txtProductName.Text;
	     string ProductName = "";
      
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        InventoryCommon_BL inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        inventoryBL.GetStockInHandDetails(OrgID, ILocationID, InventoryLocationID, 0, ProductName, out lstInventoryItemsBasket);
        //if (lstInventoryItemsBasket.Count > 0)
        //{
        //    if (lstInventoryItemsBasket[0].ProductID != null && lstInventoryItemsBasket[0].ProductID.ToString() != "")
        //    {
        //        hdnProductId.Value += lstInventoryItemsBasket[0].ProductID;
                 
        //    }
        //}
        
      /*  if (CheckBox1.Checked == true)  
        {
            chkSelectAll.Checked = false;
            //grdResult.DataSource = lstInventoryItemsBasket.FindAll(P => P.OrderedQty > 0).ToList();
            //grdResult.DataBind();
 			lstInventoryItemsBasket = lstInventoryItemsBasket.FindAll(P => P.OrderedQty > 0).ToList();
           // lstInventoryItemsBasket = lstInventoryItemsBasket.FindAll(P => P.OrderedQty == 0  ).ToList();
            
        }
            
        else
        {
            chkSelectAll.Checked = true;
           // grdResult.DataSource = lstInventoryItemsBasket.FindAll(P => P.OrderedQty == 0).OrderByDescending(P => P.OrderedQty == 0).ToList();
           // grdResult.DataBind();
            lstInventoryItemsBasket = lstInventoryItemsBasket.FindAll(P=>P.OrderedQty == 0 && P.Description == "Y").ToList();//.OrderByDescending(P => P.OrderedQty == 0).ToList();
             //lstInventoryItemsBasket.FindAll(P=>(P.Description=="Y") &&(P.OrderedQty==0)).ToList();
          //  lstInventoryItemsBasket = lstInventoryItemsBasket.Where((P => P.Description == "Y").Select(P => P.OrderedQty == 0)).ToList();
           
           
        }*/
        
        lblorderQty.Text = lstInventoryItemsBasket.FindAll( p => p.OrderedQty > 0 && p.Description=="N").Count + "  Product already placed an order";
       // txtorderQty.CssClass = "grdchecked";
       //txtReachedReorder.BackColor = System.Drawing.Color.Orange;
    }
  /*  protected void grdResult_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        if (e.NewPageIndex != -1)
        {
            grdResult.PageIndex = e.NewPageIndex;
            LoadStockInHand();
            txtProductName.Text = "";
        }
    }
    public void grdResult_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        string prodID = string.Empty;
        string prodFName = string.Empty;
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket obj = (InventoryItemsBasket)e.Row.DataItem;

                for (int i = 0; i < al.Count; i++)
                {
                    prodFName = al[i].ToString();

                    prodID = prodFName.Split('~')[0].ToString();

                    if (obj.ProductID == Convert.ToInt64(prodID))
                    {
                        ((CheckBox)e.Row.FindControl("chkBox")).Checked = true;
                    }
                }
                if (obj.Description == "Y")
                {
                    e.Row.BackColor = System.Drawing.Color.Orange;                    
                    if ((obj.Description == "Y") && (obj.OrderedQty == 0))
                    {
                        ((CheckBox)e.Row.FindControl("chkBox")).Checked = true;
                    }
                    e.Row.CssClass = "grdcheck";
                    e.Row.ToolTip = "This product is reached the reorder level";

                }
                if (obj.OrderedQty > 0)
                {
                    //e.Row.Style.Add("Background-color", "#95B546");
                    e.Row.CssClass = "grdchecked";
                    e.Row.ToolTip = "This product is already been ordered";
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading StockInHand Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
        }
    }
*/
   /* void AddToViewState()
    {
        long prodID = -1;
        string prodName = string.Empty;
        string strProduct = string.Empty;
        string IsChecked = string.Empty;
        bool blnExists = false;
        string ProductDetails = string.Empty;
        string[] hiddenIDs = new string[] { };
        ArrayList alTemp = al;

        foreach (GridViewRow row in grdResult.Rows)
        {
            if (row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkBox = (CheckBox)row.FindControl("chkBox");
                if (chkBox.Checked)
                {
                    prodID = Convert.ToInt64(grdResult.DataKeys[row.RowIndex][0].ToString());
                    prodName = grdResult.DataKeys[row.RowIndex][1].ToString();
                    strProduct = prodID.ToString() + "~" + prodName;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            if (al[i].ToString() == strProduct)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (!blnExists)
                        {
                            alTemp.Add(strProduct);
                        }
                    }
                    else
                    {
                        alTemp.Add(strProduct);
                    }
                }
                else
                {
                    prodID = Convert.ToInt64(grdResult.DataKeys[row.RowIndex][0].ToString());
                    prodName = grdResult.DataKeys[row.RowIndex][1].ToString();
                    strProduct = prodID.ToString() + "~" + prodName;

                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {

                            if (al[i].ToString() == strProduct)
                            {
                                blnExists = true;
                                break;
                            }
                        }
                        if (blnExists)
                        {
                            alTemp.Remove(strProduct);
                        }
                    }
                }
            }
        }
        ViewState["SelectedProds"] = alTemp;
    }

    protected void btnBillShow_Click(object sender, EventArgs e)
    {
        string str = string.Empty;

        AddToViewState();
        ArrayList alTemp = (ArrayList)ViewState["SelectedProds"];

        for (int i = 0; i < alTemp.Count; i++)
        {
            str += alTemp[i].ToString() + "^";
        }
        if (str != string.Empty)
        {
            hdnValue.Value = str;
        }
        //Response.Redirect("~/Inventory/SuplierPurchaseOrder.aspx");
    }
*/

    protected void lnkBack_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("../Reports/ViewReportList.aspx", true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Redirecting to Home Page", ex);
        }
    }
  /*  protected void btnSearch_Click(object sender, EventArgs e)
    {
        LoadStockInHand();
        txtProductName.Text = "";
    }

    protected void imgBtnXL_Click(object sender, EventArgs e)
    {
        try
        {


            LoadStockInHand();

            ExportToExcel(grdResult);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    public void ExportToExcel(Control CTR)
    {
        //export to excel
        try
        {
            string attachment = "attachment; filename=ReorderLevelReport.xls";
            Response.ClearContent();
            Response.AddHeader("content-disposition", attachment);
            Response.Clear();
            //Response.AddHeader("content-disposition",
            //string.Format("attachment;filename={0}.xls", "ReorderLevelReport"));
            Response.Charset = "";
            Response.ContentType = "application/vnd.xls";

            StringWriter stringWrite = new StringWriter();
            HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
            grdResult.RenderControl(htmlWrite);


            Response.Write(stringWrite.ToString());
            Response.End();
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }



    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        txtProductName.Text = "";
        LoadStockInHand();
      
    }
}
*/
  protected void btnBillShow_Click(object sender, EventArgs e)
    {
     
      //ViewState["hdnvalue"] =hdnvalue.Value;
        Session["values"] = hdnvalue.Value;
      Response.Redirect("~/PurchaseOrder/SuplierPurchaseOrder.aspx");
       
    }
}