<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DailyBillPrint.aspx.cs" Inherits="Admin_DailyBillPrint" meta:resourcekey="PageResource1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
      <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />
--%>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <style type="text/css" media="print">
        #header, #footer
        {
            display: none;
        }
    </style>

    <script src="../Scripts/Common.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
        window.name = "ReportWindow";
        window.resizeTo(1024, 768);
    </script>
    <style type="text/css">
        .style1
        {
            width: 80%;
            height: 28px;
        }
        .style2
        {
            height: 28px;
        }
        .style3
        {
            width: 80%;
        }
        .style4
        {
            height: 26px;
        }
        .style5
        {
            width: 80%;
            height: 26px;
        }
    </style>
</head>
<body id="oneColLayout" >
    <form id="form1" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <table cellpadding="0" cellspacing="0" border="0" style="font-family:Arial; font-weight:bold;"  width="95%">
    <tr>
    <td align="right">
      <asp:Label ID="Rs_ExportToExcel" Text="  Export To Excel" runat="server" 
            meta:resourcekey="Rs_ExportToExcelResource1"></asp:Label>
     <asp:ImageButton ID="btnXL" OnClick="btnXL_Click" runat="server" 
                                                        
            ImageUrl="../Images/ExcelImage.GIF"   ToolTip="Save As Excel" 
            meta:resourcekey="btnXLResource1" />                                         
                                                  
    
    </td>
    </tr>
    </table>
    <table id="resultTab" runat="server" cellpadding="0" cellspacing="0" border="0" style="font-family:Arial;"  width="95%">
    
    <tr>
        <td>
        <table id="orgHeaderTab"  runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                <tr>
                                <td id="orgHeaderTextForReport" align="center" runat="server" style="color:#000000; font-size:12px; font-weight:bold;">
                                
                                </td>
                                </tr>
                                <tr>
                                <td id="dateTextForReport" align="left" runat="server" style="color:#000000;font-size:12px; font-weight:bold; padding-top:20px;">
                                
                                </td>
                                 
                               </tr></table>
                               
                               <br />
                               
                               <table id="cashBillTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                        <tr>
                                        <td style="font-weight:bold; font-size:14px;">
                                       <asp:Label ID="Rs_CashBills" Text="CashBills" runat="server" 
                                                meta:resourcekey="Rs_CashBillsResource1"></asp:Label>
                                        </td>
                                        </tr>
                                        
                                        <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        <tr>
                                        <td>
        <asp:GridView ID="grdResultCashBill" runat="server" Font-Names="arial" Font-Size="12px" Font-Bold="False" 
                                                RowStyle-Font-Bold="false" AutoGenerateColumns="False"  GridLines="None" 
                                                Width="100%" meta:resourcekey="grdResultCashBillResource1">
<RowStyle Font-Bold="False"></RowStyle>
            <Columns>
                <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" 
                    meta:resourcekey="BoundFieldResource1" />
                
                <asp:BoundField DataField="BillID" HeaderStyle-HorizontalAlign="left" HeaderText="Bill No"
               ItemStyle-HorizontalAlign="Left" ItemStyle-Width="6%" 
                    meta:resourcekey="BoundFieldResource2">
                    <HeaderStyle HorizontalAlign="Left" Width="6%"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </asp:BoundField>
                
              <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                        HeaderText="Bill Date" 
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%" 
                    meta:resourcekey="BoundFieldResource3">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource4">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Age" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource5">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ReferingPhysicianName" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Physicain Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="20%" meta:resourcekey="BoundFieldResource6">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                    </asp:BoundField>
                                                 
                                                    <asp:BoundField DataField="ClientName" 
                    HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                        Visible="false" 
                    meta:resourcekey="BoundFieldResource7">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <%--<asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="GrossAmount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Bill Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%" Visible="true" 
                    meta:resourcekey="BoundFieldResource8">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Discount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Discount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource9">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AmountReceived" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Amount Received" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource10">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                    </asp:BoundField>
                                                     <asp:BoundField DataField="AmountDue" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Due Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource11">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
        </asp:GridView>
        
         </td></tr>
                                             <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        </table>
                                        <table id="creditBillTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                             <tr>
                                        <td style="font-weight:bold; font-size:14px;">
                                       <asp:Label ID="Rs_CreditBills" Text="CreditBills" runat="server" 
                                                meta:resourcekey="Rs_CreditBillsResource1"></asp:Label>
                                        </td>
                                        </tr>
                                        
                                        <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        <tr>
                                        <td>
          <asp:GridView ID="grdResultCreditBill" runat="server" Font-Names="arial" Font-Size="12px" Font-Bold="False" 
                                                RowStyle-Font-Bold="false" AutoGenerateColumns="False"  GridLines="None" 
                                                Width="100%" meta:resourcekey="grdResultCreditBillResource1">
