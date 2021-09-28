<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BillSettlement.aspx.cs" Inherits="Admin_BillSettlement"
    meta:resourcekey="PageResource1" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader" TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
<%=Resources.Admin_ClientDisplay.Admin_BillSettlement_aspx_01 %> </title>
    <link href="../StyleSheets/DHEBAdder.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Scripts/AutoComplete.js" language="javascript"></script>

    <script type="text/javascript" src="../Scripts/DHEBAdder.js"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <style type="text/css">
        .stylenone
        {
            display: none;
        }
    </style>

    

</head>
<body>
    <form id="frmPatientVitals" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
    </asp:ScriptManager>
      <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                    <asp:UpdatePanel ID="UpdatePanel102" runat="server" UpdateMode="Conditional">
            
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
                       
                        <div class="a-center" id="printCashClosure">
                            <table class="w-100p searchPanel">
                                <tr>
                                    <td class="a-center">
                                        <%--<asp:Label ID="Rs_ReceivedBy" Text="Received By" runat="server" meta:resourcekey="Rs_ReceivedByResource1"></asp:Label>
                                        --%>
                                    </td>
                                    <td class="a-center">
                                        &nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td class="a-left" colspan="2">
                                <table class="w-100p">
                                 <tr>
                                 <td>
                                <asp:Label ID="lblFromDate" runat="server" meta:resourcekey="lblFromDate" CssClass="a-left padding8" Text="From"></asp:Label>
                               </td>
                               
                                <td>
                                
                                    <asp:TextBox ID="txtFromDate1" runat="server" CssClass="Txtboxsmall" 
                                                    meta:resourcekey="txtFromDate"></asp:TextBox>
                                                    <asp:ImageButton ID="ImgBntCalcFrom1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                           
                                                       <cc1:CalendarExtender ID="CalExtender1" runat="server" TargetControlID="txtFromDate1"
                                                                 Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom1" Enabled="true" />
                                                                 <%--<cc1:CalendarExtender ID="CalExtender1" runat="server"></cc1:CalendarExtender>--%>
                                                               
                               </td>
                               <td>
                                
                                
                                    <asp:Label ID="lblToDate" runat="server" meta:resourcekey="lblToDate" CssClass="a-left padding8" Text="To"></asp:Label>
                                    
                             
                                </td>
                                <td>
                                
                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall" onchange="javascript:ValidateDate();"  
                                                    meta:resourcekey="txtToDate"></asp:TextBox>
                                                   <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                            
                                                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                                                Format="dd/MM/yyyy" PopupButtonID="ImageButton1" Enabled="True" />
                                     </td>                           
                                   </tr>
                                <tr>
                                <td>
                                 <asp:Label ID="lblLocation" runat="server" meta:resourcekey="lblLocation" CssClass="a-left padding8" Text="Location"></asp:Label>
                                 </td>
                                 <td>
                                 <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl" Width="130px" 
                                meta:resourcekey="ddlLocation">
                            </asp:DropDownList>
                            </td>
                            
                            <td>
                            <asp:Label ID="lblUser" runat="server" meta:resourcekey="lblUser" CssClass="a-left padding8" Text="User Name"></asp:Label>
                            </td>
                            <td>
                                <asp:DropDownList ID="ddlUser" runat="server" 
                                            CssClass="ddl" meta:resourcekey="ddlUserResource1">
                                        </asp:DropDownList>
                                        </td>
                                        </tr>
                                        <tr>
                                        <td colspan="4" align="center">
                                        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn" OnClientClick="return ValidateDate()" OnClick="btnSearch_click"/>
                                        </td></tr>
                                        </table>
                           </td>
                                </tr>
                                
                                <tr>
                                    <td class="a-Center" colspan="2">
                                        <div class="dataheader2" id="divtimeDisplay" runat="server" style="display:none;">
                                            <asp:Label ID="lblReceivedTime" Style="text-align: left; padding-left: 5px;" runat="server"
                                                meta:resourcekey="lblReceivedTimeResource1"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblRefundTime" Style="text-align: left; padding-left: 5px;" runat="server"
                                                meta:resourcekey="lblRefundTimeResource1"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblPrintDateTime" Style="text-align: left; padding-left: 5px;" runat="server"
                                                meta:resourcekey="lblPrintDateTimeResource"></asp:Label>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <asp:Panel ID="pnlExam" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlExamResource1">
                                            <div class="dataheader2 a-center">
                                                <table class="w-80p m-auto">
                                                    <tr>
                                                        <td class="w-80p v-top">
                                                            <asp:Panel ID="pnlReceived" runat="server" GroupingText="Received Details" meta:resourcekey="pnlReceivedResource1">
                                                                <asp:Label ID="lblgvBillDetails" Visible="False" runat="server" meta:resourcekey="lblgvBillDetailsResource1"></asp:Label>
                                                                <asp:GridView ID="gvBillDetails" runat="server" AutoGenerateColumns="False" 
                                                                    OnRowDataBound="gvBillDetails_RowDataBound" CssClass="w-100p gridView" DataKeyNames="FinalBillID" Visible="False"
                                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="2" Font-Names="Verdana" Font-Size="9pt" GridLines="Horizontal" OnRowCommand="gvBillDetails_RowCommand"
                                                                    meta:resourcekey="gvBillDetailsResource2">
                                                                    <RowStyle VerticalAlign="Top" ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="AMTBillDate" HeaderText="Bill Date" 
                                                                            meta:resourcekey="BoundFieldResource69">
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Bill Number" 
                                                                            meta:resourcekey="TemplateFieldResource1">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lnkBillNumber" runat="server" 
                                                                                    meta:resourcekey="lnkBillNumberResource1" 
                                                                                    Style="color: Black; font-family: Verdana; cursor: pointer;" 
                                                                                    Text='<%# Eval("BillNumber") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" 
                                                                            >
                                                                            
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="FinalBillID" HeaderText="FinalbillID" Visible="false"
                                                                            />
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourcekey="BoundFieldResource1">
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Description" 
                                                                            meta:resourcekey="TemplateFieldResource2" Visible="False">
                                                                            <ItemTemplate>
                                                                                <asp:GridView ID="gvChildDetails" runat="server" AutoGenerateColumns="False" 
                                                                                    CssClass="dataheaderInvCtrl w-100p gridView" Font-Names="Verdana" 
                                                                                    Font-Size="9pt" meta:resourceKey="gvChildDetailsResource1">
                                                                                    <Columns>
                                                                                        <asp:TemplateField HeaderText="Description" 
                                                                                            meta:resourceKey="TemplateFieldResource3">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="chkID" runat="server" meta:resourceKey="chkIDResource1" 
                                                                                                    Style="text-align: left;" Text='<%# Eval("Descriptions") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                                            <ItemStyle HorizontalAlign="Left" Width="60%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Billed Amount" 
                                                                                            meta:resourceKey="BoundFieldResource2">
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="RefundAmount" DataFormatString="{0:0.00}" 
                                                                                            HeaderText="Amount Refunded" meta:resourceKey="BoundFieldResource3">
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourcekey="BoundFieldResource4">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourcekey="BoundFieldResource5" />
                                                                        <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency" 
                                                                            meta:resourcekey="BoundFieldResource6" Visible="False">
                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="PaidCurrencyAmount" DataFormatString="{0:0.00}" 
                                                                            HeaderText="Amount Paid" meta:resourcekey="BoundFieldResource7">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <RowStyle VerticalAlign="Top" ForeColor="#000066" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvAllUsers" runat="server" AutoGenerateColumns="False"
                                                                    OnRowDataBound="gvAllUsers_RowDataBound" CssClass="w-100p gridView" Visible="False" OnRowCommand="gvAllUsers_RowCommand"
                                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="gvAllUsersResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Received By" 
                                                                            meta:resourceKey="TemplateFieldResource5">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" 
                                                                                    CommandArgument='<%# Eval("ReceivedBy") %>' CommandName="UserLink" 
                                                                                     Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana; cursor: pointer;" Text='<%# Eval("FinalBillID") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Amount" 
                                                                            meta:resourceKey="TemplateFieldResource6">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblAmtReceived" runat="server" 
                                                                                     Text='<%# bind("AmtReceived") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource8" />
                                                                        <asp:BoundField DataField="ReceivedBy" HeaderText="UserID" 
                                                                            meta:resourceKey="BoundFieldResource9" />
                                                                        <asp:TemplateField HeaderText="Pending Settlement Amount" 
                                                                            meta:resourceKey="TemplateFieldResource7">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblPedningSettledAmt" runat="server" 
                                                                                     Style="text-align: right;" 
                                                                                    Text='<%# bind("PendingSettlementAmt") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" Width="20%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Total Settlement Amount" 
                                                                            meta:resourceKey="TemplateFieldResource8">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblTotalPendingSettlementAmt" runat="server" 
                                                                                     
                                                                                    Text='<%# TotalSettlementAmountCalc(Eval("PendingSettlementAmt"),Eval("AmtReceived")) %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" Width="20%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Settlement Amount" 
                                                                            meta:resourceKey="TemplateFieldResource9">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtAllUserSettledAmt" runat="server" 
                                                                                    meta:resourceKey="txtAllUserSettledAmtResource1" Style="text-align: right;" 
                                                                                    Text="0.00"></asp:TextBox>
                                                                                    <asp:Label ID="lblRefundamt" runat="server" 
                                                                                     Text='<%# bind("RefundAmount") %>' style="display:none;"></asp:Label>
                                                                            </ItemTemplate>
                                                                            <ItemStyle HorizontalAlign="Right" Width="20%" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                            </asp:Panel>
                                                            <asp:Panel ID="pnlRefund" runat="server" GroupingText="Refund / Cancel Details" meta:resourcekey="pnlRefundResource1">
                                                                <asp:Label ID="lblgvRefundDetails" Visible="False" runat="server" meta:resourcekey="lblgvRefundDetailsResource1"></asp:Label>
                                                                <asp:GridView ID="gvRefundDetails" runat="server" AutoGenerateColumns="False" CssClass="w-100p gridView"
                                                                    OnRowDataBound="gvRefundDetails_RowDataBound" Visible="False" BackColor="White"
                                                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Names="Verdana"
                                                                    Font-Size="9pt" meta:resourcekey="gvRefundDetailsResource2">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Bill Number" 
                                                                            meta:resourceKey="TemplateFieldResource10">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lnkBillNumber" runat="server" 
                                                                                    meta:resourceKey="lnkBillNumberResource2" Style="color: Black; font-family: Verdana;
                                                                                    cursor: pointer;" Text='<%# Eval("BillNumber") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="ReceiptNO" HeaderText="Refund Number" 
                                                                            meta:resourceKey="BoundFieldResource10" />
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                                                            meta:resourceKey="BoundFieldResource11" />
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourceKey="BoundFieldResource12">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource13" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvAllUsersRefund" runat="server" AutoGenerateColumns="False" CssClass="w-100p gridView"
                                                                    OnRowDataBound="gvAllUsersRefund_RowDataBound" Visible="False" BackColor="White"
                                                                    BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Names="Verdana"
                                                                    Font-Size="9pt" meta:resourcekey="gvAllUsersRefundResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Refund By" 
                                                                            meta:resourceKey="TemplateFieldResource11">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" 
                                                                                    meta:resourceKey="lnkReceivedNumberResource2" Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana; cursor: pointer;" Text='<%# Eval("FinalBillID") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourceKey="BoundFieldResource14">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource15" />
                                                                        <asp:BoundField DataField="ReceivedBy" HeaderText="UserID" 
                                                                            meta:resourceKey="BoundFieldResource16" />
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
                                                            <asp:Panel ID="pnlPayments" runat="server" GroupingText="Payment Details" meta:resourcekey="pnlPaymentsResource1">
                                                                <asp:Label ID="lblgvPaymentDetails" Visible="False" runat="server" meta:resourcekey="lblgvPaymentDetailsResource1"></asp:Label>
                                                                <asp:GridView ID="gvPaymentDetails" runat="server" AutoGenerateColumns="False" OnRowDataBound="gvPaymentDetails_RowDataBound"
                                                                    Visible="False" CssClass="w-100p gridView" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
                                                                    BorderWidth="1px" CellPadding="3" Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="gvPaymentDetailsResource2">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Doctor Number" 
                                                                            meta:resourceKey="TemplateFieldResource12">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lnkBillNumber" runat="server" 
                                                                                    meta:resourceKey="lnkBillNumber0Resource1" Style="color: Black; font-family: Verdana;
                                                                                    cursor: pointer;" Text='<%# Eval("BillNumber") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="stylenone" />
                                                                            <ItemStyle CssClass="stylenone" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Description" 
                                                                            meta:resourceKey="BoundFieldResource17" />
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourceKey="BoundFieldResource18">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource19" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvAllUsersPayments" runat="server" AutoGenerateColumns="False"
                                                                    OnRowDataBound="gvAllUsersPayments_RowDataBound" Visible="False" CssClass="w-100p gridView"
                                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" OnRowCommand="gvAllUsersPayments_RowCommand"
                                                                    meta:resourcekey="gvAllUsersPaymentsResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Paid By" 
                                                                            meta:resourceKey="TemplateFieldResource13">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" 
                                                                                    CommandArgument='<%# Eval("ReceivedBy") %>' CommandName="UserPaidLink" 
                                                                                     Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana;" Text='<%# Eval("FinalBillID") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourceKey="BoundFieldResource20">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource21" />
                                                                        <asp:BoundField DataField="ReceivedBy" HeaderText="UserID" 
                                                                            meta:resourceKey="BoundFieldResource22" />
                                                                    </Columns>
                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                </asp:GridView>
                                                                <asp:GridView ID="gvAmtPaidDetails" runat="server" AutoGenerateColumns="False" Visible="False"
                                                                   CssClass="w-100p gridView" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                                    CellPadding="3" Font-Names="Verdana" Font-Size="9pt" meta:resourcekey="gvAmtPaidDetailsResource1">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Doctor Number" 
                                                                            meta:resourceKey="TemplateFieldResource14">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lnkBillNumber0" runat="server" 
                                                                                     Style="color: Black; font-family: Verdana;
                                                                                    cursor: pointer;" Text='<%# Eval("ReceiverID") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="stylenone" />
                                                                            <ItemStyle CssClass="stylenone" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="PatientName" HeaderText="Description" 
                                                                            meta:resourceKey="BoundFieldResource23" />
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourceKey="BoundFieldResource24">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="AmtReceivedID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource25" />
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
                                                            <asp:Panel ID="pnlCashIncomeDetails" runat="server" GroupingText="Cash income details"
                                                                meta:resourcekey="pnlCashIncomeDetailsResource1">
                                                                <asp:Label ID="lblgvCashIncomeDetails" Visible="False" runat="server" meta:resourcekey="lblgvCashIncomeDetailsResource1"></asp:Label>
                                                                <asp:GridView ID="gvCashIncomeDetails" runat="server" AutoGenerateColumns="False"
                                                                    Visible="False" CssClass="w-100p gridView" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None"
                                                                    BorderWidth="1px" CellPadding="3" Font-Names="Verdana" Font-Size="9pt" OnRowCommand="gvAllUsers_RowCommand"
                                                                    OnRowDataBound="gvCashIncomeDetails_RowDataBound" meta:resourcekey="gvCashIncomeDetailsResource2">
                                                                    <RowStyle ForeColor="#000066" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Received By" 
                                                                            meta:resourceKey="TemplateFieldResource15">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lnkReceivedNumber" runat="server" 
                                                                                    CommandArgument='<%# Eval("ReceivedBy") %>' CommandName="UserLink" 
                                                                                     Style="color: Black; text-decoration: underline;
                                                                                    font-family: Verdana; cursor: pointer;" Text='<%# Eval("ReceiptNO") %>'></asp:LinkButton>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="Remarks" HeaderText="Description" 
                                                                            meta:resourceKey="BoundFieldResource26" />
                                                                        <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                                            meta:resourceKey="BoundFieldResource27">
                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="FinalBillID" HeaderText="UniqueID" 
                                                                            meta:resourceKey="BoundFieldResource28" Visible="False" />
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
                                                        <td class="v-top a-right">
                                                            <asp:Label runat="server" ID="lblConsreport" meta:resourcekey="lblConsreportResource1"></asp:Label>
                                                            <table class="w-100p">
                                                                <tr>
                                                                    <td class="a-center w-95p">
                                                                        <asp:Label ID="Rs_TotalCollectedAmount" Text="Total Collected Amount" runat="server"
                                                                            meta:resourcekey="Rs_TotalCollectedAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right w-5p">
                                                                        <asp:Label ID="lblTotal" runat="server" Text="0.00" meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblTotalIncAmount" Text="Total Collected Source Amount" runat="server"
                                                                            meta:resourcekey="lblTotalIncAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblTotalInc" runat="server" Text="0.00" meta:resourcekey="lblTotalIncResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="Rs_TotalRefundedAmount" Text="Total Refunded Amount" runat="server"
                                                                            meta:resourcekey="Rs_TotalRefundedAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblRefund" runat="server" Text="0.00" meta:resourcekey="lblRefundResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="Rs_TotalCancelledBillAmount" Text="Total Cancelled Bill Amount" runat="server"
                                                                            meta:resourcekey="Rs_TotalCancelledBillAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblCancelledAmount" runat="server" Text="0.00" meta:resourcekey="lblCancelledAmountResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="Rs_TotalPaidAmounttoPhysician" Text="Total Paid Amount to Physician"
                                                                            runat="server" meta:resourcekey="Rs_TotalPaidAmounttoPhysicianResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblPhyAmount" runat="server" Text="0.00" meta:resourcekey="lblPhyAmountResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="Rs_TotalPaidMiscellaneousAmount" Text="Total Paid Miscellaneous Amount"
                                                                            runat="server" meta:resourcekey="Rs_TotalPaidMiscellaneousAmountResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblOthersAmount" runat="server" Text="0.00" meta:resourcekey="lblOthersAmountResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="Rs_TotalPendingSettledAmt" Text="Total Pending Settlement Amount"
                                                                            runat="server" meta:resourcekey="Rs_TotalPendingSettledAmtResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblTotalPendingSettledAmt" runat="server" Text="0.00" meta:resourcekey="lblTotalPendingSettledAmtResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="Rs_ClosingBalance" Text="Closing Balance" runat="server" meta:resourcekey="Rs_ClosingBalanceResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right">
                                                                        <asp:Label ID="lblClosingBalance" runat="server" Text="0.00" meta:resourcekey="lblClosingBalanceResource1"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr id="trSettledAmt" runat="server">
                                                                    <td class="a-right" runat="server">
                                                                        <asp:Label ID="Rs_settledAmt" Text="Settlement Amount" runat="server" meta:resourcekey="Rs_settledAmtResource1"></asp:Label>
                                                                    </td>
                                                                    <td class="a-right" runat="server">
                                                                        <asp:TextBox ID="txtSettledAmt" runat="server" onblur="ChangeFormat();" Style="text-align: right;"
                                                                            CssClass="Txtboxsmall"></asp:TextBox>
                                                                        <asp:HiddenField ID="hdnClosingAmt" runat="server" Value="0" />
                                                                        <asp:HiddenField ID="hdnCashInHand" runat="server" Value="0" />
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
                                                                                <td class="v-top a-right bold">
                                                                                    <asp:Label ID="Rs_ClosingCashInHand" Text="Closing Cash In Hand:" runat="server"
                                                                                        meta:resourcekey="Rs_ClosingCashInHandResource1"></asp:Label>
                                                                                </td>
                                                                                <td class="a-right">
                                                                                    <asp:Label ID="lblClosingCashInHand" ForeColor="Green" runat="server" Text="0.00"
                                                                                        meta:resourcekey="lblClosingCashInHandResource1"></asp:Label>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="a-center" colspan="2">
                                                                        <asp:Button ID="btnSave" runat="server" CssClass="btn" OnClick="btnSave_Click" onmouseout="this.className='btn'"
                                                                            onmouseover="this.className='btn btnhov'" OnClientClick="javascript:return ValidateAmt();"
                                                                            Text="Settle Amount" meta:resourcekey="btnSaveResource1" />
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
                            <div class="dataheader2">
                                <asp:Panel ID="Panel2" runat="server" GroupingText="Amount Received Breakup For OP"
                                    meta:resourcekey="Panel2Resource1">
                                    <asp:GridView ID="gvINDAmtReceivedDetails" runat="server" AutoGenerateColumns="False"
                                        Visible="False" CssClass="w-75p gridView mytable1" ForeColor="#333333" OnRowDataBound="gvINDAmtReceivedDetails_RowDataBound"
                                        meta:resourcekey="gvINDAmtReceivedDetailsResource1">
                                        <Columns>
                                            <asp:BoundField DataField="Descriptions" HeaderText="Description" meta:resourcekey="BoundFieldResource29">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Qty" HeaderText="Quantity" meta:resourcekey="BoundFieldResource30" />
                                            <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource31">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
                                </asp:Panel>
                                <asp:Panel ID="Panel1" runat="server" GroupingText="Amount Received Breakup For IP"
                                    meta:resourcekey="Panel1Resource1">
                                    <asp:GridView ID="gvIndIPAMountReceived" runat="server" AutoGenerateColumns="False"
                                        Visible="False" CssClass="w-75p gridView mytable1" ForeColor="#333333"  OnRowDataBound="gvINDAmtReceivedDetails_RowDataBound"
                                        meta:resourcekey="gvIndIPAMountReceivedResource1">
                                        <Columns>
                                            <asp:BoundField DataField="Descriptions" HeaderText="Description" meta:resourcekey="BoundFieldResource32">
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Qty" HeaderText="Quantity" meta:resourcekey="BoundFieldResource33" />
                                            <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourcekey="BoundFieldResource34">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
                                </asp:Panel>
                                <asp:Panel ID="Panel3" runat="server" Visible="False" GroupingText="Payments Breakup"
                                    meta:resourcekey="Panel3Resource1">
                                    <asp:GridView ID="gvAmountBreakup" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Font-Bold="False"
                                        Font-Names="Verdana" Font-Overline="False" Font-Size="9pt" Font-Strikeout="False" CssClass="gridView"
                                        Font-Underline="False" meta:resourcekey="gvAmountBreakupResource1">
                                        <RowStyle ForeColor="#000066" />
                                        <Columns>
                                            <asp:BoundField DataField="ClosureStatus" HeaderText="Payment Type" 
                                                meta:resourceKey="BoundFieldResource35" />
                                            <asp:BoundField DataField="AmtReceived" HeaderText="Amount" 
                                                meta:resourceKey="BoundFieldResource36">
                                                <ItemStyle HorizontalAlign="Right" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <HeaderStyle CssClass="grdcolor" Font-Bold="True" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <RowStyle ForeColor="#000066" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                    </asp:GridView>
                                </asp:Panel>
                                <asp:Panel ID="pnlOthers" runat="server" Style="display: none;" CssClass="modalPopup dataheaderPopup"
                                    meta:resourcekey="pnlOthersResource1">
                                    <center>
                                        <div id="divOthers" style="width: 350px; height: 400px; padding-top: 50px; padding-left: 15px">
                                            <table class="a-center w-90p">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvResult" ShowFooter="True" CellPadding="3" runat="server" AutoGenerateColumns="False"
                                                            CssClass="gridView" Font-Names="Verdana" OnRowDataBound="gvResult_RowDataBound" meta:resourcekey="gvResultResource1">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource16">
                                                                    <ItemTemplate>
                                                                        <%# Container.DataItemIndex + 1 %>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="8%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Details" meta:resourcekey="TemplateFieldResource17"
                                                                    Visible="False">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblID" runat="server"  Text='<%# DataBinder.Eval(Container.DataItem,"ClosureID") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Details" meta:resourcekey="TemplateFieldResource18">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDetail" runat="server"  Text='<%# DataBinder.Eval(Container.DataItem,"Rupees") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle Width="30px" />
                                                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Unit" meta:resourcekey="TemplateFieldResource19">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblUnit" runat="server"  Text='<%# DataBinder.Eval(Container.DataItem,"Unit") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <FooterTemplate>
                                                                        <b>
                                                                        <div style="text-align: right">
                                                                            <asp:Label ID="lblTotal" runat="server"  
                                                                                Style="text-align: right" Text="Total:"></asp:Label>
                                                                        </div>
                                                                        </b>
                                                                    </FooterTemplate>
                                                                    <HeaderStyle Width="30px" />
                                                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Amount" meta:resourcekey="TemplateFieldResource20">
                                                                    <FooterTemplate>
                                                                        <div style="text-align: right">
                                                                            <asp:Label ID="lblTotalSum" runat="server" Font-Bold="True" 
                                                                                meta:resourceKey="lblTotalSumResource1"></asp:Label>
                                                                        </div>
                                                                    </FooterTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDetail" runat="server" meta:resourcekey="lblDetailResource2" Text='<%# DataBinder.Eval(Container.DataItem,"Amount") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle Width="30px" />
                                                                    <ItemStyle HorizontalAlign="Right" Width="5%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle CssClass="dataheader1" />
                                                            <PagerStyle CssClass="dataheader1" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    <button id="btnCancel" class="btn">Cancel</button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </center>
                                </asp:Panel>
                            </div>
                        </div>
                        <div class="dataheader2 a-center">
                           <%-- <input id="btnAdd" type="button" class="btn" value="View Denomination" onclick="showModalPopup(event);" />--%>
                            <%--<button  id="btnAdd" class="btn"   onclick="showModalPopup(event);" >View Denomination</button>--%>
                            <asp:Button ID="btnPrint" runat="server" Text="Print" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" OnClientClick="return popupprint();"
                                meta:resourcekey="btnPrintResource1" />
                            <asp:Button ID="btnBack" runat="server" Text="Back" CssClass="btn"
                                onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'" Visible="False"
                                OnClick="btnBack_Click" meta:resourcekey="btnBackResource1" display="none"/>
                            <asp:HiddenField ID="hiddenTargetControlFormpeOthers" runat="server" />
                            <asp:HiddenField ID="hdnShowPopup" runat="server" Value="0" />
                            <asp:HiddenField ID="hdnDenomination" runat="server" Value="0" />
                            <ajc:ModalPopupExtender ID="mpeOthers" runat="server" BehaviorID="mpeOthersBehavior"
                                PopupControlID="pnlOthers" CancelControlID="btnCancel" TargetControlID="hiddenTargetControlFormpeOthers"
                                DynamicServicePath="" Enabled="True">
                            </ajc:ModalPopupExtender>
                        </div>
                         </ContentTemplate>
        </asp:UpdatePanel>
                    </div>
       <Attune:Attunefooter ID="Attunefooter" runat="server" />       

    <script type="text/javascript" language="javascript">
        function DrawTable(BillID) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            //alert(BillID);
            ValidationWindow(BillID, Information);
        }
        //if (document.getElementById('hdnShowPopup').value == "1" && document.getElementById('hdnDenomination').value == "1")
            //document.getElementById('btnAdd').style.display = 'block';
        //else
            //document.getElementById('btnAdd').style.display = 'none';
    </script>

    <asp:HiddenField ID="hdnAmtReceivedID" runat="server" />
    <asp:HiddenField ID="hdnNeedDescription" Value="Y" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    </form>
