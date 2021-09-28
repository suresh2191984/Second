<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BillingPart.ascx.cs" Inherits="CommonControls_BillingPart" %>
<%@ Register Src="OtherCurrencyReceived.ascx" TagName="OtherCurrencyDisplay" TagPrefix="OtherCurrency" %>
<%@ Register Src="PaymentTypeDetails.ascx" TagName="paymentType" TagPrefix="Payment" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../EMR/His.ascx" TagName="History" TagPrefix="His" %>

<%--<script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>
<script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>--%>


  <%--<script src="../QMS/dataTable/jquery.dataTables.min.js" type="text/javascript"></script>
  <link href="../QMS/dist/css/jquery-ui.css" rel="stylesheet" type="text/css" />--%>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
   <%--  <script src="Script/bootstrap-multiselect.js" type="text/javascript"></script>--%>

    <%-- <script type="text/javascript" src="plugins/multiSelect/js/bootstrap-multiselect.js"></script>--%>


<style>
.show{display: block !important;}
.w-75p {
    width: 75% !important;
}
.w-50p {
    width: 50% !important;
}
.w-49p{width: 49px;}
.paddingT100 {
    padding-top: 100px;
}
.paddingT50 {
    padding-top: 50px;
}
	/*******************Common.Css Modal PopUP Jquery****************************/
 .modalDiag 
    {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
    }
	
 .closeModalDiag {
		color: white;
		float: right;
		font-size: 12px;
		font-weight: bold;
		padding: 3px;
		border: 1px solid #fff;
		border-radius: 5px;
		width: 15px;
		height: 15px;
		text-align: center;
    }
    .closeModalDiag:hover,
    .closeModalDiag:focus {
        color: #ccc;
        text-decoration: none;
        cursor: pointer;
		padding: 3px;
		border: 1px solid #fff;
		border-radius: 5px;
		width: 15px;
		height: 15px;
		text-align: center;
    }
    /* modaldiag1 Body */
    .modalDiag-body {
        padding: 16px 16px !important;overflow:auto;}

/*******************End of Common.Css ****************************/
/*******************Green Theme Modal PopUP Jquery****************************/
    /* modaldiag1 Header */
    .modalDiag-header {
        padding: 12px 16px !important;
        background-color: #008080;
        color: white;
    }

    /* modaldiag1 Footer */
    .modalDiag-footer {
        padding: 12px 16px !important;
        background-color: #008080;
        color: white;
    }

    /* modaldiag1 Content */
    .modalDiag-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.7s;
        animation-name: animatetop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    .modalDiag-content1 {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animaterevtop;
        -webkit-animation-duration: 0.7s;
        animation-name: animaterevtop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }

    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
       from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }
    @-webkit-keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }
    @keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }

/*******************End of Green Theme Modal PopUP Jquery****************************/

/*******************Blue Theme Modal PopUP Jquery****************************/
    /* modaldiag1 Header */
    .modalDiag-header {
        padding: 12px 16px !important;
        background-color: #3B90D0;
        color: white;
    }

    /* modaldiag1 Footer */
    .modalDiag-footer {
        padding: 12px 16px !important;
        background-color: #3B90D0;
        color: white;
    }

    /* modaldiag1 Content */
    .modalDiag-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.7s;
        animation-name: animatetop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    .modalDiag-content1 {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animaterevtop;
        -webkit-animation-duration: 0.7s;
        animation-name: animaterevtop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
       from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }
    @-webkit-keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }
    @keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }

/*******************End of Blue Theme Modal PopUP Jquery****************************/


/*******************Black Theme Modal PopUP Jquery****************************/
    /* modaldiag1 Header */
   .modalDiag-header {
		padding: 12px 16px !important;
		background-color: #3B90D0;
		color: white;
	}

    /* modaldiag1 Footer */
    .modalDiag-footer {
        padding: 12px 16px !important;
        background-color: #777777;
        color: white;
    }

    /* modaldiag1 Content */
    .modalDiag-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animatetop;
        -webkit-animation-duration: 0.7s;
        animation-name: animatetop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    .modalDiag-content1 {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.19);
        -webkit-animation-name: animaterevtop;
        -webkit-animation-duration: 0.7s;
        animation-name: animaterevtop;
        animation-duration: 0.7s;
        border-radius: 10px;
    }
    /* Add Animation */
    @-webkit-keyframes animatetop {
        from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }

    @keyframes animatetop {
       from {top:-300px; opacity:0} 
        to {top:0; opacity:1}
    }
    @-webkit-keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }
    @keyframes animaterevtop {
        from {top:0; opacity:1}
        to {top:-300px; opacity:0}
    }

/*******************End of Black Theme Modal PopUP Jquery****************************/
</style>
<!-- Language converter -->
<style type="text/css">
.History_ModalPopup
{
height: 475px !important;
}
.ui-autocomplete {
	z-index: 10000001;
}
 .hide_Column
        {
            display: none;
        }
        .multiselect-container
        {
            max-height: 250px; /* you can change as you need it */
            overflow: auto;
            width: 160px ! important;
        }
        .required
        {
            padding-right: 25px;
            color: Red;
            background-position: right top;
        }
         .flow
        {
            float:left;
        }
        .alignCenter
        {
            text-align:center;
        }
    .marginT20{margin-top: 20px;} .marginB20{margin-bottom: 20px;}
