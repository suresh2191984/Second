<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeFile="PurchaseOrderReportGST.aspx.cs"
    Inherits="InventoryReports_PurchaseOrderReportGST" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Purchase Order Report</title>

    <script src="Scripts/GridviewSelRow.js" type="text/javascript"></script>
 <script language="javascript" type="text/javascript">
        function printwin() {
          //  var prtContent = document.getElementById('dPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write('<html><style>html *{font-size: 7px;}</style><body>');
        //    document.getElementById('gvPurchase').setAttribute["AllowPaging"]= "False";
         //        document.getElementById('gvPurchase_Alternate').setAttribute["AllowPaging"]= "False";
              WinPrint.document.write($('#dPrint').html());
         //   WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.write('</body></html>');
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //WinPrint.close();
            return false;
        }
        
   function popupprint() {
            $('#tblHostional').removeClass().addClass('show');
            var PrtLog = document.getElementById('tblHostional');
            var prtContent = document.getElementById('dPrint');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(PrtLog.innerHTML);
            WinPrint.document.write($('dPrint').html() + prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            $('#tblHostional').removeClass().addClass('hide');
            return false;
        }

    </script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnSearch">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <div class="contentdata">
           <div id="tblHostional" class="hide">
            <table class="searchPanel w-100p">
                <tr>
                    <td class='v-bot'>
                        <img alt="img" id="imgPath" runat="server" />
                    </td>
                    <td class="a-center">
                        <asp:Label ID="lblHospital" runat="server" Text="Hospital" meta:resourcekey="lblHospital_RK" />
                    </td>
                </tr>
                <tr class="marginT30">
                    <td colspan="2" class="a-center">
                        <asp:Label ID="lblReport" runat="server" Text="Report" meta:resourcekey="lblReport_RK" />
                    </td>
                </tr>
            </table>
        </div>
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
                                                </td><td colspan=2>
										<asp:Panel ID="pnReportType" runat="server"   CssClass="divscheduler-border w-90p lh20"
                                            GroupingText="Report Type" meta:resourcekey="pnReportTypeResource1">
											<asp:RadioButtonList ID="rdotypes" CssClass="w-100p" runat="server" RepeatDirection="Horizontal" meta:resourcekey="rdotypesResource2">
												<asp:ListItem Text="Summary" Selected="True" Value="summary"></asp:ListItem>
												<asp:ListItem Text="Details" Value="Details" ></asp:ListItem>
												<%--<asp:ListItem Text="Both" Value="Summary/ Details" ></asp:ListItem>--%>
											</asp:RadioButtonList>
										</asp:Panel>
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
                                                  OnClick="btnprnt_Click"   ToolTip="Print"  meta:resourcekey="btnprntResource1" />
                                                      <asp:ImageButton ID="btnPrint" CssClass="marginL5" runat="server" ImageUrl="~/PlatForm/images/printer.gif"
                                                            OnClientClick="return popupprint();" ToolTip="Print" meta:resourcekey="btnPrintResource1" />
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
                <div id="dPrint" runat="server"  EnableViewState="false">
                    <asp:Table CssClass="w-100p" runat="server" ID="tblpurchaseOrder" meta:resourcekey="tblpurchaseOrderResource1">
                    </asp:Table>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
											<ProgressTemplate>
												<div id="progressBackgroundFilter">
												</div>
												<div align="center" id="processMessage">
													<asp:Label ID="Loading" Text="Loading..." runat="server" meta:resourcekey="LoadingResource2" />
													<br />
													<br />
													<asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/PlatForm/Images/working.gif" meta:resourcekey="imgProgressbarResource2" />
												</div>
											</ProgressTemplate>
										</asp:UpdateProgress>
                    							 <br />
                            <input type="hidden" id="Hidden1" runat="server"/>
                                <asp:GridView ID="grdSummarydata" runat="server" AllowPaging="True" AutoGenerateColumns="False" Width="100%"
                                    CssClass="w-100p gridView" EmptyDataText="No matching records found " meta:resourceKey="grdSummarydataResource1"
                                    OnPageIndexChanging="grdSummarydata_PageIndexChanging"
                                     PageSize="20" ShowFooter="True">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                          <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        
                                       
                                            <asp:BoundField DataField="Tax" HeaderText="Rate (%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="TaxableAmount" HeaderText="Taxable Amount" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                       <asp:BoundField DataField="VATCST" HeaderText="VAT CST Paid" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                       <%--  <asp:BoundField DataField="VAT_CST_paid_decimal" HeaderText="Tax Amount" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>--%>
                                         <asp:BoundField DataField="NetValue" HeaderText="Net Value" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                                                        
                                      
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" Wrap="False" />
                                    <SelectedRowStyle ForeColor="AliceBlue" />
                                </asp:GridView>
								<asp:GridView ID="grdSummarydata_alt" runat="server" AutoGenerateColumns="False" ShowFooter="true" Width="100%"
                                    CssClass="w-100p gridView" meta:resourceKey="grdSummarydata_altResource1">
                                    <Columns>
                                    <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                         <asp:BoundField DataField="Tax" HeaderText="Rate (%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="GrossValue" HeaderText="Taxable Value" DataFormatString="{0:N2}">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="CGST" HeaderText="CGST" DataFormatString="{0:N2}">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="SGST" HeaderText="SGST " DataFormatString="{0:N2}">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="IGST" HeaderText="IGST" DataFormatString="{0:N2}">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                          <asp:BoundField DataField="TaxAmount" HeaderText="Tax Amount" DataFormatString="{0:N2}">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NetValue" HeaderText=" Net Amount" meta:resourceKey="BoundFieldResource13" DataFormatString="{0:N2}">
                                            <ItemStyle HorizontalAlign="Right" />                               
                                            
                                              </asp:BoundField>
                                       
                                    </Columns>
                                   <HeaderStyle CssClass="dataheader1" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" Wrap="False" />
                                    <SelectedRowStyle ForeColor="AliceBlue"  Font-Bold="True" /> 
                                  <FooterStyle CssClass="grdcolor" Font-Bold="True" HorizontalAlign=Right
                                   />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                  
                                    <RowStyle Font-Bold="True" HorizontalAlign=Right />
                                   
                                </asp:GridView>
                            
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
                                <FooterStyle CssClass="dataheader1" BackColor="White" ForeColor="#000066" />
                                <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Wrap="False" />
                                <RowStyle Font-Bold="True" />
                                <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                            </asp:GridView>
                            <br />
                            <input type="hidden" id="hdnRowCount" runat="server"/>
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
										<asp:BoundField DataField="Invoice_Date"  HeaderText="Invoice_Date"
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
                                        <asp:BoundField DataField="CGST0" HeaderText="CGST (0%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="SGST0" HeaderText="SGST (0%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="IGST0" HeaderText="IGST (0%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="CGST05" HeaderText="CGST (2.5%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="SGST05" HeaderText="SGST (2.5%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="IGST05" HeaderText="IGST (5%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="CGST12" HeaderText="CGST (6%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SGST12" HeaderText="SGST (6%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="IGST12" HeaderText="IGST (12%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="CGST18" HeaderText="CGST (9%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="SGST18" HeaderText="SGST (9%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="IGST18" HeaderText="IGST (18%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="CGST28" HeaderText="CGST (14%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="SGST28" HeaderText="SGST (14%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                            <asp:BoundField DataField="IGST28" HeaderText="IGST (28%)" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NetValue" HeaderText=" Net Value" meta:resourceKey="BoundFieldResource13">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                    </Columns>
                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" Wrap="False" />
                                    <RowStyle Font-Bold="True" />
                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                </asp:GridView>
                              
                              
                                <div id="divpanels" class="" style="max-height: 175px; width: 1015px; overflow: auto;">
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
                                        <asp:BoundField DataField="Invoice_Date" DataFormatString="{0:dd-MMM-yyyy}" HeaderText="StockReceived_Date"
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
                                        <asp:TemplateField HeaderText="Seller_GSTIN" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblTinNo" runat="server" meta:resourcekey="lblTinNoResource2" Text='<%# Eval("TinNo") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" />
                                        </asp:TemplateField>
										<asp:BoundField DataField="Invoice_Date"  HeaderText="Invoice_Date"
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
                                                    Text='<%# Eval("GrossAmount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTotalGross.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CGST(0%)">
                                            <FooterTemplate>
                                                <%# lblCGST0.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCGST0" runat="server"  Text='<%# Eval("CGST0") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SGST(0%)" >
                                            <FooterTemplate>
                                                <%# lblSGST0.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSGST0" runat="server" Text='<%# Eval("SGST0") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IGST(0%)" >
                                            <FooterTemplate>
                                                <%# lblIGST0.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblIGST0" runat="server" Text='<%# Eval("IGST0") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CGST(2.5%)" >
                                            <FooterTemplate>
                                                <%# lblCGST05.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCGST05" runat="server" Text='<%# Eval("CGST05") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SGST(2.5%)" >
                                            <FooterTemplate>
                                                <%# lblSGST05.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSGST05" runat="server" Text='<%# Eval("SGST05") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IGST(5%)" >
                                            <FooterTemplate>
                                                <%# lblIGST05.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblIGST05" runat="server"  Text='<%# Eval("IGST05") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CGST(6%)" >
                                            <FooterTemplate>
                                                <%# lblCGST12.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCGST12" runat="server"  Text='<%# Eval("CGST12") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SGST(6%)">
                                            <FooterTemplate>
                                                <%# lblSGST12.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSGST12" runat="server"  Text='<%# Eval("SGST12") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IGST(12%)" >
                                            <FooterTemplate>
                                                <%# lblIGST12.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblIGST12" runat="server"  Text='<%# Eval("IGST12") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CGST(9%)" >
                                            <FooterTemplate>
                                                <%# lblCGST18.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCGST18" runat="server"  Text='<%# Eval("CGST18") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="SGST(9%)">
                                            <FooterTemplate>
                                                <%# lblSGST18.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSGST18" runat="server"  Text='<%# Eval("SGST18") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IGST(18%)" >
                                            <FooterTemplate>
                                                <%# lblIGST18.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblIGST18" runat="server"  Text='<%# Eval("IGST18") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="CGST(14%)" >
                                            <FooterTemplate>
                                                <%# lblCGST28.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblCGST28" runat="server"  Text='<%# Eval("CGST28") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                            <asp:TemplateField HeaderText="SGST(14%)">
                                            <FooterTemplate>
                                                <%# lblSGST28.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSGST28" runat="server"  Text='<%# Eval("SGST28") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="IGST(28%)" >
                                            <FooterTemplate>
                                                <%# lblIGST28.Text%>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblIGST28" runat="server"  Text='<%# Eval("IGST28") %>'></asp:Label>
                                            </ItemTemplate>
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
										<asp:TemplateField HeaderText="Status" >
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" 
                                                    Text='<%# Eval("Status") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <%# lblTotalNet1.Text %>
                                            </FooterTemplate>
                                            <FooterStyle CssClass="dataheader1" Font-Bold="True" HorizontalAlign="Right" />
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <HeaderStyle CssClass="dataheader1" />
                                    <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" Wrap="False" />
                                    <SelectedRowStyle ForeColor="AliceBlue" />
                                </asp:GridView>
                                </div>
                                <asp:Label ID="lblTotalGross" runat="server" meta:resourceKey="lblTotalGrossResource2"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblTotalNet1" runat="server" meta:resourceKey="lblTotalNet1Resource1"
                                    Text="0" Visible="False"></asp:Label>
                                <asp:Label ID="lblSGST0" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblCGST0" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblIGST0" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblTotalDiscount" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblSGST05" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblCGST05" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblIGST05" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                             
                                <asp:Label ID="lblSGST12" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                Visible="False"></asp:Label>
                                <asp:Label ID="lblCGST12" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblIGST12" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>    
                                             
                                <asp:Label ID="lblSGST18" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                Visible="False"></asp:Label>
                                <asp:Label ID="lblCGST18" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblIGST18" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                             
                                <asp:Label ID="lblSGST28" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                Visible="False"></asp:Label>
                                <asp:Label ID="lblCGST28" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
                                <asp:Label ID="lblIGST28" runat="server" meta:resourcekey="lblVat0Resource2" Text="0"
                                    Visible="False"></asp:Label>
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
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
            <asp:HiddenField ID="hdnPageName" runat="server" />

        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnStatus" runat="server" />
        <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
    </form>

   

    <script language="javascript" type="text/javascript">
        $(document).ready(function () {
            calcWidth();
        });
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
        function calcWidth() {
            setTimeout(function () {
                var hgt = $('.contentdata').height() - $('#tblStock').height() - 175;
                var widt = $(window).width() - 8;
                $("#divpanels").css('max-height', hgt);
                $("#divpanels").css('width', widt);
                $("#divpanels").css('overflow', 'auto');
            }, 1000);
        }
$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });


    </script>

</body>
</html>