</body>
</html>
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
        else {
            var skey = "../Reception/ViewPrintPage.aspx"
                           + obj
                           + "&IsPopup=" + "Y"
                           + "&CCPage=Y"
                           + "";

            window.open(skey, 'ViewBill', 'letf=0,top=0,height=640,width=800,toolbar=0,scrollbars=1,status=0');
        }
    }
    function popupprint() {
        var prtContent = document.getElementById('printCashClosure');
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        //alert(WinPrint);
        WinPrint.document.write(prtContent.innerHTML);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }
    function showModalPopup(evt, footDescID, footAmtID) {

        document.getElementById('<%= pnlOthers.ClientID %>').style.display = "none";
        var modalPopupBehavior = $find('mpeOthersBehavior');
        modalPopupBehavior.show();
    }
    function ValidateAmt() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_BillSettlement_aspx_03") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_03") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_BillSettlement_aspx_01") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_01") : "Settlement amount cannot be greater than closing balance amount";
        var userMsg1 = SListForAppMsg.Get("Admin_BillSettlement_aspx_02") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_02") : "Please provide settlement amount";
        if (document.getElementById('ddlUser').value != 0) {
            if (Number($('[id$="txtSettledAmt"]').val()) > 0) {
                if (Number($('[id$="txtSettledAmt"]').val()) > Number($('[id$="hdnClosingAmt"]').val())) {

                    //var userMsg = SListForApplicationMessages.Get("Admin\\BillSettlement.aspx_1");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Settlement amount cannot be greater than closing balance amount');
                        ValidationWindow(userMsg, AlrtWinHdr);
                        return false;
                    }
                    return false;
                }
            }
            else {
                //var userMsg = SListForApplicationMessages.Get("Admin\\BillSettlement.aspx_2");
                if (userMsg1 != null) {
                    // alert(userMsg);
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Please provide settlement amount');
                    ValidationWindow(userMsg1, AlrtWinHdr);
                    return false;
                }
                return false;
            }
        }
        else {
            try {
                var flag = 0, Amtflag = 0;
                var grid = document.getElementById('gvAllUsers');
                var grdlength = grid.rows.length;
                for (var i = 1; i < grdlength; i++) {
                    if (grid.rows[i].cells[4].childNodes[1].value == '' || Number(grid.rows[i].cells[4].childNodes[1].value) <= 0) {
                        flag = 1;
                        break;
                    }
                }
                if (flag == 1) {
                    // var userMsg = SListForApplicationMessages.Get("Admin\\BillSettlement.aspx_3");
                    if (userMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg1, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Provide the settlement Amount');
                        ValidationWindow(userMsg1, AlrtWinHdr);
                        return false;
                    }
                    return false;
                }
            } catch (e) {

            }
            return true;
        }


    }
    function ChangeFormat() {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_BillSettlement_aspx_03") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_03") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_BillSettlement_aspx_01") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_01") : "Settlement amount cannot be greater than closing balance amount";
        document.getElementById('txtSettledAmt').value = format_number(document.getElementById('txtSettledAmt').value, 2);
        if (Number($('[id$="txtSettledAmt"]').val()) > Number($('[id$="hdnClosingAmt"]').val())) {
            // var userMsg = SListForApplicationMessages.Get("Admin\\BillSettlement.aspx_4");
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            else {
                //alert('Settlement amount cannot be greater than closing balance amount');
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            $('[id$="txtSettledAmt"]').val("0.00");
            return false;
        }
    }
    function CalcItemValidation(objtxtAllUserSettledAmt, objlblAmtReceived) {
        var AlrtWinHdr = SListForAppMsg.Get("Admin_BillSettlement_aspx_03") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_03") : "Information";
        var userMsg = SListForAppMsg.Get("Admin_BillSettlement_aspx_01") != null ? SListForAppMsg.Get("Admin_BillSettlement_aspx_01	") : "Settlement amount cannot be greater than closing balance amount";

        var objtxtAmountValue = document.getElementById(objtxtAllUserSettledAmt).value;
        var objlblAmtReceivedValue = document.getElementById(objlblAmtReceived).innerHTML;
        if (parseFloat(objtxtAmountValue) > parseFloat(objlblAmtReceivedValue)) {
            //var userMsg = SListForApplicationMessages.Get("Admin\\BillSettlement.aspx_5");
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            else {
                //alert('Settlement amount cannot be greater than Net amount');
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            document.getElementById(objtxtAllUserSettledAmt).value = '0.00';
            document.getElementById(objtxtAllUserSettledAmt).focus();
            return false;
        }
    }
     function ValidateDate() {
         var AlrtWinHdr = SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_alert") != null ? SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_alert") : "Alert";
         var UsrAlrtMsg3 = SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_11") != null ? SListForAppMsg.Get("Reception_BillSettlementIndividual_aspx_11") : "Please select valid ToDate!!!";

         if (document.getElementById('txtFromDate1').value != "") {

             var getDate = document.getElementById('<%= txtFromDate1.ClientID %>').value;
             var getDate2 = document.getElementById('<%= txtToDate.ClientID %>').value;
             var Flag = true;
//             if (getDate2.substr(6, 4) >= getDate.substr(6, 4)) {
//                 if (getDate2.substr(3, 2) == getDate.substr(3, 2)) {
//                     if (getDate2.substr(0, 2) >= getDate.substr(0, 2)) {
//                         Flag = false;
//                     }
//                 }
//                 else if (getDate2.substr(3, 2) > getDate.substr(3, 2)) {
//                     Flag = false;
//                 }

             //             }

             if (getDate.substr(6, 4) > getDate2.substr(6, 4)) {
                 Flag = false;
             } else if ((getDate.substr(6, 4) == getDate2.substr(6, 4)) && (getDate.substr(3, 2) > getDate2.substr(3, 2))) {
                 Flag = false;
             } else if ((getDate.substr(3, 2) == getDate2.substr(3, 2)) && (getDate.substr(0, 2) > getDate2.substr(0, 2))) {
                 Flag = false;
             }
             if (Flag == false) {
                 ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                 document.getElementById('txtToDate').value = new Date().format('dd/MM/yyyy');
             }
         }
         return Flag;
     }
    </script>