<RowStyle Font-Bold="False"></RowStyle>
            <Columns>
                <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" 
                    meta:resourcekey="BoundFieldResource12" />
                
                <asp:BoundField DataField="BillID" HeaderStyle-HorizontalAlign="left" HeaderText="Bill No"
               ItemStyle-HorizontalAlign="Left" ItemStyle-Width="6%" 
                    meta:resourcekey="BoundFieldResource13">
                    <HeaderStyle HorizontalAlign="Left" Width="6%"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </asp:BoundField>
                
              <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                        HeaderText="Bill Date" 
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%" 
                    meta:resourcekey="BoundFieldResource14">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource15">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Age" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource16">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ReferingPhysicianName" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Physicain Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="20%" meta:resourcekey="BoundFieldResource17">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                    </asp:BoundField>
                                                 
                                                    <asp:BoundField DataField="ClientName" 
                    HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                        Visible="false" 
                    meta:resourcekey="BoundFieldResource18">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    </asp:BoundField>
                                                   <%-- <asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="GrossAmount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Bill Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%" Visible="true" 
                    meta:resourcekey="BoundFieldResource19">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Discount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Discount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource20">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AmountReceived" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Amount Received" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource21">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                    </asp:BoundField>
                                                     <asp:BoundField DataField="AmountDue" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Due Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource22">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
        </asp:GridView>
        
         </td></tr>
                                             <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        </table>
                                        <table id="dueAmountReceivedTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                            <tr>
                                        <td style="font-weight:bold; font-size:14px;">
                                        <asp:Label ID="Rs_DueAmountReceivedBills" Text="Due Amount Received Bills" 
                                                runat="server" meta:resourcekey="Rs_DueAmountReceivedBillsResource1"></asp:Label>
                                        </td>
                                        </tr>
                                        
                                        <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        <tr>
                                        <td>
        
          <asp:GridView ID="grdResultDueReceivedBill" runat="server" Font-Names="arial" Font-Size="12px" Font-Bold="False" 
                                                RowStyle-Font-Bold="false" AutoGenerateColumns="False"  GridLines="None" 
                                                Width="100%" meta:resourcekey="grdResultDueReceivedBillResource1">
