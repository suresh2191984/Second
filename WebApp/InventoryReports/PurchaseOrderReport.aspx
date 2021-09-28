<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="PurchaseOrderReport.aspx.cs"
    Inherits="InventoryReports_PurchaseOrderReport" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchase Order Report</title>

    <script src="Scripts/GridviewSelRow.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSearch">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
            <div id="divProjection">
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <table width="100%" class="dataheader2 defaultfontcolor" border="0" cellpadding="4"
                                cellspacing="3">
                                <tr>
                                    <td align="center">
                                        <table width="100%">
                                            <tr>
                                                <td class="w-12p a-left">
	                                                <asp:Label ID="lblOrgs" runat="server" Text="Select an Organization" 
		                                                meta:resourcekey="lblOrgsResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p">
	                                                <asp:DropDownList ID="ddlTrustedOrg"  onchange="javascript:clearContextText();" runat="server"
		                                                CssClass="small" meta:resourcekey="ddlTrustedOrgResource1" >
	                                                </asp:DropDownList>
                                                </td>
                                                <td align="left" class="w-7p a-left">
                                                    <asp:Label ID="Labelfrmdt" runat="server" Text="From Date" meta:resourcekey="LabelfrmdtResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p a-left">
                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass="small datePickerPres" Width="130px"
                                                        onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="1"
                                                        meta:resourcekey="txtFromResource1" />
                                                </td>
                                                <td align="left" class="w-7p a-left">
                                                    <asp:Label ID="LabelTodt" runat="server" Text="To Date " meta:resourcekey="LabelTodtResource1"></asp:Label>
                                                </td>
                                                <td class="w-20p a-left">
                                                    <asp:TextBox ID="txtTo" runat="server" CssClass="small datePickerPres" Width="130px"
                                                        onkeypress="return ValidateSpecialAndNumeric(this);" TabIndex="2"
                                                        meta:resourcekey="txtToResource1" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkDefault" runat="server" Width="130px" TabIndex="3" Text="Alternate Report"
                                                        meta:resourcekey="chkDefaultResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="left">
                                                    <asp:Label ID="LabelLocation" runat="server" Text="Location" meta:resourcekey="LabelLocationResource1"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small"  TabIndex="4"
                                                        meta:resourcekey="ddlLocationResource1">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="left">
                                                    <asp:Label ID="LabelSupplier" runat="server" Text="Supplier" meta:resourcekey="LabelSupplierResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtSupplier" runat="server" CssClass="small" 
                                                        OnkeyPress="return ValidateMultiLangChar(this)" TabIndex="3" meta:resourcekey="txtSupplierResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtSupplier"
                                                        ServiceMethod="GetSupplierList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                                                        EnableCaching="False" MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="wordWheel listMain box"
                                                        CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" CompletionListItemCssClass="listitemtwo"
                                                        DelimiterCharacters=";,:" Enabled="True">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td align="left" >
                                                    <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                        OnClientClick="javascript:return CheckDates('');" OnClick="btnSearch_Click"
                                                        TabIndex="5" meta:resourcekey="btnSearchResource1" />
                                                    &nbsp;
                                                </td>
                                                <td>
                                                <asp:LinkButton ID="lnkBack" runat="server" CssClass="cancel-btn" OnClick="lnkBack_Click"
                                                    meta:resourcekey="lnkBackResource1" Text="Back&amp;nbsp;&amp;nbsp;&amp;nbsp;"></asp:LinkButton>
                                                </td>
                                                <td class="a-left">
                                        <table id="tblTool" runat="server" style="display: none">
                                                        <tr>
                                                            <td>
                                                    <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../PlatForm/images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                                                <%--<asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="True"
                                                        Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" Text="Export To XL"
                                                                    Font-Underline="True" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>--%>
                                                                <asp:ImageButton ID="btnprnt" runat="server" CssClass="marginL10" ImageUrl="~/PlatForm/Images/printer.gif"
                                                        OnClientClick="return printwin();" ToolTip="Print" meta:resourcekey="btnprntResource1" />
                                                               <%-- <b id="printText" runat="server">
                                                        <asp:LinkButton ID="lnkPrint" Text="Print Report" OnClientClick="return printwin();"
                                                                        runat="server" meta:resourcekey="lnkExportXLResource2"></asp:LinkButton></b>--%>
                                                    <%-- <asp:LinkButton OnClientClick="javascript:return printwin();" ID="hypLnkPrint" Font-Bold="True"
                                                    Font-Size="12px" ForeColor="Black" Target="BillWindow" runat="server" ToolTip="Click Here To Print Purchase Order Report"
                                                    meta:resourcekey="hypLnkPrintResource1">
                                                    <img id="imgPrint" alt="" runat="server" style="border-width: 0px;" src="../PlatForm/images/printer.gif" />
                                                    &nbsp;
                                                    <asp:Label ID="LabelPrntporpt" runat="server" Font-Bold="true" Text="Print PO Report"
                                                        meta:resourcekey="LabelPrntporptResource1"></asp:Label>
                                                </asp:LinkButton>--%>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <div id="dPrint" runat="server">
                    <asp:Table CssClass="w-100p" runat="server" ID="tblpurchaseOrder" meta:resourcekey="tblpurchaseOrderResource1">
                    </asp:Table>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="MainGrandTotal" runat="server" AutoGenerateColumns="False" Visible="False"
                                CssClass="w-100p gridView" meta:resourcekey="MainGrandTotalResource1">
                                <Columns>
                                    <asp:TemplateField HeaderText="Grand Total" meta:resourcekey="TemplateFieldResource1">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBillID1" Width="380px" Text="Grand Total" runat="server" meta:resourcekey="lblBillID1Resource1"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="GrandTotal" HeaderText="Gross Value" meta:resourcekey="BoundFieldResource1">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="TaxAmount0" HeaderText="Tax Amount" meta:resourcekey="BoundFieldResource2">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NetValue" HeaderText=" Net Value" meta:resourcekey="BoundFieldResource3">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="NetRoundofValue" HeaderText="NetRoundoff Value" meta:resourcekey="BoundFieldResource16">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                </Columns>
                                <FooterStyle BackColor="White" ForeColor="#000066" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Wrap="False" />
                                <RowStyle Font-Bold="True" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                            </asp:GridView>
                            <br />
                            <input type="hidden" id="hdnRowCount" runat="server">
                                <asp:GridView ID="gvPurchase" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    CssClass="w-100p gridView" EmptyDataText="No matching records found " meta:resourceKey="gvPurchaseResource1"
                                    OnPageIndexChanging="gvPurchase_PageIndexChanging" OnRowCreated="gridView_RowCreated"
                                    OnRowDataBound="gvPurchase_RowDataBound" PageSize="20" ShowFooter="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="StockReceived_Date"
                                            meta:resourceKey="BoundFieldResource4">
                                            <FooterStyle CssClass="dataheader1" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="SRD No" meta:resourceKey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBillID1" runat="server" meta:resourcekey="lblBillID1Resource2"
                                                    Text='<%# Eval("PurchaseOrderNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name_of_seller" meta:resourceKey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="SupplierName" runat="server" meta:resourcekey="SupplierNameResource1"
                                                    Text='<%# Eval("SupplierName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="Labelpagetot" runat="server" meta:resourceKey="LabelpagetotResource1"
                                                    Text="Page Total"></asp:Label>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Seller_TIN" meta:resourceKey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTinNo" runat="server" meta:resourcekey="lblTinNoResource1" Text='<%# Eval("TinNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
										<asp:BoundField DataField="InvoiceDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Invoice_Date"
											meta:resourcekey="BoundFieldResource19">
											<FooterStyle CssClass="dataheader1" />
										</asp:BoundField>
                                        <asp:TemplateField HeaderText="Invoice_No" meta:resourceKey="TemplateFieldResource6">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceNo" runat="server" meta:resourcekey="lblInvoiceNoResource1"
                                                    Text='<%# Eval("InvoiceNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="VAT_CST_paid" meta:resourceKey="TemplateFieldResource7">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPaidAmt" runat="server" meta:resourcekey="lblPaidAmtResource1"
                                                    Text='<%# Eval("TaxAmount0") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblPaidAmt.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Taxable Amount" meta:resourceKey="TemplateFieldResource8"
                                            Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTaxableAmt0" runat="server" meta:resourcekey="lblTaxableAmt0Resource1"
                                                    Text='<%# Eval("TaxableAmount0") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTaxableAmount0.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax_rate" meta:resourceKey="TemplateFieldResource9">
                                            <ItemTemplate>
                                                <asp:Label ID="lblComments" runat="server" meta:resourcekey="lblCommentsResource1"
                                                    Text='<%# Eval("Tax") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Purchase_Value" meta:resourceKey="TemplateFieldResource10">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNetvalue" runat="server" meta:resourcekey="lblNetvalueResource1"
                                                    Text='<%# Eval("NetValue") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTotalNet.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" Wrap="False" />
                                    <SelectedRowStyle ForeColor="AliceBlue" />
                                </asp:GridView>
                                <asp:Label ID="lblPaidAmt" runat="server" meta:resourceKey="lblPaidAmtResource2"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblTotalNet" runat="server" meta:resourceKey="lblTotalNetResource1"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblTaxableAmount0" runat="server" meta:resourceKey="lblTaxableAmount0Resource1"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:GridView ID="MainGrandTotal_Alt" runat="server" AutoGenerateColumns="False"
                                    CssClass="gridView w-100p" meta:resourceKey="MainGrandTotal_AltResource1">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Grand Total" meta:resourceKey="TemplateFieldResource11">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBillID1" runat="server" meta:resourceKey="lblBillID1Resource3"
                                                    Text="Grand Total" Width="380px"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="GrandTotal" HeaderText="Gross Value" meta:resourceKey="BoundFieldResource5">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxAmount0" HeaderText="Tax (0%)" meta:resourceKey="BoundFieldResource6">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxAmount4" HeaderText="Tax (4%)" meta:resourceKey="BoundFieldResource7">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxAmount5" HeaderText="Tax (5%)" meta:resourceKey="BoundFieldResource8">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxAmount12" HeaderText="Tax (12.5%)" meta:resourceKey="BoundFieldResource9">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxAmount13" HeaderText="Tax (13.5%)" meta:resourceKey="BoundFieldResource10">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="TaxAmount14" HeaderText="Tax (14%)" meta:resourceKey="BoundFieldResource11">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Others" HeaderText="Others" meta:resourceKey="BoundFieldResource12">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
										<asp:BoundField DataField="CSTAmount" HeaderText="CST Tax" meta:resourcekey="TemplateFieldResource29">
											<ItemStyle HorizontalAlign="Right" />
										</asp:BoundField>
                                        <asp:BoundField DataField="NetValue" HeaderText=" Net Value" meta:resourceKey="BoundFieldResource13">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RoundofValue" HeaderText="RoundOf Value" meta:resourceKey="BoundFieldResource15">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NetRoundofValue" HeaderText="NetRoundoff Value" meta:resourceKey="BoundFieldResource16">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Wrap="False" />
                                    <RowStyle Font-Bold="True" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                                <br />
                                <br />
                                <asp:GridView ID="gvPurchase_Alternate" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                    CssClass="gridView w-100p" EmptyDataText="No matching records found " meta:resourceKey="gvPurchase_AlternateResource1"
                                    OnPageIndexChanging="gvPurchase_Alternate_PageIndexChanging" OnRowCreated="gridView_RowCreated"
                                    OnRowDataBound="gvPurchase_Alternate_RowDataBound" ShowFooter="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource12">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="StockReceived_Date"
                                            meta:resourceKey="BoundFieldResource14">
                                            <FooterStyle CssClass="dataheader1" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="SRD No" meta:resourceKey="TemplateFieldResource13">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBillID" runat="server" meta:resourcekey="lblBillIDResource1" Text='<%# Eval("PurchaseOrderNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Name_of_seller" meta:resourceKey="TemplateFieldResource14">
                                            <ItemTemplate>
                                                <asp:Label ID="Suppliername" runat="server" meta:resourcekey="SuppliernameResource2"
                                                    Text='<%# Eval("SupplierName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="LabelpgTot" runat="server" meta:resourceKey="LabelpgTotResource1"
                                                    Text="Page Total"></asp:Label>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Seller_TIN" meta:resourceKey="TemplateFieldResource15">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTinNo" runat="server" meta:resourcekey="lblTinNoResource2" Text='<%# Eval("TinNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
										<asp:BoundField DataField="InvoiceDate" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="Invoice_Date"
											meta:resourcekey="BoundFieldResource19">
											<FooterStyle CssClass="dataheader1" />
										</asp:BoundField>
                                        <asp:TemplateField HeaderText="Invoice_No" meta:resourceKey="TemplateFieldResource16">
                                            <ItemTemplate>
                                                <asp:Label ID="lblInvoiceNo" runat="server" meta:resourcekey="lblInvoiceNoResource2"
                                                    Text='<%# Eval("InvoiceNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Gross Value" meta:resourceKey="TemplateFieldResource17">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotalGross" runat="server" meta:resourcekey="lblTotalGrossResource1"
                                                    Text='<%# Eval("GrandTotal") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTotalGross.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax (0%)" meta:resourceKey="TemplateFieldResource18">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVat0" runat="server" meta:resourcekey="lblVat0Resource1" Text='<%# Eval("TaxAmount0") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVat0.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax (4%)" meta:resourceKey="TemplateFieldResource19">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVat4" runat="server" meta:resourcekey="lblVat4Resource1" Text='<%# Eval("TaxAmount4") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVat4.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax (5%)" meta:resourceKey="TemplateFieldResource20">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVat5" runat="server" meta:resourcekey="lblVat5Resource1" Text='<%# Eval("TaxAmount5") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVat5.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax (12.5%)" meta:resourceKey="TemplateFieldResource21">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVat12" runat="server" meta:resourcekey="lblVat12Resource1" Text='<%# Eval("TaxAmount12") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVat12.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax (13.5%)" meta:resourceKey="TemplateFieldResource22">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVat13" runat="server" meta:resourcekey="lblVat13Resource1" Text='<%# Eval("TaxAmount13") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVat13.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Tax (14%)" meta:resourceKey="TemplateFieldResource23">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVat14" runat="server" meta:resourcekey="lblVat14Resource1" Text='<%# Eval("TaxAmount14") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVat14.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Others" meta:resourceKey="TemplateFieldResource24">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVatothers" runat="server" meta:resourcekey="lblVatothersResource1"
                                                    Text='<%# Eval("Others") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVatothers.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
										<asp:TemplateField HeaderText="CST Tax" meta:resourcekey="TemplateFieldResource29">
											<FooterTemplate>
												<%# lblCSTTax.Text%>
											</FooterTemplate>
											<ItemTemplate>
												<asp:Label ID="lblCSTTax" runat="server" meta:resourcekey="lblCSTTaxResource2" Text='<%# Eval("CSTAmount") %>'></asp:Label>
											</ItemTemplate>
											<FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
											<ItemStyle HorizontalAlign="Right" />
										</asp:TemplateField>
                                        <asp:TemplateField HeaderText="Net Value" meta:resourceKey="TemplateFieldResource25">
                                            <ItemTemplate>
                                                <asp:Label ID="lblNetvalue" runat="server" meta:resourcekey="lblNetvalueResource2"
                                                    Text='<%# Eval("NetValue") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTotalNet1.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Discount Amount" meta:resourceKey="TemplateFieldResource28">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPoDiscount" runat="server" meta:resourcekey="lblPoDiscountResource1"
                                                    Text='<%# Eval("PoDiscount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Roundoff Value" meta:resourceKey="TemplateFieldResource26">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRoundOfvalue" runat="server" meta:resourcekey="lblRoundOfvalueResource1"
                                                    Text='<%# Eval("RoundofValue") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVRoundOfvalue.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="NetRoundoff Value" meta:resourceKey="TemplateFieldResource27">
                                            <ItemTemplate>
                                                <asp:Label ID="lblVNetRoundOfvalue" runat="server" meta:resourcekey="lblVNetRoundOfvalueResource1"
                                                    Text='<%# Eval("NetRoundofValue") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblVNetRoundOfvalue.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" Wrap="False" />
                                    <SelectedRowStyle ForeColor="AliceBlue" />
                                </asp:GridView>
                                <asp:Label ID="lblTotalGross" runat="server" meta:resourceKey="lblTotalGrossResource2"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblTotalNet1" runat="server" meta:resourceKey="lblTotalNet1Resource1"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblVat0" runat="server" meta:resourceKey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblVat4" runat="server" meta:resourceKey="lblVat4Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblVat5" runat="server" meta:resourceKey="lblVat5Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblVat12" runat="server" meta:resourceKey="lblVat12Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblVat13" runat="server" meta:resourceKey="lblVat13Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblVat14" runat="server" meta:resourceKey="lblVat14Resource2" Text="0"
                                    Visible="False"></asp:Label>
								<asp:Label ID="lblCSTTax" runat="server" meta:resourcekey="lblCSTTaxResource2" Text="0"
									Visible="False"></asp:Label>
                                <asp:Label ID="lblVatothers" runat="server" meta:resourceKey="lblVatothersResource2"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblVRoundOfvalue" runat="server" meta:resourceKey="lblVRoundOfvalueResource1"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblVNetRoundOfvalue" runat="server" meta:resourceKey="lblVNetRoundOfvalueResource2"
                                    Text="0" Visible="False"></asp:Label>
                            </input>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnStatus" runat="server" />
        <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>

    <script language="javascript" type="text/javascript">
        function printwin() {
            var prtContent = document.getElementById('dPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false
        }

    </script>

    <script language="javascript" type="text/javascript">
        var userMsg;
        var errorMsg = SListForAppMsg.Get("InventoryReports_Error") == null ? "Alert" : SListForAppMsg.Get("InventoryReports_Error");
        function CheckDates(splitChar) {
            if (document.getElementById('txtFrom').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseOrderReport_aspx_01") == null ? "Select From Date!" : SListForAppMsg.Get("InventoryReports_PurchaseOrderReport_aspx_01");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {

                var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseOrderReport_aspx_02") == null ? "Select To Date!" : SListForAppMsg.Get("InventoryReports_PurchaseOrderReport_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            else {
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                if (CheckFromToDate(DateFrom, DateTo)) {
                    GetPurchaseStatusDetails();
                    return false;
                } else {
                    var userMsg = SListForAppMsg.Get("InventoryReports_PurchaseOrderReport_aspx_03") == null ? "From date should not be  greater then To date" : SListForAppMsg.Get("InventoryReports_PurchaseOrderReport_aspx_03");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
        }

$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });

    </script>

</body>
</html>

