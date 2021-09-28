<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QuotationMaster.aspx.cs"
    Inherits="Waters_QuotationMaster" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/PaymentTypeDetails.ascx" TagName="paymentType"
    TagPrefix="Payment" %>
<%@ Register Src="../CommonControls/ViewTRFImage.ascx" TagName="ViewTRFImage" TagPrefix="TRF" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms"
    TagPrefix="rsweb" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quotation Master</title>
    

    <script src="../Scripts/datetimepicker.js" type="text/javascript"></script>

    <script src="Waters.js" type="text/javascript"></script>
    <script src="Scripts/CommonQuotation.js" type="text/javascript"></script>
    <style type="text/css">
        .searchQuotation td, .testSectionArea, .billingDetails
        {
            padding: 2px 10px;
        }
        .testSectionArea .trEven td, .testSectionArea .trOdd td
        {
            padding: 2px;
        }
        .searchQuotation .chkBillingAddress tr td
        {
            padding: 0;
        }
        .chkBillingAddress input[type="checkbox" i]
        {
            margin: 3px 3px 3px 0px;
        }
        table.gridView.tblGridTest .dataHeader
        {
            background: #446d87 !important;
        }
        table.gridView.tblGridTest .dataHeader td
        {
            color: #fff !important;
            font-weight: bold;
        }
        .lblBillingDeatils
        {
            background: #446d87;
            color: #fff;
            font-weight: bold;
            padding: 3px 5px;
        }
        .testSectionArea span
        {
            font-size: 12px;
        }
        table.gridView.tblGridTest tr
        {
            height: 23px;
        }
        .divGridTest
        {
            display: block;
            overflow: auto;
            min-height: 50px;
            max-height: 75px;
        }
        .holder
        {
            position:static
            
            
        }
        
        .btnsize
        {
            height: 20px;
            width: 55px;
        }
        .transparent
        {
            background-color: Transparent;
        }
    </style>
