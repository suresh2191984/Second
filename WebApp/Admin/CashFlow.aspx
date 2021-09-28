<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CashFlow.aspx.cs" Inherits="Admin_CashFlow"
    meta:resourcekey="PageResource2" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/ProcedureName.ascx" TagName="procedure" TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/ConsultingName.ascx" TagName="consulting" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/ReferDoctor.ascx" TagName="ReferDoctor" TagPrefix="uc8" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="PaymentTypeDetails"
    TagPrefix="uc9" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>
        <%=Resources.Admin_ClientDisplay.Admin_CashFlow_aspx_01%>
    </title>
    <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>
    <script src="../Scripts/Format_Currency/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="../Scripts/Format_Currency/jquery.formatCurrency-1.4.0.js" type="text/javascript"></script>
     <script src="../Scripts/Format_Currency/jquery.formatCurrency.all.js" type="text/javascript"></script>

</head>
<body onload="onComboFocus('dPurpose');" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnViewDetails">

    <script type="text/javascript">


        function SetOtherCurrValues() {
            var pnetAmt = document.getElementById('PaymentTypeDetails1_txtAmount').value;
            //            var ConValue = "OtherCurrencyDisplay1";
            var ConValue = SListForAppMsg.Get("Admin_CashFlow_aspx_02") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_02") : "OtherCurrencyDisplay1";
            SetPaybleOtherCurr(pnetAmt, ConValue, true);
        }


        function SetOtherCurrPayble(pCurrName, pCurrAmount, pNetAmount, ConValue, IsDisplay) {

           // var pTotalNetAmt = parseFloat(parseFloat(pNetAmount).toFixed(4) / parseFloat(pCurrAmount).toFixed(2)).toFixed(4);
            //                document.getElementById("billPart_" + ConValue + "_lblOtherCurrPaybleName").innerHTML = pCurrName;
            //                document.getElementById("billPart_" + ConValue + "_lblOtherCurrRecdName").innerHTML = pCurrName;
            //                document.getElementById("billPart_" + ConValue + "_lblOtherCurrPaybleAmount").innerHTML = parseFloat(pTotalNetAmt).toFixed(2);
            //                document.getElementById("billPart_" + ConValue + "_hdnOterCurrPayble").value = parseFloat(pTotalNetAmt).toFixed(4);
            //                ToTargetFormat($("#" + ConValue + "_lblOtherCurrPaybleAmount"));
            //                ToTargetFormat($("#" + ConValue + "_hdnOterCurrPayble"));
           // document.getElementById('PaymentTypeDetails1_txtAmount').value = pTotalNetAmt;
        }
        function isOtherCurrDisplay1(pType) {
            //                if (pType == "B") {
            //                    document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "table-row";
            //                    document.getElementById("billPart_" + "trOtherCurrency").style.display = "table-row";
            //                }
            //                if (pType == "N") {
            //                    document.getElementById("billPart_" + "OtherCurrencyDisplay1_tbAmountPayble").style.display = "none";
            //                    document.getElementById("billPart_" + "trOtherCurrency").style.display = "none";
            //                }


        }
    
    function ShowAlertMsg(key) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_CashFlow_aspx_03") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_03	") : "There is no Payment for Consultation on Selected Date";
            //var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                // alert(userMsg);
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
            else  {
                // alert('There is no Payment for Consultation on Selected Date');
                ValidationWindow(userMsg, AlrtWinHdr);
                return false;
            }
           return true;
        }


        function ChangeSecImage() {
        }

        function funcChangeType() {

            var selval = document.getElementById('<%= dPurpose.ClientID %>').value;
            var dpurpose = document.getElementById('<%= dPurpose.ClientID %>');
            document.getElementById('hdndPurpose').value = dpurpose.options[dpurpose.selectedIndex].value;
            if (selval == "0") {
                document.getElementById('<%= divConsulting.ClientID %>').style.display = 'none';
                document.getElementById('<%= divRefer.ClientID %>').style.display = 'none';
                document.getElementById('<%= divOthers.ClientID %>').style.display = 'none';
                document.getElementById('<%= divDetails.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSave.ClientID %>').style.display = 'none';
                document.getElementById('<%= divPayment.ClientID %>').style.display = 'none';
                document.getElementById('<%= divFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divPhySettlement.ClientID %>').style.display = 'none';
                document.getElementById('<%= Panel2.ClientID %>').style.display = 'none';
                document.getElementById('<%= lblMsg.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplierFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplier.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplier.ClientID %>').style.display = 'none';
                document.getElementById('<%= pnltempPreviousPymts.ClientID %>').style.display = 'none';
                document.getElementById('<%= trGrantTotal.ClientID %>').style.display = 'none';



            }
            else if (selval == "PHY") {
                document.getElementById('<%= divConsulting.ClientID %>').style.display = 'block';
                document.getElementById('<%= divRefer.ClientID %>').style.display = 'none';
                document.getElementById('<%= divOthers.ClientID %>').style.display = 'none';
                document.getElementById('<%= divDetails.ClientID %>').style.display = 'block';
                document.getElementById('<%= divSave.ClientID %>').style.display = 'block';
                document.getElementById('<%= divPayment.ClientID %>').style.display = 'block';
                document.getElementById('<%= divFTDate.ClientID %>').style.display = 'block';
                document.getElementById('<%= divPhySettlement.ClientID %>').style.display = 'block';
                document.getElementById('<%= Panel2.ClientID %>').style.display = 'block';
                document.getElementById('<%= lblMsg.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplierFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplier.ClientID %>').style.display = 'none';
                document.getElementById('<%= pnltempPreviousPymts.ClientID %>').style.display = 'block';
                document.getElementById('<%= trGrantTotal.ClientID %>').style.display = 'none';

            }
            else if (selval == 'OTH') {
                document.getElementById('<%= divConsulting.ClientID %>').style.display = 'none';
                document.getElementById('<%= divRefer.ClientID %>').style.display = 'none';
                document.getElementById('<%= divOthers.ClientID %>').style.display = 'block';
                document.getElementById('<%= divDetails.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSave.ClientID %>').style.display = 'block';
                document.getElementById('<%= divPayment.ClientID %>').style.display = 'block';
                document.getElementById('<%= divFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divPhySettlement.ClientID %>').style.display = 'none';
                document.getElementById('<%= Panel2.ClientID %>').style.display = 'none';
                document.getElementById('<%= lblMsg.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplierFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplier.ClientID %>').style.display = 'none';
                document.getElementById('<%= pnltempPreviousPymts.ClientID %>').style.display = 'none';
                document.getElementById('<%= trGrantTotal.ClientID %>').style.display = 'none';


            }
            else if (selval == "SUP") {
                document.getElementById('<%= divConsulting.ClientID %>').style.display = 'none';
                document.getElementById('<%= divRefer.ClientID %>').style.display = 'none';
                document.getElementById('<%= divOthers.ClientID %>').style.display = 'none';
                document.getElementById('<%= divDetails.ClientID %>').style.display = 'block';
                document.getElementById('<%= divSave.ClientID %>').style.display = 'block';
                document.getElementById('<%= divPayment.ClientID %>').style.display = 'block';
                document.getElementById('<%= divFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplierFTDate.ClientID %>').style.display = 'block';
                document.getElementById('<%= divPhySettlement.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplier.ClientID %>').style.display = 'block';
                document.getElementById('<%= Panel2.ClientID %>').style.display = 'none';
                document.getElementById('<%= lblMsg.ClientID %>').style.display = 'none';
                document.getElementById('<%= pnltempPreviousPymts.ClientID %>').style.display = 'none';
                document.getElementById('<%= trGrantTotal.ClientID %>').style.display = 'block';
            }
            else {
                document.getElementById('<%= divConsulting.ClientID %>').style.display = 'none';
                document.getElementById('<%= divRefer.ClientID %>').style.display = 'none';
                document.getElementById('<%= divOthers.ClientID %>').style.display = 'none';
                document.getElementById('<%= divDetails.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSave.ClientID %>').style.display = 'block';
                document.getElementById('<%= divPayment.ClientID %>').style.display = 'block';
                document.getElementById('<%= divFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divPhySettlement.ClientID %>').style.display = 'none';
                document.getElementById('<%= Panel2.ClientID %>').style.display = 'none';
                document.getElementById('<%= lblMsg.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplierFTDate.ClientID %>').style.display = 'none';
                document.getElementById('<%= divSupplier.ClientID %>').style.display = 'none';
                document.getElementById('<%= pnltempPreviousPymts.ClientID %>').style.display = 'none';
                document.getElementById('<%= trGrantTotal.ClientID %>').style.display = 'none';

            }
        }

        function validateToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg1 = SListForAppMsg.Get("Admin_CashFlow_aspx_04") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_04	") : "Select doctor name";
            var userMsg2 = SListForAppMsg.Get("Admin_CashFlow_aspx_05") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_05	") : "Provide / select value for To date";
             
            var selval = document.getElementById('<%= dPurpose.ClientID %>').value;
            if (selval == "PHY") {
                var sDocName = document.getElementById('<%= ddlDrName.ClientID %>').value;
                if (sDocName == "0") {
                //var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_1");
                if (userMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg1, Information);
                    return false;
                }
                else {
                    // alert('Select doctor name');
                    ValidationWindow(UserMsg1, Information);
                    return false;
                }
                    return false;
                }
            }

            if (document.getElementById('txtToDate').value == '') {
                //var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_4");
                if (userMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UserMsg2, Information);
                 return false;
             }
             else {
                 //alert('Provide / select value for To date');
                 ValidationWindow(UserMsg2, Information);
                 return false;
             }
                document.getElementById('ImgToDate').focus();
                return false;
            }
        }

        function validateDetails() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg1 = SListForAppMsg.Get("Admin_CashFlow_aspx_04") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_04	") : "Select doctor name";
            var userMsg2 = SListForAppMsg.Get("Admin_CashFlow_aspx_05") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_05	") : "Provide / select value for To date";
            var userMsg3 = SListForAppMsg.Get("Admin_CashFlow_aspx_06") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_06	") : "Click on view details. The total payable amount will be of zero or lessthan zero";
            var userMsg4 = SListForAppMsg.Get("Admin_CashFlow_aspx_07") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_07	") : "Provide Description";
            var userMsg5 = SListForAppMsg.Get("Admin_CashFlow_aspx_08") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_08	") : "Provide remarks";
            var selval = document.getElementById('<%= dPurpose.ClientID %>').value;
            if (selval == "PHY") {
                var sDocName = document.getElementById('<%= ddlDrName.ClientID %>').value;
                if (sDocName == "0") {
                 //var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_1");
                 if (userMsg1 != null) {
                     //alert(userMsg);

                     ValidationWindow(UserMsg1, Information);
                     return false;
                 }
                 else {
                     //alert('Select doctor name');

                     ValidationWindow(UserMsg1, Information);
                     return false;
                 }
                    return false;
                }
            }
            if (document.getElementById('txtToDate').value == '') {
             //var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_4");
             if (userMsg2 != null) {
                 //alert(userMsg);
                 ValidationWindow(UserMsg2, Information);
                 return false;
             }
             else {
                 // alert('Provide / select value for To date');
                 ValidationWindow(UserMsg2, Information);
                 return false;
             }
                document.getElementById('ImgToDate').focus();
                return false;
            }

            if (document.getElementById('txtPayableAmount').value <= 0) {
            // var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_5");
             if (userMsg3 != null) {
                 //alert(userMsg);
                 ValidationWindow(UserMsg3, Information);
                 return false;
             }
             else {
                 //alert('Click on view details. The total payable amount will be of zero or lessthan zero');
                 ValidationWindow(UserMsg3, Information);
                 return false;
             }
                //document.getElementById('btnViewDetails').focus();
                return false;
            }
            if (document.getElementById('dPurpose').options[document.getElementById('dPurpose').selectedIndex].innerHTML == 'Others') {
                if (document.getElementById('txtOthers').value == '') {
                 //var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_6");
                    if (userMsg4 != null) {
                        //alert(userMsg);
                        ValidationWindow(UserMsg4, Information);
                     return false;
                 }
                 else {
                     //alert('Provide description');
                     ValidationWindow(UserMsg4, Information);
                     return false;
                 }
                    document.getElementById('txtOthers').focus();
                    return false;
                }
                if (document.getElementById('txtRemarks').value == '') {
                 //var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_7");
                 if (userMsg5 != null) {
                     //alert(userMsg);
                     ValidationWindow(UserMsg5, Information);
                     return false;
                 }
                 else {
                     //alert('Provide remarks');
                     ValidationWindow(UserMsg5, Information);
                     return false;
                 }
                    document.getElementById('txtRemarks').focus();
                    return false;
                }
            }

            AvoidDoubleEntry();
        }

        function AvoidDoubleEntry() {
            document.getElementById('bsave').style.display = 'none';
        }

        function validatesupToDate() {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_CashFlow_aspx_09") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_09	") : "Select the suppliers";
            if (document.getElementById('ddlSuppliers').value == '0') {
            // var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_8");
             if (userMsg != null) {
                 //alert(userMsg);
                 ValidationWindow(UserMsg, Information);
                 return false;
             }
             else {
                 //alert('Select the suppliers');
                 ValidationWindow(UserMsg, Information);
                 return false;
             }
                document.getElementById('ddlSuppliers').focus();
                return false;
            }

        }

        function ModifyAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_CashFlow_aspx_10") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_10	") : "Amount cannot be zero";
	
            if (TotalAmount > 0) {
                var oldAmount = document.getElementById('<%= txtPayableAmount.ClientID %>').value;
                oldAmount = Number(oldAmount) + Number(TotalAmount);
                ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
                document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(Number(ServiceCharge), 2);
                document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(Number(ServiceCharge), 2);
                document.getElementById('<%= txtPayableAmount.ClientID %>').value = format_number(oldAmount, 2);
                document.getElementById('<%= hdnPayable.ClientID %>').value = format_number(oldAmount, 2);
                return true;
            }
            else {
            // var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_9");
             if (userMsg != null) {
                 //alert(userMsg);
                 ValidationWindow(userMsg, AlrtWinHdr);
                 return false;
             }
             else {
                 // alert('Amount cannot be zero');
                 ValidationWindow(userMsg, AlrtWinHdr);
                 return false;
             }
                return false;
            }
        }

        function DeleteAmountValue(PaymentAmount, TotalAmount, ServiceCharge) {
            var oldAmount = document.getElementById('<%= txtPayableAmount.ClientID %>').value;
            oldAmount = Number(oldAmount) - Number(TotalAmount);
            document.getElementById('<%= txtPayableAmount.ClientID %>').value = format_number(oldAmount, 2);
            document.getElementById('<%= hdnPayable.ClientID %>').value = format_number(oldAmount, 2);

            ServiceCharge = (Number(ServiceCharge) * Number(PaymentAmount) / 100);
            var tempService = document.getElementById('<%= txtServiceCharge.ClientID %>').value;
            document.getElementById('<%= txtServiceCharge.ClientID %>').value = format_number(Number(tempService) - Number(ServiceCharge), 2);
            document.getElementById('<%= hdnServiceCharge.ClientID %>').value = format_number(Number(tempService) - Number(ServiceCharge), 2);

        }
        function closeData() { }

        var ddlText, ddlValue, ddl, lblMesg;
        function CacheItems() {
            ddlText = new Array();
            ddlValue = new Array();
            ddl = document.getElementById("<%=ddlDrName.ClientID %>");
            for (var i = 0; i < ddl.options.length; i++) {
                ddlText[ddlText.length] = ddl.options[i].text;
                ddlValue[ddlValue.length] = ddl.options[i].value;
            }
        }

        window.onload = CacheItems;


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
//        function AddPhysician() {

