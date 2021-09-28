using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.DataAccessEngine;
using System.Collections;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.InventoryKit.BL;
using Attune.Kernel.PlatForm.Utility;
public partial class Inventory_KitCreation : Attune_BasePage
{
    public Inventory_KitCreation()
        : base("InventoryKit_KitCreation_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    //long tolocation;
    List<InventoryItemsBasket> lstKitDetail = new List<InventoryItemsBasket>();
    List<KitMaster> lstKitMaster = new List<KitMaster>();
    InventoryKit_BL inventoryBL;
    string OrgName = string.Empty;
    int KitNos = 0;
    int Minimum = 0;
    int ReturnKitQty = 0;
    long KitMasterID = 0;
    int ReturnExpMonth = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryKit_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            ddlKitNames.Focus();
            lblDate.Text = DateTimeNow.ToExternalDate();

            loadKitNames();
            btnKit.Visible = false;

        }
        if (OrgName == "")
        {
            trMinimum.Attributes.Add("class", "hide");
            trNoKit.Attributes.Add("class", "hide");

        }
        else
        {

            trMinimum.Attributes.Add("class", "show");
            trNoKit.Attributes.Add("class","show");
            //btnKit.Visible = false;  
        }

        hdngridviewdata.Value = "";


    }

    private void loadKitNames()
    {
        inventoryBL.GetKitDetails(OrgID, out lstKitMaster);
        ddlKitNames.DataSource = lstKitMaster;
        ddlKitNames.DataTextField = "ProductName";
        ddlKitNames.DataValueField = "ProductID";
        ddlKitNames.DataBind();
        string select = Resources.InventoryKit_ClientDisplay.InventoryKit_Select;
        select = select == null ? "--Select--" : select;
        ddlKitNames.Items.Insert(0, new ListItem(select, "0"));



    }


    protected void ddlKitNames_SelectedIndexChanged(object sender, EventArgs e)
    {
        Trace.Write("Hey, there");
        clearAll();
        KitMasterID = Convert.ToInt64(ddlKitNames.SelectedValue);
        AutoCompleteProduct.ContextKey = KitMasterID.ToString();
        inventoryBL.pGetKitMasterDetails(OrgID, InventoryLocationID, KitMasterID, out lstKitDetail);
        if (lstKitDetail.Count > 0)
        {
            if (lstKitDetail[0].IsTransactionBlock == "N")
            {
                inventoryBL.GetKitBatchCount(KitMasterID, OrgID, ILocationID, LID, InventoryLocationID, KitNos, Minimum, out  ReturnKitQty, out ReturnExpMonth);
                if (ReturnKitQty > 0)
                {
                    hdnKitBatchQty.Value = ReturnKitQty.ToString();
                }
                if (ReturnExpMonth > 0)
                {
                    hdnExpMonth.Value = ReturnExpMonth.ToString();
                }


                if (lstKitDetail.Count > 0)
                {
                    if (OrgName == "")
                    {


                        btnSubmit.Visible = true;
                        btnKit.Visible = false;
                        gvtable.Attributes.Add("class", "show");
                        tblProducts.Attributes.Add("class", "show");
                        trMinimum.Attributes.Add("class", "hide");
                        trNoKit.Attributes.Add("class", "hide");
                    }
                    else
                    {
                        btnSubmit.Visible = true;
                        gvtable.Attributes.Add("class", "show");
                        tblProducts.Attributes.Add("class", "hide");
                        btnKit.Visible = false;
                    }
                    gvKitDetails.DataSource = lstKitDetail;
                    gvKitDetails.DataBind();
                }
                foreach (InventoryItemsBasket itm in lstKitDetail)
                {
                    hdngridviewdata.Value += itm.ID + "~" + itm.ProductID + "~" + itm.ProductName + "~" + itm.Quantity + "~" + itm.InHandQuantity + "^";

                }
            }
            else if (lstKitDetail[0].IsTransactionBlock == "Y")
            {
                btnSubmit.Visible = false;
                btnKit.Visible = false;

                string sPath = Resources.InventoryKit_AppMsg.InventoryKit_KitCreation_aspx_KitInactive;
                string errorMsg = Resources.InventoryKit_AppMsg.InventoryKit_Error;
                sPath = sPath == null ? "This Kit is Currently in inactive status, Contact Admin!" : sPath;
                errorMsg = errorMsg == null ? "Error" : errorMsg;
                ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);

                gvtable.Attributes.Add("class", "hide");
                tblProducts.Attributes.Add("class", "hide");
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        long returncode = -1;

        DateTime Minimumlife = DateTimeNow;
        Minimum = txtMinimumlife.Text == "" ? 0 : Convert.ToInt16(txtMinimumlife.Text);
        string BatchNo = string.Empty;
        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
        lstInventoryItemsBasket = GetCollectedItems();
        long Masterkitid = Convert.ToInt64(ddlKitNames.SelectedValue);
        KitNos = txtKitNos.Text == "" ? 1 : Convert.ToInt16(txtKitNos.Text);

        if (lstInventoryItemsBasket.Count > 0)
        {

            returncode = inventoryBL.InsertKitPrepMaster(Masterkitid, OrgID, ILocationID, LID, InventoryLocationID, lstInventoryItemsBasket, out BatchNo);


        }
        if (returncode > 0)
        {
            hdnProductList.Value = "";
            hdngridviewdata.Value = "";
            ddlKitNames.SelectedIndex = 0;
            gvtable.Attributes.Add("class", "hide");
            tblProducts.Attributes.Add("class", "hide");
            Response.Redirect("PrintKitCreationDetail.aspx?KitID=" + Masterkitid + "&KitBatchNo=" + BatchNo);
        }

    }
    private List<InventoryItemsBasket> GetCollectedItems()
    {

        List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();

        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string Isreimbursable = string.Empty;
                InventoryItemsBasket newBasket = new InventoryItemsBasket();
                string[] listChild = listParent.Split('~');
                newBasket.ID = Convert.ToInt64(listChild[10]);
                newBasket.ProductName = listChild[1];
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);//InhandQnty
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
                newBasket.Rate = Convert.ToDecimal(listChild[7]);
                newBasket.Tax = Convert.ToDecimal(listChild[8]);
                newBasket.ExpiryDate = DateTime.Parse(listChild[9]);
                newBasket.CategoryID = Convert.ToInt16(listChild[11]);
                newBasket.Manufacture = DateTimeNow;
                newBasket.AttributeDetail = "N";
                newBasket.Providedby = Convert.ToInt64(listChild[12]);
                newBasket.CategoryName = txtComments.Text;
                newBasket.UnitPrice = Convert.ToDecimal(listChild[13]);
                newBasket.HasBatchNo = listChild[14] == "Y" ? "Y" : "N";
                newBasket.ProductReceivedDetailsID = Convert.ToInt64(listChild[15]);
                //newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                //               + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.Unit;
                
                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        return lstInventoryItemsBasket;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {

        hdnProductList.Value = "";
        ddlKitNames.SelectedIndex = 0;
        gvtable.Attributes.Add("class", "hide");
        txtComments.Text = "";
        tblProducts.Attributes.Add("class", "hide");
        hdngridviewdata.Value = "";



    }

    public void clearAll()
    {
        hdnProductList.Value = "";
        hdngridviewdata.Value = "";
        txtComments.Text = "";
        txtMinimumlife.Text = "";
        txtKitNos.Text = "";

    }


    protected void btnKit_Click(object sender, EventArgs e)
    {
        long returncode = -1;

        DateTime Minimumlife = DateTimeNow;
        Minimum = txtMinimumlife.Text == "" ? 0 : Convert.ToInt16(txtMinimumlife.Text);
        string BatchNo = string.Empty;
        long Masterkitid = Convert.ToInt64(ddlKitNames.SelectedValue);
        KitNos = txtKitNos.Text == "" ? 0 : Convert.ToInt16(txtKitNos.Text);

        if (Convert.ToInt32(hdnKitBatchQty.Value.ToString()) >= KitNos)
        {
            returncode = inventoryBL.InsertKitCreation(Masterkitid, OrgID, ILocationID, LID, InventoryLocationID, KitNos, Minimumlife, Minimum, out ReturnKitQty);
        }
        if (ReturnKitQty > 0)
        {
            string sPath = Resources.InventoryKit_AppMsg.InventoryKit_KitCreation_aspx_KitBatch;
            string errorMsg = Resources.InventoryKit_AppMsg.InventoryKit_Information;
            sPath = sPath == null ? "KitBatch has been created Successfully" : sPath;
            errorMsg = errorMsg == null ? "Information" : errorMsg;
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "mm", "javascript:ValidationWindow('" + sPath + "','" + errorMsg + "');", true);
            //ScriptManager.RegisterStartupScript(Page, this.GetType(), "Kitdetailsadd", "alert(" + ReturnKitQty + "''KitBatch has been created Successfully ');", true);
            hdnProductList.Value = "";
            hdngridviewdata.Value = "";
            hdnKitBatchQty.Value = "";
            hdnExpMonth.Value = "";
            ddlKitNames.SelectedIndex = 0;
            gvtable.Attributes.Add("class", "hide");
            tblProducts.Attributes.Add("class", "hide");
            txtKitNos.Text = "";
            txtMinimumlife.Text = "";
            txtComments.Text = "";
            //Response.Redirect("PrintKitCreationDetail.aspx?KitID=" + Masterkitid + "&KitBatchNo=" +BatchNo);

        }


    }
}
