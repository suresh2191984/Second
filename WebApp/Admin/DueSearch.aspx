<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DueSearch.aspx.cs" Inherits="Admin_DueSearch" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="Header" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="AdminHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Due Reports</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function ValidateDate() {

            if (document.getElementById('txtFrom').value == '') {

                alert('Select from date and to date');
                return false;
            }
            else if (document.getElementById('txtTo').value == '') {
                alert('Select from date and to date');
                return false;

            }
            else {
                return checkFromDateToDate('txtFrom', 'txtTo');
            }
            //            else if (document.getElementById('txtTo').value == '') {
            //                alert('Select from Date and to date');
            //                return false;

            //            }
            //            else {
            //                return checkFromDateToDate('txtFrom', 'txtTo');
            //            }

        }
        
           
    </script>

    <style type="text/css">
        .style1
        {
            width: 135px;
        }
        .style2
        {
            width: 123px;
        }
        .style3
        {
            width: 112px;
        }
        .style4
        {
            width: 175px;
        }
        .style5
        {
            width: 133px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btnGo" defaultfocus="ddlClient">
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
                <uc2:Header ID="Header2" runat="server" />
                <uc7:AdminHeader ID="AdminHeader" runat="server" />
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                    <div id="navigation">
                        <uc3:leftmenu id="LeftMenu1" runat="server" />
                    </div>
                </td>
                <td width="85%" valign="top" class="tdspace">
                     <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu" style="Cursor:pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata">
                        <ul>
                            <li>
                                <uc5:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="32">
                                    <table border="0" id="mytable1" cellpadding="4" cellspacing="0" width="100%">
                                        <tr>
                                            <td colspan="5" id="us">
                                               <asp:Label ID="Rs_LookupforDueDetails" Text="Look up for Due Details" 
                                                    runat="server" meta:resourcekey="Rs_LookupforDueDetailsResource1"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div>
                                        <asp:Panel runat="server" CssClass="dataheader2" ID="pnlDate" Width="99%" 
                                            meta:resourcekey="pnlDateResource1">
                                            <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="height: 5px;">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table border="0" width="100%" cellpadding="4" cellspacing="0">
                                                            <tr>
                                                                <td align="right" style="width: 13%">
                                                                    <asp:Label runat="server" ID="fromDate" Text="From Date" CssClass="label_title" 
                                                                        meta:resourcekey="fromDateResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 37%;">
                                                                    <asp:TextBox ID="txtFrom" runat="server" CssClass ="Txtboxsmall" TabIndex="4" MaxLength="1"
                                                                        Style="text-align: justify" ValidationGroup="MKE" 
                                                                        meta:resourcekey="txtFromResource1" />
                                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" meta:resourcekey="ImageButton1Resource1" />
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFrom"
                                                                        Mask="99/99/9999" MaskType="Date"
                                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                                                        ControlToValidate="txtFrom" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                                                                        meta:resourcekey="MaskedEditValidator1Resource1" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFrom"
                                                                        PopupButtonID="ImageButton1" Format="dd/MM/yyyy" Enabled="True" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                                <td align="right" style="width: 13%; display: block;">
                                                                    <asp:Label runat="server" ID="toDate" Text="To Date" CssClass="label_title" 
                                                                        meta:resourcekey="toDateResource1"></asp:Label>
                                                                </td>
                                                                <td style="width: 37%; display: block;">
                                                                    <asp:TextBox ID="txtTo" runat="server"  CssClass ="Txtboxsmall" TabIndex="5" MaxLength="1" Style="text-align: justify"
                                                                        ValidationGroup="MKE" meta:resourcekey="txtToResource1" />
                                                                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" meta:resourcekey="ImageButton2Resource1" />
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtTo"
                                                                        Mask="99/99/9999" MaskType="Date"
                                                                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                                                                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                                                                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                                                        ControlToValidate="txtTo" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" 
                                                                        meta:resourcekey="MaskedEditValidator2Resource1" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtTo"
                                                                        PopupButtonID="ImageButton2" Format="dd/MM/yyyy" Enabled="True" />
                                                                    &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                  <asp:Label ID="Rs_SelectType" Text="Select Type" runat="server" 
                                                                        meta:resourcekey="Rs_SelectTypeResource1"></asp:Label>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="ddlType" runat="server"  CssClass ="ddlsmall"
                                                                        meta:resourcekey="ddlTypeResource1">
                                                                        <asp:ListItem Selected="True" Text="Pending Dues" Value="Pending" 
                                                                            meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                        <asp:ListItem Text="Cleared Dues" Value="Cleared" 
                                                                            meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <center>
                                                            <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return ValidateDate();"
                                                                OnClick="btnGo_Click" meta:resourcekey="btnGoResource1" Width="39px" />
                                                            &nbsp;
                                                            <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                                                onmouseout="this.className='btn1'" OnClick="btnCancel_Click" 
                                                                meta:resourcekey="btnCancelResource1" />
                                                        </center>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="height: 5px;">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
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
                                <td colspan="2">
                                    <table id="orgHeaderTab" runat="server" cellpadding="0" cellspacing="0" border="0"
                                        width="100%">
                                        <tr>
                                            <td id="orgHeaderTextForReport" colspan="2" align="center" runat="server" style="color: #000000;
                                                font-size: 12px; font-weight: bold;">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="dateTextForReport" align="left" runat="server" style="color: #000000; font-size: 11px;
                                                font-weight: bold; padding-top: 20px;">
                                            </td>
                                            <td>
                                                <div id="divPrintExcel" runat="server" style="display: block; padding-top: 20px;">
                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                        <tr>
                                                            <td align="right" style="padding-right: 25px;">
                                                                <asp:HyperLink ID="hypLnkPrint" ImageUrl="~/Images/printer.gif" ToolTip="Print" Visible="False"
                                                                    Target="ReportWindow" runat="server" 
                                                                    meta:resourcekey="hypLnkPrintResource1"></asp:HyperLink>
                                                                <label id="dispLabel" runat="server" visible="false" style="color: #000;">
                                                                    <asp:Label ID="Rs_Info" Text="Print Report/Export To Excel" runat="server"></asp:Label></label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <br />
                                    <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                        CellPadding="4" Font-Size="10px" CssClass="mytable1" DataKeyNames="BillID" 
                                        ForeColor="#333333" OnRowDataBound="grdResult_RowDataBound" PagerSettings-Mode="NextPrevious"
                                        Width="99%" OnPageIndexChanging="grdResult_PageIndexChanging" 
                                        meta:resourcekey="grdResultResource1">
                                        <PagerTemplate>
                                            <tr>
                                                <td align="center" colspan="7">
                                                    <asp:ImageButton ID="lnkPrev" runat="server" CausesValidation="False" CommandArgument="Prev"
                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/previousimage.png" 
                                                        Width="18px" meta:resourcekey="lnkPrevResource1" />
                                                    <asp:ImageButton ID="lnkNext" runat="server" CausesValidation="False" CommandArgument="Next"
                                                        CommandName="Page" Height="18px" ImageUrl="~/Images/nextimage.png" 
                                                        Width="18px" meta:resourcekey="lnkNextResource1" />
                                                </td>
                                            </tr>
                                        </PagerTemplate>
                                        <HeaderStyle CssClass="dataheader1" />
                                        <PagerSettings Mode="NextPrevious"></PagerSettings>
                                        <Columns>
                                            <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" 
                                                meta:resourcekey="BoundFieldResource1" />
                                            <asp:TemplateField HeaderText="Bill No" ItemStyle-HorizontalAlign="Center" 
                                                ItemStyle-Width="13%" meta:resourcekey="TemplateFieldResource1">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lnkBillID" Font-Bold="True" Font-Size="10px" NavigateUrl='<%# Eval("BillID", "PrintBill.aspx?billNo={0}") %>'
                                                        Text='<%# Bind("BillID") %>' Font-Underline="True" ToolTip="Click To View & Print Bill"
                                                        ForeColor="Black" Target="BillWindow" runat="server" 
                                                        meta:resourcekey="lnkBillIDResource1"></asp:HyperLink>
                                                </ItemTemplate>

                                                 <ItemStyle HorizontalAlign="Center" Width="13%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Ref Bill No" ItemStyle-HorizontalAlign="Center" 
                                                ItemStyle-Width="13%" meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:HyperLink ID="lnkBillID1" Font-Bold="True" Font-Size="10px" NavigateUrl='<%# Eval("ReferenceBillID", "PrintBill.aspx?billNo={0}") %>'
                                                        Text='<%# Bind("ReferenceBillID") %>' Font-Underline="True" ToolTip="Click To View & Print Reference Bill"
                                                        ForeColor="Black" Target="BillWindow" runat="server" 
                                                        meta:resourcekey="lnkBillID1Resource1"></asp:HyperLink>
                                                </ItemTemplate>

                                                 <ItemStyle HorizontalAlign="Center" Width="13%"></ItemStyle>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                HeaderText="Bill Date" ItemStyle-HorizontalAlign="Left" 
                                                ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource2">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="25%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Name" HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="20%" 
                                                meta:resourcekey="BoundFieldResource3">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="30%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Age" HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                ItemStyle-HorizontalAlign="Left" Visible="true" 
                                                meta:resourcekey="BoundFieldResource4">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="12%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderStyle-HorizontalAlign="Left" HeaderText="Due Status"
                                                ItemStyle-HorizontalAlign="Left" Visible="true" ItemStyle-Width="15%" 
                                                meta:resourcekey="BoundFieldResource5">
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="AmountDue" DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                HeaderText="Due Amount" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                Visible="true" meta:resourcekey="BoundFieldResource6">
                                                <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                <ItemStyle HorizontalAlign="Right" Width="15%"></ItemStyle>
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table border="0" id="tabGranTotal1" runat="server" visible="false" class="dataheaderInvCtrl"
                            cellpadding="5" style="color: #000000;" cellspacing="0" width="99%">
                            <tr>
                                <td align="right" style="width: 80%;">
                                  <asp:Label ID="Rs_TotalAmount" Text="Total Amount" runat="server" 
                                        meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                </td>
                                <td align="right" style="padding-right: 5px;">
                                    <label id="lblGrandTotal" runat="server">
                                    </label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
        <uc4:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
