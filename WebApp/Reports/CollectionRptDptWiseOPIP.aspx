<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectionRptDptWiseOPIP.aspx.cs"
    Inherits="Reports_CollectionRptDptWiseOPIP" meta:resourcekey="PageResource1" EnableEventValidation ="false"  %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>


    <style type="text/css">
        .style1
        {
            width: 80%;
            height: 22px;
        }
        .style2
        {
            height: 22px;
        }
        .style3
        {
            height: 32px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                          <table id="tblCollectionOPIP" class="a-center w-100p">
                            <tr class="a-center">
                                <td class="a-center">
                                    <div class="dataheaderWider">
                                        <table id="tbl" class="w-100p">
                                            <tr>
                                                <td class="a-right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" 
                                                        meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender1" Format="dd/MM/yyyy" runat="server" TargetControlID="txtFDate"
                                                        PopupButtonID="ImgFDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgFDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgFDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                        ControlToValidate="txtFDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                                                        meta:resourcekey="MaskedEditValidator5Resource1" />
                                                </td>
                                                <td class="a-right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date :" runat="server" 
                                                        meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td class="a-left">
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <ajc:CalendarExtender ID="CalendarExtender2" Format="dd/MM/yyyy" runat="server" TargetControlID="txtTDate"
                                                        PopupButtonID="ImgTDate" Enabled="True" />
                                                    <asp:ImageButton ID="ImgTDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                        CausesValidation="False" meta:resourcekey="ImgTDateResource1" />
                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtTDate"
                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                        ControlToValidate="txtTDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                        meta:resourcekey="MaskedEditValidator1Resource1" />
                                                </td>
                                                <td class="a-left">
                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                        runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                       <%-- <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>--%>
                                                        <%--<asp:ListItem Text="OP&IP" Value="-1"></asp:ListItem>--%>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                   <%-- <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1"/>
                                                    <asp:LinkButton ID="lnkExportXL" Text="Export To XL" Font-Underline="True" 
                                                        runat="server" Font-Bold="True" Font-Size="10px"
                                                        ForeColor="Black" ToolTip="Save As Excel" OnClick="lnkExportXL_Click" 
                                                        meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>--%>
                                                          <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                                <td class="a-left">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td class="a-left">
                                                    <asp:LinkButton ID="lnkBack"  Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age" 
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="style3">
                                                    &nbsp;
                                                </td>
                                                <td class="style3">
                                                    &nbsp;
                                                </td>
                                                <td class="style3">
                                                    &nbsp;
                                                </td>
                                                <td class="style3">
                                                    &nbsp;
                                                </td>
                                                <td class="style3">
                                                    <asp:RadioButtonList ID="rblReportType" ValidationGroup="rformat" RepeatDirection="Horizontal" 
                                                        runat="server" meta:resourcekey="rblReportTypeResource1">
                                                       <%-- <asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td class="style3">
                                                    &nbsp;
                                                </td>
                                                <td class="style3">
                                                    &nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdateProgress ID="Progressbar" runat="server">
                                        <ProgressTemplate>
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" 
                                                meta:resourcekey="imgProgressbarResource1" />
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait...." runat="server" 
                                                meta:resourcekey="Rs_PleasewaitResource1"></asp:Label>
                                        </ProgressTemplate>
                                    </asp:UpdateProgress>
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table class="w-100p">
                                            <tr>
                                                <td class="a-right paddingR10">
                                                    <b id="printText" runat="server"><asp:Label ID="Rs_PrintReport" 
                                                        Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label>
                                                    </b>
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return popupprint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:UpdatePanel ID="updatePanel1" runat="server">
                                        <ContentTemplate>
                                            <div id="divOPDWCR" runat="server" style="display: block;">
                                                <div id="prnReport" style="font-family: Verdana; text-decoration: none; font-size: 10px;">
                                                    <asp:GridView ID="gvIPReport" runat="server" AutoGenerateColumns="False" Visible="False"
                                                        OnRowDataBound="gvIPReport_RowDataBound" Font-Names="verdana" class="w-100p gridView" 
                                                        Font-Size="10px" meta:resourcekey="gvIPReportResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="a-left h-25">
                                                                                <b><asp:Label ID="Rs_Date" Text="Date :" runat="server" 
                                                                                    meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                <asp:LinkButton ID="lnkDate" ForeColor="Blue" Font-Bold="True" Font-Size="12px" Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>'
                                                                                    runat="server" meta:resourcekey="lnkDateResource1"></asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="100%"
                                                                                    ForeColor="#333333" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                    OnRowCommand="gvIPCreditMain_RowCommand" CssClass="w-100p gridView mytable1" 
                                                                                    meta:resourcekey="gvIPCreditMainResource1">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Department Name" 
                                                                                            meta:resourcekey="TemplateFieldResource1"  >
                                                                                            <ItemTemplate >
                                                                                              
                                                                                                <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                                                    runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                            <ItemStyle Width="42%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="ItemQuantity" DataFormatString="{0:N0}" 
                                                                                            HeaderText="Quantity" meta:resourcekey="BoundFieldResource1" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField Visible="False" DataField="ItemAmount"  
                                                                                            DataFormatString="{0:0.00}" HeaderText="Amount" 
                                                                                            meta:resourcekey="BoundFieldResource2" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField  DataField="BilledAmount" DataFormatString="{0:0.00}" 
                                                                                            HeaderText="BilledAmount" meta:resourcekey="BoundFieldResource3" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" 
                                                                                            HeaderText="AmountReceived" meta:resourcekey="BoundFieldResource4" >
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                                </asp:GridView>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td class="w-45p">
                                                                                            <asp:Label ID="lblSubTotal" Font-Size="12px" Text="Total" runat="server" 
                                                                                                meta:resourcekey="lblSubTotalResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td  class="a-right w-13p">
                                                                                            <asp:Label ID="lblQty" runat="server" meta:resourcekey="lblQtyResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td  class="a-right w-20p">
                                                                                            <asp:Label ID="lblBilledAmount" runat="server" 
                                                                                                meta:resourcekey="lblBilledAmountResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td class="a-right w-25p">
                                                                                            <asp:Label ID="lblAmtReceived" runat="server" 
                                                                                                meta:resourcekey="lblAmtReceivedResource1"></asp:Label>
                                                                                        </td>
                                                                                        </tr>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <table id="tblgvIPCreditMainSummary" visible="False" runat="server" class="w-100p">
                                                        <tr runat="server">
                                                            <td class="a-left h-25" runat="server">
                                                                <b><asp:Label ID="Rs_Date" Text="Date:" runat="server"></asp:Label></b>
                                                                <asp:LinkButton ID="lnkDateSummary" ForeColor="Blue" Font-Bold="True" Font-Size="12px"
                                                                    runat="server"></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <asp:GridView ID="gvIPCreditMainSummary" runat="server" AutoGenerateColumns="False"
                                                                    ForeColor="#333333" CssClass="mytable1 gridView w-100p" OnRowDataBound="gvIPCreditMainSummary_RowDataBound"
                                                                    OnRowCommand="gvIPCreditMainSummary_RowCommand">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Department Name">
                                                                            <ItemTemplate>
                                                                             
                                                                                <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                                    runat="server"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle Width="42%" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ItemQuantity" DataFormatString="{0:N0}" 
                                                                            HeaderText="Quantity" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField Visible="False"  DataFormatString="{0:0.00}" 
                                                                            DataField="ItemAmount" HeaderText="Amount" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="BilledAmount" DataFormatString="{0:0.00}"  
                                                                            HeaderText="BilledAmount" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}"  
                                                                            HeaderText="AmountReceived" >
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <table id="tabTotal2" style="display: none;" runat="server" class="w-100p">
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <table class="w-100p">
                                                                    <tr class="h-25 bold">
                                                                        <td class="a-center w-42p">
                                                                            <asp:Label ID="Rs_Total" Text="Total" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="tdQuantity2" class="a-right w-13p" runat="server">
                                                                        </td>
                                                                        <td id="tdBilledAmount2" class="a-right w-20p" runat="server">
                                                                        </td>
                                                                        <td id="tdAmountReceived2"  class="a-right w-25p" runat="server">
                                                                        </td>
                                                                        
                                                                    </tr>
                                                                    <tr class="bold">
                                                                        <td>
                                                                            <asp:Label ID="Rs_CreditDebitCardChargesCollected" Text="Credit/Debit Card Charges Collected" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="td1"  class="a-right" runat="server">
                                                                        </td>
                                                                        <td id="td2"  class="a-right" runat="server">
                                                                        </td>
                                                                        <td id="tdServiceCharge"  class="a-right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="bold">
                                                                        <td >
                                                                            <asp:Label ID="lbltotAdv" runat="server"><asp:Label ID="Rs_TotalAdvance" Text="Total Advance" runat="server"></asp:Label>
