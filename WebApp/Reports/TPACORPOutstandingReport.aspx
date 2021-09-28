<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TPACORPOutstandingReport.aspx.cs"
    Inherits="Reports_TPACORPOutstandingReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/PendingVitals.ascx" TagName="PendingVitalsControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/Tasks.ascx" TagName="TaskControl" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/TaskEscalation.ascx" TagName="TaskEscalation"
    TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReminderDisplay.ascx" TagName="ReminderDisplay"
    TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>TPA Corp out standing Report</title>
    <link href="../Images/favicon.ico" rel="shortcut icon" />
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
     <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/Common.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script runat="server">
        string _date;
        string GetDate(string Date)
        {
            if (Date != "01/01/0001")
            {
                _date = Date;
            }
            else
            {
                _date = "--";
            }
            return _date;
        }
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
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
                <uc3:Header ID="AdminHeader" runat="server" />
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
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer;" />
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <Top:TopHeader ID="TopHeader1" runat="server" />
                            </td>
                        </tr>
                    </table>
                    <div class="contentdata1">
                        <ul style="display: none;">
                            <li>
                                <uc9:ErrorDisplay ID="ErrorDisplay1" runat="server" />
                            </li>
                        </ul>
                        <div>
                            <table cellpadding="2" class="dataheader2 defaultfontcolor" style="text-align: left;"
                                cellspacing="1">
                                <tr>
                                    <td align="left">
                                        <table>
                                            <tr>
                                                <td align="left">
                                                    From :
                                                    <asp:TextBox runat="server" ID="txtFromDate" MaxLength="10" CssClass ="Txtboxsmall" Width ="120px"
                                                        size="25" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" border="0" alt="Pick from date" 
                                                        meta:resourcekey="ImgBntCalcResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                        TargetControlID="txtFromDate" Enabled="True" />
                                                    To :
                                                    <asp:TextBox runat="server" ID="txtToDate" MaxLength="10" CssClass ="Txtboxsmall" Width ="120px"
                                                        meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                                    &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                        Width="16px" Height="16px" AlternateText="Pick to date" 
                                                        meta:resourcekey="ImgToDateResource1" />
                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                        TargetControlID="txtToDate" Enabled="True" />
                                                </td>
                                                <td>
                                                <asp:RadioButtonList ID="rblVisitType" RepeatDirection="Horizontal" 
                                                        RepeatColumns="3" runat="server" meta:resourcekey="rblVisitTypeResource1">
                                                <asp:ListItem Text="IP" Value="1" Selected="True" 
                                                        meta:resourcekey="ListItemResource1" ></asp:ListItem>
                                                <asp:ListItem Text="OP" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Text="IP & OP" Value="2" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                </asp:RadioButtonList>
                                                </td>
                                                <td align="right">
                                                    <asp:Button runat="server" ID="btnGo" Text=" Go " CssClass="btn" TabIndex="6" onmouseover="this.className='btn btnhov'"
                                                        onmouseout="this.className='btn'" OnClick="btnGo_Click" 
                                                        meta:resourcekey="btnGoResource1" />
                                                    &nbsp;
                                                    <asp:Button ID="btnCancel" runat="server" Text="Reset" CssClass="btn" onmouseover="this.className='btn1 btnhov1'"
                                                        onmouseout="this.className='btn'" OnClick="btnCancel_Click" 
                                                        meta:resourcekey="btnCancelResource1" />
                                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="details_label_age" 
                                                        OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1">
                                                Back
                                                    </asp:LinkButton>
                                                    &nbsp;
                                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                        ToolTip="Save As Excel" OnClick="imgBtnXL_Click" 
                                                        meta:resourcekey="imgBtnXLResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <table width="60%" style="display: none;" class="dataheader2 defaultfontcolor">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblNote" runat="server" Text="Note:" ForeColor="Red" 
                                            meta:resourcekey="lblNoteResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <span><b>Out Standing Calculation = </b></span>
                                        <asp:Label ID="lblOutCalculation" runat="server" 
                                            Text="Net Amount - (Pt Settled Amt + TPA Settled Amt)" 
                                            meta:resourcekey="lblOutCalculationResource1"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <span><b>Patient Due Calculation = </b></span>
                                        <asp:Label ID="lblDueCalculation" runat="server" 
                                            Text="Net Amount - (Pt Settled Amt + Claim Amount)" 
                                            meta:resourcekey="lblDueCalculationResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div align="center" id="printCashClosure">
                            <table cellpadding="2" class="defaultfontcolor" style="text-align: left;" cellspacing="1"
                                width="100%">
                                <tr id="tralldetails" runat="server">
                                    <td valign="top">
                                        <div id="divAllUsers" runat="server">
                                            <table cellpadding="2" class="defaultfontcolor" style="color: Black; font-family: Verdana;
                                                text-align: left;" cellspacing="1" width="100%">
                                                <tr>
                                                    <td valign="top" class="dataheader2" nowrap="nowrap">
                                                        <asp:GridView ID="grdResult" runat="server" EmptyDataText="No Results Found." AutoGenerateColumns="False"
                                                            CellPadding="4" CssClass="mytable1" Width="100%" 
                                                            OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource1">
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <RowStyle HorizontalAlign="Left" Font-Size="10px" />
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText=""
                                                                PageButtonCount="5" PreviousPageText="" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bill Date" SortExpression="CreatedAt" ItemStyle-HorizontalAlign="Right"
                                                                    Visible="true" meta:resourcekey="TemplateFieldResource1">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "DischargedDT", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="25px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="BillNumber" HeaderText="Bill No" 
                                                                    meta:resourcekey="BoundFieldResource1" />
                                                                <asp:TemplateField HeaderText="Bill Desp.Date" SortExpression="CreatedAt" ItemStyle-HorizontalAlign="Right"
                                                                    Visible="true" meta:resourcekey="TemplateFieldResource2">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "CliamForwardDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="25px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="GrossAmount" HeaderText="Gross Bill Amount" DataFormatString="{0:0.00}"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource2" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="OrgDiscountAmount" HeaderText="KMH Disc Amt" DataFormatString="{0:0.00}"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource3" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="NetAmount" HeaderText="Net Amount" DataFormatString="{0:0.00}"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource4" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" 
                                                                    meta:resourcekey="BoundFieldResource5" />
                                                                <asp:BoundField DataField="Name" HeaderText="Patient Name" 
                                                                    meta:resourcekey="BoundFieldResource6" />
                                                                <asp:BoundField DataField="BirthDays" HeaderText="Age/Sex" 
                                                                    ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource7" >
