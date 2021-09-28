<%@ Control Language="C#" AutoEventWireup="true" CodeFile="VoucherSearch.ascx.cs"
    Inherits="CommonControls_VoucherSearch" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />-->
       <script type="text/javascript" language="javascript">
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
            document.getElementById('<%=txtFromPeriod.ClientID %>').value = "";
            document.getElementById('<%=txtToPeriod.ClientID %>').value = "";
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

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Receipts Issued"
    Style="color: #000000;" DefaultButton="btnSearch" 
    meta:resourcekey="pnlPSearchResource1">
    <table class="w-100p searchPanel">
        <tr>
            <td class="w-10">
            </td>
        </tr>
        <tr>
            <td class="a-left w-10p">
               <asp:Label ID="lbvoucherno" runat="server" Text="Voucher No" 
                    meta:resourcekey="lbvouchernoResource1"></asp:Label>
            </td>
            <td >
                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="255"  
                    CssClass ="Txtboxsmall " meta:resourcekey="txtBillNoResource1"></asp:TextBox>
            </td>
            <td class="a-left">
              <asp:Label ID="lbvoucherdt" runat="server" Text="Voucher Date" 
                    meta:resourcekey="lbvoucherdtResource1"></asp:Label>
            </td>
            <td >
                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                   CssClass ="ddlsmall" runat="server" 
                    meta:resourcekey="ddlRegisterDateResource1">
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
            <td >
         <div id="divRegDate" style="display: none" runat="server">
                    <asp:Label ID="lbfrmdt" runat="server" Text="From Date" 
                        meta:resourcekey="lbfrmdtResource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromDate" CssClass="Txtboxsmall" runat="server" 
                        meta:resourcekey="txtFromDateResource1"></asp:TextBox>
                <asp:Label ID="lbtodt" runat="server" Text="To Date" 
                        meta:resourcekey="lbtodtResource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" CssClass="Txtboxsmall" ID="txtToDate" 
                        meta:resourcekey="txtToDateResource1"></asp:TextBox>
                </div>
                <div id="divRegCustomDate" runat="server" style="display: none;">
                  <asp:Label ID="lbfromdate" runat="server" Text="From Date" 
                        meta:resourcekey="lbfromdateResource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromPeriod" CssClass="Txtboxsmall" runat="server" 
                        meta:resourcekey="txtFromPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromPeriod"
                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                        ControlToValidate="txtFromPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" 
                        meta:resourcekey="MaskedEditValidator5Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                    <asp:Label ID="lbtodate" runat="server" Text="To Date" 
                        meta:resourcekey="lbtodateResource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" CssClass="Txtboxsmall" ID="txtToPeriod" 
                        meta:resourcekey="txtToPeriodResource1"></asp:TextBox>
                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                        CausesValidation="False" meta:resourcekey="ImgBntCalcToResource1" />
                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtToPeriod"
                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left"
                        ErrorTooltipEnabled="True" CultureAMPMPlaceholder="" 
                        CultureCurrencySymbolPlaceholder="" CultureDateFormat="" 
                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" 
                        CultureThousandsPlaceholder="" CultureTimePlaceholder="" Enabled="True" />
                    <cc1:MaskedEditValidator ID="MaskedEditValidator1" runat="server" ControlExtender="MaskedEditExtender5"
                        ControlToValidate="txtToPeriod" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator1" 
                        meta:resourcekey="MaskedEditValidator1Resource1" />
                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToPeriod"
                        Format="dd/MM/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                </div>
        </td>
        </tr>
        
        <tr>
            <td  class="a-left">
               <asp:Label ID="lbreceivername" runat="server" Text="Receiver Name" 
                    meta:resourcekey="lbreceivernameResource1"></asp:Label>
            </td>
            <td >
                <asp:TextBox ID="txtPatientName" runat="server"  CssClass ="Txtboxsmall" 
                    MaxLength="255" meta:resourcekey="txtPatientNameResource1"></asp:TextBox>
            </td>
            <td class="a-left">
                &nbsp;
            </td>
            <td >
                <asp:Button ID="btnSearch" runat="server" CssClass="btn" OnClick="btnSearch_Click"
                     
                    Text="Search" meta:resourcekey="btnSearchResource1" />
                &nbsp;<%--<asp:Button ID="btnCancel" runat="server" CssClass="btn1" 
                    OnClick="btnCancel_Click" onmouseout="this.className='btn1'" 
                    onmouseover="this.className='btn1 btnhov1'" Text="Reset" />--%>
                <input class="btn" type="button" id="btnCancel" value="Reset"  onclick="getElementById('<%= txtPatientName.ClientID %>').value='';getElementById('<%= txtBillNo.ClientID %>').value='';var now = new Date();
                    getElementById('<%= ddlRegisterDate.ClientID %>').options[0].selected=true;return ShowRegDate()" />
            </td>
        </tr>
    </table>
    <table class="w-100p">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" 
                    meta:resourcekey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table class="w-100p">
        <tr>
            <td>
                <asp:GridView ID="grdResult" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    DataKeyNames="OutFlowID" OnRowDataBound="grdResult_RowDataBound"
                    OnPageIndexChanging="grdResult_PageIndexChanging" PageSize="15"  CssClass="w-100p gridView"
                     meta:resourcekey="grdResultResource1">
                    <Columns>
                        <asp:BoundField DataField="VoucherNO" HeaderText="Voucher No" 
                            meta:resourcekey="BoundFieldResource1">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="ReceiverName" HeaderText="Receiver Name" 
                            meta:resourcekey="BoundFieldResource2">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="18%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="CreatedAt" 
                            DataFormatString="{0:dd MMM yyyy hh:mm tt}" HeaderText="Voucher Date" 
                            meta:resourcekey="BoundFieldResource3">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Remarks" HeaderText="Remarks" 
                            meta:resourcekey="BoundFieldResource4">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" 
                            HeaderText="Amount" meta:resourcekey="BoundFieldResource5">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Print" meta:resourcekey="TemplateFieldResource1">
                            <ItemTemplate>
                                <input ID="rdSel" runat="server" class="btn" title="Print Voucher" 
                                    type="button" value=" PrintVoucher"></input>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                   
                </asp:GridView>
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
    </table>
    <input type="hidden" id="hdnBillStatus" runat="server" >
   
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
