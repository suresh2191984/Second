<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ServiceSearch.ascx.cs" Inherits="Corporate_ServiceSearch" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />-->
<style type="text/css">
    .style1
    {
        width: 95px;
    }
</style>

<script type="text/javascript" language="javascript">

    function SelectBillNo(billno, Refundstatus, vType, isCreditBill, visitstate, CollectionType, ReceivedAmount, RefundAmount, TotAmount) {
    
        document.getElementById('<%=hdnBillNumber.ClientID %>').value = billno;
        document.getElementById('<%=hdnRefundstatus.ClientID %>').value = Refundstatus;
        document.getElementById("hdnVisitTypeCredit").value = vType + "~" + isCreditBill + "~" + visitstate;
        document.getElementById('<%=hdnCollectionType.ClientID %>').value = CollectionType;
        document.getElementById('<%=hdnReceivedAmount.ClientID %>').value = ReceivedAmount;
        document.getElementById('<%=hdnRefundAmount.ClientID %>').value = RefundAmount;
        document.getElementById('<%=hdnTotalAmount.ClientID %>').value = TotAmount;
        setBillNumber(billno);
    }
    
    function checkForValues() {
        if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
            alert("Please Enter Page No");
            return false;
        }

        if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {
            alert("Please Enter Correct Page No");
            return false;
        }

        if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
            alert("Please Enter Correct Page No");
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

            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';2210,1
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'block';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegDate.ClientID %>').style.display = 'inline';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
            document.getElementById('<%=divRegCustomDate.ClientID %>').style.display = 'none';
        }
    }
   


    function FilterItems(value) {
        value = value.toLowerCase();
        ddl.options.length = 0;
        for (var i = 0; i < ddlText.length; i++) {
            if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                AddItem(ddlText[i], ddlValue[i]);
            }
        }

        if (ddl.options.length == 0) {
            AddItem("No Physician Found", "");
        }
    }

    function AddItem(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl.options.add(opt);
    }
    
</script>

<asp:Panel ID="pnlPSearch" runat="server" 
    DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" class="dataheader3">
        <tr>
            <td>
                <asp:Label ID="Rs_PatientNumber" Text="Employee Number" runat="server" 
                    meta:resourcekey="Rs_PatientNumberResource1" />
            </td>
            <td>
                <asp:TextBox ID="txtPatientNumber" runat="server" MaxLength="20" onkeypress="return onEnterKeyPress(event);"
                    CssClass="txtboxps" meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
            </td>
            <td align="left" class="style1">
                <asp:Label ID="Rs_BillDate" runat="server" Text="Bill Date" meta:resourceKey="Rs_BillDateResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                    CssClass="ddlTheme" runat="server" 
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
            <td>
                <div id="divRegDate" style="display: none" runat="server">
                    <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate1Resource1"></asp:Label>
                    <asp:TextBox Width="70px" ID="txtFromDate" runat="server" meta:resourceKey="txtFromDateResource1"></asp:TextBox>
                    <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate1Resource1"></asp:Label>
                    <asp:TextBox Width="70px" runat="server" ID="txtToDate" meta:resourceKey="txtToDateResource1"></asp:TextBox>
                </div>
                <div id="divRegCustomDate" runat="server" style="display: none;">
                    <asp:Label ID="Rs_FromDate2" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate2Resource1"></asp:Label>
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
                    <asp:Label ID="Rs_ToDate2" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate2Resource1"></asp:Label>
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
        </tr>
        <tr>
            <%--<td>
                <asp:Label ID="Rs_SelectClient" runat="server" Text="Select Client" 
                    meta:resourceKey="Rs_SelectClientResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlCorporate" CssClass="ddlTheme" runat="server" 
                    meta:resourceKey="ddlCorporateResource1">
                </asp:DropDownList>
            </td>--%>
            <td align="left">
                <asp:Label ID="Rs_PatientName" runat="server" Text="Employee Name" meta:resourceKey="Rs_PatientNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPatientName" runat="server" MaxLength="255" CssClass="txtboxps"
                    meta:resourceKey="txtPatientNameResource1"></asp:TextBox>
            </td>
            
        </tr>
        <%--<tr>
            <td style="width: 100px" align="left">
                <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" 
                    meta:resourcekey="Rs_BillNoResource1" />
            </td>
            <td style="width: 350px">
                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="255" CssClass="txtboxps" 
                    meta:resourcekey="txtBillNoResource1"></asp:TextBox>
            </td>
            <td class="style1">
                <asp:Label ID="Rs_DoctorName" runat="server" Text="Doctor Name" meta:resourceKey="Rs_DoctorNameResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" onkeyup="FilterItems(this.value)"
                    onblur="AddPhysician()" meta:resourceKey="txtNewResource1"></asp:TextBox>&nbsp;
                <asp:DropDownList ID="ddlPhysician" runat="server" meta:resourceKey="ddlPhysicianResource1">
                </asp:DropDownList>
                <cc1:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                    WatermarkText="Type Physician Name" Enabled="True" />
            </td>
            
        </tr>--%>
        <tr>
            <td colspan="4" style="padding-bottom: 10px;" align="center">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                    onmouseout="this.className='btn1'" OnClick="btnSearch_Click" meta:resourceKey="btnSearchResource1" />
                &nbsp;
                <input id="btnCancel" class="btn1" onclick="getElementById('').value='';getElementById('').value='';var now = new Date();
                    getElementById('').options[0].selected=true;getElementById('').options[0].selected=true;getElementById('').options[0].selected=true;getElementById('').value='';return ShowRegDate()"
                    type="button" value="Reset" />
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
            <td>
                <asp:GridView ID="grdResult" runat="server"  AutoGenerateColumns="False"
                    DataKeyNames="BillID" OnRowDataBound="grdResult_RowDataBound" OnPageIndexChanging="grdResult_PageIndexChanging"
                     meta:resourceKey="grdResultResource1">
                    <Columns>
                        <asp:BoundField DataField="BillID" HeaderText="BillID" meta:resourceKey="BoundFieldResource1"
                            Visible="False" />
                        <asp:TemplateField HeaderText="Select" meta:resourceKey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:RadioButton ID="rdSel" runat="server" GroupName="BillSelect" ToolTip="Select Row" /><%--meta:resourceKey="rdSelResource1"--%>
                            </ItemTemplate>
                            <ItemStyle Width="3%" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="PatientNumber" HeaderText="Number " meta:resourceKey="BoundFieldResource2">
                            <ItemStyle Width="10%" HorizontalAlign="Left"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Name">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="30%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BillNumber" HeaderText="Service No" meta:resourceKey="BoundFieldResource3">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="10%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd MMM yyyy hh:mm tt}"
                            HeaderText="Service Date" meta:resourceKey="BoundFieldResource6">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle HorizontalAlign="Left" Width="20%" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DrName" HeaderStyle-HorizontalAlign="left" HeaderText="Doctor Name"
                            ItemStyle-Width="17%" Visible="true">
                            <HeaderStyle HorizontalAlign="Left" />
                            <ItemStyle Width="17%" />
                        </asp:BoundField>
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
                <asp:Label ID="Label1" runat="server" Text="Page" ></asp:Label>
                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="Of"></asp:Label>
                <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click"/>
                <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click"/>
                <asp:HiddenField ID="hdnCurrent" runat="server" />
                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:"></asp:Label>
                <asp:TextBox ID="txtpageNo" runat="server" Width="30px"    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click"/>
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
    </table>
    <input type="hidden" id="hdnBillStatus" runat="server"> </input>
    <input type="hidden" id="hdnCollectionType" runat="server"> </input>
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
