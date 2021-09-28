<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvoiceMapping.aspx.cs" Inherits="StockReceived_InvoiceMapping"
    meta:resourcekey="PageResource1"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc6" %>
<%@ Register Src="~/InventoryCommon/Controls/INVAttributes.ascx" TagName="INVAttributes"
    TagPrefix="uc2" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Invoice Mapping </title>
    <style type="text/css">
        .Align
        {
            text-align: right;
        }
    </style>
    <%--<link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />--%>

    <%--<script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>--%>

    <%-- <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>--%>

    

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader ID="Attuneheader" runat="server" />
    
    <div class="contentdata">
<%--        <ul>
            <li>
                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <table class="w-100p searchPanel">
            <tr>
                <td>
                    <div id="DivSupplier" runat="server">
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:HiddenField ID="hdnsupllierid" runat="server" />
                                <table class="dataheader2 defaultfontcolor w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Rs_SupplierName" Text="Supplier Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtSupplierName" onkeypress="return ValidateMultiLangChar(this);" CssClass="small" runat="server" meta:resourcekey="txtSupplierNameResource1"></asp:TextBox>
                                            <ajc:autocompleteextender id="AutoCompleteExtender1" runat="server" targetcontrolid="txtSupplierName"
                                                enablecaching="False" minimumprefixlength="1" completioninterval="1" firstrowselected="True"
                                                onclientitemselected="GetSupplierID" completionlistcssclass="wordWheel listMain .box"
                                                completionlistitemcssclass="wordWheel itemsMain" completionlisthighlighteditemcssclass="wordWheel itemsSelected"
                                                servicemethod="GetSupplierList" servicepath="~/InventoryCommon/WebService/InventoryWebService.asmx" delimitercharacters=""
                                                enabled="True">
                                            </ajc:autocompleteextender>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_StockReceivedNumber" Text="Stock Received Number" runat="server"
                                                meta:resourcekey="Rs_StockReceivedNumberResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtStockReceivedNumber" onkeypress="return ValidateMultiLangChar(this);" runat="server" CssClass="small" meta:resourcekey="txtStockReceivedNumberResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_StockReceivedDateFrom" Text="Stock Received Date From :" runat="server"
                                                meta:resourcekey="Rs_StockReceivedDateFromResource1" />
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtFDate" runat="server" CssClass="datePicker" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                            <%--<ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgFDate"
                                                TargetControlID="txtFDate" Enabled="True" />
                                            <asp:ImageButton ID="ImgFDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                meta:resourcekey="ImgFDateResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" ErrorTooltipEnabled="True"
                                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtFDate" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                ControlToValidate="txtFDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />--%>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_To" Text="To :" runat="server" meta:resourcekey="Rs_ToResource1" />
                                        </td>
                                        <td class="a-left">
                                            <asp:TextBox ID="txtTDate" runat="server" CssClass="datePicker" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                           <%-- <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgTDate"
                                                TargetControlID="txtTDate" Enabled="True" />
                                            &nbsp;
                                            <asp:ImageButton ID="ImgTDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                meta:resourcekey="ImgTDateResource1" />
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" ErrorTooltipEnabled="True"
                                                Mask="99/99/9999" MaskType="Date" TargetControlID="txtTDate" CultureAMPMPlaceholder=""
                                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                                Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                ControlToValidate="txtTDate" Display="Dynamic" EmptyValueBlurredText="*" EmptyValueMessage="Date is required"
                                                InvalidValueBlurredMessage="*" InvalidValueMessage="Date is invalid" TooltipMessage="(dd-mm-yyyy)"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_InvoiceNumber" Text="Invoice Number" runat="server" meta:resourcekey="Rs_InvoiceNumberResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtInvoiceNo" runat="server" onkeypress="return ValidateMultiLangChar(this);" CssClass="small" meta:resourcekey="txtInvoiceNoResource1"></asp:TextBox>
                                        </td>
                                        <td class="a-left">
                                            <asp:Label ID="Rs_DCNumber" Text="DC Number" runat="server" meta:resourcekey="Rs_DCNumberResource1" />
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDCNo" runat="server" onkeypress="return ValidateMultiLangChar(this);" CssClass="small" meta:resourcekey="txtDCNoResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center" colspan="4">
                                            <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClick="btnSearch_Click" OnClientClick="javascript:return validateToDate();"
                                                meta:resourcekey="btnSearchResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="4" class="a-center">
                                            <asp:UpdateProgress ID="Progressbar" runat="server">
                                                <ProgressTemplate>
                                                    <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                                    <asp:Label ID="LBPLSWAIT" runat="server" Text="Please wait...." meta:resourcekey="LBPLSWAITResource1"></asp:Label>
                                                </ProgressTemplate>
                                            </asp:UpdateProgress>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-100p" cellpadding="2" cellspacing="1">
                                    <tr>
                                        <td>
                                            <div id="divgrdResult">
                                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" CssClass="gridView w-100p"
                                                    DataKeyNames="OrderID" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                                    <HeaderStyle CssClass="gridHeader" />
                                                    <PagerStyle CssClass="gridPager" />
                                                    <Columns>
                                                        <asp:TemplateField Visible="false" HeaderText="PurChase Order" 
                                                            meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPurchaseOrder" runat="server" 
                                                                    Text='<%# Eval("PurchaseOrderID") %>' 
                                                                    ></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                            <ItemTemplate>
                                                                <%# Container.DisplayIndex + 1 %>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Supplier Name" meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:DropDownList ID="ddsn" runat="server" CssClass="ddl" meta:resourcekey="ddsnResource1">
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SRD Date" meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtStockDate" runat="server" CssClass="datePicker" onkeypress="return ValidateSpecialAndNumeric(this);" Text='<%#((DateTime)DataBinder.Eval(Container.DataItem,"StockReceivedDate")).ToString(DateTimeFormat) %>'
                                                                    Width="80px" onblur="return validdatechk(this.id);"></asp:TextBox>
                                                               <%-- <ajc:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" PopupButtonID="txtStockDate"
                                                                    TargetControlID="txtStockDate" Enabled="True" />--%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Invoice Date" 
                                                            meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtInvoiceDate" runat="server" CssClass="datePicker" ReadOnly="true" onkeypress="return ValidateSpecialAndNumeric(this);" Text='<%#((DateTime)DataBinder.Eval(Container.DataItem,"InvoiceDate")).ToString(DateTimeFormat) %>'
                                                                    Width="80px" onblur="validdatechk(this.id);CheckInvoiceDateSame(this.id);" 
                                                                    Enabled="False" ></asp:TextBox>
                                                                <%--<ajc:CalendarExtender ID="CalendarExtender48" runat="server" Format="dd/MM/yyyy"
                                                                    PopupButtonID="txtInvoiceDate" TargetControlID="txtInvoiceDate" Enabled="True" />--%>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="SRDNo" HeaderText="SRD No." meta:resourcekey="BoundFieldResource1">
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="DC Number" meta:resourcekey="TemplateFieldResource4">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtDCNo" onkeypress="return ValidateMultiLangChar(this);" CssClass="small w-80 a-right" runat="server"
                                                                    MaxLength="25" Text='<%# Eval("DCN0") %>' ></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Invoice Number" meta:resourcekey="TemplateFieldResource5">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtInvNo" onkeypress="return ValidateMultiLangChar(this);" CssClass="small w-80 a-right" runat="server"
                                                                    MaxLength="25" Text='<%# Eval("InvoiceNo") %>' 
                                                                    OnBlur="CheckInvoiceDate(this)"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                    </Columns>
                                                </asp:GridView>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <br />
                                            <asp:Button ID="btnUpdate" Text="Update" runat="server"
                                                CssClass="btn" OnClick="btnsaveDC_Click" Visible="False"
                                                meta:resourcekey="btnUpdateResource1" OnClientClick="javascript:return CheckSaveDateValdiation();" />
                                            &nbsp;
                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="cancel-btn" OnClick="btnCancel_Click" Visible="False" meta:resourcekey="btnCancelResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <attune:attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <script type="text/javascript">
        function CheckInvoiceDate() {
            $("#divgrdResult table tr").each(function() {
                var Medtr = $(this).closest("tr");
                if ($(Medtr).find("input:text[id$=txtInvNo]").val() != undefined && $(Medtr).find("input:text[id$=txtInvNo]").val() != "") {
                    $(Medtr).find("input:text[id$=txtInvoiceDate]").attr('disabled', false);
                } else {
                    $(Medtr).find("input:text[id$=txtInvoiceDate]").val("");
                    $(Medtr).find("input:text[id$=txtInvoiceDate]").attr('disabled', true);
                }
            });
        }
        function CheckInvoiceDateSame(id) {
            var InvoiceDate = $('#' + id).val();
            var InvNo = '';
            $("#divgrdResult table tr").each(function() {
                var Medtr = $(this).closest("tr");
                if ($(Medtr).find("input:text[id$=txtInvoiceDate]").val() == InvoiceDate) {
                    InvNo = $(Medtr).find("input:text[id$=txtInvNo]").val();

                    $("#divgrdResult table tr").each(function() {
                        var tr = $(this).closest("tr");
                        if ($(tr).find("input:text[id$=txtInvNo]").val() == InvNo) {
                            $(tr).find("input:text[id$=txtInvoiceDate]").val(InvoiceDate);
                        }
                    });
                }
            });

        }

        function CheckSaveDateValdiation(id) {
            var Check = 0;
            $("#divgrdResult table tr").each(function() {
                var tr = $(this).closest("tr");
                if ($(tr).find("input:text[id$=txtInvNo]").val() != '') {
                    if ($(tr).find("input:text[id$=txtInvoiceDate]").val() == '') {
                        Check = 1;
                    }
                }
            });

            if (Check == 1) {
                userMsg = SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_04") == null ? "Please Enter a Invoice 3..." : SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_04");
                ValidationWindow(userMsg,errorMsg);
                return false;
            }
            else {
                return true;
            }
        }

    </script>

    </form>
    
    <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("StockReceived_Error") != null ? SListForAppMsg.Get("StockReceived_Error") : "Alert";
        var InformationMsg = SListForAppMsg.Get("StockReceived_Information") != null ? SListForAppMsg.Get("StockReceived_Information") : "Information";
        var okMsg = SListForAppMsg.Get("StockReceived_Ok") != null ? SListForAppMsg.Get("StockReceived_Ok") : "Ok";
        var CancelMsg = SListForAppMsg.Get("StockReceived_Cancel") != null ? SListForAppMsg.Get("StockReceived_Cancel") : "Cancel";
   </script>
    
    <script language="javascript" type="text/javascript">
        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            var struserMsg1 = SListForAppDisplay.Get("StockReceived_InvoiceMapping_aspx_05") == null ? "No matching Records Found!" : SListForAppDisplay.Get("StockReceived_InvoiceMapping_aspx_05");
            var struserMsg2 = SListForAppDisplay.Get("StockReceived_InvoiceMapping_aspx_06") == null ? "Supplier/Invoice/DCNO UPDated Suceefully!" : SListForAppDisplay.Get("StockReceived_InvoiceMapping_aspx_06");
            var struserMsg3 = SListForAppDisplay.Get("StockReceived_InvoiceMapping_aspx_07") == null ? "Updation failed." : SListForAppDisplay.Get("StockReceived_InvoiceMapping_aspx_07");
            if (userMsg != null) {
                alert(userMsg);
            }
            else if (key == struserMsg1) {
                ValidationWindow(struserMsg1, errorMsg);
            }

            else if (struserMsg2) {
                ValidationWindow(struserMsg1, errorMsg);
            }
            else if (key == struserMsg3) {
                ValidationWindow(struserMsg1, errorMsg);
            }

            return true;
        }
        var userMsg;
        function GetSupplierID(source, eventArgs) {
            document.getElementById('hdnsupllierid').value = eventArgs.get_value();
        }


        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                userMsg = SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_01") == null ? "Provide / select value for From date" : SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_01");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtFDate').focus();
                    return false;
                }
            }
            if (document.getElementById('txtTDate').value == '') {
                userMsg = SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_02") == null ? "Provide / select value for To date" : SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_02");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtTDate').focus();
                    return false;
                }
            }
        }

        function validdatechk(id) {

            var textid = document.getElementById(id).value == '' ? '' : document.getElementById(id).value;
            if (textid == '__/__/____' || textid == '') {
                userMsg = SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_03") == null ? "Provide / select value for To date" : SListForAppMsg.Get("StockReceived_InvoiceMapping_aspx_03");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            }
            return true;
        }

    </script>
    
</body>
</html>