</asp:Label>
                                                                        </td>
                                                                        <td id="td3" class="a-right" runat="server">
                                                                        </td>
                                                                        <td id="td4"  class="a-right" runat="server">
                                                                        </td>
                                                                        <td id="dvTotAdvance"  class="a-right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr class="bold">
                                                                        <td  >
                                                                            <asp:Label ID="lblDueChart" runat="server"><asp:Label ID="Rs_DueChartPayments" Text="Due Chart Payments" runat="server"></asp:Label>
</asp:Label>
                                                                        </td>
                                                                        <td id="td6"  class="a-right" runat="server">
                                                                        </td>
                                                                        <td id="td7"  class="a-right" runat="server">
                                                                        </td>
                                                                        <td id="dvDuechartPayments"  class="a-right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td>
                                                                           <asp:Label ID="Rs_TotalDiscounts"  Text="Total Discounts" runat="server"></asp:Label>
                                                                        </td>
                                                                        
                                                                        <td id="td9"  align="right" runat="server">
                                                                        </td>
                                                                        <td id="td10"  align="right" runat="server">
                                                                        </td>
                                                                        <td id="dvTotalDiscounts"  align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="height: 1px; background-color: Black;" align="right" colspan="4">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td>
                                                                            <asp:Label ID="Rs_TotalReceivedAmount1" Text="Total Received Amount" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="td15"  align="right" runat="server">
                                                                        </td>
                                                                        <td id="td16"  align="right" runat="server">
                                                                        </td>
                                                                        <td id="dvTotRcvd"  align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <table id="tblExcessAmount" runat="server" width="100%;">
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <asp:Label runat="server" ID="lblAdvRcvdText" Font-Bold="True"></asp:Label>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:Label ID="lblExcessAmount" runat="server" Font-Bold="True"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <div id="breakup">
                                                        <table border="0" id="tabGranTotal1" runat="server" visible="False" class="dataheaderWider"
                                                            cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                            <tr runat="server">
                                                                <td align="right" runat="server" class="style1">
                                                                    <asp:Label ID="Rs_GrandTotal" Text="Grand Total" runat="server"></asp:Label>
                                                                    <label id="Label1" style="color: Green;" runat="server">
                                                                        (A)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server" class="style2">
                                                                    <label id="lblGrandTotal" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr id="trDiscount" runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_TotalDiscountAmount" Text="Total Discount Amount" runat="server"></asp:Label>
                                                                    <label id="Label5" style="color: Green;" runat="server">
                                                                        (B)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblDiscountAmount" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr id="trServiceCharge" runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_ServiceCharge"  Text="Service Charge" runat="server"></asp:Label>
                                                                    <label id="Label2" style="color: Green;" runat="server">
                                                                        (C)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblServiceCharge" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr id="trTax" runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_Tax" Text="Tax" runat="server"></asp:Label>
                                                                    <label id="Label3" style="color: Green;" runat="server">
                                                                        (D)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblTax" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table border="0" id="tabGranTotal2" runat="server" visible="False" class="dataheaderWider"
                                                            cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                            <tr runat="server">
                                                                <td colspan="2" align="right" runat="server">
                                                                    ----------------
                                                                </td>
                                                            </tr>
                                                            <tr id="trNetAmt" runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_TotalNetAmount" Text="Total Net Amount" runat="server"></asp:Label>
                                                                    <label id="Label4" style="color: Green;" runat="server">
                                                                        (E)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblNetAmount" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_TotalReceivedAmount" Text="Total Received Amount" runat="server"></asp:Label>
                                                                    <label id="Label7" style="color: Green;" runat="server">
                                                                        (F)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblReceivedAmount" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_TotalDueAmount1" Text="Total Due Amount"  runat="server"></asp:Label>
                                                                    <label id="Label6" style="color: Green;" runat="server">
                                                                        (G)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblDueAmount" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr runat="server">
                                                                <td colspan="2" align="right" runat="server">
                                                                    ----------------
                                                                </td>
                                                            </tr>
                                                        </table>
                                                        <table border="0" id="tabtotal" runat="server" visible="False" class="dataheaderWider"
                                                            cellpadding="5" style="color: #000000;" cellspacing="0" width="100%">
                                                            <tr style="display: none;" runat="server">
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_TotalDueAmount" Text="Total Due Amount" runat="server"></asp:Label>
                                                                    <label id="Label8" style="color: Green;" runat="server">
                                                                        (A)</label> :
                                                                </td>
                                                                <td align="left" style="padding-right: 15px;" runat="server">
                                                                    <label id="lblDueTotal" runat="server">
                                                                    </label>
                                                                </td>
                                                            </tr>
                                                            <tr runat="server">
                                                                <td colspan="2" runat="server">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>
                    </div>
      <Attune:Attunefooter ID="Attunefooter" runat="server" />          
        <asp:HiddenField ID="hdnMessages" runat ="server" />
    </form>
        <script language="javascript" type="text/javascript">
        function validateToDate() {
                AlertType = SListForAppMsg.Get('Reports_CollectionRptDptWiseOPIP_aspx_03') == null ? "Alert" : SListForAppMsg.Get('Reports_CollectionRptDptWiseOPIP_aspx_03');
               
                var fdate = SListForAppMsg.Get('Reports_CollectionRptDptWiseOPIP_aspx_01') == null ? "Provide / select From date" : SListForAppMsg.Get('Reports_CollectionRptDptWiseOPIP_aspx_01');
                var tdate = SListForAppMsg.Get('Reports_CollectionRptDptWiseOPIP_aspx_02') == null ? "Provide / select To date" : SListForAppMsg.Get('Reports_CollectionRptDptWiseOPIP_aspx_02');
            if (document.getElementById('txtFDate').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonMessages_18');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    ValidationWindow(fdate, AlertType);
                  //  alert('Provide / select From date');
                }
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                var userMsg = SListForApplicationMessages.Get('CommonMessages_19');
                if (userMsg != null) {
                    alert(userMsg);
                }
                else {
                    // alert('Provide / select To date');
                    ValidationWindow(tdate, AlertType);
                }
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent = document.getElementById('prnReport');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }
    </script>
</body>
</html>