//            var ddlPhy = document.getElementById("<%= ddlDrName.ClientID %>");
//            var ddlPhyLength = ddlPhy.options.length;
//            for (var i = 0; i < ddlPhyLength; i++) {
//                if (ddlPhy.options[i].selected) {


//                    if (ddlPhy.options[i].text != '--Select--') {

//                        document.getElementById('<%= txtNew.ClientID %>').value = ddlPhy.options[i].text;

//                    }

//                }

//            }
        //        }
        function SetPhysicianID(source, eventArgs) {
            if (eventArgs != undefined) {
                document.getElementById('<%=hdnPhysicianID.ClientID %>').value = eventArgs.get_value();
            }
            else if (document.getElementById('hdnPhysicianID') != null) {
                if (document.getElementById('<%=hdnPhysicianID.ClientID %>').value == '') {
                    alert('Please select from the list');
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                    document.getElementById('txtNew').value = '';
                }
            }
        }
        function SelectedOverPhy(source, eventArgs) {
            $find('AutoCompleteExtenderRefPhy')._onMethodComplete = function(result, context) {
                $find('AutoCompleteExtenderRefPhy')._update(context, result, /* cacheResults */false);
                if (result == "") {

                    alert('Please select from the list');
                    document.getElementById('txtNew').value = '';
                    document.getElementById('<%=hdnPhysicianID.ClientID %>').value = '0';
                }
            };
        }

        
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <%--<ul id="ulErrorDiv" runat="server" style="display: none">
                            <li>
                                <uc6:ErrorDisplay ID="divError" runat="server" />
                            </li>
                        </ul>--%>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <Triggers>
                                <asp:PostBackTrigger ControlID="bsave" />
                            </Triggers>
                            <ContentTemplate>
                                <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server">
                                    <ProgressTemplate>
                                        <div class="a-center">
                                            <asp:Image ID="Image2" ImageUrl="~/Images/working.gif" runat="server" meta:resourcekey="Image2Resource2" />
                                            <asp:Label ID="Rs_PleaseWait" Text="Please Wait..." runat="server" meta:resourcekey="Rs_PleaseWaitResource1"></asp:Label>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                
                                
                                
                                
                                <table class="w-100p searchPanel">
                                    <tr>
                                        <td class="h-32">
                                            <div class="dataheader2">
                                                <table class="w-100p bg-row">
                                                    <tr>
                                                        <td width="200px;">
                                                            <asp:Label ID="Rs_SelectPayableType" Text="Select Payable Type:" runat="server" meta:resourcekey="Rs_SelectPayableTypeResource2"></asp:Label>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:DropDownList ID="dPurpose" runat="server" CssClass ="ddl" onchange="javascript:funcChangeType();" 
                                                TabIndex="1" >
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hdndPurpose" runat="server" />
                                                           <span id="divRefer" runat="server" style="display: none">
                                                                <asp:DropDownList ID="ddlReferDoctor" CssClass="ddl" runat="server" meta:resourcekey="ddlReferDoctorResource2">
                                                                </asp:DropDownList>
                                                            </span><span id="divConsulting" runat="server" style="display: none">
                                                                <%--<asp:TextBox ID="txtNew" runat="server" ToolTip="Enter Text Here" CssClass="Txtboxsmall" onkeyup="FilterItems(this.value)"
                                                                    onblur="AddPhysician()" meta:resourcekey="txtNewResource2" />--%>
