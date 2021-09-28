using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Attune.Kernel.BusinessEntities;
using System.Collections;
using System.Text;
using System.IO;
using Attune.Kernel.PlatForm.Base;
using Attune.Kernel.InventoryCommon.BL;
using Attune.Kernel.PlatForm.BL;
using Attune.Kernel.PlatForm.Utility;
using Attune.Kernel.PerformingNextAction;
using System.Xml;
using System.Xml.Xsl;

public partial class Inventory_ViewIssuedIndentdetails : Attune_BasePage
{
    public Inventory_ViewIssuedIndentdetails()
        : base("StockIntend_ViewIssuedIndentdetails_aspx")
    {
    }
    protected void page_Init(object sender, EventArgs e)
    {
        base.page_Init(sender, e);
    }
    InventoryCommon_BL inventoryBL;
    Locations objLocation = new Locations();
    IntendDetail objIntendDetail = new IntendDetail();
    List<Locations> lstLocation = new List<Locations>();
    List<Intend> lstIntend = new List<Intend>();
    List<InventoryItemsBasket> lstInventoryItemsBasket;
    List<InventoryItemsBasket> lstIntendDetail = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstIntendKitDetail = new List<InventoryItemsBasket>();
    List<InventoryItemsBasket> lstPrintCount = new List<InventoryItemsBasket>();
    List<Users> lstcUsers = new List<Users>();
    List<Users> lstUsers = new List<Users>();
    string Status = string.Empty;
    string IndentType = string.Empty;
    string SearchType = string.Empty;
    List<Organization> lstOrganization = new List<Organization>();
    List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
    string packingConfig = "N";
    string S = string.Empty;
    string pages = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        inventoryBL = new InventoryCommon_BL(base.ContextInfo);
        if (!IsPostBack)
        {

            HideOrShowUsageCount();
            string displayToolTip = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_06;
            displayToolTip = displayToolTip == null ? "StockIssue ReceivedNo :" : displayToolTip;
            if (Request.QueryString["IsTransfer"] != null)
            {
                LabelIndentReceivedNo.Text = displayToolTip;
            }
            if (Request.QueryString["Status"] != null && Request.QueryString["Status"] == "Approved")
            {
                btnExportExcel.Style.Add("display", "none");
            }
            else
            {
                btnExportExcel.Style.Add("display", "inline-block");
            }
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Required_Indent_Packing_Slip_Barcode", OrgID, ILocationID, out lstInventoryConfig);
            if (lstInventoryConfig.Count > 0)
            {
                packingConfig = lstInventoryConfig[0].ConfigValue.ToUpper();
            }


            if (packingConfig == "Y")
            {
                if (Request.QueryString["intID"] != null && Request.QueryString["ID"] != null)
                {
                    if (Request.QueryString["Status"] != null)
                    {
                        Status = Request.QueryString["Status"];
                    }
                    // E:\testweb\Development\Solution\WebApp\Inventory\ViewPackingSlipDetails.aspx
                    Response.Redirect("~/Inventory/ViewPackingSlipDetails.aspx?ID=" + Request.QueryString["ID"] + "&intID=" + Request.QueryString["intID"] + "&Appr=Y&Status=" + Status);

                    // btnCancelIntend.Visible = true;
                }
            }
            else
            {
                if (Request.QueryString["intID"] != null && Request.QueryString["ID"] != null)
                {
                    Status = Request.QueryString["Status"];
                    IndentType = Request.QueryString["IndentType"];
                    SearchType = Request.QueryString["SearchType"];

                    //XSLT Start
                    string bill_print = string.Empty;
                    bill_print = "ViewIssueIndentDetails-" + base.LanguageCode;
                    List<XSLBillFormat> lstXSLBillFormat = new List<XSLBillFormat>();

                    new Master_BL(ContextInfo).GetXSLBillFormat(OrgID, bill_print, out lstXSLBillFormat);
                    if (lstXSLBillFormat != null)
                    {
                        if (lstXSLBillFormat.Count > 0)
                        {
                            divProjection.Attributes.Add("class", "hide");
                            hdnXsltPrint.Value = "Y";
                            XslTransform xsl = new XslTransform();
                            XmlDocument xml = new XmlDocument();
                            //xml.LoadXml(sw.ToString());
                            xml = LoadXslt(Convert.ToInt64(Request.QueryString["intID"]), Convert.ToInt64(Request.QueryString["ID"]), Status);
                            //string s = Server.MapPath("..\\xsl\\WHC-ViewIssueIndentDetails-en-GB.xsl");
                            //xsl.Load(s);

                            using (var stringReader = new StringReader(lstXSLBillFormat[0].Body.Trim()))
                            {
                                using (var xslt = XmlReader.Create(stringReader))
                                {
                                    xsl.Load(xslt);
                                }
                            }
                            xmlIndentView.Document = xml;
                            xmlIndentView.Transform = xsl;
                        }
                    }
                    //END
                    else
                    {
                        LoadIntendDetailGrid(Convert.ToInt64(Request.QueryString["intID"]), Convert.ToInt64(Request.QueryString["ID"]), Status);
                    }
                }
            }
            BindHeaderDetails();

            string rval = GetConfigValue("VIEW_DL_NO", OrgID);
            if (!string.IsNullOrEmpty(rval))
            {
                if (rval == "Y")
                {
                    trTransferorNo.Attributes.Add("class", "displaytr");
                    trDLNo.Attributes.Add("class", "displaytr");
                    // trRaiseFrom.Style.Add("display", "none");
                    trRaiseComment.Attributes.Add("class", "hide");
                    trRaiseBy.Attributes.Add("class", "hide");
                }
                else
                {
                    trTransferorNo.Attributes.Add("class", "hide");
                    trDLNo.Attributes.Add("class", "hide");
                    // trRaiseFrom.Style.Add("display", "table-row");
                    trRaiseComment.Attributes.Add("class", "displaytr");
                    trRaiseBy.Attributes.Add("class", "hide");
                }
            }
            else
            {
                trTransferorNo.Attributes.Add("class", "hide");
                trDLNo.Attributes.Add("class", "hide");
                // trRaiseFrom.Style.Add("display", "table-row");
                trRaiseComment.Attributes.Add("class", "displaytr");
                trRaiseBy.Attributes.Add("class", "displaytr");
            }

        }

    }


    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/StockIntend/Intend.aspx");
    }
    private void Notification()
    {

        pages = Request.UrlReferrer.ToString();

        string fileName = System.IO.Path.GetFileName(pages);
        if (fileName.Contains("IssueStock.aspx"))
        {

            string displayTip = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_07;
            PageContextDetails.ButtonName = "btnSubmit";
            PageContextDetails.ButtonValue = displayTip;
        }

        var mailbuilder = new StringBuilder();
        divProjection.RenderControl(new HtmlTextWriter(new StringWriter(mailbuilder)));

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
        PageContextDetails.ReceiptNo = "";
        PageContextDetails.MessageTemplate = mailContent.ToString();
        PageContextDetails.IndentNo = Convert.ToInt64(Request.QueryString["intID"]);
        long returnCode = am.PerformingNextStepNotification(PageContextDetails, "", "");
        #endregion

    }


    string strDate = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_10 == null ? "Date" : Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_10;
    private void LoadIntendDetailGrid(long pIntendID, long pIntendReceivedID, string Status)
    {
        try
        {
            //objIntendDetail.IntendID = 2;
            objIntendDetail.OrgID = OrgID;
            objIntendDetail.OrgAddressID = ILocationID;
            //objIntendDetail.LocationID = InventoryLocationID;
            inventoryBL.GetReceivedIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, Status, pIntendReceivedID, out lstIntendDetail, out lstIntend, out lstOrganization, out lstIntendKitDetail, out lstPrintCount);

            lblOrgName.Text = OrgName;

            if (lstIntend!=null && lstIntend.Count > 0)
            {
                new GateWay(this.ContextInfo).GetUserDetail(lstIntend[0].CreatedBy, out lstcUsers);

                string displayTool = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_01;
                displayTool = displayTool == null ? "Sub-Store StockReturnNo :" : displayTool;
                string displayRaise = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_02;
                displayRaise = displayRaise == null ? "Returned By :" : displayRaise;

                string displayRaiseFrom = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_03;
                displayRaiseFrom = displayRaiseFrom == null ? "Raise From :" : displayRaiseFrom;

                string displayRaiseTo = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_04;
                displayRaiseTo = displayRaiseTo == null ? "Raised To" : displayRaiseTo;

                if (lstIntend[0].IntendNo.StartsWith("S") == true)
                {
                    LabelIndentNo.Text = displayTool;
                    LabelIndentRaiseBy.Text = displayRaise;
                    LabelIndentRaisedFrom.Text = displayRaiseFrom;
                    LabelIndentFrom.Text = displayRaiseTo;
                }
                string displayToolNo = Resources.StockIntend_ClientDisplay.StockIntend_ViewIssuedIndentdetails_aspx_05;
                displayToolNo = displayToolNo == null ? "NO." : displayToolNo;
                if (Request.QueryString["IsTransfer"] != null)
                {
                    LabelIndentNo.Text = displayToolNo;
                }


                lblIntendNo.Text = lstIntend[0].IntendNo;
                if (lstIntendDetail.Count > 0)
                {
                    if (!string.IsNullOrEmpty(lstIntendDetail[0].Name))
                    {
                        lblRaiseBy.Text = lstcUsers[0].Name + " (" + lstIntendDetail[0].Name + ")";
                    }
                    else
                    {
                        lblRaiseBy.Text = lstcUsers[0].Name;
                    }
                }
                else
                {
                    lblRaiseBy.Text = lstcUsers[0].Name;
                }
                lblDate.Text = lstIntend[0].IntendDate.ToExternalDateTime();//("dd MMMM yy");

                var Transferor = lstIntend[0].LocName.Split('|');
                if (Transferor.Length > 1)
                {
                    if (Transferor[1] == "0")
                    {
                        Label3.Attributes.Add("class", "hide");
                        lblTransferorTinNo.Attributes.Add("class", "hide");
                    }
                    else { lblTransferorTinNo.Text = Transferor[1]; }
                }
                if (Transferor.Length > 2)
                {
                    if (Transferor[2] == "0")
                    {
                        Label7.Attributes.Add("class", "hide");
                        lblTransferorDLNO.Attributes.Add("class", "hide");
                    }
                    else { lblTransferorDLNO.Text = Transferor[2]; }
                }
                if (Transferor.Length > 0)
                {
                    lblIndentRaiseTo.Text = Transferor[0];
                }

                var Transferree = lstIntend[0].ToLocName.Split('|');
                if (Transferree.Length > 1)
                {
                    if (Transferree[1] == "0")
                    {
                        Label1.Attributes.Add("class", "hide");
                        lblTransferreeTinNo.Attributes.Add("class", "hide");
                    }
                    else { lblTransferreeTinNo.Text = Transferree[1]; }
                }
                if (Transferree.Length > 2)
                {
                    if (Transferree[2] == "0")
                    {
                        Label5.Attributes.Add("class", "hide");
                        lblTransferreeDLNO.Attributes.Add("class", "hide");
                    }
                    else { lblTransferreeDLNO.Text = Transferree[2]; }
                }
                if (Transferree.Length > 0)
                {
                    lblIndentFrom.Text = Transferree[0];
                }

                lblComments.Text = lstIntend[0].Comments;
                if(isCorporateOrg=="Y" && Status!="Received")
                    LabelIndentReceivedNo.Attributes.Add("class", "hide");
                else   
                   lblIndentReceivedNo.Text = lstIntend[0].IndentReceivedNo;
           
                new GateWay(this.ContextInfo).GetUserDetail(lstIntend[0].ApprovedBy, out lstUsers);

                if (lstUsers != null && lstUsers.Count > 0)
                {
                    if (lstIntend[0].ApprovedAt.ToShortDateString() != "01/01/0001")
                    {
                        tdApproved.Visible = true;

                        approvedDateTD.InnerText = lstIntend[0].ApprovedAt.ToExternalDateTime();
                        approvedByTD.InnerHtml = lstUsers[0].Name;
                    }
                }
                else
                {
                    tdApproved.Visible = false;
                    approvedDateTD.InnerText = "--";
                    approvedByTD.InnerHtml = "--";
                }

                lblStatus.Text = lstIntend[0].Status;
                
                lblissueddatetitle.Text = lblStatus.Text + " " + strDate;
                lblIssuedDate.Text = lstIntend[0].IntendIssuedDate.ToExternalDateTime();
            }


            GridViewDetails.DataSource = lstIntendDetail.Where(ID => ID.Status != "Cancel");
            GridViewDetails.DataBind();


            if (hdnEnablePackSize.Value == "Y")
            {
                GridViewDetails.Columns[5].Visible = true;
                GridViewDetails.Columns[7].Visible = true;
               // GridViewDetails.Columns[9].Visible = true;
                GridViewDetails.Columns[11].Visible = true;
            }
            else
            {
                GridViewDetails.Columns[5].Visible = false;
                GridViewDetails.Columns[7].Visible = false;
               // GridViewDetails.Columns[9].Visible = false;
                GridViewDetails.Columns[11].Visible = false;
            }
            List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
            new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("Need_Return_Stock_From_Receive_Indent", OrgID, ILocationID, out lstInventoryConfig);
            string PreviousRecQuantity = lstInventoryConfig.Count > 0 ? lstInventoryConfig[0].ConfigValue : "N";
            if (PreviousRecQuantity == "Y")
			{
			GridViewDetails.Columns[10].Visible = true;
			 }
		   
		    if (lstIntend[0].Status == "Received")
            {
                GridViewDetails.Columns[11].Visible = true;
                GridViewDetails.Columns[13].Visible = true;
                lbltotalText.Style.Add("display","inline-block");
                lblTotalAmount.Style.Add("display", "inline-block");
                
            }
            else
            {
                GridViewDetails.Columns[11].Visible = false;
                GridViewDetails.Columns[13].Visible = false;
                lbltotalText.Attributes.Add("class", "hide");
                lblTotalAmount.Attributes.Add("class", "hide");
                
            }
        }
        catch (Exception Ex)
        {
            CLogger.LogError("Error while Loading Location - IntendViewDetail.aspx", Ex);
        }

    }
    public XmlDocument LoadXslt(long pIntendID, long pIntendReceivedID, string Status)
    {
        #region Start
        objIntendDetail.OrgID = OrgID;
        objIntendDetail.OrgAddressID = ILocationID;
        //objIntendDetail.LocationID = InventoryLocationID;
        inventoryBL.GetReceivedIntendDetail(pIntendID, 0, objIntendDetail.OrgID, objIntendDetail.OrgAddressID, Status, pIntendReceivedID, out lstIntendDetail, out lstIntend, out lstOrganization, out lstIntendKitDetail, out lstPrintCount);
        XmlDocument xml = new XmlDocument();
        try
        {
            if (lstOrganization.Count > 0 && lstIntend.Count > 0)
            {
                using (var sw = new StringWriter())
                {
                    using (var xw = XmlWriter.Create(sw))
                    {
                        xw.WriteStartDocument();
                        xw.WriteStartElement("Indent");

                        xw.WriteStartElement("OrgName", "");
                        xw.WriteString(lstOrganization[0].Name != null && lstOrganization[0].Name != "" ? lstOrganization[0].Name : "-");
                        //xw.WriteString(lstOrganization[0].Name);
                        xw.WriteEndElement();

                        xw.WriteStartElement("Street", "");
                        xw.WriteString(lstOrganization[0].Address != null && lstOrganization[0].Address != "" ? lstOrganization[0].Address : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("City", "");
                        xw.WriteString(lstOrganization[0].City != null && lstOrganization[0].City != "" ? lstOrganization[0].City : "-");
                        xw.WriteEndElement();


                        xw.WriteStartElement("Phonenumber", "");
                        xw.WriteString(lstOrganization[0].PhoneNumber != null && lstOrganization[0].PhoneNumber != "" ? lstOrganization[0].PhoneNumber : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("IntendNo", "");
                        xw.WriteString(lstIntend[0].IntendNo != null && lstIntend[0].IntendNo != "" ? lstIntend[0].IntendNo : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("RaisedDate", "");
                        xw.WriteString(lstIntend[0].IntendDate != null ? lstIntend[0].IntendDate.ToExternalDateTime() : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("TransferorTinNo", "");
                        var TransferorTinNo = "";
                        var Transferor = lstIntend[0].LocName.Split('|');
                        if (Transferor.Length > 1)
                        {
                            TransferorTinNo = Transferor[1];
                        }
                        xw.WriteString(TransferorTinNo != null && TransferorTinNo != "" ? TransferorTinNo : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("Status", "");
                        xw.WriteString(lstIntend[0].Status != null && lstIntend[0].Status != "" ? lstIntend[0].Status : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("IndentRaiseTo", "");
                        var IndentRaiseTo = "";
                        if (Transferor.Length > 0)
                        {
                            IndentRaiseTo = Transferor[0];
                        }
                        xw.WriteString(IndentRaiseTo != null && IndentRaiseTo != "" ? IndentRaiseTo : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("IndentReceivedNo", "");
                        xw.WriteString(lstIntend[0].IndentReceivedNo != null && lstIntend[0].IndentReceivedNo != "" ? lstIntend[0].IndentReceivedNo : "-");
                        xw.WriteEndElement();

                        var Transferree = lstIntend[0].ToLocName.Split('|');
                        var IndentFrom = "";
                        xw.WriteStartElement("IndentFrom", "");
                        if (Transferree.Length > 0)
                        {
                            IndentFrom = Transferree[0];
                        }
                        xw.WriteString(IndentFrom != null && IndentFrom != "" ? IndentFrom : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("IssuedDate", "");
                        xw.WriteString(lstIntend[0].IntendIssuedDate != null ? lstIntend[0].IntendIssuedDate.ToExternalDateTime() : "-");
                        xw.WriteEndElement();

                        xw.WriteStartElement("Comments", "");
                        xw.WriteString(lstIntend[0].Comments != null && lstIntend[0].Comments != "" ? lstIntend[0].Comments : "-");
                        //xw.WriteString(lstIntend[0].Comments);
                        xw.WriteEndElement();
                        var QtyLsu = "";
                        var SellingUnit = "";
                        int Quantity = 0;
                        int StockReceived = 0;
                        int OrderedConvertUnit = 0;
                        var OrderedUnit = "";
                        var IssuedQuantity = "";
                        decimal SellingPrice = 0;
                        decimal TotalIssuedQtyAmount = 0;
                        decimal RECQuantity = 0;
                        decimal Total = 0;
                        decimal TotalReceivedAmount = 0;
                        decimal TotalIssuedAmount = 0;
                        for (int i = 0; i < lstIntendDetail.Count; i++)
                        {
                            xw.WriteStartElement("IndentDetails", "");
                            xw.WriteStartElement("ProductCode", "");
                            xw.WriteString(lstIntendDetail[i].ProductCode != null && lstIntendDetail[i].ProductCode != "" ? lstIntendDetail[i].ProductCode : "-");
                            //xw.WriteString(lstIntendDetail[i].ProductCode);
                            xw.WriteEndElement();

                            xw.WriteStartElement("ProductName", "");
                            xw.WriteString(lstIntendDetail[i].ProductName != null && lstIntendDetail[i].ProductName != "" ? lstIntendDetail[i].ProductName : "-");
                            xw.WriteEndElement();

                            xw.WriteStartElement("CategoryName", "");
                            xw.WriteString(lstIntendDetail[i].CategoryName != null && lstIntendDetail[i].CategoryName != "" ? lstIntendDetail[i].CategoryName : "-");
                            xw.WriteEndElement();

                            xw.WriteStartElement("BatchNo", "");
                            xw.WriteString(lstIntendDetail[i].BatchNo != null && lstIntendDetail[i].BatchNo != "" ? lstIntendDetail[i].BatchNo : "*");
                            xw.WriteEndElement();

                            xw.WriteStartElement("ExpiryDate", "");
                            xw.WriteString(lstIntendDetail[i].ExpiryDate != null && lstIntendDetail[i].ExpiryDate.ToString("yyyy") != "1753" && lstIntendDetail[i].ExpiryDate.ToString("yyyy") != "9999" ? lstIntendDetail[i].ExpiryDate.ToString("MMM-yy") : "-");
                            //xw.WriteString(lstIntendDetail[i].ExpiryDate.ToString("{0:MMM-yy}"));
                            xw.WriteEndElement();

                            xw.WriteStartElement("Quantity", "");
                            Quantity = lstIntendDetail[i].Quantity != null ? Convert.ToInt32(lstIntendDetail[i].Quantity) : 0;
                            SellingUnit = lstIntendDetail[i].SellingUnit != null ? lstIntendDetail[i].SellingUnit : "-";
                            if (SellingUnit != "")
                            {
                                QtyLsu = Quantity.ToString() + "(" + SellingUnit + ")";
                            }
                            else
                            {
                                QtyLsu = Quantity.ToString();
                            }
                            xw.WriteString(QtyLsu);
                            xw.WriteEndElement();

                            xw.WriteStartElement("IssuedQuantity", "");
                            //<%# (String.Format("{0}", Convert.ToInt32(Eval("StockReceived")) / Convert.ToInt32(Eval("OrderedConvertUnit")))) + " (" + Eval("OrderedUnit") + ")"%>
                            StockReceived = Convert.ToInt32(lstIntendDetail[i].StockReceived != null ? lstIntendDetail[i].StockReceived : 0);
                            OrderedConvertUnit = Convert.ToInt32(StockReceived) / Convert.ToInt32(lstIntendDetail[i].OrderedConvertUnit != null ? lstIntendDetail[i].OrderedConvertUnit : 0);
                            OrderedUnit = lstIntendDetail[i].SellingUnit != null ? lstIntendDetail[i].SellingUnit : "-";
                            IssuedQuantity = StockReceived.ToString() + "(" + OrderedUnit + ")";
                            xw.WriteString(IssuedQuantity);
                            xw.WriteEndElement();

                            xw.WriteStartElement("TotalIssuedQtyAmount", "");
                            //<%# (String.Format("{0:n}", Convert.ToDecimal(Eval("StockReceived")) * Convert.ToDecimal(Eval("SellingPrice"))))%>
                            SellingPrice = lstIntendDetail[i].SellingPrice != null ? lstIntendDetail[i].SellingPrice : 0;
                            TotalIssuedQtyAmount = Convert.ToDecimal(StockReceived) * SellingPrice;
                            xw.WriteString(TotalIssuedQtyAmount.ToString("0.00"));
                            xw.WriteEndElement();

                            xw.WriteStartElement("Total", "");
                            //<%# (String.Format("{0:n}", Convert.ToDecimal(Eval("RECQuantity")) * Convert.ToDecimal(Eval("SellingPrice"))))%>
                            RECQuantity = Convert.ToDecimal(lstIntendDetail[i].RECQuantity != null ? lstIntendDetail[i].RECQuantity : 0);
                            Total = RECQuantity * SellingPrice;
                            xw.WriteString(Total.ToString("0.00"));
                            xw.WriteEndElement();
                            xw.WriteEndElement();
                            TotalAmount = TotalAmount + TotalIssuedQtyAmount;
                            TotalIssuedAmount = TotalIssuedAmount + TotalIssuedQtyAmount;

                            TotalReceivedAmount = TotalReceivedAmount + (Convert.ToDecimal(lstIntendDetail[i].RECQuantity != null ? lstIntendDetail[i].RECQuantity : 0) * Convert.ToDecimal(lstIntendDetail[i].SellingPrice != null ? lstIntendDetail[i].SellingPrice : 0));
                        }

                        xw.WriteStartElement("TotalIssuedAmount", "");
                        xw.WriteString(TotalIssuedAmount.ToString("0.00"));
                        xw.WriteEndElement();

                        xw.WriteStartElement("TotalReceivedAmount", "");
                        xw.WriteString(TotalReceivedAmount.ToString("0.00"));
                        xw.WriteEndElement();

                        xw.WriteEndElement();

                        xw.WriteEndDocument();
                        xw.Close();

                        xml.LoadXml(sw.ToString());
                    }
                }
            }
        }

        catch (Exception ex)
        {
            CLogger.LogError("Error View Issue Indent XSLT Page", ex);
        }
        #endregion
        return xml;
    }
    decimal TotalAmount = 0;     
    decimal TotalIssuedAmount = 0;     
    List<long> lstProducts = new List<long>();
    protected void GridViewDetails_RowDataBound(Object sender, GridViewRowEventArgs e)
    {
        try
        {
            string st = string.Empty;

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                InventoryItemsBasket IOM = (InventoryItemsBasket)e.Row.DataItem;

                if (lstProducts.Exists(p => p.Equals(IOM.ProductID)))
                {
                    e.Row.Cells[5].Text = "--";
                }
                else
                {
                    lstProducts.Add(IOM.ProductID);
                    lblTotalQty.Text = String.Format("{0:0.00}", (IOM.Quantity + decimal.Parse(lblTotalQty.Text)));
                }

                lblUnitCostPrice.Text = String.Format("{0:0.00}", (IOM.TotalCost + decimal.Parse(lblUnitCostPrice.Text)));
                lblTSellingPrice.Text = String.Format("{0:0.00}", (IOM.TSellingPrice + decimal.Parse(lblTSellingPrice.Text)));
                lblTotalUnitSellingPrice.Text = String.Format("{0:0.00}", (IOM.SellingPrice + decimal.Parse(lblTotalUnitSellingPrice.Text)));

                HiddenField hdnStockReceived = (HiddenField)e.Row.FindControl("hdnStockReceived");
                HiddenField hdnSellingPrice = (HiddenField)e.Row.FindControl("hdnSellingPrice");
                HiddenField hdnStockPartRec = (HiddenField)e.Row.FindControl("hdnStockPartRec");

                if (lstIntendDetail[0].RECQuantity != null && lstIntendDetail[0].RECQuantity > 0)
                {
                    TotalAmount = TotalAmount + (Convert.ToDecimal(hdnStockPartRec.Value) * Convert.ToDecimal(hdnSellingPrice.Value));
                }
                TotalIssuedAmount = TotalIssuedAmount  + (Convert.ToDecimal(hdnStockReceived.Value) * Convert.ToDecimal(hdnSellingPrice.Value));
                lblDisplayIssuedAmount.Text = Math.Round(TotalIssuedAmount, 2).ToString();
                lblTotalAmount.Text = Math.Round(TotalAmount, 2).ToString();
               
            }

        }


        catch (Exception ex)
        {
            CLogger.LogError("Error While Loading GridViewDetails Details.", ex);

        }
    }

    protected void BindHeaderDetails()
    {

        List<Organization> lstOrganization = new List<Organization>();
        new Organization_BL(ContextInfo).getOrganizationAddress(OrgID, ILocationID, out  lstOrganization);
        if (lstOrganization.Count > 0)
        {
            lblOrgName.Text = lstOrganization[0].Name;
            lblstreet.Text = lstOrganization[0].Address;
            lblCity.Text = lstOrganization[0].City;
            lblPhonenumber.Text = lstOrganization[0].PhoneNumber;
        }

        List<Config> lstConfig = new List<Config>();
        int iBillGroupID = 0;
        iBillGroupID = (int)ReportType.OPBill;

        new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
        bool _flag = false;
        if (lstConfig.Count > 0)
        {
            imgBillLogo.ImageUrl = lstConfig[0].ConfigValue.Trim();
            if (!string.IsNullOrEmpty(lstConfig[0].ConfigValue.Trim()))
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

    protected string GetRowTotal(object Quantity, object CostPrice)
    {
        GetTotal(Quantity, CostPrice);
        decimal c = 0;
        try
        {
            c = ((decimal)Quantity * (decimal)CostPrice);
            lblTotalPrice.Text = String.Format("{0:0.00}", ((c) + decimal.Parse(lblTotalPrice.Text)));//To Print Row vise Total
            return c.ToString("0.00");
        }
        catch (Exception)
        {
            return "0.00";
        }
    }


    protected void GetTotal(object Quantity, object CostPrice)
    {
        decimal c = 0;
        try
        {
            c += ((decimal)Quantity * (decimal)CostPrice);
            lblTotal.Text = c.ToString("0.00");
        }
        catch (Exception)
        {
            lblTotal.Text = "0.00";
        }
    }
    public string GetConfigValue(string configKey, int orgID)
    {
        string configValue = string.Empty;
        long returncode = -1;
        Configuration_BL objGateway = new Configuration_BL(base.ContextInfo);
        List<Config> lstConfig = new List<Config>();

        returncode = objGateway.GetConfigDetails(configKey, orgID, out lstConfig);
        if (lstConfig!=null && lstConfig.Count > 0)
            configValue = lstConfig[0].ConfigValue;

        return configValue;
    }
    public override void VerifyRenderingInServerForm(Control control)
    {

    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        ExportToExcel();
    }


    public void ExportToExcel()
    {
        try
        {
            List<Config> lstConfig = new List<Config>();
            String imagepath = "";
            String HospitalName = "";
            int iBillGroupID = 0;
            iBillGroupID = (int)ReportType.IPBill;

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Logo", OrgID, ILocationID, out lstConfig);
            if (lstConfig.Count > 0)
            {
                //imagepath = "<img src='" + lstConfig[0].ConfigValue.Trim().Replace("..", System.Configuration.ConfigurationManager.AppSettings["ApplicationName"].ToString()) + "'/>";
                string test = "http://" + HttpContext.Current.Request.UrlReferrer.Authority + ResolveUrl(lstConfig[0].ConfigValue);
                //string base64String = AttuneUtilitieHelper.ToBase64(test);


                //imagepath = "<img src='data:image/png;base64," + base64String + "'/>";
                imagepath = "<img src='" + test + "'/>";
            }

            new Configuration_BL(base.ContextInfo).GetBillConfigDetails(iBillGroupID, "Header Content", OrgID, ILocationID, out lstConfig);

            if (lstConfig.Count > 0)
            {
                HospitalName = lstConfig[0].ConfigValue.Trim().Replace("Rincian Pembayaran", "");
            }
            Response.Clear();
            Response.ClearHeaders();
            Response.ClearContent();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=IndentDetails_" + lblIntendNo.Text + ".xls");
            Response.ContentType = "application/vnd.ms-excel";
            Response.Output.Write("\n<html>\n<body>");
            Response.Output.Write("<table>");

            Response.Output.Write("<tr> <td class='v-bottom'><div class='a-center'>" + imagepath + "</div> </td> <td colspan='3'><H3>" + HospitalName + "</H3></td>  </tr>");
            //Response.Output.Write("<tr> <td colspan='3'><H3>" + HospitalName + "</H3></td>  </tr>");

            Response.Output.Write("<tr> <td></td></tr>");
            //Response.Output.Write("<tr> <td colspan='5' style='text-align:center'>" + "<B>" + hdnPageName.Value + "&nbsp;" + txtFromDate.Text.ToString() + " - " + txtToDate.Text.ToString() + "</B></td></tr>");
            //Response.Output.Write("<tr> <td colspan='5' style='text-align:center'>" + "<B>Pengguna Wise Laporan Collection " + txtFromDate.Text.ToString() + " - " + txtToDate.Text.ToString() + "</B></td></tr>");
            Response.Output.Write("</table>");


            System.IO.StringWriter oStringWriter = new System.IO.StringWriter();
            HtmlTextWriter oHtmlTextWriter = new HtmlTextWriter(oStringWriter);

            //imgBillLogo.RenderControl(oHtmlTextWriter);

            if (hdnXsltPrint.Value == "N")
            {
                tblIndentInfo.RenderControl(oHtmlTextWriter);
                GridViewDetails.RenderControl(oHtmlTextWriter);
            }
            else
            {
                string bill_print = string.Empty;
                bill_print = "ViewIssueIndentDetails-" + base.LanguageCode;
                List<XSLBillFormat> lstXSLBillFormat = new List<XSLBillFormat>();
                
                new Master_BL(ContextInfo).GetXSLBillFormat(OrgID, bill_print, out lstXSLBillFormat);
                XslTransform xsl = new XslTransform();
                XmlDocument xml = new XmlDocument();
                //xml.LoadXml(sw.ToString());
                xml = LoadXslt(Convert.ToInt64(Request.QueryString["intID"]), Convert.ToInt64(Request.QueryString["ID"]), Status);
                //string s = Server.MapPath("..\\xsl\\WHC-ViewIssueIndentDetails-en-GB.xsl");
                //xsl.Load(s);

                using (var stringReader = new StringReader(lstXSLBillFormat[0].Body.Trim()))
                {
                    using (var xslt = XmlReader.Create(stringReader))
                    {
                        xsl.Load(xslt);
                    }
                }
                xmlIndentView.Document = xml;
                xmlIndentView.Transform = xsl;
                xmlIndentView.RenderControl(oHtmlTextWriter);
                //divXsltPrint.RenderControl(oHtmlTextWriter);
            }

            // trbeakupdetails.RenderControl(oHtmlTextWriter);
            // ctr.RenderControl(oHtmlTextWriter);
            //hiddenfield is shown as input box in excel. To hide it following code has been added
            string html = oStringWriter.ToString().Replace("<input", "<input style=\"display:none\"");
             html = oStringWriter.ToString().Replace("<input", "<span");
            Response.Output.Write(html);
            //Response.Output.Write(oStringWriter.ToString());
            oHtmlTextWriter.Close();
            oStringWriter.Close();
            Response.Output.Write("\n</body>\n</html>");
            Response.Flush();
            Response.End();


        }
        catch (InvalidOperationException ioe)
        {
            CLogger.LogError("Error in Userwise Collection  Report-ExportToExcel", ioe);
        }
    }
    protected void HideOrShowUsageCount()
    {
        List<InventoryConfig> lstInventoryConfig = new List<InventoryConfig>();
        new Configuration_BL(base.ContextInfo).GetInventoryConfigDetails("EnablePackSize", OrgID, ILocationID, out lstInventoryConfig);
        if (lstInventoryConfig.Count > 0)
        {

            hdnEnablePackSize.Value = lstInventoryConfig[0].ConfigValue;


        }
        else
        {

            hdnEnablePackSize.Value = "N";
        }

    }

}



