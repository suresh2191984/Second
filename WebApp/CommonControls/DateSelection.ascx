<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DateSelection.ascx.cs"
    Inherits="CommonControls_DateSelection" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        width: 95px;
    }
    .style2
    {
        width: 200px;
    }
</style>

<script type="text/javascript" language="javascript">
    /* Common Alert Validation */
    var AlertType;
//    $(document).ready(function() {
//        AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');
//    });
    function chkdateEmpty(ctrlId) {
       // debugger;
        /* Added By Venkatesh S */
        var vSelectDateRange = SListForAppMsg.Get('CommonControls_DateSelection_ascx_01') == null ? "Select Date Range" : SListForAppMsg.Get('CommonControls_DateSelection_ascx_01');
        var vProvideFromDate = SListForAppMsg.Get('CommonControls_DateSelection_ascx_02') == null ? "Provide FromDate" : SListForAppMsg.Get('CommonControls_DateSelection_ascx_02');
        var vProvideToDate = SListForAppMsg.Get('CommonControls_DateSelection_ascx_03') == null ? "Provide ToDate" : SListForAppMsg.Get('CommonControls_DateSelection_ascx_03');
      var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        var ddlDate = ctrlId + '_ddlRegisterDate';
        var fromdate = ctrlId + '_txtFromPeriod';
        var todate = ctrlId + '_txtToPeriod';
        var ddlID = document.getElementById(ddlDate);
        if (ddlID.options[ddlID.selectedIndex].value == "-1") {
                ValidationWindow(vSelectDateRange, AlertType);
            return false;
        }
        if(ddlID.options[ddlID.selectedIndex].value=="3" && document.getElementById(fromdate).value=="") {
                ValidationWindow(vProvideFromDate, AlertType);
            return false;
        }
        if(ddlID.options[ddlID.selectedIndex].value=="3" && document.getElementById(todate).value=="") {
                ValidationWindow(vProvideToDate, AlertType);

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
            
            document.getElementById('<%=txtFromDate.ClientID %>').value = document.getElementById('<%=hdnTodayFirst.ClientID %>').value;
            document.getElementById('<%=txtToDate.ClientID %>').value = document.getElementById('<%=hdnTodayFirst.ClientID %>').value;

            document.getElementById('<%=hdnTempFrom.ClientID %>').value = document.getElementById('<%=hdnTodayFirst.ClientID %>').value;
            document.getElementById('<%=hdnTempTo.ClientID %>').value = document.getElementById('<%=hdnTodayFirst.ClientID %>').value;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
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

<table class="w-100p">
    <tr>
        <td class="a-left w-12p">
            <asp:Label ID="Rs_BillDate" runat="server" Text="Date Range" meta:resourcekey="Rs_BillDateResource1"></asp:Label>
        </td>
        <td class="w-22p">
            <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                CssClass="ddlTheme ddlsmall" runat="server" ToolTip="Select Date Range" meta:resourcekey="ddlRegisterDateResource1">
               <%-- <asp:ListItem Value="-1" Selected="True" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                <asp:ListItem Value="0" meta:resourcekey="ListItemResource2">This Week</asp:ListItem>
                <asp:ListItem Value="1" meta:resourcekey="ListItemResource3">This Month</asp:ListItem>
                <asp:ListItem Value="2" meta:resourcekey="ListItemResource4">This Year</asp:ListItem>
                <asp:ListItem Value="3" meta:resourcekey="ListItemResource5">Custom Period</asp:ListItem>
                <asp:ListItem Value="4" meta:resourcekey="ListItemResource6">Today</asp:ListItem>
                <asp:ListItem Value="5" meta:resourcekey="ListItemResource7">Last Week</asp:ListItem>
                <asp:ListItem Value="6" meta:resourcekey="ListItemResource8">Last Month</asp:ListItem>
                <asp:ListItem Value="7" meta:resourcekey="ListItemResource9">Last Year</asp:ListItem>--%>
            </asp:DropDownList>
            <img src="../Images/starbutton.png" alt="" class="v-middle" />
        </td>
        <td class="w-7p">
        </td>
        <td class="w-70p a-left">
            <div id="divRegDate" style="display: none" runat="server">
                <table class="w-60p">
                    <tr>
                        <td class="w-30p a-left">
                            <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate1Resource1"></asp:Label>
                            <asp:TextBox ID="txtFromDate" CssClass="small" runat="server" meta:resourceKey="txtFromDateResource1"></asp:TextBox>
                        </td>
                        <td class="w-30p a-right">
                            <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate1Resource1"></asp:Label>
                            <asp:TextBox runat="server" ID="txtToDate" CssClass="small" meta:resourceKey="txtToDateResource1"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divRegCustomDate" runat="server" style="display: none;">
                <table class="w-80p">
                    <tr>
                        <td id="tdAutoDate" class="w-40p a-left" runat="server">
                            <asp:Label ID="Rs_FromDate2" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate2Resource1"></asp:Label>
                            <asp:TextBox ID="txtFromPeriod" CssClass="small" runat="server" meta:resourceKey="txtFromPeriodResource1"></asp:TextBox>
                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" meta:resourceKey="ImgBntCalcFromResource1" />
                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True" />
                            <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                                ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourceKey="MaskedEditValidator1Resource1" />
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                        </td>
                        <td class="w-40p a-right" id="tdCustomDate" runat="server">
                            <asp:Label ID="Rs_ToDate2" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate2Resource1"></asp:Label>
                            <asp:TextBox CssClass="small" runat="server" ID="txtToPeriod" meta:resourceKey="txtToPeriodResource1"></asp:TextBox>
                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" meta:resourceKey="ImgBntCalcToResource1" />
                            <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                                Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                                CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                                CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                                Enabled="True" />
                            <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                                ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                Display="Dynamic" TooltipMessage="(dd/mm/yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourceKey="MaskedEditValidator2Resource1" />
                            <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                                Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                        </td>
                    </tr>
                </table>
                </div>
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
        <asp:HiddenField ID="hdnBillNumber" runat="server" />
        <asp:HiddenField ID="hdnRefundstatus" runat="server" />
        <asp:HiddenField ID="hdnTodayFirst" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
