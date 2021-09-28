<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdvancePatientSearch.ascx.cs"
    Inherits="CommonControls_AdvancePatientSearch" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
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

<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

<%--<script src="../Scripts/jquery-1.3.2.js" type="text/javascript"></script>--%>

<%--<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>--%>

<script src="../Scripts/ChangePayMentModes.js" language="javascript" type="text/javascript"></script>

<script type="text/javascript" language="javascript">
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
        document.getElementById('<%=ddlocations.ClientID %>').selectedIndex = 0;
        return true;
    }
</script>

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Advance Client's Patient"
    DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" class="dataheader3">
        <tr>
            <td>
                <asp:Label runat="server" ID="lblVisitNumber" Text="Client Name"></asp:Label>
            </td>
            <td>
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
            <td>
                <asp:Label ID="lblLocation" Text="Location" runat="server" />
            </td>
            <td>
                <asp:DropDownList ID="ddlocations" runat="server" TabIndex="5" CssClass="ddlsmall">
                </asp:DropDownList>
            </td>
            <td colspan="4" width="44%">
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblFromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource2"></asp:Label>
            </td>
            <td>
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
            <td>
                <asp:Label ID="lblToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource2"></asp:Label>
            </td>
            <td>
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
            <td colspan="4" width="44%">
            </td>
        </tr>
        <tr>
            <td>
            </td>
            <td>
            </td>
            <td>
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" Style="height: 24px;"
                    onmouseover="this.className='btn1 btnhov1'" onmouseout="this.className='btn1'"
                    OnClick="btnSearch_Click" meta:resourceKey="btnSearchResource1" />
                &nbsp;
                <input id="btnCancel" class="btn" type="button" value="Reset" onclick="return Clear();" />
            </td>
            <td>
            </td>
            <td colspan="4" width="44%">
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
        <tr id="trlegend" runat="server" style="display: none">
            <td align="left">
                <asp:TextBox ID="txtStatColor" Style="background-color: gray; vertical-align: text-top"
                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                <asp:Label ID="lblStatTestColor" Text="Client Bill" runat="server"></asp:Label>
                <asp:TextBox ID="txtInvoiceColor" Style="background-color: Lime; vertical-align: text-top"
                    ReadOnly="True" runat="server" Height="5px" Width="5px"></asp:TextBox>
                <asp:Label ID="Label4" Text="Invoice Bill" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td align="center">
                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" OnPageIndexChanging="grdResult_PageIndexChanging"
                    meta:resourceKey="grdResultResource1" OnRowDataBound="grdResult_RowDataBound"
                    ShowFooter="true">
                    <Columns>
                        <asp:BoundField DataField="ClientName" HeaderText="ClientName" meta:resourceKey="BoundFieldResource1" />
                        <asp:BoundField DataField="VisitDate" HeaderText="VisitDate" meta:resourceKey="BoundFieldResource2">
                        </asp:BoundField>
                        <asp:BoundField DataField="VisitNumber" HeaderText="VisitNumber" meta:resourceKey="BoundFieldResource3">
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource4" />
                        <%--<asp:BoundField DataField="BillNumber" HeaderText="BillNumber" meta:resourceKey="BoundFieldResource5" />--%>
                        <asp:TemplateField HeaderText="BillNumber" FooterText="Total Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblBillNumber" runat="server" Text='<%#bind("BillNumber")%>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lblGrandtotal" Text="Total Amount:" runat="server"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="Amount" HeaderText="Amount" />--%>
                        <asp:TemplateField HeaderText="Amount" FooterText="Grand Total">
                            <ItemTemplate>
                                <asp:Label ID="lblAmount" runat="server" Text='<%#bind("Amount")%>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="lbltotal" Text="0.00" runat="server"></asp:Label>
                            </FooterTemplate>
                        </asp:TemplateField>
                    </Columns>
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
                <asp:TextBox ID="txtpageNo" runat="server" Width="30px"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                <asp:HiddenField ID="hdnTrustedlist" runat="server" Value="0" />
            </td>
        </tr>
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
        <asp:HiddenField ID="hdnReceivedAmount" runat="server" />
        <asp:HiddenField ID="hdnRefundAmount" runat="server" />
        <asp:HiddenField ID="hdnTotalAmount" runat="server" />
        <asp:HiddenField ID="hdnClientID" runat="server" />
        <asp:HiddenField ID="hdnPhysicianID" runat="server" Value="0" />
        <asp:HiddenField ID="hdnFinalBillId" runat="server" Value="0" />
        <asp:HiddenField ID="hdnAmtReceivedID" runat="server" Value="0" />
    </table>
    <input type="hidden" id="hdnBillStatus" runat="server"> </input>
    <input type="hidden" id="hdnCollectionType" runat="server"> </input>
    <asp:HiddenField ID="hdnAmt" runat="server" />
    <input id="bid" name="bid" type="hidden" />
    <asp:HiddenField ID="hdnClientPortal" runat="server" />
    <input type="hidden" runat="server" id="hdnclientName" />
    <input type="hidden" runat="server" id="hdnCustomerType" />
    <input type="hidden" runat="server" id="hdnClientTypeID" />


</asp:Panel>
