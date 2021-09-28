using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using NumberToWord;
using Attune.Solution.BusinessComponent;
using System.Data;
using System.Xml;
using System.IO;


public partial class Corporate_CorpInvBilling : BasePage
{
    long TaskID = 0;
    public string CorPrescripion { get; set; }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
             

            try
            {
                lblmsg.Text = "Search the Product List";
                divlistProducts.Style.Add("display", "none");
                tableTask.Style.Add("display", "none");
 
                List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("IsCreditBill", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue == "Y")
                    {
                        divClients.Style.Add("display", "block");

                        hdnIsCreditBill.Value = "Y";
                    }
                }
                string rval = GetConfigValue("roundoffpatamt", OrgID);
                hdnDefaultRoundoff.Value = rval == "" ? "0" : rval;

                rval = GetConfigValue("patientroundoffpattern", OrgID);
                hdnRoundOffType.Value = rval;


                loadClientsName();
                
                LoadDiscount();
                new GateWay(base.ContextInfo).GetInventoryConfigDetails("ExpiryDateLevel", OrgID, ILocationID, out lstInventoryConfig);
                if (lstInventoryConfig.Count > 0)
                {
                    if (lstInventoryConfig[0].ConfigValue != null && lstInventoryConfig[0].ConfigValue != "")
                    {
                        if (lstInventoryConfig[0].ConfigValue.Split('-')[0] != null && lstInventoryConfig[0].ConfigValue.Split('-')[0] != "")
                        {
                            string ExpiryDateLevel = lstInventoryConfig[0].ConfigValue.Split('-')[0];
                            hdnExpiryDateLevel.Value = ExpiryDateLevel;
                            lblExpLevel.Text = "Expired With in " + ExpiryDateLevel + " Month(s)";
                            txtExpiredColor.CssClass = "grdcheck";
                        }

                    }
                    AutoCompleteProduct.ContextKey = hdnPatVisitID.Value;
                }
                long VisitID = -1;
                LoadPrescriptiongrug();
                Int64.TryParse(Request.QueryString["VID"], out VisitID);
                List<PatientVisit> visitList = new List<PatientVisit>();
                Patient_BL patientBL = new Patient_BL(base.ContextInfo);
                long returnCode = -1;
                returnCode = patientBL.GetLabVisitDetails(VisitID, OrgID, out visitList);
                if (visitList.Count > 0)
                {
                    lblPNo.Text = Convert.ToString(visitList[0].PatientNumber);
                    lblName.Text = visitList[0].TitleName + " " + visitList[0].PatientName;

                    if (visitList[0].Sex == "M")
                    {
                        lblSex.Text = "[Male]";
                    }
                    else
                    {
                        lblSex.Text = "[Female]";
                    }
                    lblAge.Text = visitList[0].PatientAge.ToString();
                    lblDate.Text = Convert.ToString(visitList[0].VisitDate.ToString("dd/MM/yyyy"));
                }
            }

            catch (Exception ex)
            {
                CLogger.LogError("Error in Page Load - StockReturn.aspx", ex);
            }
        }
        listBox_click();
    }
    private void BindConsumedBy(long patientVisitID)
    {
        long returnCode = -1;
        List<PatientVisit> lstPatientVisitDetails = new List<PatientVisit>();
        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(patientVisitID, out lstPatientVisitDetails);
        if (lstPatientVisitDetails.Count > 0)
        {
             
            txtPhysicianName.Text = lstPatientVisitDetails[0].PhysicianName;
            
            hdnPatientNo.Value = lstPatientVisitDetails[0].NextReviewDate;
            hdnPatVisitID.Value = patientVisitID.ToString();
            hdnpatientID.Value = lstPatientVisitDetails[0].PatientID.ToString();
        }
    }

    private void LoadPrescriptiongrug()
    {
        long VisitID = -1;
        Int64.TryParse(Request.QueryString["VID"], out VisitID);
        Int64.TryParse(Request.QueryString["tid"], out TaskID);
        BindConsumedBy(VisitID);
        
        btnSearch.Visible = false;
        

        tableTask.Style.Add("display", "block");
        List<InventoryItemsBasket> lstInventoryBasket = new List<InventoryItemsBasket>();
      
        long returnCode = -1;
        
        try
        {
            //returnCode = new Inventory_BL(base.ContextInfo).getPrescriptiongrugList(VisitID, OrgID, ILocationID, InventoryLocationID, out lstInventoryBasket,TaskID);
            if(lstInventoryBasket.Count>0)
            hdnPrescriptionNO.Value = lstInventoryBasket[0].PrescriptionNO.ToString();

            var templist = (from val in lstInventoryBasket
                            where val.Type.ToUpper()=="OPEN"
                            select new
                            {
                                val.ProductName,
                                val.ProductID,
                                val.Description,
                                val.TotalQty,
                                val.IssuedQty
                            }).Distinct().ToList();

            TableRow rowH = new TableRow();
            TableCell cellH1 = new TableCell();
            TableCell cellH2 = new TableCell();
            TableCell cellH3 = new TableCell();
            TableCell cellH4 = new TableCell();

            cellH1.Attributes.Add("align", "left");
            cellH1.Text = "Product Name";
            cellH1.Width = Unit.Percentage(25);

            cellH2.Attributes.Add("align", "left");
            cellH2.Text = "Ordered Qty";
            cellH2.Width = Unit.Percentage(10);

            cellH3.Attributes.Add("align", "left");
            cellH3.Text = "Issued Qty";
            cellH3.Width = Unit.Percentage(10);

            cellH4.Attributes.Add("align", "left");
            cellH4.Text = "Remaining Qty";
            cellH4.Width = Unit.Percentage(10);

            rowH.Font.Bold = true;
            rowH.CssClass = "dyTbHeader";
            rowH.Cells.Add(cellH1);
            rowH.Cells.Add(cellH2);
            rowH.Cells.Add(cellH3);
            rowH.Cells.Add(cellH4);
            ConsumableItemsTab.Rows.Add(rowH);

            foreach (var item in templist)
            {
                
                TableRow rowCh = new TableRow();
                TableCell cellCh1 = new TableCell();
                TableCell cellCh2 = new TableCell();
                TableCell cellCh3 = new TableCell();
                TableCell cellCh4 = new TableCell();

                HiddenField hdnChProductList = new HiddenField();
                HiddenField hdnChBacthList = new HiddenField();

                cellCh1.Attributes.Add("align", "left");
                cellCh1.Text = item.ProductName;
                cellCh1.Font.Size = 7;
                rowCh.Cells.Add(cellCh1);

                cellCh2.Attributes.Add("align", "left");
                cellCh2.Text = item.TotalQty.ToString();
                cellCh2.Font.Size = 7;
                rowCh.Cells.Add(cellCh2);

                cellCh3.Attributes.Add("align", "left");
                cellCh3.Text =item.IssuedQty.ToString() ;
                cellCh3.Font.Size = 7;
                rowCh.Cells.Add(cellCh3);

                decimal RQTY = (Convert.ToDecimal(item.TotalQty.ToString()) - Convert.ToDecimal(item.IssuedQty.ToString()));
                cellCh4.Attributes.Add("align", "left");
                cellCh4.Text = RQTY.ToString();;
                cellCh4.Font.Size = 7;
                rowCh.Cells.Add(cellCh4);

                lstInventoryBasket.OrderBy(P => P.ExpiryDate);
                hdnTasklist.Value += item.ProductID + "^";

                foreach (InventoryItemsBasket childList in lstInventoryBasket.OrderBy(P => P.ExpiryDate))
                {
                    if (childList.ProductID == item.ProductID)
                    {
                        hdnChProductList.Value += childList.ProductID + "~" +
                                                childList.BatchNo + "~" +
                                                childList.InHandQuantity + "~" +
                                                childList.SellingUnit + "~" +
                                                childList.Rate + "~" +
                                                childList.Tax + "~" +
                                                childList.ExpiryDate + "~" +
                                                childList.ID + "~" +
                                                childList.ProductName + "^";
                        hdnChBacthList.Value += childList.BatchNo + "|";

                        hdnProductLists.Value += childList.ProductName + "~" + childList.ProductID + "~" + RQTY + "^";
                    }
                }

                
                rowCh.Cells.Add(cellCh1);
                rowCh.Cells.Add(cellCh2);
                rowCh.Cells.Add(cellCh3);
                rowCh.Cells.Add(cellCh4);
                rowCh.CssClass = "dyTbRow";
                ConsumableItemsTab.Rows.Add(rowCh);
            }
            if (templist.Count > 0)
            {
            }
            else
            {
                ConsumableItemsTab.Attributes.Add("style", "display:none");
            }

            //------------------------------------------------------Closed product
            TableRow row1H = new TableRow();
            TableCell cell1H1 = new TableCell();
            cell1H1.Attributes.Add("align", "left");
            cell1H1.Text = "Closed Product Name";
            cell1H1.Width = Unit.Percentage(25);
            row1H.Cells.Add(cell1H1);

            row1H.CssClass = "dyTbHeader";
            ConsumableItemsTabClose.Rows.Add(row1H);
            var temp1list = (from val in lstInventoryBasket
                             where val.Type == "Closed"
                            select new
                            {
                                val.ProductName,
                                val.ProductID,
                                val.Description
                            }).Distinct().ToList();
            foreach (var item in temp1list)
            {
                TableRow row1Ch = new TableRow();
                TableCell cell1Ch1 = new TableCell();
                cell1Ch1.Attributes.Add("align", "left");
                cell1Ch1.Attributes.Add("Style", "color:Red;");
                cell1Ch1.Text = item.ProductName;
                cell1Ch1.Font.Size = 7;
                row1Ch.Cells.Add(cell1Ch1);
                row1Ch.CssClass = "dyTbRow";
                ConsumableItemsTabClose.Rows.Add(row1Ch);
            }
            if (temp1list.Count > 0)
            {
            }
            else
            {
                ConsumableItemsTabClose.Attributes.Add("style", "display:none");
            }
            //-----------------------------------------------------------End
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in Page Load - PrescriptionBilling.aspx", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
    }
    

    protected void btnConsumable_Click(object sender, EventArgs e)
    {

        long returnCode = -1;
        long visitID = -1;
        string feeType = string.Empty;
        string otherName = string.Empty;
        string PaymentLogic = string.Empty;
        string physicianName = String.Empty;
        string referrerName = string.Empty;
       
        long FinalBillID = -1;
        string visittype = "";
        decimal dueAmount = 0;
        long patientID = -1;
        try
        {
            FinalBill finalBill = new FinalBill();
           
            AmountReceivedDetails amtRD = new AmountReceivedDetails();
            List<InventoryItemsBasket> lstStockUsageDetails = new List<InventoryItemsBasket>();
            List<VisitClientMapping> lstVisitClientMapping = new List<VisitClientMapping>();
            decimal dserviceCharge = 0;
            DataTable dtAmountReceived = new DataTable();
            PatientVisit_BL pvisitBL = new PatientVisit_BL(base.ContextInfo);
            Patient_BL patientBL = new Patient_BL(base.ContextInfo);
            PatientVisit pVisit = new PatientVisit();
            List<Patient> lstPatient = new List<Patient>();
            List<FinalBill> lstDueDetail1 = new List<FinalBill>();
            BillingEngine billingEngineBL = new BillingEngine(base.ContextInfo);
            List<BillingDetails> lstBillingDetails = new List<BillingDetails>();
            List<StandardDeduction> lstStdDeduction = new List<StandardDeduction>();
            List<PatientPrescription> lstPatientPre = new List<PatientPrescription>();
            List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
            Int64.TryParse(Request.QueryString["PID"], out patientID);
            Int64.TryParse(Request.QueryString["VID"], out visitID);
 
             
            if (visitID != -1)
            {

                dueDetail.loadDueDetail(OrgID, patientID, visitID, out FinalBillID, out lstDueDetail1, out visittype);
                int iCount = lstDueDetail1.Count == 0 ? 1 : lstDueDetail1.Count;
                if (lstDueDetail1.Count > 0)
                {
                    Decimal.TryParse(lstDueDetail1[lstDueDetail1.Count - 1].CurrentDue.ToString(), out dueAmount);
                }
            }
            GetInvBillingDetails(out  finalBill, out  dtAmountReceived, out  amtRD, out lstStockUsageDetails, out dserviceCharge);
            lstDDtoSTOP = GetCollectedPrescription();
            finalBill.PatientID =  patientID;
            finalBill.VisitID = visitID;
            finalBill.CurrentDue = finalBill.Due;
            finalBill.Due = 0;
            finalBill.RoundOff = Convert.ToDecimal(hdnRoundBalace.Value);
            finalBill.NetValue = 0;
            finalBill.NetValue = Convert.ToDecimal(txtNetAmount.Text);
            string ConsumedBy = string.Empty;
            string isFreeOfCost = "Y";
            if (lstStockUsageDetails.Count > 0)
            {
                //returnCode = new Inventory_BL(base.ContextInfo).SaveOPCorpInventoryBilling(ConsumedBy, ILocationID, finalBill, dtAmountReceived, amtRD, lstStockUsageDetails,
                //    InventoryLocationID, out FinalBillID, dserviceCharge, isFreeOfCost,lstVisitClientMapping);
                finalBill.FinalBillID = FinalBillID;
                hdnProductList.Value = "";
            }

            //-------------------------------------------update Status PatientPrecscription
            int PatientPre = -1;
            if (lstDDtoSTOP.Count > 0)
            {
               // returnCode = new Inventory_BL(base.ContextInfo).UpdatePrescription(lstDDtoSTOP, out PatientPre);
                //------------------------------------------------------------------------END
                #region Task
                if (Request.QueryString["tid"] != null)
                {
                    if (PatientPre > 0)
                    {

                    }
                    else
                    {
                        Int64.TryParse(Request.QueryString["tid"], out TaskID);
                        returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(TaskID, TaskHelper.TaskStatus.Completed, UID);
                    }
                }
            }
            #endregion
            

            if (finalBill.FinalBillID > 0)
            {

                if (returnCode != 0 || returnCode != -1)
                {
                    Int64.TryParse(Request.QueryString["tid"], out TaskID);
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(TaskID, TaskHelper.TaskStatus.Completed, UID);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:alert('Saved Successfully.');", true);
                    if (Request.QueryString["tid"] != null)
                    {
                        string pageSTR = Request.ApplicationPath + "/Inventory/Home.aspx?IsPopup=Y";
                        hdnprint.NavigateUrl = @"PrintBill.aspx?bid=" + finalBill.FinalBillID + "&IsPopup=Y&vid=" + visitID + "&pid =" + patientID;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Comp", "openPOPup();GetCurrencyValues();ReDirectPage('" + pageSTR + "');", true);
                        ClearALL();
                    }
                    else
                    {
                        hdnprint.NavigateUrl = @"PrintBill.aspx?bid=" + finalBill.FinalBillID + "&IsPopup=Y&vid=" + visitID + "&pid =" + patientID;
                        ScriptManager.RegisterStartupScript(Page, this.GetType(), "Comp", "openPOPup();GetCurrencyValues();", true);
                        ClearALL();
                    }
                    
                }
            }
            else
            {
                if (chkTaskReasgin.Checked == true)
                {
                    Int64.TryParse(Request.QueryString["tid"], out TaskID);
                    returnCode = new Tasks_BL(base.ContextInfo).UpdateTask(TaskID, TaskHelper.TaskStatus.Pending,0);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:alert('Task Reassign Successfully.');", true);
                    List<Role> lstUserRole = new List<Role>();
                    string path = string.Empty;
                    Role role = new Role();
                    role.RoleID = RoleID;
                    lstUserRole.Add(role);
                    returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
                    Response.Redirect(Request.ApplicationPath + path, true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Co1mp", "javascript:alert('Error While Saving Billing Items.');", true);
                    CLogger.LogWarning("Error While Saving Consumable Details.");
                }
            }
        }

        catch (System.Threading.ThreadAbortException tae)
        {
            string exp = tae.ToString();
            CLogger.LogError("Error While Saving Consumable Details.", tae);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Saving Consumable Details.", ex);
            ErrorDisplay1.ShowError = true;
            ErrorDisplay1.Status = "There was a problem. Please contact system administrator";
        }
         
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ClearALL();
        LoadPrescriptiongrug();
    }

    #region UserFunction

   


    void ClearALL()
    {
        
        txtAmountDue.Text = "0.00";
        txtAmountRecieved.Text = "0.00";
        txtBatchNo.Text = string.Empty;
        txtBatchQuantity.Text = string.Empty;
         
        txtDiscount.Text = "0.00";
        txtDue.Text = "0.00";
        txtGrandTotal.Text = "0.00";
        txtGross.Text = "0.00";
        txtNetAmount.Text = "0.00";
     
        txtPhysicianName.Text = string.Empty;
        txtProduct.Text = string.Empty;
        txtQuantity.Text = string.Empty;
        txtServiceCharge.Text = "0.00";
        txtSubTotal.Text = "0.00";
        txtTax.Text = "0.00";
        txtUnit.Text = string.Empty;
        ddDiscountPercent.SelectedIndex = 0;
        txtDiscountPercent.Text = "0.00";
        hdnAmountDue.Value = "0.00";
        hdnAmountRecieved.Value = "0.00";
        hdnTotalAmtRec.Value = "0.00";
        hdnBatchList.Value = "";
        hdnPatVisitID.Value = "-1";
        hdnExpiryDate.Value = "";
        hdnGrandTotal.Value = "0";
        hdnGross.Value = "";
        hdnpatientID.Value = "-1";
        hdnProBatchNo.Value = "";
        hdnProductId.Value = "";
        hdnProductList.Value = "";
        hdnProductName.Value = "";
        hdnReceivedID.Value = "";
        hdnRowEdit.Value = "";
        hdnSellingPrice.Value = "0";
        hdnTax.Value = "0";
        hdnGrandTotal.Value = "0.00";
        hdnTtax.Value = "0.00";
        hdnPatientNo.Value = "0";
        hdnTaskCollectedItems.Value = "";
        hdnAddedAmount.Value = "";
        hdnTaskAmount.Value = "";
        hdnTasklist.Value = "";
        tableTask.Style.Add("display", "none");
       
        txtNonMedical.Text = "0.00";
        txtCoPayment.Text = "0.00";
        txtExcess.Text = "0.00";
        hdnCoPayment.Value = "0.00";
        txtRoundoffAmount.Text = "0.00";
        hdnUnitPrice.Value = "0.00";
        hdnPrescriptionNO.Value = "0";

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "ClearPaymentControl", "  ClearPaymentControlEvents();", true);

    }

    private void GetInvBillingDetails(out FinalBill finalBill, out DataTable dtAmountReceived, out AmountReceivedDetails amtRD, out List<InventoryItemsBasket> lstStockUsageDetails, out decimal dserviceCharge)//,out List<DrugDetails> lstDDtoSTOP)
    {
        finalBill = new FinalBill();
        VisitClientMapping VisitClientMapping = new VisitClientMapping(); 
        amtRD = new AmountReceivedDetails();
        lstStockUsageDetails = new List<InventoryItemsBasket>();
        dserviceCharge = 0;
        dtAmountReceived = new DataTable();
        try
        {
            # region Billing
            txtAmountRecieved.Text = hdnTotalAmtRec.Value == null ? "0" : hdnTotalAmtRec.Value.ToString();
            txtDiscount.Text = txtDiscount.Text == "" ? "0" : txtDiscount.Text;
            txtAmountDue.Text = hdnAmountDue.Value == "" ? "0" : hdnAmountDue.Value;
            txtTax.Text = hdnTtax.Value == "" ? "0" : hdnTtax.Value;
            decimal dServiceCharge = 0;
            decimal.TryParse(txtServiceCharge.Text, out dServiceCharge);
            if (ddDiscountPercent.SelectedItem.Value == "select")
                finalBill.IsDiscountPercentage = "N";
            else finalBill.IsDiscountPercentage = "Y";
            finalBill.DiscountAmount = Convert.ToDecimal(txtDiscount.Text);
            Decimal tempTaxAmt = Convert.ToDecimal(hdnTtax.Value);
            finalBill.GrossBillValue = (Convert.ToDecimal(hdnGross.Value.ToString())) - (dServiceCharge + tempTaxAmt);
            finalBill.ServiceCharge = dServiceCharge;


            finalBill.TaxPercent = tempTaxAmt;
            finalBill.NetValue = ((Convert.ToDecimal(hdnGross.Value.ToString()) + dServiceCharge) - (Convert.ToDecimal(txtDiscount.Text)));//  Convert.ToDecimal(hdnGrandTotal.Value)-;
            finalBill.AmountReceived = Convert.ToDecimal(hdnTotalAmtRec.Value);
            finalBill.OrgID = OrgID;

            VisitClientMapping.ClientID = Int64.Parse(ddlClients.SelectedValue);
            finalBill.Physician = txtPhysicianName.Text;
            finalBill.Comments = "";
            dtAmountReceived = PaymentType.GetAmountReceivedDetails();
            amtRD.AmtReceived = Convert.ToDecimal(hdnTotalAmtRec.Value);
            amtRD.ReceivedBy = LID;
            amtRD.CreatedBy = LID;

            finalBill.CurrentDue = 0;
            //newly added
            decimal pNonMedicalAmtPaid = decimal.Zero;
            decimal pCoPayment = decimal.Zero;
            decimal pExcess = decimal.Zero;

            pNonMedicalAmtPaid = txtNonMedical.Text == "" || Convert.ToDecimal(txtNonMedical.Text) == 0 ? decimal.Zero : Convert.ToDecimal(txtNonMedical.Text);
            pCoPayment = txtCoPayment.Text == "" || Convert.ToDecimal(txtCoPayment.Text) == 0 ? decimal.Zero : Convert.ToDecimal(txtCoPayment.Text);
            pExcess = txtExcess.Text == "" || Convert.ToDecimal(txtExcess.Text) == 0 ? decimal.Zero : Convert.ToDecimal(txtExcess.Text);

            VisitClientMapping.CoPayment = pCoPayment;
            VisitClientMapping.NonMedicalAmount = pNonMedicalAmtPaid;
            finalBill.ExcessAmtRecd = pExcess;

            //ends here
            if (hdnTotalAmtRec.Value.Trim() == "0" || txtAmountRecieved.Text.Trim() == "")
            {
                finalBill.Due = (Convert.ToDecimal(hdnNetAmount.Value) + dServiceCharge - Convert.ToDecimal(txtDiscount.Text));
            }
            finalBill.Due = (Convert.ToDecimal(hdnNetAmount.Value) - Convert.ToDecimal(hdnTotalAmtRec.Value));


            if (chkisCreditTransaction.Checked == true)
            {
                finalBill.Due = 0;
                finalBill.IsCreditBill = "Y";
            }
            else
            {
                finalBill.IsCreditBill = "N";
            }


            finalBill.ModifiedBy = LID;

            lstStockUsageDetails = GetCollectedItems();
            //lstDDtoSTOP = GetCollectedPrescription();

            #endregion

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while executing op billing", ex);
            return;
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
                newBasket.ID = Convert.ToInt64(listChild[0]);
                newBasket.ProductName = listChild[1];
                newBasket.BatchNo = listChild[2];
                newBasket.Quantity = Convert.ToDecimal(listChild[3]);
                newBasket.Unit = listChild[4];
                newBasket.ComplimentQTY = Convert.ToDecimal(listChild[5]);
                newBasket.ProductID = Convert.ToInt64(listChild[6]);
                newBasket.Amount = Convert.ToDecimal(listChild[3]) * Convert.ToDecimal(listChild[7]);
                newBasket.Rate = Convert.ToDecimal(listChild[7]);
                newBasket.Tax = Convert.ToDecimal(listChild[8]);
                newBasket.ExpiryDate = DateTime.Parse(listChild[9] == "**" ? "01/01/1753" : listChild[9]);
                newBasket.Manufacture = Convert.ToDateTime(new BasePage().OrgDateTimeZone);
                if (listChild[11] == "Yes")
                {
                    Isreimbursable = "Y";
                }
                if (listChild[11] == "No")
                {
                    Isreimbursable = "N";
                }
                newBasket.Type = Isreimbursable;
                newBasket.AttributeDetail = "N";
                newBasket.UnitPrice = Convert.ToDecimal(listChild[13]);
                newBasket.ProductKey = newBasket.ProductID + "@#$" + newBasket.BatchNo + "@#$" + newBasket.ExpiryDate.ToString("MMM/yyyy")
                                + "@#$" + String.Format("{0:0.000000}", newBasket.UnitPrice) + "@#$" + String.Format("{0:0.000000}", newBasket.Rate) + "@#$" + newBasket.Unit;
                newBasket.PrescriptionNO = hdnPrescriptionNO.Value.ToString();
                lstInventoryItemsBasket.Add(newBasket);
            }
        }
        return lstInventoryItemsBasket;
    }

    private List<DrugDetails> GetCollectedPrescription()
    {

        List<DrugDetails> lstDDtoSTOP = new List<DrugDetails>();
        foreach (string listParent in hdnProductList.Value.Split('^'))
        {
            if (listParent != "")
            {
                string[] listChild = listParent.Split('~');
                DrugDetails DD = new DrugDetails();
                DD.PatientVisitID = Convert.ToInt64(Request.QueryString["VID"]);
                DD.PrescriptionID = Convert.ToInt64(listChild[6]);//PrescriptionID-->ProductID 
                DD.ComplaintId = Convert.ToInt32(listChild[3]);//ComplaintId-->Qty
                lstDDtoSTOP.Add(DD);

            }
        }
        return lstDDtoSTOP;
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
                LoadProductsBatchNo(Int64.Parse(listProducts.SelectedValue));
                divProductDetails.Style.Add("display", "block");
                hdnProductId.Value = listProducts.SelectedValue;

            }

        }
        listProducts.Attributes.Add("ondblclick", Page.ClientScript.GetPostBackEventReference(listProducts, "Change"));
    }

    
    protected void loadClientsName()
    {
        Investigation_BL ObjInv = new Investigation_BL(base.ContextInfo);
        List<InvClientMaster> ObjClientMas = new List<InvClientMaster>();
        ObjInv.getOrgClientName(OrgID, out ObjClientMas);
        ddlClients.DataSource = ObjClientMas;
        ddlClients.DataTextField = "ClientName";
        ddlClients.DataValueField = "ClientID";
        ddlClients.DataBind();
        ddlClients.Items.Insert(0, new ListItem("--Select Client--", "0"));
        ddlClients.Items[0].Selected = true;
    }

    private void LoadProductsBatchNo(long iProductId)
    {
        try
        {
            hdnProBatchNo.Value = "";
            hdnBatchList.Value = "";
            List<InventoryItemsBasket> lstInventoryItemsBasket = new List<InventoryItemsBasket>();
            //new Inventory_BL(base.ContextInfo).GetProductsBatchNo(OrgID, ILocationID, InventoryLocationID, iProductId, out lstInventoryItemsBasket, 0);

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

    #endregion

    public void LoadDiscount()
    {
        try
        {
            long retCode = -1;
            Patient_BL patBL = new Patient_BL(base.ContextInfo);
            List<DiscountMaster> getDiscount = new List<DiscountMaster>();
            retCode = patBL.GetLabDiscount(OrgID, out getDiscount);
            if (retCode == 0)
            {

                ddDiscountPercent.DataSource = getDiscount;
                ddDiscountPercent.DataTextField = "DiscountName";
                ddDiscountPercent.DataValueField = "Discount";
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, "--Select--");
                ddDiscountPercent.Items[0].Value = "select";
                if (getDiscount.Count > 0)
                {
                    ddDiscountPercent.Style.Add("display", "block");
                    tdDiscountLabel.Style.Add("display", "block");
                }
                else
                {
                    ddDiscountPercent.Style.Add("display", "none");
                    tdDiscountLabel.Style.Add("display", "none");
                }
            }
            else
            {
                ddDiscountPercent.DataSource = null;
                ddDiscountPercent.DataBind();
                ddDiscountPercent.Items.Insert(0, "--Select--");
                ddDiscountPercent.Items[0].Value = "select";
                ddDiscountPercent.Style.Add("display", "none");
                tdDiscountLabel.Style.Add("display", "none");
            }

        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading Lab Discount Details.", ex);
        }


    }
    
    
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        GateWay objGateway = new GateWay(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
}
