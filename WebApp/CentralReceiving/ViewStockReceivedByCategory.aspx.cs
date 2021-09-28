using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Text;
using System.Web.Script.Serialization;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PerformingNextAction;

public partial class CentralReceiving_ViewStockReceivedByCategory : Attune_BasePage
{
    public CentralReceiving_ViewStockReceivedByCategory()

        : base("CentralReceiving_ViewStockReceivedByCategory_aspx")
    {}
    long returnCode = -1;
    decimal DiscountAmt = decimal.Zero;
    decimal TaxAmt = decimal.Zero;
    List<Organization> lstOrganization = new List<Organization>();
    List<Suppliers> lstSuppliers = new List<Suppliers>();
    List<StockReceived> lstStockReceived = new List<StockReceived>();
    List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
    List<Users> lstUsers = new List<Users>();
    List<StockReceiveByCategory> lstStockReceiveByCategory = new List<StockReceiveByCategory>();
    List<StockReceivedAttributesDetails> lstARAD = new List<StockReceivedAttributesDetails>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    InventoryCommon_BL inventoryBL;
    string IsAttributeConfig = "";
    
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {
            
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("ReceviedUnitCostPrice", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {
                hdnIsResdCalc.Value = lstInventoryConfig[0].ConfigValue;
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("View_MatchingInvoice_Button", OrgID, ILocationID, out lstInventoryConfig);

            if (lstInventoryConfig.Count > 0)
            {
                btnInvoice.Visible = Convert.ToBoolean(lstInventoryConfig[0].ConfigValue);

            }
            else
            {
                btnInvoice.Visible = false;
            }
            LoadDetails();
            if (lblStatus.Text.ToLower().Equals("approved"))
            {
                Notification();
            }
            string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
            if (HideTaxOpbilling == "Y")
            {
                trSupplierServiceTax.Attributes.Add("Style", "display:none");
                trTotalTaxAmount.Attributes.Add("Style", "display:none");
                lbltotalExe.Attributes.Add("Style", "display:none");
                trCess2.Attributes.Add("Style", "display:none");
                trEdCess1.Attributes.Add("Style", "display:none");
                lblcst5.Attributes.Add("Style", "display:none");        
            }   
        string HideTotalSales = GetConfigValue("HideTotalSalesInCentralPurchaseOrder", OrgID);
            if (HideTotalSales == "Y")
            {
                trTotalSales.Attributes.Add("Style", "display:none"); 
            
            }
        }
    }


    public void LoadDetails()
    {
        long poNO = 0;
        string approval = string.Empty;
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        List<StockReceived> lstTaxType = new List<StockReceived>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        if (Request.QueryString["ID"] != null)
        {
            poNO = long.Parse(Request.QueryString["ID"]);
        }
        approval = Request.QueryString["Approve"];
        try
        {
            inventoryBL.GetCentralStockReceivedDetails(OrgID, ILocationID, poNO, out lstOrganization, out lstSuppliers, out lstStockReceived, out lstInventoryItemsBasket, out lstStockReceiveByCategory, out lstARAD, out lstTaxType, out lstTaxmaster);
            if (lstTaxType != null && lstTaxType.Count > 0)
            {
                SetTaxType(lstTaxType);
            }
            if (lstTaxmaster != null && lstTaxmaster.Count > 0)
            {
                JavaScriptSerializer objJSS = new JavaScriptSerializer();
                hdnGetTaxList.Value = objJSS.Serialize(lstTaxmaster);
            }
            if (lstInventoryItemsBasket != null && lstStockReceiveByCategory != null
                && lstInventoryItemsBasket.Count > 0 && lstStockReceiveByCategory.Count > 0)
            {
                LoadStockReceivedItems(lstInventoryItemsBasket, lstStockReceiveByCategory, lstARAD);
            }
            if (lstOrganization != null && lstOrganization.Count > 0)
            {
                lblOrgName.Text = lstOrganization[0].Name;
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_TinNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                    lblOrgTinno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("PHARMA_LiNo", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                    lblorgDlno.Text = lstInventoryConfig[0].ConfigValue.ToUpper();
                lblStreetAddress.Text = lstOrganization[0].Address;
                lblCity.Text = lstOrganization[0].City;
                lblPhone.Text = lstOrganization[0].PhoneNumber;
                if (isCorporateOrg == "Y")
                {
                    imgOrgLogo.Attributes.Add("class", "show");
                    imgOrgLogo.ImageUrl = lstOrganization[0].LogoPath;
                }
                if (lstSuppliers.Count > 0)
                {
                    lblVendorName.Text = lstSuppliers[0].SupplierName;
                    lblVendorTinno.Text = lstSuppliers[0].TinNo;
                    lblVendorAddress.Text = lstSuppliers[0].Address1 + ", " + lstSuppliers[0].Address2;
                    lblVendorCity.Text = lstSuppliers[0].City;
                    lblVendorPhone.Text = lstSuppliers[0].Phone;
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
                if (lstStockReceived[0].ExciseTaxAmount <= 0)
                {
                    lbltotalExe.Attributes.Add("Style", "display:none");
                    trCess2.Attributes.Add("Style", "display:none");
                    trEdCess1.Attributes.Add("Style", "display:none");
                    lblcst5.Attributes.Add("Style", "display:none");
                }

                hdnApproveStockReceived.Value = lstStockReceived[0].StockReceivedID.ToString();

                lblReceivedID.Text = Convert.ToString(lstStockReceived[0].StockReceivedNo);
                lblTotaltax.Text = String.Format("{0:0.00}", lstStockReceived[0].Tax);
                lblDiscount.Text = String.Format("{0:0.00}", lstStockReceived[0].PODiscountAmount);
                lblamountused.Text = String.Format("{0:0.00}", lstStockReceived[0].UsedCreditAmount);
                lblGrountTotal.Text = String.Format("{0:0.00}", lstStockReceived[0].GrandTotal);
                lblTotalExcise.Text = String.Format("{0:0.00}", (lstStockReceived[0].ExciseTaxAmount - lstStockReceived[0].UsedCreditAmount));
                lblCessOnExcise.Text = String.Format("{0:0.00}", lstStockReceived[0].CessOnExciseTax);
                lblHighterEdCess.Text = String.Format("{0:0.00}", lstStockReceived[0].HighterEdCessTaxAmount);
                lblTotalDiscount.Text = String.Format("{0:0.00}", lstStockReceived[0].Discount);
                if (!string.IsNullOrEmpty(lstStockReceived[0].SupServiceTax.ToString()))
                {
                    lblTax.Text = String.Format("{0:0.00}", lstStockReceived[0].SupServiceTax);
                }
                new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("RecuiredCessAmountDispay", OrgID, ILocationID, out lstInventoryConfig);

                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue.ToUpper() == "N")
                    {
                        trCess2.Attributes.Add("Style", "display:none");
                        trEdCess1.Attributes.Add("Style", "display:none");
                    }
                    else
                    {
                        trCess2.Attributes.Add("Style", "display:block");
                        trEdCess1.Attributes.Add("Style", "display:block");
                    }

                }
                lblCST.Text = String.Format("{0:0.00}", lstStockReceived[0].CSTAmount);
                lblRoundOffValue.Text = string.Format("{0:0.00}", lstStockReceived[0].RoundOfValue);
                lblGrandwithRoundof.Text = string.Format("{0:0.00}", lstStockReceived[0].GrandTotalRF);
                if (lstStockReceived[0].Comments != "")
                {
                    commentsTD.InnerHtml = "<hr/>" + "Note: " + lstStockReceived[0].Comments;
                }
                if (lstStockReceived[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                {
                    approvalTR.Style.Add("display", "block");
                    approvedDateTD.InnerText = lstStockReceived[0].ApprovedAt.ToExternalDate();
                }
                hdnStatus.Value = lstStockReceived[0].Status;
                lblStatus.Text = lstStockReceived[0].Status;

                if (lstStockReceived[0].ApprovedBy != 0)
                {
                    returnCode = new GateWay(base.ContextInfo).GetUserDetail(lstStockReceived[0].ApprovedBy, out lstUsers);
                    if (lstUsers != null && lstUsers.Count > 0)
                    {
                    approvedByTD.Style.Add("display", "block");
                    approvedByTD.InnerText = lstUsers[0].Name;
                    }
                }
                if (hdnStatus.Value == StockOutFlowStatus.Approved && approval == "1")
                {
                    approvalTR.Style.Add("display", "block");
                    trApproveBlock.Style.Add("display", "block");
                }
            }
            else
            {
                string Message = Resources.CentralReceiving_ClientDisplay.CentralReceiving_ViewStockReceivedByCategory_aspx_01;
                if (Message == null)
                {
                    Message = "No Matching Records Found!";
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
            //lstInventoryItemsBasket = GetReceivedItems();
            returnCode = inventoryBL.UpdateReceivedInventoryApproval("StockReceive", lstInventoryItemsBasket, orderID, status, LID, OrgID, ILocationID);
            if (returnCode == 0)
            {
                LoadDetails();
            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Updating Approval details in ViewStockReceived.aspx", ex);
            
            Attuneheader.LoadErrorMsg("There was a problem. Please contact system administrator");
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
        string url = Request.ApplicationPath + @"/CentralReceiving/MatchingViewStockReceived.aspx?isPopup=Y&ID=" + hdnApproveStockReceived.Value;
        ScriptManager.RegisterStartupScript(Page, this.GetType(), "hideDivs", "javascript:ReportPopUP('" + url + "');", true);
    }


    protected void LoadStockReceivedItems(List<InventoryItemsBasket> lstIIB, List<StockReceiveByCategory> lstStockReceiveByCategory, List<StockReceivedAttributesDetails> lstARAD)
    {
        string strViewStockHead = string.Empty;
        string strViewStockBody = string.Empty;
        StringBuilder sb = new StringBuilder();

        var distinctCustomers = ((from p in lstIIB
                                  where p.CategoryID.ToString() != string.Empty
                                  select p.CategoryID.ToString()).Distinct()).ToArray();
        if (distinctCustomers != null)
        {
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Attributes_Basedby_Category", OrgID, ILocationID, out lstInventoryConfig);
            IsAttributeConfig = lstInventoryConfig.Count == 0 ? "N" : lstInventoryConfig[0].ConfigValue;
            if (IsAttributeConfig == "N")
            {
                for (int i = 0; i < distinctCustomers.Count(); i++)
                {
                    List<InventoryItemsBasket> lstIB = lstIIB.FindAll(P => (P.CategoryID == int.Parse(distinctCustomers[i])));
                    sb.Append(ReturnViewStockRow(lstIB, lstStockReceiveByCategory, lstARAD));
                    divViewStock.InnerHtml = sb.ToString();
                }
            }
            else
            {
                sb.Append(ReturnViewStockRow(lstIIB, lstStockReceiveByCategory, lstARAD));
                divViewStock.InnerHtml = sb.ToString();
            }
        }
    }


    protected StringBuilder ReturnViewStockRow(List<InventoryItemsBasket> lstIIB, List<StockReceiveByCategory> lstStockReceiveByCategory, List<StockReceivedAttributesDetails> lstARAD)
    {
        string dateExpiryDateFormat = GetInventoryConfigDetailsValue("StockReceiveExpirydateFormatDD/MM/YYYY", OrgID, 0);
        string HideTaxOpbilling = GetConfigValue("IsMiddleEast", OrgID);
        string strSetAttr = string.Empty;
        string strCategoryName = string.Empty;
        StringBuilder sbHead = new StringBuilder();
        StringBuilder sbBody = new StringBuilder();
        StringBuilder sb = new StringBuilder();
        int i = 1;
        string strVal = string.Empty;
        long categoryID = 0;
        foreach (InventoryItemsBasket row in lstIIB)
        {
            List<StockReceiveByCategory> lstCategory = lstStockReceiveByCategory.FindAll(P => (P.CategoryID == row.CategoryID) && (P.ProductID == row.ProductID));
            categoryID = Convert.ToInt64(row.CategoryID);
            List<StockReceivedAttributesDetails> lstCAM = lstARAD.FindAll(P => (P.CategorieMappingID == row.CategoryID) && (P.StockReceivedDetailsId == row.ProductID));
            sbBody.Append("<tr>");
            sbHead.Append("<tr>");
            foreach (StockReceiveByCategory lst in lstCategory.OrderBy(P => P.SeqNo))
            {
                strSetAttr = string.Empty;
                if (i == lstIIB.Count)
                {
                    strCategoryName = row.CategoryName;
                    if (lst.ShowColumn.Equals("0"))
                    {
                        strSetAttr = " style='display:none'";
                    }
                    sbHead.Append("<th " + strSetAttr + " class='dataheader1'>" + lst.DisplayText + "</th>");
                }

                if (lst.AttributeName.Equals("StockStatus"))
                {
                    var v3 = row.GetType().GetProperty(lst.AttributeName).GetValue(row, null);
                    switch (int.Parse(v3.ToString()))
                    {
                        case (int)StockReceivedStatus.Damage:
                            strVal = StockReceivedStatus.Damage.ToString();
                            break;

                        case (int)StockReceivedStatus.Rejected:
                            strVal = StockReceivedStatus.Rejected.ToString();
                            break;

                        case (int)StockReceivedStatus.shortage:
                            strVal = StockReceivedStatus.shortage.ToString();
                            break;

                        default:
                            strVal = string.Empty;
                            break;
                    }
                }
                else
                {
                    try
                    {
                        var v3 = row.GetType().GetProperty(lst.AttributeName.Trim()).GetValue(row, null);
                        //decimal getTotalCost = 0;
                        if (lst.AttributeName.Equals("Type"))
                        {
                            v3 = row.GetType().GetProperty("TotalCost").GetValue(row, null);
                            //getTotalCost = ((row.UnitCostPrice * row.RECQuantity) - (row.UnitCostPrice * row.RECQuantity * row.Discount / 100) + (row.UnitCostPrice * row.RECQuantity * row.Tax / 100));
                            strVal = String.Format("{0:0.00}", v3);
                        }
                        else
                        {
                            switch (lst.DataType)
                            {
                                case "DateTime":
                                    DateTime dt = Convert.ToDateTime(v3.ToString());
                                    if (dt.ToString("yyyy").Equals("9999"))
                                    {
                                        strVal = string.Empty;
                                    }
                                    else
                                    {
                                        strVal = dateExpiryDateFormat == "N" ? dt.ToString("MM/yyyy") : dt.ToString("dd/MM/yyyy");
                                    }
                                    break;

                                case "Decimal":
                                    strVal = String.Format("{0:0.00}", v3);
                                    break;

                                default:
                                    strVal = v3.ToString();
                                    break;
                            }
                        }
                    }
                    catch (Exception)
                    {
                        foreach (StockReceivedAttributesDetails CAT in lstCAM)
                        {
                            if (lst.AttributeName.Equals(CAT.AttributesKey))
                            {
                                strVal = CAT.AttributesValue;
                                break;
                            }
                        }
                    }
                }


                if (lst.ShowColumn.Equals("0"))
                {
                    strSetAttr = " style='display:none'";
                }
                if (lst.DisplayText == "ProductName")
                {
                    strVal = IsAttributeConfig == "Y" ? strVal + "(" + row.CategoryName + ")" : strVal;
                }
                sbBody.Append("<td " + strSetAttr + ">" + strVal + "</td>");
            }
            i++;
            sbBody.Append("</tr>");

        }
        sbHead.Append("</tr>");
        if (IsAttributeConfig == "N")
        {
          sb.Append("<span style='border:solid 1px black;background-color:#BBE7ED;padding:3px;font-size:10px;' >" + strCategoryName + "</span>");
        }
        sb.Append("<table style='margin-bottom:10px;width:100%' id='tblSRRow' border='1' cellpadding='4' cellspacing='0'>");
        sb.Append(sbHead);
        sb.Append(sbBody);
        sb.Append("</table>");
        return sb;
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

    public void Notification()
    {
        var mailbuilder = new StringBuilder();
        PageContextDetails.ButtonName = "btnPrint";
        PageContextDetails.ButtonValue = "Print";
        divReceived.RenderControl(new HtmlTextWriter(new StringWriter(mailbuilder)));
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
        PageContextDetails.IndentNo = Convert.ToInt64(Request.QueryString["ID"]);
        long returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
        #endregion

    }
    public string GetInventoryConfigDetailsValue(string configKey, int orgID, int OrgAddressID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(new Attune_BaseClass().ContextInfo);
        List<InventoryConfig> lstConfig = null;
        returncode = objGateway.GetInventoryConfigDetails(configKey, orgID, OrgAddressID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;
        return configValue;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }
}