</style>
<script type="text/javascript">
    /* Common Alert Validation */
    var AlertType;

    $(document).ready(function() {
        var btnAddValue = "<%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_01 %>";        
        AlertType = SListForAppMsg.Get('CommonControls_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('CommonControls_Header_Alert');
    });

    function fnCalTtlDisount() {
        /* Added By Venkatesh S */
        var vDiscountAmt = SListForAppMsg.Get('CommonControls_BillingPart_ascx_01') == null ? "Discount Amount Greater than 100%." : SListForAppMsg.Get('CommonControls_BillingPart_ascx_01');
        var vReferringDoct = SListForAppMsg.Get('CommonControls_BillingPart_ascx_02') == null ? "Referring Doctor discount limit is exceeded for this period, will not be able to provide further discounts." : SListForAppMsg.Get('CommonControls_BillingPart_ascx_02');
        var vEmployeeDiscount = SListForAppMsg.Get('CommonControls_BillingPart_ascx_03') == null ? "Employee discount limit is exceeded for this period, will not be able to provide further discounts." : SListForAppMsg.Get('CommonControls_BillingPart_ascx_03');
        
        var total = 0.0;
        var checkBoxSelector = '#<%=gvMultiDisTypes.ClientID%> input[id*="CheckSelect"]:checkbox';
        var totalCkboxes = $(checkBoxSelector),
        checkedCheckboxes = totalCkboxes.filter(":checked")
        document.getElementById('billPart_hdnDisPercentage').value = '';
        document.getElementById('billPart_hdnDisReason').value = '';
        if (checkedCheckboxes.length == 0) {
            document.getElementById('billPart_hdnDiscountPercentage').value = total.toFixed(2);
            document.getElementById('billPart_lblTtlDiscountPercentage').innerText = '';
            SetNetValue('ADD');
            var modal = $find("billPart_MPEMultDisc");
            modal.hide();
            //alert("check at least one");
            return true;
        }
        else {
            var gridView1Control = document.getElementById('<%= gvMultiDisTypes.ClientID %>');
            $('input:checkbox[id$=CheckSelect]:checked', gridView1Control).each(function(item, index) {

                var tr = $(this).closest("tr");
                var DisID = $(tr).find("input:hidden[id$=hdDiscountID]");
                var RsnName = $(tr).find("span[id*=lblDiscountName]");

                var Discount = $(this).next('input:hidden[id$=hdDiscount]').val();
                var DisReason = $(this).next('input:hidden[id$=hdDiscountName]').val();
                total += parseFloat(Discount);
                //To save DiscountId and DiscountReason in PatientDiscount Table Store the vales in hidden field with comma seperator 
                document.getElementById('billPart_hdnDisPercentage').value = document.getElementById('billPart_hdnDisPercentage').value + ',' + DisID.val();
                document.getElementById('billPart_hdnDisReason').value = document.getElementById('billPart_hdnDisReason').value + ',' + RsnName.text();
                //alert(total);
            });
            if (total > 100) {
                //alert("Discount Amount Greater than 100%.");
                ValidationWindow(vDiscountAmt, AlertType);
                return false;
            }
            else {
                var DiscountAmount = 0;
                var AvailableDiscountAmt = 0;
                var DiscountLimitAmt = 0;
                DiscountAmount = Number((document.getElementById('billPart_txtGross').value) * total / 100).toFixed(2);
                AvailableDiscountAmt = Number(Number(document.getElementById('hdnAvailableDiscountAmt').value)).toFixed(2);
                DiscountLimitAmt = document.getElementById('hdnDiscountLimitAmt').value;
                if (Number(DiscountAmount) <= Number(AvailableDiscountAmt)) {
                    document.getElementById('billPart_hdnDiscountPercentage').value = total.toFixed(2);
                    document.getElementById('billPart_lblTtlDiscountPercentage').innerText = total + "%";
                    //$find("billPart_lblTtlDiscountPercentage").text(total);
                    SetNetValue('ADD');
                    //$(checkBoxSelector).attr('checked', false);
                    var modal = $find("billPart_MPEMultDisc");
                    modal.hide();
                }
                else if (DiscountLimitAmt > 0) {
                    if (document.getElementById('hdnDiscountLimitType').value != "EMPL") {
                        //alert("Referring Doctor discount limit is exceeded for this period, will not be able to provide further discounts.");                        
                        ValidationWindow(vReferringDoct, AlertType);
                        return false;
                    }
                    else {
                        //alert("Employee discount limit is exceeded for this period, will not be able to provide further discounts.");
                        ValidationWindow(vEmployeeDiscount, AlertType);
                        return false;
                    }

                }
                else {
                    document.getElementById('billPart_hdnDiscountPercentage').value = total.toFixed(2);
                    document.getElementById('billPart_lblTtlDiscountPercentage').innerText = total + "%";
                    //$find("billPart_lblTtlDiscountPercentage").text(total);
                    SetNetValue('ADD');
                    //$(checkBoxSelector).attr('checked', false);
                    var modal = $find("billPart_MPEMultDisc");
                    modal.hide();
                }
            }
        }
        return true;
    }


    function ToInternalFormat(pControl) {
        // //debugger;
        if ("<%=LanguageCode%>" == "en-GB") {
            if (pControl.is('span')) {
                return pControl.text();
            }
            else {
                return pControl.val();
            }
        }
        else {
            return pControl.asNumber({ region: "<%=LanguageCode%>" });
        }
    }
    function ClearPopUp1() {

        var otable = document.getElementById('tblGroupHistory');
        FindCheckedItems(otable.id);
        while (otable.rows.length > 1) {
            otable.deleteRow(otable.rows.length - 1);
        }
        var modal = $find('billPart_ModalPopupShow');
        modal.hide();
        //        document.getElementById('billPart_btnDummy').click();
        return false;
    }

    function ToTargetFormat(pControl) {
        // //debugger;
        if ("<%=LanguageCode%>" == "en-GB") {
            if (pControl.is('span')) {
                return pControl.text();
            }
            else {
                return pControl.val();
            }
        }
        else {
            return pControl.formatCurrency({ region: "<%=LanguageCode%>" }).val();
        }
    }
        

</script>

<table class="w-100p">
    <tr id="trOrderPart" runat="server" style="display: table-row;">
        <td class="v-top">
            <div id="divOrder" runat="server" class="dataheader3 bg-row">
                <table class="w-100p">
                    <tr style="display: none">
                        <td colspan="5" class="v-top">
                            <asp:RadioButtonList ID="rblFeeTypes" runat="server" RepeatDirection="Horizontal"
                                RepeatColumns="8" onClick="Javascript:chkPros();resetpreviousradiodetails();"
                                meta:resourcekey="rblFeeTypesResource1">
                            </asp:RadioButtonList>
                            <asp:HiddenField ID="hdnFeeType1" runat="server" Value="COM" />
                        </td>
                    </tr>
                    <tr id="trSTATOutSource" runat="server" style="display: table-row;">
                        <td colspan="2">
                            <asp:TextBox ID="txtStatColor" Style="background-color: #EEB4B4;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px" 
                                meta:resourcekey="txtStatColorResource1"></asp:TextBox>
                            <asp:Label ID="lblStatTestColor" Text="STAT Test" runat="server" 
                                meta:resourcekey="lblStatTestColorResource1"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtOutsourceTest" Style="background-color: #D0FA58;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px" 
                                meta:resourcekey="txtOutsourceTestResource1"></asp:TextBox>
                            <asp:Label ID="lblOutSourceTestColor" runat="server" Text="Out Source" 
                                meta:resourcekey="lblOutSourceTestColorResource1"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtinvcolor" Style="background-color: #000000;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px" 
                                meta:resourcekey="txtinvcolorResource1"></asp:TextBox>
                            <asp:Label ID="lblinvcolor" Text="Investigation" runat="server" 
                                meta:resourcekey="lblinvcolorResource1"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtgrpcolor" Style="background-color: #C71585;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px" 
                                meta:resourcekey="txtgrpcolorResource1"></asp:TextBox>
                            <asp:Label ID="lblgrpcolor" Text="Group" runat="server" 
                                meta:resourcekey="lblgrpcolorResource1"></asp:Label>&nbsp;
                            <asp:TextBox ID="txtpkgcolor" Style="background-color: #6699FF;" ReadOnly="True"
                                runat="server" Height="5px" TabIndex="-1" Width="5px" 
                                meta:resourcekey="txtpkgcolorResource1"></asp:TextBox>
                            <asp:Label ID="lblpkgcolor" Text="Package" runat="server" 
                                meta:resourcekey="lblpkgcolorResource1"></asp:Label>
                        </td>
                        <td colspan="3">
                        </td>
                    </tr>
                    <tr>
                        <td class="w-8p">
                            <asp:Label ID="lblTestName" Text="Test Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>
                        </td>
                        <td class="w-50p">
                            <table class="w-100p">
                                <tr>
                                    <td class="w-75p">
                                        <asp:TextBox CssClass="AutoCompletesearchBox11" ID="txtTestName" onfocus="chkPros();"
                                            runat="server" onchange="boxExpand(this);" onkeydown="javascript:clearfn();" onfocusout="ClearAutocomp()"
                                            onkeypress="javascript:clearfn();" Width="350px" Style="margin-top: 0px" 
                                            meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="BillingItemSelected"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                                            FirstRowSelected="false" OnClientItemOver="TempBillingItemSelected" ServicePath="~/OPIPBilling.asmx"
                                            UseContextKey="True" DelimiterCharacters="" OnClientShown="InvPopulated" Enabled="True"
                                            OnClientPopulated="onTestListPopulated">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:TextBox ID="txtVariableRate" runat="server" Style="display: none;" 
                                            Width="40px" meta:resourcekey="txtVariableRateResource1"></asp:TextBox>
                                        <button id="billPart_btnAdd" width="150px"  onclick="return AddItems();" 
                                            class="btn" tabindex="-1" ><%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_01 %></button>
                                            <%--<a id="btnAdd" width="150px"  onclick="AddItems();" 
                                            class="btn" tabindex="-1" ><%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_01 %></a>--%>
                                            <%--<input type="button" id="btnAdd" value="ADD" width="150px" runat="server" onclick="AddItems();"
                                            class="btn" tabindex="-1" />--%>
                                    </td>
                                    <td class="w-25p" id="tdAdditionalTest" runat="server" Style="display: none;"> 
                                    <asp:CheckBox  ID="chkAddExtraTest" runat="server" onclick="return CheckExBarcode();"  Checked="false" />
                                    </td>                                     
                                    <td class="w-25p" id="tdlblAdditionalTest" runat="server" Style="display: none;">
                                    <asp:Label ID="lblExtraTest" runat="server" Text="AdditionalTest" Font-Bold="True"  meta:resourcekey="lblExtraTestResource1"></asp:Label>
                                    </td> 
                                    <td class="w-25p">
                                        <asp:Label ID="lblInvType" runat="server" ForeColor="Red" Font-Bold="True" meta:resourcekey="lblInvTypeResource1"></asp:Label>
                                        &nbsp;<asp:Label ID="alert" runat="server" ForeColor="Blue" meta:resourcekey="alertResource1"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td id="tdPatientHistory" runat="server" class="a-center" style="display: none;">
                            <asp:LinkButton runat="server" ID="LinkPatientHistory"
                                OnClientClick="Capturepatienthistory()" Font-Underline="True" ForeColor="Red" Font-Bold="True" text="Capture Patient History"
                                meta:resourcekey="LnkpatientHistoryResource1"></asp:LinkButton>
                        </td>
                        
                        <td id="tdSpeci" runat="server" style="display:none">
                         <input type="button" id="btnspec" class="btn btn-primary" onclick="openModalJQ('mymodaldiag2', 'myModalclass2');" value="Specimen" style="color:Red;  font-size:10pt; font-weight:bold; text-decoration:underline; background-color:Transparent;" runat="server" />
                        </td>
                        <td id="tdHistory" runat="server" class="a-center" style="display: none;">
                            <asp:LinkButton runat="server" ID="LnkHistory"
                                OnClientClick="onShowHistoryNameList()" Font-Underline="True" ForeColor="Red"
                                Font-Bold="True" meta:resourcekey="LnkHistoryResource1"><%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_32 %></asp:LinkButton>
                        </td>
                        <td id="tdClientAttributes" runat="server" class="a-center" style="display:none;">
                           <a id="clientwise" onclick="" style="font-weight: bold;text-decoration: underline;color: red;" >Client Attributes</a>
                        </td>
                        <td id="tdAttributes" runat="server" class="a-center" style="display:none;">
                            <asp:LinkButton runat="server" ID="LnkAttributes"
                                OnClientClick="onShowAttributes()" Font-Underline="True" ForeColor="Red" 
                                Font-Bold="True" meta:resourcekey="LnkAttributesResource1"></asp:LinkButton>
                        </td>
                        <td id="tdPreviousDue" runat="server" class="a-right">
                            <asp:Label ID="lblPreviousDue" ForeColor="Red" Font-Bold="True" Text="Previous Due :"
                                runat="server" meta:resourcekey="lblPreviousDueResource1"></asp:Label>
                            <asp:Label ID="lblPreviousDueText" Text="0.00" runat="server" meta:resourcekey="lblPreviousDueTextResource1"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="divBill3" title="Billing Details">
                <asp:Panel CssClass="dataheaderInvCtrl" ID="BillingPanel1" runat="server" GroupingText="Billing Details" ToolTip="Billing Details"
                    meta:resourcekey="BillingPanel1Resource1">
                    <table class="w-100p">
                        <tr class="v-top">
                            <td class="w-75p v-top">
                                <table class="w-100p">
                                    <tr class="v-top">
                                        <td  class="v-top w-65p">
                                            <table class="w-100p">
                                                <tr class="v-top">
                                                    <td>
                                                        <div class="w-100p" runat="server" id="divItemTable">
                                                        </div>
                                                        <span id="spanAddItems" runat="server" class="a-center" style="color: Red; display: none;">
                                                            <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_25 %> </span>
                                                    </td>
                                                </tr>
                                                <tr id="trOtherCurrency" runat="server" style="display: none;">
                                                    <td id="Td1" runat="server">
                                                        <OtherCurrency:OtherCurrencyDisplay IsDisplayPayedAmount="false" ID="OtherCurrencyDisplay1"
                                                            runat="server" />
                                                    </td>
                                                </tr>
                                                <tr id="divPaymentType" runat="server">
                                                    <td id="Td2" class="a-center" runat="server">
                                                        <Payment:paymentType ID="PaymentType" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-left v-bottom bold" style="display: none;" id="tdCopayment" runat="server">
                                                        <table border="1">
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <%-- <asp:Label ID="Label5" runat="server" Text="Medical Amount" />--%>
                                                                    <asp:Label ID="Label5" runat="server" Text="Billed Amount" 
                                                                        meta:resourcekey="Label5Resource1" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblMedical" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblMedicalResource1" />
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label13" runat="server" Text="Non Medical Amount" 
                                                                        meta:resourcekey="Label13Resource1" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblNonMedical" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblNonMedicalResource1" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label23" runat="server" Text="Actual Copayment " 
                                                                        meta:resourcekey="Label23Resource1" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblActualCopaymenttxt" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblActualCopaymenttxtResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label6" runat="server" 
                                                                        Text="Difference Between Claim & Medical Amount " 
                                                                        meta:resourcekey="Label6Resource1" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblDifferenceAmount" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblDifferenceAmountResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblPreAuthAmt" Text="Patient Net Payable Amount" runat="server" 
                                                                        meta:resourcekey="lblPreAuthAmtResource1"></asp:Label>
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblTotal" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblTotalResource1"></asp:Label>
                                                                </td>
                                                                <asp:HiddenField ID="hdnClaim" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnTotalCopayment" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnTowardsAmount" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnPreAuthType" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnPreAuthPercentage" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnPreAuthAmount" runat="server" Value="0" />
                                                                <asp:HiddenField ID="hdnCoPaymentType" runat="server" Value=" " />
                                                                <asp:HiddenField ID="hdnClaimID" runat="server" Value="-1" />
                                                                <asp:HiddenField ID="hdnCoPaymentlogicID" runat="server" Value="-1" />
                                                                <asp:HiddenField ID="hdnCoPaymentPerCentage" runat="server" Value="0" />
                                                                 <asp:HiddenField ID="hdnpopuporgid" runat="server" Value="" />
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="Label4" runat="server" Text="Claim Amount " 
                                                                        meta:resourcekey="Label4Resource1" />
                                                                </td>
                                                                <td class="a-right">
                                                                    <asp:Label ID="lblClaminAmount" runat="server" Text="0.00" 
                                                                        meta:resourcekey="lblClaminAmountResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table>
                                                <tr id="trRollingAdvance" style="display:none" >
                                                    <td>
                                                        <span><%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_26 %>&nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_31 %>&nbsp;&nbsp;&nbsp;
                                                        </span>
                                                        <asp:Label ID="lblRollingBalAmt" runat="server" Text="0" meta:resourcekey="lblRollingBalAmtResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trRollingAdvance1" style="display: none" runat="server">
                                                    <td runat="server">
                                                        <span><%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_27 %>&nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_31 %>&nbsp;&nbsp;&nbsp;
                                                        
                                                        
                                                        
                                                        </span>
                                                        <asp:Label ID="lblRollingBalAmt1" runat="server" Text="0"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                            <table>
                                                <tr id="trCreditLimit" style="display:none" >
                                                    <td>
                                                        <span><%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_42%>&nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_31 %>&nbsp;&nbsp;&nbsp;
                                                        </span>
                                                        <asp:Label ID="lblCreditLimitAmt" runat="server" Text="0" meta:resourcekey="lblRollingBalAmtResource1"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trCreditLimit1" style="display: none" runat="server">
                                                    <td id="Td5" runat="server">
                                                        <span><%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_27 %>&nbsp;<%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_31 %>&nbsp;&nbsp;&nbsp;
                                                        
                                                        
                                                        
                                                        </span>
                                                        <asp:Label ID="Label7" runat="server" Text="0"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            
                                            <div id="dvHealhcard" runat="server">
                                                <table style="padding-top: 5px">
                                                    <tr>
                                                       <td class="v-top a-left">
                                                            <div id="dvExistingCard" class="w-100p">
                                                                <table class="w-100p">
                                                                    <tr>
                                                                        <td style="padding-left: 50px">
                                                                            <div id="DvCard" class="w-100p">
                                                                                <asp:Label ID="lblCardNo" runat="server" Text="Health&nbsp;card&nbsp;No" meta:resourcekey="lblCardNoResource1"></asp:Label>
                                                                                <asp:TextBox ID="txtCardNo" runat="server" meta:resourcekey="txtCardNoResource1"></asp:TextBox>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <button id="btnAddcardNo" value="Add" onclick="javascript:return GetMemberDetails('VerifyMember','CardNo');"
                                                                                    class="btn">
                                                                                    <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_02 %></button>
                                                                                <asp:Label ID="lblMobileNumber" Text="Click Here To Use Mobile Number" runat="server"
                                                                                    onclick="javascript:ClickCardType('Mobile');" class="lnkOtp w-50p" Style="display: none"
                                                                                    meta:resourcekey="lblMobileNumberResource1"></asp:Label>
                                                                                <asp:Label ID="lblCardStatus" runat="server" ClientIDMode="Static" meta:resourcekey="lblCardStatusResource1"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none">
                                                                        <td>
                                                                            <div id="DvMobile" class="w-100p">
                                                                                <asp:Label ID="lblMobileNo" runat="server" Text="Mobile No" Width="60px" meta:resourcekey="lblMobileNoResource1"></asp:Label>
                                                                                <asp:TextBox ID="txtMobileNo" runat="server" onChange="javascript:GetMemberDetails('VerifyMember','MobileNo');"
                                                                                    meta:resourcekey="txtMobileNoResource1"></asp:TextBox>
                                                                                &nbsp;&nbsp;&nbsp;
                                                                                <asp:Label ID="lblCardNumber" Text="Click Here To Use Card Number" runat="server"
                                                                                    class="lnkOtp" onclick="javascript:ClickCardType('Card');" Width="50%" meta:resourcekey="lblCardNumberResource1"></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="display: none">
                                                                        <td>
                                                                            <asp:CheckBox ID="chkCredit" runat="server" ClientIDMode="Static" Text="Credit" Checked="True"
                                                                                Style="display: none" meta:resourcekey="chkCreditResource1" />
                                                                            <asp:CheckBox ID="chkRedeem" runat="server" ClientIDMode="Static" Text="Redeem" Style="display: none"
                                                                                onclick="javascript:ClickCardType('Redeem');" meta:resourcekey="chkRedeemResource1" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <style type="text/css">
                                                                                #cardPoints tr td
                                                                                {
                                                                                    border: 1px solid black;
                                                                                }
                                                                            </style>
                                                                            <table id="cardPoints"  style="padding-top: 20px" width="350px">
                                                                               
                                                                                <tr id="trHeader" style="display: none" class="Duecolor">
                                                                                    <td class="Duecolor">
                                                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_28 %>
                                                                                    </td>
                                                                                    <td class="Duecolor">
                                                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_29 %>
                                                                                    </td>
                                                                                    <td class="Duecolor">
                                                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_30 %>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                        <%-- <td valign="top">
                                                             <asp:CheckBox ID="chkMycard" runat="server" ClientIDMode="Static" onclick="javascript:CheckMyCard();" />
                                                             <input type="checkbox" id="chkMycard" runat="serv1er" checked="false"  ClientIDMode="Static"/> 
                                                             <asp:Label ID="lblHealthcard" runat="server" Text="Health Coupon" ClientIDMode="Static"></asp:Label> 
                                                        </td>--%>
                                                        <td runat="server" id="tdMycard" class="v-top">
                                                            <div id="dvMycard">
                                                                <asp:RadioButton ID="rbNewCard" runat="server" Text="New Card" name="CardType" ClientIDMode="Static"
                                                                    onclick="javascript:ClickCardType('NewCard');" meta:resourcekey="rbNewCardResource1" />
                                                                <asp:RadioButton ID="rbExistingCard" runat="server" Text="Existing Card" name="CardType"
                                                                    onclick="javascript:ClickCardType('ExistsCard');" ClientIDMode="Static" meta:resourcekey="rbExistingCardResource1" />
                                                            </div>
                                                        </td>
                                                     
                                                        <td class="v-top">
                                                            <div id="dvPoints" style="display: none">
                                                                <table>
                                                                    <tr id="trCreditPoints" style="display: none;">
                                                                        <td>
                                                                            <asp:Label ID="lblPoints" runat="server" Text="Your Current Points is:" meta:resourcekey="lblPointsResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblCreditPoints" runat="server" ClientIDMode="Static" meta:resourcekey="lblCreditPointsResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr id="trCreditAmount" style="display: none;">
                                                                        <td>
                                                                            <asp:Label ID="lblValue" runat="server" Text="Your Current Points Rs:" meta:resourcekey="lblValueResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblCreditValue" runat="server" ClientIDMode="Static" meta:resourcekey="lblCreditValueResource1"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="DvRedeemOnetimePassword">
                                                    <asp:Panel ID="pnlRedeem" runat="server" GroupingText="Redeem" meta:resourcekey="pnlRedeemResource1">
                                                        <table>
                                                            <tr id="trOtp" style="display: none;">
                                                                <td>
                                                                    <button id="btnGenerateOTP" class="btn" onclick="return GenerateOtp('Billing');">
                                                                        <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_03 %></button>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblOtp" runat="server" Text="Enter Your OTP:" meta:resourcekey="lblOtpResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtOTP" runat="server" meta:resourcekey="txtOTPResource1"></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <button id="Button1" class="btn" onclick="return VerifyOtp();">
                                                                        <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_04 %></button>
                                                                </td>
                                                            </tr>
                                                            <tr id="trOtpVerifyStatus" style="display: none;">
                                                                <td colspan="4">
                                                                    <asp:Label ID="lblOtpStatus" runat="server" meta:resourcekey="lblOtpStatusResource1"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </asp:Panel>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <table>
                                                <tr>
                                                    <td>
                                                        <table id="tblnetamt" runat="server" style="display: none">
                                                            <tr id="tr1" runat="server">
                                                                <td runat="server">
                                                                    <asp:Label ID="Label2" runat="server" meta:resourceKey="lblNetValueResource1" Text="Net Amount" />
                                                                </td>
                                                                <td class="a-right" runat="server">
                                                                    <asp:TextBox ID="txtEdtNetAmt" runat="server" CssClass="Txtboxverysmall" Enabled="False"
                                                                        Style="text-align: right" Text="0.00" />
                                                                    <asp:HiddenField ID="HiddenField2" runat="server" Value="0" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdBillDetails" runat="server">
                                                <tr id="trFoc" runat="server">
                                                    <td colspan="2" runat="server">
                                                        <div class="a-left">
                                                            <asp:CheckBox ID="chkFoc" runat="server" Checked="false" Enabled="false"></asp:CheckBox>
                                                            <asp:Label ID="lblFoc" Text="IS FOC" runat="server" meta:resourceKey="lblNetValueResource1" />
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr id="trnetamt" style="display: none" runat="server">
                                                    <td style="display: none" runat="server">
                                                        <asp:Label ID="Label1" Text="Net Amount" runat="server" meta:resourceKey="lblNetValueResource1" />
                                                    </td>
                                                    <td class="a-right" style="display: none" runat="server">
                                                        <asp:TextBox CssClass="Txtboxverysmall" ID="TextBox1" Style="text-align: right" Enabled="False"
                                                            runat="server" Text="0.00" meta:resourceKey="txtNetAmountResource1" />
                                                        <asp:HiddenField ID="HiddenField1" runat="server" Value="0" />
                                                    </td>
                                                </tr>
                                                <tr id="trOrderedItemsCount" runat="server" style="display: none;">
                                                    <td class="a-left" runat="server">
                                                        <asp:Label ID="lblOrderCount" ForeColor="Red" Font-Bold="True" Text="Ordered Items:"
                                                            runat="server" meta:resourcekey="lblOrderCountResource1"></asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:Label ForeColor="Red" Font-Bold="True" ID="lblOrderedItemsCount" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trDiscountPart" runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="tdDiscountLabel" runat="server">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_04 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList Enabled="False" CssClass="ddl" ID="ddDiscountPercent" Width="98%"
                                                            onChange="javascript:SetDiscountAmt();SetNetValue('ADD');IsCheckMyCard();" runat="server"
                                                            meta:resourceKey="ddDiscountPercentResource1">
                                                        </asp:DropDownList>
                                                        <asp:Button ID="btnDiscountPercent" runat="server" Enabled="false" Text="Discount"
                                                            CssClass="smallbtn" />
                                                        <asp:Label ID="lblTtlDiscountPercentage" runat="server" Text=""></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr id="trDiscountType" runat="server" style="display: none">
                                                    <td runat="server">
                                                        <asp:Label ID="lblDiscountType" runat="server" meta:resourceKey="tdDiscountLabelResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_06 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList CssClass="ddl" ID="ddlDiscountType" Width="98%" ToolTip="Select the Discount"
                                                            runat="server" meta:resourceKey="ddDiscountPercentResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trSlab" runat="server" style="display: none">
                                                    <td runat="server">
                                                        <asp:Label ID="lblSlab" runat="server" meta:resourceKey="tdDiscountLabelResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_08 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList CssClass="ddl" ID="ddlSlab" Width="95%" ToolTip="Select the Discount"
                                                            onChange="javascript:SetNetValue('ADD');" runat="server" meta:resourceKey="ddDiscountPercentResource1">
                                                        </asp:DropDownList>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr id="trCeiling" runat="server" style="display: none">
                                                    <td runat="server">
                                                        <asp:Label ID="lblCeiling" runat="server" meta:resourceKey="tdDiscountLabelResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_09 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtCeiling" runat="server" onchange="javascript:SetNetValue('ADD');"
                                                            CssClass="AutoCompletesearchBox"      onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                                                        <img src="../Images/starbutton.png" alt="" align="middle" />
                                                    </td>
                                                </tr>
                                                <tr id="tdDiscReason" runat="server">
                                                    <td class="a-left" runat="server">
                                                        <asp:Label ID="lblDiscountReason" runat="server">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_10 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList Enabled="False" ID="ddlDiscountReason" runat="server" CssClass="ddl"
                                                            Width="98%" onchange="javascript:GetSelectedValue();">
                                                        </asp:DropDownList>
                                                        <asp:TextBox Style="display: none;" ID="txtDiscountReason" autocomplete="off" CssClass="Txtboxsmall"
                                                            Width="95%" runat="server" MaxLength="900" onfocus="javascript:CheckBillItems();" />
                                                        <%-- <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                    </td>
                                                </tr>
                                                <tr id="trAuthorisedBy" runat="server">
                                                    <td class="a-left" runat="server">
                                                        <asp:Label ID="lblAuthorised" runat="server">
                                                         <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_11 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtAuthorised" Enabled="False" autocomplete="off" onfocus="javascript:CheckBillItems();"
                                                            CssClass="AutoCompletesearchBox" runat="server" Width="145px" />
                                                        <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                        <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" CompletionInterval="10"
                                                            FirstRowSelected="true" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                                            CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                                            Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandLoginID"
                                                            ServicePath="~/WebService.asmx" TargetControlID="txtAuthorised" OnClientItemOver="DiscountAuthSelectedOver"
                                                            OnClientItemSelected="DiscountAuthSelected">
                                                        </ajc:AutoCompleteExtender>
                                                    </td>
                                                </tr>
                                                <tr id="trRSTax" runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="Rs_Tax" runat="server">
                                                         <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_12 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:DropDownList Enabled="False" CssClass="ddl" ID="ddlTaxPercent" Width="98%" onChange="javascript:SetTaxAmt();SetNetValue('ADD');"
                                                            runat="server" meta:resourceKey="ddlTaxPercentResource1">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trHistory" runat="server">
                                                    <td class="v-top" runat="server">
                                                        <asp:Label ID="lblHistory" runat="server" meta:resourceKey="lblHistoryResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_13 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtPatientHistory" Width="95%" runat="server" onBlur="return collapseTextBox(this.id);"
                                                            onFocus="return expandTextBox(this.id)" TextMode="MultiLine" onkeypress="javascript:return MaxLengthAlert(this.id);"
                                                            onChange="javascript:return MaxLengthAlert(this.id);" meta:resourceKey="txtPatientHistoryResource1"
                                                            ></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr id="trRemarks" runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="lblRemarks" runat="server" meta:resourceKey="lblRemarksResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_14 %>
                                                        </asp:Label>
                                                    </td>
                                                    <td runat="server">
                                                        <asp:TextBox ID="txtRemarks" Width="95%" runat="server" MaxLength="900" onBlur="return collapseTextBox(this.id);"
                                                            onFocus="return expandTextBox(this.id)" TextMode="MultiLine" meta:resourceKey="txtRemarksResource1"
                                                            ></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td class="w-15p" runat="server" id="tdGrossBillDetails">
                                <table class="w-100p">
                                    <tr id="trGross" runat="server">
                                        <td>
                                            <asp:Label ID="lblGross" runat="server" Text="Gross" class="defaultfontcolor" meta:resourceKey="lblGrossResource1" />
                                        </td>
                                        <td class="a-right" id="tdGross" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtGross" Style="text-align: right" runat="server"
                                                Text="0.00" Enabled="False" ></asp:TextBox>
                                            <asp:HiddenField ID="hdnGrossValue" runat="server" Value="0" />
                                        </td>
                                        <td class="a-right" id="tdMRPGross" runat="server" style="display:none;">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtMRPGross" Style="text-align: right" runat="server"
                                                Text="0.00" Enabled="False"></asp:TextBox>
                                                <asp:HiddenField ID="hdnMRPGrossValue" runat="server" Value="0" />
                                            
                                        </td>
                                    </tr>
                                    <tr id="trHealthCard" style="display: none;">
                                        <td>
                                            <asp:Label ID="lblRedeem" runat="server" Text="Redeem" class="defaultfontcolor" meta:resourcekey="lblRedeemResource1" />
                                        </td>
                                        <td class="a-right">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtRedeem" Style="text-align: right"
                                                runat="server" Text="0.00" ReadOnly="true" meta:resourcekey="txtRedeemResource1"></asp:TextBox>
                                            <%-- <asp:HiddenField ID="HiddenField3" runat="server" Value="0" />--%>
                                        </td>
                                    </tr>
                                    <tr id="trDisAmount" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblDiscount" runat="server" class="defaultfontcolor" meta:resourceKey="lblDiscountResource1">
                                                <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_05 %>
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtDiscount"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                onBlur="javascript:SetNetValue('ADD');" Style="text-align: right;" runat="server"
                                                Text="0.00" meta:resourceKey="txtDiscountResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnDiscountAmt" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trServiceCharge" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblServiceCharge" runat="server" meta:resourceKey="lblServiceChargeResource1">
                                            <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_17 %>
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtServiceCharge" Style="text-align: right"
                                                Enabled="True" runat="server" Text="0.00" meta:resourceKey="txtServiceChargeResource1" />
                                            <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trTaxAmountPart" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblTaxt" runat="server" meta:resourceKey="lblTaxtResource1">
                                            <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_18 %> 
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                onChange="javascript:SetNetValue('ADD');" ID="txtTax" runat="server" Style="text-align: right"
                                                Text="0.00" meta:resourceKey="txtTaxResource1"></asp:TextBox>
                                            <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdfTax" runat="server" />
                                            <div id="dvTaxDetails" align="left" runat="server">
                                            </div>
                                        </td>
                                    </tr>
                                    <tr id="trRsEDSChess" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="Rs_EDCess" runat="server">
                                             <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_19 %> 
                                            </asp:Label>
                                            <asp:CheckBox runat="server" Width="7%" ToolTip="Add ED Cess to Bill" onclick="javascript:SetNetValue('ADD');"
                                                ID="chkEDCess" meta:resourceKey="chkEDCessResource1" />
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtEDCess"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                onBlur="javascript:SetNetValue('ADD');" Style="text-align: right" runat="server"
                                                Text="0.00" />
                                            <asp:HiddenField ID="hdnEDCess" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trRssHEDChess" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="Rs_SHEDCess" Text="SHED Cess(1%)" runat="server">
                                             <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_20 %> 
                                            </asp:Label>
                                            <asp:CheckBox runat="server" Width="7%" onclick="javascript:SetNetValue('ADD');"
                                                ID="chkSHEDCess" meta:resourceKey="chkSHEDCessResource1" />
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtSHEDCess"      onkeypress="return ValidateOnlyNumeric(this);"   
                                                onBlur="javascript:SetNetValue('ADD');" Style="text-align: right" runat="server"
                                                Text="0.00" />
                                            <asp:HiddenField ID="hdnSHEDCess" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trRoundOffAmount" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblRoundOffAmt" Text="Round Off" runat="server" meta:resourceKey="lblRoundOffAmtResource1">
                                             <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_21 %> 
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtRoundoffAmt" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" meta:resourceKey="txtRoundoffAmtResource1" />
                                            <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trNetValue" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblNetValue" runat="server" meta:resourceKey="lblNetValueResource1">
                                             <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_22 %> 
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" id="tdNetAmount" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtNetAmount" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" />
                                            <asp:HiddenField ID="hdnNetAmount" runat="server" Value="0" />
                                        </td>
                                        <td id="tdMRPNetAmount" class="a-right" runat="server" style="display:none;">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtMRPNetAmount" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" />
                                            <asp:HiddenField ID="hdnMRPNetAmount" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trAmountReceived" runat="server">
                                        <td runat="server">
                                            <asp:Label ID="lblAmtReceived" Text="Amt Received" runat="server" meta:resourceKey="lblAmtReceivedResource1">
                                            <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_23 %> 
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtAmtReceived" Style="text-align: right"
                                                Enabled="False" runat="server" Text="0.00" meta:resourceKey="txtAmtReceivedResource1" />
                                            <asp:HiddenField ID="hdnAmountReceived" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                    <tr id="trDue" runat="server" style="display: table-row;">
                                        <td runat="server">
                                            <asp:Label ID="lblDue" runat="server" meta:resourceKey="lblDueResource1">
                                            <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_24 %> 
                                            </asp:Label>
                                        </td>
                                        <td class="a-right" id="tdDue" runat="server">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtDue" Style="text-align: right" Enabled="False"
                                                runat="server" Text="0.00"  />
                                            <asp:HiddenField ID="hdnDue" runat="server" Value="0" />
                                        </td>
                                        <td id="tdMRPDue" class="a-right" runat="server" style="display:none;">
                                            <asp:TextBox CssClass="Txtboxverysmall" ID="txtMRPDue" Style="text-align: right" Enabled="False"
                                                runat="server" Text="0.00" />
                                            <asp:HiddenField ID="hdnMRPDue" runat="server" Value="0" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
  
                    <table>
                     <tr>
                        <td align="center" id="td20" runat="server">
                            <asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; height: 540px; width: 1050px;"
                                ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup" meta:resourcekey="pnlOutDocResource1">
                                <%--<asp:Panel ID="pnlOutDoc" runat="server" Style="display: none; 600px; width: 1050px;"
                                        ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">--%>
                                <div id="div7">
                                    <table border="0" cellpadding="2" cellspacing="1" width="100%" class="dataheader2 defaultfontcolor">
                                       
                                        
                                                 

                                        
                                        <tr>
                                            <td>
                                                <input type="button" id="Button3" runat="server" style="display: none;" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                           <input id="QSave" runat="server" class="btn" onclick="popupformedit();" type="button" value="Save" />&nbsp;&nbsp;&nbsp;
                              <input id="btnClose4" runat="server" class="btn" type="button" value="Close" /></asp:Panel>
                                              </asp:Panel>
                            <ajc:ModalPopupExtender ID="mpopOutDoc" runat="server" BackgroundCssClass="modalBackground"
                                DropShadow="false" PopupControlID="pnlOutDoc" CancelControlID="btnClose4" TargetControlID="Button3"
                                Enabled="True">
                            </ajc:ModalPopupExtender>
                        </td>
                    </tr>
                    </table>
                
                <div runat="server" id="divtemplate" style="display:none;">
                
                </div>
                    <input id="hdnDiscountApprovedBy" type="hidden" value="0" runat="server" />
                    <input type="hidden" runat="server" value="Y" id="hdnIsCashClient" />
                    <input type="hidden" runat="server" value="Y" id="hdnOrgid" />
                    <input type="hidden" runat="server" value="" id="hdnClientType" />
                    <input type="hidden" runat="server" value="" id="hdnReportCommitedDate" />
                    <input type="hidden" runat="server" value="Y" id="hdnValidation" />
                    <input id="hdfBillType1" type="hidden" runat="server" />
                    <input id="hndLocationID" type="hidden" value="0" runat="server" />
                    <input id="hdnFeeTypeSelected" type="hidden" runat="server" value="COM" />
                    <input id="hdnName" type="hidden" runat="server" />
                    <input id="hdnAmt" type="hidden" runat="server" value="0" />
                    <input id="hdnID" type="hidden" runat="server" />
                    <input id="hdnReportDate" type="hidden" runat="server" />
                    <input id="hdnRemarks" type="hidden" runat="server" />
                    <input id="hdnIsRemimbursable" type="hidden" runat="server" />
                    <input id="hdnPaymentControlReceivedtemp" type="hidden" value="0.00" runat="server" />
                    <input type="hidden" id="hdnActualAmount" value="0" runat="server" />
                    <input type="hidden" id="hdnBaseRateID" value="0" runat="server" />
                    <input type="hidden" id="hdnDiscountPolicyID" value="0" runat="server" />
                    <input type="hidden" id="hdnDiscountCategoryCode" value="" runat="server" />
                    <input type="hidden" id="hdnGender" runat="server" />
                    <input type="hidden" runat="server" value="N" id="hdnIsDiscount" />
                    <input type="hidden" runat="server" value="Y" id="hdnIsDiscountableTest" />
                    <input type="hidden" runat="server" value="Y" id="hdnIsTaxable" />
                    <input type="hidden" runat="server" value="N" id="hdnIsRepeatable" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSTAT" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSMS" />
                    <input type="hidden" runat="server" value="N" id="hdnIsOutSource" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountableTestTotal" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemableTestAmount" />
                    <input type="hidden" runat="server" value="0" id="hdnTaxableTestToal" />
                    <input type="hidden" runat="server" value="N" id="hdnIsNABL" />
                    <input type="hidden" runat="server" value="0" id="hdnBillingItemRateID" />
                    <input type="hidden" runat="server" value="0" id="hdnInvCode" />
                    <input type="hidden" runat="server" value="0" id="hdnOrgIDC" />
                    <input type="hidden" runat="server" value="N" id="hdnHasHistory" />
                    <input type="hidden" runat="server" value="N" id="hdnProcessingLoc" />
                    <input id="hdnInvHistory" type="hidden" runat="server" />
                    <input id="hdnHistoryAttributeList" type="hidden" runat="server" />
                    <asp:HiddenField ID="hdnAttributesList" runat="server" />
                    <input id="hdnCapture" type="hidden" runat="server" />
                    <input id="hdnHistoryTableList" type="hidden" runat="server" />
                    <input id="hdnHistoryTableLists" type="hidden" runat="server" />
                    <input id="hdnHistoryTableListsP" type="hidden" runat="server" />
                    <input type="hidden" runat="server" id="hdnIsInvestigationAdded" value="0" />
                    <asp:HiddenField ID="hdnfinduplicate" runat="server" />
                    <input type="hidden" runat="server" value="N" id="hdnoutsourcelocation" />
                    <input type="hidden" runat="server" id="hdnDiscountPercentage" value="0" />
                    <input type="hidden" runat="server" id="hdnAllowMulDisc" />
                    <input type="hidden" runat="server" id="hdnDisPercentage" />
                    <input type="hidden" runat="server" id="hdnDisReason" />
                    <input type="hidden" runat="server" id="hdnCpedit" value="N" />
                    <asp:HiddenField ID="hdnIsClientBilling" Value="N" runat="server" />
                    <asp:HiddenField ID="hdnIsBillable" Value="" runat="server" />
                    <asp:HiddenField ID="hdnIsCollected" Value="N" runat="server" />
                    <asp:HiddenField ID="hdnCollectedDateTime" Value="01/01/1900" runat="server" />
                    <asp:HiddenField ID="hdnLocName" runat="server" />
                    <asp:HiddenField ID="ZeroAmount" runat="server" />
                    <input id="hdnDeliveryDate" type="hidden" runat="server" />
                    <input type="hidden" runat="server" value="N" id="hdnIsHistoryMandatory" />
                    <input type="hidden" runat="server" id="hdnIshtml" />
                    <input type="hidden" runat="server" id="hdnIsTemplateID" />
                    <input type="hidden" runat="server" id="hdnIsTemplateText" />
                     <input type="hidden" runat="server" id="hdnTemplateValue"/>
                    <input type="hidden" runat="server" value="0" id="hdnDiscountID" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSpecialTest" />
                     <asp:HiddenField ID="hdnSpecimenValues" runat="server" />
                      <input id="hdnTestFeeID" type="hidden" runat="server" />
                    <%-- Added--%>
                    <input type="hidden" runat="server" value="0" id="hdnCeilingValue" />
                    <input type="hidden" runat="server" value="0" id="hdnMaxDiscount" />
                    <input type="hidden" runat="server" value="" id="hdnItems" />
                    <input type="hidden" runat="server" value="" id="hdnItemsNoDiscount" />
                    <input type="hidden" runat="server" value="" id="hdnItemLevelPercent" />
                    <input type="hidden" runat="server" value="" id="hdnItemLevelTotalPercent" />
                    <input type="hidden" runat="server" value="0" id="hdnIsNormalRateCard" />
                    <input type="hidden" runat="server" value="N" id="hdnIsSlabDiscount" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountSlab" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountCeiling" />
                    <input type="hidden" runat="server" value="0" id="hdnSlabPercentAndValue" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountDetails" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountType" />
                    <input type="hidden" runat="server" value="0" id="hdnDiscountReason" />
                    <input type="hidden" runat="server" value="" id="hdnDiscountReasonForFoc" />
                    <input type="hidden" runat="server" value="N" id="hdnIsRedeem" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemAmount" />
                    <%-- MyCard--%>
                    <input type="hidden" runat="server" value="N" id="hdnHasMyCard" />
                    <input type="hidden" runat="server" value="0" id="hdnExistingPatientID" />
                    <input type="hidden" runat="server" value="0" id="hdnMycardDetails" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemPoints" />
                    <input type="hidden" runat="server" value="0" id="hdnRedeemValue" />
                    <input type="hidden" runat="server" value="0" id="hdnMembershipCardMappingID" />
                    <input type="hidden" runat="server" value="" id="hdnOtpExist" />
                    <input type="hidden" runat="server" value="" id="hdnHealthCardItems" />
                    <input type="hidden" runat="server" value="" id="hdnlstHealthCardItems" />
                    <input type="hidden" runat="server" value="N" id="hdnHealthCardOTP" />
                    <input type="hidden" runat="server" value="" id="hdnmyCardDetailsbill" />
                    <input type="hidden" runat="server" value="" id="hdnMycarddetailsSave" />
                    <input type="hidden" runat="server" value="" id="hdnTotalRedeemPoints" />
                    <input type="hidden" runat="server" value="" id="hdnTotalRedeemAmount" />
                    <input type="hidden" runat="server" value="" id="hdntotalredemPoints" />
                    <input type="hidden" runat="server" value="" id="hdnHasClientHealthcoupon" />
                    <input type="hidden" runat="server" value="" id="hdnOrgHealthCoupon" />
                    <%--Quantumhdnfields added--%>
                    <asp:HiddenField ID="hdnBilledDate" runat="server" Value='' />
                    <asp:HiddenField ID="hdnRtID" runat="server" />
                    <asp:HiddenField ID="hdnZeroAmount" runat="server" />
                    <asp:HiddenField ID="hdnRateForStat" runat="server" />
                    <asp:HiddenField ID="hdnIsStatValues" runat="server" />
                    <asp:HiddenField ID="hdnTaxCalFromNetAmt" runat="server" Value="N" />
                    <asp:HiddenField ID="hdnPkgandgrpID" runat="server" />
                    <asp:HiddenField ID="hdnIsOptionalTest" runat="server" />
                    <asp:HiddenField ID="hdnStstFee" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnAutoCalcGenBillItemID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnAutoCalcGenBillItemAmt" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnStatAutoFeeID" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnActualGenBillItemAmt" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnActualStatAmt" runat="server" Value="0" />
                    <asp:HiddenField ID="hdnNeedAutoCalc" runat="server" Value="Y" />
                    <asp:HiddenField ID="hdnAllowZeroAmt" runat="server" />
                    <asp:HiddenField ID="hdnallowduplicatetesttobill" runat="server"  Value="N" />
                    <asp:HiddenField ID="hdnallowduplicatetesttobill1" runat="server"  Value="N" />
                   <%-- VEL--%>
                    <asp:HiddenField ID="hdnDisplayMRPAmount" runat="server"  Value="N" />
                    <%--VEL--%>
   
                 
                    <input id="hdnTATProcessDateTime" type="hidden" runat="server" />
				    <input id="hdnTATSampleReceiptDateTime" type="hidden" runat="server" />
				    <input id="hdnTATProcessStartDateTime" type="hidden" runat="server" />
				 
				    <input id="hdnTATLogisticTimeasmins" type="hidden" runat="server" />
				    <input id="hdnTATProcessinghoursasmins" type="hidden" runat="server" />
				    <input id="hdnTATLabendTime" type="hidden" runat="server" />
				    <input id="hdnTATEarlyReportTime" type="hidden" runat="server" />
				    <input id="hdnTatreferencedatebase" type="hidden" runat="server" />
		        	<input id="hdnSampleExpiryDate" type="hidden" runat="server" />
				       <%-- Seetha--%>
                    <asp:HiddenField ID="hdnEnableHistoryTest" runat="server"  Value="N" />
					<asp:HiddenField ID="hdnIsMandatoryHis" runat="server"  Value="false" />
                    <asp:HiddenField ID="hdnEnableHistoryTestConfig" runat="server"  Value="N" />
                   
                    <asp:HiddenField ID="hdnTestHistFeeID" runat="server"  Value="0"/>
                    
                    <asp:HiddenField ID="hdnTestHistFeeType" runat="server"  Value="" />
                     <asp:HiddenField ID="hdnNotallowDiscashClient" runat="server" Value="N" />
                    <%--Seetha--%>
					
					<%--HomeCollectionPayment--%>
				    <input type="hidden" id="hdnHCPayments" runat="server" />
                  
    
                </asp:Panel>
                <div class="w-100p">
                    <div id="divHistoryDetail" class="w-100p">
                        <asp:Panel ID="PanelHistory" runat="server" ScrollBars="Vertical" CssClass="History_ModalPopup modalPopup dataheaderPopup"
                            meta:resourcekey="PanelHistoryResource1">
                            <div id="divHistory">
                                <table class="dataheader2 defaultfontcolor w-100p">
                                    <tr>
                                        <td id="Td3" runat="server" class="w-100p">
                                            <His:History ID="UcHistory" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="a-center">
                                            <table class="w-100p h-100">
                                                <tr>
                                                    <td class="a-right">
                                                        <button runat="server" id="Butsave" class="btn" onclick="return AddHistoryItemList();">
                                                            <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_05 %></button>
                                                    </td>
                                                    <td class="margin0 padding0">
                                                        <button runat="server" id="ButEdit" class="btn" onclick="edits_Click();return false;" style="display: none;">
                                                            <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_06 %></button>
                                                    </td>
                                                    <td class="margin0 padding0">
                                                        <%--<button runat="server" id="ButPrint" class="btn" onclick="return popupprintHistory();" style="display: none;">
                                                            <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_07 %></button>--%>
                                                            
                                                                  <input type="button" runat="server" id="ButPrint" class="btn" value="Print" onclick="popupprintHistory();"
                                                            style="display: none;" meta:resourcekey="ButPrintResource1" />
                                                            
                                                    </td>
                                                    <td class="a-left">
                                                        <button id="Butclose" runat="server" class="btn">
                                                            <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_08 %></button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <asp:Panel ID="PanelAttributes" runat="server" Style="height: 365px; width: 750px;"
                            ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup">
                            <div id="divAttributes">
                                <table class="w-100p a-center" cellpadding="2" cellspacing="1" class="dataheader2 defaultfontcolor">
                                    <tr>
                                        <td id="Td4" class="w-100p">
                                            <His:History ID="UctHistory" runat="server" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="MPEhistory" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="PanelHistory" CancelControlID="Butclose" TargetControlID="LnkHistory"
                            Enabled="True">
                        </ajc:ModalPopupExtender>
                        <ajc:ModalPopupExtender ID="PATattributes" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="PanelAttributes" TargetControlID="LnkAttributes"
                            Enabled="True">
                        </ajc:ModalPopupExtender>
                    </div>
                    
                    <div id="mymodaldiag2" class="modalDiag paddingT100">
    <!-- modaldiag1 content -->
    <div id="myModalclass2" class="w-75p">
        <div class="modalDiag-header">
            <span class="bold w-100p"><span class="marginT5">Specimen Entry</span><span onclick="closeModdalDialog('mymodaldiag2', 'myModalclass2');" class="closeModalDiag pointer pull-right">X</span></span>
        </div>
        <div class="modalDiag-body">
                    <div id="divSpecimen">
                       <asp:Panel ID="pnlSpecimen" runat="server" CssClass="w-100p">
     
                          
                                <table class="w-100p">
                                    
                                    <tr>
                                        <td>
                                            <table class="w-100p">
                                                <tr>
                                                    <td>
                                                        <label for="txtSpecimen">Specimen</label>
                                                    </td>
                                                    <td class="margin0 padding0 a-left">
                                                      <input type="text" class="TxtEnterkeyPress" id="txtSpecimen" />
                                                      <img src="../Images/starbutton.png" alt="" align="middle" />
                                                      <input type="hidden" id="hdnspecimenid" runat="server" />
                                                        <input type="hidden" id="hdnspecimenname" runat="server" />
                                                    </td>
                                                    <td class="margin0 padding0 a-left">
                                                               <label for="txtContainercount">Container Count</label>                                                   
                                                    </td>
                                                    <td class="a-left w-20p">                                                       
                                                       
                                                        <input type="text" class="TxtEnterkeyPress txtsmall w-20p" maxlength="2" id="txtContainercount" onkeypress="return ValidateOnlyNumeric(this);"  />                                                            
                                         <img src="../Images/starbutton.png" alt="" align="middle" />
                                                       

                                                    </td>
                                                    <td>
                                                    <label style="font-weight:bold">No of Containers :</label>
                                                    <label id="lblTCCount" runat="server"></label>
                                                    </td>
                                                    <td class="a-left">
                                                     <input type="button" id="btnspecAdd" onclick="addspecimentabledetails();" value="Add" class="btn" runat="server" />
                                                    </td>
                                                </tr>
                                                
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                 <div class="gridTable bounceinup marginT20" id="divspectab">
                            <div class="table-responsive">
                              <table class="w-100p gridView" id="TblSpecimen" style="display:none;">
                                  <thead>
                                        <tr>
                                            <th class="hide_Column">TestID</th>
                                            <th class="">TestName</th>
                                             <th class="hide_Column">TestType</th>
                                            <th class="hide_Column">SpecialSampleID</th>
                                            <th>Specimen</th>
                                            <th>Container Count</th>
                                            <th>Action</th>                                          
 
                                        </tr>
                                  </thead>
                                  <tbody>
                  
                                    </tbody>
                              </table>
                           </div>
                    </div>
                    <br /><br />
                    
                   
                    <div class="w-100p">
                    <div class="w-50p inline-block">
                        <label id="lblCnotes" style="vertical-align:top" runat="server">Clinical Notes</label>
                      <textarea name="textarea" id="txtClinicalNotes" style="height:50px; width:250px;" rows="80" cols="25"></textarea>
                    </div>
                    <div class="w-49p inline-block">
                        <label id="lblcdiag" style="vertical-align:top" runat="server">Clinical Diagnosis</label>
                        <textarea name="textarea" id="txtClinicalDiag" style="height:50px;width:250px;" rows="80" cols="25"></textarea>
                    </div>
                      
                    <%-- <input type="text" maxlength="500" style=" vertical-align:text-top; height:80px; vertical-align :text-top" class="txtsmall w-30p" id="txtClinicalNotes" style="height:60px;vertical-align:top;" /> --%>
                     &nbsp;&nbsp;&nbsp;&nbsp;
                       
                     <%--<input type="text" maxlength="500" class="txtsmall w-30p" style=" vertical-align:text-top; height:80px; vertical-align:text-top" style="height:60px;vertical-align:top" id="txtClinicalDiag" /> --%>
                    </div>
                    <br /><br />
                                <div class="a-center">
                                 <input type="button" id="btncspeclear" value="Clear" class="btn" runat="server" onclick="btnspecclear();" />
                                                 <input type="button" id="btnspecSave" onclick="saveSpecimendetails();" value="Save" class="btn" runat="server" />
                                    <%--   <input type="button" id="btnspecclose" value="Close" class="btn" runat="server" />--%>
                                         
                                    </div>
                         
                        </asp:Panel>
                  <%--   <ajc:ModalPopupExtender ID="MPESpecimen" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="pnlSpecimen" CancelControlID="btnspecclose" TargetControlID="btncspeclear"
                            Enabled="True">
                        </ajc:ModalPopupExtender>--%>
                        
                    </div>
                    
                     </div>
    </div>
</div>
                    
                    <div id="dvInvstigationDetails">
                        <asp:Panel ID="PanelGroup" runat="server" Style="height: 300px; width: 650px;" CssClass="modalPopup dataheaderPopup"
                            meta:resourcekey="PanelGroupResource1">
                            <asp:Panel ID="table_GroupItem" runat="server" Style="height: 260px; width: 650px;"
                                ScrollBars="Auto" meta:resourcekey="table_GroupItemResource1">
                                <table id="Group" class="a-center">
                                    <tr>
                                        <td>
                                            <asp:Label ID="Lbl_GroupName" runat="server" meta:resourcekey="Lbl_GroupNameResource1"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table id="tblGroupHistory" class='dataheaderInvCtrl gridView' align="center" nowrap='nowrap'
                                    class="w-100p" style='font-size: 11px; border: none'>
                                    <tbody>
                                        <tr class='dataheader1'>
                                            <th scope='col' class="a-left w-7p paddingL2">
                                                <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_34 %> 
                                            </th>
                                            <th scope='col' class="a-left w-53p paddingL2">
                                               <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_35 %> 
                                            </th>
                                            <th scope='col' class="a-left w-15p paddingL2">
                                                <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_36 %> 
                                            </th>
                                            <th scope='col' class="a-left w-25p paddingL2">
                                                <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_37 %> 
                                            </th>
                                             <th scope='col' class="a-left w-25p paddingL2">
                                                
                                            </th>
                                        </tr>
                                        <tbody>
                                </table>
                            </asp:Panel>
                            <div id="Btn_Close">
                                <table class="a-center w-100p">
                                    <tr>
                                        <td class="a-center">
                                        <%--    <input id="Button2" class="btn" onmouseout="this.className='btn'" onmouseover="this.className='btn btnhov'"
                                                type="button" value="Close" onclick="return ClearPopUp1();" />--%>
                                                 <button id="Button2" class="btn"  onclick="return ClearPopUp1();" > <%=Resources.CommonControls_ClientDisplay.CommonControls_ViewTRFImage_ascx_01%> </button>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="MPEMultDisc" runat="server" TargetControlID="btnDiscountPercent"
                            PopupControlID="Panel1" BackgroundCssClass="modalBackground" Enabled="True" DropShadow="True"
                            DynamicServicePath="" CancelControlID="btnCancel" />
                        <asp:Panel ID="Panel1" runat="server" CssClass="modalPopup dataheaderPopup" Style="width: 400px;
                            height: 400px; overflow: scroll; overflow-x: hidden;" meta:resourcekey="Panel1Resource1">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div style="text-align: center;">
                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_41 %> 
                                    </div>
                                    <asp:GridView ID="gvMultiDisTypes" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        Width="100%" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                                        Font-Bold="False" Font-Names="Verdana" Font-Overline="False" Font-Size="9pt"
                                        Font-Strikeout="False" Font-Underline="False" DataKeyNames="Discount,DiscountName"
                                        meta:resourcekey="gvMultiDisTypesResource1">
                                        <Columns>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                <HeaderTemplate>
                                                    Select
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="CheckSelect" runat="server" meta:resourcekey="CheckSelectResource1" />
                                                    <asp:HiddenField ID="hdDiscount" runat="server" Value='<%# Eval("Discount") %>' />
                                                    <asp:HiddenField ID="hdDiscountID" runat="server" Value='<%# Eval("DiscountID") %>' />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_38 %> 
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource2">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDiscountPercentage" runat="server" meta:resourcekey="lblDiscountPercentageResource1"
                                                        Text='<%# Eval("DiscountPercentage") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                    <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_39 %> 
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource3">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDiscountName" runat="server" meta:resourcekey="lblDiscountNameResource1"
                                                        Text='<%# Eval("DiscountName") %>'></asp:Label>
                                                    <asp:HiddenField ID="hdDiscountName" runat="server" Value='<%# Eval("DiscountName") %>' />
                                                </ItemTemplate>
                                                <HeaderTemplate>
                                                   <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_40 %> 
                                                </HeaderTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                    <div class="a-center">
                                        <button id="btnAddDisc" runat="server" class="smallbtn" onclick="javascript:return fnCalTtlDisount();">
                                            <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_01 %></button>
                                        <button id="btnCancel" runat="server" class="smallbtn">
                                            <%=Resources.Billing_ClientDisplay.Billing_BillingPart_aspx_09 %></button>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                        <ajc:ModalPopupExtender ID="ModalPopupShow" runat="server" BackgroundCssClass="modalBackground"
                            DropShadow="false" PopupControlID="PanelGroup" Enabled="True" TargetControlID="btnDummy">
                        </ajc:ModalPopupExtender>
                        <input type="button" id="btnDummy" runat="server" style="display: none;" />
                    </div>
                </div>
            </div>
               <div id="dialog" style="display: none" >
              
              
   
</div>
        </td>
    </tr>
</table>
 <div id="dialog1" style="display: none" ></div>
 <div id="dialogdue" style="display: none" ></div>
<style type="text/css">
    .lnkOtp
    {
        font-size: larger;
        font-weight: bold;
        font-style: italic;
        text-decoration: none;
        color: #2c88b1;
        cursor: pointer;
    }
</style>

<script type="text/javascript" language="javascript">
    function chkPros() {
        var orgID = '<%= OrgID %>';
        CallBillItems(orgID);
    }
</script>

<script type="text/javascript">

    //    $('#dvMycard').hide();
    $('#dvPoints').hide();
    //    $('#dvExistingCard').hide();
    $('#DvRedeemOnetimePassword').hide();
    //    $('#billPart_trHealthCard').hide();
    //    $("#DvCard").show();

    //    $("#DvMobile").hide();
    //    
    function CheckMyCard() {
        ClearmycardDetails('Y');

        //            IsCheckMyCard();
        //            $('#dvMycard').hide();
        //            $('#trHealthCard').css("display", "none");
        //            $('#billPart_tdBillDetails').removeAttr("disabled");
        //            $('#dvExistingCard').hide();
        //            $('#billPart_txtDiscount').removeAttr("readonly");
        //            $("input#billPart_rbNewCard").attr('checked', false);
        //            $("input#billPart_chkRedeem").attr('checked', false);
        //            $("input#billPart_chkCredit").attr('checked', true);
        //            $("input#billPart_rbExistingCard").attr('checked', false);
        //            $('#dvExistingCard').hide();
        //            $('#dvPoints').hide();
        //      
        //            IsCheckMyCard();
        //            $('#trHealthCard').css("display", "");
        //            $('#dvMycard').show();
        //            $('#billPart_txtDiscount').attr('readonly', true);

        //            $('#billPart_tdBillDetails').attr('disabled', 'disabled');
        //            $('#dvExistingCard').show();
        //            $('#dvPoints').hide();
         
    }
    var Obj;
    function ClickCardType(obj) {
        /* Added By Venkatesh S */
        var vMobileNo = SListForAppMsg.Get('CommonControls_BillingPart_ascx_04') == null ? "Please enter the mobile number" : SListForAppMsg.Get('CommonControls_BillingPart_ascx_04');
        var vCardNo = SListForAppMsg.Get('CommonControls_BillingPart_ascx_05') == null ? "Please enter the card number" : SListForAppMsg.Get('CommonControls_BillingPart_ascx_05');
        
        if (obj == "NewCard") {
            //$("input#billPart_rbNewCard").click(function() {
            $('#dvExistingCard').hide();
            $('#dvPoints').hide();
            $("input#billPart_rbExistingCard").attr('checked', false);
            //});
        }
        else if (obj == "ExistsCard") {
            if (!$('#billPart_rbExistingCard').is(':checked')) {
                $('#dvExistingCard').hide();
                $('#dvPoints').hide();
                $("input#billPart_rbNewCard").attr('checked', false);
                $("input#billPart_chkRedeem").attr('checked', false);
                $("input#billPart_chkCredit").attr('checked', true);
            }
            else {
                //$("input#billPart_rbExistingCard").click(function() {
                $('#dvExistingCard').show();
                $('#dvPoints').hide();
                $("input#billPart_rbNewCard").attr('checked', false);
                $("input#billPart_chkRedeem").attr('checked', false);
                $("input#billPart_chkCredit").attr('checked', true);
            }
        }
        else if (obj == "Redeem") {
            // $("#billPart_chkRedeem").click(function() {
            // debugger;
            if (!$('#billPart_chkRedeem').is(':checked')) {

                SetNetValue('RedeemUncheck');
            }
            else {
                var MemberCardNo = $('#billPart_txtCardNo').val();
                var MobileNo = $('#billPart_txtMobileNo').val();
                if (MemberCardNo == "" && MobileNo == "") {
                    if ($('#billPart_txtMobileNo').is(':visible')) {
                        if (MobileNo == "") {
                            $("input#billPart_chkRedeem").attr('checked', false);
                            //alert("Please enter the mobile number");
                            ValidationWindow(vMobileNo, AlertType);
                        }
                    }
                    if ($('#billPart_txtCardNo').is(':visible')) {
                        if (MemberCardNo == "") {
                            $("input#billPart_chkRedeem").attr('checked', false);
                            //alert("Please enter the card number");
                            ValidationWindow(vCardNo, AlertType);
                        }
                    }
                }
                else {

                    // $("#billPart_txtMobileNo").mask("999-999-9999");
                    var RedeemPoints = $('#billPart_lblCreditPoints').text();
                    var RedeemAmount = $('#billPart_lblCreditValue').text();
                    if (RedeemPoints != "" && RedeemAmount != "") {
                        //Create Credit detail table
                        var cardNo = $('#billPart_txtCardNo').val();
                        var RedeemTestTotalAmount = 0;
                        var TotalcardAmt1 = 0;

                        $('#cardPoints tr').each(function(i, n) {
                            if (i == 0) {
                            }
                            else {
                                var $row = $(n);
                                var lblCardAmt = $row.find($('span[id$="lblCardAmt"]')).html();
                                if (typeof (lblCardAmt) === "undefined") {
                                }
                                else {
                                    TotalcardAmt1 = parseFloat(TotalcardAmt1) + parseFloat(lblCardAmt);
                                }
                                //  previousRedemData = TotalcardAmt;
                            }
                        });

                        var lstHealthCardItems = document.getElementById('billPart_hdnHealthCardItems').value;
                        arrayMainData = lstHealthCardItems.split('-');
                        var ItemLevelRedemableAmt = 0.00;
                        var ItemLevelRedeemMasterpercent = 0;
                        if (arrayMainData.length > 0) {
                            for (iMain = 0; iMain < arrayMainData.length - 1; iMain++) {
                                var maindata = arrayMainData[iMain];
                                var data = maindata.split('~');
                                var Itemfeelid = data[0];
                                var ItemFeeType = data[1];
                                var IsRedeem = data[4];
                                if (data[2].trim() != "")
                                    ItemAmount = data[2];

                                if (data[3].trim() != "") {
                                    ItemLevelRedeemMasterpercent = data[3];
                                }
                                else {
                                    ItemLevelRedeemMasterpercent = 0.00;
                                }
                                if (IsRedeem == "Y") {
                                    ItemLevelRedemableAmt = Number(parseFloat(ItemLevelRedemableAmt)) + Number(parseFloat((parseFloat(ItemAmount) * parseFloat(ItemLevelRedeemMasterpercent)) / 100).toFixed());
                                }
                            }
                        }
                        RedeemTestTotalAmount = ItemLevelRedemableAmt;
                        //  AddCardPoints(cardNo, RedeemPoints, RedeemTestTotalAmount);
                        var totalredemPoints = AddCardPoints(cardNo, RedeemPoints, RedeemTestTotalAmount);
                        $("#billPart_txtCardNo").val("");
                        $("#billPart_hdnTotalRedeemPoints").val(RedeemPoints);
                        $("#billPart_hdnTotalRedeemAmount").val(RedeemAmount);
                        $("#billPart_hdntotalredemPoints").val(totalredemPoints);

                        if (RedeemTestTotalAmount < totalredemPoints) {
                            totalredemPoints = RedeemTestTotalAmount;
                        }
                        ItemLevelCreditCal(RedeemPoints, RedeemAmount, totalredemPoints);

                    }
                    $("input#billPart_chkCredit").attr('checked', true);
                    $('#trOtp').css("display", "");

                }
            }
        }
        else if (obj == 'Card') {
            //$("#billPart_lblCardNumber").click(function() {
            $('#dvExistingCard').show();
            $("#DvCard").show();
            $("#DvMobile").hide();
            //});
        }
        else if (obj == 'Mobile') {
            $("#billPart_lblMobileNumber").click(function() {
                $('#dvExistingCard').show();
                $("#DvCard").hide();
                $("#DvMobile").show();
            });
        }

    }
    //   $("#billPart_txtMobileNo").mask("999-999-9999");
</script>

<script type="text/javascript">
    var hdnHasMyCard = $('#billPart_hdnHasMyCard').val();

    // $('#dvMycard').hide();
    // $('#dvPoints').hide();
    // $('#dvExistingCard').hide();
    //  $('#DvRedeemOnetimePassword').hide();
    // $('#billPart_trHealthCard').hide();
    //  $("#DvCard").show();
    //  $("#DvMobile").hide();
    //  $("input#billPart_chkMycard").attr('checked', false);
    if (hdnHasMyCard == "Y") {
        //        $('#billPart_chkMycard').click(function() {
        //             if (!$(this).is(':checked')) {
        //                IsCheckMyCard();
        //                $('#dvMycard').hide();
        //                $('#trHealthCard').css("display", "none");
        //                $('#billPart_tdBillDetails').removeAttr("disabled");
        //                $('#dvExistingCard').hide();

        //            }
        //            else {
        //                IsCheckMyCard();
        //                $('#trHealthCard').css("display", "");
        //                $('#dvMycard').show();
        //                $('#billPart_tdBillDetails').attr('disabled', 'disabled');

        //            }
        //        });

        //        $("input#billPart_rbExistingCard").click(function() {
        //            $('#dvExistingCard').show();
        //            $('#dvPoints').hide();
        //            $("input#billPart_rbNewCard").attr('checked', false);
        //            $("input#billPart_chkRedeem").attr('checked', false);
        //            $("input#billPart_chkCredit").attr('checked', true);

        //        });
        //        $("input#billPart_rbNewCard").click(function() {
        //            $('#dvExistingCard').hide();
        //            $('#dvPoints').hide();
        //            $("input#billPart_rbExistingCard").attr('checked', false);
        //        });
        //        $("input#billPart_chkCredit").click(function() {
        //            var MemberCardNo = $('#billPart_txtCardNo').val();
        //            if (MemberCardNo == "") {
        //                $("input#billPart_chkCredit").attr('checked', false);
        //                alert("Please enter the card number");
        //            } else {
        //                $("input#billPart_chkRedeem").attr('checked', false);
        //                $('#DvRedeemOnetimePassword').hide();
        //            }
        //        });
        //Added
        //        $("#billPart_chkRedeem").click(function() {
        //            // debugger;
        //            var MemberCardNo = $('#billPart_txtCardNo').val();
        //            var MobileCardNo = $('#billPart_txtMobileNo').val();
        //            if (MemberCardNo == "" || MobileCardNo=="") {
        //                $("input#billPart_chkRedeem").attr('checked', false);
        //                alert("Please enter the card number");
        //            }
        //            else {
        //                var RedeemPoints = $('#billPart_lblCreditPoints').text();
        //                var RedeemAmount = $('#billPart_lblCreditValue').text();
        //                if (RedeemPoints != "" && RedeemAmount != "") {
        //                    ItemLevelCreditCal(RedeemPoints, RedeemAmount);
        //                }
        //                $("input#billPart_chkCredit").attr('checked', true);
        //                $('#trOtp').css("display", "");
        //              
        //            }

        //        });
        //        $("#billPart_lblCardNumber").click(function() {
        //            $('#dvExistingCard').show();
        //            $("#DvCard").show();
        //            $("#DvMobile").hide();
        //        });
        //        $("#billPart_lblMobileNumber").click(function() {
        //            $('#dvExistingCard').show();
        //            $("#DvCard").hide();
        //            $("#DvMobile").show();
        //        });
    }
</script>
<script type="text/javascript">
    //var modalClassdiag = document.getElementById('mymodaldiag1');
    var arrModalDiag = ["mymodaldiag1", "mymodaldiag2"];
    var arrModalDiagClass = ["myModalclass1", "myModalclass2"];
    function openModalJQ(modalId, modalClassID) {
        var modaldiag = modalId;
        var modalClassdiag = modalClassID;
        $('#' + modalClassdiag).removeClass("modalDiag-content1");
        $('#' + modalClassdiag).addClass("modalDiag-content");
        $('#' + modaldiag).removeClass("hide").addClass("modalDiag show");
    }
    function closeModdalDialog(modalId, modalClassID) {
        //  if ($('#billPart_btnspecAdd').val() == 'Add' && $("#billPart_hdnSpecimenValues").val() != "") {
        var txt = $('[id$="billPart_hdnSpecimenValues"]').val();
        var flag = 0;
        if (txt != '') {

            var row = txt.split('~');
            $.each(row, function(id, column) {
                var cols = column.split(',');
                var obj = {};
                if (cols != '') {
                    if (cols[0] == SpecFeeID) {
                        flag = 1

                    }
                }
            });
        }
        else { flag = 0; }


      //  if (flag == 1) {
            var modaldiag = modalId;
            var modalClassdiag = modalClassID;
            $('#' + modalClassdiag).addClass("modalDiag-content1");
            btnspecsaveclear();
            setTimeout(function() {
                $('#' + modaldiag).removeClass("show").addClass("hide");
            }, 700);
        //} 
    }
    document.addEventListener('click', function(e) {
        //alert(e.target.id);
        for (i = 0; i < arrModalDiag.length; i++) {
            if (e.target.id == arrModalDiag[i]) {
                modalPopupHide(i);
            }
        }
    });
    $('body').keydown(function(evt) {
        if (evt.keyCode === 27) {
            for (i = 0; i < arrModalDiagClass.length; i++) {
                if ($('#' + arrModalDiagClass[i]).hasClass("modalDiag-content")) {
                    modalPopupHide(i);
                }
            }
        }
    });
    function modalPopupHide(i) {
        if ($('#billPart_btnspecAdd').val() != 'Update') {
            if ($("#billPart_hdnSpecimenValues").val() != "") {
                btnspecsaveclear();
                var temp = i;
                $('#' + arrModalDiagClass[i]).removeClass("modalDiag-content").addClass("modalDiag-content1");
                setTimeout(function() {
                    $('#' + arrModalDiag[i]).removeClass("show").addClass("hide");
                }, 700);
                //alert();
                sleep(1000);
            } 
        } 
    }
 function SetRadio(ctrl) {
        var rgroup = $(ctrl).closest('.radio-group');
        $(rgroup).find('input[type="radio"]').prop('checked', false);
        $(rgroup).attr('value', $(ctrl).find('input[type="radio"]').val());
        $(ctrl).find('input[type="radio"]').prop('checked', true);
    }

     function popupformedit() {

    //  var itemval=  $('#div7').prop('outerHTML');
         var attrid = $('#div7').attr('iconid');
         var flag = true;

         var obj = {};
         var jstrimg = "";
         $.each($('#div7').find('[key]'), function(id, val) {

             var key = $(val).closest('.form-group').find('label').attr('key');

             var IsRequired = $(val).closest('.form-group').find('label').attr('IsRequired');

             var ctrl = $(val).closest('.form-group').find('[control-type]');

             if ($(ctrl).attr('control-type') == 'header') {
                 key = $(val).closest('.form-group').find('[control-type="header"]').attr('key');
                 if (jstrimg == "")
                 { jstrimg ='"' +key + '":' + '{'+'"'; }
                 else {

                     jstrimg = jstrimg.substring(0, jstrimg.length - 2);
                     jstrimg = jstrimg + '}'+'*'+',';
                     jstrimg = jstrimg+ '"' + key + '":' + '{'; 
                     
                     //|{";
                 }
             }
             else if (key != null && key != 'undefined') {
                 var value = "";
                 if ($(ctrl).attr('control-type') == 'radio-group') {
                     value = $(ctrl).attr('value');

                     if (IsRequired == "Y" && (value == '-1' || value == '0' || value == '' || value == undefined)) {
                         alert('please fill all mandatory fields');
                         flag = false;
                         return false;
                     }
                    jstrimg = jstrimg + '"' + key + '":"' + value + '",';
                     //jstrimg = jstrimg + key + '":"' + value + '","';
                 }
                 else if ($(ctrl).attr('control-type') == 'NwithUnits') {

                     if (IsRequired == "Y" && ($(ctrl[0]).val() == '' || $(ctrl[0]).val() == '0' || $(ctrl[0]).val() == '-1')) {
                         alert('please fill all mandatory fields');
                         flag = false;
                         return false;
                     }
                     value =  $(ctrl[0]).val()+'_'+ $(ctrl[1]).val();
                     value1 = 'unit":"' + $(ctrl[1]).val() + '",' + '"value":' + $(ctrl[0]).val();
                     jstrimg = jstrimg + key + '":{"' + value1 + '},"';

                 }
                 else if ($(ctrl).attr('control-type') == 'select') {
                     value = $(ctrl).val();
                     if (IsRequired == "Y" && (value == '' || value == '0' || value == '')) {
                         alert('please fill all mandatory fields');
                         flag = false;
                         return false;
                     }
                     jstrimg = jstrimg + '"' + key + '":"' + value + '","';
                 }

                 else {
                     value = $(ctrl).val();
                     if (IsRequired == "Y" && value == '') {
                         alert('please fill all mandatory fields');
                         flag = false;
                         return false;
                     }
                     jstrimg = jstrimg + '"' + key + '":"' + value + '","';
                 }
                 if (key != null && key != '')
                     obj[key] = value;
             }
         });
         if (flag == true) {
             jstrimg = jstrimg.substring(0, jstrimg.length - 2);
             jstrimg = jstrimg +'"'+'}';
          var jsonStrin = JSON.stringify(obj);
          $('#' + attrid).attr('jsonData', jsonStrin);
          var icons = $('#' + attrid).closest('tbody').find('td.template');
          var templateString = "";
          var templateString1 = "";
          $.each(icons, function(id, val) {
          //templateString = templateString + $(val).find('input').attr('orderedItems') + '^' + $(val).find('input').attr('jsonData') + '|';
          templateString1 = templateString1 + $(val).find('input').attr('orderedItems') + '^' + jstrimg + '|';

          });

          $('#billPart_hdnTemplateValue').val(templateString1);

          $('#billPart_btnClose4').click();
      }
    }
    function TextBoxpressBrowserRefresh(e) {
        var keycode = (window.event) ? event.keyCode : e.keyCode;
        if (keycode == 13) {
            //alert("Doing browser refresh may cause loss or unstable data. Please be sure before continuing");
            event.preventDefault();
            //return false;
        }
    }
    $('.TxtEnterkeyPress').keypress(function(e) {
        TextBoxpressBrowserRefresh(e);
    });
</script>