</head>
<body>

    <script type="text/javascript" language="javascript">


        function checkEmail(id) {


            //debugger;


            var objname = SListForAppMsg.Get("Waters_QuotationMaster_aspx_24") == null ? "Provide name" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_24");
            var objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");


            if ($('#chkEmail').prop('checked') == true) {

                if (document.getElementById('txtEmailID').value == "") {

                    ValidationWindow(objname, objalert);

                    return false;

                }

                else {
                    return true;
                
                }
            
            }






        }




        function TestDisplay() {


            var behavior = $find('AutoCompleteExtender3');
            var target = behavior.get_completionList();
            for (i = 0; i < target.childNodes.length; i++) {
                var text = target.childNodes[i]._value;
                var ItemArray;
                ItemArray = text.split('^');
                if (ItemArray[4].trim().toLowerCase() == 'y') {
                    // target.childNodes[i].className = "focus"
                }
                if (ItemArray[2].trim().toLowerCase() == 'inv') {
                    // target.childNodes[i].className = "focus"

                    target.childNodes[i].style.color = "Black";
                    //target.childNodes[i].style.fontcolor('Orange');
                }
                else if (ItemArray[2].trim().toLowerCase() == 'pkg') {
                    target.childNodes[i].style.color = "blue";

                }
                else {

                    target.childNodes[i].style.color = "MediumVioletRed";
                    //target.childNodes[i].style.fontcolor('red');
                }

            }





        }


        function checkSms(id) {


           // debugger;


            var objname = SListForAppMsg.Get("Waters_QuotationMaster_aspx_25") == null ? "Provide name" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_25");
            var objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");


            if ($('#chkSMS').prop('checked') == true) {

                if (document.getElementById('txtMobileNo').value == "") {

                    ValidationWindow(objname, objalert);

                    return false;

                }

                else {
                    return true;

                }

            }






        }
        
        
        
        function ValidateQuotationEvents(Obj) {
            var objname = SListForAppMsg.Get("Waters_QuotationMaster_aspx_07") == null ? "Provide name" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_07");
            var objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");
            var objTestDetails = SListForAppMsg.Get("Waters_QuotationMaster_aspx_23") == null ? "Add Test to generate Quotation" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_23");
            if ($('#txtClientName').val() == '') {
                ValidationWindow(objname, objalert);
                return false;

            }


            if (document.getElementById('hdnTempTest').value == "" || document.getElementById('hdnTempTest').value == "[]") {


                ValidationWindow(objTestDetails, objalert);
                return false;
            
            
            }




        }


        function AddPKGTestList() {

            
            var Popupamt = 0;
            var Defaultamt = 0;
            var CheckedAmt = 0;
            objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");
            objperiod = SListForAppMsg.Get("Waters_QuotationMaster_aspx_12") == null ? "Select Test that has to added" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_12");

            if (document.getElementById('hdnChckedMasterTest').value == "") {

                ValidationWindow(objperiod, objalert);
                return false;
            
            }

            document.getElementById('hdnPKGTest').value += document.getElementById('hdnChckedMasterTest').value;
            Defaultamt = document.getElementById('hdnDefaultAmount').value;
            CheckedAmt = document.getElementById('hdnPopupMasterAmt').value;
            Popupamt = parseFloat(Defaultamt) + parseFloat(CheckedAmt);
            document.getElementById('hdnDefaultAmount').value = Popupamt.toFixed(2);
//            Popupamt = document.getElementById('PopUptxtTotal').value;
//            //   document.getElementById('PopUptxtAmount').value = parseFloat(document.getElementById('PopUptxtAmount').value) + parseFloat(document.getElementById('hdnPopupMasterAmt').value);
//            document.getElementById('hdnPopupMasterAmt').value = parseFloat(document.getElementById('PopUptxtSampleCount').value * document.getElementById('hdnPopupMasterAmt').value).toFixed(2);
//            Popupamt = parseFloat(document.getElementById('hdnPopupMasterAmt').value) + parseFloat(Popupamt);
//            //document.getElementById('PopUptxtAmount').innerHTML = Popupamt;
//            document.getElementById('PopUptxtTotal').value = Popupamt;
            PopupQuotationTable();
            PopupMasterDetailsBind();
            /****FAmount Calculation*****/

            FamountCalculation();
            Clearitems();
            return false;



        }



        function RemovePKGList() {

           
            var Popupamt = 0;
            var Defaultamt = 0;
            var CheckedAmt = 0;
            objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");
            objperiod = SListForAppMsg.Get("Waters_QuotationMaster_aspx_12") == null ? "Select Test that has to added" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_12");

            if (document.getElementById('hdnTestChckdDetails').value == "") {

                ValidationWindow(objperiod, objalert);
                return false;

            }


            document.getElementById('hdnMasterPKGTest').value += document.getElementById('hdnTestChckdDetails').value;
            Defaultamt = document.getElementById('hdnDefaultAmount').value;
            CheckedAmt = document.getElementById('hdnPopupAmt').value;
            Popupamt = parseFloat(Defaultamt - CheckedAmt).toFixed(2);
            document.getElementById('hdnDefaultAmount').value = Popupamt;
       

            PopupQuotationTable();
            PopupMasterDetailsBind();
            FamountCalculation();
            Clearitems();
            return false;



        }


        function FamountCalculation() {

           

            var DiscountType, DiscountValue, Famount, amount, DiscountAmount;
            var Popupamt = 0;
            Popupamt = document.getElementById('hdnDefaultAmount').value;
            Popupamt = parseFloat(document.getElementById('PopUptxtSampleCount').value * Popupamt).toFixed(2);
            document.getElementById('PopUptxtTotal').value = Popupamt;
            DiscountType = document.getElementById('hdnDiscountTypePopup').value;
            DiscountValue = document.getElementById('PopUptxtDiscountValue').value;
            amount = document.getElementById('PopUptxtTotal').value;

            if (DiscountType == "PERCENTAGE") {

                Famount = parseFloat((amount * DiscountValue) / 100).toFixed(2);
                DiscountAmount = parseFloat(Famount).toFixed(2);
                Famount = amount - Famount;

            }
            else if (DiscountType == "VALUE") {



            Famount = parseFloat(amount - DiscountValue).toFixed(2);
            DiscountAmount = parseFloat(Famount).toFixed(2);

            }

            else {

                Famount = parseFloat(amount).toFixed(2);
                DiscountAmount = "0";

            }
            document.getElementById('hdnPopupFinalAmt').value = Famount;
            document.getElementById('PopUptxtFinalAmount').value = Famount;   
            document.getElementById('hdnPopupFinalDiscountAmt').value = DiscountAmount;
           // document.getElementById('PopUptxtDiscountValue').value = DiscountAmount;
            Clearitems();

            return false;
        
        }


        function Clearitems() {


            document.getElementById('hdnPopupMasterAmt').value = "0";
            document.getElementById('hdnPopupAmt').value = "0";
            document.getElementById('hdnChckedMasterTest').value = "";
            document.getElementById('hdnTestChckdDetails').value = "";
        }


        function CancelPopup() {

            $find('ModalPopupShow').hide();
            document.getElementById('hdnPKGTest').value = "";
            document.getElementById('hdnMasterPKGTest').value = "";
            return false;
        
        }

        function UpdatePKGList() {

            var updatedTest, i = 0, TestID, main = 0, TempsEditedData;
            objalert = SListForAppMsg.Get("Waters_QuotationMaster_aspx_08") == null ? "alert" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_08");
            objperiod = SListForAppMsg.Get("Waters_QuotationMaster_aspx_12") == null ? "Select Test that has to added" : SListForAppMsg.Get("Waters_QuotationMaster_aspx_12");

           if (document.getElementById('hdnPopupFinalAmt').value == "0") {

                ValidationWindow(objperiod, objalert);
                return false;
            }
            var updatedMasterTest, MasterTestID, Mastermain = 0, MasterTempsEditedData;
            if (document.getElementById('hdnPKGUpdateList').value != "") {
                updatedTest = document.getElementById('hdnPKGUpdateList').value.split('%');
                for (i = 0; i < updatedTest.length - 1; i++) {
                    var UpdateListID = updatedTest[i].split('^');
                    var ListID = UpdateListID[0].split('~');
                    if(ListID[0] == document.getElementById('hdnPopupTestID').value) 
                    {
                        updatedTest[i] = "";
                    
                    }

                }
                TempsEditedData = "";
                for (Mastermain = 0; Mastermain < updatedTest.length; Mastermain++) {
                    if (updatedTest[Mastermain] != "") {
                        TempsEditedData += updatedTest[Mastermain] + "%";

                    }


                }

                document.getElementById('hdnPKGUpdateList').value = TempsEditedData;

            }

            document.getElementById('hdnPKGUpdateList').value += document.getElementById('hdnPopupTestID').value + '~' + document.getElementById('hdnPopupFinalAmt').value + '~' + document.getElementById('hdnPopupFinalDiscountAmt').value + '~' + document.getElementById('PopUptxtSampleCount').value + '~' + document.getElementById('hdnDefaultAmount').value + '~' + document.getElementById('PopUptxtDiscountValue').value + '^' + document.getElementById('hdnPKGTest').value + '%';
            if (document.getElementById('hdnPKGMasterUpdatelist').value != "") {

                updatedMasterTest = document.getElementById('hdnPKGMasterUpdatelist').value.split('%');
                for (i = 0; i < updatedMasterTest.length - 1; i++) {
                    var UpdateListID = updatedMasterTest[i].split('^');
                    var ListID = UpdateListID[0].split('~');
                    if (ListID[0] == document.getElementById('hdnPopupTestID').value) {
                        updatedMasterTest[i] = "";

                    }

                }
                TempsEditedData = "";
                for (main = 0; main < updatedMasterTest.length; main++) {
                    if (updatedMasterTest[main] != "") {
                        TempsEditedData += updatedMasterTest[main] + "%";

                    }


                }

                document.getElementById('hdnPKGMasterUpdatelist').value = TempsEditedData;

            
            }
            document.getElementById('hdnPKGMasterUpdatelist').value += document.getElementById('hdnPopupTestID').value + '^' + document.getElementById('hdnMasterPKGTest').value + '%';
            $find('ModalPopupShow').hide();

            AddItems();
            document.getElementById('hdnPKGTest').value = "";
            document.getElementById('hdnMasterPKGTest').value = "";
            document.getElementById('hdnPopupFinalAmt').value == "0";
            return false;
        }

        function SuppressBrowserRefresh1(e) {
            var keySource = event.soruce;
            var keycode = (window.event) ? event.keyCode : e.keyCode;
            if (Number(keycode) == Number(13)) {
                //alert("Doing browser refresh may cause loss or unstable data. Please be sure before continuing");
                event.keyCode = 0;
                event.returnValue = false;
                return false;
            }

        }

        function OpenBillPrint(url) {
            window.open(url + " &duplicateBill=N", "billprint", "letf=0,top=0,toolbar=0,scrollbars=yes,status=0");
        }

    </script>

    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/OPIPBilling.asmx" />
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata quotMaster">
        <div>
            <table class="w-100p searchQuotation searchPanel" onkeydown="SuppressBrowserRefresh1();">
                <tr>
                    <td class="w-13p">
                        <asp:TextBox ID="txtQuotationNumber" runat="server" onkeypress="" MaxLength="15"
                            TabIndex="1" CssClass="AutoCompletesearchBox" meta:resourcekey="txtQuotationNumberResource1"></asp:TextBox>
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderQuotationNo" runat="server" TargetControlID="txtQuotationNumber"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="3" CompletionInterval="0" ServiceMethod="GetQuotationNumber"
                            OnClientItemSelected="SelectedQuotationNumber" ServicePath="~/OPIPBilling.asmx"
                            DelimiterCharacters="" Enabled="True" UseContextKey="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                    <td colspan="5">
                        <asp:Label ID="Rs_QuotationNumber" Text="Quotation Number" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblClientName" Text="Client Name" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtClientName" runat="server" CssClass="small" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                            TabIndex="2" MaxLength="30" onblur="ConverttoUpperCase(this.id);" meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientName" runat="server" TargetControlID="txtClientName"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                            MinimumPrefixLength="2" CompletionInterval="0" ServiceMethod="GetQuotationClientName"
                            OnClientItemSelected="SelectedClient" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                            Enabled="True" UseContextKey="True">
                        </ajc:AutoCompleteExtender>
                        <%--   <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtTestName"
                          EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" OnClientItemSelected="BillingItemSelected"
                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetBillingItems"
                            FirstRowSelected="false" OnClientItemOver="TempBillingItemSelected" ServicePath="~/OPIPBilling.asmx"
                            UseContextKey="True" DelimiterCharacters="" OnClientShown="InvPopulated" Enabled="True"
                            OnClientPopulated="onTestListPopulated">
                        </ajc:AutoCompleteExtender>--%>
                    </td>
                    <td>
                        <asp:Label ID="lblClientSource" Text="Client Source" runat="server" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlClientSource" CssClass="ddlsmall" runat="server" TabIndex="3"
                            meta:resourcekey="ddlRegisterDateResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblOthers" Text="Others" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtOthers" runat="server" CssClass="small" MaxLength="30" TabIndex="4"
                            placeholder="Max of 30 Characters" OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                            meta:resourcekey="txtOthersResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblEmailID" Text="Email Id" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmailID" runat="server" CssClass="small" MaxLength="30" onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');"
                            TabIndex="5" meta:resourcekey="txtEmailIDResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblMobileNo" Text="Mobile No" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtMobileNo" runat="server" onkeypress="return ValidateOnlyNumeric(this);"
                            Onchange="CheckMobileSMS();" TabIndex="6" MaxLength="10" CssClass="small" meta:resourcekey="txtMobileNoResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblTelephoneNo" Text="Telephone No" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtTelephoneNo" runat="server" onkeypress="return ValidateOnlyNumeric(this);"
                            TabIndex="7" MaxLength="10" CssClass="small" meta:resourcekey="txtTelephoneNoResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblAddress" Text="Address" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="small" MaxLength="250" TabIndex="8"
                            OnKeyPress="return ValidateMultiLangCharacter(this)|| ValidateOnlyNumeric(this);"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblSuburb" Text="Suburb" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtSuburb" runat="server" CssClass="small" MaxLength="30" TabIndex="9"
                            OnKeyPress="return ValidateMultiLangCharacter(this)|| ValidateOnlyNumeric(this);"
                            meta:resourcekey="txtSubrubResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblCity" Text="City" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtCity" runat="server" CssClass="small" MaxLength="30" TabIndex="10"
                            OnKeyPress="return ValidateMultiLangCharacter(this);" meta:resourcekey="txtCityResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblCountry" Text="Country" runat="server" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddCountry" runat="server" TabIndex="12" onchange="javascript:loadState();"
                            CssClass="small">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblState" Text="State" runat="server" />
                    </td>
                    <td>
                        <select id="ddState" runat="server" class="ddlsmall" tabindex="11" onchange="javascript:onchangeState();">
                        </select>
                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                    </td>
                    <td>
                        <asp:Label ID="lblPincode" Text="Pincode" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtPincode" runat="server" CssClass="small" MaxLength="20" TabIndex="13"
                            onkeypress="return ValidateOnlyNumeric(this);" meta:resourcekey="txtPincodeResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table class="w-100p chkBillingAddress" onkeydown="SuppressBrowserRefresh1();">
                            <tr>
                                <td>
                                    <asp:CheckBox ID="chkSameAddress" runat="server" meta:resourcekey="chkSameAddressResource1"
                                        TabIndex="14" />
                                    <asp:Label ID="lblSameAddress" runat="server" Text="Same Billing Address" meta:resourcekey="lblSameAddressResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr id="trSameBIllingAddrOne" runat="server">
                    <td>
                        <asp:Label ID="lblAddress1" Text="Address" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtAddress1" runat="server" MaxLength="250" OnKeyPress="return ValidateMultiLangCharacter(this)|| ValidateOnlyNumeric(this);"
                            CssClass="small" meta:resourcekey="TextBox1Resource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblSuburb1" Text="Suburb" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtSuburb1" runat="server" CssClass="small" MaxLength="30" OnKeyPress="return ValidateMultiLangCharacter(this)|| ValidateOnlyNumeric(this);"
                            meta:resourcekey="TextBox2Resource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblCity1" Text="City" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtCity1" runat="server" CssClass="small" MaxLength="30" OnKeyPress="return ValidateMultiLangCharacter(this);"
                            meta:resourcekey="TextBox3Resource1"></asp:TextBox>
                    </td>
                </tr>
                <tr id="trSameBIllingAddrTwo" runat="server">
                    <td>
                        <asp:Label ID="lblState1" Text="State" runat="server" />
                    </td>
                    <td>
                        <select id="ddState1" runat="server" class="ddlsmall" onchange="javascript:onchangeState();">
                        </select>
                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                    </td>
                    <td>
                        <asp:Label ID="lblCountry1" Text="Country" runat="server" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddCountry1" runat="server" onchange="javascript:loadTempState();"
                            CssClass="small">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:Label ID="lblPincode1" Text="Pincode" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtPincode1" runat="server" MaxLength="20" onkeypress="return ValidateOnlyNumeric(this);"
                            CssClass="small" meta:resourcekey="TextBox6Resource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblSalesPerson" Text="Sales Person" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtSalesPerson" runat="server" CssClass="small" MaxLength="30" TabIndex="15"
                            OnKeyPress="return ValidateMultiLangCharacter(this);" meta:resourcekey="txtSalesPersonResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblBranch" Text="Branch" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtBranch" runat="server" CssClass="small" MaxLength="30" TabIndex="16"
                            OnKeyPress="return ValidateMultiLangCharacter(this);" meta:resourcekey="txtBranchResource1"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Label ID="lblRemarks" Text="Remarks" runat="server" />
                    </td>
                    <td>
                        <asp:TextBox ID="txtRemarks" runat="server" MaxLength="250" placeholder="Max of 250 Characters"
                            TabIndex="17" CssClass="small" meta:resourcekey="txtRemarksResource1"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblValidityPeriod" Text="Validity Period" runat="server" />
                    </td>
                    <td style="cursor: pointer;">
                        <asp:TextBox ID="txtValidityPeriod" runat="server" TabIndex="18" CssClass="small"
                            meta:resourcekey="txtValidityPeriodResource1"></asp:TextBox>
                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                    </td>
                    <td>
                        <asp:Label ID="lblQuotationMode" Text="Dispatch/Delivery mode" runat="server" />
                    </td>
                    <td>
                    <input id="chkEmail"  runat ="server"  type="checkbox" onclick="return checkEmail(this.id); " />
                       <%-- <asp:CheckBox ID="chkEmail" runat="server"  OnCheckedChanged="CheckEmail"  meta:resourcekey="chkEmailResource1" />--%>
                        <asp:Label ID="lblEmailchk" runat="server" Text="Email" meta:resourcekey="lblEmailchkResource1"></asp:Label>
                        <input id="chkSMS"  runat ="server"  type="checkbox" onclick="return checkSms(this.id); " />
                        <%--<asp:CheckBox ID="chkSMS" runat="server"   meta:resourcekey="chkSMSResource1" />--%>
                        <asp:Label ID="lblSMSchk" runat="server" Text="SMS" meta:resourcekey="lblSMSchkResource1"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblFileUpload" Text="File Upload" runat="server" />
                    </td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" accept="gif|GIF|jpg|JPG|png|PNG|bmp|BMP|jpeg|JPEG|pdf|PDF"
                            class="multi" meta:resourcekey="FileUpload1Resource1" />
                        <asp:Label ID="FileUpload" cssclass="transparent" runat="server" Font-Size="10px" Text="GIF|JPG|PNG|BMP|JPEG|PDF"></asp:Label>
                    </td>
                </tr>
            </table>
            <table class="testSectionArea searchPanel w-100p" id="testSectionArea" runat="server">
                <tr>
                    <td>
                        <asp:TextBox ID="txtinvcolor" Style="background-color: #000000;" ReadOnly="True"
                            runat="server" Height="5px" TabIndex="-1" Width="5px"></asp:TextBox>
                        <asp:Label ID="lblinvcolor" Text="Investigation" runat="server" ></asp:Label>&nbsp;
                        <asp:TextBox ID="txtgrpcolor" Style="background-color: #C71585;" ReadOnly="True"
                            runat="server" Height="5px" TabIndex="-1" Width="5px" ></asp:TextBox>
                        <asp:Label ID="lblgrpcolor" Text="Group" runat="server" ></asp:Label>&nbsp;
                        <asp:TextBox ID="txtpkgcolor" Style="background-color: #6699FF;" ReadOnly="True"
                            runat="server" Height="5px" TabIndex="-1" Width="5px" ></asp:TextBox>
                        <asp:Label ID="lblpkgcolor" Text="Package" runat="server" ></asp:Label>
                    </td>
                </tr>
                <tr class="gridHeader">
                    <td>
                        <asp:Label ID="lblTestName" Text="Test Name" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblSampleType" Text="Sample Type" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblSampleCount" Text="Sample Count" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblDiscountType" Text="Discount Type" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblDiscountValue" Text="Discount Value" runat="server" />
                    </td>
                    <td>
                        <asp:Label ID="lblAction" Text="Action" runat="server" />
                    </td>
                </tr>
                <tr class="trEven">
                    <td>
                    
                        <asp:TextBox ID="txtTestName" runat="server" CssClass="large" meta:resourcekey="txtTestNameResource1"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtTestName"
                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                            CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                            ServiceMethod="GetBillingItems" FirstRowSelected="false" ServicePath="~/OPIPBilling.asmx"
                            OnClientShown="TestDisplay" OnClientItemSelected="TestItemSelected" UseContextKey="True"
                            DelimiterCharacters="" Enabled="True">
                        </ajc:AutoCompleteExtender>
                    </td>
                    <td>
                        <%--<asp:TextBox ID="txtSampleType" runat="server" CssClass="small" onkeypress="return ValidateMultiLangCharacter(this);"  meta:resourcekey="txtSampleTypeResource1"></asp:TextBox>--%>
                        <asp:DropDownList ID="ddSampleType" Enabled="false" CssClass="ddlsmall" runat="server" >
                        </asp:DropDownList>
						<img src="../Images/starbutton.png" alt="" align="middle" />

                    </td>
                    <td>
                        <asp:TextBox ID="txtSampleCount" runat="server" MaxLength="15" CssClass="small" Enabled="false"
                            onkeypress="return ValidateOnlyNumeric(this);" meta:resourcekey="txtSampleCountResource1"></asp:TextBox>
                        <img src="../Images/starbutton.png" alt="" align="middle" />
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlDiscountType" Enabled="false" onchange="javascript:EnableDiscountValue();" 
                            CssClass="ddlsmall" runat="server" meta:resourcekey="ddlRegisterDateResource1">
                        </asp:DropDownList>
                    </td>
                    <td>
                        <asp:TextBox ID="txtDiscountValue" runat="server" MaxLength="15" onkeypress="return ValidateOnlyNumeric(this);"
                            Enabled="false" CssClass="small"></asp:TextBox>
                    </td>
                    <td>
                        <asp:Button ID="btnAdd" runat="server" ToolTip="Click here to Add" Style="cursor: pointer;"
                            CssClass="btn" Text="Add" OnClientClick="return AddItems();" />
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <div class="paddingT10">
                            <div class="paddingT10" id="divGrid" runat="server">
                            </div>
                            <asp:Panel ID="PanelTestGroup" runat="server" Style="height: 500px; width: 90%; margin: 0 auto;"
                                CssClass="modalPopup dataheaderPopup" CancelControlID="Butclose" Enabled="True">
                                <table class="w-100p gridView">
                                    <tr>
                                        <td>
                                            <asp:Label ID="PopUplblTestName" runat="server" Text="Test Name:" />
                                            <asp:Label ID="PopUptxtTestName" runat="server"  />
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblSample" runat="server" Text="Sample:" />
                                            <asp:Label ID="PopUptxtSample" runat="server"  />
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblCount" runat="server" Text="Count:" />
                                            <asp:Label ID="PopUptxtCount" runat="server" Text="Count" />
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblAmount" runat="server" Text="Amount:" />
                                            <asp:Label ID="PopUptxtAmount" runat="server" Text="Amount" />
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblDiscount" runat="server" Text="Discount:" />
                                            <asp:Label ID="PopUptxtDiscount" runat="server" Text="Discount" />
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblFamount" runat="server" Text="Final amount:" />
                                            <asp:Label ID="PopUptxtFamount" runat="server" Text="F.amount" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <table class="w-100p">
                                    <tr>
                                        <td class="w-45p v-top">
                                            <div class="w-100p a-right">
                                            <asp:TextBox ID="TextBox1" runat="server" Font-Size="14px" CssClass="small a-right AutoCompletesearchBox"
                                                 onkeyup="Search_Gridview(this, 'MasterTest')" ToolTip="Search"
                                                placeholder="Search"></asp:TextBox>
                                               <%-- <asp:TextBox ID="TextBox1" runat="server" colspan="2" CssClass="small a-right AutoCompletesearchBox"></asp:TextBox>--%>
                                            </div>
                                            <div class="bg-row" id="PKGMaster" style="overflow: auto; border: 1px; border-color: #fff;  max-height: 300px;">
                                            </div>
                                        </td>
                                        <td class="w-10p">
                                            <table id="btnPopUp" class="w-100p a-center">
                                                <tr>
                                                    <td class="a-center">
                                                        <button id="btnPopUpAdd" runat="server" class="btn btnsize" onclick=" return AddPKGTestList();">
                                                            Add</button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="a-center">
                                                        <button id="btnPopUpRemove" runat="server" class="btn btnsize" onclick="return RemovePKGList();">
                                                            Remove</button>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td class="w-45p v-top">
                                            <div class="w-100p a-right">
                                               <%-- <asp:TextBox ID="" runat="server" CssClass="small a-right AutoCompletesearchBox"></asp:TextBox>--%>
                                                 <asp:TextBox ID="txtPopupPKG" runat="server" Font-Size="14px" CssClass="small a-right AutoCompletesearchBox"
                                                 onkeyup="Search_Gridview(this, 'PKGListTest')" ToolTip="Search"
                                                placeholder="Search"></asp:TextBox>
                                            </div>
                                            <div id="PKGlist" class="bg-row" style="overflow: auto; border: 1px; border-color: #fff;max-height: 300px;">
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-100p bg-row">
                                    <tr>
                                        <td>
                                            <asp:Label ID="PopUplblTotal" runat="server" Text="Total"></asp:Label>
                                            <asp:TextBox ID="PopUptxtTotal" runat="server" CssClass="small"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblSampleCount" runat="server" Text="Sample Count"></asp:Label>
                                            <asp:TextBox ID="PopUptxtSampleCount" onblur="return FamountCalculation();" onkeypress="return ValidateOnlyNumeric(this);" runat="server" CssClass="small"></asp:TextBox>
                                        </td>
                                        <td>
                                        <asp:Label ID="PopuplblDiscountType" runat="server" Text="Discount Type"></asp:Label>
                                        <asp:DropDownList ID="PopupDiscountType"   CssClass="ddlsmall" runat="server" meta:resourcekey="ddlRegisterDateResource1">
                        </asp:DropDownList>
                                        
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblDiscountValue" runat="server" Text="Discount Value"></asp:Label>
                                            <asp:TextBox ID="PopUptxtDiscountValue" runat="server" onkeypress="return ValidateOnlyNumeric(this);" onblur="return FamountCalculation();" CssClass="small"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:Label ID="PopUplblFinalAmount" runat="server" Text="Final Amount"></asp:Label>
                                            <asp:TextBox ID="PopUptxtFinalAmount" runat="server" CssClass="small"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <div class="a-center">
                                    <button id="btnPopupCancel" runat="server" class="btn" onclick="return CancelPopup();">
                                        Cancel</button>
                                        <button id="btnUpdate" runat="server" class="btn" onclick="return UpdatePKGList();">
                                        Update</button>
                                </div>
                            </asp:Panel>
                            <ajc:ModalPopupExtender ID="ModalPopupShow" runat="server" BackgroundCssClass="modalBackground"
                                PopupControlID="PanelTestGroup" Enabled="True" TargetControlID="btnDummy" DynamicServicePath="">
                            </ajc:ModalPopupExtender>
                            <input type="button" id="btnDummy" runat="server" style="display: none;" />
                        </div>
                    </td>
                </tr>
            </table>
            <table class="w-100p billingDetails" onkeydown="SuppressBrowserRefresh1();">
                <tr>
                    <td>
                        <p class="lblBillingDeatils">
                            Payment Details</p>
                    </td>
                </tr>
                <tr>
                    <td class="v-top w-100p" runat="server" id="tdGrossBillDetails">
                        <table id="tdBillDetails" class="w-100p" runat="server">
                            <tr>
                                <td id="trFoc" runat="server">
                                    <div class="a-left">
                                        <asp:CheckBox ID="chkFoc" runat="server"></asp:CheckBox>
                                        <asp:Label ID="lblFoc" Text="IS FOC" runat="server" />
                                    </div>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtFoc" runat="server" placeholder="Max of 100 Characters" Enabled="false" CssClass="small"></asp:TextBox>
                                </td>
                                <td id="trDiscountPart" runat="server">
                                    <asp:Label ID="tdDiscountLabel" runat="server" meta:resourcekey="tdDiscountLabelResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_04 %>
                                    </asp:Label>
                                </td>
                                <td id="Td7" runat="server">
                                    <asp:DropDownList CssClass="ddlsmall" ID="ddDiscountPercent" ToolTip="Select the Discount"
                                        onChange="javascript:SetQuotationDiscountAmt();" runat="server" Enabled="false"
                                        meta:resourceKey="ddDiscountPercentResource1">
                                    </asp:DropDownList>
                                    <asp:Button ID="btnDiscountPercent" runat="server" Enabled="False" Text="Discount"
                                        CssClass="smallbtn" Style="display: none;" meta:resourcekey="btnDiscountPercentResource1" />
                                    <asp:Label ID="lblTtlDiscountPercentage" runat="server" meta:resourcekey="lblTtlDiscountPercentageResource1"></asp:Label>
                                </td>
                                <td id="tdDiscReason" class="a-left" runat="server">
                                    <asp:Label ID="lblDiscountReason" runat="server" meta:resourcekey="lblDiscountReasonResource1">
                                                        <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_10 %>
                                    </asp:Label>
                                </td>
                                <td id="Td15" runat="server">
                                    <asp:DropDownList ID="ddlDiscountReason" runat="server" CssClass="ddlsmall" Enabled="false"
                                        meta:resourcekey="ddlDiscountReasonResource1">
                                    </asp:DropDownList>
                                    <asp:TextBox Style="display: none;" ID="txtDiscountReason" autocomplete="off" CssClass="Txtboxsmall"
                                        Width="95%" runat="server" MaxLength="900" onfocus="javascript:CheckBillItems();"
                                        meta:resourcekey="txtDiscountReasonResource1" />
                                    <%-- <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                </td>
                                <td id="trAuthorisedBy" class="a-left" runat="server">
                                    <asp:Label ID="lblAuthorised" runat="server" meta:resourcekey="lblAuthorisedResource1">
                                                         <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_11 %>
                                    </asp:Label>
                                </td>
                                <td id="Td17" runat="server">
                                    <asp:TextBox ID="txtAuthorised" autocomplete="off" CssClass="AutoCompletesearchBox"
                                        runat="server" meta:resourcekey="txtAuthorisedResource1" />
                                    <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                    <ajc:AutoCompleteExtender ID="AutoAuthorizer" runat="server" CompletionInterval="10"
                                        FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected"
                                        CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters=";,:" EnableCaching="False"
                                        Enabled="True" MinimumPrefixLength="1" ServiceMethod="getUserNamesWithNameandLoginID"
                                        ServicePath="~/WebService.asmx" TargetControlID="txtAuthorised">
                                    </ajc:AutoCompleteExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblGross" runat="server" Text="Gross Amount" class="defaultfontcolor"
                                        meta:resourceKey="lblGrossResource1" />
                                </td>
                                <td id="tdGross" class="a-left">
                                    <asp:TextBox CssClass="small a-right" ID="txtGross" runat="server" Text="0.00" Enabled="true"
                                        meta:resourceKey="txtGrossResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdnGrossValue" runat="server" Value="0" />
                                </td>
                                <td id="trRSTax" runat="server">
                                    <asp:Label ID="Rs_Tax" runat="server" meta:resourcekey="Rs_TaxResource1">
                                                         <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_12 %>
                                    </asp:Label>
                                </td>
                                <td id="Td19" runat="server">
                                    <asp:DropDownList CssClass="ddlsmall" ID="ddlTaxPercent" ToolTip="Select the Tax"
                                        Enabled="false" onChange="javascript:SetQuotationTaxAmt();" runat="server" meta:resourcekey="ddlTaxPercentResource1">
                                    </asp:DropDownList>
                                </td>
                                <td id="trTaxAmountPart" runat="server">
                                    <asp:Label ID="lblTaxt" runat="server" meta:resourceKey="lblTaxtResource1">
                                            <%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_18 %> 
                                    </asp:Label>
                                </td>
                                <td id="Td29" class="a-left" runat="server">
                                    <asp:TextBox CssClass="small a-right" onkeypress="return ValidateOnlyNumeric(this);"
                                        onChange="javascript:SetNetValue('ADD');" ID="txtTax" runat="server" Text="0.00"
                                        meta:resourceKey="txtTaxResource1"></asp:TextBox>
                                    <asp:HiddenField ID="hdnTaxAmount" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdfTax" runat="server" />
                                    <div id="dvTaxDetails" align="left" runat="server">
                                    </div>
                                </td>
                                <td id="Td34" runat="server">
                                    <asp:Label ID="lblRoundOffAmt" runat="server"><%=Resources.CommonControls_ClientDisplay.CommonControls_BillingPart_ascx_21 %></asp:Label>
                                </td>
                                <td id="Td35" class="a-left" runat="server">
                                    <asp:TextBox CssClass="small a-right" ID="txtRoundoffAmt" Enabled="true" runat="server"
                                        Text="0.00" meta:resourceKey="txtRoundoffAmtResource1" />
                                    <asp:HiddenField ID="hdnRoundOff" runat="server" Value="0" />
                                </td>
                                <td id="trNetValue" runat="server">
                                    <asp:Label ID="lblNetValue" runat="server">
                                            Net Amount
                                    </asp:Label>
                                </td>
                                <td id="Td37" class="a-left" runat="server">
                                    <asp:TextBox CssClass="small a-right" ID="txtNetAmount" Enabled="true" runat="server"
                                        Text="0.00" meta:resourceKey="txtNetAmountResource1" />
                                    <asp:HiddenField ID="hdnNetAmount" runat="server" Value="0" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <table class="w-100p">
                <tr>
                    <td class="a-center">
                        <asp:Button ID="btnFinish" runat="server" ToolTip="Click here to Generate Quotation"
                            OnClick="btnFinish_Click" Style="cursor: pointer;" CssClass="btn" Text="Generate Quotation"
                            OnClientClick="javascript: return ValidateQuotationEvents('After');"/>
                        &nbsp;
                        <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Width="70px"
                            CssClass="btn" Text="Clear"  />
                    </td>
                </tr>
                <tr>
                    <td class="a-center">
                        &nbsp;
                    </td>
                </tr>
            </table>
            <asp:Panel ID="PopupBill" runat="server" Height="95%" ScrollBars="Vertical" CssClass="modalPopup dataheaderPopup w-65p"
            Enabled="True">
                <table id="tblBill" runat="server" class="w-100p">
                    <tr>
                        <td>
                            <rsweb:ReportViewer ID="rReportViewer" runat="server" ProcessingMode="Remote" Font-Names="Verdana"
                                Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt">
                                <ServerReport ReportServerUrl="" />
                            </rsweb:ReportViewer>
                        </td>
                    </tr>
                    <tr class="a-center">
                        <td class="a-center">
                            <asp:Button ID="BillClose" runat="server" CssClass="a-center" Text="Close" OnClientClick="return Closepopup();" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <ajc:ModalPopupExtender ID="ModalPopupExtenderBill" runat="server" BackgroundCssClass="modalBackground"
                PopupControlID="PopupBill" Enabled="True" TargetControlID="btnDummy1" DynamicServicePath="">
            </ajc:ModalPopupExtender>
            <input type="button" id="btnDummy1" runat="server" style="display: none;" />
        </div>
    </div>
    <input id="hndLocationID" type="hidden" value="0" runat="server" />
    <input type="hidden" runat="server" value="N" id="hdnIsSlabDiscount" />
    <input id="hdnOrgID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientDetails" type="hidden" value="0" runat="server" />
    <input id="hdnID" type="hidden" runat="server" />
    <input id="hdnTempID" type="hidden" runat="server" />
    <input id="hdnTempName" type="hidden" runat="server" />
    <input id="hdnTestQuotationList" type="hidden" value="" runat="server" />
    <input id="hdnFeeType" type="hidden" runat="server" />
    <input id="hdnAmount" type="hidden" runat="server" />
    <input id="hdnName" type="hidden" runat="server" />
    <input id="hdnPatientID" type="hidden" value="-1" runat="server" />
    <input id="hdnAppendTest" type="hidden" runat="server" />
    <input id="hdnFeeTypeSelected" type="hidden" runat="server" value="COM" />
    <input type="hidden" runat="server" value="0" id="hdnInvCode" />
    <input type="hidden" runat="server" value="N" id="hdnIsOutSource" />
    <input type="hidden" runat="server" value="N" id="hdnoutsourcelocation" />
    <input id="hdnDefaultCountryID" type="hidden" value="0" runat="server" />
    <input id="hdnTestHistory" type="hidden" value="" runat="server" />
    <input id="hdnIsExpired" type="hidden" value="" runat="server" />
    <input id="hdnSelectedQuotationNo" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedQuotationID" type="hidden" value="0" runat="server" />
    <input id="hdnDefaultStateID" type="hidden" value="0" runat="server" />
    <input id="hdnSelectedClientClientID" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnOrdereditems" runat="server" />
    <asp:HiddenField ID="hdnMasterPKGTest" runat="server" Value="" />
    <input id="hdnDiscountApprovedBy" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnIsCollected" Value="N" runat="server" />
    <input type="hidden" runat="server" id="hdnDefaultRoundoff" />
    <input type="hidden" runat="server" id="hdnRoundOffType" />
    <input id="hdnPatientStateID" type="hidden" value="0" runat="server" />
    <input id="hdnPatientStateID1" type="hidden" value="0" runat="server" />
    <asp:HiddenField ID="hdnCollectedDateTime" Value="01/01/1900" runat="server" />
    <asp:HiddenField ID="hdnLocName" runat="server" />
    <asp:HiddenField ID="hdnPopupSampleCount" runat="server" />
    <asp:HiddenField ID="hdnDefaultAmount" runat="server" Value="0" />
    <asp:HiddenField ID="hdnPKGTest" runat="server" />
    <asp:HiddenField ID="hdnPKGList" runat="server" Value="" />
    <asp:HiddenField ID="hdnPKGUpdateList" runat="server" Value="" />
    <asp:HiddenField ID="hdnDiscountAmt" runat="server" Value="0" />
    <asp:HiddenField ID="hdnTotalDiscount" runat="server" />
    <asp:HiddenField ID="hdnDiscountPercent" runat="server" />
     <asp:HiddenField ID="hdnDiscountTypePopup" runat="server" />
     <asp:HiddenField ID="hdnDiscountValuePopup" runat="server" />
    <asp:HiddenField ID="hdnPopupAmt" runat="server" value="0" />
    <asp:HiddenField ID="hdnPopupMasterAmt" runat="server" value="0" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnTempTest" runat="server" Value="" />
     <asp:HiddenField ID="hdnPopUpDiscountAmt" runat="server" Value="" />
    <asp:HiddenField ID="hdnPendingQuotation" runat="server" Value="" />
    <asp:HiddenField ID="hdnCurrentDate" runat="server" Value="" />
    <asp:HiddenField ID="hdnFutureDate" runat="server" Value="" />
    <asp:HiddenField ID="hdnTestChckdDetails" runat="server" Value="" />
    <asp:HiddenField ID="hdnChckedMasterTest" runat="server" Value="" />
    <asp:HiddenField ID="hdnPopupTestID" runat="server" Value="" />
    <asp:HiddenField ID="hdnPopupFinalAmt" runat="server" Value="0" />
    <asp:HiddenField ID="hdnPopupFinalDiscountAmt" runat="server" Value="0" />
    <asp:HiddenField ID="hdnLoadNewTestID" runat="server" Value="" />
    <asp:HiddenField ID="hdnPKGMasterUpdatelist" runat="server" Value="" />
    <asp:HiddenField ID="hdnNewAmount" runat="server" Value="" />
    <asp:HiddenField ID="hdnLoadPkgID" runat="server" Value="" />
    
    <asp:HiddenField ID="hdnPopUpPkgID" runat="server" Value="" />
    <asp:HiddenField ID="hdnRegPageType" runat="server" Value="" />
    <input id="hdnClientID" type="hidden" runat="server" value="" />
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
<script src="../Scripts/jquery.MultiFile.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(function() {
            $("#txtValidityPeriod").datepicker({
                dateFormat: 'dd/mm/yy',
                defaultDate: "+1w",
                changeMonth: true,
                changeYear: true,
                showOn: "both",
                buttonImage: "../images/Calendar_scheduleHS.png",
                buttonImageOnly: true,
                minDate: 0,
                yearRange: '1900:2100',
                onClose: function(selectedDate) {
                    // $("#txtTo").datepicker("option", "minDate", selectedDate);

                    var date = $("#txtValidityPeriod").datepicker('getDate');
                    //var d = new Date(date.getFullYear(), date.getMonth() + 1, 0);
                    // $("#txtTo").datepicker("option", "maxDate", d);

                }
            });
        });
        $(function() {
            $('#chkSameAddress').click(function() {
                if ($(this).prop("checked") == false) {
                    $("#trSameBIllingAddrOne").attr("style", "display:table-row");
                    $("#trSameBIllingAddrTwo").attr("style", "display:table-row");
                    $('#txtAddress1').val("");
                    $('#txtSuburb1').val("");
                    $('#txtCity1').val("");
                    $('#txtPincode1').val("");

                }
                else if ($(this).prop("checked") == true) {
                    $("#trSameBIllingAddrOne").attr("style", "display:none");
                    $("#trSameBIllingAddrTwo").attr("style", "display:none");
                    $('#txtAddress1').val($('#txtAddress').val());
                    $('#txtSuburb1').val($('#txtSuburb').val());
                    $('#txtCity1').val($('#txtCity').val());

                    $('#txtPincode1').val($('#txtPincode').val());
                }
            });
        });


        $(function() {
            $('#chkFoc').click(function() {
                if ($(this).prop("checked") == false) {
                    $("#txtTax").prop('disabled', false);
                    $("#ddDiscountPercent").prop('disabled', false);
                    $("#ddlDiscountReason").prop('disabled', false);
                    $("#txtAuthorised").prop('disabled', false);
                    $("#ddlTaxPercent").prop('disabled', false);
                    $("#txtGross").prop('disabled', false);
                    $("#txtTax").prop('disabled', false);
                    $("#txtRoundoffAmt").prop('disabled', false);
                    $("#txtNetAmount").prop('disabled', false);
                    $("#txtFoc").prop('disabled', true);
                }
                else if ($(this).prop("checked") == true) {
                    $("#txtFoc").prop('disabled', false);
                    $("#txtTax").prop('disabled', true);
                    $("#ddDiscountPercent").prop('disabled', true);
                    $("#ddlDiscountReason").prop('disabled', true);
                    $("#txtAuthorised").prop('disabled', true);
                    $("#ddlTaxPercent").prop('disabled', true);
                    $("#txtGross").prop('disabled', true);
                    $("#txtTax").prop('disabled', true);
                    $("#txtRoundoffAmt").prop('disabled', true);
                    $("#txtNetAmount").prop('disabled', true);


                }
            });
        });


        function CheckMobileSMS() {
            // var elements = document.getElementById('chkDespatchMode');
            if (document.getElementById('txtMobileNo').value != '') {
                document.getElementById('chkSMS').checked = true;

            }
            else {
                document.getElementById('chkSMS').checked = false;
            }

        }

        function CheckEmailSend() {

            if (document.getElementById('txtEmailID').value != '') {
                document.getElementById('chkEmail').checked = true;

            }
            else {
                document.getElementById('chkEmail').checked = false;

            }


        }

        function Closepopup() {
            $find('ModalPopupExtenderBill').hide();
            
            return false;

        }

    </script>

</body>
</html>
