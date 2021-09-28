<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CollectionRptDptWiseOPIPDetails.aspx.cs"
    Inherits="Reports_CollectionRptDptWiseOPIPDetails" meta:resourcekey="PageResource1" %>

<%@ Register Src="~/CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="~/CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/datetimepicker.css" rel="stylesheet" type="text/css">
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtTDate').value == '') {
                alert('Provide / select value for To date');
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

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div class="middleheader">
                <uc4:MainHeader ID="MHead" runat="server" />
                <uc3:Header ID="RHead" runat="server" />
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
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
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
                                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <table id="tblCollectionOPIP" align="center">
                            <tr align="center">
                                <td align="center">
                                    <div class="dataheaderWider">
                                        <table id="tbl">
                                            <tr>
                                                <td align="right">
                                                    <asp:Label ID="Rs_FromDate" Text="From Date:" runat="server" 
                                                        meta:resourcekey="Rs_FromDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtFDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtFDateResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtFDate','ddmmyyyy','arrow',true,12)">
                                                        <img src="../images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                                </td>
                                                <td align="right">
                                                    <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" 
                                                        meta:resourcekey="Rs_ToDateResource1"></asp:Label>
                                                </td>
                                                <td align="left">
                                                    <asp:TextBox ID="txtTDate" runat="server" CssClass ="Txtboxsmall"  Width ="120px" meta:resourcekey="txtTDateResource1"></asp:TextBox>
                                                    <a href="javascript:NewCssCal('txtTDate','ddmmyyyy','arrow',true,12)">
                                                        <img src="../images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                                                </td>
                                                <td align="left">
                                                    <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" runat="server"
                                                        Height="30px" meta:resourcekey="rblVisitTypeResource1">
                                                        <asp:ListItem Text="OP" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                        <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:ImageButton Visible="False" ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" Style="width: 16px" 
                                                        meta:resourcekey="imgBtnXLResource1" />
                                                    <asp:LinkButton Visible="False" ID="lnkExportXL" Text="Export To XL" Font-Underline="True"
                                                        runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="Save As Excel"
                                                        OnClick="lnkExportXL_Click" meta:resourcekey="lnkExportXLResource1"></asp:LinkButton>
                                                </td>
                                                <td align="left">
                                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                                </td>
                                                <td align="left">
                                                    <asp:LinkButton ID="lnkBack" Text="Back" Font-Underline="True" runat="server" CssClass="details_label_age"
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                                </td>
                                            </tr>
                                            <tr visible="false">
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
                                                    <asp:RadioButtonList Visible="False" ID="rblReportType" RepeatDirection="Horizontal"
                                                        runat="server" meta:resourcekey="rblReportTypeResource1">
                                                        <asp:ListItem Text="Summary" Selected="True" Value="0" 
                                                            meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                        <asp:ListItem Text="Detail" Value="1" meta:resourcekey="ListItemResource4"></asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    &nbsp;
                                                </td>
                                                <td>
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
                                        <table cellpadding="0" cellspacing="0" border="0" width="95%">
                                            <tr>
                                                <td align="right" style="padding-right: 10px; color: #000000;">
                                                    <b id="printText" runat="server">
                                                        <asp:Label ID="Rs_PrintReport" Text="Print Report" runat="server" 
                                                        meta:resourcekey="Rs_PrintReportResource1"></asp:Label></b>
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
                                                        Width="100%" OnRowDataBound="gvIPReport_RowDataBound" Font-Names="verdana" 
                                                        Font-Size="10px" meta:resourcekey="gvIPReportResource1">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Collection Report" 
                                                                meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <table cellpadding="0" cellspacing="0" border="0" width="100%">
                                                                        <tr>
                                                                            <td align="left" style="height: 25px;">
                                                                                <b>
                                                                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server" 
                                                                                    meta:resourcekey="Rs_DateResource1"></asp:Label></b>
                                                                                <asp:LinkButton ID="lnkDate" ForeColor="Blue" Font-Bold="True" Font-Size="12px" Text='<%# Eval("VisitDate", "{0:dd/MM/yyyy}") %>'
                                                                                    runat="server" meta:resourcekey="lnkDateResource1"></asp:LinkButton>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:GridView ID="gvIPCreditMain" runat="server" AutoGenerateColumns="False" Width="750px"
                                                                                    ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMain_RowDataBound"
                                                                                    OnRowCommand="gvIPCreditMain_RowCommand" 
                                                                                    meta:resourcekey="gvIPCreditMainResource1">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Department Name" 
                                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                                            <ItemTemplate>
                                                                                                <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                                                    runat="server" meta:resourcekey="lnkDeptResource1"></asp:LinkButton>
                                                                                            </ItemTemplate>
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="ItemQuantity" HeaderText="Quantity" 
                                                                                            meta:resourcekey="BoundFieldResource1" >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField Visible="False" DataField="ItemAmount" HeaderText="Amount" 
                                                                                            meta:resourcekey="BoundFieldResource2" >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="BilledAmount" HeaderText="BilledAmount" 
                                                                                            meta:resourcekey="BoundFieldResource3" >
                                                                                            <ItemStyle Width="25px" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="AmountReceived" HeaderText="AmountReceived" 
                                                                                            meta:resourcekey="BoundFieldResource4" >
                                                                                            <ItemStyle Width="25px" />
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
                                                                                <table border="0" width="750px;">
                                                                                    <tr style="font-weight: bold; color: Black;">
                                                                                        <td align="center" style="width: 310px;">
                                                                                            <asp:Label ID="lblSubTotal" Font-Size="12px" Text="Total" runat="server" 
                                                                                                meta:resourcekey="lblSubTotalResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 40px;" align="center">
                                                                                            <asp:Label ID="lblQty" runat="server" meta:resourcekey="lblQtyResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 60px;" align="Right">
                                                                                            <asp:Label ID="lblBilledAmount" runat="server" 
                                                                                                meta:resourcekey="lblBilledAmountResource1"></asp:Label>
                                                                                        </td>
                                                                                        <td style="width: 60px;" align="Right">
                                                                                            <asp:Label ID="lblAmtReceived" runat="server" 
                                                                                                meta:resourcekey="lblAmtReceivedResource1"></asp:Label>
                                                                                        </td>
                                                                                </table>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                    <table id="tblgvIPCreditMainSummary" visible="False" runat="server" cellpadding="0"
                                                        cellspacing="0" border="0" width="100%">
                                                        <tr runat="server">
                                                            <td align="left" style="height: 25px;" runat="server">
                                                                <b>
                                                                    <asp:Label ID="Rs_Date" Text="Date :" runat="server"></asp:Label></b>
                                                                <asp:LinkButton ID="lnkDateSummary" ForeColor="Blue" Font-Bold="True" Font-Size="12px"
                                                                    runat="server"></asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <asp:GridView ID="gvIPCreditMainSummary" runat="server" AutoGenerateColumns="False"
                                                                    Width="750px" ForeColor="#333333" CssClass="mytable1" OnRowDataBound="gvIPCreditMainSummary_RowDataBound"
                                                                    OnRowCommand="gvIPCreditMainSummary_RowCommand">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Department Name">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkDept" ForeColor="Blue" Font-Size="12px" Text='<%# Eval("FeeType") %>'
                                                                                    runat="server"></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ItemQuantity" HeaderText="Quantity" >
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField Visible="False" DataField="ItemAmount" HeaderText="Amount" >
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="BilledAmount" HeaderText="BilledAmount" >
                                                                            <ItemStyle Width="25px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmountReceived" HeaderText="AmountReceived" >
                                                                            <ItemStyle Width="25px" />
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
                                                    <table id="tabTotal2" style="display: none;" runat="server" cellpadding="4" cellspacing="0"
                                                        border="0" width="750px">
                                                        <tr runat="server">
                                                            <td runat="server">
                                                                <table cellpadding="4" cellspacing="0" class="dataheaderInvCtrl" style="border-collapse: collapse;"
                                                                    border="0" width="750px">
                                                                    <tr style="height: 25px; font-weight: bold;">
                                                                        <td style="width: 300px;" align="right">
                                                                            <asp:Label ID="Rs_Total" Text="Total" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="tdQuantity2" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="tdBilledAmount2" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="tdAmountReceived2" style="width: 50px;" align="left" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="width: 300px;" align="right">
                                                                            <asp:Label ID="Rs_CreditDebitCardChargesCollected" Text="Credit/Debit Card Charges Collected"
                                                                                runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="td1" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="td2" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="tdServiceCharge" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="width: 300px;" align="right">
                                                                            <asp:Label ID="lbltotAdv" runat="server"><asp:Label ID="Rs_TotalAdvance" Text="Total Advance" runat="server"></asp:Label>
