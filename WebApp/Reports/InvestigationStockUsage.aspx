<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InvestigationStockUsage.aspx.cs"
    Inherits="Reports_InvestigationStockUsage" meta:resourcekey="PageResource1" %>

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
    <title>
        <%--Stock Issued Report--%><%=Resources.Reports_ClientDisplay.Reports_InvestigationStockUsage_aspx_005 %>
    </title>
    <%--<link href="../StyleSheets/style.css"  rel="Stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
       <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        function CheckDates(splitChar) {
            var AlrtWinHdr = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_02") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_01") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_01") : "Select From Date!";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_03") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_03") : "Select To Date!";
            var today = new Date();
            var now = today.getDate() + splitChar + (today.getMonth() + 1) + splitChar + today.getFullYear();
            if (document.getElementById('txtFrom').value == '') {
                //alert('Select From Date!');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                // alert('Select To Date!');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
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
            var AlrtWinHdr = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_02") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_02") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_04") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_04") : "Mismatch Day Between Current & To Date";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_05") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_05") : "Mismatch Day Between From & To Date";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_06") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_06") : "Mismatch Month Between Current & To Date";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_07") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_07") : "Mismatch Month Between From & To Date";
            var UsrAlrtMsg4 = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_08") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_08") : "Mismatch Year Between Current & To Date";
            var UsrAlrtMsg5 = SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_09") != null ? SListForAppMsg.Get("Reports_InvestigationStockUsage_aspx_09") : "Mismatch Year Between From & To Date";
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
                                //alert('Mismatch Day Between Current & To Date');
                                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                            }
                            else {
                                //alert('Mismatch Day Between From & To Date');
                                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
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
                        //alert('Mismatch Month Between Current & To Date');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    }
                    else {
                        //                        alert('Mismatch Month Between From & To Date');
                        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    //alert('Mismatch Year Between Current & To Date');
                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                }
                else {
                    //alert('Mismatch Year Between From & To Date');
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                }
                return false;
            }
        }
        //        function onSearch() {
        //            var txt = document.getElementById('txtProduct').value;
        //            if (txt.trim() != "") {
        //                document.getElementById('btnSearch').click();
        //                document.getElementById('btnSearch').disabled = true;
        //            }
        //        }
        function CallPrint() {
            var prtContent = document.getElementById('Printdata');

            var WinPrint =
                        window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,sta­tus=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;
        }

        function getdeviceid() {
            var deviceid = document.getElementById('drpDevices').value;
            document.getElementById('hdnDeviceID').value = deviceid;
            $find('AutoInvName').set_contextKey(deviceid);
        }

        function fnSelectedInventory(source, eventArgs) {
            var lis = eventArgs.get_value();
            AddInventoryDetails(lis);
        }
        function AddInventoryDetails(obj) {

            var p = obj.split('~');
            if (p.lenght != 0) {
                document.getElementById('txtInvName').value = p[0];
                document.getElementById('hdnInvID').value = p[1];
            }
            else {
                document.getElementById('hdnInvID').value = '0';
            }

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
                <td width="15%" valign="top" id="menu" style="display: none;">
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
                                                <asp:Label runat="server" ID="fromDate" Text="From" CssClass="label_title" meta:resourcekey="fromDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtFrom" runat="server" CssClass ="Txtboxsmall" Width ="120px" TabIndex="1" MaxLength="1"
                                                    Style="text-align: justify" ValidationGroup="MKE" meta:resourcekey="txtFromResource1" />
                                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                    ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                    PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                                            </td>
                                            <td style="font-weight: bold">
                                                <asp:Label runat="server" ID="toDate" Text="To" CssClass="label_title" meta:resourcekey="toDateResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTo" runat="server" CssClass ="Txtboxsmall" Width ="120px" TabIndex="2" MaxLength="1" Style="text-align: justify"
                                                    ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                    CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />
                                                <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                    Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                    CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                    CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                    CultureTimePlaceholder="" Enabled="True" />
                                                <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                    ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                    Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                    ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource1" />
                                                <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                    PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                                            </td>
                                            <td width="28%">
                                                <%--Product Name--%><%=Resources.Reports_ClientDisplay.Reports_InvestigationStockUsage_aspx_001 %>
                                                <asp:TextBox ID="txtProduct" runat="server" Style="margin-left: 0px" CssClass="Txtboxmedium"
                                                    meta:resourcekey="txtProductResource1"></asp:TextBox>
                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server"
                                                        TargetControlID="txtProduct" ServiceMethod="GetSearchProductList" ServicePath="~/InventoryWebService.asmx"
                                                        EnableCaching="false" MinimumPrefixLength="1" CompletionInterval="10" CompletionListCssClass="listtwo"
                                                        CompletionListHighlightedItemCssClass="hoverlistitemtwo" CompletionListItemCssClass="listitemtwo"
                                                        DelimiterCharacters=";,:" FirstRowSelected="false">
                                                    </ajc:AutoCompleteExtender>
                                                </td>
                                                <td width="28%">
                                                <%--Department--%>
                                                <%=Resources.Reports_ClientDisplay.Reports_InvestigationStockUsage_aspx_002 %>
                                                &nbsp;&nbsp;
                                                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddlmedium" TabIndex="4" Style="margin-left: 0px">
                                                    </asp:DropDownList>
                                                </td>
                                        </tr>
                                        <tr >
                                            <td style="font-weight: bold">
                                                <asp:Label ID="lableDeviceName" runat="server" Text="DeviceName" meta:resourcekey="lableDeviceNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                             <asp:DropDownList ID="drpDevices" runat="server" Width="150px" CssClass="bilinvddltb"
                                                onchange="getdeviceid();">
                                            </asp:DropDownList>
                                            <input id="hdnDeviceID" runat="server" type="hidden" value="0" />
                                           
                                            </td>
                                            <td style="font-weight: bold">
                                                <asp:Label ID="LabelInvestigationName" runat="server" Text="Investigation Name" meta:resourcekey="LabelInvestigationNameResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtInvName" runat="server" TabIndex="2" meta:resourcekey="txtInvNameResource1" />
                                                            <ajc:AutoCompleteExtender ID="AutoInvName" runat="server" TargetControlID="txtInvName"
                                                                ServiceMethod="GetInventoryList" ServicePath="~/WebService.asmx" EnableCaching="false"
                                                                MinimumPrefixLength="2" OnClientItemSelected="fnSelectedInventory" CompletionInterval="10"
                                                                DelimiterCharacters=";,:" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected">
                                                            </ajc:AutoCompleteExtender>
                                           <input id="hdnInvID" runat="server" type="hidden" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3" align="center">
                                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                    OnClientClick="javascript:return CheckDates('/')" TabIndex="5" OnClick="btnSearch_Click"
                                                    meta:resourcekey="btnSearchResource1" />
                                            
                                            </td>
                                             <td id="tdExcel" runat="server" style="display:none">
                                                                <asp:ImageButton ID="imgBtnXL" OnClick="imgBtnXL_Click" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                    ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                                                <asp:LinkButton ID="lnkExportXL" OnClick="imgBtnXL_Click" runat="server" Font-Bold="true"
                                                    Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel" meta:resourcekey="lnkExportXLResource1"><u><%--Export To XL--%>	<%=Resources.Reports_ClientDisplay.Reports_InvestigationStockUsage_aspx_003 %> </u></asp:LinkButton>
                                                                &nbsp;&nbsp;
                                                                <asp:ImageButton ID="imgBtnPrint" runat="server" ImageUrl="../Images/printer.GIF"
                                                    ToolTip="Click Here To Print Supplier Details" OnClientClick="return CallPrint();"
                                                    meta:resourcekey="imgBtnPrintResource1" />
                                                <asp:LinkButton ID="lnkPrint" runat="server" Font-Bold="True" OnClientClick="return CallPrint();"
                                                    Font-Size="12px" ForeColor="Black" ToolTip="Click Here To Print Stock Details"
                                                    meta:resourcekey="lnkPrintResource1"><u><%--Print--%>	<%=Resources.Reports_ClientDisplay.Reports_InvestigationStockUsage_aspx_004 %> </u></asp:LinkButton>
                                             </td>
                                        </tr>
                                    </table>
                                    <div id="divPrint" style="display: none;" runat="server">
                                        <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                                <td align="left" style="padding-right: 10px; color: #000000;">
                                                    <asp:Label ID="lbExcel" Text="Excel Report" Font-Bold="True" ForeColor="#000333"
                                                        runat="server" meta:resourcekey="lbExcelResource1"></asp:Label>
                                                    <asp:ImageButton ID="btnConverttoXL" runat="server" ImageUrl="~/Images/ExcelImage.GIF"
                                                        meta:resourcekey="btnConverttoXLResource1" />
                                                </td>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
                                                    <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return CallPrint();"
                                                        ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:Label ID="lblNoResult" Text="No Results." Font-Bold="True" ForeColor="#000333"
                                        Style="display: none;" runat="server" meta:resourcekey="lblNoResultResource1"></asp:Label>
                        
                            </tr>
                            <tr>
                            
                             <td class="dataheader2">
                                 
                                <div id="Printdata" >   
                                      
                                    <asp:GridView ID="grdResult" EmptyDataText="No Results Found." runat="server" CssClass="mytable1"
                                        AutoGenerateColumns="False" ShowFooter="false" Width="100%" meta:resourcekey="grdResultResource1">
                                        <HeaderStyle CssClass="dataheader1" />
                                        <RowStyle HorizontalAlign="Right" Font-Size="10px" />
                                        <Columns>
                                            <asp:BoundField HeaderText="Investigation Name" DataField="InvestigationName" meta:resourcekey="BoundFieldResource1" />
                                                <asp:BoundField HeaderText="TestCount" DataField="InvestigationQty" meta:resourcekey="BoundFieldResource2" />
                                            <asp:BoundField HeaderText="ProductName" DataField="ProductName" meta:resourcekey="BoundFieldResource3" />
                                                <asp:BoundField HeaderText="Estimated Quantity" DataField="EstimateQty" meta:resourcekey="BoundFieldResource4" />
                                                <asp:BoundField HeaderText="Buffer Quantity" DataField="BufferQty" meta:resourcekey="BoundFieldResource5" />
                                                <asp:BoundField HeaderText="Actual Quantity" DataField="ActualQty" meta:resourcekey="BoundFieldResource6" />
                                                <asp:BoundField HeaderText="Usage Quantity" DataField="UsedQty" meta:resourcekey="BoundFieldResource7" />
                                                <asp:BoundField HeaderText="Unit" DataField="eunits" meta:resourcekey="BoundFieldResource8" />
                                        </Columns>
                                       </asp:GridView>
                                       <%-- <asp:GridView ID="GridView1" runat="server"
                                        AutoGenerateColumns="False"  
                                        BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                                        GridLines="Horizontal" ForeColor="Black" 
                                        Height="119px"
                                        OnDataBound="GridView1_DataBound1"> 
                                        <RowStyle HorizontalAlign="Right" Font-Size="10px" />
                                        <Columns>
                                            <asp:BoundField HeaderText="Investigation Name" DataField="InvestigationName" />
                                            <asp:BoundField HeaderText="Investigation Qty" DataField="InvestigationQty" />
                                            <asp:BoundField HeaderText="ProductName" DataField="ProductName" />
                                            <asp:BoundField HeaderText="Estimated Qty" DataField="EstimateQty" />
                                            <asp:BoundField HeaderText="Buffer Qty" DataField="BufferQty" />
                                            <asp:BoundField HeaderText="Actual Qty" DataField="ActualQty" />
                                            <asp:BoundField HeaderText="Used Qty" DataField="UsedQty" />
                                        </Columns>
                                        </asp:GridView>--%>
                                    </div>
           
                                </td>
                             
                               
                            </tr>
                             
                         
                    </div>
                </td>
            </tr>
        </table>
    </div>

    <uc5:Footer ID="Footer1" runat="server" />

    </form>
</body>
</html>
