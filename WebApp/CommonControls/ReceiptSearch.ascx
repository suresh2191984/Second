<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReceiptSearch.ascx.cs"
    Inherits="CommonControls_ReceiptSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />-->

<script type="text/javascript" language="javascript">
    function SelectAdvance() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vAdvanceAmt = SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_01') == null ? "Advance Amount cannot be Refund" : SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_01');
        
        var userMsg = SListForApplicationMessages.Get('CommonControls\\ReceiptSearch.ascx_1');
        if (userMsg != null) {
            alert(userMsg);
            return false;
        }
        else {
            //alert("Advance Amount cannot be Refund");
            ValidationWindow(vAdvanceAmt, AlertType);
            return false;
        }
    }
    function SelectCopayment() {
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vCoPaymentAmt = SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_02') == null ? "Co payment Amount cannot be Refund" : SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_02');
        
        var userMsg = SListForApplicationMessages.Get('CommonControls\\ReceiptSearch.ascx_2');
        if (userMsg != null) {
            alert(userMsg);
            return false;
        }
        else {
            //alert("Co payment Amount cannot be Refund");
            ValidationWindow(vCoPaymentAmt, AlertType);
            return false;
        }
    }
    function SelectReceiptPatientDischarged() {
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vDischargePatient = SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_03') == null ? "Discharged Patient Receipt Cannot be Refund" : SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_03');
        
        var userMsg = SListForApplicationMessages.Get('CommonControls\\ReceiptSearch.ascx_3');
        if (userMsg != null) {
            alert(userMsg);
            return false;
        }
        else {
            //alert("Discharged Patient Receipt Cannot be Refund");\
            ValidationWindow(vDischargePatient, AlertType);
            return false;
        }
    }
    function ShowRegDate() {
        document.getElementById('<%=txtFromDate.ClientID %>').value = "";
        document.getElementById('<%=txtToDate.ClientID %>').value = "";
        document.getElementById('<%=txtFromPeriod.ClientID %>').value = "";
        document.getElementById('<%=txtToPeriod.ClientID %>').value = "";
        document.getElementById('<%=hdnTempFrom.ClientID %>').value = "";
        document.getElementById('<%=hdnTempTo.ClientID %>').value = "";

        document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "0";
        document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "0";
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "0") {

            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayWeek.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayWeek.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "1") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayMonth.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayMonth.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "2") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnFirstDayYear.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastDayYear.ClientID %>').value

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';

        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "3") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value = "1";
            document.getElementById('<%=hdnTempToPeriod.ClientID %>').value = "1";

        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "-1") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "4") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "5") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastWeekFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastWeekLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "6") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastMonthFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastMonthLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "7") {
            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;
            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnLastYearFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnLastYearLast.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
    }
    function checkForValues() {
        /* Added By Venkatesh S */
        var AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
        var vPageNo = SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_04') == null ? "Please Enter Page No" : SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_04');
        var vCorrectPageNo = SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_05') == null ? "Please Enter Correct Page No" : SListForAppMsg.Get('CommonControls_ReceiptSearch_ascx_05');
                
        if (document.getElementById('uctrlBillSearch_' + 'txtpageNo').value == "") {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ReceiptSearch.ascx_4');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                //alert("Please Enter Page No");
                ValidationWindow(vPageNo, AlertType);
                return false;
            }
        }

        if (Number(document.getElementById('uctrlBillSearch_' + 'txtpageNo').value) < Number(1)) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ReceiptSearch.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                //alert("Please Enter Correct Page No");
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }
        }

        if (Number(document.getElementById('uctrlBillSearch_' + 'txtpageNo').value) > Number(document.getElementById('uctrlBillSearch_' + 'lblTotal').innerText)) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\ReceiptSearch.ascx_5');
            if (userMsg != null) {
                alert(userMsg);
                return false;
            }
            else {
                //alert("Please Enter Correct Page No");
                ValidationWindow(vCorrectPageNo, AlertType);
                return false;
            }
        }




    }
