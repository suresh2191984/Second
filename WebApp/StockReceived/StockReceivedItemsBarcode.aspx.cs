using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.BusinessEntities;
using Attune.Kernel.StockReceive.BL;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.BL;
using System.Data;
using Attune.Kernel.PlatForm.Common;

public partial class LabConsumptionInventory_StockReceivedItemsView : Attune_BasePage
{

    #region CommonDeclaration

    StockReceived_BL  objStockReceived_BL;
    List<StockReceivedBarcodeDetails> lstSRBD;

    static long SRDID, PRUN, ProductID, gvLocationID;
    static string IsUniqueBarcode;
    List<InventoryConfig> lstInventoryConfig;
    //string 

    #endregion



    public LabConsumptionInventory_StockReceivedItemsView()
        : base("LabConsumptionInventory_StockReceivedItemsView")
    { }

    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            LoadStockReceivedDetalis();
        }

        
        lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("HideNonUniqueBarcode", OrgID, ILocationID, out lstInventoryConfig);

        if (lstInventoryConfig.Count > 0 && lstInventoryConfig[0].ConfigKey == "Y")
        {
            tdcheIsUniqueBarcode.Attributes.Add("class", "display-td");
        }
    }

    private void LoadStockReceivedDetalis()
    {
        objStockReceived_BL = new StockReceived_BL(base.ContextInfo);
      

        List<Organization> lstOrganization = new List<Organization>();
        List<Suppliers> lstSuppliers = new List<Suppliers>();
        List<StockReceived> lstStockReceived = new List<StockReceived>();
        List<StockReceivedDetails> lstSRD = new List<StockReceivedDetails>();


        long SRDID = 0;

        try
        {

            if (Request.QueryString["ID"] != null)
            {
                SRDID = long.Parse(Request.QueryString["ID"]);
            }

            objStockReceived_BL.GetStockReceivedDetailsBarCodeItems(OrgID,ILocationID,SRDID,out lstOrganization, out lstSuppliers, out lstStockReceived, out lstSRD);
           // objConInvBL.GetStockReceivedDetailsBarCodeItems(OrgID, ILocationID, SRDID, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstSRD);

            if (lstSuppliers.Count > 0 && lstStockReceived.Count > 0)
            {
                lblSupplierValue.Text = lstSuppliers[0].SupplierName;
                lblDateValue.Text = lstStockReceived[0].StockReceivedDate.ToExternalDate();
                lblPoNoValue.Text = lstStockReceived[0].PurchaseOrderNo;
                lblSRDNoValue.Text = lstStockReceived[0].StockReceivedNo;
                lblInvoiceNoValue.Text = lstStockReceived[0].InvoiceNo;
                lblSRDNoValue.Text = lstStockReceived[0].StockReceivedNo;
                lblStatusValue.Text = lstStockReceived[0].Status;
                lblDCNoValue.Text = lstStockReceived[0].DCNumber;
            }
            if (lstSRD.Count > 0)
            {
                gvSRDBarcode.DataSource = lstSRD;
                gvSRDBarcode.DataBind();

            }




        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on BindInventoryUOM in StockReceivedItemsView.aspx", ex);
        }
    }

    protected void gvSRDBarcode_RowCommand(object sender, GridViewCommandEventArgs e)
    {


        try
        {
            GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
            int rowIndex = row.RowIndex;


            HiddenField objStockReceivedId = (HiddenField)gvSRDBarcode.Rows[rowIndex].FindControl("hdnStockReceivedId");
            HiddenField objProductId = (HiddenField)gvSRDBarcode.Rows[rowIndex].FindControl("hdnProductId");
            HiddenField objLocationID = (HiddenField)gvSRDBarcode.Rows[rowIndex].FindControl("hdnLocationID");
            HiddenField objProductReceivedDetailsID = (HiddenField)gvSRDBarcode.Rows[rowIndex].FindControl("hdnProductReceivedUniqueNumber");
            HiddenField objIsUniqueBarcode = (HiddenField)gvSRDBarcode.Rows[rowIndex].FindControl("hdnIsUniqueBarcode");
            

            SRDID = Convert.ToInt64(objStockReceivedId.Value);
            PRUN = Convert.ToInt64(objProductReceivedDetailsID.Value);
            ProductID = Convert.ToInt64(objProductId.Value);
            IsUniqueBarcode = objIsUniqueBarcode.Value;
            gvLocationID = Convert.ToInt64(objLocationID.Value);

            if (e.CommandName == "BarcodeGenerate")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                Label objlblSellingUnit = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblSellingUnit");
                Label objlblRecUnit = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblRecUnit");                
                Label objlblInvoiceQty = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblInvoiceQty");
                Label objlblReceivedQty = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblReceivedQty");
                Label objlblComplimentQTY = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblComplimentQTY");
                Label objlblRECQuantity = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblRECQuantity");
                Label objlblProductName = (Label)gvSRDBarcode.Rows[rowIndex].FindControl("lblProductName");


                if (cheAutoBarCode.Checked == false)
                {
                    GenarateUserDefiendUniqueBarcode(objlblSellingUnit.Text, objlblRecUnit.Text, objlblProductName.Text,
                        Convert.ToInt16(Convert.ToDecimal(objlblRECQuantity.Text)), Convert.ToInt16(Convert.ToDecimal(objlblInvoiceQty.Text)),
                        Convert.ToInt16(Convert.ToDecimal(objlblReceivedQty.Text)), Convert.ToInt16(Convert.ToDecimal(objlblComplimentQTY.Text)),
                          ProductID, PRUN);
                }
                else if (cheAutoBarCode.Checked == true)
                {
                    AutoGenerateProductBarCode(SRDID, PRUN, ProductID);
                    LoadStockReceivedDetalis();
                }
                

                MPEBarCode.Show();
                if (cheIsUniqueBarcode.Checked == false)
                {
                    IsUniqueBarcode = "N";
                    gvBarcodeDetails.Columns[0].Visible = false;
                    gvBarcodeDetails.Columns[5].Visible = false;
                }
                else
                {
                    IsUniqueBarcode = "Y";
                    gvBarcodeDetails.Columns[0].Visible = true;
                    gvBarcodeDetails.Columns[5].Visible = true;
                                      
                }
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ViewBarcode", "disabledBarcodeTextBox();", true);

                
                
            }
            else if (e.CommandName == "PrintBarcode")
            {
                Response.Redirect("PrintProductBarcode.aspx?PRUN=" + PRUN.ToString() + "&ProductID=" + ProductID.ToString() + "&LID=" + gvLocationID.ToString() + "&IUB=" + IsUniqueBarcode + "&SRDID=" + SRDID + "");
            }
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on gvSRDBarcode_RowCommand in StockReceivedItemsView.aspx", ex);
        }
    }


    protected void gvBarcodeDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField hdnStockReceivedBarcodeID = (HiddenField)e.Row.FindControl("gvBD_StockReceivedBarcodeID");

            GridView gvChildBarcode = (GridView)e.Row.FindControl("gvBD_gvChildBarcode");
            var childBarCode = lstSRBD.Where(lstCH => lstCH.StockReceivedBarcodeID.Equals(Convert.ToInt64(hdnStockReceivedBarcodeID.Value)) && lstCH.ActionType == "CB").ToList();

            if (childBarCode.Count > 0 && cheIsUniqueBarcode.Checked == true)
            {
                gvChildBarcode.DataSource = childBarCode;
                gvChildBarcode.DataBind();
            }
            else
            {
                gvChildBarcode.DataSource = null;
                gvChildBarcode.DataBind();
            }
        }


    }

    protected void gvSRDBarcode_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            HiddenField objhdnBarcodeStatus = (HiddenField)e.Row.FindControl("hdnBarcodeStatus");
            LinkButton objlnkbtn = (LinkButton)e.Row.FindControl("lnkbtn");
            LinkButton lknPrintBarcode = (LinkButton)e.Row.FindControl("lknPrintBarcode");
            
            if (objhdnBarcodeStatus.Value == "Genarated")
            {
                objlnkbtn.Attributes.Add("class", "hide");
                
            }
            else {
                lknPrintBarcode.Attributes.Add("class", "hide");
                
                
            }
        }


    }

    protected void btnSave_Click(object sender, EventArgs e)
    {

        JavaScriptSerializer JSserializer = new JavaScriptSerializer();
        List<StockReceivedBarcodeDetails> lstSRDBarCode = new List<StockReceivedBarcodeDetails>();
        objStockReceived_BL = new StockReceived_BL(base.ContextInfo);
        long returncode = -1, ReceivedUniqueNumber;
        string ReturnExBarcode = string.Empty;

        try
        {
            lstSRDBarCode = JSserializer.Deserialize<List<StockReceivedBarcodeDetails>>(hdnBarcodeList.Value);

            returncode = objStockReceived_BL.InsertUserDefiendProductBarcode(OrgID, InventoryLocationID, lstSRDBarCode, out ReceivedUniqueNumber, out ReturnExBarcode);

            if (ReturnExBarcode == "Y")
            {

                string strIsUniqueBarcode = cheIsUniqueBarcode.Checked == true ? "Y" : "N";
                PRUN = ReceivedUniqueNumber; ProductID = lstSRDBarCode[0].ProductID; 
                Response.Redirect("PrintProductBarcode.aspx?PRUN=" + PRUN.ToString() + "&ProductID=" + ProductID.ToString() + "&LID=" + InventoryLocationID.ToString() + "&IUB=" + strIsUniqueBarcode + "&SRDID=" + SRDID +"  ");
            }
            else {
                lblAlertMsg.Text = "This Barcode already exists in Database, Please check  " + ReturnExBarcode;
                MPEBarCode.Show();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "diplay", "DisPlayMessage();", true); 
            }
         
        }
        catch (Exception ex)
        {
            Attuneheader.LoadErrorMsg("There was a problem in page load. Please contact system administrator");
            CLogger.LogError("Error on btnSave_Click in StockReceivedItemsView.aspx", ex);
        }

    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {
            long returncode = 0;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returncode = new Attune_Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
       //string  strIsUniqueBarcode = cheIsUniqueBarcode.Checked == true ? "Y" : "N";
        Response.Redirect("PrintProductBarcode.aspx?PRUN=" + PRUN.ToString() + "&ProductID=" + ProductID.ToString() + "&LID=" + InventoryLocationID.ToString() + "&IUB=" + IsUniqueBarcode + "&SRDID=" + SRDID + " ");

    }


    private void GenarateUserDefiendUniqueBarcode(string SellingUnit, string RecUnit, string ProductName, int RECQuantity, int InvoiceQty, int ReceivedQty, int ComplimentQTY, long ProductID, long PRUniqueNumber)
    {
        lstSRBD = new List<StockReceivedBarcodeDetails>();
        long DummySRB_ID = 0;
        try
        {

            if (cheIsUniqueBarcode.Checked == true)
            {

                for (int RQ = 0; RQ < RECQuantity; RQ++)
                {
                    DummySRB_ID++;

                    lstSRBD.Add(new StockReceivedBarcodeDetails()
                                                    {

                                                        StockReceivedBarcodeDetailsID = 0,
                                                        StockReceivedBarcodeID = DummySRB_ID,
                                                        ReceivedUniqueNumber = PRUniqueNumber,
                                                        ProductID = ProductID,
                                                        ProductName = ProductName,
                                                        ParentBarCode = string.Empty,
                                                        BarcodeNo = string.Empty,
                                                        Status = string.Empty,
                                                        RecUnit = RecUnit,
                                                        SellingUnit = SellingUnit,
                                                        ActionType = "PB"
                                                    });

                    if (SellingUnit.ToUpper().Trim() == RecUnit.ToUpper().Trim())
                    {

                        for (int R = 0; R < ReceivedQty; R++)
                        {
                            lstSRBD.Add(new StockReceivedBarcodeDetails()
                            {
                                StockReceivedBarcodeDetailsID = 0,
                                StockReceivedBarcodeID = DummySRB_ID,
                                ReceivedUniqueNumber = PRUniqueNumber,
                                ProductID = ProductID,
                                ProductName = ProductName,
                                ParentBarCode = string.Empty,
                                BarcodeNo = string.Empty,
                                Status = string.Empty,
                                RecUnit = RecUnit,
                                SellingUnit = SellingUnit,
                                ActionType = "CB"
                            });
                        }

                        break;
                    }
                    else
                    {
                        for (int IQ = 0; IQ < InvoiceQty; IQ++)
                        {
                            lstSRBD.Add(new StockReceivedBarcodeDetails()
                            {

                                StockReceivedBarcodeDetailsID = 0,
                                StockReceivedBarcodeID = DummySRB_ID,
                                ReceivedUniqueNumber = PRUniqueNumber,
                                ProductID = ProductID,
                                ProductName = ProductName,
                                ParentBarCode = string.Empty,
                                BarcodeNo = string.Empty,
                                Status = string.Empty,
                                RecUnit = RecUnit,
                                SellingUnit = SellingUnit,
                                ActionType = "CB"
                            });


                        }
                    }



                }

                /* Compliment QTY */
                for (int IQ = 0; IQ < ComplimentQTY; IQ++)
                {
                    if (IQ == 0 && SellingUnit != RecUnit)
                    {
                        DummySRB_ID++;
                        lstSRBD.Add(new StockReceivedBarcodeDetails()
                        {
                            StockReceivedBarcodeDetailsID = 0,
                            StockReceivedBarcodeID = DummySRB_ID,
                            ReceivedUniqueNumber = PRUniqueNumber,
                            ProductID = ProductID,
                            ProductName = ProductName,
                            ParentBarCode = string.Empty,
                            BarcodeNo = string.Empty,
                            Status = string.Empty,
                            RecUnit = RecUnit,
                            SellingUnit = SellingUnit,
                            ActionType = "PB"
                        });
                    }

                    lstSRBD.Add(new StockReceivedBarcodeDetails()
                    {

                        StockReceivedBarcodeDetailsID = 0,
                        StockReceivedBarcodeID = DummySRB_ID,
                        ReceivedUniqueNumber = PRUniqueNumber,
                        ProductID = ProductID,
                        ProductName = ProductName,
                        ParentBarCode = string.Empty,
                        BarcodeNo = string.Empty,
                        Status = string.Empty,
                        RecUnit = RecUnit,
                        SellingUnit = SellingUnit,
                        ActionType = "CB"
                    });


                }
            }
            else
            {
                lstSRBD.Add(new StockReceivedBarcodeDetails()
                {
                    StockReceivedBarcodeDetailsID = 0,
                    StockReceivedBarcodeID = DummySRB_ID,
                    ReceivedUniqueNumber = PRUniqueNumber,
                    ProductID = ProductID,
                    ProductName = ProductName,
                    ParentBarCode = string.Empty,
                    BarcodeNo = string.Empty,
                    Status = string.Empty,
                    RecUnit = RecUnit,
                    SellingUnit = SellingUnit,
                    ActionType = "PB"
                });

            }


            var lstParBarCode = lstSRBD.Where(lPB => lPB.ActionType.Equals("PB")).ToList();

            if (lstParBarCode.Count > 0)
            {
                gvBarcodeDetails.DataSource = lstParBarCode;
                gvBarcodeDetails.DataBind();

                //if (lstParBarCode[0].Status.ToUpper() == "Generated".ToUpper())
                //{
                //    ScriptManager.RegisterStartupScript(this, this.GetType(), "ViewBarcode", "disabledBarcodeTextBox();", true);
                //}


            }



        }
        catch (Exception ex)
        {
            throw ex;
        }
        


    }


    private void AutoGenerateProductBarCode(long StockReceivedID,long ReceivedUniqueNumber,long ProductID)
    {
        
        lstSRBD = new List<StockReceivedBarcodeDetails>();
        objStockReceived_BL = new StockReceived_BL(base.ContextInfo);
        long returnCode = -1;
        string strcheIsUniqueBarcode= string.Empty;

        try
        {
            strcheIsUniqueBarcode = cheIsUniqueBarcode.Checked == true ? "Y" : "N";
            returnCode = objStockReceived_BL.pAutoGenerateProductBarCode(StockReceivedID, ReceivedUniqueNumber, ProductID,InventoryLocationID, OrgID, strcheIsUniqueBarcode, out lstSRBD);

            if (lstSRBD.Count > 0)
            {
                var lstParBarCode = lstSRBD.Where(lPB => lPB.ActionType.Equals("PB")).ToList();
                if (lstParBarCode.Count > 0)
                {
                    gvBarcodeDetails.DataSource = lstParBarCode;
                    gvBarcodeDetails.DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


}