</asp:Label>
                                                                        </td>
                                                                        <td id="td3" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="td4" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="dvTotAdvance" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="width: 300px;" align="right">
                                                                            <asp:Label ID="lblDueChart" runat="server"><asp:Label ID="Rs_DueChartPayments" Text="Due Chart Payments" runat="server"></asp:Label>
</asp:Label>
                                                                        </td>
                                                                        <td id="td6" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="td7" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="dvDuechartPayments" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="width: 300px;" align="right">
                                                                            <asp:Label ID="Rs_TotalDiscounts" Text="Total Discounts" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="td9" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="td10" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="dvTotalDiscounts" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="height: 1px; background-color: Black;" align="right" colspan="4">
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="font-weight: bold;">
                                                                        <td style="width: 300px;" align="right">
                                                                            <asp:Label ID="Rs_TotalReceivedAmount" Text="Total Received Amount" runat="server"></asp:Label>
                                                                        </td>
                                                                        <td id="td15" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="td16" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                        <td id="dvTotRcvd" style="width: 50px;" align="right" runat="server">
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                    <table id="tblExcessAmount" runat="server" width="750px;">
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
                                                                <td align="right" style="width: 80%;" runat="server">
                                                                    <asp:Label ID="Rs_GrandTotal" Text="Grand Total" runat="server"></asp:Label>
                                                                    <label id="Label1" style="color: Green;" runat="server">
                                                                        (A)</label> :
                                                                </td>
                                                                <td align="right" style="padding-right: 15px;" runat="server">
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
                                                                    <asp:Label ID="Rs_ServiceCharge" Text="Service Charge" runat="server"></asp:Label>
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
                                                                    <asp:Label ID="Rs_TotalReceivedAmount1" Text="Total Received Amount" runat="server"></asp:Label>
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
                                                                    <asp:Label ID="Rs_TotalDueAmount1" Text="Total Due Amount" runat="server"></asp:Label>
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
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
