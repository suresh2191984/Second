using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using Attune.Kernel.BusinessEntities;
using System.Text;
using System.IO;
using System.Web.Script.Serialization;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.CentralPurchasing.BL;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using System.Web.UI.WebControls;
using Attune.Kernel.PerformingNextAction;


public partial class CentralPurchasing_ViewPurchaseOrderMedal : Attune_BasePage
{
    public CentralPurchasing_ViewPurchaseOrderMedal()
        : base("CentralPurchasing_ViewPurchaseOrderMedal_aspx")
    {
    }

    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<PurchaseOrders> lstPurchaseOrders = new List<PurchaseOrders>();
    List<PurchaseOrderMappingLocation> lstPurchaseOrderRaise = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstProductsMap = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstProductsMapToLoc = new List<PurchaseOrderMappingLocation>();
    List<PurchaseOrderMappingLocation> lstPOQuantityDetails = new List<PurchaseOrderMappingLocation>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    List<QuotationMaster> lstQuotationMaster = new List<QuotationMaster>();
    CentralPurchasing_BL inventoryBL;
    long returnCode = -1;
    long poID = 0;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    string POBasedonQty = string.Empty;
    string ShowProductDescription = string.Empty;
 
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new CentralPurchasing_BL(base.ContextInfo);
        ShowProductDescription = GetConfigValue("ShowProductDescription", OrgID);
        if (!IsPostBack)
        {
            if (Request.QueryString["POID"] != "" && Request.QueryString["POID"] != null)
            {
                poID = long.Parse(Request.QueryString["POID"]);
            }
            if (Request.QueryString["ID"] != "" && Request.QueryString["ID"] != null)
            {
                poID = long.Parse(Request.QueryString["ID"]);
            }
            if (Request.QueryString["ACN"] != "" && Request.QueryString["ACN"] != null)
            {
                tdBack.Attributes.Add("class", "displaytd a-right");
            }
            if (Request.QueryString["IsBasedOnQty"] != "" && Request.QueryString["IsBasedOnQty"] != null)
            {
                POBasedonQty = Request.QueryString["IsBasedOnQty"];
            }
            PrintDetails(poID);
         //   Notification();  ////Base on status mail send below

        }

    }

    private void Notification()
    {

        PageContextDetails.ButtonName = "btnPrint";
        PageContextDetails.ButtonValue = "Print";

        var mailbuilder = new StringBuilder();
        Divpo.RenderControl(new HtmlTextWriter(new StringWriter(mailbuilder)));

        string mailContent = mailbuilder.ToString();
        #region Notification
        ActionManager am = new ActionManager(base.ContextInfo);
        PageContextDetails.PatientID = 0;
        PageContextDetails.RoleID = RoleID;
        PageContextDetails.AccessionNo = "0";
        PageContextDetails.LabNo = 0;
        PageContextDetails.FinalBillID = 0;
        PageContextDetails.RegPatientID = 0;
        PageContextDetails.RateType = "0";
        PageContextDetails.FeeID = "0";
        PageContextDetails.RefundNo = "0";
        PageContextDetails.BillNumber = "0";
        PageContextDetails.PhoneNo = "";
        PageContextDetails.MessageTemplate = mailContent.ToString();
        PageContextDetails.IndentNo = Convert.ToInt64(Request.QueryString["POID"]);
        long returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
        #endregion

    }

    public void PrintDetails(long poID)
    {
        List<StockReceived> lstTaxType = new List<StockReceived>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();

        returnCode = new InventoryCommon_BL(base.ContextInfo).GetPurchaseOrderProductDetailsPrint(poID, OrgID, out lstOrganization, out lstSuppliers, out lstPurchaseOrders
            , out  lstPurchaseOrderRaise, out lstProductsMap, out lstQuotationMaster
            , out lstTaxType, out lstTaxmaster, out lstPOQuantityDetails);
        if (lstTaxType != null && lstTaxType.Count > 0)
        {
            SetTaxType(lstTaxType);
        }
        if (lstTaxmaster != null && lstTaxmaster.Count > 0)
        {
            JavaScriptSerializer objJSS = new JavaScriptSerializer();
            hdnGetTaxList.Value = objJSS.Serialize(lstTaxmaster);
        }
        if (lstOrganization.Count > 0)
        {
            lblOrgName.Text = "M/S" + "  " + lstOrganization[0].Name;
            lblstreet.Text = lstOrganization[0].Address; //+ "," + lstOrganization[0].City;
            lblPhonenumber.Text = lstOrganization[0].PhoneNumber;
            lblStreetAddress.Text = lstOrganization[0].Address;
            lblCity.Text = lstOrganization[0].City;
            lblPhone.Text = lstOrganization[0].PhoneNumber;
            lblEmail.Text = lstOrganization[0].Email;
            lblHeaderorg.Text = lstOrganization[0].Name;
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue != "")
                    tdlblOrgTIN.Attributes.Add("class", "displaytd");
                lblOrgTINNo.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            }

            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                if (lstInventoryConfig[0].ConfigValue != "")
                    tdlblOrgDL.Attributes.Add("class", "displaytd");
                lblOrgDLNo.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
            }
            lblNotes.Text = lstSuppliers[0].Termsconditions;
            
            string displayTool = Resources.CentralPurchasing_ClientDisplay.CentralPurchasing_ViewPurchaseOrderMedal_aspx_07;
            displayTool = displayTool == null ? "M/S" : displayTool;
            lblVendorName.Text = displayTool + lstSuppliers[0].SupplierName;
            //ends
            if (lstSuppliers[0].Address1 != "")
            lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
            lblVendorCity.Text = lstSuppliers[0].City;
            lblVendorPhone.Text = lstSuppliers[0].Phone;
            lblVendorEmail.Text = lstSuppliers[0].EmailID;
            //lblVendorContactPerson.Text = lstSuppliers[0].ContactPerson;
            if (lstSuppliers[0].SupplierCode != "")
            {
                tdsuppliervedorcode.Attributes.Add("class", "displaytd");
                lblVendorTINNo.Text = lstSuppliers[0].SupplierCode;
            }
            if (lstSuppliers[0].TinNo != "")
            {
                tdsupplierTinNo.Attributes.Add("class", "displaytd");
                lblsupplierTinno.Text = lstSuppliers[0].TinNo;
            }
            if (lstSuppliers[0].DrugLicenceNo != "")
            {
                tdSupplierDLNo.Attributes.Add("class", "displaytd");
                lblsupplierDLno.Text = lstSuppliers[0].DrugLicenceNo;
            }
            else if (lstSuppliers[0].DrugLicenceNo1 != "")
            {
                tdSupplierDLNo.Attributes.Add("class", "displaytd");
                lblsupplierDLno.Text = lstSuppliers[0].DrugLicenceNo1;
            }
            else if (lstSuppliers[0].DrugLicenceNo2 != "")
            {
                tdSupplierDLNo.Attributes.Add("class", "displaytd");
                lblsupplierDLno.Text = lstSuppliers[0].DrugLicenceNo2;
            }
            if (lstSuppliers[0].PanNo != "")
            {
                tdventorpanno.Attributes.Add("class", "displaytd");
                lblPanNotxt.Text = lstSuppliers[0].PanNo;
            }

           //  lblPODate.Text = lstPurchaseOrders[0].PurchaseOrderDate.ToShortDateString();
            lblPODate.Text = lstPurchaseOrders[0].PurchaseOrderDate.ToExternalDateTime();//.ToString("dd/MM/yyyy hh:mm tt");
            lblPOID.Text = lstPurchaseOrders[0].PurchaseOrderNo.ToString();
            lblStatus.Text = lstPurchaseOrders[0].Status;
            if (!string.IsNullOrEmpty(lstPurchaseOrders[0].Status) && lstPurchaseOrders[0].Status.Equals("Approved")
                && !string.IsNullOrEmpty(lstPurchaseOrders[0].ReceivableLocation))
            {
                litApprovedBy.Text = lstPurchaseOrders[0].ReceivableLocation;
                string strShowPODigitalSign = GetConfigValue("ShowPODigitalSign", OrgID);
                
                if(strShowPODigitalSign=="Y")
                {
		            GetUserImage(lstPurchaseOrders[0].ApproveDigitalSign);               
                }
            }
            else
            {
                litApprovedBy.Text = string.Empty;
            }
			if (!string.IsNullOrEmpty(lstPurchaseOrders[0].Status) && lstPurchaseOrders[0].Status.Equals("Pending")
                && !string.IsNullOrEmpty(lstPurchaseOrders[0].LocationName))
            {
                litPrepared.Text = lstPurchaseOrders[0].LocationName;
            }
            else
            {
                litPrepared.Text = string.Empty;
            }
          
            if (lstQuotationMaster.Count > 0)
            {
                Quotationref.Attributes.Add("class", "displaytr");
                QuotationDate.Attributes.Add("class", "displaytr");
                lblQuotationNo.Text = lstQuotationMaster[0].QuotationNo;

                lblVlaidDate.Text = lstQuotationMaster[0].ValidFrom.ToExternalDate() + " <strong> To </strong> " + lstQuotationMaster[0].ValidTo.ToExternalDate();

            }

            if (lstPurchaseOrders[0].Comments == "")
            {
                tdcomments.Attributes.Add("class", "hide");
                lblComments.Text = "--";
            }
            else
            {
                lblComments.Text = lstPurchaseOrders[0].Comments;
            }
            if (lstPurchaseOrders[0].FreightCharges.ToString() == "" || lstPurchaseOrders[0].FreightCharges == null)
            {
                lblFreightCouriercharges.Text = "--";
            }
            else
            {
                lblFreightCouriercharges.Text = lstPurchaseOrders[0].FreightCharges.ToString();
            }
            //if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Inprogress)
            //{
            //    lblStatus.Text = lstPurchaseOrders[0].Status;
            //    trApproveBlock.Style.Add("display", "block");
            //    tprint.Style.Add("display", "none");

            //}
            //else if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Inprogress)
            //{
            //    lblStatus.Text = lstPurchaseOrders[0].Status;
            //    trApproveBlock.Style.Add("display", "none");
            //}
            //else if (lstPurchaseOrders[0].Status == StockOutFlowStatus.Cancelled)
            //{
            //    lblStatus.Text = lstPurchaseOrders[0].Status;
            //    canOrder.Style.Add("display", "none");
            //}
            //else
            //{
            //    lblStatus.Text = lstPurchaseOrders[0].Status;
            //    trApproveBlock.Style.Add("display", "none");
            //    tprint.Style.Add("display", "block");
            //}
        }
      
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;

        //new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "PO Header", OrgID, ILocationID, out lstConfig);     
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PO Header", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {
            //tblBillPrint.Style.Add("background-image", "url('" + lstConfig[0].ConfigValue.Trim() + "'); ");
            imgBillLogo.ImageUrl = lstInventoryConfig[0].ConfigValue.Trim();
            if (lstInventoryConfig[0].ConfigValue.Trim() != "")
            {
                imgBillLogo.Attributes.Add("class", "inline-block");
            }
            else
            {
                imgBillLogo.Attributes.Add("class", "hide");
            }
        }
        else
        {
            imgBillLogo.Attributes.Add("class", "hide");
        }


        if (lstProductsMap.Count > 0 && lstPurchaseOrders[0].IsRate == true)
        {
            tdcalculation.Attributes.Remove("class");
            tdcalculation.Attributes.Add("class", "displaytd a-right");
            lstProductsMapToLoc = lstProductsMap.FindAll(p => p.ToLocationID != p.LocationId);
            grdResult.Visible = true;
            grdResult.DataSource = lstProductsMap;
            grdResult.DataBind();
            if (lstProductsMapToLoc.Count > 0)
            {
                grdResult.Columns[3].Visible = true;
            }
            else
            {
                grdResult.Columns[3].Visible = false;  
            }
            if (string.IsNullOrEmpty(ShowProductDescription))
            {
                grdResult.Columns[2].Visible = false;
            }
            else if (ShowProductDescription == "Y")
            {
                grdResult.Columns[2].Visible = true;
            }
            else
            {
                grdResult.Columns[2].Visible = false;
            }
            grdPOQuantityResult.Visible = false;
        }
        else
        {
            tdcalculation.Attributes.Remove("class");
            tdcalculation.Attributes.Add("class", "hide a-right");
            if (lstPOQuantityDetails.Count > 0)
            {
                grdResult.Attributes.Add("class", "hide");
                grdPOQuantityResult.Attributes.Add("class", "show");
                grdPOQuantityResult.DataSource = lstPOQuantityDetails;
                grdPOQuantityResult.DataBind();
            }
        }
        /// ----   Item level Discount Calculation-----------------
        decimal GetDiscount = Convert.ToDecimal(lblTotalDiscount.Text);
        decimal GetVat = Convert.ToDecimal(lblTotaltax.Text);
        decimal PoDiscount = 0;
        decimal PoDiscountAmount = 0;
        ///------------------End----------------------------

        if (lstPurchaseOrders.Count > 0)
        {
            PoDiscount = Convert.ToDecimal(lstPurchaseOrders[0].PoDiscount);
            PoDiscountAmount = (lstPurchaseOrders[0].GrossAmount * PoDiscount) / 100;
            lblGrossAmt.Text = lstPurchaseOrders[0].GrossAmount.ToString();
            lblPODisc.Text = lstPurchaseOrders[0].PoDiscount.ToString();
            lblTotalDiscount.Text = (Convert.ToDecimal(lblTotalDiscount.Text) + PoDiscountAmount).ToString("0.00"); ;
            //lblPOVat.Text = lstPurchaseOrders[0].POVat.ToString();
            //lblNetAmt.Text = (lstPurchaseOrders[0].NetAmount ).ToString();
          //  lblNetAmt.Text = (lstPurchaseOrders[0].NetAmount + GetVat - GetDiscount).ToString();
            lblNetAmt.Text = (lstPurchaseOrders[0].NetAmount).ToString("0.00");

            if (Request.QueryString["Ismail"] != null)
            {
                if (lstPurchaseOrders[0].Status == "Approved")
                    Notification();
            }
        }
        


    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("../CentralPurchasing/CentralPurchaseOrder.aspx", true);
            if (Request.QueryString["ACN"] != null)
            {
                string strACN = Request.QueryString["ACN"];
                Response.Redirect(@"~/InventoryCommon/InventorySearch.aspx?ACN=" + strACN, true);
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

    protected void grdResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PurchaseOrderMappingLocation imm = (PurchaseOrderMappingLocation)e.Row.DataItem;
            string approval = string.Empty;

            decimal iDiscount = 0;
            decimal iTax = 0;
            decimal iGrassTotal = 0;
            decimal iNetTotal = 0;
            decimal iTempNetTotal = 0;

            iGrassTotal = (Convert.ToDecimal(imm.Rate) * imm.Quantity);
            iDiscount = iGrassTotal * imm.Discount / 100;
            iTempNetTotal = iGrassTotal - iDiscount;
            iTax = iTempNetTotal * imm.Vat / 100;
            iNetTotal = iTax + iTempNetTotal;

            //lblTotalSales.Text = String.Format("{0:0.00}", Decimal.Parse(lblTotalSales.Text) + iGrassTotal);
            DiscountAmt += iDiscount;
            lblTotalDiscount.Text = String.Format("{0:0.00}", DiscountAmt);
            TaxAmt = TaxAmt + iTax;
            lblTotaltax.Text = String.Format("{0:0.00}", TaxAmt);
        }
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
    
    protected void SetTaxType(List<StockReceived> lstTaxType)
    {
        if (!string.IsNullOrEmpty(lstTaxType[0].PackingSale.ToString()))
        {
            lbltxtPackingSale.Text = lstTaxType[0].PackingSale.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].ExciseDuty.ToString()))
        {
            lbltxtExciseDuty.Text = lstTaxType[0].ExciseDuty.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].EduCess.ToString()))
        {
            lbltxtEduCess.Text = lstTaxType[0].EduCess.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].SecCess.ToString()))
        {
            lbltxtSecCess.Text = lstTaxType[0].SecCess.ToString();
        }

        if (!string.IsNullOrEmpty(lstTaxType[0].CST.ToString()))
        {
            lbltxtCST.Text = lstTaxType[0].CST.ToString();
        }
    }

    protected void grdPOQuantityResult_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            PurchaseOrderMappingLocation imm = (PurchaseOrderMappingLocation)e.Row.DataItem;
            string approval = string.Empty;

            decimal iDiscount = 0;
            decimal iTax = 0;
            decimal iGrassTotal = 0;
            decimal iNetTotal = 0;
            decimal iTempNetTotal = 0;

            iGrassTotal = (Convert.ToDecimal(imm.Rate) * imm.Quantity);
            iDiscount = iGrassTotal * imm.Discount / 100;
            iTempNetTotal = iGrassTotal - iDiscount;
            iTax = iTempNetTotal * imm.Vat / 100;
            iNetTotal = iTax + iTempNetTotal;

            //lblTotalSales.Text = String.Format("{0:0.00}", Decimal.Parse(lblTotalSales.Text) + iGrassTotal);
            DiscountAmt += iDiscount;
            lblTotalDiscount.Text = String.Format("{0:0.00}", DiscountAmt);
            TaxAmt = TaxAmt + iTax;
            lblTotaltax.Text = String.Format("{0:0.00}", TaxAmt);
        }
    }
  public void GetUserImage(byte[] ApproveDigitalByte)
    {   

        byte[] byteArray = ApproveDigitalByte;
        if (byteArray != null && byteArray.Count() > 0)        {
           
            imgApprovedsigin.Attributes.Add("src", GetImage(byteArray));
            imgApprovedsigin.Attributes.Add("class", "show");
        }
       
    }
    public string GetImage(object img)
    {
        return "data:image/jpg;base64," + Convert.ToBase64String((byte[])img);
    }

}
