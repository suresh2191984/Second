using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Podium.BusinessEntities;
using Attune.Solution.BusinessComponent;
using Attune.Podium.BillingEngine;
using Attune.Podium.Common;
using System.Collections;
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Xml;
using System.IO;
using PdfSharp.Drawing;
using PdfSharp.Pdf;
using PdfSharp.Pdf.IO;
using PdfSharp.Pdf.Advanced;
using PdfSharp.Pdf.Security;
using System.Web.UI.HtmlControls;
using System.Text;
using System.Security.Cryptography;
using Attune.Podium.PerformingNextAction;
    public partial class Invoice_GenerateInvoice : BasePage
    {
    BillingEngine bill;
    List<Organization> lstOrganization = new List<Organization>();
    static List<ReasonMaster> lstReason = new List<ReasonMaster>();
    long ClientID = 0;
    string ClientCode = string.Empty;
    string IsApprovalrequired = string.Empty;
    string fdate;
    string todate;
    string clientName = string.Empty;
    string CName = string.Empty;
    string PageValue = string.Empty;
    string ApproveStatus = string.Empty;
    long InvoiceID = 0;
    long ScID = 0;
    int Rejbills = 0;
    decimal GrsAmt = 0;
    decimal DebitAmt = 0;
    int total = 0;
    ActionManager objActionManager;
    StringBuilder strBuildTax = new StringBuilder();
    string strSelect = Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_005 == null ? "--Select-- : " : Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_005;
    public Invoice_GenerateInvoice()
        : base("Invoice_GenerateInvoice_aspx")
    {
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        bill = new BillingEngine(base.ContextInfo);
        objActionManager = new ActionManager(base.ContextInfo);
        ModalPopupExtender2.Hide();
        hdnIsWaters.Value = GetConfigValue("WatersMode", OrgID);
        
        if (!IsPostBack)
        {
           

            if (Request.QueryString["IsA"] != null)
            {
                IsApprovalrequired = Request.QueryString["IsA"];
            }

            if (IsApprovalrequired.TrimEnd() != "Y" || IsApprovalrequired == "")
            {
                btnGenerateInvoice.Style.Add("Display", "Inline");
                btnGenerateTask.Style.Add("Display", "None");
            }
            else
            {
                btnGenerateInvoice.Style.Add("Display", "None");
                btnGenerateTask.Style.Add("Display", "Block");

            }
           // AutoAuthorizer.ContextKey = OrgID.ToString();
           
            LoadReasonMaster();
            LoadInvoiceBill();
            LoadDiscount();
            LoadTaxmaster();
           // LoadDesignations();
            LoadDiscountReason();           
            LoadTODRangeAmount();
            LoadInvoiceDiscount();
            LoadMetaData();
            txtGross.Text = hdnGrsAmt.Value.ToString();
            txtNetAmt.Text = hdnGrsAmt.Value.ToString();
            //NeedApproval();

        }
        if (IsPostBack)
        {
            if (hdnShowReport.Value == "true")
            {
                rptMdlPopup.Show();
            }
            else
            {
                rptMdlPopup.Hide();
            }
        }
        if (Request.QueryString["InvoiceID"] != null)
        {
            Int64.TryParse(Request.QueryString["InvoiceID"], out InvoiceID);
        }
        if (Request.QueryString["InvoiceID"] != null && Request.QueryString["tid"] != null)
        {
            hdnInvID.Value = Request.QueryString["InvoiceID"].ToString();
           
        }
       



    }

    public void LoadInvoiceDiscount()
    {
        if (!String.IsNullOrEmpty(hdnInvoiceDiscount.Value) && hdnInvoiceDiscount.Value != "0")
        {
            string[] objDiscount = hdnInvoiceDiscount.Value.Split('~');
            if (objDiscount.Count() > 0)
            {
                foreach (string oDis in objDiscount)
                {
                    if (!String.IsNullOrEmpty(oDis))
                    {
                        ddDiscountPercent.SelectedValue = Convert.ToString(objDiscount[0]);
                        hdnDisPer.Value = Convert.ToString(objDiscount[1]);
                        txtDiscountAmt.Text = Convert.ToString(objDiscount[2]);
                        DdlDiscountreason.SelectedValue = Convert.ToString(objDiscount[3]);
                        txtDisCountReason.Text = Convert.ToString(objDiscount[4]);
                       

                    }
                }
            }

            trDiscountReason.Style.Add("display", "block");
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:CalCulateAmtvalue();", true);
        }
    }




    private void LoadReasonMaster()
    {
        try
        {
            long returnCode = -1;
            string ReasonCode = "INVCA";
            Master_BL objReasonMaster = new Master_BL(base.ContextInfo);
            returnCode = objReasonMaster.GetReasonMaster(1, 1, ReasonCode, out lstReason);
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error in load GetReasonMaster details", ex);
        }
    }

    public void LoadTODRangeAmount()
    {
        long ClientID = -1;
        long ReturnCode = -1;
        List<DiscountPolicy> lstTOD = new List<DiscountPolicy>();
        try
        {
            using (Master_BL Master_BL = new Master_BL(base.ContextInfo))
            {
                if ((Request.QueryString["CID"] != null) && (Request.QueryString["CID"] != ""))
                {
                    Int64.TryParse(Request.QueryString["CID"], out ClientID);
                }
                ReturnCode = Master_BL.GetTODforInvoice(OrgID, ClientID, out lstTOD);

                if (lstTOD.Count > 0)
                {
                    foreach (DiscountPolicy objDiscount in lstTOD)
                    {
                        //CODE CHANGES BY PREM DISCOUNT POLICY TABLE STRUCTURE CHANGED///
                        hdnTODdetails.Value += objDiscount.TODID.ToString() + '~' + objDiscount.RangeFrom + '~' + objDiscount.RangeTo + '~' + objDiscount.Value + '^';
                    }
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:CalCulateAmtvalue();", true);
                }
                else
                {
                    txtTOD.Text = "0.00";
                }

            }
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error While Loding DiscountPolicy()", ex);
        }
    }

    private void LoadInvoiceBill()
    {
    List<Config> lstConfig = new List<Config>();
    int iBillGroupID = 0;
    iBillGroupID = (int)ReportType.OPBill;
    List<BillingDetails> lstInvoice = new List<BillingDetails>();
    List<DiscountPolicy> lstVolumediscount = new List<DiscountPolicy>();
    List<CreditDebitSummary> lstCreditDebit = new List<CreditDebitSummary>();

    List<OrgUsers> lstOrgUsers = new List<OrgUsers>();
        string DispMsgFrom = Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_003 == null ? "From : " : Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_003;
        string DispMsgTo = Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_004 == null ? "To : " : Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_004;
    if (Request.QueryString["CID"] != null)
    {
        Int64.TryParse(Request.QueryString["CID"], out ClientID);
    }

    if (Request.QueryString["CCode"] != null)
    {
        ClientCode =Request.QueryString["CCode"];
    }

    if (Request.QueryString["TDate"] != null)
    {
    todate = (Request.QueryString["TDate"]);
    }
    if (Request.QueryString["FDate"] != null)
    {
    fdate = (Request.QueryString["FDate"]);
    }
    if (Request.QueryString["CName"] != null)
    {
    clientName = (Request.QueryString["CName"]);
    }
    if (Request.QueryString["Pvalue"] != null)
    {
    PageValue = (Request.QueryString["Pvalue"]);
    }
    if (Request.QueryString["InvoiceID"] != null)
    {
        Int64.TryParse(Request.QueryString["InvoiceID"], out InvoiceID);
    }


    if (Request.QueryString["RejBill"] != null)
    {
        Int32.TryParse(Request.QueryString["RejBill"], out Rejbills);
    }

    if (lstOrgUsers.Count > 0)
    {

   // txtAuthorizer.Text = lstOrgUsers[0].Name;
    }
    //new GateWay().GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);
    long lresult = new SharedInventory_BL().getOrganizationAddress(OrgID, ILocationID, out lstOrganization);

    if (lstOrganization.Count > 0)
    {
        lblHospitalName.InnerHtml = lstOrganization[0].Name.Trim() + "<br/>" + lstOrganization[0].Address.ToString() + "<br/>" + lstOrganization[0].City.ToString();
    }
    lblClient.Text = clientName;
    lblClientCode.Text = ClientCode;
    if (todate == "01/01/0001")
    {
        todate = "01/01/1900";

    }
    if (todate == "01/01/1900" || todate == "01/01/1900 00:00:00")
    {
        DateTime dt = Convert.ToDateTime(fdate);
        todate = dt.AddDays(1 + Convert.ToDouble(dt.DayOfWeek)).ToString("dd/MM/yyyy");

            lblfrom.Text = Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_002 == null ? "All Un-Invoiced Bills" : Resources.Invoice_ClientDisplay.Invoice_GenerateInvoice_aspx_002;
    }
    else
    {
            // lblfrom.Text = "From : " + fdate + "   TO : " + todate;
            lblfrom.Text = DispMsgFrom + fdate + DispMsgTo + todate;
    }
    if (fdate == "")
    {
        fdate = DateTime.Now.ToString("dd/MM/yyyy");
    }
    if (todate == "")
    {
        todate = DateTime.Now.ToString("dd/MM/yyyy");
    }
    if (hdnIsWaters.Value != "Y")
    {

        bill.GetInvoiceGeneration(InvoiceID, ClientID, OrgID, ILocationID, Convert.ToDateTime(fdate), Convert.ToDateTime(todate), Rejbills, out lstInvoice, out lstVolumediscount, out lstCreditDebit);

    }
    else {

        bill.GetWatersInvoiceGeneration(InvoiceID, ClientID, OrgID, ILocationID, Convert.ToDateTime(fdate), Convert.ToDateTime(todate), Rejbills, out lstInvoice, out lstVolumediscount, out lstCreditDebit);
       // bill.GetWatersInvoiceGeneration(InvoiceID, ClientID, OrgID, ILocationID, Convert.ToDateTime(Fdate), Convert.ToDateTime(Tdate), tempID, out lstInvoice, out lstVol, out lstCreditDebit);

    
    }
    if (lstInvoice.Count > 0)
    {
        lblRecAmt.Text = Convert.ToString(lstInvoice[0].AmountReceived);
        lblDueAmt.Text = Convert.ToString(lstInvoice[0].Due);
        if (hdnIsWaters.Value == "Y")
        {
            lblfrom.Text = DispMsgFrom + Convert.ToString(lstInvoice[0].RefPhyName) + DispMsgTo + Convert.ToString(lstInvoice[0].ReferenceType);
        }


        hdnInvoiceDiscount.Value = Convert.ToString(lstInvoice[0].Discount);
        txtVolumeAmount.Text = Convert.ToString(lstInvoice[0].VolumeDiscount);
        grdInvoiceBill.DataSource = lstInvoice;
        grdInvoiceBill.DataBind();
    }

    if(lstCreditDebit.Count > 0)
    {
        lblCrDB.Visible = true;
        GrdCreditDebit.DataSource = lstCreditDebit;
        GrdCreditDebit.DataBind();
    }




    if (lstVolumediscount.Count > 0)
    {
        lblVolumeDiscounts.Visible = true;
        GrdVolumebased.DataSource = lstVolumediscount;
        GrdVolumebased.DataBind();

    }


    }
    protected void grdInvoiceBill_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if ((string)(DataBinder.Eval(e.Row.DataItem, "IsCreditBill")) == "Y")
            {

                e.Row.BackColor = System.Drawing.Color.PapayaWhip;

            }
            else
            {
                e.Row.BackColor = System.Drawing.Color.BurlyWood; 
            }

            BillingDetails inv = (BillingDetails)e.Row.DataItem;
            GrsAmt = GrsAmt + inv.Rate;
            hdnGrsAmt.Value = GrsAmt.ToString();
            CheckBox chkAll = (CheckBox)e.Row.FindControl("chkInvoiceItem");
            DropDownList ddlReason = (DropDownList)e.Row.FindControl("ddlReason");

            ddlReason.DataSource = lstReason;
            ddlReason.DataValueField = "ReasonID";
            ddlReason.DataTextField = "Reason";
            ddlReason.DataBind();
            ddlReason.Items.Insert(0, new ListItem(strSelect, "0"));

            if (chkAll.Checked == true)
            {
                ddlReason.Style.Add("display", "none");
            }
            else
            {
                ddlReason.Style.Add("display", "block");
            }
            if (hdnchkAll.Value == "")
            {
                hdnchkAll.Value = chkAll.ClientID;
            }
            else
            {
                hdnchkAll.Value += "~" + chkAll.ClientID;
            }
            string str = ddlReason.ClientID;
            chkAll.Attributes.Add("onclick", "ChkboxSelectedItems(this.id,'"+str+"')"); 
        }
    }
    protected void btnGenerateInvoice_Click(object sender, EventArgs e)
    {
        string Tstatus = string.Empty;
        string reportPath = string.Empty;
        decimal GrsAmt, Netamt;
        long returnCode = -1;
        long CreateBy = 0;
        string Tax = string.Empty;      
        decimal TOD;
        decimal VolumeDiscountAmt;
        long FinalBillID = 0;
        long InvoiceID = 0;
        string Discount = string.Empty;
        int DisPer = 0;
        int DiscountID = 0;
        decimal DiscountAmt = 0;
      
        Tax = CreateClientXML();
        if (Request.QueryString["InvoiceID"] != null)
        {
            Int64.TryParse(Request.QueryString["InvoiceID"], out InvoiceID);
        }
        string Aprover = string.Empty;
        string desgnation = string.Empty;
        string Status = string.Empty;
        long discoutResCode = 0;
        long desgID = 0;
        long Approverid = 0;
        string DiscountRes = string.Empty;
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        PageContextDetails.PageID = PageID;
        string InvoiceType = String.Empty;
        if (ddlInvoiceType.SelectedItem.Value != "0")
        {
            InvoiceType = ddlInvoiceType.SelectedItem.Value;
        }
        else
        {
            InvoiceType = "Orginal"; 
        }
        int flag = 1;

        if (Request.QueryString["CID"] != null)
        {
            Int64.TryParse(Request.QueryString["CID"], out ClientID);
        }
        if (Request.QueryString["TDate"] != null)
        {
            todate = (Request.QueryString["TDate"]);
        }
        if (todate == "01/01/0001")
        {
            todate = "01/01/1900";

        }
        if (Request.QueryString["FDate"] != null)
        {
            fdate = (Request.QueryString["FDate"]);
        }
        if (Request.QueryString["SID"] != null)
        {
            Int64.TryParse(Request.QueryString["SID"], out ScID);
        }
  

        if (hdnStatus.Value == "1")
        {
            Status = "Pending";
        }
        else
        {
            Status = "Completed";
        }

        if (Request.QueryString["InvoiceID"] != null && Request.QueryString["tid"] != null)
        {
            Tstatus = "APPROVED";
             Status = "Completed";
        }
        else
        {
             Tstatus = string.Empty;
        }
      List<Invoice> lstInvoices = new List<Invoice>();
        Invoice InvoiceItems = new Invoice();
        GrsAmt = Convert.ToDecimal(txtGross.Text);
        if (!String.IsNullOrEmpty(ddDiscountPercent.SelectedValue) && ddDiscountPercent.SelectedValue != "0")
        {
            DiscountID = Convert.ToInt32(ddDiscountPercent.SelectedValue.ToString());
        }
        if (!String.IsNullOrEmpty(hdnDisPer.Value) && hdnDisPer.Value != "0")
        {
            DisPer = Convert.ToInt32(hdnDisPer.Value);
        }

        if (!String.IsNullOrEmpty(txtDiscountAmt.Text) && (txtDiscountAmt.Text != "0.00"))
        {
            DiscountAmt = Convert.ToDecimal(txtDiscountAmt.Text);
        }

        if (DiscountID != 0 && DisPer != 0 && DiscountAmt != 0)
        {
            Discount = DiscountID + "~" + DisPer + "~" + DiscountAmt + "~";
        } 

        CreateBy = LID;       
        Aprover = RoleName;
        Approverid = Convert.ToInt64(hdnApprovedByID.Value);
        VolumeDiscountAmt = Convert.ToDecimal(txtVolumeAmount.Text);
        Netamt = Convert.ToDecimal(txtNetAmt.Text);
        TOD = Convert.ToDecimal(txtTOD.Text);
        
        discoutResCode = Convert.ToInt64(hdnDisResCode.Value);
        if (!String.IsNullOrEmpty(txtDisCountReason.Text) && txtDisCountReason.Text.Length > 0)
        {

            int DiscountResID = Convert.ToInt32(DdlDiscountreason.SelectedValue.ToString());
            string DReason = txtDisCountReason.Text;
            DiscountRes = DiscountResID + "~" + DReason + "~";

        }
        foreach (GridViewRow grd in grdInvoiceBill.Rows)
        {
            string UDTStatus = string.Empty;
            string drpReason = string.Empty;
            UDTStatus = "APPROVED";
            CheckBox chkbox = (CheckBox)grd.FindControl("chkInvoiceItem");
            DropDownList Reason = (DropDownList)grd.FindControl("ddlReason");
            if (chkbox.Checked == false)
            {
                UDTStatus = "Rejected";
                drpReason = Reason.SelectedItem.Text;
            }
            else
            {
                UDTStatus = "APPROVED";                

            }
            //flag = 1;
            Label lblFinalBillID = (Label)grd.FindControl("lblFinalBillID");
              Label lblPT = (Label)grd.FindControl("lblPT");
                string PayType = lblPT.Text;

                if (PayType == "Bill")
                {
                    FinalBillID = Convert.ToInt64(lblFinalBillID.Text);
                    InvoiceItems.FinalBillID = Convert.ToInt64(FinalBillID);
                    InvoiceItems.RefType = "GB";
                    InvoiceItems.RefID = 0;
                }
                else
                {
                    InvoiceItems.RefID = Convert.ToInt64(lblFinalBillID.Text);
                    InvoiceItems.RefType = "AC";
                }
                InvoiceItems.Status = UDTStatus;
                InvoiceItems.Reason = drpReason;
           
            InvoiceItems.ClientID = Convert.ToInt64(ClientID);
            lstInvoices.Add(InvoiceItems);
            InvoiceItems = new Invoice();
           
        }
        if (flag > 0)
        {
            returnCode = bill.SaveInvoiceBill(GrsAmt, Discount, DiscountRes, Netamt, CreateBy, Tax, ClientID, OrgID, ILocationID, FinalBillID, lstInvoices, Convert.ToDateTime(fdate), Convert.ToDateTime(todate), TOD, ScID, Status, PageContextDetails, Approverid, InvoiceID, Tstatus, VolumeDiscountAmt, out InvoiceID,InvoiceType);

        }
     
        //if (chkApprover.Checked != true)
        //{
            if (returnCode >= 0)
            {
                string Type = string.Empty;
                long ReportTemplateID = 0;
                Type = "Invoice";

                List<BillingDetails> lstReportPath = new List<BillingDetails>();
                returnCode = bill.GetInvoiceReportPath(OrgID, Type, ClientID, ReportTemplateID, out lstReportPath);
                if (lstReportPath.Count > 0)
                {
                    reportPath = lstReportPath[0].RefPhyName.ToString();
                }
                else
                {

                }

                if (Request.QueryString["InvoiceID"] != null)
                {
                    Int64.TryParse(Request.QueryString["InvoiceID"], out InvoiceID);
                    ShowReport(reportPath, InvoiceID, OrgID, ILocationID,LID);
                }
                else
                {

                    ShowReport(reportPath, InvoiceID, OrgID, ILocationID,LID);
                }
                //Response.Redirect("../Invoice/InvoicePrinting.aspx?ID=" + InvoiceID + "&CID=" + ClientID);
                rptMdlPopup.Show();

            }
       // }
        

        //Response.Redirect("../Invoice/InvoicePrinting.aspx?ID=1");

    }

    string CreateClientXML()
    {

        XmlDocument Doc = new XmlDocument();
        Doc.LoadXml("<ClientTax></ClientTax>");
        XmlNode xmlNode;
        foreach (string O in hdnClientTax.Value.Split('^'))
        {
            if (O != string.Empty)
            {
                string GrossValue = string.Empty;

                if (!String.IsNullOrEmpty(hdnGrsAmt.Value) && hdnGrsAmt.Value.Length > 0)
                {
                    GrossValue = hdnGrsAmt.Value;

                    string TaxValue = string.Empty;
                    decimal Totaltax = 0;
                    string TaxName = string.Empty;
                    string TaxID = string.Empty;
                    string Code = string.Empty;
                    string TaxPercent = string.Empty;
                    string TaxAmount = string.Empty;

                    if (O.Split('~')[1] != string.Empty)
                    {
                        TaxID = O.Split('~')[1];
                    }
                    if (O.Split('~')[0] != string.Empty)
                    {

                        TaxName = O.Split('~')[0];

                    }                    
                    if (O.Split('~')[2] != string.Empty)
                    {

                        Code = O.Split('~')[2];

                    }
                    if (O.Split('~')[3] != string.Empty)
                    {                      

                        TaxPercent = O.Split('~')[3];
                   

                     TaxValue = ((Convert.ToDecimal(GrossValue) * Convert.ToDecimal(O.Split('~')[3])) / 100).ToString();
                     Totaltax = Math.Round(Convert.ToDecimal(TaxValue), 2);
                     TaxAmount = Convert.ToString(Totaltax);

 }

                    XmlElement xmlElement = Doc.CreateElement("Attributes");

                    xmlNode = Doc.CreateNode(XmlNodeType.Element, "TaxID", "");
                    xmlNode.InnerText = TaxID;
                    xmlElement.AppendChild(xmlNode);

                    xmlNode = Doc.CreateNode(XmlNodeType.Element, "TaxName", "");
                    xmlNode.InnerText = TaxName;
                    xmlElement.AppendChild(xmlNode); 

                    xmlNode = Doc.CreateNode(XmlNodeType.Element, "Code", "");
                    xmlNode.InnerText = Code;
                    xmlElement.AppendChild(xmlNode);

                    xmlNode = Doc.CreateNode(XmlNodeType.Element, "TaxPercent", "");
                    xmlNode.InnerText = TaxPercent;
                    xmlElement.AppendChild(xmlNode);

                    xmlNode = Doc.CreateNode(XmlNodeType.Element, "TaxAmount", "");
                    xmlNode.InnerText = TaxAmount;
                    xmlElement.AppendChild(xmlNode);

                    Doc.DocumentElement.AppendChild(xmlElement);
                }
            }
        }
        return Doc.InnerXml;
    }

    protected void btnCnl_Click(object sender, EventArgs e)
    {
       try
    {
    long returnCode = -1;
    List<Role> lstUserRole = new List<Role>();
    string path = string.Empty;
    Role role = new Role();
    role.RoleID = RoleID;
    lstUserRole.Add(role);
    returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
    Response.Redirect(Request.ApplicationPath + path, true);
    }
    catch (System.Threading.ThreadAbortException tae)
    {
    string thread = tae.ToString();
    }
    
    }


    protected void btnCancel_Click(object sender, EventArgs e)
    {
    try
    {
    long returnCode = -1;
    List<Role> lstUserRole = new List<Role>();
    string path = string.Empty;
    Role role = new Role();
    role.RoleID = RoleID;
    lstUserRole.Add(role);
    returnCode = new Navigation().GetLandingPage(lstUserRole, out path);
    Response.Redirect(Request.ApplicationPath + path, true);
    }
    catch (System.Threading.ThreadAbortException tae)
    {
    string thread = tae.ToString();
    }
    }
    private void LoadTaxmaster()
    {
        long returnCode = -1;
        List<ClientMaster> lsttaxmaster = new List<ClientMaster>();
        List<Taxmaster> lstTaxmaster = new List<Taxmaster>();
        Master_BL taxmas = new Master_BL(base.ContextInfo);
        if ((Request.QueryString["CID"] != null) && (Request.QueryString["CID"] != ""))
        {
            Int64.TryParse(Request.QueryString["CID"], out ClientID);
        }
        returnCode = taxmas.GetTaxforClient(OrgID, ClientID, out lsttaxmaster);

 
        List<int> lstTaxDiscount = new List<int>();
        foreach (ClientMaster objClientMaster in lsttaxmaster)
        {
            if (lsttaxmaster[0].Tax != null)
            {
                string[] objTax = objClientMaster.Tax.Split('~');
                if (objTax.Count() > 0)
                {
                    foreach (string oTax in objTax)
                    {
                        if (!String.IsNullOrEmpty(oTax))
                        {                           
                                int taxID = 0;
                                Int32.TryParse(oTax, out taxID);
                                lstTaxDiscount.Add(taxID);
                            
                        }
                    }
                }
            }
        }
        lstTaxDiscount.Sort();
        
        Dictionary<string, string> lstTaxCodePer = new Dictionary<string, string>();
        string ClientTax = string.Empty;
        foreach (ClientMaster objClientMaster in lsttaxmaster)
        {
            if (lsttaxmaster[0].Termsconditions != null)
            {
                string[] objTaxPer = objClientMaster.Termsconditions.Split('^');
                foreach (string oTaxCode in objTaxPer)
                {
                    if (!String.IsNullOrEmpty(oTaxCode))
                    {
                        string[] lstTaxCode = oTaxCode.Split('~');
                        int id = 0;
                        Int32.TryParse(lstTaxCode[1], out id);
                       
                        if (lstTaxDiscount.Contains(id))
                            {
                                ClientTax += oTaxCode + '^';
                                hdnClientTax.Value += oTaxCode + '^';
                            }
                        
                    }
                }
            }
        }

        

        string startTag = "<table width=100% border='0' cellspacing='2' cellpadding='2' CssClass='textBoxRightAlign'>";
        string endTag = "</table>";
        string bodytag=string.Empty;
        if (!String.IsNullOrEmpty(ClientTax) && ClientTax.Length > 0)
        {
            bodytag = startTag;
            string[] GenerateTax = ClientTax.Split('^');
            for (int i = 0; i < GenerateTax.Count(); i++)
            {
                string TaxValue = string.Empty;
                string GrossValue = string.Empty;
                decimal Totaltax=0;
                if (!String.IsNullOrEmpty(hdnGrsAmt.Value) && hdnGrsAmt.Value.Length > 0)
                {
                    GrossValue = hdnGrsAmt.Value;

                    if (!String.IsNullOrEmpty(GenerateTax[i]) && GenerateTax[i].Length > 0)
                    {
                        if (!String.IsNullOrEmpty(GenerateTax[i].Split('~')[3]) && GenerateTax[i].Split('~')[3].Length > 0)
                        {
                            TaxValue = ((Convert.ToDecimal(GrossValue) * Convert.ToDecimal(GenerateTax[i].Split('~')[3])) / 100).ToString();
                            Totaltax = Math.Round(Convert.ToDecimal(TaxValue), 2);
                        }
                        bodytag += "<tr>";
                        bodytag += "<td align='right'>" + GenerateTax[i].Split('~')[0] + '(' + GenerateTax[i].Split('~')[3].Split('.')[0] +'%' + ')' + "</td>";
                        bodytag += "<td><input type='text' onKeyPress='javascript: return false;'onKeyDown='javascript: return false;'onPaste='javascript: return false;' style='text-align:right' size='15' id='txtTax" + GenerateTax[i].Split('~')[2] + "' value='" + Convert.ToString(Totaltax) + "' /></td>";
                        bodytag += "</tr>";
                    }
                }
            }
            bodytag += endTag;
        } 
        divGenerateTax.InnerHtml = "";
        if (!String.IsNullOrEmpty(bodytag) && bodytag.Length > 0)
        {
            divGenerateTax.InnerHtml = bodytag;
        }
        

        ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:CalCulateAmtvalue();", true);



    }

    private void LoadDiscount()
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
    ddDiscountPercent.DataValueField = "DiscountID";
    ddDiscountPercent.DataBind();
    ddDiscountPercent.Items.Insert(0, new ListItem(strSelect, "0"));

    if (getDiscount.Count > 0)
    {

        foreach (DiscountMaster objDiscount in getDiscount)
        {
            
            hdnDiscount.Value += objDiscount.DiscountID.ToString() + '~' + objDiscount.DiscountName + '~' + objDiscount.Discount + '^';
            
        }

    ddDiscountPercent.Style.Add("display", "block");

    }
    else
    {
    ddDiscountPercent.Style.Add("display", "none");

    }
    }
    else
    {
    ddDiscountPercent.DataSource = null;
    ddDiscountPercent.DataBind();
    ddDiscountPercent.Items.Insert(0, strSelect);
    ddDiscountPercent.Items[0].Value = "select";
    ddDiscountPercent.Style.Add("display", "none"); 

    }

    }
    catch (Exception ex)
    {
    CLogger.LogError("Error While Loading Lab Discount Details.", ex);
    }

    }

    //private void LoadDesignations()
    //{
    //long returnCode = -1;
    //List<DesignationMaster> lstDesignationMaster = new List<DesignationMaster>();
    //returnCode = bill.LoadDesignations(OrgID, out lstDesignationMaster);
    //if (lstDesignationMaster.Count > 0)
    //{
    //ddlDesignation.DataTextField = "DesignationName";
    //ddlDesignation.DataValueField = "DesignationID";
    //ddlDesignation.DataSource = lstDesignationMaster;
    //ddlDesignation.DataBind();

    //}
    //}

    private void LoadDiscountReason()
    {
    try
    {
    long retCode = -1;

    Patient_BL patBL = new Patient_BL(base.ContextInfo);
    List<DiscountReasonMaster> getDiscount = new List<DiscountReasonMaster>();
    retCode = patBL.GetDiscountReason(OrgID, out getDiscount);
    if (getDiscount.Count > 0)
    {
    DdlDiscountreason.DataSource = getDiscount;
    DdlDiscountreason.DataTextField = "ReasonDesc";
    DdlDiscountreason.DataValueField = "ReasonId";
    DdlDiscountreason.DataBind();
    DdlDiscountreason.Items.Insert(0, strSelect);
    foreach (var item in getDiscount)
    {
    hdndiscountreason.Value += item.ReasonId + "~" + item.ReasonCode + "~" + item.ReasonDesc + "^";

    }
    }
    else
    {
    DdlDiscountreason.Style.Add("display", "none");
    }

    }
    catch (Exception ex)
    {
    CLogger.LogError("Error While Loading Lab Discount Details.", ex);
    }

    }
    public void ShowReport(string reportPath, long InvID, long Orgid, long OrgAddressID,long LID)
    {
        try
        {
            string InvoiceType = String.Empty;
            if (ddlInvoiceType.SelectedItem.Value != "0")
            {
                InvoiceType = ddlInvoiceType.SelectedItem.Value;
            }
            else
            {
                InvoiceType = ddlInvoiceType.SelectedItem.Value;
            }
            hdnShowReport.Value = "true";
            rReportViewer.Visible = true;
            rReportViewer.Attributes.Add("style", "width:100%; height:484px");
            string strURL = string.Empty;
            string connectionString = "";
            connectionString = Utilities.GetConnectionString();
            rReportViewer.ServerReport.ReportServerCredentials = new MyReportServerCredent();
           // strURL = "http://attune4-pc/ReportServer";
            strURL = GetConfigValues("ReportServerURL", OrgID);
            rReportViewer.ServerReport.ReportServerUrl = new Uri(strURL);
            rReportViewer.ServerReport.ReportPath = reportPath;
            rReportViewer.ShowParameterPrompts = false;
            Microsoft.Reporting.WebForms.ReportParameter[] reportParameterList = new Microsoft.Reporting.WebForms.ReportParameter[6];
            reportParameterList[0] = new Microsoft.Reporting.WebForms.ReportParameter("pInvoiceID", Convert.ToString(InvID));
            reportParameterList[1] = new Microsoft.Reporting.WebForms.ReportParameter("pOrgID", Convert.ToString(OrgID));
            reportParameterList[2] = new Microsoft.Reporting.WebForms.ReportParameter("OrgAddressID", Convert.ToString(ILocationID));
            reportParameterList[3] = new Microsoft.Reporting.WebForms.ReportParameter("ConnectionString", connectionString);
            reportParameterList[4] = new Microsoft.Reporting.WebForms.ReportParameter("LoginID", Convert.ToString(LID));
            reportParameterList[5] = new Microsoft.Reporting.WebForms.ReportParameter("InvoiceType", Convert.ToString(InvoiceType));
            rReportViewer.ServerReport.SetParameters(reportParameterList);
            hdnInvID.Value = Convert.ToString(InvID); 
            //SendInvoiceEMail();
            SendEmail();
        }
        catch (Exception ex)
        {
            CLogger.LogError("Error while Loading SSRS", ex);
        }

        #region DontDelete
    //    try
    //{
    //hdnShowReport.Value = "true";
    //rReportViewer.Visible = true;
    //string InvoiceID = InvID.ToString();
    //myiframe.Attributes["src"] = "PrintInvoiceDetails.aspx?InvID=" + InvID + "&reportPath=" + reportPath;
  
    
 
    //}
    //catch (Exception ex)
    //{
    //CLogger.LogError("Error while Loading SSRS", ex);
    //}
        #endregion

    }

    protected void SendEmail()
    {
        try
        {
            ActionManager AM = new ActionManager(base.ContextInfo);
            List<PageContextkey> lstpagecontextkeys = new List<PageContextkey>();
            PageContextkey PC = new PageContextkey();
            PC.ID = Convert.ToInt64(ILocationID);
            PC.PatientID = ClientID;
            PC.RoleID = Convert.ToInt64(RoleID);
            PC.OrgID = OrgID;
            PC.PatientVisitID = ClientID;
            PC.PageID = Convert.ToInt64(PageID);
            PC.ButtonName = "btnGenerateInvoice";
            PC.ButtonValue = "Generate Bill";
            PC.ContextType = "INV";
            lstpagecontextkeys.Add(PC);
            long res = -1;
            res = AM.PerformingNextStepNotification(PC, fdate,todate);
        }
        catch (Exception ex)
        {
           // ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "Unable to send invoice mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }

    }

    protected void SendInvoiceEMail()
    {
        
        long InvID = 0;
        InvID = Convert.ToInt64(hdnInvID.Value);
        string deviceInfo = null;
        string format = "PDF";
        Byte[] results;
        string encoding = String.Empty;
        string mimeType = String.Empty;
        string extension = String.Empty;
        string[] streamIDs = null;
        Microsoft.Reporting.WebForms.Warning[] warnings = null;
        MemoryStream sourceStream = null;
        MemoryStream targetStream = null;
        try
        {
         
           long returnCode = -1;
            targetStream = new MemoryStream();
            List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
            GateWay gateWay = new GateWay(base.ContextInfo);
     
            returnCode = gateWay.GetCommunicationDetails(CommunicationType.Invoice,InvID, LocationName, out lstCommunicationDetails);
            if (lstCommunicationDetails.Count > 0 && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
            {
            results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
            sourceStream = new MemoryStream(results);
            PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
            PdfSecuritySettings securitySettings = document.SecuritySettings;
            string DocPassword = RandomPassword.Generate(8, 10);

            securitySettings.UserPassword = DocPassword;
            securitySettings.OwnerPassword = DocPassword;
            securitySettings.PermitAccessibilityExtractContent = false;
            securitySettings.PermitAnnotations = false;
            securitySettings.PermitAssembleDocument = false;
            securitySettings.PermitExtractContent = false;
            securitySettings.PermitFormsFill = false;
            securitySettings.PermitFullQualityPrint = true;
            securitySettings.PermitModifyDocument = false;
            securitySettings.PermitPrint = true;
            document.Save(targetStream, false);

            List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
            MailAttachment objMailAttachment = new MailAttachment();
            objMailAttachment.ContentStream = targetStream;
            objMailAttachment.FileName = "InvoiceReport_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
            lstMailAttachment.Add(objMailAttachment);
            MailConfig oMailConfig = new MailConfig();
            ActionManager OBJ = new ActionManager();
            OBJ.GetEMailConfig(OrgID, out oMailConfig);
            Communication.SendMail(lstCommunicationDetails[0].To, lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Invoice Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your Invoice E-Settlement-report is now being sent to you as a pdf document. Please enter your password " + DocPassword + ", to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", lstMailAttachment, oMailConfig);
           // Communication.SendMail("admin@attunelive.com", "nallathambhi.n@attunelive.com", "", "", "Invoice", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + "Venkat" + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + "ATTUNE" + "<br/>" + "Guindy, Chennai" + "</strong></div></div>", OrgName, lstMailAttachment);

            }
            ////else
            ////{
            //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed. Please enable notification settings.');", true);
            ////}
        }
        catch (Exception ex)
        {
            //ErrorDisplay1.ShowError = true;
           // ErrorDisplay1.Status = "Unable to send mail";
            CLogger.LogError("Error while Sending Mail", ex);
        }
        finally
        {
            if (sourceStream != null)
                sourceStream.Dispose();
            if (targetStream != null)
                targetStream.Dispose();
        }
    }

    public string GetConfigValues(string strConfigKey, int OrgID)
    {
    string strConfigValue = string.Empty;
    try
    {
    long returncode = -1;
    GateWay objGateway = new GateWay(base.ContextInfo);
    List<Config> lstConfig = new List<Config>();
    returncode = objGateway.GetConfigDetails(strConfigKey, OrgID, out lstConfig);
    if (lstConfig.Count >= 0)
    strConfigValue = lstConfig[0].ConfigValue;
    else
    CLogger.LogWarning("InValid " + strConfigKey);
    }
    catch (Exception ex)
    {
    CLogger.LogError("Error While Loading" + strConfigKey, ex);
    }
    return strConfigValue;
    }
    #region SendInvoiceEMail
    //protected void SendInvoiceEMail()
    //{
    //    string deviceInfo = null;
    //    string format = "PDF";
    //    Byte[] results;
    //    string encoding = String.Empty;
    //    string mimeType = String.Empty;
    //    string extension = String.Empty;
    //    string[] streamIDs = null;
    //    Microsoft.Reporting.WebForms.Warning[] warnings = null;
    //    MemoryStream sourceStream = null;
    //    MemoryStream targetStream = null;
    //    try
    //    {
    //        targetStream = new MemoryStream();
    //        List<CommunicationDetails> lstCommunicationDetails = new List<CommunicationDetails>();
    //        GateWay gateWay = new GateWay();
    //        //returnCode = gateWay.GetCommunicationDetails(CommunicationType.EMail, pVisitID, LocationName, out lstCommunicationDetails);
    //        //if (lstCommunicationDetails.Count > 0 && lstCommunicationDetails[0].IsNotify && !String.IsNullOrEmpty(lstCommunicationDetails[0].To))
    //        //{
    //            results = rReportViewer.ServerReport.Render(format, deviceInfo, out mimeType, out encoding, out extension, out streamIDs, out warnings);
    //            sourceStream = new MemoryStream(results);
    //            PdfSharp.Pdf.PdfDocument document = PdfSharp.Pdf.IO.PdfReader.Open(sourceStream);
    //            PdfSecuritySettings securitySettings = document.SecuritySettings;
    //            securitySettings.UserPassword = "123";//lstCommunicationDetails[0].DocPassword;
    //            securitySettings.OwnerPassword = "123";//lstCommunicationDetails[0].DocPassword;
    //            securitySettings.PermitAccessibilityExtractContent = false;
    //            securitySettings.PermitAnnotations = false;
    //            securitySettings.PermitAssembleDocument = false;
    //            securitySettings.PermitExtractContent = false;
    //            securitySettings.PermitFormsFill = false;
    //            securitySettings.PermitFullQualityPrint = true;
    //            securitySettings.PermitModifyDocument = false;
    //            securitySettings.PermitPrint = true;
    //            document.Save(targetStream, false);

    //            List<MailAttachment> lstMailAttachment = new List<MailAttachment>();
    //            MailAttachment objMailAttachment = new MailAttachment();
    //            objMailAttachment.ContentStream = targetStream;
    //            objMailAttachment.FileName = "Report_" + String.Format("{0:ddMMMyyyy}", Convert.ToDateTime(new BasePage().OrgDateTimeZone)) + ".pdf";
    //            lstMailAttachment.Add(objMailAttachment);

    //            //Communication.SendMail(String.IsNullOrEmpty(lstCommunicationDetails[0].From) ? "admin@attunelive.com" : lstCommunicationDetails[0].From, "nallathambhi.n@attunelive.com", lstCommunicationDetails[0].CC, lstCommunicationDetails[0].BCC, "Investigation Report", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + lstCommunicationDetails[0].PatientName + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + lstCommunicationDetails[0].OrgName + "<br/>" + lstCommunicationDetails[0].OrgAddress + "</strong></div></div>", OrgName, lstMailAttachment);
    //            Communication.SendMail("admin@attunelive.com", "premanand.m@attunelive.com", "", "", "Invoice", "<div style='font-family:Verdana;font-size:12;'><p>Dear " + "Venkat" + ",</p><p>Your investigation e-report is now being sent to you as a pdf document. Please enter your patient number as password, to view your report.</p><div><br><br>Sincerely,<br><strong><br>" + "ATTUNE" + "<br/>" + "Guindy, Chennai" + "</strong></div></div>", OrgName, lstMailAttachment);

    //        //}
    //        ////else
    //        ////{
    //        //    ScriptManager.RegisterStartupScript(Page, this.GetType(), "tAlert", "javascript:alert('This action cannot be performed. Please enable notification settings.');", true);
    //        ////}
    //    }
    //    catch (Exception ex)
    //    {
    //        ErrorDisplay1.ShowError = true;
    //        ErrorDisplay1.Status = "Unable to send mail";
    //        CLogger.LogError("Error while Sending Mail", ex);
    //    }
    //    finally
    //    {
    //        if (sourceStream != null)
    //            sourceStream.Dispose();
    //        if (targetStream != null)
    //            targetStream.Dispose();
    //    }
    //}
    #endregion


    protected void btnGenerateTask_Click(object sender, EventArgs e)
    {
        string reportPath = string.Empty;
        decimal GrsAmt, Netamt;
        string Discount = string.Empty;
        long returnCode = -1;
        long CreateBy = 0;
        string Tax = string.Empty;      
        decimal TOD;
        decimal VolumeDiscountAmt;
        long FinalBillID = 0;
        long InvocID = 0;      
        string Aprover = string.Empty;       
        string Status = string.Empty;
        long discoutResCode = 0;      
        long Approverid = RoleID;
        string DiscountRes = string.Empty;
        PageContextDetails.ButtonName = ((Button)sender).ID;
        PageContextDetails.ButtonValue = ((Button)sender).Text;
        PageContextDetails.PageID = PageID;

        int flag = 1;

        if (Request.QueryString["CID"] != null)
        {
            Int64.TryParse(Request.QueryString["CID"], out ClientID);
        }
        if (Request.QueryString["CCode"] != null)
        {
            ClientCode = Request.QueryString["CCode"];
        }
        if (Request.QueryString["TDate"] != null)
        {
            todate = (Request.QueryString["TDate"]);
        }
        if (todate == "01/01/0001")
        {
            todate = "01/01/1900";

        }
        if (Request.QueryString["FDate"] != null)
        {
            fdate = (Request.QueryString["FDate"]);
        }
        if (Request.QueryString["SID"] != null)
        {
            Int64.TryParse(Request.QueryString["SID"], out ScID);
        }
        if (Request.QueryString["CName"] != null)
        {
            CName = (Request.QueryString["CName"]);
        }
        if (Request.QueryString["RejBill"] != null)
        {
            Int32.TryParse(Request.QueryString["RejBill"], out Rejbills);
        }
        string TStatus = string.Empty;
        TStatus = "Pending";

        if (hdnStatus.Value == "1")
        {
            Status = "Pending";
            
        }
        else
        {
           Status = "Completed";
           
            
        }

         int DisPer =0;
        int DiscountID=0;
        decimal DiscountAmt=0;

        List<Invoice> lstInvoices = new List<Invoice>();
        Invoice InvoiceItems = new Invoice();
        GrsAmt = Convert.ToDecimal(txtGross.Text);

        if (!String.IsNullOrEmpty(ddDiscountPercent.SelectedValue) && ddDiscountPercent.SelectedValue !="0" )
        {
            DiscountID = Convert.ToInt32(ddDiscountPercent.SelectedValue.ToString());
        }
        if(!String.IsNullOrEmpty(hdnDisPer.Value) && hdnDisPer.Value !="0")
        {
             DisPer = Convert.ToInt32(hdnDisPer.Value);
        }

        if (!String.IsNullOrEmpty(txtDiscountAmt.Text) && (txtDiscountAmt.Text !="0.00"))
        {
            DiscountAmt = Convert.ToDecimal(txtDiscountAmt.Text);
        }

        if (DiscountID != 0 && DisPer != 0 && DiscountAmt != 0)
        {
            Discount = DiscountID + "~" + DisPer + "~" + DiscountAmt + "~";
        }

        CreateBy = LID;  
       
        Netamt = Convert.ToDecimal(txtNetAmt.Text);
        Tax = CreateClientXML();  
        TOD = Convert.ToDecimal(txtTOD.Text);
        VolumeDiscountAmt = Convert.ToDecimal(txtVolumeAmount.Text);
        discoutResCode = Convert.ToInt64(hdnDisResCode.Value);

        if (!String.IsNullOrEmpty(txtDisCountReason.Text) && txtDisCountReason.Text.Length > 0)
        {

            int DiscountResID = Convert.ToInt32(DdlDiscountreason.SelectedValue.ToString());
            string DReason = txtDisCountReason.Text;
            DiscountRes = DiscountResID + "~" + DReason + "~";

        }
        string UDTStatus = string.Empty;
        UDTStatus = "INPROGRESS";
        foreach (GridViewRow grd in grdInvoiceBill.Rows)
        {
           
            string drpReason = string.Empty;
            UDTStatus = "INPROGRESS";
            CheckBox chkbox = (CheckBox)grd.FindControl("chkInvoiceItem");
            DropDownList Reason = (DropDownList)grd.FindControl("ddlReason");
            if (chkbox.Checked == false)
            {
                UDTStatus = "Rejected";
                drpReason = Reason.SelectedItem.Text;
            }
            else
            {
                UDTStatus = "INPROGRESS";

            }
            //flag = 1;
            Label lblFinalBillID = (Label)grd.FindControl("lblFinalBillID");
            Label lblPT = (Label)grd.FindControl("lblPT");
            string PayType = lblPT.Text;

            if (PayType == "Bill")
            {
                FinalBillID = Convert.ToInt64(lblFinalBillID.Text);
                InvoiceItems.FinalBillID = Convert.ToInt64(FinalBillID);
                InvoiceItems.RefType = "GB";
                InvoiceItems.RefID = 0;
            }
            else
            {
                InvoiceItems.RefID = Convert.ToInt64(lblFinalBillID.Text);
                InvoiceItems.RefType = "AC";
            }
            InvoiceItems.Status = UDTStatus;
            InvoiceItems.Reason = drpReason;

            InvoiceItems.ClientID = Convert.ToInt64(ClientID);
            lstInvoices.Add(InvoiceItems);
            InvoiceItems = new Invoice();

        }


        string InvoiceType = "Orginal";
       
        if (flag > 0)
        {
            returnCode = bill.SaveInvoiceBill(GrsAmt, Discount, DiscountRes, Netamt, CreateBy, Tax, ClientID, OrgID, ILocationID, FinalBillID, lstInvoices, Convert.ToDateTime(fdate), Convert.ToDateTime(todate), TOD, ScID, Status, PageContextDetails, Approverid, InvocID, TStatus, VolumeDiscountAmt, out InvoiceID, InvoiceType);

        }      

        CreateTasks(InvoiceID, ClientID, ClientCode, CName, fdate, todate, ScID, Rejbills);
    }

    public void CreateTasks(long InvoiceID, long ClientID, string ClientCode, string CName, string fdate, string todate, long ScID, long Rejbills)
    {

        try
        {

        long returncode = -1;
        Tasks task = new Tasks();
        Hashtable dText = new Hashtable();
        Hashtable urlVal = new Hashtable(); 
        long createTaskID = -1;
        List<PatientVisitDetails> lstPatientVisitDetails = new List<PatientVisitDetails>();
        returncode = Utilities.GetInvoiceHashTable(Convert.ToInt64(TaskHelper.TaskAction.GenerateInvoice), InvoiceID, ClientID, ClientCode, CName, fdate, todate, ScID, Rejbills, out dText, out urlVal);
        task.TaskActionID = Convert.ToInt32(TaskHelper.TaskAction.GenerateInvoice);
        task.DispTextFiller = dText;
        task.URLFiller = urlVal;
        task.RoleID = RoleID;
        task.OrgID = OrgID;
        task.PatientID = InvoiceID;
        task.PatientVisitID = InvoiceID;
        task.TaskStatusID = (int)TaskHelper.TaskStatus.InProgress;
        task.CreatedBy = LID;
        task.RefernceID = "";
        task.LocationID = ILocationID;
        //Create task               
        returncode = new Tasks_BL(base.ContextInfo).CreateTask(task, out createTaskID);
        returncode = new Tasks_BL(base.ContextInfo).UpdateTask(createTaskID, TaskHelper.TaskStatus.InProgress, LID);

        ModalPopupExtender2.Show();
        }
       catch (Exception ex)
        {
            CLogger.LogError("Error in load CreateTask Details", ex);
        }
        
       

    }

    protected void btnpopClose_Click(object sender, EventArgs e)
    {

        RedirectPage();
    }

        public void  RedirectPage()
        {

        try
        {
            long returncode = -1;
            List<Role> lstUserRole = new List<Role>();
            string path = string.Empty;
            Role role = new Role();
            role.RoleID = RoleID;
            lstUserRole.Add(role);
            returncode = new Navigation().GetLandingPage(lstUserRole, out path);
            Response.Redirect(Request.ApplicationPath  + path, true);
        }
        catch (System.Threading.ThreadAbortException tae)
        {
            string thread = tae.ToString();
        }

        }

        //----------------------------------------------Random Password---------------------------------------//


        public class RandomPassword
        {
            private static int DEFAULT_MIN_PASSWORD_LENGTH = 6;
            private static int DEFAULT_MAX_PASSWORD_LENGTH = 8;
            private static string PASSWORD_CHARS_LCASE = "abcdefgijkmnopqrstwxyz";
            private static string PASSWORD_CHARS_UCASE = "ABCDEFGHJKLMNPQRSTWXYZ";
            private static string PASSWORD_CHARS_NUMERIC = "1234567890";
            private static string PASSWORD_CHARS_SPECIAL = "*$@#!%/";

            public static string Generate()
            {
                return Generate(DEFAULT_MIN_PASSWORD_LENGTH,
                                DEFAULT_MAX_PASSWORD_LENGTH);
            }

            public static string Generate(int length)
            {
                return Generate(length, length);
            }

            public static string Generate(int minLength,
                                          int maxLength)
            {

                if (minLength <= 0 || maxLength <= 0 || minLength > maxLength)
                    return null;

          
                char[][] charGroups = new char[][] 
        {
            PASSWORD_CHARS_LCASE.ToCharArray(),
            PASSWORD_CHARS_UCASE.ToCharArray(),
            PASSWORD_CHARS_NUMERIC.ToCharArray(),
            PASSWORD_CHARS_SPECIAL.ToCharArray()
        };

             
                int[] charsLeftInGroup = new int[charGroups.Length];

        
                for (int i = 0; i < charsLeftInGroup.Length; i++)
                    charsLeftInGroup[i] = charGroups[i].Length;

           
                int[] leftGroupsOrder = new int[charGroups.Length];

     
                for (int i = 0; i < leftGroupsOrder.Length; i++)
                    leftGroupsOrder[i] = i;

                byte[] randomBytes = new byte[4];

          
                RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider();
                rng.GetBytes(randomBytes);

            
                int seed = (randomBytes[0] & 0x7f) << 24 |
                            randomBytes[1] << 16 |
                            randomBytes[2] << 8 |
                            randomBytes[3];

         
                Random random = new Random(seed);

         
                char[] password = null;

              
                if (minLength < maxLength)
                    password = new char[random.Next(minLength, maxLength + 1)];
                else
                    password = new char[minLength];

         
                int nextCharIdx;

     
                int nextGroupIdx;

          
                int nextLeftGroupsOrderIdx;

                int lastCharIdx;

               
                int lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;

              
                for (int i = 0; i < password.Length; i++)
                {
            
                    if (lastLeftGroupsOrderIdx == 0)
                        nextLeftGroupsOrderIdx = 0;
                    else
                        nextLeftGroupsOrderIdx = random.Next(0,
                                                             lastLeftGroupsOrderIdx);

               
                    nextGroupIdx = leftGroupsOrder[nextLeftGroupsOrderIdx];

               
                    lastCharIdx = charsLeftInGroup[nextGroupIdx] - 1;

            
                    if (lastCharIdx == 0)
                        nextCharIdx = 0;
                    else
                        nextCharIdx = random.Next(0, lastCharIdx + 1);

             
                    password[i] = charGroups[nextGroupIdx][nextCharIdx];

              
                    if (lastCharIdx == 0)
                        charsLeftInGroup[nextGroupIdx] =
                                                  charGroups[nextGroupIdx].Length;
               
                    else
                    {
                    
                        if (lastCharIdx != nextCharIdx)
                        {
                            char temp = charGroups[nextGroupIdx][lastCharIdx];
                            charGroups[nextGroupIdx][lastCharIdx] =
                                        charGroups[nextGroupIdx][nextCharIdx];
                            charGroups[nextGroupIdx][nextCharIdx] = temp;
                        }
                 
                        charsLeftInGroup[nextGroupIdx]--;
                    }

                  
                    if (lastLeftGroupsOrderIdx == 0)
                        lastLeftGroupsOrderIdx = leftGroupsOrder.Length - 1;
                  
                    else
                    {
                        
                        if (lastLeftGroupsOrderIdx != nextLeftGroupsOrderIdx)
                        {
                            int temp = leftGroupsOrder[lastLeftGroupsOrderIdx];
                            leftGroupsOrder[lastLeftGroupsOrderIdx] =
                                        leftGroupsOrder[nextLeftGroupsOrderIdx];
                            leftGroupsOrder[nextLeftGroupsOrderIdx] = temp;
                        }
                      
                        lastLeftGroupsOrderIdx--;
                    }
                }

             
                return new string(password);
            }
        }

        

        //-----------------------------------------------------------------------------------------------------//


        protected void GrdVolumebased_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                total += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "TotalDiscounts"));
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                Label lblamount = (Label)e.Row.FindControl("lblTotal");
                lblamount.Text = total.ToString();
                hdnTovamout.Value = total.ToString();
            }
        }
        protected void GrdCreditDebit_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CreditDebitSummary inv = (CreditDebitSummary)e.Row.DataItem;
                if (inv.ItemType == "Debit")
                {
                    GrsAmt = GrsAmt + inv.Amount;
                    hdnGrsAmt.Value = GrsAmt.ToString();
                }
                else if (inv.ItemType == "Credit")
                {
                    DebitAmt = DebitAmt + inv.Amount;
                    hdnDebitAmt.Value = DebitAmt.ToString();
                }
            }

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alt1", "javascript:CalCulateAmtvalue();", true);
        }
        public void LoadMetaData()
        {
            try
            {
                long returncode = -1;
                string domains = "InvoiceType";
                string[] Tempdata = domains.Split(',');

                List<MetaData> lstmetadataInput = new List<MetaData>();
                List<MetaData> lstmetadataOutput = new List<MetaData>();
                string LangCode = "en-GB";
                MetaData objMeta;

                for (int i = 0; i < Tempdata.Length; i++)
                {
                    objMeta = new MetaData();
                    objMeta.Domain = Tempdata[i];
                    lstmetadataInput.Add(objMeta);

                }

                // returncode = new MetaData_BL(base.ContextInfo).LoadMetaData_New(lstmetadataInput, LangCode, out lstmetadataOutput);
                returncode = new MetaData_BL(base.ContextInfo).LoadMetaDataOrgMapping(lstmetadataInput, OrgID, LangCode, out lstmetadataOutput);

                if (lstmetadataOutput.Count > 0)
                {
                    var childItems = from child in lstmetadataOutput
                                     where child.Domain == "InvoiceType"
                                     select child;

                    ddlInvoiceType.DataSource = childItems;
                    ddlInvoiceType.DataTextField = "DisplayText";
                    ddlInvoiceType.DataValueField = "Code";
                    ddlInvoiceType.DataBind();
                    ddlInvoiceType.Items.Insert(0, strSelect);

                }



            }
            catch (Exception ex)
            {
                CLogger.LogError("Error while loading Meta Data like Date,Gender ,Marital Status ", ex);
                //edisp.Visible = true;
                //ErrorDisplay1.ShowError = true;
               // ErrorDisplay1.Status = "There was a problem in page load. Please contact system administrator";
            }
        }
}
    class MyReportServerCredent : IReportServerCredentials
    {
    string CredentialuserName = System.Configuration.ConfigurationManager.AppSettings["ReportUserName"];
    string CredentialpassWord = System.Configuration.ConfigurationManager.AppSettings["ReportPassword"];

    public MyReportServerCredent()
    {
    }

    public System.Security.Principal.WindowsIdentity ImpersonationUser
    {
    get
    {
    return null;  // Use default identity.
    }
    }

    public System.Net.ICredentials NetworkCredentials
    {
    get
    {
    return new System.Net.NetworkCredential(CredentialuserName, CredentialpassWord);
    }
    }

    public bool GetFormsCredentials(out System.Net.Cookie authCookie,
    out string user, out string password, out string authority)
    {
    authCookie = null;
    user = password = authority = null;
    return false;  // Not use forms credentials to authenticate.
    }



   



    }

