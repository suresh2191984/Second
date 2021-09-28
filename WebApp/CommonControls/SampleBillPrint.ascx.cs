using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.Common;

public partial class CommonControls_SampleBillPrint : BaseControl
{
    long pVisitID;
    long pPatientID;
    int pPayerID;
    int pClientID;
    long pTPAID;
    string pBillID=string.Empty;
    long pRefOrgID;
    int pRefPhyID;
    int pIsCredit;
    decimal pPreviousDue = 0;
    double GST=0;
    int rowCount = 0;
    int RowID = 0;
    int flag=-1;
    int k = 0;
    int count = 0;
    string viewTemp;
    long taskID = -1;
    string items = string.Empty;
    Hashtable dText = new Hashtable();
    Hashtable urlVal = new Hashtable();
    Tasks task = new Tasks();
    DropDownList ddDiscount = new DropDownList();
    public string TotalLineItems = string.Empty;
    public string LineItems = string.Empty;
    public event EventHandler AddNewItem;
    public void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            flag = 0;
            ViewState["NewItems"] = "";
            ViewState["TotalLineItems"] = "";
            LoadDiscount();
        }
        //Int64.TryParse(Request.QueryString["vid"], out pVisitID);
        //Int64.TryParse(Request.QueryString["pid"], out pPatientID);
        //Int32.TryParse(Request.QueryString["cid"], out pClientID);
        if (Request.QueryString["vid"] == null)
        {
            Int64.TryParse(Request.QueryString["pid"], out pPatientID);
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            List<OrderedInvestigations> lstOrdered = new List<OrderedInvestigations>();

            new PatientVisit_BL(base.ContextInfo).GetPatientLatestVisit(pPatientID, out lstPatientVisit, out lstOrdered);
            if (lstPatientVisit.Count > 0)
            {
                pVisitID = lstPatientVisit[0].PatientVisitId;
                pClientID =Convert.ToInt32(lstPatientVisit[0].ClientMappingDetailsID);
                pPatientID = lstPatientVisit[0].PatientID;
                //Int64.TryParse(l, out );.
                pRefOrgID = lstPatientVisit[0].HospitalID;
                pRefPhyID = lstPatientVisit[0].ReferingPhysicianID;
                //pIsCredit = lstPatientVisit[0].PayerID;
                pTPAID = lstPatientVisit[0].TPAID; 
            }
            new Patient_BL(base.ContextInfo).GetIsCredit(OrgID, pRefOrgID, pRefPhyID, pClientID, out pIsCredit);
            if (!IsPostBack)
            {
                //if (pIsCredit == 1)
                //{
                //    chkUseCredit.Checked = true;
                //}
                if (pPayerID == 1 || pPayerID == 3)
                {
                    chkUseCredit.Checked = true;
                    PaymentType.TPALAB();
                }
            }
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out pVisitID);
            Int32.TryParse(Request.QueryString["cid"], out pClientID);
            Int64.TryParse(Request.QueryString["pid"], out pPatientID);
            Int32.TryParse(Request.QueryString["PayID"], out pPayerID);
            List<PatientVisit> lstPatientVisit1 = new List<PatientVisit>();
            List<OrderedInvestigations> lstOrdered1 = new List<OrderedInvestigations>();
            new PatientVisit_BL(base.ContextInfo).GetPatientLatestVisit(pPatientID, out lstPatientVisit1, out lstOrdered1);
            if (lstPatientVisit1.Count > 0)
            {
                pRefOrgID = lstPatientVisit1[0].HospitalID;
                pRefPhyID = lstPatientVisit1[0].ReferingPhysicianID;
            }
            new Patient_BL(base.ContextInfo).GetIsCredit(OrgID, pRefOrgID, pRefPhyID, pClientID, out pIsCredit);
            if (!IsPostBack)
            {
                //if (pIsCredit == 1 || pPayerID==3)
                //{
                //    chkUseCredit.Checked = true;
                //    PaymentType.TPALAB();
                //}
                if (pPayerID==1||pPayerID==3)
                {
                    chkUseCredit.Checked = true;
                    PaymentType.TPALAB();
                }
                    
            }
        }
        LineItems = ViewState["TotalLineItems"].ToString();
        
        int ItemCount = -1;
        // int c = 3;
        long retCode = -1;
        Patient_BL patBL = new Patient_BL(base.ContextInfo);
        retCode = patBL.GetPreviousDue(pPatientID,OrgID,out pPreviousDue);
        txtPreviousDue.Value=String.Format("{0:0.00}", Convert.ToDouble(pPreviousDue));
        //List<LabPatientInvestigation> patientInvestigation1 = new List<LabPatientInvestigation>();
        //List<LabPatientInvestigation> patientInvestigation2 = new List<LabPatientInvestigation>();
        //retCode = patBL.GetBillInvestigationDetails(pVisitID,pClientID, out patientInvestigation1, out patientInvestigation2);
        //if (retCode == 0)
        //{
        //    ItemCount = patientInvestigation2.Count;
        //    for (int i = 0; i < ItemCount; i++)
        //    {
        //        LoadBillItems(patientInvestigation2[i].InvestigationName, patientInvestigation2[i].InvestigationID, patientInvestigation2[i].Rate, patientInvestigation2[i].Type);
        //    }
        //    ItemCount = patientInvestigation1.Count;
        //    for (int i = 0; i < ItemCount; i++)
        //    {
        //        LoadBillItems(patientInvestigation1[i].GroupName, patientInvestigation1[i].GroupID, patientInvestigation1[i].Rate, patientInvestigation1[i].Type);
        //    }
            if (IsPostBack)
            {
                viewTemp = ViewState["NewItems"].ToString();
                foreach (string drow in viewTemp.Split(','))
                {
                    if (drow != "")
                    {
                        LoadBillItems(drow, 0, 0, "");
                    }
                }
            }
        //}
        Page.ClientScript.RegisterStartupScript(typeof(Page), "total", "total('BillPrintCtrl_total');", true);
        string tempgst = string.Empty;
        tempgst=GetConfigValue("GST", OrgID);
        
        if (tempgst != "" && tempgst != null)
        {
            if (tempgst == "Tax Percent")
                tempgst = 0.ToString();
            GST = Convert.ToDouble(tempgst);
        }
        if (GST <= 0)
        {
            GST = 0;
        }
        txtTaxPercent.Value = GST.ToString(); 
        string IsRoundOff = string.Empty;
        IsRoundOff = GetConfigValue("PatientCommonRoundOffPattern", OrgID);
        if (String.IsNullOrEmpty(IsRoundOff))
        {
            hdnIsRoundOff.Value = "ON";
        }
        else
        {
            hdnIsRoundOff.Value = "OFF";
        }
    }
    public void LoadBillItems(string Name, long ID, decimal Rate,string Type)
    {
        string dtoRemove = string.Empty;
        dtoRemove = did.Value;
        string newDonation = string.Empty;
        rowCount++;
        if (dtoRemove.Trim().Length > 0)
        {
            foreach (string drow in LineItems.Split('|'))
            {
                bool IsDeleted = false;
                foreach (string s in dtoRemove.Split(','))
                {
                    if (s != string.Empty && !IsDeleted)
                    {
                        if (drow.Contains("RID^" + s + "~"))
                        {
                            IsDeleted = true;
                        }
                    }
                }
                if (!IsDeleted && drow != string.Empty)
                    newDonation += drow + "|";
            }
            LineItems = string.Empty;
            LineItems = newDonation;
       }
       LineItems = "RID^" + rowCount.ToString() + "~Item^" + Name + "~ItemID^" + ID + "~Quantity^" + 1 + "~Rate^" + Rate +"~Type^"+Type+ "~Amount^" + (1 * Rate) + "|";
       TotalLineItems = TotalLineItems + LineItems;
       if (flag != 0 && flag!=-1)
       {
          ViewState["TotalLineItems"] = TotalLineItems ;
       }
       if (LineItems.Trim().Length > 0)
       BuildTable();
    }
    public void BuildTable()
    {
        List<TableCell> cells = new List<TableCell>();
        int colCount = 0;
        string rid = string.Empty;
        foreach (string drow in LineItems.Split('|'))
        {
            TableRow row = new TableRow();
            if (drow != string.Empty)
            {
                foreach (string column in drow.Split('~'))
                {
                    cells.Add(AddCell(column, out rid));
                    if (rid != string.Empty)
                    row.Attributes.Add("id", rid);
                }
                foreach (TableCell cell in cells)
                {
                    if(cell!=null)
                    row.Cells.Add(cell);
                }
                cells.Clear();
                gridTab.Rows.Add(row);
            }
        }
        gridTab.Visible = true;
        count++;
    }
    private TableCell AddCell(string column, out string rid)
    {   
        TextBox txtBoxQ = new TextBox();
        TextBox txtBoxR = new TextBox();
        TextBox txtBoxA = new TextBox();
        string colName = column.Split('^')[0];
        string colValue = column.Split('^')[1];
        double gst = 0;
        string temp = GetConfigValue("GST", OrgID);
        if (temp != null && temp != "" && temp != "Tax Percent")
            GST = Convert.ToDouble(GST);
        GST = Convert.ToDouble(GST);
        TableCell cell = new TableCell();
        if (colName != "Item")
        {
            cell.Attributes.Add("align", "center");
        }
        else
        {
            cell.Attributes.Add("align", "left");
        }
        rid = string.Empty;
        switch (colName)
        {
            case "RID":
                HyperLink hLnk = new HyperLink();
                //hLnk.ImageUrl = "~/Images/delete.jpg";
                //hLnk.NavigateUrl = "javascript:SampleBillPrintDeleteRow('" + colValue + "','" + did.ClientID + "');";
                cell.Width = Unit.Percentage(20);
                RowID = Convert.ToInt32(colValue);
                rid = colValue;
                cell = null;
                //cell.Controls.Add(hLnk);
                break;
            case "Item":
                cell.Text = colValue;
                cell.Width = Unit.Percentage(60);
                break;
            case "ItemID":
                cell.Text = colValue;
                cell.Style.Add("Display","none");
                //cell.Width = Unit.Percentage(40);
                break;
            case "Quantity":
                txtBoxQ.ID = colName + RowID;
                txtBoxQ.Style.Add("width", "25px");
                cell.Controls.Add(txtBoxQ);
                txtBoxQ.Attributes.Add("onblur", "javascript:calculate(this.id);");
                txtBoxQ.Attributes.Add("onKeyDown", "return validatenumber(event);");
                txtBoxQ.ToolTip = "Quantity";
                txtBoxQ.Text = String.Format("{0:0.00}", Convert.ToDouble(colValue));
                txtBoxQ.Style.Add("text-align", "right");
                cell.Width = Unit.Percentage(10);
                break;
            case "Rate":
                txtBoxR.ID = colName + RowID;
                cell.Controls.Add(txtBoxR);
                txtBoxR.Attributes.Add("onblur", "javascript:calculate(this.id);");
                txtBoxR.Attributes.Add("onKeyDown", "return validatenumber(event);");
                txtBoxR.ToolTip = "Rate";
                //txtBoxR.Attributes.Add("ReadOnly", "ReadOnly");
                txtBoxR.Style.Add("width", "50px");
                txtBoxR.Style.Add("text-align", "right");
                //if (GST > 0.0)
                //{
                //    gst = (1 + (GST / 100));
                //    txtBoxR.Text = String.Format("{0:0.00}", (Convert.ToDouble(colValue) / gst));
                //}
                //else
                //{
                    txtBoxR.Text = String.Format("{0:0.00}", Convert.ToDouble(colValue));
                //}
                cell.Width = Unit.Percentage(20);
                break;
            case "Type":
                cell.Text = colValue;
                cell.Style.Add("Display", "none");
                //cell.Width = Unit.Percentage(40);
                break;
            case "Amount":
                txtBoxA.ID = colName + RowID;
                cell.Controls.Add(txtBoxA);
                txtBoxA.Attributes.Add("ReadOnly", "ReadOnly");
                txtBoxA.ToolTip = "Amount";
                txtBoxA.Style.Add("width", "75px");
                txtBoxA.Style.Add("background-color", "#efefef");
                txtBoxA.Style.Add("border-color", "#d8d8d8");
                txtBoxA.Style.Add("border-style", "solid");
                txtBoxA.Style.Add("text-align", "right");
                //if (GST > 0.0)
                //{
                //    gst = (1 + (GST / 100));
                //    txtBoxA.Text = String.Format("{0:0.00}", (Convert.ToDouble(colValue) / gst));
                //}
                //else
                //{
                    txtBoxA.Text = String.Format("{0:0.00}", Convert.ToDouble(colValue));
               // }
                cell.Width = Unit.Percentage(20);
                break;
        };
        return cell;
    }
    protected void lnkAddMore_Click(object sender, EventArgs e)
    {
        
        //Response.Redirect("InvestigationSearch.aspx?vid=" + pVisitID + "&pid=" + pPatientID+"&cid="+pClientID, true);
        
    }
    protected void btnFinish_Click(object sender, EventArgs e)
    {
        long returnCode = -1;
        //try
        //{
        //    BillMaster billMaster = new BillMaster();
        //    BillLineItems billLineItems = new BillLineItems();
        //    billMaster.VisitID = pVisitID;
        //    billMaster.PatientID = pPatientID;
        //    billMaster.ClientID = pClientID;
        //    billMaster.GrossAmount = Convert.ToDecimal(txtGrossAmount.Value);
        //    billMaster.Discount = Convert.ToDecimal(txtDiscount.Value);
        //    billMaster.TaxPercent = Convert.ToDecimal(txtTaxPercent.Value);
        //    billMaster.NetAmount = Convert.ToDecimal(txtNetAmount.Value);
        //    billMaster.AmountReceived = Convert.ToDecimal(txtAmountReceived.Value);
        //    billMaster.AmountDue = Convert.ToDecimal(txtAmountDue.Value);
        //    billMaster.CreatedBy = LID;
        //    if (chkUseCredit.Checked == true)
        //    {
        //        billMaster.IsCredit = "Y";
        //    }
        //    else
        //    {
        //        billMaster.IsCredit = "N";
        //    }

        //    //billMaster = Getillmaster();
        //    // returnCode = GetBillItems(billMaster,pVisitID, pPatientID);
        //    long createTaskID = -1;

        //    // Create task to lab tech for collect samples
        //    //if (Convert.ToString(Request.QueryString["ftype"]) == "INV")
        //    //{
        //        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        //        returnCode = new PatientVisit_BL(base.ContextInfo).GetVisitDetails(pVisitID, out lstPatientVisitDetails);
        //        returnCode = Utilities.GetHashTable(Convert.ToInt64(TaskHelper.TaskAction.CollectSample), pVisitID, 0,
        //        pPatientID, lstPatientVisitDetails[0].TitleName + " " + lstPatientVisitDetails[0].PatientName, "", 0, "", "", 0, "INV", out dText, out urlVal);
        //        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.CollectSample);
        //        task.DispTextFiller = dText;
        //        task.URLFiller = urlVal;
        //        task.RoleID = RoleID;
        //        task.OrgID = OrgID;
        //        task.PatientVisitID = pVisitID;
        //        task.PatientID = pPatientID;
        //        task.TaskStatusID = (int)TaskHelper.TaskStatus.Pending;
        //        task.CreatedBy = LID;

        //        //Create task        
       
        //        returnCode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
        //   // }

        //    if (returnCode != 0)
        //    {
        //        //ErrorDisplay1.ShowError = true;
        //        //ErrorDisplay1.Status = "Error while saving Billing Details. Please try after some time.";
        //    }
        //    else
        //    {
        //        if (btnFinish.Text == "Finish")
        //        {
        //           // ErrorDisplay1.ShowError = true;
        //           // ErrorDisplay1.Status = "Billing Completed Successfully.";
        //        }
        //    }
        //    ViewState["TotalLineItems"] = "";
        //    Response.Redirect("ViewBill.aspx?type=N&billNo=" + pBillID, true);
        //}
        //catch (System.Threading.ThreadAbortException tae)
        //{
        //    string exp = tae.ToString();
        //}
        //catch (Exception ex)
        //{
        //    CLogger.LogError("Error While Saving Billing Details.", ex);
        //    //ErrorDisplay1.ShowError = true;
        //    //ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";

        //}
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
       // Response.Redirect("PatientSampleRegistration.aspx", true);
    }
    public long GetBillItems(BillMaster billMaster,long visitID,long patientID,out string billId )
    {
        int entry = -1;
        long rid = -1;
        long rtn = -1;
        billId = "";
        string temp;
       
        string newItems = string.Empty;
        string dtoRemove = string.Empty;
        dtoRemove = did.Value;
        List<BillLineItems> billItems = new List<BillLineItems>();
        items = TotalLineItems;
        if (items == "")
        {
            items = ViewState["TotalLineItems"].ToString();
        }
        else
        {
            if (flag != 0)
            {
                temp=ViewState["TotalLineItems"].ToString();
                if(temp!="")
                {
                    items =  temp;
                }
            }
        }
        if (dtoRemove.Trim().Length > 0)
        {
            foreach (string drow in items.Split('|'))
            {
                bool IsDeleted = false;
                foreach (string s in dtoRemove.Split(','))
                {
                    if (s != string.Empty && !IsDeleted)
                    {
                        if (drow.Contains("RID^" + s + "~"))
                        {
                            IsDeleted = true;
                        }
                    }
                }
                if (!IsDeleted && drow != string.Empty)
                newItems += drow + "|";
            }
            items = string.Empty;
            items = newItems;
        }
        foreach (string row in items.Split('|'))
        {
            if (row.Trim().Length != 0)
            {
                BillLineItems billItems1 = new BillLineItems();
                foreach (string column in row.Split('~'))
                {
                    string[] colNameValue;
                    string colName = string.Empty;
                    string colValue = string.Empty;
                    colNameValue = column.Split('^');
                    colName = colNameValue[0];
                    if (colNameValue.Length > 1)
                        colValue = colNameValue[1];
                    if (colName == "RID")
                    {
                        rid = Convert.ToInt64(colValue);
                    }
                    foreach (string rid1 in did.Value.Split(','))
                    {
                        if (rid1 != "")
                        {
                            if (rid == Convert.ToInt64(rid1))
                            {
                                entry = 0;
                            }
                        }
                    }
                    switch (colName)
                    {
                            case "Item":
                                billItems1.ItemName = colValue;
                                break;
                            case "ItemID":
                                billItems1.ItemID = Convert.ToInt64(colValue);
                                break;
                            case "Quantity":
                                // TextBox txtQuantity = FindControl("Quantity" + rid) as TextBox;
                                //string str = FindControl("Quantity" + rid).ClientID;
                                TextBox txtQuantity = FindControl("Quantity" + rid) as TextBox;
                                billItems1.Quantity = Convert.ToDecimal(txtQuantity.Text);
                                break;
                            case "Rate":
                                TextBox txtRate = FindControl("Rate" + rid) as TextBox;
                                billItems1.Rate = Convert.ToDecimal(txtRate.Text);
                                break;
                            case "Type":
                                billItems1.ItemType = colValue;
                                break;
                            case "Amount":
                                TextBox txtAmount = FindControl("Amount" + rid) as TextBox;
                                billItems1.Amount = Convert.ToDecimal(txtAmount.Text);
                                //  billItems1.Amount = Convert.ToDecimal(colValue);
                                break;
                    };
                }
                if (entry != 0)
                {
                    billItems.Add(billItems1);
                }
            }
            entry = -1;
        }
        
        Patient_BL patientBL = new Patient_BL(base.ContextInfo);
        System.Data.DataTable dtAmountReceived = new System.Data.DataTable();
        dtAmountReceived = PaymentType.GetAmountReceivedDetails();
        decimal dServiceCharge = 0;
        decimal.TryParse(hdnServiceCharge.Value, out dServiceCharge);

        rtn = patientBL.SaveBillDetails(billMaster, billItems, out pBillID, dtAmountReceived, dServiceCharge);
        billId = pBillID;
        return rtn;
    }
    protected void btnAddNewItem_Click(object sender, EventArgs e)
    {
        string itemName = txtNewItemName.Value;
        string test;
        long itemID = 0;
        decimal rate = 0;
        string type = "NEW";
        flag = 1;
        hdnOrderedItems.Value += itemID + "~" + itemName + " -"+CurrencyName+": " + rate + "~" + "NEW^";
        //ViewState["NewItems"] = ViewState["NewItems"]+itemName+",";
        //test = ViewState["NewItems"].ToString();
        LoadBillItems(itemName, itemID, rate, type);
        txtNewItemName.Value = "";
        AddNewItem(sender, e);
    }
    public BillMaster Getillmaster()
    {
        Int64.TryParse(Request.QueryString["pid"], out pPatientID);
        if (Request.QueryString["vid"] == null)
        {
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            List<OrderedInvestigations> lstOrdered = new List<OrderedInvestigations>();
            new PatientVisit_BL(base.ContextInfo).GetPatientLatestVisit(pPatientID, out lstPatientVisit, out lstOrdered);
            if (lstPatientVisit.Count > 0)
            {
                pVisitID = lstPatientVisit[0].PatientVisitId;
                pClientID = Convert.ToInt32(lstPatientVisit[0].ClientMappingDetailsID);
                pTPAID = lstPatientVisit[0].TPAID;
                
            }
        }
        else
        {
            Int64.TryParse(Request.QueryString["vid"], out pVisitID);
            //Int32.TryParse(Request.QueryString["cid"], out pClientID);
            List<PatientVisit> lstPatientVisit = new List<PatientVisit>();
            List<OrderedInvestigations> lstOrdered = new List<OrderedInvestigations>();
            new PatientVisit_BL(base.ContextInfo).GetPatientLatestVisit(pPatientID, out lstPatientVisit, out lstOrdered);
            if (lstPatientVisit.Count > 0)
            {
                //pVisitID = lstPatientVisit[0].PatientVisitId;
                pClientID = Convert.ToInt32(lstPatientVisit[0].ClientMappingDetailsID);
                pTPAID = lstPatientVisit[0].TPAID;

            }
            
        }

        BillMaster billMaster = new BillMaster();
        BillLineItems billLineItems = new BillLineItems();
        billMaster.OrgID = OrgID;
        billMaster.VisitID = pVisitID;
        billMaster.PatientID = pPatientID;
        billMaster.ClientID = pClientID;
        billMaster.TPAID = pTPAID;
        billMaster.GrossAmount = Convert.ToDecimal(txtGrossAmount.Value);
        billMaster.Discount = Convert.ToDecimal(txtDiscount.Value);
        billMaster.TaxPercent = Convert.ToDecimal(txtTaxPercent.Value);
        billMaster.NetAmount = Convert.ToDecimal(txtNetAmount.Value);
        billMaster.AmountReceived = Convert.ToDecimal(hdnAmountReceived.Value.ToString());
        billMaster.AmountDue = Convert.ToDecimal(txtAmountDue.Value);
        billMaster.CreatedBy = LID;
        if (txtComments.Value != "")
        {
            billMaster.Comments = txtComments.Value;
        }
        if (chkUseCredit.Checked == true)
        {
            billMaster.IsCredit = "Y";
        }
        else
        {
            billMaster.IsCredit = "N";
        }
        return billMaster;
    }
     
    public string addNewItemLblCaption
    {
        get { return addNewItemCaption.InnerText; }
        set { addNewItemCaption.InnerText = value; }
    }
    public string hdnOrderedItemsList
    {
        get { return hdnOrderedItems.Value; }
        set { hdnOrderedItems.Value = value; }
    }
    public string rtnItemList
    {
        get { return ViewState["TotalLineItems"].ToString(); }
        set { ViewState["TotalLineItems"] = value; }
    }
    public bool enableAddConTab
    {
        set { AddConTab.Visible = value; }
    }
    public string SetCheckHospitalCredit
    {
        get { return hdnCheckHospitalCredit.Value; }
        set { hdnCheckHospitalCredit.Value = value; }
    }

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
