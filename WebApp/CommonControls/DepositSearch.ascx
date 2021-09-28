<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DepositSearch.ascx.cs"
    Inherits="CommonControls_DepositSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />-->

<script type="text/javascript" language="javascript">
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
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
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
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
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
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "4") {
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';


        }
        if (document.getElementById('<%= ddlRegisterDate.ClientID %>').value == "5") {
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
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
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
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
            //            document.getElementById('<%=txtFromDate.ClientID %>').disabled = true;
            //            document.getElementById('<%=txtToDate.ClientID %>').disabled = true;
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

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Collect Deposit"
    Style="color: #000000;" DefaultButton="btnSearch" Width="100%" meta:resourcekey="pnlPSearchResource1">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="dataheader3">
        <tr>
            <td align="right">
                <asp:Label ID="Rs_PatientNo" Text="Patient No" runat="server" meta:resourceKey="Rs_PatientNoResource1" />
            </td>
            <td>
                <asp:TextBox AutoComplete="off" ID="txtPatientNo" runat="server" MaxLength="255"
                    CssClass="txtboxps" meta:resourceKey="txtPatientNoResource1"></asp:TextBox>
            </td>
            <td align="right">
                <asp:Label ID="Rs_PatientName" Text="Patient Name" runat="server" meta:resourceKey="Rs_PatientNameResource1" />
            </td>
            <td>
                <asp:TextBox AutoComplete="off" ID="txtPatientName" runat="server" CssClass="txtboxps"
                    MaxLength="255" meta:resourceKey="txtPatientNameResource1"></asp:TextBox>
            </td>
            <td align="right">
                <asp:Label ID="Rs_DepositDate" Text="Deposit Date" runat="server" meta:resourceKey="Rs_DepositDateResource1" />
            </td>
            <td>
                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                    CssClass="ddlTheme" runat="server" meta:resourceKey="ddlRegisterDateResource1">
                    <asp:ListItem Value="-1" Selected="True" meta:resourceKey="ListItemResource1">--Select--</asp:ListItem>
                    <asp:ListItem Value="0" meta:resourceKey="ListItemResource2">This Week</asp:ListItem>
                    <asp:ListItem Value="1" meta:resourceKey="ListItemResource3">This Month</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourceKey="ListItemResource4">This Year</asp:ListItem>
                    <asp:ListItem Value="3" meta:resourceKey="ListItemResource5">Custom Period</asp:ListItem>
                    <asp:ListItem Value="4" meta:resourceKey="ListItemResource6">Today</asp:ListItem>
                    <asp:ListItem Value="5" meta:resourceKey="ListItemResource7">Last Week</asp:ListItem>
                    <asp:ListItem Value="6" meta:resourceKey="ListItemResource8">Last Month</asp:ListItem>
                    <asp:ListItem Value="7" meta:resourceKey="ListItemResource9">Last Year</asp:ListItem>
                </asp:DropDownList>
                <div id="divRegDate" style="display: none" runat="server">
                    <asp:Label ID="Rs1_FromDate" Text="From Date" runat="server" meta:resourceKey="Rs1_FromDateResource1" />
                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourceKey="txtFromDateResource1"></asp:TextBox>
                    <asp:Label ID="Rs1_ToDate" Text="To Date" runat="server" meta:resourceKey="Rs1_ToDateResource1" />
                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourceKey="txtToDateResource1"></asp:TextBox>
                </div>
                <div id="divRegCustomDate" runat="server" style="display: none;">
                    <asp:Label ID="Rs_FromDate" Text="From Date" runat="server" meta:resourceKey="Rs_FromDateResource1" />
                    <asp:TextBox Width="70px" ID="txtFromPeriod" runat="server" meta:resourceKey="txtFromPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourceKey="ImgBntCalcFromResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFromPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender1"
                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" meta:resourceKey="MaskedEditValidator1Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFromPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    <asp:Label ID="Rs_ToDate" Text="To Date" runat="server" meta:resourceKey="Rs_ToDateResource1" />
                    <asp:TextBox Width="70px" runat="server" ID="txtToPeriod" meta:resourceKey="txtToPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourceKey="ImgBntCalcToResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtToPeriod"
                        Mask="99/99/9999" MaskType="Date" ErrorTooltipEnabled="True" CultureAMPMPlaceholder=""
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" CultureDatePlaceholder=""
                        CultureDecimalPlaceholder="" CultureThousandsPlaceholder="" CultureTimePlaceholder=""
                        Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator2" runat="server" ControlExtender="MaskedEditExtender2"
                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator2" meta:resourceKey="MaskedEditValidator2Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtToPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                </div>
            </td>
            <td>
                <asp:Button ID="btnSearch" runat="server" CssClass="btn1" onmouseout="this.className='btn1'"
                    onmouseover="this.className='btn1 btnhov1'" Text="Search" OnClick="btnSearch_Click"
                    meta:resourceKey="btnSearchResource1" />
                &nbsp;
                <input class="btn1" type="button" id="btnCancel" value="Reset" onclick="getElementById('').value='';getElementById('').value='';var now = new Date();
                    getElementById('').options[0].selected=true;return ShowRegDate()" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourceKey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td>
                <asp:GridView ID="gvDeposit" runat="server" CellPadding="1" AutoGenerateColumns="False"
                    Width="100%" AllowPaging="True" PageSize="15" class="mytable1" OnPageIndexChanging="gvDeposit_PageIndexChanging"
                    meta:resourceKey="gvDepositResource1">
                    <Columns>
                        <asp:TemplateField HeaderText="Patient Number" meta:resourceKey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:Label ID="lblNo" runat="server" meta:resourceKey="lblNoResource1" Text='<%# Bind("PatientNumber") %>'
                                    Width="40px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Patient Name" meta:resourceKey="TemplateFieldResource2">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" meta:resourceKey="lblNameResource1" Text='<%# Bind("Name") %>'
                                    Width="180px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Age" meta:resourceKey="TemplateFieldResource3">
                            <ItemTemplate>
                                <asp:Label ID="lblAge" runat="server" meta:resourceKey="lblAgeResource1" Text='<%# Bind("Age") %>'
                                    Width="60px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date" meta:resourceKey="TemplateFieldResource4">
                            <ItemTemplate>
                                <asp:Label ID="lblAge" runat="server" meta:resourceKey="lblAgeResource2" Text='<%# Bind("CreatedAt") %>'
                                    Width="120px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Contact No" meta:resourceKey="TemplateFieldResource5">
                            <ItemTemplate>
                                <asp:Label ID="lblContactNo" runat="server" meta:resourceKey="lblContactNoResource1"
                                    Text='<%# Bind("MobileNumber") %>' Width="90px"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Deposit Amount" meta:resourceKey="TemplateFieldResource6">
                            <ItemTemplate>
                                <asp:Label ID="lblTDA" runat="server" meta:resourceKey="lblTDAResource1" Text='<%# Bind("TotalDepositAmount") %>'
                                    Width="60px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Deposit Used" meta:resourceKey="TemplateFieldResource7">
                            <ItemTemplate>
                                <asp:Label ID="lblTDU" runat="server" meta:resourceKey="lblTDUResource1" Text='<%# Bind("TotalDepositUsed") %>'
                                    Width="60px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Balance Amount" meta:resourceKey="TemplateFieldResource8">
                            <ItemTemplate>
                                <asp:Label ID="lblBA" runat="server" meta:resourceKey="lblBAResource1" Text='<%# Bind("DepositBalance") %>'
                                    Width="60px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Refunded Amount" meta:resourceKey="TemplateFieldResource9">
                            <ItemTemplate>
                                <asp:Label ID="lblRefund" runat="server" meta:resourceKey="lblRefundResource1" Text='<%# Bind("AmtRefund") %>'
                                    Width="90px"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:TemplateField>
                        <asp:TemplateField meta:resourceKey="TemplateFieldResource10">
                            <ItemTemplate>
                                <asp:HyperLink ID="lnkID" runat="server" Font-Bold="True" Font-Size="12px" Font-Underline="True"
                                    ForeColor="Black" meta:resourceKey="lnkIDResource1" NavigateUrl='<%# String.Format("../Billing/DepositRefund.aspx?PID={0}&DID={1}",Eval("PatientID"),Eval("DepositID")) %>'
                                    Target="_self" Text="Deposit Refund" ToolTip="Click To View Details"></asp:HyperLink>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                    <PagerStyle HorizontalAlign="Center" />
                    <RowStyle Height="10px" />
                </asp:GridView>
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
        </input>
    <input id="bid" name="bid" type="hidden" />

    <script language="javascript" type="text/javascript">

        if (document.getElementById('').value == "1" && document.getElementById('').value == "1") {
            document.getElementById('').style.display = 'none';
            document.getElementById('').style.display = 'none';
            document.getElementById('').style.display = 'block';
            document.getElementById('').style.display = 'block';
            document.getElementById('').style.display = 'inline';
            document.getElementById('').style.display = 'inline';
        }
        if (document.getElementById('').value != "" && document.getElementById('').value != "") {
            document.getElementById('').style.display = 'block';
            document.getElementById('').style.display = 'block';
            document.getElementById('').style.display = 'none';
            document.getElementById('').style.display = 'none';
            document.getElementById('').style.display = 'inline';
            document.getElementById('').style.display = 'inline';
        }
    </script>

</asp:Panel>