<RowStyle Font-Bold="False"></RowStyle>
            <Columns>
                <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" 
                    meta:resourcekey="BoundFieldResource23" />
                
                <asp:BoundField DataField="BillID" HeaderStyle-HorizontalAlign="left" HeaderText="Bill No"
               ItemStyle-HorizontalAlign="Left" ItemStyle-Width="6%" 
                    meta:resourcekey="BoundFieldResource24">
                    <HeaderStyle HorizontalAlign="Left" Width="6%"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </asp:BoundField>
                
              <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                        HeaderText="Bill Date" 
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%" 
                    meta:resourcekey="BoundFieldResource25">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource26">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Age" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource27">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ReferingPhysicianName" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Physicain Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="20%" meta:resourcekey="BoundFieldResource28">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                    </asp:BoundField>
                                                 
                                                    <asp:BoundField DataField="ClientName" 
                    HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                        Visible="false" 
                    meta:resourcekey="BoundFieldResource29">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <%--<asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="GrossAmount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Bill Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%" Visible="true" 
                    meta:resourcekey="BoundFieldResource30">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Discount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Discount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource31">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AmountReceived" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Amount Received" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource32">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                    </asp:BoundField>
                                                     <asp:BoundField DataField="AmountDue" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Due Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                    meta:resourcekey="BoundFieldResource33">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
        </asp:GridView>
        
         </td></tr>
                                             <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        </table>
                                        <table id="cancelledBillTab" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                                             <tr>
                                        <td style="font-weight:bold; font-size:14px;">
                                       <asp:Label ID="Rs_CancelledBills" Text="Cancelled Bills" runat="server" 
                                                meta:resourcekey="Rs_CancelledBillsResource1"></asp:Label>
                                        </td>
                                        </tr>
                                        
                                        <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                        <tr>
                                        <td>
        
             <asp:GridView ID="grdResultCancelledBill" runat="server" Font-Names="arial" Font-Size="12px" Font-Bold="False" 
                                                RowStyle-Font-Bold="false" AutoGenerateColumns="False"  GridLines="None" 
                                                Width="100%" meta:resourcekey="grdResultCancelledBillResource1">
