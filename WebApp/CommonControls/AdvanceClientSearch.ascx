<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdvanceClientSearch.ascx.cs"
    Inherits="CommonControls_AdvanceClientSearch" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style type="text/css">
    .style1
    {
        width: 300px;
    }
    .style2
    {
        width: 332px;
    }
    .dataheader3
    {
        margin-right: 2px;
    }
    .style4
    {
        width: 229px;
    }
    .style5
    {
        width: 96px;
    }
</style>

<%--<script src="../Scripts/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/ChangePayMentModes.js" language="javascript" type="text/javascript"></script>



<script type="text/javascript" language="javascript">

    function SetClientID(source, eventArgs) {
        document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();

    }
    function OnselectedClientName(source, eventArgs) {
        document.getElementById('<%=txtClientNameSrch.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%=hdnclientName.ClientID %>').value = eventArgs.get_text();
        document.getElementById('<%=hdnCustomerType.ClientID %>').value = 'C';
        document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();
        document.getElementById('<%=hdnClientTypeID.ClientID %>').value = '0';
    }
    function Clear() {
        document.getElementById('<%=txtClientNameSrch.ClientID %>').value = "";
        document.getElementById('<%=txtFromDate.ClientID %>').value = "";
        document.getElementById('<%=txtToDate.ClientID %>').value = "";
        document.getElementById('<%=ddlType.ClientID %>').selectedIndex = 0;
        return true;
    }
</script>

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Advance Client"
    DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <table width="100%" border="0" cellpadding="2" cellspacing="0" class="dataheader3">
        <tr>
            <td>
                <table>
                    <tr>
                        <td style="width: 10%">
                            <asp:Label runat="server" ID="lblClientName" Text="Client Name"></asp:Label>
                        </td>
                        <td style="width: 19%">
                            <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                AutoComplete="off"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientNameSrch"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                MinimumPrefixLength="3" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                OnClientItemSelected="OnselectedClientName" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                Enabled="True" UseContextKey="True">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td style="width: 10%" align="left">
                            <asp:Label ID="lblType" Text="Type" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                        </td>
                        <td style="padding-left: 1%">
                            <asp:DropDownList ID="ddlType" runat="server" TabIndex="5" CssClass="ddlsmall">
                                <asp:ListItem>Collection</asp:ListItem>
                                <asp:ListItem>Refund</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 10%">
                            <asp:Label ID="lblFromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource2"></asp:Label>
                        </td>
                        <td style="width: 19%">
                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall" TabIndex="1"
                                meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromDate"
                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                CultureTimePlaceholder="" Enabled="True" />
                            <asp:ImageButton ID="ImgBntFromDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" Height="13px" TabIndex="2" meta:resourcekey="ImgBntFromDateResource1" />
                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                Format="dd/MM/yyyy" PopupButtonID="ImgBntFromDate" Enabled="True" />
                        </td>
                        <td style="width: 10%" align="left">
                            <asp:Label ID="lblToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource2"></asp:Label>
                        </td>
                        <td style="padding-left: 1%">
                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall" TabIndex="3" meta:resourcekey="txtToDateResource1"></asp:TextBox>
                            <ajc:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToDate"
                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                CultureTimePlaceholder="" Enabled="True" />
                            <asp:ImageButton ID="ImgBntToDate" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                CausesValidation="False" Height="13px" TabIndex="4" meta:resourcekey="ImgBntToDateResource1" />
                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                Format="dd/MM/yyyy" PopupButtonID="ImgBntToDate" Enabled="True" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="4" style="padding-bottom: 10px;" align="center">
                <asp:Button ID="btnSearch" runat="server" Text="Search" Height="25px" Width="50px"
                    CssClass="btn1" onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                    OnClick="btnSearch_Click" meta:resourceKey="btnSearchResource1" />
                &nbsp;
                <input id="btnCancel" class="btn" style="width: 50px;" type="button" value="Reset" onclick="Clear();" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="5" cellspacing="0">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourceKey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td align="center">
                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="grdResult_PageIndexChanging"
                    meta:resourceKey="grdResultResource1" CssClass="mytable1" CellPadding="2" ForeColor="#333333">
                    <HeaderStyle CssClass="dataheader1" />
                    <Columns>
                        <asp:BoundField DataField="ClientName" HeaderText="ClientName" meta:resourceKey="BoundFieldResource1" />
                        <asp:BoundField DataField="DepositedDate" HeaderText="DepositedDate" meta:resourceKey="BoundFieldResource2">
                        </asp:BoundField>
                        <asp:BoundField DataField="PaymentType" HeaderText="PaymentType" meta:resourceKey="BoundFieldResource3">
                        </asp:BoundField>
                        <asp:BoundField DataField="AmountDeposited" HeaderText="AmountDeposited" meta:resourceKey="BoundFieldResource4" />
                        <asp:BoundField DataField="ReceiptNo" HeaderText="ReceiptNo" meta:resourceKey="BoundFieldResource5" />
                    </Columns>
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:GridView ID="gridRefund" runat="server" AutoGenerateColumns="False"
                    meta:resourceKey="gridRefundResource1" CssClass="mytable1" CellPadding="2" ForeColor="#333333">
                    <HeaderStyle CssClass="dataheader1" />
                    <Columns>
                        <asp:BoundField DataField="ClientName" HeaderText="ClientName" meta:resourceKey="BoundFieldResource1" />
                        <asp:BoundField DataField="DepositedDate" HeaderText="DepositedDate" meta:resourceKey="BoundFieldResource2">
                        </asp:BoundField>
                        <asp:BoundField DataField="PaymentType" HeaderText="PaymentType" meta:resourceKey="BoundFieldResource3">
                        </asp:BoundField>
                        <asp:BoundField DataField="RefundAmount" HeaderText="RefundAmount" meta:resourceKey="BoundFieldResource4" />
                        <asp:BoundField DataField="ReceiptNo" HeaderText="ReceiptNo" meta:resourceKey="BoundFieldResource5" />
                    </Columns>
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
            <td align="center" colspan="10" class="defaultfontcolor">
                <asp:Label ID="Label1" runat="server" Text="Page"></asp:Label>
                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                <asp:HiddenField ID="hdnCurrent" runat="server" />
                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                <asp:TextBox ID="txtpageNo" runat="server" Width="30px"></asp:TextBox>
                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
            </td>
        </tr>
        <asp:HiddenField ID="hdnTempFromPeriod" runat="server" />
        <asp:HiddenField ID="hdnTempToPeriod" runat="server" />
        <asp:HiddenField ID="hdnRefundstatus" runat="server" />
        <asp:HiddenField ID="hdnReceivedAmount" runat="server" />
        <asp:HiddenField ID="hdnRefundAmount" runat="server" />
        <asp:HiddenField ID="hdnTotalAmount" runat="server" />
        <asp:HiddenField ID="hdnClientID" runat="server" />
    </table>
    <input type="hidden" id="hdnBillStatus" runat="server"></input>
    <input type="hidden" id="hdnCollectionType" runat="server"></input>
    <asp:HiddenField ID="hdnAmt" runat="server" />
    <input id="bid" name="bid" type="hidden" />
    <asp:HiddenField ID="hdnClientPortal" runat="server" />
    <input type="hidden" runat="server" id="hdnclientName" />
    <input type="hidden" runat="server" id="hdnCustomerType" />
    <input type="hidden" runat="server" id="hdnClientTypeID" />
</asp:Panel>