</script>

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Receipts Issued"
    Style="color: #000000;" DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource2"
    CssClass="w-100p">
    <table class="w-100p marginB0">
        <tr>
            <td class="a-right">
                <asp:Label ID="lblpatno" runat="server" Text="Patient No" meta:resourcekey="lblpatnoResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPatientNo" Height="15px" Width="128px" runat="server" MaxLength="255"
                    CssClass="Txtboxsmall" meta:resourcekey="txtPatientNoResource2"></asp:TextBox>
            </td>
            <td class="a-right">
                <asp:Label ID="lblreceiptno" runat="server" Text="Receipt No" meta:resourcekey="lblreceiptnoResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="255" Height="15px" Width="128px"
                    CssClass="Txtboxsmall" meta:resourcekey="txtBillNoResource2"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="a-right">
                <asp:Label ID="lblpatname" runat="server" Text="Patient Name" meta:resourcekey="lblpatnameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" MaxLength="255"
                    Height="15px" Width="128px" meta:resourcekey="txtPatientNameResource2"></asp:TextBox>
            </td>
            <td class="a-right">
                <asp:Label ID="lblrecptdt" runat="server" Text="Receipt Date" meta:resourcekey="lblrecptdtResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                    CssClass="ddlsmall" runat="server" >
                   <%-- <asp:ListItem Value="-1" meta:resourcekey="ListItemResource16">--Select--</asp:ListItem>
                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource17">This Week</asp:ListItem>
                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource18">This Month</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource19">This Year</asp:ListItem>
                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource20">Custom Period</asp:ListItem>
                    <asp:ListItem Value="4" Selected="True" meta:resourcekey="ListItemResource21">Today</asp:ListItem>
                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource22">Last Week</asp:ListItem>
                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource23">Last Month</asp:ListItem>
                    <asp:ListItem Value="7" meta:resourcekey="ListItemResource24">Last Year</asp:ListItem>--%>
                </asp:DropDownList>
                <div id="divRegDate" style="display: none" runat="server">
                    <asp:Label ID="lbfromdt" runat="server" Text="From Date" meta:resourcekey="lbfromdtResource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource2"></asp:TextBox>
                    <asp:Label ID="lbtodt" runat="server" Text="To Date" meta:resourcekey="lbtodtResource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource2"></asp:TextBox>
                </div>
                <div id="divRegCustomDate" runat="server" style="display: none;">
                    <asp:Label ID="lblfrmdt" runat="server" Text="From Date" meta:resourcekey="lblfrmdtResource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource2"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource2" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource2" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    <asp:Label ID="lbltodate" runat="server" Text="To Date" meta:resourcekey="lbltodateResource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource2"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource2" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourcekey="MaskedEditValidator2Resource2" />
                    <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                </div>
            </td>
        </tr>
        <tr>
            <td class="a-right">
                <asp:Label ID="lblrecpttype" runat="server" Text="Receipt Type" meta:resourcekey="lblrecpttypeResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlReceiptType" CssClass="ddlsmall" runat="server" Width="93px"
                   >
                    <%--<asp:ListItem Text="Select" Value="0" meta:resourcekey="ListItemResource25"></asp:ListItem>
                    <asp:ListItem Text="IP Payments" Value="1" meta:resourcekey="ListItemResource26"></asp:ListItem>
                    <asp:ListItem Text="Advance" Value="2" meta:resourcekey="ListItemResource27"></asp:ListItem>
                    <asp:ListItem Text="Deposit" Value="3" meta:resourcekey="ListItemResource28"></asp:ListItem>
                    <asp:ListItem Text="Co Payment" Value="4" meta:resourcekey="ListItemResource29"></asp:ListItem>
                    <asp:ListItem Text="Cash In Flow" Value="6" meta:resourcekey="ListItemResource30"></asp:ListItem>
                    <asp:ListItem Text="Due Receipt" Value="7" meta:resourcekey="ListItemResource4"></asp:ListItem>--%>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="4" class="a-center">
                <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                    onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov1'"
                    Text="Search" meta:resourcekey="btnSearchResource2" />
                &nbsp;<%--<asp:Button ID="btnCancel" runat="server" CssClass="btn1" 
                    OnClick="btnCancel_Click" onmouseout="this.className='btn1'" 
                    onmouseover="this.className='btn1 btnhov1'" Text="Reset" />--%>
                <input id="btnCancel" class="btn1" onclick="getElementById('<%= txtPatientName.ClientID %>').value='';getElementById('<%= txtBillNo.ClientID %>').value='';var now = new Date();
                    getElementById('<%= ddlRegisterDate.ClientID %>').options[0].selected=true;return ShowRegDate()"
                    type="button" value="Reset" />
            </td>
        </tr>
    </table>
    <table class="w-100p">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource2"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="w-100p">
        <tr>
            <td>
                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" DataKeyNames="BillNumber"
                    OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource2"
                    CssClass="w-100p">
                    <HeaderStyle CssClass="dataheader1" />
                    <Columns>
                        <asp:BoundField DataField="BillNumber" HeaderText="Receipt No" meta:resourceKey="BoundFieldResource6">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" meta:resourceKey="BoundFieldResource7">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource8">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle Width="25%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd MMM yyyy hh:mm tt}"
                            HeaderText="Receipt Date" meta:resourceKey="BoundFieldResource9">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourceKey="BoundFieldResource10">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Print" meta:resourceKey="TemplateFieldResource4">
                            <ItemTemplate>
                                <input id="rdSel" runat="server" class="btn" title="Print Receipt" type="button"
                                    value="Print Receipt"></input>
                                </input> </input>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Refund" meta:resourceKey="TemplateFieldResource5">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkID" runat="server" Font-Bold="True" Font-Size="12px" Font-Underline="True"
                                    ForeColor="Black" meta:resourceKey="lnkIDResource2" Target="_self" Text="Refund"
                                    ToolTip="Click To View Details"></asp:HyperLink>
                            </ItemTemplate>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Duplicate Receipt" meta:resourceKey="TemplateFieldResource6">
                            <ItemTemplate>
                                <input id="chkDuplicate" runat="server" class="btn" title="Duplicate Receipt" type="checkbox"></input>
                                </input> </input>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" Width="12%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
            <td class="defaultfontcolor a-center" runat="server">
                <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red" meta:resourcekey="lblCurrentResource1"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                <asp:Label ID="lblTotal" runat="server" Font-Bold="True" meta:resourcekey="lblTotalResource1"></asp:Label>
                <asp:Button ID="Btn_Previous" runat="server" Text="Previous" CssClass="btn" OnClick="Btn_Previous_Click"
                    meta:resourcekey="Btn_PreviousResource1" />
                <asp:Button ID="Btn_Next" runat="server" Text="Next" CssClass="btn" OnClick="Btn_Next_Click"
                    meta:resourcekey="Btn_NextResource1" />
                <asp:HiddenField ID="hdnCurrent" runat="server" />
                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                <asp:TextBox ID="txtpageNo" runat="server" CssClass="Txtboxsmall" Width="30px"    onkeypress="return ValidateOnlyNumeric(this);"  
                    meta:resourcekey="txtpageNoResource1"></asp:TextBox>
                <asp:Button ID="btnGo1" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click1"
                    meta:resourcekey="btnGo1Resource1" />
                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
            </td>
        </tr>
    </table>
    <asp:HiddenField ID="hdnFirstDayWeek" runat="server" />
    <asp:HiddenField ID="hdnLastDayWeek" runat="server" />
    <asp:HiddenField ID="hdnFirstDayMonth" runat="server" />
    <asp:HiddenField ID="hdnLastDayMonth" runat="server" />
    <asp:HiddenField ID="hdnFirstDayYear" runat="server" />
    <asp:HiddenField ID="hdnLastDayYear" runat="server" />
    <asp:HiddenField ID="hdnDateImage" runat="server" />
    <asp:HiddenField ID="hdnTempFrom" runat="server" />
    <asp:HiddenField ID="hdnTempTo" runat="server" />
    <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
    <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
    <asp:HiddenField ID="hdnLastMonthFirst" runat="server" />
    <asp:HiddenField ID="hdnLastMonthLast" runat="server" />
    <asp:HiddenField ID="hdnLastWeekFirst" runat="server" />
    <asp:HiddenField ID="hdnLastWeekLast" runat="server" />
    <asp:HiddenField runat="server" ID="hdnLastYearFirst" />
    <asp:HiddenField ID="hdnLastYearLast" runat="server" />
    <input type="hidden" id="hdnBillStatus" runat="server" />
    <input id="bid" name="bid" type="hidden" />

    <script language="javascript" type="text/javascript">

        if (document.getElementById('<%=hdnTempFromPeriod.ClientID %>').value == "1" && document.getElementById('<%=hdnTempToPeriod.ClientID %>').value == "1") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'inline';
        }
        if (document.getElementById('<%=hdnTempFrom.ClientID %>').value != "" && document.getElementById('<%=hdnTempTo.ClientID %>').value != "") {
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
        }
    </script>

</asp:Panel>
