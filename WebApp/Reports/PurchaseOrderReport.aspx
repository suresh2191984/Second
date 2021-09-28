<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PurchaseOrderReport.aspx.cs"
    Inherits="Reports_PurchaseOrderReport" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PharmacyHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <%-- <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />--%>
    <title>Purchase Order Report</title>
    <%--<link href="../StyleSheets/style.css"  rel="Stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function CheckDates(splitChar) {
            var today = new Date();
            var now = today.getDate() + splitChar + (today.getMonth() + 1) + splitChar + today.getFullYear();
            if (document.getElementById('txtFrom').value == '') {
                alert('Select From Date!');
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('Select To Date!');
                return false;
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value.split(splitChar);
                DateTo = document.getElementById('txtTo').value.split(splitChar);
                DateNow = now.split(splitChar);
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date 
                if (doDateValidation(DateTo, DateNow, 0)) {
                    if (doDateValidation(DateFrom, DateTo, 1)) {
                        //alert("Validation Succeeded");

                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
        }
        function doDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                alert('Mismatch Day Between Current & To Date');
                            }
                            else {
                                alert('Mismatch Day Between From & To Date');
                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        alert('Mismatch Month Between Current & To Date');
                    }
                    else {
                        alert('Mismatch Month Between From & To Date');
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    alert('Mismatch Year Between Current & To Date');
                }
                else {
                    alert('Mismatch Year Between From & To Date');
                }
                return false;
            }
        }
        function onSearch() {
            var txt = document.getElementById('txtProduct').value;
            if (txt.trim() != "") {
                document.getElementById('btnSearch').click();
                document.getElementById('btnSearch').disabled = true;
            }
        }
        function CallPrint() {
            var prtContent = document.getElementById('divPrintarea');

            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }
        
    </script>

</head>
<body id="Body1" oncontextmenu="return false;" runat="server">
    <form id="prFrm" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MainHeader" runat="server" />
                <uc3:Header ID="ReceptionHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc1:LeftMenu ID="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/show.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <table class="dataheader2 defaultfontcolor" border="0" width="100%" cellpadding="2"
                            cellspacing="1">
                            <tr>
                                <td>
                                    <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td style="font-weight: bold">
                                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title"> </asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFrom" runat="server"  CssClass="Txtboxsmall" Width ="120px" TabIndex="1" MaxLength="1"
                                                    Style="text-align: justify" ValidationGroup="MKE" />
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                    ErrorTooltipEnabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                    ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" />
                                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                    PopupButtonID="ImageButton1" Format="dd/MM/yyyy" />
                                            </td>
                                            <td style="font-weight: bold">
                                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title"> </asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTo" runat="server" CssClass="Txtboxsmall" Width ="120px" TabIndex="2" MaxLength="1" Style="text-align: justify"
                                                    ValidationGroup="MKE" />
                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                    Mask="99/99/9999" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                    OnInvalidCssClass="MaskedEditError" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                                                    ErrorTooltipEnabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                    ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                    PopupButtonID="ImageButton2" Format="dd/MM/yyyy" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblPOID" runat="server" Text="PONO" Style="font-weight: bold"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPoid" runat="server" CssClass="Txtboxsmall" Width ="120px" ></asp:TextBox>
                                            </td>
                                            <td style="font-weight: bold">
                                                <asp:Label runat="server" ID="lblProduct" Text="Product Name" CssClass="label_title"> </asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                    <ContentTemplate>
                                                        <asp:TextBox ID="txtProduct" runat="server" CssClass="Txtboxsmall" Width ="120px" TabIndex="4"></asp:TextBox>
                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtProduct"
                                                            ServiceMethod="GetSearchProductList" ServicePath="~/InventoryWebService.asmx"
                                                            EnableCaching="false" BehaviorID="AutoCompleteExLstGrp11" MinimumPrefixLength="1"
                                                            CompletionInterval="10" CompletionListCssClass="listtwo" CompletionListHighlightedItemCssClass="hoverlistitemtwo"
                                                            CompletionListItemCssClass="listitemtwo" DelimiterCharacters=";,:" FirstRowSelected="false">
                                                        </ajc:AutoCompleteExtender>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="font-weight: bold">
                                                <asp:Label runat="server" ID="lblDepartment" Text="Department" CssClass="label_title"> </asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass ="ddlsmall" TabIndex="3">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" align="center">
                                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                    OnClientClick="javascript:return CheckDates('/')" TabIndex="5" OnClick="btnSearch_Click" />
                                                <%--<asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                        OnClick="lnkBack_Click" TabIndex="6">Back&nbsp;&nbsp;&nbsp;</asp:LinkButton>--%>
                                            </td>
                                        </tr>
                                    </table>
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="left" style="padding-right: 10px; color: #000000;">
                                                    <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="true" ForeColor="#333" runat="server"></asp:Label>
                                                    <asp:ImageButton ID="btnConverttoXL" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:Label ID="lblNoResult" Text="No Results." Font-Bold="true" ForeColor="#333"
                                        Style="display: none;" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <td >
                                    <div id="divPrintarea" runat="server">
                                        <asp:GridView ID="GrdPrhOrder" runat="server" Width="100%" GridLines="Both" AutoGenerateColumns="false"
                                            OnRowDataBound="GrdPrhOrder_RowDataBound" PageSize="5" OnPageIndexChanging="GrdPrhOrder_PageIndexChanging"
                                            AllowPaging="true">
                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="PO Number">
                                                    <ItemTemplate>
                                                        <table  style="border-collapse: collapse;" cellspacing="3"
                                                            border="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <table width="100%">
                                                                        <tr class="Duecolor">
                                                                            <td align="left" forecolor="#333333">
                                                                                <asp:Label ID="lblPOID" runat="server" Text='<%# Eval("PurchaseOrderNo") %>'></asp:Label>
                                                                            </td>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="GrdChild" runat="server" AutoGenerateColumns="false" Width="100%"
                                                                        CssClass="mytable1" PageSize="5" ForeColor="#333333" PagerSettings-Mode="NextPrevious">
                                                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                                                        <Columns>
                                                                            <asp:BoundField DataField="Status" HeaderText="Product Name">
                                                                            <headerstyle horizontalalign="center"></headerstyle>
                                                                            <itemstyle horizontalalign="left" width="20%"></itemstyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ModifiedBy" HeaderText="Quantity">
                                                                              <headerstyle horizontalalign="center"></headerstyle>
                                                                              <itemstyle horizontalalign="left" width="10%"></itemstyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="ReceivableLocation" HeaderText="Location" >
                                                                              <headerstyle horizontalalign="center"></headerstyle>
                                                                            <itemstyle horizontalalign="left" width="20%"></itemstyle>
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Comments" HeaderText="DeliveryOrg" >
                                                                              <headerstyle horizontalalign="center"></headerstyle>
                                                                            <itemstyle horizontalalign="left" width="20%"></itemstyle>
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                    </asp:GridView>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
