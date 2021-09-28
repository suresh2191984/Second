<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillSettlementIndividual.aspx.cs"
    EnableEventValidation="false" Inherits="Billing_BillSettlement" 
    meta:resourcekey="PageResource2" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%--<%@ Register Assembly="System.Web.DataVisualization, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
--%>
<%--<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="Header" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Reception Cash Closure</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>
    <link href="../StyleSheets/StyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />

    <%-- <script type="text/javascript" src="../Scripts/Common.js" language="javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <%--<script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/bid.js"></script>--%>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <style type="text/css">
        .stylenonee
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function openViewBill(obj, ftype) {

            if (ftype == "PRM") {
                var skey = "../Inventory/PrintBill.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
            else if (ftype == "DEP") {
                var skey = "../Reception/PrintDepositReceipt.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "&sType = DEPOSIT"
                           + "";

                window.open(skey, 'ViewDeposit', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
            else {

                var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

                window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
            }
        }
        function popupRprint() {
            var prtContent = document.getElementById('printRCashClosure');

            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            //alert(WinPrint);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
        }

        $(document).ready(function() {
        $(".CalendarExtender1").datepicker("setDate", new Date());
        $(".CalendarExtender2").datepicker("setDate", new Date());
        });
        
        
    </script>

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
    <asp:UpdatePanel ID="UpdatePanel102" runat="server" UpdateMode="Conditional">
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click"/> 
            </Triggers>
            <ContentTemplate>
                <asp:UpdateProgress ID="Progressbar1" AssociatedUpdatePanelID="UpdatePanel102" runat="server">
                    <ProgressTemplate>
                        <div id="progressBackgroundFilter" class="a-center">
                        </div>
                        <div id="processMessage" class="a-center w-20p">
                            <asp:Image ID="imgProgressbar1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                meta:resourcekey="img1Resource1" />
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
        <div class="a-center" id="printRCashClosure">
            <table class="w-100p" cellpadding="2" cellspacing="1">
                <tr>
                    <td class="a-left"  >
                        <div class="dataheader2" id="divtimeDisplay" runat="server" style="display:none;">
                            <asp:Label ID="lblUserName" runat="server" CssClass="a-left padding8" meta:resourcekey="lblUserNameResource1"></asp:Label>
                            <br />
                            <asp:Label ID="lblReceivedTime" CssClass="a-left padding8" runat="server" meta:resourcekey="lblReceivedTimeResource2"></asp:Label>
                            <br />
                            <asp:Label ID="lblRefundTime" CssClass="a-left padding8" runat="server" meta:resourcekey="lblRefundTimeResource2"></asp:Label>
                        </div>
                        <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocationResource1" CssClass="a-left padding8" Text="Location"></asp:Label>
                        </td>
                        <td class="a-left">
                             <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" Width="130px" Enabled="false"
                                    meta:resourcekey="ddlLocation">
                                </asp:DropDownList>
                    </td>
                    <td class="a-left">
                    <asp:Label ID="lblUser" runat="server" meta:resourcekey="lblUserResource1" CssClass="a-left padding8" Text="User Name"></asp:Label>
                    </td>
                    <td class="a-left">
                    <asp:DropDownList ID="ddlUsers" runat="server" CssClass="ddl" Width="130px" Enabled="false"
                                meta:resourcekey="ddlUsers">
                            </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                <td class="a-left"  >
                        <asp:Label ID="lblFromDate" runat="server" meta:resourcekey="lblFromDateResource1" CssClass="a-left padding8" Text="From"></asp:Label>
                        </td>
                        <td class="a-left">
                          <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall" 
                                                    meta:resourcekey="txtFromDate"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                                            
                                                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    </td>
                    <td class="a-left">
                    <asp:Label ID="lblToDate" runat="server" meta:resourcekey="lblToDateResource1" CssClass="a-left padding8" Text="To"></asp:Label>
                    </td>
                    <td class="a-left">
                     <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall"   onchange="javascript:ValidateDate();" 
                                                    meta:resourcekey="txtToDate"></asp:TextBox>
                                                   <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" /><br />
                                                            
                                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImageButton1" Enabled="True" />
                    
                    </td>
                </tr>
                <tr>
                <td colspan="4">
                <asp:Button ID="btnSearch" runat="server" Text="Search" meta:resourcekey="btnSearchResource1" CssClass="btn" OnClientClick="return ValidateDate();" OnClick="btnSearch_click"/>
                </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <%--<asp:HiddenField ID="hdnPDetail" runat="server" />--%>
                        <input type="hidden" id="hdnPDetail" runat="server" />
                        <asp:Panel ID="pnlExam" runat="server" CssClass="defaultfontcolor w-100p" meta:resourcekey="pnlExamResource2">
                            <div class="dataheader2" align="center">
                                <table class="w-80p">
                                    <tr>
                                        <td class="w-100p v-top" colspan="2">
                                            <asp:Panel ID="pnlReceived" runat="server" GroupingText="Received Details" meta:resourcekey="pnlReceivedResource2">
                                                <asp:Label ID="lblgvBillDetails" Visible="False" runat="server" meta:resourcekey="lblgvBillDetailsResource2"></asp:Label>
                                                <asp:GridView ID="gvBillDetails" runat="server" CssClass="gridView w-100p font9" AutoGenerateColumns="False"
                                                   OnRowDataBound="gvBillDetails_RowDataBound" Visible="False" BackColor="White"
                                                    BorderColor="#CCCCCC" BorderStyle="None" DataKeyNames="FinalBillID" BorderWidth="1px"
                                                    CellPadding="2" Font-Names="Verdana" GridLines="Horizontal" OnRowCommand="gvBillDetails_RowCommand"
                                                    meta:resourcekey="gvBillDetailsResource3">
                                                    <Columns>
                                                        <asp:BoundField DataField="AMTBillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                            HeaderText="Bill Date">
                                                            <ItemStyle CssClass="a-center" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Bill Number" meta:resourcekey="TemplateFieldResource7">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lnkBillNumber" Style="color: Black; font-family: Verdana; cursor: pointer;"
                                                                    Text='<%# Eval("BillNumber") %>' runat="server" meta:resourcekey="lnkBillNumberResource3"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--  <asp:TemplateField HeaderText="Receipt No" 
                                                                            meta:resourcekey="TemplateFieldResource8">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lnkReceiptNO" Text='<%# Eval("ReceiptNO") %>' runat="server" 
                                                                                    meta:resourcekey="lnkReceiptNOResource2"></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>--%>
                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" 
                                                            meta:resourcekey="BoundFieldResource2">
                                                            <ItemStyle CssClass="a-center" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                                            meta:resourcekey="BoundFieldResource16">
                                                            <ItemStyle CssClass="a-left" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Description" Visible="False" 
                                                            meta:resourcekey="TemplateFieldResource2">
                                                            <ItemTemplate>
                                                                <asp:GridView ID="gvChildDetails" CssClass="dataheaderInvCtrl gridView" Width="390px"
                                                                    runat="server" AutoGenerateColumns="False" meta:resourcekey="gvChildDetailsResource2"
                                                                    Visible="false">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Description" 
                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="chkID" runat="server" CssClass="a-left" Text='<%# Eval("Descriptions") %>'
                                                                                    meta:resourcekey="chkIDResource2" />
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="a-center" />
                                                                            <ItemStyle CssClass="a-left" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Billed Amount" 
                                                                            meta:resourcekey="BoundFieldResource4">
                                                                            <ItemStyle CssClass="a-right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="RefundAmount" HeaderText="Amount Refunded" 
                                                                            meta:resourcekey="BoundFieldResource5">
                                                                            <ItemStyle CssClass="a-right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                </asp:GridView>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <%--<asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" meta:resourcekey="BoundFieldResource26" />--%>
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Net Amount" meta:resourcekey="BoundFieldResource6">
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PaidCurrencyAmount" DataFormatString="{0:0.00}" 
                                                            HeaderText="Amount Received" meta:resourcekey="BoundFieldResource7">
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" 
                                                            Visible="False" meta:resourcekey="BoundFieldResource8">
                                                            <ItemStyle CssClass="a-center" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                    <RowStyle CssClass="v-top" ForeColor="#000066" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="w-100p v-top" colspan="2">
                                            <asp:Panel ID="pnlRefund" runat="server" GroupingText="Refund / Cancel Details" meta:resourcekey="pnlRefundResource2">
                                                <asp:Label ID="lblgvRefundDetails" Visible="False" runat="server" meta:resourcekey="lblgvRefundDetailsResource2"></asp:Label>
                                                <asp:GridView ID="gvRefundDetails" CssClass="gridView font9 w-100p" runat="server" AutoGenerateColumns="False"
                                                     OnRowDataBound="gvRefundDetails_RowDataBound" Visible="False" BackColor="White"
                                                    BorderColor="#CCCCCC" BorderStyle="None" DataKeyNames="FinalBillID" BorderWidth="1px"
                                                    CellPadding="3" Font-Names="Verdana" meta:resourcekey="gvRefundDetailsResource3">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Bill Number" meta:resourcekey="TemplateFieldResource11">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lnkBillNumber" runat="server" meta:resourcekey="lnkBillNumberResource4"
                                                                    Style="color: Black; font-family: Verdana; cursor: pointer;" Text='<%# Eval("BillNumber") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource29" />
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" meta:resourcekey="BoundFieldResource30">
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" meta:resourcekey="BoundFieldResource31" />
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" CssClass="a-left" />
                                                    <RowStyle ForeColor="#000066" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr class="v-top a-right">
                                        <td colspan="2" class="a-left">
                                            <asp:Panel ID="pnlPayments" runat="server" GroupingText="Payment Details" meta:resourcekey="pnlPaymentsResource2">
                                                <asp:Label ID="lblgvPaymentDetails" Visible="False" runat="server" meta:resourcekey="lblgvPaymentDetailsResource2"></asp:Label>
                                                <asp:GridView ID="gvPaymentDetails" CssClass="gridView w1-100p font9" runat="server"
                                                    AutoGenerateColumns="False" OnRowDataBound="gvPaymentDetails_RowDataBound" Visible="False"
                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                    CellPadding="3" Font-Names="Verdana" 
                                                    meta:resourcekey="gvPaymentDetailsResource1">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Doctor Number" Visible="False" 
                                                            meta:resourcekey="TemplateFieldResource3">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lnkBillNumber0" runat="server" meta:resourcekey="lnkBillNumber0Resource2"
                                                                    Style="color: Black; font-family: Verdana; cursor: pointer;" Text='<%# Eval("BillNumber") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="stylenonee" />
                                                            <ItemStyle CssClass="stylenonee" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="PatientName" HeaderText="Description" meta:resourcekey="BoundFieldResource32" />
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" meta:resourcekey="BoundFieldResource33">
                                                            <ItemStyle HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" meta:resourcekey="BoundFieldResource34" />
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <RowStyle ForeColor="#000066" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr class="v-top a-right" style="display: none">
                                        <td colspan="2" class="a-right">
                                            <asp:Panel ID="pnlCashIncomeDetails" runat="server" GroupingText="Cash income details"
                                                meta:resourcekey="pnlCashIncomeDetailsResource1">
                                                <asp:Label ID="lblgvCashIncomeDetails" Visible="False" runat="server" meta:resourcekey="lblgvCashIncomeDetailsResource1"></asp:Label>
                                                <asp:GridView ID="gvCashIncomeDetails" CssClass="gridView w-100p" runat="server"
                                                    AutoGenerateColumns="False" Visible="False" BackColor="White" BorderColor="#CCCCCC"
                                                    BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Names="Verdana" Font-Size="9pt"
                                                    OnRowDataBound="gvCashIncomeDetails_RowDataBound" meta:resourcekey="gvCashIncomeDetailsResource2">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Received By" meta:resourcekey="TemplateFieldResource13">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" CommandArgument='<%# Eval("ReceivedBy") %>'
                                                                    CommandName="UserLink" meta:resourcekey="lnkReceivedNumberResource1" Style="color: Black;
                                                                    text-decoration: underline; font-family: Verdana; cursor: pointer;" Text='<%# Eval("ReceiptNO") %>'></asp:LinkButton>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="Remarks" HeaderText="Description" meta:resourcekey="BoundFieldResource35" />
                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" meta:resourcekey="BoundFieldResource36">
                                                            <ItemStyle CssClass="a-right" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="FinalBillID" HeaderText="UniqueID" meta:resourcekey="BoundFieldResource37"
                                                            Visible="False" />
                                                    </Columns>
                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                    <RowStyle ForeColor="#000066" />
                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblConsReport" runat="server" meta:resourcekey="lblConsReportResource2"></asp:Label>
                                        </td>
                                        <td align="a-right" style="text-align: right;">
                                            <table class="a-right paddingR10 w-100p">
                                                <tr class="a-right">
                                                    <td class="a-right">
                                                        <asp:Label ID="lbtotcollamt" runat="server" Text="Total Collected Amount" meta:resourcekey="lbtotcollamtResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblTotal" runat="server" Text="0.00" meta:resourcekey="lblTotalResource2"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="lbtotsourceamt" runat="server" Text="Total Collected Source Amount"
                                                            meta:resourcekey="lbtotsourceamtResource1"></asp:Label>&nbsp;&nbsp;
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblTotalIncAmount" runat="server" Text="0.00" meta:resourcekey="lblTotalIncAmountResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="lbrefundamt" runat="server" Text="Total Refunded Amount" meta:resourcekey="lbrefundamtResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblRefund" runat="server" Text="0.00" meta:resourcekey="lblRefundResource2"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="lbcancel" runat="server" Text="Total Cancelled Bill Amount" meta:resourcekey="lbcancelResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblCancelledAmount" runat="server" Text="0.00" meta:resourcekey="lblCancelledAmountResource2"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="amttophy" runat="server" Text="Total Paid Amount to Physician" meta:resourcekey="amttophyResource1"></asp:Label>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblPhyAmount" runat="server" Text="0.00" meta:resourcekey="lblPhyAmountResource2"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td >
                                                    <div style="float:left;width:50%;" align="left">----------------------------------------------</div>
                                                    <div style="float:right;width:50%;" align="right">
                                                        <asp:Label ID="lbmiscamt" runat="server" Text="Total Paid Miscellaneous Amount" meta:resourcekey="lbmiscamtResource1"></asp:Label>
                                                        &nbsp;&nbsp;</div>
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblOthersAmount" runat="server" Text="0.00" meta:resourcekey="lblOthersAmountResource2"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                    <div style="float:left;width:50%;" align="left">
                                                    <div style="float:left;width:30%">
                                                    <asp:Label ID="lblClosingCash" Text="Closing Cash In Hand:"
                                                            runat="server" meta:resourcekey="Rs_lblCashinhandResource1"></asp:Label>
                                                     
                                                    </div>
                                                    <div style="float:right;width:70%;color:Green">
                                                     <asp:Label ID="lblRupeeText" Text="Indian Rupee - "
                                                            runat="server" meta:resourcekey="Rs_lblRupeeTextResource1"></asp:Label>
                                                    <asp:Label ID="lblCashInHand" runat="server"></asp:Label>
                                                    </div>
                                                    </div>
                                                    <div style="float:right;width:50%;" align="right">
                                                        <asp:Label ID="Rs_TotalPendingSettledAmt" Text="Total Pending Settlement Amount"
                                                            runat="server" meta:resourcekey="Rs_TotalPendingSettledAmtResource1"></asp:Label>
                                                        &nbsp;&nbsp;</div>
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblTotalPendingSettledAmt" runat="server" Text="0.00" meta:resourcekey="lblTotalPendingSettledAmtResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-right">
                                                        <asp:Label ID="lbclosbal" runat="server" Text="Closing Balance" meta:resourcekey="lbclosbalResource1"></asp:Label>&nbsp;&nbsp;
                                                        &nbsp;&nbsp;
                                                    </td>
                                                    <td class="a-right">
                                                        <asp:Label ID="lblClosingBalance" runat="server" Text="0.00" meta:resourcekey="lblClosingBalanceResource2"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trCashInHand" runat="server">
                                                    <td colspan="2" runat="server">
                                                        <table>
                                                            <tr>
                                                                <td colspan="2">
                                                                    --------------------------------------------------------------------
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="a-right bold v-top">
                                                                    <asp:Label ID="lbclosingcash" runat="server" Text="Closing Cash In Hand:"></asp:Label>
                                                                    &nbsp;&nbsp;
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblClosingCashInHand" ForeColor="Green" runat="server" Text="0.00"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center" colspan="2">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                    </td>
                                                    <td class="a-center">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </td>
                </tr>
            </table>
        </div>
        <table class="a-center w-100p">
            <tr>
                <td align="center" colspan="3">
                    <asp:Panel ID="Panel1" runat="server" GroupingText="Amount Breakup For OP" meta:resourcekey="Panel1Resource2">
                        <asp:GridView ID="gvINDAmtReceivedDetails" runat="server" AutoGenerateColumns="False"
                            Visible="False" ForeColor="#333333" CssClass="mytable1 gridView w-75p" OnRowDataBound="gvINDAmtReceivedDetails_RowDataBound"
                            meta:resourcekey="gvINDAmtReceivedDetailsResource2">
                            <Columns>
                                <asp:BoundField DataField="Descriptions" HeaderText="Description" meta:resourcekey="BoundFieldResource38">
                                    <ItemStyle CssClass="a-left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Qty" HeaderText="Quantity" meta:resourcekey="BoundFieldResource39" />
                                <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource40">
                                    <ItemStyle CssClass="a-right" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                            <PagerStyle BackColor="White" ForeColor="#000066" CssClass="a-left" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Panel ID="Panel2" runat="server" GroupingText="Amount Breakup For IP" meta:resourcekey="Panel2Resource2">
                        <asp:GridView ID="gvIndIPAMountReceived" runat="server" AutoGenerateColumns="False"
                            Visible="False" ForeColor="#333333" CssClass="mytable1 gridView w-75p" OnRowDataBound="gvINDAmtReceivedDetails_RowDataBound"
                            meta:resourcekey="gvIndIPAMountReceivedResource2">
                            <Columns>
                                <asp:BoundField DataField="Descriptions" HeaderText="Description" meta:resourcekey="BoundFieldResource41">
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Qty" HeaderText="Quantity" meta:resourcekey="BoundFieldResource42" />
                                <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource43">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle Font-Bold="True" />
                            <PagerStyle BackColor="White" ForeColor="#000066" CssClass="a-left" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:Panel ID="Panel3" runat="server" Visible="False" GroupingText="Payments Breakup"
                        meta:resourcekey="Panel3Resource2">
                        <asp:GridView ID="gvAmountBreakup" runat="server" AutoGenerateColumns="False" BackColor="White"
                            BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Bold="False"
                            Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False"
                            Font-Underline="False" meta:resourcekey="gvAmountBreakupResource2">
                            <Columns>
                                <asp:BoundField DataField="ClosureStatus" HeaderText="Payment Type" meta:resourcekey="BoundFieldResource44" />
                                <asp:BoundField DataField="AmtReceived" HeaderText="Amount" meta:resourcekey="BoundFieldResource45">
                                    <ItemStyle HorizontalAlign="Right" />
                                </asp:BoundField>
                            </Columns>
                            <FooterStyle BackColor="White" ForeColor="#000066" />
                            <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                            <PagerStyle BackColor="White" ForeColor="#000066" CssClass="a-left" />
                            <RowStyle ForeColor="#000066" />
                            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        </asp:GridView>
                    </asp:Panel>
                </td>
            </tr>
            <tr style="display:none">
            <td align="right">
            <asp:CheckBox ID="ChkSettlement" runat="server" />
            <asp:Label ID="lblSettlement" runat="server" Text="Settlement"></asp:Label>
            </td>
            <td>
            <asp:Label ID="lblRolename" runat="server" Text="Role Name"></asp:Label>
            <asp:DropDownList ID="ddlRolename" runat="server" CssClass="ddl" Width="130px" Enabled="false" 
                                    meta:resourcekey="ddlLocation">
                                </asp:DropDownList>
            </td>
            <td align="left">
            <asp:Label ID="lblUser2" runat="server" Text="User Name"></asp:Label>
            <asp:DropDownList ID="ddlUsername2" runat="server" CssClass="ddl" Width="130px" Enabled="false"  
                                    meta:resourcekey="ddlLocation">
                                </asp:DropDownList>
            </td>
            </tr>
            <tr class="a-center">
                <td colspan="3">
                    <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" OnClientClick="return popupRprint();" meta:resourcekey="btnPrintResource2" />
                    <asp:Button ID="btnBack" runat="server" Text="BACK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                        onmouseout="this.className='btn'" OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" />
                <br /> <br /> </td>
            </tr>
        </table>
        </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

    <script type="text/javascript" language="javascript">
        function DrawTable(BillID) {
            alert(BillID);
        }
        $(document).ready(function() {
            $('input[type="checkbox"]').click(function() {
            if ($(this).is(":checked")) {
                $("#ddlUsername2").prop("disabled", false);
                $("#ddlRolename").prop("disabled", false);
                }
                else {
                    $("#ddlUsername2").prop("disabled", true);
                    $("#ddlRolename").prop("disabled", true);
                }
            });
        });
    </script>

    <asp:HiddenField ID="hdnAmtReceivedID" runat="server" />
    <asp:HiddenField ID="hdnNeedDescription" Value="Y" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
<script type="text/javascript">
    function ValidateDate() {
        var AlrtWinHdr = SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_alert") != null ? SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_alert") : "Alert";
        var UsrAlrtMsg3 = SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_11") != null ? SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_11") : "Please select valid ToDate!!!";
           
        if (document.getElementById('txtFromDate').value != "") {
            
            var getDate = document.getElementById('<%= txtFromDate.ClientID %>').value;
            var getDate2 = document.getElementById('<%= txtToDate.ClientID %>').value;
            var Flag = true;




            if (getDate.substr(6, 4) > getDate2.substr(6, 4)) {
                Flag = false;
            } else if ((getDate.substr(6, 4) == getDate2.substr(6, 4)) && (getDate.substr(3, 2) > getDate2.substr(3, 2))) {
            Flag=false;
        } else if ((getDate.substr(3, 2) == getDate2.substr(3, 2)) && (getDate.substr(0, 2) > getDate2.substr(0, 2))) {
            Flag=false;
            }
            if (Flag == false) {
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                document.getElementById('txtFromDate').value = new Date().format('dd/MM/yyyy');
            }
        }
        return Flag;
    }
</script>
