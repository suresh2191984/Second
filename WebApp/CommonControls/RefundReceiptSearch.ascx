<%@ Control Language="C#" AutoEventWireup="true" CodeFile="RefundReceiptSearch.ascx.cs"
    Inherits="CommonControls_RefundReceiptSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />-->

<script type="text/javascript" language="javascript">

    function getMessage(v1, v2, v3, v4, v5, v6, v7, v8, v9) {
        var ans;
        ans = window.confirm('Do you wish to take Print?');
        //          alert(v1);
        //          alert(v2);
        //          alert(v3);
        //          alert(v4);
        //          //alert (ans);
        if (ans == true) {
            //alert(ans);
            var strFeatures = "toolbar=no,status=no,menubar=no,location=no";
            strFeatures = strFeatures + ",scrollbars=yes,resizable=yes,height=600,width=800";
            strFeatures = strFeatures + ",left=0,top=0";

            if (v2 > 0) {
                var strURL = "../Billing/RefundVoucher.aspx?BillNo="
               + v1
               + "&VID=" + v2
               + "&Name=" + v3
               + "&IsPopup=Y"
               + "&RefundAmount=" + v4 + ""
               + "&RefundVoucherNo=" + v5 + ""
               + "&Date=" + v6 + ""
               + "&BilledBy=" + v7 + ""
               + "&PAge=" + v8 + ""
               + "&PNumber=" + v9 + "";
               window.open(strURL, "", strFeatures, true);
            }
            else {
//                var strURL = "../admin/PrintVoucherPage.aspx?Amount="
//            + v4
//            + "&dDate=" + v6
//            + "&VONO=" + v5
//            + "&OID=" + v1
//            + "&RNAME=" + v3 + ""
                //            + "&BBy=" + v7 + "";
                var strURL = "../admin/PrintVoucherPage.aspx?VONO=" + v5
            + "&OID=" + v1;
            window.open(strURL, "", strFeatures, true);
            }
           
            
            //window.print();
 
        }
        else {


        }
    }

    function doValidate() {
        var patient = document.getElementById("<%=txtPatientName.ClientID %>").value;
        var bill = document.getElementById("<%=txtRefundNo.ClientID %>").value;
        var ddlstatus = document.getElementById('<%=ddlRegisterDate.ClientID %>').value;

        if (patient.trim() == '' && bill.trim() == '' && ddlstatus == -1) {
            alert('Provide value for one of the fields');
            return false;
        }
        else {
            if (patient.trim().length < 3 && patient.trim() != '' && (bill.trim() == '')) {
                alert('Name must have atleast three characters');
                return false;
            }
        }
        return true;
    }
    function reset() {
        document.getElementById('<%=txtPatientName.ClientID %>').value = '';
        document.getElementById('<%=txtRefundNo.ClientID %>').value = '';

    }
    function ShowRegDate() {
        document.getElementById('<%=txtFromDate.ClientID %>').value = "";
        document.getElementById('<%=txtToDate.ClientID %>').value = "";

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
            document.getElementById('<%=txtFromDate.ClientID %>').value = "";
            document.getElementById('<%=txtToDate.ClientID %>').value = "";
            document.getElementById('<%=txtFromDate.ClientID %>').value = "";
            document.getElementById('<%=txtToDate.ClientID %>').value = "";
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
</script>

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Vouchers Issued"
    Style="color: #000000;" DefaultButton="btnRefundSearch" meta:resourcekey="pnlPSearchResource1">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" class="dataheader3">
        <tr>
            <td align="left">
                <asp:Label ID="lblPatientNo" runat="server" Text="Patient No"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPatientNo" runat="server" MaxLength="255" CssClass="Txtboxsmall"></asp:TextBox>
            </td>
           
            <td align="left">
                <asp:Label ID="Rs_RefundDate" runat="server" Text="Refund Date" meta:resourcekey="Rs_RefundDateResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                    CssClass="ddlsmall" runat="server" meta:resourcekey="ddlRegisterDateResource1">
                    <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource2">This Week</asp:ListItem>
                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource3">This Month</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource4">This Year</asp:ListItem>
                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource5">Custom Period</asp:ListItem>
                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource6">Today</asp:ListItem>
                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource7">Last Week</asp:ListItem>
                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource8">Last Month</asp:ListItem>
                    <asp:ListItem Value="7" meta:resourcekey="ListItemResource9">Last Year</asp:ListItem>
                </asp:DropDownList>
            </td>
            <td>
                <div id="divRegDate" style="display: none" runat="server">
                    <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate1Resource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                    <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate1Resource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                </div>
                <div id="divRegCustomDate" runat="server" style="display: none;">
                    <asp:Label ID="Rs_FromDate2" runat="server" Text="From Date" meta:resourcekey="Rs_FromDate2Resource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    <asp:Label ID="Rs_ToDate2" runat="server" Text="To Date" meta:resourcekey="Rs_ToDate2Resource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourcekey="MaskedEditValidator1Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                </div>
            </td>
        </tr>
        <tr>
            <td align="left">
                <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name" meta:resourcekey="Rs_PatientNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPatientName" runat="server" CssClass="Txtboxsmall" MaxLength="255"
                    meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
            </td>
           <td align="left">
                <asp:Label ID="Rs_RefundNo" runat="server" Text="Refund No" meta:resourcekey="Rs_RefundNoResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtRefundNo" runat="server" MaxLength="255" CssClass="Txtboxsmall"
                    meta:resourcekey="txtRefundNoResource1"></asp:TextBox>
            </td>
            </tr>
            <tr>
            <td colspan="4" align="center">
                <asp:Button ID="btnRefundSearch" runat="server" CssClass="btn" OnClick="btnRefundSearch_Click"
                    onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov1'"
                    Text="Search" meta:resourcekey="btnRefundSearchResource1" />
                <input class="btn" type="button" id="btnCancel" value="Reset" onclick="getElementById('').value='';getElementById('').value='';
                    getElementById('').options[0].selected=true;return ShowRegDate()" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" id="tablebilID" visible="False" runat="server" class="defaultfontcolor"
        border="0" cellpadding="2" cellspacing="2">
        <tr runat="server">
            <td runat="server">
                <table border="0" id="searchTab" runat="server" cellpadding="4" cellspacing="0" width="100%">
                    <tr runat="server">
                        <td runat="server">
                            <asp:GridView ID="grdResult" EmptyDataText="No Matching Records Found!" Width="100%"
                                runat="server" AllowPaging="True" CellPadding="2" AutoGenerateColumns="False"
                                OnRowDataBound="grdResult_RowDataBound" ForeColor="#333333" OnPageIndexChanging="grdResult_PageIndexChanging"
                                CssClass="mytable1">
                                <Columns>
                                    <asp:TemplateField HeaderText="Refund No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBillID" runat="server" Text='<%# Eval("ClientName")%>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="Name" HeaderText="Name" />
                                    <%--<asp:BoundField DataField="Comments" HeaderText="Reason" />--%>
                                    <asp:BoundField DataField="NetValue" HeaderText="Amount">
                                        <ItemStyle HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="CreatedAt" DataFormatString="{0:dd MMM yyyy hh:mm tt}"
                                        HeaderText="Refund Date" />
                                    <asp:TemplateField HeaderText="Print">
                                        <ItemTemplate>
                                            <input type="button" id="rdSel" runat="server" title="Print Voucher" class="btn"
                                                value="Print Voucher" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <HeaderStyle CssClass="dataheader1" />
                                <PagerStyle CssClass="dataheader1" />
                            </asp:GridView>
                        </td>
                    </tr>
                </table>
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
    <input type="hidden" id="hdnBillStatus" runat="server"> </input>
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
    </script> </asp:Panel>
