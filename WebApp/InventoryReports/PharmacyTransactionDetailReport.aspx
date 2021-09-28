<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PharmacyTransactionDetailReport.aspx.cs"
    Inherits="InventoryReports_PharmacyTransactionDetailReport" meta:resourcekey="PageResource1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Pharmacy Transaction Details</title>

    <script language="javascript" type="text/javascript">
        function validateToDate() {

            if (document.getElementById('txtFromDate').value == '') {
                alert('Provide / select value for From date');
                document.getElementById('txtFDate').focus();
                return false;
            }
            if (document.getElementById('txtToDate').value == '') {
                alert('Provide / select value for To date');
                document.getElementById('txtTDate').focus();
                return false;
            }
        }
        function popupprint() {
            var prtContent;
            var radioValue = $("[id*=rdotypes] input:checked");
            document.getElementById('tblHostional').style.display = "block";
            var PrtLog = document.getElementById('tblHostional');
            if (radioValue.val() == "Summary") {
                prtContent = document.getElementById('prnSummary');
            } else {
                prtContent = document.getElementById('prnReport');
            }
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(PrtLog.innerHTML);
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            //   WinPrint.close();
            document.getElementById('tblHostional').style.display = "none";
            return false;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="scriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <table id="tblCollectionOPIP" class="dataheader2 defaultfontcolor" align="center"
            width="100%">
            <tr align="center">
                <td align="left">
                    <div class="dataheaderWider">
                        <table id="tbl" width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="lblFrom" Text="From :" runat="server" meta:resourcekey="lblFromResource1" />
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtFromDate" OnKeyPress="return ValidateSpecialAndNumeric(event);"
                                        CssClass="xsmaller datePicker" Width="70px" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblTo" Text="To :" runat="server" meta:resourcekey="Label1Resource1" />
                                </td>
                                <td>
                                    <asp:TextBox runat="server" ID="txtToDate" OnKeyPress="return ValidateSpecialAndNumeric(event);"
                                        CssClass="xsmaller datePicker" Width="70px" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                                </td>
                                <td nowrap="nowrap">
                                    <asp:Panel ID="pnvisitType" runat="server" CssClass="divscheduler-border w-90p lh20"
                                        GroupingText="Visit Type">
                                        <asp:RadioButtonList ID="rbtVisitType" RepeatDirection="Horizontal" runat="server"
                                            meta:resourcekey="rbtVisitTypeResource1">
                                            <asp:ListItem Text="OP" Selected="True" Value="0" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            <asp:ListItem Text="IP" Value="1" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                            <asp:ListItem Text="Both" Value="-1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td nowrap="nowrap">
                                    <asp:Panel ID="pnReportType" runat="server" CssClass="divscheduler-border w-90p lh20"
                                        GroupingText="Report Type" meta:resourcekey="pnReportTypeResource1">
                                        <asp:RadioButtonList ID="rdotypes" CssClass="w-100p" runat="server" RepeatDirection="Horizontal"
                                            meta:resourcekey="rdotypesResource2">
                                            <asp:ListItem Text="Summary" Selected="True" Value="Summary"></asp:ListItem>
                                            <asp:ListItem Text="Details" Value="Details"></asp:ListItem>
                                        </asp:RadioButtonList>
                                    </asp:Panel>
                                </td>
                                <td align="left" style="width: 20px;">
                                    <asp:Button ID="btnSubmit" runat="server" Text="Get Report" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                        onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                        OnClick="btnSubmit_Click" meta:resourcekey="btnSubmitResource1" />
                                </td>
                                <td align="left">
                                    <asp:LinkButton ID="lnkBack" runat="server" CssClass="btn" OnClick="lnkBack_Click"
                                        Text="Back" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                </td>
                                <td align="left" style="width: 20px;">
                                    <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="~/PlatForm/Images/ExcelImage.GIF"
                                        ToolTip="Save As Excel" Style="width: 16px" OnClick="imgBtnXL_Click" meta:resourcekey="imgBtnXLResource1" />
                                </td>
                                <td align="left">
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/PlatForm/Images/printer.gif"
                                        OnClientClick="return popupprint();" ToolTip="Print" meta:resourcekey="ImageButton1Resource1" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr id="prnReport" runat="server">
                <td>
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" Visible="False"
                                    HeaderStyle-Height="25px" FooterStyle-Height="25px" CellPadding="1"
                                    Width="100%" HorizontalAlign="Right" BorderStyle="Ridge"
                                    OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" 
                                    CssClass="dataheader2" meta:resourcekey="grdResultResource1">
                                   <FooterStyle Height="25px"></FooterStyle>

                                    <HeaderStyle CssClass="dataheader1" />
                                    <RowStyle HorizontalAlign="Left" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="BillNumber" 
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReceiptDate" runat="server" 
                                                    Text='<%# Eval("BillNumber").ToString() %>' 
                                                    meta:resourcekey="lblReceiptDateResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Receipt Number" 
                                            meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReceiptDate" runat="server" 
                                                    Text='<%# Eval("ReceiptNo").ToString() %>' 
                                                    meta:resourcekey="lblReceiptDateResource2"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UHID" meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPatientNumber" runat="server" 
                                                    Text='<%# Eval("PatientNumber").ToString() %>' 
                                                    meta:resourcekey="lblPatientNumberResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                            meta:resourcekey="BoundFieldResource1">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DiscountAmount" HeaderText="Discount Amount" 
                                            DataFormatString="{0:0.00}" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BillAmount" HeaderText="Amount" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource2">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Physician Name">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhysicianName" runat="server" Text='<%# Eval("PhysicianName").ToString()%>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:BoundField DataField="ReceiverName" HeaderText="Billed By"></asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                        <tr>
                            <td align="right">
                                <table runat="server" id="tbTotalCal" style="display: none;">
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCashAmount" Text="Cash Sales   " runat="server" 
                                                meta:resourcekey="lblCashAmountResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblCashAmounttxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblCashAmounttxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCrdeitAmount" Text="Credit Sales   " runat="server" 
                                                meta:resourcekey="lblCrdeitAmountResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblCreditamounttxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblCreditamounttxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblAdvaceAmt" Text=" Advance Receipt Amount " runat="server" 
                                                meta:resourcekey="lblAdvaceAmtResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblAdvaceAmttxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblAdvaceAmttxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblGrandTotal" Text="Total Sales   " runat="server" 
                                                meta:resourcekey="lblGrandTotalResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblGrandTotalText" Text="0.00" runat="server" 
                                                meta:resourcekey="lblGrandTotalTextResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lbldiscountamt" Text="Total Discount  " runat="server" 
                                                 />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lbldiscountamttxt" Text="0.00" runat="server" 
                                               />
                                        </td>
                                    </tr>
                                    <tr style="display: none;">
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRefundAmt" Text="Return Sales " runat="server" 
                                                meta:resourcekey="lblRefundAmtResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblRefundAmttxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblRefundAmttxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCashReturnSale" Text="Cash Sales Return(-) " runat="server" 
                                                meta:resourcekey="lblCashReturnSaleResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblCashReturnSaletxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblCashReturnSaletxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblRefundCrdeitReturn" Text="Credit Sales Reurn(-) " 
                                                runat="server" meta:resourcekey="lblRefundCrdeitReturnResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblRefundCrdeitReturntxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblRefundCrdeitReturntxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblGrandTotalAmount" Text="Grand Total  " runat="server" 
                                                meta:resourcekey="lblGrandTotalAmountResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblGrandTotalAmounttxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblGrandTotalAmounttxtResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <br />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCashInHand" Text="Total Cash In Hand  " runat="server" 
                                                meta:resourcekey="lblCashInHandResource1" />
                                        </td>
                                        <td>
                                            :
                                        </td>
                                        <td align="right">
                                            <asp:Label ID="lblCashInHandtxt" Text="0.00" runat="server" 
                                                meta:resourcekey="lblCashInHandtxtResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr id="prnSummary" runat="server">
               <td>
                 <table width="100%">
                        <tr>
                            <td align="center">
                                <asp:GridView ID="grdSummary" runat="server" AutoGenerateColumns="False" Visible="False"
                                    HeaderStyle-Height="25px" FooterStyle-Height="25px" CellPadding="1"
                                    Width="100%" HorizontalAlign="Right" BorderStyle="Ridge"
                                    OnRowDataBound="grdviewSummary_RowDataBound" ForeColor="#333333" 
                                    CssClass="dataheader2" meta:resourcekey="grdSummaryResource2">
                                   <FooterStyle Height="25px"></FooterStyle>

                                    <HeaderStyle CssClass="dataheader1" />
                                    <RowStyle HorizontalAlign="Left" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Bill Number" 
                                            meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBillNumber" runat="server" 
                                                    Text='<%# Eval("BillNumber").ToString() %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="BillDate" HeaderText="Billed Date"
                                                meta:resourcekey="BoundFieldResource3">
                                            <ItemStyle HorizontalAlign="Left"/>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Receipt Number" 
                                            meta:resourcekey="TemplateFieldResource3">
                                            <ItemTemplate>
                                                <asp:Label ID="lblReceiptNo" runat="server" 
                                                    Text='<%# Eval("ReceiptNo").ToString() %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="UHID" meta:resourcekey="TemplateFieldResource4">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPatientNumber" runat="server" 
                                                    Text='<%# Eval("PatientNumber").ToString() %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name" 
                                            meta:resourcekey="BoundFieldResource1">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="BillAmount" HeaderText="Gross Amount" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                         <asp:BoundField DataField="DiscountAmount" HeaderText="Discount" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource5" >
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NetValue" HeaderText="Net Value" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource6">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DepositUsed" HeaderText="Deposit Used" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource15">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ReceivedAmt" HeaderText="Received" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource16">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RefundAmt" HeaderText="Due Refund" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource17">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DueAmount" HeaderText="Due Amount" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource18">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DueCollected" HeaderText="Due Paid" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource19">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Discount" HeaderText="Due Discount" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource20">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <%--<asp:BoundField DataField="Payertype" HeaderText="Payment Mode" 
                                             meta:resourcekey="BoundFieldResource14">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Cash" HeaderText="Cash" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource7">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Cards" HeaderText="Cards" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource8">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DD" HeaderText="DD" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource9">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Cheque" HeaderText="Cheque" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource10">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PaidCurrency" HeaderText="Paid Currency"
                                              meta:resourcekey="BoundFieldResource11">
                                            <ItemStyle HorizontalAlign="Left" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PaidCurrencyAmount" HeaderText="Paid Currency Amount" 
                                            DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource12">
                                            <ItemStyle HorizontalAlign="Right" />
                                        </asp:BoundField>
                                        <%--<asp:TemplateField HeaderText="Physician Name" meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPhysicianName" runat="server" Text='<%# Eval("PhysicianName").ToString()%>'>
                                                </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:BoundField DataField="ReceiverName" HeaderText="Billed By" meta:resourcekey="BoundFieldResource13">
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
               </td>
            </tr>
        </table>
    </div>
    <div id="tblHostional" style="display: none;">
        <table>
            <tr>
                <td valign='bottom'>
                    <img id="imgPath" runat="server" />
                </td>
                <td>
                    <asp:Label ID="lblHosital" runat="server" Style="font-weight: bold;" 
                        meta:resourcekey="lblHositalResource1" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="center">
                    <asp:Label ID="lblReport" runat="server" Style="font-weight: bold;" 
                        meta:resourcekey="lblReportResource1" />
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />

    <script type="text/javascript">
        $(function() {
            $("#txtFromDate").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '2008:2030'
            });
            $("#txtToDate").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '2008:2030'
            })
        });
		
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>

    </form>
</body>
</html>