<%--                                                                    <td id="tdRefDrPart" runat="server">
                                                                  <%--  <asp:Label ID="lblRefby" rusnat="server" AccessKey="D" AssociatedControlID="txtInternalExternalPhysician"
                                                                        Text="Ref Dr."></asp:Label>--%>
                                                                       <asp:TextBox ID="txtNew" runat="server" CssClass="AutoCompletesearchBox"></asp:TextBox>
                                                                      <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                                                        CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionSetCount="10" EnableCaching="false" ServiceMethod="GetRateCardForBilling" OnClientItemSelected="SetPhysicianID"  ServicePath="~/OPIPBilling.asmx"
                                                                        FirstRowSelected="true" MinimumPrefixLength="2"
                                                                       TargetControlID="txtNew">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                               
                                                                
                                                                <td>
                                                                    
                                                                 
                                                <asp:DropDownList runat="server" ID="ddlDrName" TabIndex="1" CssClass="ddl" >
                                                                </asp:DropDownList>
                                                                <ajc:TextBoxWatermarkExtender ID="TBWE2" runat="server" TargetControlID="txtNew"
                                                                    WatermarkText="Type Physician Name" Enabled="True" />
                                                            </span><span id="divSupplier" runat="server" style="display: none">
                                                <asp:DropDownList runat="server" ID="ddlSuppliers" TabIndex="1" CssClass="ddl" >
                                                                </asp:DropDownList>
                                                            </span><span id="divOthers" runat="server" style="display: none">
                                                                <asp:TextBox ID="txtOthers" runat="server" CssClass="Txtboxsmall" meta:resourcekey="txtOthersResource2"></asp:TextBox>
                                                            </span>
                                                        </td>
                                                    </tr>
                                                    <tr class="a-center">
                                                        <td colspan="2" class="a-center">
                                                            <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource2"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divFTDate" class="dataheader2" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_FromDate" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDateResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                            <asp:TextBox runat="server" ID="txtFromDate" MaxLength="10" Width="100px" size="25"
                                                CssClass="Txtboxsmall " Enabled="False" meta:resourcekey="txtFromDateResource2"></asp:TextBox>
                                                            &nbsp;<asp:Image runat="server" ID="ImgBntCalc" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="ImgBntCalcResource2" />
                                                        </td>
                                                        <ajc:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgBntCalc"
                                                            TargetControlID="txtFromDate" Enabled="True" />
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate" Text="To Date:" runat="server" meta:resourcekey="Rs_ToDateResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                            <asp:TextBox runat="server" ID="txtToDate" MaxLength="10" Width="100px" Enabled="False"
                                                CssClass="Txtboxsmall " meta:resourcekey="txtToDateResource2"></asp:TextBox>
                                                            &nbsp;<asp:Image runat="server" ID="ImgToDate" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                Width="16px" Height="16px" AlternateText="Pick to date" meta:resourcekey="ImgToDateResource2" />
                                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd/MM/yyyy" PopupButtonID="ImgToDate"
                                                                TargetControlID="txtToDate" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnViewDetails" runat="server" CssClass="btn" TabIndex="2" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validateToDate();"
                                                                Text="View Details" OnClick="btnViewDetails_Click" meta:resourcekey="btnViewDetailsResource2" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divSupplierFTDate" class="dataheader2" runat="server">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_InvoiceNo" Text="Invoice No :" runat="server" meta:resourcekey="Rs_InvoiceNoResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                            <asp:TextBox runat="server" ID="txtInvoiceNo" MaxLength="10" Width="100px" size="25"
                                                CssClass="Txtboxsmall " meta:resourcekey="txtInvoiceNoResource2"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp; &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_PONo" Text="PO No :" runat="server" meta:resourcekey="Rs_PONoResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                            <asp:TextBox runat="server" ID="txtPOno" MaxLength="10" Width="100px" CssClass="Txtboxsmall "
                                                meta:resourcekey="txtPOnoResource2"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp; &nbsp;
                                                        </td>
                                                        <td>
                                                            &nbsp; &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_FromDate1" Text="From Date :" runat="server" meta:resourcekey="Rs_FromDate1Resource2"></asp:Label>
                                                        </td>
                                                        <td>
                                            <asp:TextBox runat="server" ID="txtSupFTD" MaxLength="10" Width="100px" size="25"
                                                CssClass="Txtboxsmall" Enabled="False" meta:resourcekey="txtSupFTDResource2"></asp:TextBox>
                                                            &nbsp;<asp:Image runat="server" ID="imgSupFTD" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                Width="16px" Height="16px" border="0" alt="Pick from date" meta:resourcekey="imgSupFTDResource2" />
                                                            <ajc:CalendarExtender ID="CalendarExtender3" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgSupFTD"
                                                                TargetControlID="txtSupFTD" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp; &nbsp;
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_ToDate1" Text="To Date :" runat="server" meta:resourcekey="Rs_ToDate1Resource2"></asp:Label>
                                                        </td>
                                                        <td>
                                            <asp:TextBox runat="server" ID="txtSupTFD" MaxLength="10" Width="100px" Enabled="False"
                                                CssClass="Txtboxsmall " meta:resourcekey="txtSupTFDResource2"></asp:TextBox>
                                                            &nbsp;<asp:Image runat="server" ID="imgSupTFD" ImageUrl="~/Images/Calendar_scheduleHS.png"
                                                                Width="16px" Height="16px" AlternateText="Pick to date" meta:resourcekey="imgSupTFDResource2" />
                                                            <ajc:CalendarExtender ID="CalendarExtender4" runat="server" Format="dd/MM/yyyy" PopupButtonID="imgSupTFD"
                                                                TargetControlID="txtSupTFD" Enabled="True" />
                                                        </td>
                                                        <td>
                                                            &nbsp;&nbsp; &nbsp;
                                                        </td>
                                                        <td>
                                                            &nbsp; &nbsp;
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <asp:Button ID="btnSupSearch" runat="server" CssClass="btn" TabIndex="2" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClientClick="javascript:return validatesupToDate();"
                                                                Text="Search" OnClick="btnSupSearch_Click" meta:resourcekey="btnSupSearchResource2" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6" align="center">
                                                            <asp:GridView ID="grdResult" EmptyDataText="No Matching Records Found!" Width="100%"
                                                                runat="server" CellPadding="2" AutoGenerateColumns="False" ForeColor="#333333"
                                                                CssClass="mytable1" OnRowDataBound="grdResult_RowDataBound" meta:resourcekey="grdResultResource2">
                                                                <HeaderStyle CssClass="dataheader1" />
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource3">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkSelect" runat="server" meta:resourcekey="chkSelectResource2" />
                                                                            <asp:HiddenField ID="hdnStockReceivedNo" runat="server" Value='<%# Eval("StockReceivedNo") %>' />
                                                                            <asp:HiddenField ID="hdnStockReceivedID" runat="server" Value='<%# Eval("StockReceivedID") %>' />
                                                                            <asp:HiddenField ID="hdnTotalAmt" runat="server" Value='<%# Eval("Comments") %>' />
                                                                            <asp:HiddenField ID="hdnInvoiceNo" runat="server" Value='<%# Eval("InvoiceNo") %>' />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Left" />
                                                                        <ItemStyle Width="2%" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="PurchaseOrderNo" HeaderText="PO No" meta:resourcekey="BoundFieldResource20" />
                                                                    <asp:BoundField DataField="InvoiceNo" HeaderText="Invoice No" meta:resourcekey="BoundFieldResource21" />
                                                                    <asp:BoundField DataField="StockReceivedDate" HeaderText="Received Date" meta:resourcekey="BoundFieldResource22" />
                                                                    <asp:BoundField DataField="CSTAmount" HeaderText="Debit Amount" meta:resourcekey="BoundFieldResource23" />
                                                                    <asp:BoundField DataField="Comments" HeaderText="Total Amount" meta:resourcekey="BoundFieldResource24" />
                                                                    <asp:TemplateField HeaderText="Payable Amount" meta:resourcekey="TemplateFieldResource4">
                                                                        <ItemTemplate>
                                                                            <asp:TextBox ID="txtSupAmount" MaxLength="15"  onkeypress="return ValidateOnlyNumeric(this);" 
                                                                                Text='<%# Eval("GrandTotal") %>' runat="server" meta:resourcekey="txtSupAmountResource2"></asp:TextBox>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                            </asp:GridView>
                                                            <asp:HiddenField ID="hdnValues" runat="server" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                            <asp:Panel ID="Panel2" runat="server" CssClass="collapsePanelHeader h-30" meta:resourcekey="Panel2Resource2">
                                                <div class="pointer v-middle">
                                                    <div style="float: left; margin-left: 20px;">
                                                        <asp:Label ID="Label1" runat="server" meta:resourcekey="Label1Resource2" Text="(Click to View Consultation & Physician Amount Details...)"></asp:Label>
                                                        &nbsp;<asp:ImageButton ID="Image1" OnClientClick="ChangeSecImage();" runat="server"
                                                            ImageUrl="../Images/collapse.jpg" AlternateText="(Click to View Details...)"
                                                            meta:resourcekey="Image1Resource2" />
                                                    </div>
                                                    <div class="v-middle" style="float: right; vertical-align: middle;">
                                                    </div>
                                                </div>
                                            </asp:Panel>
                                            <asp:Panel ID="Panel1" runat="server" CssClass="collapsePanel" meta:resourcekey="Panel1Resource2">
                                                <div id="divDetails" runat="server" class="dataheader2">
                                                    <table border="0" id="mytable1" class="w-80p bg-row">
                                                        <tr>
                                                            <td colspan="7">
                                                                <asp:Panel ID="pnltempAdvancePayments" GroupingText="Consultation Details on Selected Dates"
                                                                    runat="server" CssClass="defaultfontcolor w-100p" meta:resourcekey="pnltempAdvancePaymentsResource2">
                                                                    <br />
                                                                    <table class="w-100p">
                                                                        <tr>
                                                                            <td class="colorforcontent w-100p h-23 a-left">
                                                                                <div id="ACX2plusAdvPmt" style="display: block;">
                                                                                    &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                        style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',1);">
                                                                                        &nbsp;<asp:Label ID="Rs_ConsultationDetails" Text="Consultation Details" runat="server"
                                                                                            meta:resourcekey="Rs_ConsultationDetailsResource2"></asp:Label></span>
                                                                                </div>
                                                                                <div id="ACX2minusAdvPmt" style="display: none;">
                                                                                    &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                        style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);" />
                                                                                    <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2plusAdvPmt','ACX2minusAdvPmt','ACX2responsesAdvPmt',0);">
                                                                                        &nbsp;<asp:Label ID="Rs_ConsultationDetails1" Text="Consultation Details" runat="server"
                                                                                            meta:resourcekey="Rs_ConsultationDetails1Resource2"></asp:Label>
                                                                                </div>
                                                                            </td>
                                                                            <td class="w-75p h-23 a-left">
                                                                                &nbsp;
                                                                            </td>
                                                                        </tr>
                                                                        <tr class="tablerow" id="ACX2responsesAdvPmt" style="display: none;">
                                                                            <td colspan="2">
                                                                                <br />
                                                                                <div class="filterdatahe">
                                                                                    <asp:GridView ID="gvConsultation" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                                                                        ForeColor="#333333" CssClass="mytable1 gridView w-100p" OnRowDataBound="gvConsultation_RowDataBound"
                                                                                        meta:resourcekey="gvConsultationResource2">
                                                                                        <RowStyle ForeColor="#000066" />
                                                                                        <Columns>
                                                                            <asp:BoundField DataField="BillingDetailsID" HeaderText="ID" meta:resourceKey="BoundFieldResource25">
                                                                                <HeaderStyle Font-Bold="False" />
                                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="PhysicianName" HeaderText="Patient Number" meta:resourceKey="BoundFieldResource1">
                                                                                                <HeaderStyle Font-Bold="False" />
                                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="PatientName" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource26">
                                                                                                <HeaderStyle Font-Bold="False" />
                                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="VisitDate" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                                HeaderText="Date" meta:resourceKey="BoundFieldResource27">
                                                                                                <HeaderStyle Font-Bold="False" />
                                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" meta:resourceKey="BoundFieldResource28">
                                                                                <HeaderStyle Font-Bold="False" />
                                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="VisitType" HeaderText="Patient Type" meta:resourceKey="BoundFieldResource29">
                                                                                <HeaderStyle Font-Bold="False" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="Amount" HeaderText="Amount" meta:resourceKey="BoundFieldResource30">
                                                                                                <HeaderStyle Font-Bold="False" />
                                                                                            </asp:BoundField>
                                                                                        </Columns>
                                                                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                        <HeaderStyle CssClass="grdcolor" Font-Bold="False" />
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                    <br />
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="style1">
                                                                <asp:Label ID="Rs_TotalAmount" Text="Total Amount :" runat="server" meta:resourcekey="Rs_TotalAmountResource2"></asp:Label>
                                                            </td>
                                                            <td class="style1">
                                                                <asp:TextBox ID="txtTotalAmount" runat="server" MaxLength="25" size="25" ReadOnly="True"
                                                    Style="text-align: right;" Width="77px" meta:resourcekey="txtTotalAmountResource2"
                                                    CssClass="Txtboxsmall " Text="0"></asp:TextBox>
                                                            </td>
                                                            <td class="style1">
                                                                <asp:Label ID="Rs_PreviousDue" Text="Previous Due :" runat="server" meta:resourcekey="Rs_PreviousDueResource2"></asp:Label>
                                                            </td>
                                                            <td class="style1">
                                                <asp:TextBox ID="txtPreviousDue" runat="server" MaxLength="25" ReadOnly="True" Style="text-align: right;"
                                                    CssClass="Txtboxsmall " size="25" Width="77px" meta:resourcekey="txtPreviousDueResource2"
                                                    Text="0"></asp:TextBox>
                                                            </td>
                                                            <td class="style1">
                                                                <asp:Label ID="Rs_PreviousSurplusPayments" Text="Previous Surplus Payments :" runat="server"
                                                                    meta:resourcekey="Rs_PreviousSurplusPaymentsResource2"></asp:Label>
                                                            </td>
                                                            <td class="style1">
                                                <asp:TextBox ID="txtPreviousSurplus" runat="server" MaxLength="25" ReadOnly="True"
                                                    CssClass="Txtboxsmall " Style="text-align: right;" size="25" Width="77px" meta:resourcekey="txtPreviousSurplusResource2"
                                                    Text="0"></asp:TextBox>
                                                            </td>
                                                            <td class="style1">
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="7">
                                                                <table class="v-top" width="800px">
                                                                    <tr class="v-top">
                                                                        <td class="v-top w-50p">
                                                                            <asp:Panel ID="pnlIPPymts" GroupingText="IP % Details for Hospital" runat="server"
                                                                                CssClass="defaultfontcolor w-98p" meta:resourcekey="pnlIPPymtsResource2">
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td class="colorforcontent w-100p h-23 a-left">
                                                                                            <div id="ACX2IPPmt" style="display: block;">
                                                                                                &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                                    style="cursor: pointer" onclick="showResponses('ACX2IPPmt','ACX2minusIPPmt','ACX2responsesIPPmt',2);" />
                                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2IPPmt','ACX2minusIPPmt','ACX2responsesIPPmt',2);">
                                                                                                    &nbsp;<asp:Label ID="Rs_IP" Text="IP" runat="server" meta:resourcekey="Rs_IPResource2"></asp:Label></span>
                                                                                            </div>
                                                                                            <div id="ACX2minusIPPmt" style="display: none;">
                                                                                                &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                                    style="cursor: pointer" onclick="showResponses('ACX2IPPmt','ACX2minusIPPmt','ACX2responsesIPPmt',0);" />
                                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2IPPmt','ACX2minusIPPmt','ACX2responsesIPPmt',0);">
                                                                                                    &nbsp;<asp:Label ID="Rs_IP1" Text="IP" runat="server" meta:resourcekey="Rs_IP1Resource2"></asp:Label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td class="w-w-75p h-23 a-left">
                                                                                            &nbsp;
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr class="tablerow" id="ACX2responsesIPPmt" style="display: none;">
                                                                                        <td colspan="2">
                                                                                            <div class="filterdatahe">
                                                                                                <table class="BlanktableBorder w-100p">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_NumberofConsultations2" Text="Number of Consultations" runat="server"
                                                                                                                meta:resourcekey="Rs_NumberofConsultations2Resource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtNoOfIPs" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtNoOfIPsResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_TotalAmount1" Text="Total Amount" runat="server" meta:resourcekey="Rs_TotalAmount1Resource2"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtIPAmount" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtIPAmountResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_AmounttoOrganizationat1" Text="Amount to Organization at" runat="server"
                                                                                                                meta:resourcekey="Rs_AmounttoOrganizationat1Resource2"></asp:Label>
                                                                                                            <asp:Label ID="lblIPPercent" runat="server" Text="10.3" meta:resourcekey="lblIPPercentResource2"></asp:Label>
                                                                                                            &nbsp;%
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtIPAmountToOrg" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtIPAmountToOrgResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_Taxat1" Text="Tax at" runat="server" meta:resourcekey="Rs_Taxat1Resource2"></asp:Label>
                                                                                                            <asp:Label ID="lblIPTax" runat="server" ReadOnly="true" Text="10.3" meta:resourcekey="lblIPTaxResource2"></asp:Label>
                                                                                                            %
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtIPTax" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtIPTaxResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_TotalPayabletoPhysician1" Text="Total Payable to Physician" runat="server"
                                                                                                                meta:resourcekey="Rs_TotalPayabletoPhysician1Resource2"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtIPPayable" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtIPPayableResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </td>
                                                                        <td class="v-top w-50p">
                                                                            <asp:Panel ID="pnlOPPymts" GroupingText="OP % Details for Hospital" runat="server"
                                                                                CssClass="defaultfontcolor w-98p" meta:resourcekey="pnlOPPymtsResource2">
                                                                                <table class="w-100p">
                                                                                    <tr class="colorforcontent">
                                                                                        <td class="w-100p h-23 a-left">
                                                                                            <div id="ACX2OPPmt" style="display: block;">
                                                                                                &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                                    style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',2);" />
                                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',2);">
                                                                                                    &nbsp;<asp:Label ID="Rs_OP" Text="OP" runat="server" meta:resourcekey="Rs_OPResource2"></asp:Label></span>
                                                                                            </div>
                                                                                            <div id="ACX2minusOPPmt" style="display: none;">
                                                                                                &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                                    style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                                                                <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                                                                    &nbsp;<asp:Label ID="Rs_OP1" Text="OP" runat="server" meta:resourcekey="Rs_OP1Resource2"></asp:Label>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td class="w-75p h-23 a-left">
                                                                                            &nbsp;
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr class="tablerow" id="ACX2responsesOPPmt" style="display: none;">
                                                                                        <td colspan="2">
                                                                                            <div class="filterdatahe">
                                                                                                <table class="BlanktableBorder">
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_NumberofConsultations1" Text="Number of Consultations" runat="server"
                                                                                                                meta:resourcekey="Rs_NumberofConsultations1Resource2"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtNoOfOPs" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtNoOfOPsResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_TotalAmount2" Text="Total Amount" runat="server" meta:resourcekey="Rs_TotalAmount2Resource2"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtOPAmount" ReadOnly="True" Width="75px" Style="text-align: right;" CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtOPAmountResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_AmounttoOrganizationat" Text="Amount to Organization at" runat="server"
                                                                                                                meta:resourcekey="Rs_AmounttoOrganizationatResource2"></asp:Label>
                                                                                                            <asp:Label ID="lblOPPercent" runat="server" Text="10.3" meta:resourcekey="lblOPPercentResource2"></asp:Label>
                                                                                                            &nbsp;%
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtOPAmountToOrg" ReadOnly="True" Width="75px" Style="text-align: right;"  CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtOPAmountToOrgResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_Taxat" Text="Tax at" runat="server" meta:resourcekey="Rs_TaxatResource2"></asp:Label>
                                                                                                            <asp:Label ID="lblOPTax" runat="server" Text="10.3" meta:resourcekey="lblOPTaxResource2"></asp:Label>
                                                                                                            &nbsp;%
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtOPTax" ReadOnly="True" Width="75px" Style="text-align: right;"  CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtOPTaxResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                            <asp:Label ID="Rs_TotalPayabletoPhysician" Text="Total Payable to Physician" runat="server"
                                                                                                                meta:resourcekey="Rs_TotalPayabletoPhysicianResource2"></asp:Label>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <asp:TextBox ID="txtOPPayable" ReadOnly="True" Width="75px" Style="text-align: right;"  CssClass ="Txtboxsmall "
                                                                                                                runat="server" meta:resourcekey="txtOPPayableResource2"></asp:TextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </asp:Panel>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                                                </div>
                                            </asp:Panel>
                                            <ajc:CollapsiblePanelExtender ID="cpeDemo" runat="server" TargetControlID="Panel1"
                                                ExpandControlID="Panel2" CollapseControlID="Panel2" Collapsed="True" TextLabelID="Label1"
                                                ImageControlID="Image1" ExpandedText="(Click to Hide Consultation & Physician Amount Details...)"
                                                CollapsedText="(Click to View Consultation & Physician Amount Details...)" ExpandedImage="../Images/collapse.jpg"
                                                CollapsedImage="../Images/expand.jpg" SuppressPostBack="True" SkinID="CollapsiblePanelDemo"
                                                Enabled="True" />
                                            <div id="divPhySettlement" runat="server" class="dataheader2">
                                                <table class="w-100p bg-row">
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_NumberofConsultations" Text="Number of Consultations :" runat="server"
                                                                meta:resourcekey="Rs_NumberofConsultationsResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtNoOfConsultations" runat="server" MaxLength="25" ReadOnly="True"  CssClass ="Txtboxsmall "
                                                                size="25" Style="text-align: right;" Width="77px" meta:resourcekey="txtNoOfConsultationsResource2"
                                                                Text="0"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_AmounttoOrganization" Text="Amount to Organization:" runat="server"
                                                                meta:resourcekey="Rs_AmounttoOrganizationResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtOrgAmount" MaxLength="25" size="25" Width="77px"
                                                                 ReadOnly="True" meta:resourcekey="txtOrgAmountResource2"  CssClass ="Txtboxsmall a-right"
                                                                Text="0"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="Rs_PhysicianAmount" Text="Physician Amount :" runat="server" meta:resourcekey="Rs_PhysicianAmountResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox runat="server" ID="txtCommisiontoPhysician" MaxLength="25" size="25"  CssClass ="Txtboxsmall "
                                                                Width="77px" ReadOnly="True" Style="text-align: right;" Text="0" meta:resourcekey="txtCommisiontoPhysicianResource2" />
                                                        </td>
                                                        <td>
                                                            &nbsp;
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divPayment" runat="server" class="dataheader2">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td colspan="6">
                                                            <asp:Panel ID="pnltempPreviousPymts" GroupingText="Previous Payments on Selected Dates"
                                                                runat="server" CssClass="defaultfontcolor w-100p" meta:resourcekey="pnltempPreviousPymtsResource2">
                                                                <table class="w-100p">
                                                                    <tr class="tablerow" id="ACX2responsesPrevPmt" style="display: table-row;">
                                                                        <td>
                                                                            <div class="filterdatahe">
                                                                                <asp:GridView ID="gvPreviousPayments" runat="server" AutoGenerateColumns="False"
                                                                                    CellPadding="4" ForeColor="#333333" CssClass="mytable1 gridView" OnRowDataBound="gvConsultation_RowDataBound"
                                                                                    meta:resourcekey="gvPreviousPaymentsResource2">
                                                                                    <RowStyle ForeColor="#000066" />
                                                                                    <Columns>
                                                                                        <asp:BoundField HeaderText="ID" DataField="OutFlowID" meta:resourcekey="BoundFieldResource31">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Paid From" DataFormatString="{0:dd/MM/yyyy}" DataField="DateFrom"
                                                                                            meta:resourcekey="BoundFieldResource33">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Paid To" DataField="DateTo" DataFormatString="{0:dd/MM/yyyy}"
                                                                                            meta:resourcekey="BoundFieldResource34">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Paid Date" DataFormatString="{0:dd/MM/yyyy hh:mm tt}"
                                                                                            DataField="CreatedAt" meta:resourcekey="BoundFieldResource32">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Total Amount" DataField="TotalAmount" 
                                                                                            meta:resourcekey="BoundFieldResource4">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Org Amount" DataField="OrgAmount" 
                                                                                            meta:resourcekey="BoundFieldResource5">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="TDS" DataField="TDSAmount" 
                                                                                            meta:resourcekey="BoundFieldResource6">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Amount Paid" DataField="AmountReceived" DataFormatString="{0:0.00}"
                                                                                            meta:resourcekey="BoundFieldResource35">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Due" DataField="Due" DataFormatString="{0:0.00}" meta:resourcekey="BoundFieldResource36">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Surplus" DataField="Surplus" DataFormatString="{0:0.00}"
                                                                                            meta:resourcekey="BoundFieldResource37">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Right" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Remarks" DataField="Remarks" meta:resourcekey="BoundFieldResource38">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField HeaderText="Payment Type" DataField="PaymentType" meta:resourcekey="BoundFieldResource39">
                                                                                            <HeaderStyle Font-Bold="False" />
                                                                                            <ItemStyle HorizontalAlign="Left" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                    <FooterStyle BackColor="White" ForeColor="#000066" />
                                                                                    <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                                                                    <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                                                                    <HeaderStyle CssClass="grdcolor" Font-Bold="False" />
                                                                                </asp:GridView>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                        </td>
                                                    </tr>
                                                    <tr class="dataheaderPopup" style="border-color: White;">
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_AmountPaidsofar" Text="Amount Paid so far :" runat="server" meta:resourcekey="Rs_AmountPaidsofarResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblAmtPayedSoFar" Style="font-weight: bold;" runat="server" meta:resourcekey="lblAmtPayedSoFarResource2"></asp:Label>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_PayableAmount" Text="Payable Amount :" runat="server" meta:resourcekey="Rs_PayableAmountResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblPayableAmount" Style="font-weight: bold; color: Green;" runat="server"
                                                                meta:resourcekey="lblPayableAmountResource2"></asp:Label>
                                                        </td>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_PaymentType" Text="Payment Type :" runat="server" meta:resourcekey="Rs_PaymentTypeResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:RadioButton ID="rdoOfficial" runat="server" Checked="True" GroupName="rdo" Text="Official "
                                                                meta:resourcekey="rdoOfficialResource2" />
                                                            &nbsp;<asp:RadioButton ID="rdoPersonal" runat="server" GroupName="rdo" Text="Personal"
                                                                meta:resourcekey="rdoPersonalResource2" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="Rs_PaidAmount" Text="Paid Amount :" runat="server" meta:resourcekey="Rs_PaidAmountResource2"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtPayableAmount" runat="server"  onkeypress="return ValidateOnlyNumeric(this);"   CssClass ="Txtboxsmall "
                                                                ReadOnly="True" MaxLength="25" size="25" Style="text-align: right;" TabIndex="3"
                                                                Width="77px" meta:resourcekey="txtPayableAmountResource2" Text="0"></asp:TextBox>
                                                            <asp:HiddenField ID="hdnPayable" Value="0" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="hdfPayableAmount" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtServiceCharge" runat="server" CssClass="Txtboxsmall" Enabled="False"
                                                                TabIndex="9" Text="0.00" Style="display: none;" meta:resourcekey="txtServiceChargeResource2" />
                                                        </td>
                                                        <td>
                                                            <asp:HiddenField ID="hdnServiceCharge" runat="server" Value="0" />
                                                        </td>
                                                        <td id="trGrantTotal" nowrap="nowrap" style="display: none;" runat="server">
                                                            <asp:Label ID="lblGrantTotal" runat="server" Text="Grant Total :" meta:resourcekey="lblGrantTotalResource2"></asp:Label>
                                                            <asp:TextBox ID="txtGrantTotal" ReadOnly="True" MaxLength="25" size="25" Style="text-align: right;"  CssClass ="Txtboxsmall "
                                                                Width="77px" runat="server" Text="0.00" meta:resourcekey="txtGrantTotalResource2"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="6">
                                                            <uc9:PaymentTypeDetails EnabledCurrType="false" ID="PaymentTypeDetails1" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="Rs_Remarks" Text="Remarks :" runat="server" meta:resourcekey="Rs_RemarksResource2"></asp:Label>
                                                        </td>
                                                        <td colspan="6">
                                                            <asp:TextBox runat="server" ID="txtRemarks" MaxLength="25" size="25" TextMode="MultiLine"
                                                                CssClass="Txtboxlarge" meta:resourcekey="txtRemarksResource2"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <div id="divSave" runat="server" class="dataheader2">
                                                <table class="w-100p">
                                                    <tr class="a-center">
                                                        <td class="a-center">
                                                            <asp:Button ID="bsave" OnClientClick="javascript:return validateDetails();" runat="server"
                                                                CssClass="btn" TabIndex="4" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                                Text="Save" OnClick="bsave_Click" meta:resourcekey="bsaveResource2" />
                                                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" TabIndex="5" onmouseover="this.className='btn btnhov'"
                                                                onmouseout="this.className='btn'" OnClick="btnCancel_Click" Text="Cancel" meta:resourcekey="btnCancelResource2" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />          
    <asp:HiddenField ID="hdnPID" runat="server" />
     <asp:HiddenField ID="hdnMessages" runat="server" />
       <asp:HiddenField ID="hdnPhysicianID" runat="server" Value="0" />
    </form>

    <script type="text/javascript" language="javascript">
        function SelectCheckCommon(chkSelect, txtSupAmount) {
            var temoTotal = 0.00;
            var x = document.getElementById('hdnValues').value.split('^');
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    y = x[i].split("~");
                    if (document.getElementById(y[0]).checked == true) {
                        temoTotal = format_number(Number(document.getElementById(y[1]).value) + Number(temoTotal), 2);
                    }
                }

            }
            document.getElementById('txtGrantTotal').value = Number(temoTotal).toFixed(2);
            document.getElementById('<%= hdnPayable.ClientID %>').value = format_number(temoTotal, 2);


        }
        function CheckCommon(chkSelect, txtSupAmount, total) {
            var AlrtWinHdr = SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") != null ? SListForAppMsg.Get("Admin_TestInvestigation_aspx_02") : "Information";
            var userMsg = SListForAppMsg.Get("Admin_CashFlow_aspx_11") != null ? SListForAppMsg.Get("Admin_CashFlow_aspx_11	") : "Provide payable amount less than or equal to total amount";
	
            if (document.getElementById(chkSelect).checked == true) {
                if (Number(document.getElementById(txtSupAmount).value) > Number(total)) {
                  //  var userMsg = SListForApplicationMessages.Get("Admin\\CashFlow.aspx_10");
                    if (userMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(userMsg, AlrtWinHdr);
                        return false;
                 }
                 else {
                        //alert('Provide payable amount less than or equal to total amount');
                        ValidationWindow(userMsg, AlrtWinHdr);
                     return false;
                 }
                    document.getElementById(txtSupAmount).value = '0.00';
                    document.getElementById(txtSupAmount).focus();
                    return false;
                }
                SelectCheckCommon(chkSelect, txtSupAmount);

            }

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

</body>
</html>
