<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StockReturnPayment.aspx.cs"
    Inherits="StockReturn_StockReturnPayment" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<%@ Register Src="~/InventoryCommon/Controls/INVStockUsage.ascx" TagName="INVStockUsage" TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Stock Return</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    

    <script language="javascript" type="text/javascript">

        var launch = false;
        function launchModal(index) {
            launch = true;
            document.getElementById('hdnRowIndex').value = index;
            var btn = document.getElementById("btnHidden");
            btn.click();
        }


        function pageLoad() {

            if (launch) {

                $find("mpeAttributeLocation").show();

                launch = false;
            }
        }

        //        function GetSupplierID(source, eventArgs) {
        //            document.getElementById('hdnIsSupplier').value = eventArgs.get_value();
        //        }
       

        
    </script>

    <style type="text/css">
        .style1
        {
            width: 138px;
        }
    </style>
</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server" >
    <input type="hidden" id="hdnRowIndex" runat="server" />
    <input type="hidden" id="hdnRowEdit" runat="server" />
    <input type="hidden" id="hdnTotalqty" runat="server" />
    <input type="hidden" id="hdnProductName" runat="server" />
    <input type="hidden" id="hdnProductList" runat="server" />
    <input type="hidden" id="tempTable" runat="server" />
    <input type="hidden" id="hdnProductId" runat="server" />
    <input type="hidden" id="hdnReceivedID" runat="server" />
    <input type="hidden" id="hdnStockReceivcedNo" runat="server" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">

                        <table class="defaultfontcolor w-100p" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td>
                                 <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_01%>
                                                   
                                     &nbsp;<asp:RadioButton ID="rdoCreditNote" runat="server" OnCheckedChanged="ChkSelectType"
                                        GroupName="rdo" Text="Credit Note" AutoPostBack="True" 
                                        meta:resourcekey="rdoCreditNoteResource1" />
                                    <asp:RadioButton ID="rdoDebitNote" runat="server" GroupName="rdo" OnCheckedChanged="ChkSelectType"
                                        Text="Debit Note" AutoPostBack="True" 
                                        meta:resourcekey="rdoDebitNoteResource1" />
                                </td>
                            </tr>
                        </table>
                        <table class="w-100p">
                            <tr>
                                <td colspan="2">
                                    <table class="w-100p">
                                        <tr>
                                            <td colspan="2">
                                                <div id="divCreditNote" runat="server" class="hide" >
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <table  class="w-100p dataheader2 defaultfontcolor" border="0" cellpadding="2"
                                                                cellspacing="0">
                                                                <tr>
                                                                    <td class="h-10">
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-left">
                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_02%>
                                                                       
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtStockReturnNo" runat="server" 
                                                                            meta:resourcekey="txtStockReturnNoResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td colspan="2">
                                                                        <div id="divSuppliers" runat="server">
                                                                            <table>
                                                                                <tr>
                                                                                    <td>
                                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_03%>
                                                                                        
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlSupplierName" runat="server" 
                                                                                            meta:resourcekey="ddlSupplierNameResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                        <div id="divLocation" runat="server">
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_04%>
                                                                       
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtStockReceivedNumber" runat="server" 
                                                                            meta:resourcekey="txtStockReceivedNumberResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td class="style1">
                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_05%>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtStockReturnDate" runat="server" CssClass="txtboxps datePicker" 
                                                                            meta:resourcekey="txtStockReturnDateResource1"></asp:TextBox>
                                                                        <%--<ajc:MaskedEditExtender ID="txtStockReturnDate_MaskedEditExtender" 
                                                                            runat="server" ErrorTooltipEnabled="True" Mask="99/99/9999"
                                                                            MaskType="Date" TargetControlID="txtStockReturnDate" 
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                        <ajc:CalendarExtender ID="txtStockReturnDate_CalendarExtender" runat="server" Format="dd/MM/yyyy"
                                                                            PopupButtonID="ImgBntCalc0" TargetControlID="txtStockReturnDate" 
                                                                            Enabled="True" />
                                                                        <asp:ImageButton ID="ImgBntCalc0" runat="server" CausesValidation="False" 
                                                                            ImageUrl="~/PlatForm/Images/Calendar_scheduleHS.png" 
                                                                            meta:resourcekey="ImgBntCalc0Resource1" />
                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="txtStockReturnDate_MaskedEditExtender"
                                                                            ControlToValidate="txtStockReturnDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" 
                                                                            ErrorMessage="MaskedEditValidator5" 
                                                                            meta:resourcekey="MaskedEditValidator5Resource1" />--%>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td align="left">
                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_06%>
                                                                        
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtInvoiceOrDC" runat="server" 
                                                                            meta:resourcekey="txtInvoiceOrDCResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td valign="middle" id="td1" runat="server" align="center">
                                                                        <br />
                                                                        &nbsp;&nbsp;<asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn"
                                                                            onmouseover="this.className='btn btnhov'" 
                                                                            onmouseout="this.className='btn'" OnClick="btnSearch_Click" 
                                                                            meta:resourcekey="btnSearchResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                        <Triggers>
                                                            <asp:AsyncPostBackTrigger ControlID="btnHidden" EventName="Click" />
                                                            <%--<asp:PostBackTrigger ControlID="btnHidden" />--%>
                                                        </Triggers>
                                                        <ContentTemplate>
                                                            <table>
                                                                
                                                                <tr>
                                                                    <td align="center">
                                                                        <div id="divTable" runat="server" visible="False">
                                                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                                                <ProgressTemplate>
                                                                                    <asp:Image ID="imgProgressbar" runat="server" 
                                                                                        ImageUrl="~/PlatForm/Images/working.gif" 
                                                                                        meta:resourcekey="imgProgressbarResource1" />
                                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_07%>
                                                                                </ProgressTemplate>
                                                                            </asp:UpdateProgress>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="lblResult" ForeColor="#000333" runat="server" 
                                                                            meta:resourcekey="lblResultResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                        CssClass="mytable1" DataKeyNames="ID,SupplierId" OnPageIndexChanging="grdResult_PageIndexChanging"
                                                                        OnRowCreated="grdResult_OnRowCreated" 
                                                                        OnRowDataBound="grdResult_RowDataBound" Width="100%" 
                                                                        meta:resourcekey="grdResultResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Select" 
                                                                                meta:resourcekey="TemplateFieldResource1">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkBox" runat="server" meta:resourcekey="chkBoxResource1" />
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle Width="2%" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="Description" HeaderText="Stock Return Number" 
                                                                                meta:resourcekey="BoundFieldResource1">
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Name" HeaderText="Vendor" 
                                                                                meta:resourcekey="BoundFieldResource2">
                                                                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Amount" HeaderText="Actual Amount" 
                                                                                meta:resourcekey="BoundFieldResource3">
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="ReferenceNo" 
                                                                                meta:resourcekey="TemplateFieldResource2">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtReferenceNo" Style="text-align: right;" runat="server" MaxLength="20"
                                                                                        Text='<%# Eval("ReferenceNo") %>' Width="60px" 
                                                                                        meta:resourcekey="txtReferenceNoResource1"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Approved Amount" 
                                                                                meta:resourcekey="TemplateFieldResource3">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtApprovedAmount" Style="text-align: right;" runat="server" MaxLength="20"
                                                                                        Text='<%# Eval("TotalCost") %>' Width="60px" 
                                                                                        onkeydown="return validatenumber(event);" 
                                                                                        meta:resourcekey="txtApprovedAmountResource1"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </tr>
                                                                <caption>
                                                                    &nbsp;
                                                                    <tr align="center">
                                                                        <td align="center">
                                                                            <asp:Button ID="btnReturnStock" runat="server" CssClass="btn" 
                                                                                OnClick="btnUpdateAmount_Click" onmouseout="this.className='btn'" 
                                                                                onmouseover="this.className='btn btnhov'" Text="Submit" 
                                                                                meta:resourcekey="btnReturnStockResource1" />
                                                                            &nbsp;
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" 
                                                                                OnClick="btnCancel_Click" onmouseout="this.className='btn'" 
                                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" 
                                                                                meta:resourcekey="btnCancelResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Button ID="btnHidden" runat="server" CssClass="btn" 
                                                                                OnClick="btnHidden_Click" onmouseout="this.className='btn'" 
                                                                                onmouseover="this.className='btn btnhov'" Style="display: none" 
                                                                                Text="Cancel" meta:resourcekey="btnHiddenResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </caption>
                                                            </table>
                                                            <ajc:ModalPopupExtender ID="mpeAttributeLocation" runat="server" 
                                                                BackgroundCssClass="modalBackground" PopupControlID="ModalPanel" TargetControlID="btnDummy"
                                                                OkControlID="OKButton" DynamicServicePath="" Enabled="True" />
                                                            <input id="btnDummy" runat="server" style="display: none;" type="button" />
                                                            <asp:Panel ID="ModalPanel" CssClass="modalPopup" runat="server" Width="500px" 
                                                                Style="display: none" meta:resourcekey="ModalPanelResource1">
                                                                <table class="w-100p">
                                                                    <tr class="a-center">
                                                                        <td class="a-center w-100p">
                                                                            <asp:Panel ID="Panel2" runat="server" ScrollBars="Both" CssClass="h-300 w-100p" meta:resourcekey="Panel2Resource1">
                                                                                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataKeyNames="ProductID"
                                                                                    Font-Bold="False" Font-Names="Verdana" Font-Overline="False" Font-Size="9pt"
                                                                                    Font-Strikeout="False" Font-Underline="False" CssClass="w-100p" 
                                                                                    meta:resourcekey="gvProductsResource1">
                                                                                    <HeaderStyle CssClass="dataheader1" />
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="ProductName" HeaderText="Product" 
                                                                                            meta:resourcekey="BoundFieldResource4" />
                                                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                                                                            meta:resourcekey="BoundFieldResource5" />
                                                                                        <asp:BoundField DataField="BatchNo" HeaderText="BatchNo" 
                                                                                            meta:resourcekey="BoundFieldResource6" />
                                                                                        <asp:BoundField DataField="Rate" HeaderText="Amount" 
                                                                                            meta:resourcekey="BoundFieldResource7" />
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center">
                                                                            <asp:Button ID="OKButton" runat="server" Text="OK" 
                                                                                meta:resourcekey="OKButtonResource1" />
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                                <div id="divDebitNote" runat="server">
                                                    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                        <ContentTemplate>
                                                            <table class="w-100p dataheader2 defaultfontcolor" border="0" cellpadding="2"
                                                                cellspacing="0">
                                                                <tr  class="lh25">
                                                                    <td colspan="4">
                                                                        <div id="div1" runat="server">
                                                                            <table class="w-100p">
                                                                                <tr>
                                                                                    <td class="w-15p">
                                                                                    <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_03%>
                                                                                       
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:DropDownList ID="ddlDebitSupplierName" CssClass="medium" runat="server" 
                                                                                            meta:resourcekey="ddlDebitSupplierNameResource1">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                        
                                                                    </td>
                                                                </tr>
                                                                <tr  class="lh25">
                                                                    <td class="a-left w-15p">
                                                                        <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_04%>
                                                                    </td>
                                                                    <td class="w-20p">
                                                                        <asp:TextBox ID="txtDebitSRDNo" runat="server" CssClass="medium" 
                                                                            meta:resourcekey="txtDebitSRDNoResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td class="w-15p">
                                                                        <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_08%>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtStockReceivedDate" runat="server" CssClass="small datePicker" 
                                                                            meta:resourcekey="txtStockReceivedDateResource1"></asp:TextBox>
                                                                        <%--<ajc:MaskedEditExtender ID="txtStockReceivedDate_MaskedEditExtender" 
                                                                            runat="server" ErrorTooltipEnabled="True" Mask="99/99/9999"
                                                                            MaskType="Date" TargetControlID="txtStockReceivedDate" 
                                                                            CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" 
                                                                            CultureDateFormat="" CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                            CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImageButton1"
                                                                            TargetControlID="txtStockReceivedDate" Enabled="True" />
                                                                        <asp:ImageButton ID="ImageButton1" runat="server" CausesValidation="False" 
                                                                            ImageUrl="~/PlatForm/Images/Calendar_scheduleHS.png" 
                                                                            meta:resourcekey="ImageButton1Resource1" />
                                                                        <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="txtStockReceivedDate_MaskedEditExtender"
                                                                            ControlToValidate="txtStockReceivedDate" Display="Dynamic" EmptyValueBlurredText="*"
                                                                            EmptyValueMessage="Date is required" InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid"
                                                                            TooltipMessage="(dd-mm-yyyy)" ValidationGroup="MKE" 
                                                                            ErrorMessage="MaskedEditValidator1" 
                                                                            meta:resourcekey="MaskedEditValidator1Resource1" />--%>
                                                                    </td>
                                                                </tr>
                                                                <tr  class="lh25">
                                                                    <td align="left">
                                                                        <%=Resources.StockReturn_ClientDisplay.StockReturn_StockReturnPayment_aspx_06%>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="TextBox4" CssClass="medium" runat="server" meta:resourcekey="TextBox4Resource1"></asp:TextBox>
                                                                    </td>
                                                                    <td valign="middle" id="td2" runat="server" class="a-left">
                                                                       <asp:Button ID="btnDebitSearch" runat="server" Text="Search" CssClass="btn"
                                                                            onmouseover="this.className='btn btnhov'" 
                                                                            onmouseout="this.className='btn'" OnClick="btnDebitSearch_Click" 
                                                                            meta:resourcekey="btnDebitSearchResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                        <ContentTemplate>
                                                            <table>
                                                                
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label1" ForeColor="#000333" runat="server" 
                                                                            meta:resourcekey="Label1Resource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <asp:GridView ID="grdDebit" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                        CssClass="gridView" DataKeyNames="OrderID,SupplierID" OnPageIndexChanging="grdDebit_PageIndexChanging"
                                                                        OnRowCreated="grdDebit_OnRowCreated" OnRowDataBound="grdDebit_RowDataBound"
                                                                        Width="100%" meta:resourcekey="grdDebitResource1">
                                                                        <HeaderStyle CssClass="dataheader1" />
                                                                        <PagerStyle CssClass="dataheader1" />
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Select" 
                                                                                meta:resourcekey="TemplateFieldResource4">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkBox" runat="server" meta:resourcekey="chkBoxResource2" />
                                                                                </ItemTemplate>
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle Width="2%" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="OrderNo" HeaderText="Stock Received Number" 
                                                                                meta:resourcekey="BoundFieldResource8">
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="OrderDate" HeaderText="Stock Received Date" 
                                                                                meta:resourcekey="BoundFieldResource9">
                                                                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="SupplierName" HeaderText="Vendor" 
                                                                                meta:resourcekey="BoundFieldResource10">
                                                                                <ItemStyle HorizontalAlign="Center" Width="12%" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Amount" HeaderText="Actual Amount" 
                                                                                meta:resourcekey="BoundFieldResource11">
                                                                                <HeaderStyle HorizontalAlign="Left" />
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="ReferenceNo" 
                                                                                meta:resourcekey="TemplateFieldResource5">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtReferenceNo" Style="text-align: right;" runat="server" MaxLength="20"
                                                                                        Text='<%# Eval("ReferenceNo") %>' Width="60px" 
                                                                                        meta:resourcekey="txtReferenceNoResource2"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Debit Amount" 
                                                                                meta:resourcekey="TemplateFieldResource6">
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtDebitAmount" Style="text-align: right;" runat="server" MaxLength="20"
                                                                                        Text='<%# Eval("DebitAmount") %>' Width="60px" 
                                                                                        onkeydown="return validatenumber(event);" 
                                                                                        meta:resourcekey="txtDebitAmountResource1"></asp:TextBox>
                                                                                </ItemTemplate>
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </tr>
                                                                <caption>
                                                                    &nbsp;
                                                                    <tr>
                                                                        <td class="a-left">
                                                                            <asp:Button ID="btnUpdateDebit" runat="server" CssClass="btn" 
                                                                                OnClick="btnUpdateDebit_Click" onmouseout="this.className='btn'" 
                                                                                onmouseover="this.className='btn btnhov'" Text="Submit" 
                                                                                meta:resourcekey="btnUpdateDebitResource1" />
                                                                            &nbsp;
                                                                        </td>
                                                                        <td class="a-center">
                                                                            <asp:Button ID="btnCancelDebit" runat="server" CssClass="btn" 
                                                                                OnClick="btnCancel_Click" onmouseout="this.className='btn'" 
                                                                                onmouseover="this.className='btn btnhov'" Text="Cancel" 
                                                                                meta:resourcekey="btnCancelDebitResource1" />
                                                                        </td>
                                                                        <asp:Button ID="Button4" runat="server" CssClass="btn" 
                                                                            OnClick="btnHidden_Click" onmouseout="this.className='btn'" 
                                                                            onmouseover="this.className='btn btnhov'" Style="display: none" 
                                                                            Text="Cancel" meta:resourcekey="Button4Resource1" />
                                                                    </tr>
                                                                </caption>
                                                            </table>
                                                        </ContentTemplate>
                                                    </asp:UpdatePanel>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <input type="hidden" id="hdnFID" runat="server" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