<ItemStyle Width="15%"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="DOD" SortExpression="CreatedAt" ItemStyle-HorizontalAlign="Right"
                                                                    Visible="false" meta:resourcekey="TemplateFieldResource3">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "DischargedDT", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="25px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="ReceivedAmount" HeaderText="Pt-Settled Amount" DataFormatString="{0:0.00}"
                                                                    ItemStyle-ForeColor="Red" ItemStyle-HorizontalAlign="Right" 
                                                                    meta:resourcekey="BoundFieldResource8" >
<ItemStyle HorizontalAlign="Right" ForeColor="Red"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Patient Due Amount" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource4">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPatientDueAmt" Text='<%# CalcPatientDueAmount(Eval("NetAmount"),Eval("TPABillAmount"),Eval("ReceivedAmount")) %>'
                                                                            runat="server" meta:resourcekey="lblPatientDueAmtResource1"></asp:Label>
                                                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="TPAName" HeaderText="TPA/Insurance/Corporate" 
                                                                    meta:resourcekey="BoundFieldResource9" />
                                                                <asp:BoundField DataField="PreAuthAmount" DataFormatString="{0:0.00}" HeaderText="TPA Pre-Auth Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource10" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPABillAmount" DataFormatString="{0:0.00}" HeaderText="Claim Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource11" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPAAmount" DataFormatString="{0:0.00}" HeaderText="TPA/Corp Cheque Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource12" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TDS" DataFormatString="{0:0.00}" HeaderText="TPA/Corp TDS Deduction"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource13" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPADiscountAmt" DataFormatString="{0:0.00}" HeaderText="TPA/Corp Discount Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource14" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TPASettledAmt" DataFormatString="{0:0.00}" ItemStyle-ForeColor="Red"
                                                                    HeaderText="TPA/Corp Settled Amt" ItemStyle-HorizontalAlign="Right" 
                                                                    meta:resourcekey="BoundFieldResource15" >
<ItemStyle HorizontalAlign="Right" ForeColor="Red"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="TPA/Corp Settlement Date" SortExpression="CreatedAt"
                                                                    ItemStyle-HorizontalAlign="Right" Visible="true" 
                                                                    meta:resourcekey="TemplateFieldResource5">
                                                                    <ItemTemplate>
                                                                        <%# GetDate(DataBinder.Eval(Container.DataItem, "TPASettlementDate", "{0:dd/MM/yyyy}").ToString())%>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="25px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="TPADisallowedAmt" DataFormatString="{0:0.00}" HeaderText="TPA/Corp Dis-Allowed Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource16" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Outstanding Amount" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="TemplateFieldResource6">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblOutstandingAmt" Text='<%# OutStandingCalculation(Eval("NetAmount"),Eval("ReceivedAmount"),Eval("TPAAmount"),Eval("TDS"),Eval("TPADiscountAmt"),Eval("RightOff"),Eval("TPABillAmount")) %>'
                                                                            runat="server" meta:resourcekey="lblOutstandingAmtResource1"></asp:Label>
                                                                    </ItemTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="Ageing" HeaderText="Ageing(In Days)" 
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource17" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="RightOff" DataFormatString="{0:0.00}" HeaderText="Write off Amt"
                                                                    ItemStyle-HorizontalAlign="Right" meta:resourcekey="BoundFieldResource18" >
<ItemStyle HorizontalAlign="Right"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="WriteOffApprover" HeaderText="Write off Approver By" 
                                                                    meta:resourcekey="BoundFieldResource19" />
                                                                <asp:TemplateField HeaderText="Payment Details" 
                                                                    meta:resourcekey="TemplateFieldResource7">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="chkID" runat="server" Style="text-align: left;" Text='<%# Eval("PaymentDetails") %>'
                                                                            meta:resourcekey="chkIDResource1" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                    <HeaderStyle HorizontalAlign="Left" Width="35%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </td>
            </tr>
        </table>
        <uc5:Footer ID="Footer1" runat="server" />
    </div>
    </form>
</body>
</html>