<RowStyle Font-Bold="False"></RowStyle>
            <Columns>
                <asp:BoundField DataField="BillID" HeaderText="BillID" Visible="false" 
                    meta:resourcekey="BoundFieldResource34" />
                
                <asp:BoundField DataField="BillID" HeaderStyle-HorizontalAlign="left" HeaderText="Bill No"
               ItemStyle-HorizontalAlign="Left" ItemStyle-Width="6%" 
                    meta:resourcekey="BoundFieldResource35">
                    <HeaderStyle HorizontalAlign="Left" Width="6%"></HeaderStyle>
                    <ItemStyle HorizontalAlign="Left"></ItemStyle>
                </asp:BoundField>
                
              <asp:BoundField DataField="BillDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}" HeaderStyle-HorizontalAlign="Left"
                                                        HeaderText="Bill Date" 
                    ItemStyle-HorizontalAlign="Left" ItemStyle-Width="14%" 
                    meta:resourcekey="BoundFieldResource36">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="14%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Name" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Patient Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="15%" meta:resourcekey="BoundFieldResource37">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="15%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Age" 
                    HeaderStyle-HorizontalAlign="Left" HeaderText="Age"
                                                        ItemStyle-HorizontalAlign="Left" 
                    Visible="true" ItemStyle-Width="8%" meta:resourcekey="BoundFieldResource38">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ReferingPhysicianName" 
                                        HeaderStyle-HorizontalAlign="Left" HeaderText="Physicain Name"
                                                        ItemStyle-HorizontalAlign="Left" 
                                      Visible="true" ItemStyle-Width="20%" meta:resourcekey="BoundFieldResource39">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Left" Width="20%"></ItemStyle>
                                                    </asp:BoundField>
                                                 
                                                    <asp:BoundField DataField="ClientName" 
                                       HeaderStyle-HorizontalAlign="left" HeaderText="ClientName"
                                                        Visible="false" 
                                        meta:resourcekey="BoundFieldResource40">
                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                    </asp:BoundField>
                                                   <%-- <asp:BoundField DataField="IsCredit" HeaderText="Credit Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IsDue" HeaderText="Due Bill" HeaderStyle-HorizontalAlign="left"
                                                        Visible="true" ItemStyle-Width="8%">
                                                        <HeaderStyle HorizontalAlign="Left" Width="8%"></HeaderStyle>
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="GrossAmount" 
                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Bill Amount" 
                    ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%" Visible="true" 
                    meta:resourcekey="BoundFieldResource41">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Discount" 
                                    DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Discount" 
                                   ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                        Visible="true" 
                                        meta:resourcekey="BoundFieldResource42">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="AmountReceived" 
                                            DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Amount Received" 
                                   ItemStyle-HorizontalAlign="Right" ItemStyle-Width="12%"
                                                        Visible="true" 
                                                meta:resourcekey="BoundFieldResource43">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="12%"></ItemStyle>
                                                    </asp:BoundField>
                                                      <asp:BoundField DataField="AmountDue" 
                                                  DataFormatString="{0:0.00}" HeaderStyle-HorizontalAlign="right"
                                                        HeaderText="Due Amount" 
                                                 ItemStyle-HorizontalAlign="Right" ItemStyle-Width="8%"
                                                         Visible="true" 
                                                        meta:resourcekey="BoundFieldResource44">
                                                        <HeaderStyle HorizontalAlign="Right"></HeaderStyle>
                                                        <ItemStyle HorizontalAlign="Right" Width="8%"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
                                               </asp:GridView>
        
                                              </td></tr>
                                             <tr>
                                        <td>
                                        &nbsp;
                                        </td>
                                        </tr>
                                            </table>
        
          
                                                <table cellpadding="4" style="font-weight:bold;" cellspacing="0" border="0" width="100%">
                                                <tr style="color:Black;">
                                                <td align="right" class="style3">
                                                <asp:Label ID="Rs_CashBillAmount" Text="Cash Bill Amount" runat="server" 
                                                        meta:resourcekey="Rs_CashBillAmountResource1"></asp:Label>
                                                </td>
                                                <td id="tdCashAmount" runat="server" align="right">
                                                
                                                </td>
                                                </tr>
                                                <tr style="color:Black;">
                                                <td align="right" class="style1">
                                              <asp:Label ID="Rs_DueAmountReceived" Text="Due Amount Received" runat="server" 
                                                        meta:resourcekey="Rs_DueAmountReceivedResource1"></asp:Label>
                                                </td>
                                                <td id="tdDueReceivedAmount" runat="server" align="right" class="style2">
                                                
                                                </td>
                                                </tr>
                                                <tr style="color:Black;">
                                                <td align="right" class="style5">
                                               <asp:Label ID="Rs_CreditBillAmount" Text="Credit Bill Amount" runat="server" 
                                                        meta:resourcekey="Rs_CreditBillAmountResource1"></asp:Label>
                                                </td>
                                                <td id="tdCreditAmount" runat="server" align="right" class="style4">
                                                
                                                </td>
                                                </tr>
                                                <tr>
                                                <td colspan="2" align="right" class="style4">
                                                ---------------------------------------------------
                                                </td>
                                                </tr>
                                                 <tr style="color:Black;">
                                                <td align="right" class="style5">
                                              <asp:Label ID="Rs_DiscountAmount" Text="Discount Amount" runat="server" 
                                                        meta:resourcekey="Rs_DiscountAmountResource1"></asp:Label>
                                                </td>
                                                <td id="tdDiscountAmount" runat="server" align="right" class="style4">
                                                
                                                </td>
                                                </tr>
                                                 <tr style="color:Black;">
                                                <td align="right" class="style3">
                                                <asp:Label ID="Rs_PendingDueAmount" Text="Pending Due Amount" runat="server" 
                                                        meta:resourcekey="Rs_PendingDueAmountResource1"></asp:Label>
                                                </td>
                                                <td id="tdPendingDueAmount" runat="server" align="right">
                                                
                                                </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2" align="right">
                                                ---------------------------------------------------
                                                </td>
                                                </tr>
                                                <tr>
                                                <td align="right" class="style3">
                                               <asp:Label ID="Rs_TotalAmount" Text="Total Amount" runat="server" 
                                                        meta:resourcekey="Rs_TotalAmountResource1"></asp:Label>
                                                </td>
                                                <td id="tdTotalAmount" runat="server" align="right">
                                                
                                                </td>
                                                </tr>
                                                </table>
                                        
        
        
        
       </td>
    </tr>
    </table> 
   </form>
     <script language="javascript" type="text/javascript">
         window.print();
       
    </script>

</body>
</html>
