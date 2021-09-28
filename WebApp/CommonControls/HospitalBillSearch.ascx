<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HospitalBillSearch.ascx.cs"
    Inherits="CommonControls_HospitalBillSearch" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Src="PaymentTypeDetails.ascx" TagName="PaymentTypeDetails" TagPrefix="uc6" %>
<!--<link rel="stylesheet" type="text/css" href="../StyleSheets/style.css" />-->
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
<%--<script src="../Scripts_New/jquery.min.js" type="text/javascript"></script>

<script src="../Scripts_New/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts_New/jquery-1.3.2.js" type="text/javascript"></script>--%>
<%--<script src="../Scripts_New/JsonScript.js" language="javascript" type="text/javascript"></script>
--%>

<script src="../Scripts/ChangePayMentModes.js" language="javascript" type="text/javascript"></script>

<%--<link href="../StyleSheets_New/Common.css" rel="stylesheet" type="text/css" />--%>

<script type="text/javascript" language="javascript">
    function WaterMark(txttext, evt, defaultText) {
        if (txttext.value.length == 0 && evt.type == "blur") {
            txttext.style.color = "gray";
            txttext.value = defaultText;
        }
        if (txttext.value == defaultText && evt.type == "focus") {
            txttext.style.color = "black";
            txttext.value = "";
        }
    }
    function SelectedOver(source, eventArgs) {
        /* Added By Venkatesh S */
        var vValidate = SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_05') == null ? "Please select from the list" : SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_05');
        var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        $find('uctrlBillSearch_AutoCompleteExtender1')._onMethodComplete = function(result, context) {
            //var Perphysicianname = document.getElementById('txtperphy').value;
            $find('uctrlBillSearch_AutoCompleteExtender1')._update(context, result, /* cacheResults */false);
            if (result == "") {
                ValidationWindow(vValidate, AlertType);
                document.getElementById('uctrlBillSearch_txtClientName').value = '';
                document.getElementById('<%=hdnClientID.ClientID %>').value = '';
            }
        };
    }
    function SelectedOverPhy(source, eventArgs) {
        /* Added By Venkatesh S */
        var vValidate = SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_05') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');
        var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        $find('uctrlBillSearch_AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
            $find('uctrlBillSearch_AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
            if (result == "") {
                ValidationWindow(vValidate, AlertType);
              //  alert('Please select from the list');
                document.getElementById('uctrlBillSearch_txtInternalExternalPhysician').value = '';
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
            }
        };
    }
    function SetClientID(source, eventArgs) {
        document.getElementById('<%=hdnClientID.ClientID %>').value = eventArgs.get_value();

    }
    function SetPhysicianID(source, eventArgs) {
        /* Added By Venkatesh S */
        var vValidate = SListForAppMsg.Get('Billing_HospitalBillSearch_ascx_05');
        var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        if (eventArgs != undefined) {
            document.getElementById('<%=hdnPhysicianID.ClientID %>').value = eventArgs.get_value();
        }
        else if (document.getElementById('uctrlBillSearch_hdnPhysicianID') != null) {
            if (document.getElementById('<%=hdnPhysicianID.ClientID %>').value == '') {
                ValidationWindow(vValidate, AlertType);
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                document.getElementById('uctrlBillSearch_txtInternalExternalPhysician').value = '';
            }
        }
    }

    function SelectBillNo(rid, patid, billno, Refundstatus, vType, isCreditBill, visitstate, CollectionType, ReceivedAmount, RefundAmount, TotAmount, IsCoPaymentBill, IsTransfered) {
        //debugger;
        document.getElementById('<%=hdnBillNumber.ClientID %>').value = billno;
        document.getElementById('<%=hdnRefundstatus.ClientID %>').value = Refundstatus;
        document.getElementById("hdnVisitTypeCredit").value = vType + "~" + isCreditBill + "~" + visitstate + "~" + IsCoPaymentBill;
        document.getElementById('<%=hdnCollectionType.ClientID %>').value = CollectionType;
        document.getElementById('<%=hdnReceivedAmount.ClientID %>').value = ReceivedAmount;
        document.getElementById('<%=hdnRefundAmount.ClientID %>').value = RefundAmount;
        document.getElementById('<%=hdnTotalAmount.ClientID %>').value = TotAmount;
        setBillNumber(billno);
        if (IsTransfered == 'Y' && document.getElementById('<%=hdnClientPortal.ClientID %>').value == 'Y') {
            HideActions('Y');
        }
        else {
            HideActions('N');
        }
    }
    function SelectType(Type) {
        /* Added By Venkatesh S */
        var sSBIR = SListForAppMsg.Get('Billing_HospitalBillSearch_ascx_01');
        var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        var seltype = Type;
        //    setType(Type);
        if (Type == 'Reflex') {
            ValidationWindow(sSBIR, AlertType);
        }

    }
    function checkForValues() {
        /* Added By Venkatesh S */
        var vPEPNo = SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_02') == null ? "Please Enter Page No" : SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_02');
        var vPECPNo = SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_03') == null ? "Please Enter Correct Page No" : SListForAppMsg.Get('CommonControls_HospitalBillSearch_ascx_03');
        var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        if (document.getElementById('<%=txtpageNo.ClientID %>').value == "") {
            //CommonControls\PatientSearch.ascx_1
            var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientSearch.ascx_1');
            if (userMsg != null) {
                //alert(userMsg);
				ValidationWindow(userMsg, AlertType);
            }
            else {
                ValidationWindow(vPEPNo, AlertType);
            }
            return false;
        }

        if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) < Number(1)) {

            //CommonControls\PatientSearch.ascx_2
            var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientSearch.ascx_1');
            if (userMsg != null) {
                //alert(userMsg);
					ValidationWindow(userMsg, AlertType);
            }
            else {
                ValidationWindow(vPECPNo, AlertType);
            }
            return false;
        }

        if (Number(document.getElementById('<%=txtpageNo.ClientID %>').value) > Number(document.getElementById('<%=lblTotal.ClientID %>').innerText)) {
            var userMsg = SListForApplicationMessages.Get('CommonControls\\PatientSearch.ascx_1');
            if (userMsg != null) {
                //alert(userMsg);
					ValidationWindow(userMsg, AlertType);
            }
            else {
                ValidationWindow(vPECPNo, AlertType);
            }
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
    function FilterItems(value) {
        /* Added By Venkatesh S */
        var vAddItem = SListForAppMsg.Get('Billing_HospitalBillSearch_ascx_04') == null ? "No Physician Found" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');
        var AlertType = SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04') == null ? "Alert" : SListForAppMsg.Get('Billing_PatientDueDetails_aspx_04');

        value = value.toLowerCase();
        ddl.options.length = 0;
        for (var i = 0; i < ddlText.length; i++) {
            if (ddlText[i].toLowerCase().indexOf(value) != -1) {
                AddItem(ddlText[i], ddlValue[i]);
            }
        }

        if (ddl.options.length == 0) {
            AddItem(vAddItem, "");
        }
    }

    function AddItem(text, value) {
        var opt = document.createElement("option");
        opt.text = text;
        opt.value = value;
        ddl.options.add(opt);
    }
    function clearvalue() {
        //    document.getElementById('<%=txtPatientNumber.ClientID%>').value = '';
        //    document.getElementById('<%=txtBillNo.ClientID%>').value = '';
        //    document.getElementById('<%=txtPatientName.ClientID%>').value = '';
        //    document.getElementById('<%=txtClientName.ClientID%>').value = '';
        //    document.getElementById('<%=txtInternalExternalPhysician.ClientID%>').value = '';
        //    document.getElementById('<%=ddlocations.ClientID%>').options[1].selected = true;
        //    document.getElementById('<%=ddlRegisterDate.ClientID%>').options[4].selected = true;
        ShowRegDate();
    }
</script>

<asp:Panel ID="pnlPSearch" runat="server" GroupingText="Search for Bills Issued"
    DefaultButton="btnSearch" meta:resourcekey="pnlPSearchResource1">
    <table class="w-100p searchPanel" cellpadding="2">
        <tr>
            <td>
                <table>
                    <tr>
                        <%--<td style="width:100px" align="left">
                <asp:Label ID="Rs_BillNo" runat="server" Text="Bill No" 
                    meta:resourceKey="Rs_BillNoResource1"></asp:Label>
            </td>
            <td style="width:350px">
                <asp:TextBox ID="txtBillNo" runat="server" MaxLength="255" CssClass="txtboxps" 
                    meta:resourceKey="txtBillNoResource1"></asp:TextBox>
            </td>--%>
                        <td class="w-10p">
                            <asp:Label runat="server" ID="lblVisitNumber" Text="Number" meta:resourcekey="lblVisitNumberResource1"></asp:Label>
                        </td>
                        <td class="w-19p">
                            <asp:TextBox runat="server" ID="txtVisitNo" CssClass="small" meta:resourcekey="txtVisitNoResource1"></asp:TextBox>
                        </td>
                        <td class="w-10p a-left">
                            <asp:Label ID="Rs_PatientNumber" Text="Patient Number" runat="server" meta:resourcekey="Rs_PatientNumberResource1" />
                        </td>
                        <td class="paddingL1">
                            <asp:TextBox ID="txtPatientNumber" runat="server" MaxLength="20" onkeypress="return onEnterKeyPress(event);"
                                CssClass="small" meta:resourcekey="txtPatientNumberResource1"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblLocation" Text="Location" runat="server" meta:resourcekey="lblLocationResource1" />
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlocations" runat="server" TabIndex="5" CssClass="ddlsmall"  meta:resourcekey="ddlocationsResource1">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="w-11p">
                            <asp:Label ID="Rs_BillNo" Text="Bill No" runat="server" meta:resourcekey="Rs_BillNoResource1" />
                        </td>
                        <td class="w-20p">
                            <asp:TextBox ID="txtBillNo" runat="server" MaxLength="250" CssClass="small" meta:resourcekey="txtBillNoResource1"></asp:TextBox>
                        </td>
                        <td class="w-14p paddingL2p a-left">
                            <asp:Label ID="Rs_PatientName" runat="server" Text="Patient Name" meta:resourceKey="Rs_PatientNameResource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPatientName" runat="server" MaxLength="255" CssClass="small"
                                meta:resourceKey="txtPatientNameResource1"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="a-left w-11p">
                            <asp:Label ID="Rs_SelectClient" Text="Select Client" runat="server" meta:resourcekey="Rs_SelectClientResource1" />
                        </td>
                        <td class="w-20p">
                            <%-- <asp:DropDownList ID="ddlCorporate" CssClass="ddlsmall" runat="server" width="250px"
                    meta:resourcekey="ddlCorporateResource1">
                </asp:DropDownList>--%>
                            <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox" meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                            <cc1:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtClientName"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetClientList"
                                OnClientItemSelected="SetClientID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                OnClientItemOver="SelectedOver" Enabled="True">
                            </cc1:AutoCompleteExtender>
                        </td>
                        <td class="a-left w-14p paddingL2p" id="tdRefDrPart" runat="server">
                            <asp:Label ID="lblRefby" runat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                Text="Doctor Name" meta:resourcekey="lblRefbyResource1"></asp:Label>
                        </td>
                        <td id="tdRefDrParttxt" runat="server">
                            <asp:TextBox ID="txtInternalExternalPhysician" runat="server" CssClass="AutoCompletesearchBox"
                                onchange="SetPhysicianID()" meta:resourcekey="txtInternalExternalPhysicianResource1"></asp:TextBox>
                            <cc1:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false"
                                FirstRowSelected="true" MinimumPrefixLength="1" ServiceMethod="GetRateCardForBilling"
                                OnClientItemSelected="SetPhysicianID" OnClientItemOver="SelectedOverPhy" ServicePath="~/OPIPBilling.asmx"
                                TargetControlID="txtInternalExternalPhysician">
                            </cc1:AutoCompleteExtender>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkSplit" runat="server" Checked="false" Text="Show Fee Split"  meta:resourcekey="chkSplitResource1"/>
                        </td>
                        <%--<td>
                <asp:Label ID="Rs_PatientNumber" runat="server" Text="Patient Number" 
                    meta:resourceKey="Rs_PatientNumberResource1"></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtPatientNumber" runat="server" MaxLength="20" 
                    CssClass="txtboxps" meta:resourceKey="txtPatientNumberResource1"></asp:TextBox>
            </td>--%>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Rs_BillDate" runat="server" Text="Bill Date" meta:resourceKey="Rs_BillDateResource1"
                                Width="13%"></asp:Label>
                        </td>
                        <td colspan="6">
                            <asp:DropDownList ID="ddlRegisterDate" onChange="javascript:return ShowRegDate();"
                                CssClass="ddlsmall" runat="server" meta:resourcekey="ddlRegisterDateResource1">
                                <%--<asp:ListItem Value="-1" meta:resourcekey="ListItemResource1">--Select--</asp:ListItem>
                   <asp:ListItem Value="0" Selected="True" meta:resourcekey="ListItemResource2">This Week</asp:ListItem>
                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource3">This Month</asp:ListItem>
                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource4">This Year</asp:ListItem>
                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource5">Custom Period</asp:ListItem>
                    <asp:ListItem Value="4" meta:resourcekey="ListItemResource6">Today</asp:ListItem>
                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource7">Last Week</asp:ListItem>
                    <asp:ListItem Value="6" meta:resourcekey="ListItemResource8">Last Month</asp:ListItem>
                    <asp:ListItem Value="7" meta:resourcekey="ListItemResource9">Last Year</asp:ListItem>--%>
                            </asp:DropDownList>
                            <div id="divRegDate" style="display: none" runat="server">
                                <asp:Label ID="Rs_FromDate1" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate1Resource1"></asp:Label>
                                <asp:TextBox ID="txtFromDate" runat="server" meta:resourceKey="txtFromDateResource1"
                                    CssClass="small"></asp:TextBox>
                                <asp:Label ID="Rs_ToDate1" runat="server" Text="To Date" meta:resourceKey="Rs_ToDate1Resource1"></asp:Label>
                                <asp:TextBox runat="server" ID="txtToDate" meta:resourceKey="txtToDateResource1"
                                    class="small"></asp:TextBox>
                            </div>
                            <div id="divRegCustomDate" runat="server" style="display: none;">
                                <asp:Label ID="Rs_FromDate2" runat="server" Text="From Date" meta:resourceKey="Rs_FromDate2Resource1"></asp:Label>
                                <asp:TextBox ID="txtFromPeriod" runat="server" meta:resourceKey="txtFromPeriodResource1"
                                    class="small"></asp:TextBox>
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
                                <asp:TextBox runat="server" ID="txtToPeriod" meta:resourceKey="txtToPeriodResource1"
                                    CssClass="small"></asp:TextBox>
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
                </table>
            </td>
        </tr>
        <%-- <tr>--%>
        <%--<td>
                <asp:Label ID="Rs_SelectClient" runat="server" Text="Select Client" 
                    meta:resourceKey="Rs_SelectClientResource1"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlCorporate" CssClass="ddlTheme" runat="server" 
                    meta:resourceKey="ddlCorporateResource1">
                </asp:DropDownList>
            </td>--%>
        <%--  <td>
                <table class="w-60p">
                    
                </table>
            </td>--%>
        <%--  <td>
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
            </td>--%>
        <%-- </tr>--%>
        <tr>
            <td class="a-center paddingB10" colspan="4">
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                    onmouseout="this.className='btn1'" OnClick="btnSearch_Click" meta:resourceKey="btnSearchResource1" />
                &nbsp;
                <asp:Button runat="server" ID="btnCancel" OnClientClick="clearvalue()" Text="Reset"
                    CssClass="btn1" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1"  />
            </td>
        </tr>
    </table>
    <table class="w-100p" cellpadding="5">
        <tr>
            <td>
                <asp:Label ID="lblResult" ForeColor="#000333" runat="server" meta:resourceKey="lblResultResource1"></asp:Label>
            </td>
        </tr>
    </table>
    <table>
        <tr>
            <td>
                <cc1:ModalPopupExtender ID="programmaticModalPopup" runat="server" BackgroundCssClass="modalBackground"
                    PopupControlID="pnlPaymentType" CancelControlID="btnPopCancel" TargetControlID="hiddenTargetControlForModalPopup"
                    DynamicServicePath="" Enabled="True">
                </cc1:ModalPopupExtender>
                <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none"  meta:resourcekey="hiddenTargetControlForModalPopupResource1"/>
                <asp:Panel ID="pnlPaymentType" BorderWidth="1px" CssClass="modalPopup dataheaderPopup w-90p h-50p"
                    runat="server" Style="display: none" meta:resourcekey="pnlPaymentTypeResource1">
                    <table class="a-center w-100p bold">
                        <tr>
                            <td>
                                <asp:Label ID="lbltest" class="a-center" Text="PayMent Type Details" runat="server" meta:resourcekey="lbltestResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblPatient" runat="server" Text="Patient Name " Font-Bold="true" meta:resourcekey="lblPatientResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblPName" runat="server" meta:resourcekey="lblPNameResource1"></asp:Label>:
                            </td>
                            <td>
                                <asp:Label ID="lblTotalamt" runat="server" Text="Total Amount Received" Font-Bold="true" meta:resourcekey="lblTotalamtResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label ID="lblTotalAmtreceived" runat="server" meta:resourcekey="lblTotalAmtreceivedResource1"></asp:Label>
                                :
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblBill" Text="Bill No" Font-Bold="true" meta:resourcekey="lblBillResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:Label runat="server" ID="lblBillNo" meta:resourcekey="lblBillNoResource1"></asp:Label>
                            </td>
                        </tr>
                    </table>
                    <uc6:PaymentTypeDetails ID="PaymentTypeDetails1" runat="server" />
                    <table class="w-100p a-center">
                        <tr>
                            <td>
                                <asp:Button ID="Update" runat="server" Text="Update" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick="javascript:CheckAmount();" OnClick="Update_Click"  meta:resourcekey="UpdateResource1"/>
                                <input type="button" id="btnPopCancel" runat="server" value="Cancel" class="btn"
                                    onclick="javascript:CancelPopup()" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'"  meta:resourcekey="btnPopCancelResource1"/>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <table class="w-100p">
        <tr id="trlegend" runat="server" style="display: none">
            <td class="a-left">
                <asp:TextBox ID="txtStatColor" CssClass="v-top" Style="background-color: gray;" ReadOnly="True"
                    Height="5px" Width="5px" runat="server"></asp:TextBox>
                <asp:Label ID="lblStatTestColor" Text="Client Bill" runat="server" meta:resourcekey="lblStatTestColorResource1"></asp:Label>
                <asp:TextBox ID="txtInvoiceColor" CssClass="v-top" Style="background-color: Lime;"
                    ReadOnly="True" Height="5px" Width="5px" runat="server"></asp:TextBox>
                <asp:Label ID="Label4" Text="Invoice Bill" runat="server" meta:resourcekey="Label4Resource1"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>
                <%--Added MemberShipCarNo in GridView added by Thamilselvan.R on 02 Feb 2015 to Get the coupon No--%>
                <asp:GridView ID="grdResult" runat="server" AutoGenerateColumns="False" DataKeyNames="BillID"
                    class="gridView" CssClass="grdResult" OnRowDataBound="grdResult_RowDataBound"
                    OnPageIndexChanging="grdResult_PageIndexChanging" meta:resourceKey="grdResultResource1">
                    <Columns>
                        <asp:BoundField DataField="BillID" HeaderText="BillID" meta:resourceKey="BoundFieldResource1"
                            Visible="False" />
                        <asp:TemplateField HeaderText="Select" meta:resourceKey="TemplateFieldResource1">
                            <ItemTemplate>
                                <asp:RadioButton ID="rdSel" runat="server" GroupName="BillSelect" ToolTip="Select Row" meta:resourcekey="rdSelResource1" /><%--meta:resourceKey="rdSelResource1"--%>
                            </ItemTemplate>
                            <ItemStyle CssClass="w-3p" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="PatientNumber" HeaderText="Patient No" meta:resourceKey="BoundFieldResource2">
                            <ItemStyle CssClass="w-4p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BillNumber" HeaderText="Bill No" meta:resourceKey="BoundFieldResource3">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="a-left w-10p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="PatientVisitId" HeaderText="VisitID" meta:resourceKey="BoundFieldResource4" />
                        <asp:BoundField DataField="PatientID" HeaderText="PID" meta:resourceKey="BoundFieldResource5" />
                        <asp:BoundField DataField="VisitNumber" HeaderText="Visit Number" meta:resourcekey="BoundFieldResource6" />
                        <asp:BoundField DataField="BillDate" DataFormatString="{0:dd MMM yyyy hh:mm tt}"
                            HeaderText="Bill Date" meta:resourceKey="BoundFieldResource11">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="a-left w-14p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource7">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="w-18p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                            HeaderText="Amount" ItemStyle-Width="3%" meta:resourcekey="BoundFieldResource8">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="w-3p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AmountReceived" DataFormatString="{0:0.00}" ItemStyle-HorizontalAlign="Right"
                            HeaderText="Amount Received" ItemStyle-Width="3%" meta:resourcekey="BoundFieldResource9">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="w-3p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DrName" HeaderStyle-HorizontalAlign="left" HeaderText="Doctor Name"
                            ItemStyle-Width="17%" Visible="true" meta:resourcekey="BoundFieldResource12">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="w-17p" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RefOrgName" HeaderText="Hospital/CC/Branch" meta:resourceKey="BoundFieldResource10"
                            Visible="False">
                            <HeaderStyle CssClass="a-left" />
                            <ItemStyle CssClass="w-25p" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Bill Status" HeaderStyle-HorizontalAlign="left" Visible="false" meta:resourcekey="TemplateFieldResource2">
                            <ItemTemplate>
                                <asp:Label ID="lblRefundstatus" Text='<%# Eval("RefundStatus") %>' runat="server"
                                    meta:resourcekey="lblRefundstatusResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                            <ItemTemplate>
                                <asp:Label runat="server" Font-Underline="True" Style="cursor: pointer" ForeColor="Black"
                                    Text="Edit Payment Mode" ID="lblEdit" meta:resourcekey="lblEditResource1"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="MembershipCardNo" Visible="false" HeaderText="MembershipCardNo"
                            meta:resourcekey="BoundFieldResource8" />
                            <asp:BoundField DataField="Type" HeaderText="Type" meta:resourceKey="BoundFieldResource11"
                            Visible="False" />
                    </Columns>
                    <HeaderStyle CssClass="dataheader1" />
                    <PagerSettings FirstPageText="" LastPageText="" Mode="NumericFirstLast" NextPageText="&gt;&gt;"
                        PageButtonCount="5" PreviousPageText="&lt;&lt;" />
                    <PagerStyle HorizontalAlign="Center" />
                </asp:GridView>
            </td>
        </tr>
        <tr id="GrdFooter" runat="server" style="display: none" class="dataheaderInvCtrl">
            <td colspan="10" class="defaultfontcolor a-center">
                <asp:Label ID="Label1" runat="server" Text="Page" meta:resourcekey="Label1Resource1"></asp:Label>
                <asp:Label ID="lblCurrent" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                <asp:Label ID="Label2" runat="server" Text="Of" meta:resourcekey="Label2Resource1"></asp:Label>
                <asp:Label ID="lblTotal" runat="server" Font-Bold="True"></asp:Label>
                <asp:Button ID="btnPrevious" runat="server" Text="Previous" CssClass="btn" OnClick="btnPrevious_Click" meta:resourcekey="btnPreviousResource1"/>
                <asp:Button ID="btnNext" runat="server" Text="Next" CssClass="btn" OnClick="btnNext_Click" meta:resourcekey="btnNextResource1"/>
                <asp:HiddenField ID="hdnCurrent" runat="server" />
                <asp:Label ID="Label3" runat="server" Text="Enter The Page To Go:" meta:resourcekey="Label3Resource1"></asp:Label>
                <asp:TextBox ID="txtpageNo" runat="server" Width="30px" maxlength='4'    onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                <asp:Button ID="btnGo" runat="server" Text="Go" CssClass="btn" OnClick="btnGo_Click" meta:resourcekey="btnGoResource1"/>
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
     <asp:HiddenField ID="hdnChecklist" runat="server" />
    <input type="hidden" id="hdnBillStatus" runat="server"/> 
    <input type="hidden" id="hdnCollectionType" runat="server"/>
    <asp:HiddenField ID="hdnAmt" runat="server" />
    <asp:HiddenField ID="HdnEditPaymentAmt" runat="server" />
    <asp:HiddenField ID="HdnTotalAmtreceived" runat="server" />
    <input id="bid" name="bid" type="hidden" />
    <asp:HiddenField ID="hdnClientPortal" runat="server" />

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
