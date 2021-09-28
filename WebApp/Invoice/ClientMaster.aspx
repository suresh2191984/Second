<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClientMaster.aspx.cs" Inherits="Lab_InvocieMaster"
    EnableEventValidation="false" meta:resourcekey="PageResource1" MaintainScrollPositionOnPostback="true" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader" TagPrefix="uc3" %>
<%@ Register Src="../CommonControls/OrderedSamples.ascx" TagName="OrderedSamples"
    TagPrefix="uc5" %>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>

   

    <script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>
    
     <script src="../Scripts/animatedcollapse.js" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>

    <script src="../scripts/MessageHandler.js" language="javascript" type="text/javascript"></script>

    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>
    <link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <%--    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            $('INPUT[type="text"]').focus(function() {
                $(this).addClass("focus");
            });
            $('INPUT[type="text"]').blur(function() {
                $(this).removeClass("focus");
            });
            $('INPUT[type="checkbox"]').focus(function() {
                $(this).addClass("chkfocus");
            });
            $('INPUT[type="checkbox"]').blur(function() {
                $(this).removeClass("chkfocus");
            });
            $('#txtaddres1').focus(function() {
                $(this).addClass("focus");
            });
            $('#txtaddres1').blur(function() {
                $(this).removeClass("focus");
            });
        });
    </script>--%>
    <style type="text/css">
        .AutoCompletesearchBox1
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 130px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px!important;
        }
        .Txtboxsmall1
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
        }
        #pnlAttribs #Div2, #pnlAttribs #Div1 
        {
            height:auto;
        }
    </style>

    <script type="text/javascript" language="javascript">
	
	function blockSpecialChar(e) {

            var k = e.keyCode;
            if ((e.keyCode == 47) || (e.keyCode == 92) || (e.keyCode == 58) || (e.keyCode == 42) || (e.keyCode == 34) || (e.keyCode == 62) || (e.keyCode == 60) || (e.keyCode == 124) || (e.keyCode == 63)) {
            alert('The File Name Cant contain the Special Characters');  
                return false;
            } 
            
        }
		
        function ValidateUpload(id) {
            // alert(id);
            var Upload_Image = document.getElementById(id);
            var myfile = Upload_Image.value;
            //alert(Upload_Image.value);
            if (myfile.indexOf("jpg") > 0 || myfile.indexOf("jpeg") > 0) {

            }
            else {
                alert('The file given for upload is not valid');
                return false;
            }

        }
        var userMsg;
        function loadState() {
            $("select[id$=drpState] > option").remove();
            $.ajax({
                type: "POST",
                url: "../OPIPBilling.asmx/GetStateByCountry",
                data: "{ 'CountryID': '" + parseInt(document.getElementById('drpCountry').value) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    var Items = data.d;

                    $('#drpState').attr("disabled", false);
                    $('#drpState').append('<option value="-1">--Select--</option>');
                    $.each(Items, function(index, Item) {
                        $('#drpState').append('<option value="' + Item.StateID + '">' + Item.StateName + '</option>');
                        document.getElementById('lblCountryCode').innerHTML = "+" + Item.ISDCode;
                    });
                    if (document.getElementById('hdnStateID').value > 0) {
                        $('#drpState').val(document.getElementById('hdnStateID').value);
                    }
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }
        function onchangeState() {
            $('#hdnStateID').val(document.getElementById('drpState').value);
        }


        function SelectedClientValue(source, eventArgs) {
            var TextSuspend = SListForAppMsg.Get("Invoice_ClientMaster_aspx_001") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_001") : "Suspended";
            var TextTerminate = SListForAppMsg.Get("Invoice_ClientMaster_aspx_003") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_003") : "Terminated";
            var TextDunned = SListForAppMsg.Get("Invoice_ClientMaster_aspx_004") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_004") : "Dunned";
            var TextAppend1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_005") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_005") : "Selected Parent Client was";
            var TextAppend2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_006") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_006") : ". You cannnot able to edit the Client Status";


            document.getElementById('txtparentClient').value = eventArgs.get_text();
            var ClientDetails = eventArgs.get_value().split('^');
            document.getElementById('hdnParentClientID').value = ClientDetails[0].split('~')[0];
            document.getElementById('tdReasonBlock').disabled = false;
            document.getElementById('tdBlockDate').disabled = false;
            document.getElementById('tdClientSt').disabled = false;
            document.getElementById('lblReasonTxt').innerText = '';
            document.getElementById('tdReasonBlock').style.display = 'none';
            document.getElementById('tdBlockDate').style.display = 'none';
            document.getElementById('ddlClientStatus').value = "0";
            document.getElementById('ddlClientStatus').value = ClientDetails[0].split('~')[1];
            if (ClientDetails[0].split('~')[1] != 'A') {
                var stTxt = '';
                if (ClientDetails[0].split('~')[1] == 'S')
                //stTxt = 'Suspended';
                    stTxt = TextSuspend;
                if (ClientDetails[0].split('~')[1] == 'T')
                //stTxt = 'Terminated';
                    stTxt = TextTerminate;
                if (ClientDetails[0].split('~')[1] == 'D')
                //stTxt = 'Dunned';
                    stTxt = TextDunned;
                var Reason = TextAppend1 + stTxt + TextAppend2;
                //var Reason = 'Selected Parent Client was ' + stTxt + '. You cannnot able to edit the Client Status';
                document.getElementById('lblReasonTxt').innerText = Reason;
                document.getElementById('tdClientSt').disabled = true;
                document.getElementById('tdReasonBlock').disabled = true;
                document.getElementById('tdReasonBlock').style.display = 'table-cell';
                document.getElementById('drpReason').value = ClientDetails[0].split('~')[2];
            }
            if (ClientDetails[0].split('~')[1] == 'S') {
                document.getElementById('tdReasonBlock').disabled = true;
                document.getElementById('tdBlockDate').disabled = true;
                document.getElementById('tdBlockDate').style.display = 'table-cell';
                document.getElementById('txtFDate').value = ClientDetails[0].split('~')[3];
                document.getElementById('txtTDate').value = ClientDetails[0].split('~')[4];
            }
        }
        function Onzoneselected(source, eventArgs) {
            document.getElementById('txtzone').value = eventArgs.get_text();
            document.getElementById('hdntxtzoneID').value = eventArgs.get_value();
            if (document.getElementById('hdntxtzoneID').value != "0") {
                $find('AutoCompleteExtender12').set_contextKey('route' + '~' + document.getElementById('hdntxtzoneID').value);
            }
            else {
                $find('AutoCompleteExtender12').set_contextKey('');
            }
        }

        function Onrouteselected(source, eventArgs) {
            document.getElementById('txtRouteName').value = eventArgs.get_text();
            document.getElementById('hdntxtrouteID').value = eventArgs.get_value();
        }

        function OnCollectioncenterselected(source, eventArgs) {
            document.getElementById('txtcollectioncenter').value = eventArgs.get_text();
            document.getElementById('hdncollectioncenterid').value = eventArgs.get_value();
        }
        function GetEmpID(source, eventArgs) {
            var strVal = eventArgs.get_value();
            document.getElementById('txtPersonName').value = eventArgs.get_text();
            document.getElementById('hdnEmpID').value = strVal.split('~')[0].trim();
            document.getElementById('txtPrsnMobile').value = strVal.split('~')[1].trim();
            document.getElementById('txtPrsnLandNo').value = strVal.split('~')[2].trim();
            document.getElementById('txtPrsnEmail').value = strVal.split('~')[3].trim();
        }
        function GetTodID(source, eventArgs) {
            document.getElementById('txtTODCode').value = eventArgs.get_text();
            document.getElementById('hdnTodID').value = eventArgs.get_value();
        }
        function GetToVolID(source, eventArgs) {
            document.getElementById('txtvolume').value = eventArgs.get_text();
            document.getElementById('hdnVolID').value = eventArgs.get_value();
        }





        function GetPolicyID(source, eventArgs) {
            $('[id$="txtPolicyName"]').val(eventArgs.get_text());
            $('[id$="hdnPolicyID"]').val(eventArgs.get_value());
        }




        function GetTaxID(source, eventArgs) {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_01") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_01") : "This Tax was already added";

            document.getElementById('txtTaxName').value = eventArgs.get_text();
            var checkTaxID = eventArgs.get_value();
            if (document.getElementById('hdnTaxValue').value != '') {
                var items = document.getElementById('hdnTaxValue').value.split('^');
                for (var x = 0; x < items.length; x++) {
                    if (items[x] != '') {
                        if (items[x].split('~')[1] == checkTaxID) {
                            //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_1');
                            if (UsrAlrtMsg != null) {
                                //alert(userMsg);
                                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                                return false;
                            }
                            else {
                                //alert('This Tax was already added');
                                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                                return false;
                            }
                            document.getElementById('txtTaxName').value = '';
                            document.getElementById('txtTaxName').focus();
                            return false;
                        }
                    }
                }
            }
            document.getElementById('hdnTaxValue').value += eventArgs.get_text() + '~' + eventArgs.get_value() + '^';
            AddTax();
        }
        function AddTax() {
            var TextAppendTag = SListForAppMsg.Get("Invoice_ClientMaster_aspx_007") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_007") : "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;'><TBODY><tr class='dataheader1'><th scope='col' align='center' width='5%'";
            var TextAction = "<%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_008%>";
            var TextAppendTag1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_009") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_009") : "</th><th scope='col' align='center' width='20%'>";
            var TextAppendTag2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_010") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_010") : "Tax Name";
            var TextAppendTag3 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_011") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_011") : "</th>";
            if (document.getElementById('hdnTaxValue').value != '') {
                document.getElementById('<%=divTax.ClientID %>').innerHTML = '';
                var startTag, bodytag, endtag;
                var taxValue = document.getElementById('hdnTaxValue').value.split('^');
                startTag = TextAppendTag + TextAction + TextAppendTag1 + TextAppendTag2 + TextAppendTag3;
                //startTag = "<TABLE ID='tabDrg1' Cellpadding='1' Cellspacing='1' width='100%' class='dataheaderInvCtrl' style='font-size: 11px;'><TBODY><tr class='dataheader1'><th scope='col' align='center' width='5%'>" + "<%=Resources.ClientSideDisplayTexts.Invoice_ClientMaster_Action%>" + "</th><th scope='col' align='center' width='20%'> " + "<%=Resources.ClientSideDisplayTexts.Invoice_ClientMaster_TaxName %>" + " </th>";
                endtag = "</TBODY></TABLE>";
                bodytag = startTag;
                for (var j = 0; j < taxValue.length; j++) {
                    if (taxValue[j] != '') {
                        bodytag += "<tr><td><img id='imgbtn' name='" + taxValue[j] + "' style='cursor:pointer;' onClick='DeleteTax(name)' src='../Images/Delete.jpg' /></td>";
                        bodytag += "<td>" + taxValue[j].split('~')[0] + "</td></tr>";
                    }
                }
                bodytag += endtag;
                document.getElementById('<%=divTax.ClientID %>').innerHTML = bodytag;
                document.getElementById('txtTaxName').value = '';
            }
        }
        function DeleteTax(DeleteItem) {
            if (DeleteItem != '') {
                var existItem = document.getElementById('hdnTaxValue').value.split('^');
                var newItems = '';
                document.getElementById('hdnTaxValue').value = '';
                for (var k = 0; k < existItem.length; k++) {
                    if (existItem[k] != '') {
                        if (existItem[k].split('~')[1] != DeleteItem.split('~')[1]) {
                            newItems += existItem[k] + '^';
                        }
                    }
                }
                if (newItems != '') {
                    document.getElementById('hdnTaxValue').value = newItems;
                    AddTax();
                }
                else {
                    document.getElementById('<%=divTax.ClientID %>').innerHTML = '';
                }
            }
        }
        function viewParentrow() {
            if (document.getElementById('chkparentlcient').checked) {
                document.getElementById('viewparent').style.display = 'block';
            }
            else {
                document.getElementById('viewparent').style.display = 'none';
            }

        }
        //        function isNumericss(e, Id) {

        //            var key; var isCtrl; var flag = 0;
        //            var txtVal = document.getElementById(Id).value.trim();
        //            var len = txtVal.split('.');
        //            if (len.length > 1) {
        //                flag = 1;
        //            }
        //            if (window.event) {
        //                key = window.event.keyCode;
        //                if (window.event.shiftKey) {
        //                    isCtrl = false;
        //                }
        //                else {
        //                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
        //                        isCtrl = true;
        //                    }
        //                    else {
        //                        isCtrl = false;
        //                    }
        //                }
        //            } return isCtrl;
        //        }

        //Only numbers will allowed
        function isNumeric(e, Id) {
            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 0) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey) {
                    isCtrl = true;
                }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 188) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
        //only text allowed
        function vaddress(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key != 36) && (key != 126)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        var EditorInstance = "";
        function isSpclChar(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32) || (key == 44) || (key == 45) || (key == 46) || (key == 95) || (key == 37) || (key == 36)) {
                isCtrl = true;
            }

            return isCtrl;
        }


        function CheckCodes(codeType, TextBoxID) 
        {
           

            var ClientTypeID = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].value;
            var ClientTypeName = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].innerText;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_02") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_02") : "Enter the ClientCode";

//            if (ClientTypeName == "Referring Hospital" || ClientTypeName == "Referring Physician" || ClientTypeName == "Hospital") {
                if (document.getElementById('txtClientName').value.trim() != '') 
                {
                    var txtValue = document.getElementById(TextBoxID).value.trim();
                    if (txtValue != '') 
                    {
                        WebService.GetCheckCode(codeType, txtValue, onCheckCounts);
                    } //andews
//                    else {
//                    
//                        userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_13');
//                        if (userMsg != null) {
//                            alert(userMsg);
 //ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
//                            return false;
//                        }
//                        else {
//                            alert('Enter the ClientCode');
//ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
//                            return false;
//                        } //andrews
                    }
                }
//            }
      //  }


        function CheckClientName(codeType, TxtID) 
        {
            var txtValue = document.getElementById(TxtID).value.trim();
            var ClientTypeID = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].value;
            var ClientTypeName = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].innerText;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_03") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_03") : "Select the ClientName From List";

            if (ClientTypeName == "Referring Hospital" || ClientTypeName == "Referring Physician" || ClientTypeName == "Hospital") {
                if (document.getElementById('txtClientName').value != '') {
                    if (document.getElementById('hdnHosOrRefID').value == '') {
                        //alert('Select the ClientName From List');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        document.getElementById('txtClientName').value = '';
                        document.getElementById('txtClientName').focus();
                        return false;
                    }
                }
                else {
                    // alert('Select Client Name');
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                }
            }
            if (txtValue != '') {

                WebService.GetCheckCode(codeType, txtValue, onCheckClientName);


            }
            //            else {
            //                userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_12');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                }
            //                else {
            //                    alert('Enter the Client Name');
            //                    return false;
            //                }
            //            }
        }
        function CheckServiceTaxNo(codeType, TxtID) {
            var txtValue = document.getElementById(TxtID).value;
            if (txtValue != '')
                WebService.GetCheckCode(codeType, txtValue, onCheckServiceTaxNo);
        }
        function checkMailId() {
            var emailID = document.getElementById('txtEmailID')
            if ((emailID.value == null) || (emailID.value.trim() != "")) {
                if (echecks(emailID.value) == false) {
                    emailID.value = ""
                    emailID.focus()
                    return false
                }
            }
            return true
        }
        function evalid(str) {
            var reg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,10})$/;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") : "Invalid E-Mail ID";
            if (reg.test(str) == false) {
                document.getElementById('txtEmailID').value = "";
                document.getElementById('txtEmailID').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_2');
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    document.getElementById('txtEmailID').value = "";
                    return false;
                }
                else {
                    //alert('Invalid E-Mail ID');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    document.getElementById('txtEmailID').value = "";
                    return false;
                }
            }
        }
        function echecks(str) {
            var flag = 0;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") : "Invalid E-Mail ID";

            if (str.split(",")[0] != "") {
                var s = str.split(",");
                for (var i = 0; i < s.length; i++) {
                    if (s[i] != "") {
                        if (checkits(s[i])) {
                            evalid(s[i]);
                            flag = 0;
                        }
                        else {
                        }
                    }
                }
            }
            else {
                if (checkits(str)) {
                    flag = 0;
                }
                else {
                    flag = 1;
                }
            }
            if (flag == 0) {
                return true;
            }
            else {
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_2');
                if (UsrAlrtMsg != null) {
                    // alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Invalid E-Mail ID');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    document.getElementById('txtEmailID').value = "";
                    return false;
                }
            }


        }
        function checkits(str) {
            var at = "@"
            var dot = "."
            var lat = str.indexOf(at)
            var lstr = str.length
            var ldot = str.indexOf(dot)
            if (str.indexOf(at) == -1) {
                //                alert('Invalid e-mail ID');
                return false
            }

            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
                //                alert('Invalid e-mail ID');
                return false
            }

            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
                //                alert('Invalid e-mail ID');
                return false
            }

            if (str.indexOf(at, (lat + 1)) != -1) {
                //                alert('Invalid e-mail ID');
                return false
            }

            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
                //                alert('Invalid e-mail ID');
                return false
            }

            if (str.indexOf(dot, (lat + 2)) == -1) {
                //                alert('Invalid e-mail ID');
                return false
            }

            if (str.indexOf(" ") != -1) {
                //                alert('Invalid e-mail ID');
                return false
            }

            return true
        }



        function onCheckCounts(count) 
        {
            if (count != '') {

                document.getElementById('hdnCheckCode').value = count;
                   //andrews
                if (count > 0) {
                    alert('The Client code already exists.Please enter new client name');
                    document.getElementById('txtClientCode').value = '';
                    document.getElementById('txtClientCode').focus();
                    return false;
                }
                //  andrews
              }
            else 
            {
                document.getElementById('hdnCheckCode').value = '0';
            }
        }
        function onCheckClientName(count) {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_05") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_05") : "The Client name already exists.Please enter new client name";

            if (count != '') {
                if (count > 0) {
                    //UsrAlrtMsg1 = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_3');
                    if (UsrAlrtMsg1 != null) {
                        // alert(userMsg);
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        document.getElementById('txtClientName').value = '';
                        document.getElementById('txtClientName').focus();
                        //andrews
                        return false;
                    }
                    else {
                        //alert('The Client name already exists.Please enter new client name');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        document.getElementById('txtClientName').value = '';
                        document.getElementById('txtClientName').focus();
                        //andrews
                        return false;
                    }
                    document.getElementById('txtClientName').value = '';
                    document.getElementById('txtClientName').focus();
                }
            }
        }

        function onCheckServiceTaxNo(count) {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_06") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_06") : "The Service Tax No already exists.Please enter new Service Tax No.";

            if (count != '') {
                if (count > 0) {
                    // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_4');
                    if (UsrAlrtMsg2 != null) {
                        //   alert(userMsg);
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);

                        return false;
                    }
                    else {
                        //alert('The Service Tax No already exists.Please enter new Service Tax No.');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);

                        return false;
                    }
                    document.getElementById('txtServiceTaxNo').value = '';
                    document.getElementById('txtServiceTaxNo').focus();
                }
            }
        }
        function clientname() {
            //            if (document.getElementById('txtClientName').value == "") {
            //                document.getElementById('txtClientName').value = "";
            //                alert("Enter Client Name");
            //                return false;
            //            }
            //            else {
            //                return true;
            //            }
            //
        }
        function mobilevalid() {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_07") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_07") : "Mobile No. should be 10 digit";

            if (document.getElementById('txtmobileno').value != "") {
                var str = document.getElementById('txtmobileno').value;
                if (str.split(",")[0] != "") {
                    var s = str.split(",");
                    for (var i = 0; i < s.length; i++) {
                        if (s[i] != "") {
                            if (s[i].length > 10 || s[i].length < 10) {
                                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_5');
                                if (UsrAlrtMsg3 != null) {
                                    //alert(userMsg);
                                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                                    return false;
                                }
                                else {
                                    // alert("Mobile No. should be 10 digit");
                                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                                    return false;
                                }
                                document.getElementById('txtmobileno').focus();
                                document.getElementById('txtmobileno').value = "";
                                return false;
                            }

                        }
                    }
                }
            }
        }

        function vaddressWithTenDigit(e) {
            var key;
            var isCtrl = false;

            if (window.event) // IE8 and earlier
            {
                key = e.keyCode;
            }
            else if (e.which) // IE9/Firefox/Chrome/Opera/Safari
            {
                key = e.which;
            }

            if ((key != 36) && (key != 126)) {
                isCtrl = true;
            }
            if (isCtrl) {
                isCtrl = TenDigitvalid();
            }
            return isCtrl;
        }

        function TenDigitvalid() {
            if (document.getElementById('txtClientCode').value != "") {
                var str = document.getElementById('txtClientCode').value;
                if (str.split(",")[0] != "") {
                    var s = str.split(",");
                    for (var i = 0; i < s.length; i++) {
                        if (s[i] != "") {
                            if (s[i].length > 9) {
                                //alert("Client Code should be 10 digit");
                                ///document.getElementById('txtClientCode').focus();
                                // document.getElementById('txtClientCode').value = "";
                                return false;
                            }
                            else {
                                return true;
                            }

                        }
                    }
                }
            }
            return true;
        }
        function checkAddressDetails() {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg4 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_08") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_08") : "Select the addres type";
            var UsrAlrtMsg5 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_09") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_09") : "Enter the address";
            if (document.getElementById('drpaddresstype').value == "0" || document.getElementById('drpaddresstype').value == "") {
                document.getElementById('drpaddresstype').value = "0";
                document.getElementById('drpaddresstype').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_6');
                if (UsrAlrtMsg4 != null) {
                    //  alert(userMsg);
                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Select the addres type");
                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                    return false;
                }
            }
            if (document.getElementById('txtaddres1').value == "") {
                document.getElementById('txtaddres1').value = "";
                document.getElementById('txtaddres1').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_7');
                if (UsrAlrtMsg5 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert("Enter the address");
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    return false;
                }
            }

            if (document.getElementById('txtEmailID').value == '') {
                var checkMail = CheckDespatchMode('Invoice Email');
                var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
                var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_10") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_10") : "In Despatch Mode,you have selected Email. So,Please give the Email-ID";
                var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_11") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_11") : "In Despatch Mode,you have selected Sms. So,Please give the Mobile Number";

                if (checkMail == true) {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_8');
                    if (UsrAlrtMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);

                        return false;
                    }
                    else {
                        //alert('In Despatch Mode,you have selected Email. So,Please give the Email-ID');
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                        return false;
                    }
                    document.getElementById('txtEmailID').focus();
                    return false;
                }
            }
            if (document.getElementById('txtmobileno').value == '') {
                var checkSms = CheckDespatchMode('Invoice Sms');
                if (checkSms == true) {
                    // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_9');
                    if (UsrAlrtMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('In Despatch Mode,you have selected Sms. So,Please give the Mobile Number');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                        return false;
                    }
                    document.getElementById('txtmobileno').focus();
                    return false;
                }
            }
            checkMailId();
            //            if (document.getElementById('txtEmailID').value == "") {
            //                document.getElementById('txtEmailID').value = "";
            //                document.getElementById('txtEmailID').focus();
            //                alert("Enter txtEmailID");
            //                return false;
            //            }
            //            if (document.getElementById('txtPhoneNumber').value == "" && document.getElementById('txtmobileno').value == "") {
            //                alert('Provide at least one contact number');
            //                document.getElementById('txtPhoneNumber').focus();
            //                return false;
            //            }

            //            var pList = document.getElementById('hdnAddressDetails').value.split("^");
            //            if (pList == "") {
            //                alert("Enter the Address Details");
            //                return false;
            //            }
            //            var flag = 0;
            //            var pList = document.getElementById('hdnAddressDetails').value.split("^");
            //            if (pList != "") {

            //                for (s = 0; s < pList.length; s++) {
            //                    if (pList[s] != "") {
            //                        y = pList[s].split('|');
            //                        if (y[7] == "Y") {
            //                            flag = 1;
            //                        }
            //                    }
            //                }
            //                if (flag != 0) {
            //                    alert("Give One Communication Address");
            //                    return false;
            //                }
            //            }
            return true;
        }
        function EnableMadatory() {
            var checkMail = CheckDespatchMode('Invoice Email');
            var checkSMS = CheckDespatchMode('Invoice Sms');
            if (checkMail == true) {
                document.getElementById('starimgEmail').style.display = "block";
            }
            else {
                document.getElementById('starimgEmail').style.display = "none";
            }
        }
        function CheckDespatchMode(objName) {
            var checkboxCollection = document.getElementById('chkDespatch').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
                    if (checkboxCollection[i].checked == true && checkboxCollection[i].parentElement.getElementsByTagName('label')[0].innerHTML == objName) {
                        return true;
                    }
                }
            }
        }

        function ReportPrintChanged(a) {
            //Added By Arivalagan K ===== This is checking only for print report chechk box checked or not uses for RPT FROM DATE//

            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_12") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_12") : "Please enter the report print from date";
            var chkNotificationCollection = document.getElementById('chkNotification').getElementsByTagName('input');
            for (var i = 0; i < chkNotificationCollection.length; i++) {
                if (chkNotificationCollection[i].type.toString().toLowerCase() == "checkbox" && chkNotificationCollection[i].parentElement.getElementsByTagName('label')[0].innerHTML == 'Report Print') { 
                    if (chkNotificationCollection[i].checked == true ) { 
                        document.getElementById('ReportPrintFrom').style.display = 'table-row';
                        if (document.getElementById('TxtRptPrintFrom').value == "") {
                            if (a == 'N') {
                                //alert('Please enter the report print from date');
                                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                                DisplayTab('NOT');
                                document.getElementById('TxtRptPrintFrom').focus();
                                return false;
                            }

                        }
                        break;
                    }
                    else { 
                        document.getElementById('ReportPrintFrom').style.display = 'none';
                        document.getElementById('TxtRptPrintFrom').value = '';
                     }
                }
            }
            //Added By Arivalagan K ===END=== RPT FROM DATE//
        }
        function checkisempty() {
            /// debugger;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_13") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_13") : "Select Client Type";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_14") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_14") : "Enter Client Name";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_15") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_15") : "Enter Client Code";
            var UsrAlrtMsg4 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_16") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_16") : "Client code already exists.Enter a new code";
            var UsrAlrtMsg5 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_17") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_17") : "General Client Already added";
            var UsrAlrtMsg6 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_18") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_18") : "Kindly provide  Reason";
            var UsrAlrtMsg7 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_19") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_19") : "Select Business Type";
            var UsrAlrtMsg8 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_20") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_20") : "Please seletect the role to asign the task for Invoice Approval";
            var UsrAlrtMsg9 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_21") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_21") : "Please give the reason";
            var UsrAlrtMsg10 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_22") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_22") : "Enter Parent Client";
            var UsrAlrtMsg11 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_23") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_23") : "Please select the resaon";
            var UsrAlrtMsg12 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_24") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_24") : "Please select the Authorization person";
            var UsrAlrtMsg13 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_25") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_25") : "Please select block from date";
            var UsrAlrtMsg14 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_26") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_26") : "Please select valid Year";
            var UsrAlrtMsg15 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_27") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_27") : "Please select valid Month";
            var UsrAlrtMsg16 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_28") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_28") : "Please select valid Day";
            var UsrAlrtMsg17 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_29") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_29") : "Enter the Shipping Information";
            var UsrAlrtMsg18 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_30") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_30") : "Give a primary address";
            var UsrAlrtMsg19 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_31") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_31") : "This action will block all associated clients. Are you sure you want to proceed?";
            
            
            
            
            
            
            var chkNotificationCollection = document.getElementById('chkNotification').getElementsByTagName('input');
            for (var i = 0; i < chkNotificationCollection.length; i++) {
                if (chkNotificationCollection[i].type.toString().toLowerCase() == "checkbox") {
                    if (chkNotificationCollection[i].checked == true && chkNotificationCollection[i].parentElement.getElementsByTagName('label')[0].innerHTML == 'Report Print') {
                        if (document.getElementById('TxtRptPrintFrom').value == "")
                        { ReportPrintChanged('N'); return false; }
                    }
                }
            }
            if (document.getElementById('ddlClientType').value == "0") {
                document.getElementById('ddlClientType').value = "0";
                document.getElementById('ddlClientType').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_11');
                if (UsrAlrtMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);


                    return false;
                }
                else {
                    // alert("Select Client Type");
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);


                    return false;
                }
            }
            else if (document.getElementById('txtClientName').value == "") {
                document.getElementById('txtClientName').value = "";
                document.getElementById('txtClientName').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_12');
                if (UsrAlrtMsg2 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);

                    return false;
                }
                else {
                    // alert("Enter Client Name");
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);

                    return false;
                }
            }
            else if (document.getElementById('txtClientCode').value == "") {
                document.getElementById('txtClientCode').value = "";
                document.getElementById('txtClientCode').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_13');
                if (UsrAlrtMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter Client Code");
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    return false;
                }
            }
            else if (document.getElementById('hdnCheckCode').value > "0") {
                document.getElementById('txtClientCode').focus();
                // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_14');
                if (UsrAlrtMsg4 != null) {
                    // alert(userMsg);
                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert("Client code already exists.Enter a new code");
                    ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
                    return false;
                }
            }

            var s = document.getElementById('hdnclientnames').value;
            if (s.toUpperCase() == document.getElementById('txtClientName').value.toUpperCase()) {
                document.getElementById('txtClientName').value = "";
                document.getElementById('hdnclientnames').value = "";
                document.getElementById('txtClientName').focus();
                //  userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_15');
                if (UsrAlrtMsg5 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("General Client Already added");
                    ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                    return false;
                }
            }
            //------------Commented By Guruanth S
            //            if (document.getElementById('txtContactPersons').value == "") {
            //                document.getElementById('txtContactPersons').value = "";
            //                document.getElementById('txtContactPersons').focus();
            //                alert("Enter Contact Persons");
            //                return false;
            //            }
            //            if (document.getElementById('txtzone').value == "") {
            //                document.getElementById('txtzone').value = "";
            //                document.getElementById('txtzone').focus();
            //                alert("Enter Zone Name");
            //                return false;
            //            }
            if (document.getElementById('ddlReason').value == "0") {
                //alert('Kindly provide  Reason');
                ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                return false;
            }
            if (document.getElementById('drpBusinessType').value == "0") {
                document.getElementById('drpBusinessType').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_16');
                if (UsrAlrtMsg7 != null) {
                    // alert(userMsg);
                    ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Select Business Type");
                    ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
                    return false;
                }
            }
            if (document.getElementById('chkisapproval').checked == true) {
                if (document.getElementById('ddlRole').value == '0') {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_17');
                    if (UsrAlrtMsg8 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg8, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please seletect the role to asign the task for Invoice Approval');
                        ValidationWindow(UsrAlrtMsg8, AlrtWinHdr);
                        return false;
                    }
                }
            }

            if (document.getElementById('imgStarReason').style.display == "block") {
                if (document.getElementById('txtReason').value == "") {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_18');
                    if (UsrAlrtMsg9 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert("Please give the reason");
                        ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
                    }
                    document.getElementById('txtReason').focus();
                    return false;
                }
            }

            // Credit Limit Validation Commented  
            //            if (document.getElementById('Chkiscash').checked == false) {
            //                if (document.getElementById('txtcreditlimit').value == '') {
            //                    alert('Please enter Credit Limit');
            //                    DisplayTab('COM');
            //                    document.getElementById('txtcreditlimit').focus();
            //                    return false;
            //                }
            //                if (document.getElementById('txtCreditDays').value == '') {
            //                    alert('Please enter Credit Days');
            //                    DisplayTab('COM');
            //                    document.getElementById('txtCreditDays').focus();
            //                    return false;
            //                }
            //            var creditLimit = document.getElementById('txtcreditlimit').value;
            //            var creditDays = document.getElementById('txtCreditDays').value;

            //            if (Number(creditLimit) <= 0) {
            //                alert('Please..! Enter Credit Limit Greater than zero');
            //                DisplayTab('COM');
            //                document.getElementById('txtcreditlimit').focus();
            //                return false;
            //            }
            //            if (Number(creditDays) <= 0) {
            //                alert('Please..! Enter Credit Days Greater than zero');
            //                DisplayTab('COM');
            //                document.getElementById('txtCreditDays').focus();
            //                return false;
            //            }
            //            }
            //------

            //            if (document.getElementById('ddlClientStatus').options[document.getElementById('ddlClientStatus').selectedIndex].value != 'A' || document.getElementById('hdnValidateActive').value != 'A') {
            //                if (document.getElementById('txtReason').value == "") {
            //                    alert("Please give the reason");
            //                    document.getElementById('txtReason').focus();
            //                    return false;
            //                }
            //            }
            if (document.getElementById('chkisparent').checked == true) {
                if (document.getElementById('txtparentClient').value == "") {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_19');
                    if (UsrAlrtMsg10 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert("Enter Parent Client");
                        ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
                        return false;
                    }
                    funenableparent();
                    document.getElementById('txtparentClient').value = "";
                    document.getElementById('txtparentClient').focus();
                    return false;
                }
            }
            if (document.getElementById('tdReasonBlock').style.display == 'table-cell' && document.getElementById('tdClientSt').disabled != true) {
                if (document.getElementById('drpReason').options[document.getElementById('drpReason').selectedIndex].value == "---Select---") {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_20');
                    if (UsrAlrtMsg11 != null) {
                        // alert(userMsg);
                        ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please select the resaon');
                        ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('drpReason').focus();
                    return false;
                }
                if (document.getElementById('ddlAuthorizedBy').options[document.getElementById('ddlAuthorizedBy').selectedIndex].value == "0") {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_21');
                    if (UsrAlrtMsg12 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please select the Authorization person');
                        ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('ddlAuthorizedBy').focus();
                    return false;
                }
            }
            if (document.getElementById('ddlClientStatus').options[document.getElementById('ddlClientStatus').selectedIndex].value == 'S') {
                if (document.getElementById('txtFDate').value == '') {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_22');
                    if (UsrAlrtMsg13 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please select block from date');
                        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('txtFDate').focus();
                    return false;
                }
                if (document.getElementById('txtTDate').value == '') {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_23');
                    if (UsrAlrtMsg13 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please select block to date');
                        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('txtTDate').focus();
                    return false;
                }
                var fDate = document.getElementById('txtFDate').value.split('/');
                var toDate = document.getElementById('txtTDate').value.split('/');
                if (toDate[2] < fDate[2]) {
                   // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_24');
                    if (UsrAlrtMsg14 != null) {
                        // alert(userMsg);
                        ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                        return false;
                    }
                    else {
                        // alert('Please select valid Year');
                        ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('txtTDate').focus();
                    return false;
                }
                if (toDate[2] >= fDate[2] && toDate[1] < fDate[1]) {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_25');
                    if (UsrAlrtMsg15 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please select valid Month');
                        ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('txtTDate').focus();
                    return false;
                }
                if (toDate[2] >= fDate[2] && toDate[1] >= fDate[1] && toDate[0] < fDate[0]) {
                   // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_26');
                    if (UsrAlrtMsg16 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg16, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Please select valid Day');
                        ValidationWindow(UsrAlrtMsg16, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('STA');
                    document.getElementById('txtTDate').focus();
                    return false;
                }
            }
            var pList = document.getElementById('hdnAddressDetails').value.split("^");
            if (pList == "") {
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_27');
                if (UsrAlrtMsg17 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg17, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert("Enter the Shipping Information");
                    ValidationWindow(UsrAlrtMsg17, AlrtWinHdr);
                    return false;
                }
                DisplayTab('SHP');
                return false;
            }
            var flag = 0;
            var pList = document.getElementById('hdnAddressDetails').value.split("^");
            if (pList != "") {

                for (s = 0; s < pList.length; s++) {
                    if (pList[s] != "") {
                        y = pList[s].split('|');
                        if (y[7] == "Y") {
                            flag = 1;
                        }
                    }
                }
                if (flag == 0) {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_28');
                    if (UsrAlrtMsg18 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg18, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert("Give a primary address");
                        ValidationWindow(UsrAlrtMsg18, AlrtWinHdr);
                        return false;
                    }
                    DisplayTab('SHP');
                    return false;
                }
            }
            /*  Invoice Approval Alert Messgae 
            if (document.getElementById('chkisparent').disabled == false) {
            var checkboxCollection = document.getElementById('chkClientAttributes').getElementsByTagName('input');
            for (var i = 0; i < checkboxCollection.length; i++) {
            if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
            if (checkboxCollection[i].checked == false && checkboxCollection[i].parentElement.getElementsByTagName('label')[0].innerHTML == 'Invoice') {
            if (confirm('You have not select Invoice. So, The invoice cannot generate for this client. Do you want to proceed?')) {
            }
            else {
            return false;
            }
            }
            }
            }
            }
            */

            if (document.getElementById('ddlClientStatus').options[document.getElementById('ddlClientStatus').selectedIndex].value != 'A') {
                var sltTxt = document.getElementById('ddlClientStatus').options[document.getElementById('ddlClientStatus').selectedIndex].innerText;
                var TextAppend = SListForAppMsg.Get("Invoice_ClientMaster_aspx_32") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_32") : "You are going to";
                var TextAppend1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_33") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_33") : "this client. This is a critical operation. Are you sure you want to proceed?";
                var btnok = SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") : "Ok";
                var btncancel = SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") : "Cancel";
                var altMsg = TextAppend + sltTxt + TextAppend1;
                var dummy = ConfirmWindow(altMsg, AlrtWinHdr, btnok, btncancel);
                //var altMsg = 'You are going to ' + sltTxt + ' this client. This is a critical operation. Are you sure you want to proceed?';
                
                if (dummy==true) {
                }
                else {
                    DisplayTab('STA');
                    return false;
                }
            }

            if (document.getElementById('chkisparent').checked == false) {
                if (document.getElementById('ddlClientStatus').options[document.getElementById('ddlClientStatus').selectedIndex].value != 'A') {
                    var confirmmsg;
                    var dummy;
                    //var userMsg = SListForApplicationMessages.Get("Invoice\\ClientMaster.aspx_42");
                    if (UsrAlrtMsg19 != null) {
                        confirmmsg = UsrAlrtMsg19;

                    }
                    else {
                        confirmmsg =UsrAlrtMsg;
                    }
                    dummy = ConfirmWindow(confirmmsg, AlrtWinHdr, btnok, btncancel);
                    if (dummy==true) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
            }
			var creditlimitval=parseInt(document.getElementById("txtcreditlimit").value);
            if (document.getElementById("Chkiscash").checked) {
                if (document.getElementById("IsAdvanceClient").checked || creditlimitval > 0) {
                    ValidationWindow(UsrAlrtMsg20, AlrtWinHdr);
                    return false;
                }
            } else if (document.getElementById("IsAdvanceClient").checked) {
            if (document.getElementById("Chkiscash").checked || creditlimitval > 0) {
                ValidationWindow(UsrAlrtMsg20, AlrtWinHdr);
                    return false;
                }
            } else if (creditlimitval > 0) {
            if (document.getElementById("Chkiscash").checked || document.getElementById("IsAdvanceClient").checked) {
                ValidationWindow(UsrAlrtMsg20, AlrtWinHdr);
                return false;
            }
            }
            //Alex
            var chkbox = document.getElementById("chkClientAttributes");
            var inputArr = chkbox.getElementsByTagName('input');
            var labelArr = chkbox.getElementsByTagName('label');
            var sum = "";

            for (var i = 0; i < labelArr.length; i++) {
                if (inputArr[i].checked == true) {
                    sum = sum + labelArr[i].innerText;
                }
            }
            if (sum.search("FTP") >= 0) {
                if (document.getElementById('Txtftppath').value == "") {
                    ValidationWindow('Please enter the Ftp Path Name', AlrtWinHdr);
                    return false;
                }
            }
            else {

            }

            //            var flag1 = 0;
            //            var checkboxCollection = document.getElementById('chkDespatch').getElementsByTagName('input');
            //            for (var i = 0; i < checkboxCollection.length; i++) {
            //                if (checkboxCollection[i].type.toString().toLowerCase() == "checkbox") {
            //                    if (checkboxCollection[i].checked == true) {
            //                        flag1 = 1;
            //                    }
            //                }
            //            }

            //            if (flag1 == 0) {
            //                alert("Select a one Despatch Mode");
            //                //document.getElementById('chkUserType_0').focus();
            //                return false;
            //            }
            //            var flag2 = 0;
            //            var checkboxCollections = document.getElementById('chkClientAttributes').getElementsByTagName('input');
            //            for (var i = 0; i < checkboxCollections.length; i++) {
            //                if (checkboxCollections[i].type.toString().toLowerCase() == "checkbox") {
            //                    if (checkboxCollections[i].checked == true) {
            //                        flag2 = 1;
            //                    }
            //                }
            //            }
            //            if (flag2 == 0) {
            //                alert("Select a one Attributes");
            //                //document.getElementById('chkUserType_0').focus();
            //                return false;
            //            }

            //            if (document.getElementById('txtcstno').value == "") {
            //                document.getElementById('txtcstno').value = "";
            //                document.getElementById('txtcstno').focus();
            //                alert("Enter CSTNO");
            //                return false;
            //            }
            return true;


        }
        function funenableparent() {
            document.getElementById('chkDebtor').checked = false;
            document.getElementById('txtparentClient').value = "";

            if (document.getElementById('chkisparent').checked) {
                document.getElementById('isparentclient').style.display = "table-cell";
            }
            else {
                document.getElementById('isparentclient').style.display = "none";
            }
            if (document.getElementById('chkisapproval').checked == false) {
                document.getElementById('td4AdColspan').style.display = "table-cell";
                document.getElementById('td2AdColspan').style.display = "none";
            }
            else {
                document.getElementById('td2AdColspan').style.display = "table-cell";
                document.getElementById('td4AdColspan').style.display = "none";
            }
        }
        function FnClear() {
            document.getElementById('hdnId').value = "0";
            document.getElementById('txtClientName').value = "";
            document.getElementById('txtClientCode').value = "";
            //--------Commented By Gurunath S
            //document.getElementById('txtContactPersons').value = "";
            //---------
            document.getElementById('txtaddres1').value = "";
            document.getElementById('txtaddres2').value = "";
            document.getElementById('txtciti').value = "";
            document.getElementById('txtEmailID').value = "";
            document.getElementById('txtPhoneNumber').value = "";
            document.getElementById('txtmobileno').value = "";
            document.getElementById('btnFinish').value = 'Save';
            document.getElementById('lblmsg').innerText = "";
            document.getElementById('hdnStatus').value = 'Save';
            document.getElementById('txtfax').value = "";
            document.getElementById('txtPanNo').value = "";
            document.getElementById('txtcstno').value = "";
            document.getElementById('txtServiceTaxNo').value = "";
            document.getElementById('fckInvDetailss').value = "";
            //                document.getElementById('drpaddresstype').options[document.getElementById('drpaddresstype').selectedIndex].text = x[4];
            document.getElementById('drpaddresstype').value = "0"
            document.getElementById('drpdespatch').value = "--Select--"
            document.getElementById('tdChkDelete').style.display = 'none';
            document.getElementById('chkDelete').checked = false;
            document.getElementById('isappyes').checked = false;
            document.getElementById('ddlClientType').value = "0";
            var fckname = document.getElementById('fckInvDetailss').id;
            var fckeditor = FCKeditorAPI.GetInstance(fckname);
            fckeditor.EditorDocument.body.innerHTML = '';
            document.getElementById('hdnClientAttributes').value = "";

        }

        function SetValues(obj, Id) {
            document.getElementById('hdnClientAttributes').value = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(Id).checked = true;

            var Y = obj.value.split('$')[1];
            //            PageMethods.CustomiseString(obj.value.split('-')[1])
            LoadOrdItemsCorp(obj.value.split('$')[0])
            //            var x = obj.split('~');
            var x = Y.split('~');
            var opt = x != ""
            if (x != "") {

                document.getElementById('hdnId').value = x[0];
                document.getElementById('txtClientName').value = x[2];
                document.getElementById('txtClientCode').value = x[1];
                //Commented By Gurunath S
                //document.getElementById('txtContactPersons').value = x[3];
                document.getElementById('txtaddres1').value = x[5];
                document.getElementById('txtaddres2').value = x[6];
                document.getElementById('txtciti').value = x[7];
                document.getElementById('txtEmailID').value = x[10];
                document.getElementById('txtPhoneNumber').value = x[11];
                document.getElementById('txtmobileno').value = x[12];
                var vAdd1 = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_061") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_061");
                document.getElementById('btnFinish').value = vAdd1;
                document.getElementById('lblmsg').innerText = "";
                document.getElementById('hdnStatus').value = 'Update';
                document.getElementById('txtfax').value = x[13];
                document.getElementById('txtPanNo').value = x[17];
                document.getElementById('txtcstno').value = x[14];
                document.getElementById('txtServiceTaxNo').value = x[16];
                document.getElementById('fckInvDetailss').value = x[12];
                //                document.getElementById('drpaddresstype').options[document.getElementById('drpaddresstype').selectedIndex].text = x[4];
                document.getElementById('drpaddresstype').value = x[4];
                document.getElementById('drpdespatch').value = x[15];
                document.getElementById('tdChkDelete').style.display = 'table-cell';
                document.getElementById('chkDelete').checked = x[19].trim() == "N" ? false : true;
                document.getElementById('isappyes').checked = x[18].trim() == "N" ? false : true;
                document.getElementById('drpCountry').value = x[8];
                document.getElementById('drpState').value = x[9];
                document.getElementById('ddlClientType').value = x[20].trim();
                //                document.getElementById('ddlClientType').disabled = true;

                if (typeof (FCKeditorAPI) != "undefined") {
                    var EditorInstance1 = FCKeditorAPI.GetInstance('<%=fckInvDetailss.ClientID%>');
                    //                     EditorInstance1.EditorDocument.body.innerHTML = x[14];
                    EditorInstance1.SetHTML(x[21]);

                }

            }
        }
        function LoadOrdItemsCorp(AttribValue) {
            //alert('begin :'+AttribValue);
            var HidValue = "";
            if (AttribValue == '') {

                var otable = document.getElementById('tblClientAttributes');
                while (otable.rows.length > 1)
                    otable.deleteRow(otable.rows.length - 1);
                document.getElementById('tblClientAttributes').style.display = 'none';
                document.getElementById('<%= hdnClientAttributes.ClientID %>').value = "";
            }
            else {
                //alert('else '+AttribValue);
                document.getElementById('<%= hdnClientAttributes.ClientID %>').value = AttribValue;
                HidValue = AttribValue;
                var otable = document.getElementById('tblClientAttributes');
                while (otable.rows.length > 1)
                    otable.deleteRow(otable.rows.length - 1);
            }
            var list = HidValue.split('^');
            var total = 0, rate;
            // alert(HidValue);
            if (HidValue != '') {
                // alert('else 2 ' + AttribValue);
                showResponses('Div1', 'Div2', 'divLocation', 1);
                for (var count = 0; count < list.length - 1; count++) {
                    var InvesList = list[count].split('~');
                    //total = document.getElementById('InvestigationControl1_lblTotal').innerHTML;
                    var row = document.getElementById('tblClientAttributes').insertRow(1);
                    row.id = InvesList[0];
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    // var cell4 = row.insertCell(3);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + InvesList[0] + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "5%";
                    cell2.innerHTML = InvesList[1];
                    cell3.innerHTML = InvesList[2];
                    cell4.innerHTML = InvesList[3];
                    // alert(InvesList[2]);
                }
                document.getElementById('tblClientAttributes').style.display = 'table';

            }

            if (document.getElementById('<%= hdnClientAttributes.ClientID %>').value == '') {

                document.getElementById('tblClientAttributes').style.display = 'none';

            }
        }

        //        function LoadOrdItemsCorp(attXML) {

        //            if (window.DOMParser) {
        //                parser = new DOMParser();
        //                xmlDoc = parser.parseFromString(attXML, "text/xml");
        //            }
        //            else {
        //                xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
        //                xmlDoc.async = "false";
        //                xmlDoc.loadXML(attXML);
        //            }
        //            var x = xmlDoc.getElementsByTagName("AttribDetails");

        //            var HidValue = "";
        //            if (attXML == '') {

        //                var otable = document.getElementById('tblClientAttributes');
        //                while (otable.rows.length > 1)
        //                    otable.deleteRow(otable.rows.length - 1);
        //                document.getElementById('tblAttributes').style.display = 'none';
        //                //                document.getElementById('<%= hdnClientAttributes.ClientID %>').value = "";
        //            }
        //            else {



        //                var otable = document.getElementById('tblClientAttributes');
        //                if (otable != null) {
        //                    while (otable.rows.length > 1)
        //                        otable.deleteRow(otable.rows.length - 1);
        //                }
        //            }

        //            var total = 0, rate;

        //            var InvesList = 1;
        //            for (i = 0; i < x.length; i++) {

        //                showResponses('Div1', 'Div2', 'divLocation', 1);

        //                var row = document.getElementById('tblClientAttributes').insertRow(1);
        //                row.id = InvesList;
        //                var cell1 = row.insertCell(0);
        //                var cell2 = row.insertCell(1);
        //                var cell3 = row.insertCell(2);
        //                var cell4 = row.insertCell(3);
        //                // var cell4 = row.insertCell(3);

        //                cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + InvesList + ");' src='../Images/Delete.jpg' />";
        //                cell1.width = "5%";
        //                cell2.innerHTML = x[i].getElementsByTagName("Name")[0].childNodes[0].nodeValue;
        //                cell3.innerHTML = x[i].getElementsByTagName("Type")[0].childNodes[0].nodeValue;
        //                cell4.innerHTML = x[i].getElementsByTagName("Value")[0].childNodes[0].nodeValue;
        //                document.getElementById('<%= hdnClientAttributes.ClientID %>').value += InvesList + '~' + x[i].getElementsByTagName("Name")[0].childNodes[0].nodeValue + '~' +
        //                                                                                            x[i].getElementsByTagName("Type")[0].childNodes[0].nodeValue + '~' +
        //                                                                                            x[i].getElementsByTagName("Value")[0].childNodes[0].nodeValue + '^'
        //                InvesList = InvesList + 1;
        //            }

        //            document.getElementById('tblClientAttributes').style.display = 'block';

        //            //            }
        //            if (document.getElementById('<%= hdnClientAttributes.ClientID %>').value == '') {

        //                document.getElementById('tblClientAttributes').style.display = 'none';

        //            }
        //        }
        function clientcler() {
            document.getElementById('ddlClientTypes').value = "1";
            document.getElementById('txtValue').value = "";
            document.getElementById('txtClientAttributes').value = "";

        }
        function createClienttab() {

            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_34") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_34") : "Enter the Client Attributes";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_35") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_35") : "Enter the Clien Attributes Values";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_36") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_36") : "Provide attribute value";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_37") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_37") : "Attribute already added";
            if (document.getElementById('txtClientAttributes').value == "") {
                document.getElementById('txtClientAttributes').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_29');
                if (UsrAlrtMsg != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                    // alert('Enter the Client Attributes');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }

            }
            if (document.getElementById('txtValue').value == "") {
                document.getElementById('txtValue').focus();
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_30');
                if (UsrAlrtMsg1 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Enter the Clien Attributes Values');
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
            }
            var j = 1;
            var obj = document.getElementById('<%=ddlClientTypes.ClientID%>');
            var i = obj.getElementsByTagName('OPTION');
            var AddStatus = 0;
            var Attributes = document.getElementById('txtClientAttributes').value;
            var Value = document.getElementById('txtValue').value;
            var rwNumber = j;  //obj.options[obj.selectedIndex].value;
            var Type = obj.options[obj.selectedIndex].text;
            //document.getElementById('tblAttributes').style.display = 'block';
            var HidValue = document.getElementById('hdnClientAttributes').value;
            // var txtvalue = document.getElementById('hdntxtvalue').value;
            var list = HidValue.split('^');
            //var clientvalue = txtvalue.split('^');
            if (document.getElementById('hdnClientAttributes').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var SpecialityList = list[count].split('~');
                    if (SpecialityList[1] != '') {
                        if (SpecialityList[0] != '') {
                            rwNumber = parseInt(parseInt(SpecialityList[0]) + parseInt(1));
                        }
                        if (Attributes != '') {
                            if (SpecialityList[1] == Attributes) {
                                AddStatus = 1;
                            }
                        }
                    }
                }
            }
            else {

                if (Attributes != '') {
                    var row = document.getElementById('tblClientAttributes').insertRow(1);
                    //rwNumber = Attributes + rwNumber;
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //alert("rwNumber:" + rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "10%";
                    cell2.innerHTML = "<b>" + Attributes + "</b> ";
                    cell2.width = "45%";
                    cell3.innerHTML = "<b>" + Type + "</b> ";
                    cell3.width = "45%";
                    cell4.innerHTML = "<b>" + Value + "</b> ";
                    cell4.width = "45%";

                    document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";

                    AddStatus = 2;
                    document.getElementById('tblClientAttributes').style.display = 'table'
                    j++;
                }
                else {
                   // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_31');
                    if (UsrAlrtMsg2 != null) {
                        // alert(userMsg);
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                       
                        return false;
                    }
                    else {
                        // alert('Provide attribute value');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                        return false;
                    }
                }
            }
            if (AddStatus == 0) {
                if (Attributes != '') {
                    var row = document.getElementById('tblClientAttributes').insertRow(1);
                    //alert("rwNumber1:" + rwNumber);
                    //rwNumber = Attributes + rwNumber;
                    row.id = rwNumber;
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    //alert("rwNumber1:" + rwNumber);
                    cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickClient(" + rwNumber + ");' src='../Images/Delete.jpg' />";
                    cell1.width = "6%";
                    cell2.innerHTML = "<b>" + Attributes + "</b> ";
                    cell3.innerHTML = "<b>" + Type + "</b>";
                    cell4.innerHTML = "<b>" + Value + "</b>";
                    j++;
                    document.getElementById('hdnClientAttributes').value += rwNumber + "~" + Attributes + "~" + Type + "~" + Value + "^";
                    document.getElementById('tblClientAttributes').style.display = 'table';
                }

                else {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_31');
                    if (UsrAlrtMsg2 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                        return false;
                    }
                    else {
                        //alert('Provide attribute value');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                        return false;
                    }
                }

            }
            else if (AddStatus == 1) {
                //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_33');
                if (UsrAlrtMsg3 != null) {
                    //alert(userMsg);
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    return false;
                }
                else {
                    //alert('Attribute already added');
                    ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    return false;
                }
            }
            clientcler();
            return false;
        }

        function ImgOnclickClient(ImgID) {
            document.getElementById(ImgID).style.display = "none";
            var HidValue = document.getElementById('hdnClientAttributes').value;
            var list = HidValue.split('^');
            var NewHealthCheckupList = '';
            if (document.getElementById('hdnClientAttributes').value != "") {
                for (var count = 0; count < list.length; count++) {
                    var HealthCheckupList = list[count].split('~');
                    if (HealthCheckupList[0] != '') {
                        if (HealthCheckupList[0] != ImgID) {
                            NewHealthCheckupList += list[count] + '^';
                        }
                    }
                }
                document.getElementById('hdnClientAttributes').value = NewHealthCheckupList;
            }
            if (document.getElementById('hdnClientAttributes').value == '') {
                document.getElementById('hdnClientAttributes').style.display = 'none';

            }
        }

        function Enableclient() {
            document.getElementById('tblclientatt').style.display = 'table';
        }

        //Added By Gurunath.S
        function OnHubSelected(source, eventArgs) {
            document.getElementById('txtHub').value = eventArgs.get_text();
            document.getElementById('hdnHubID').value = eventArgs.get_value();
            if (document.getElementById('hdnHubID').value != "0") {
                $find('AutoCompleteExtender2').set_contextKey('zone' + '~' + document.getElementById('hdnHubID').value);
            }
            else {
                $find('AutoCompleteExtender2').set_contextKey('');
            }
        }
        function GetReason() {
            var cType = document.getElementById('ddlClientStatus').options[document.getElementById('ddlClientStatus').selectedIndex].value;
            var activeR = document.getElementById('hdnValidateActive').value;
            var hdnStatus = document.getElementById('hdnClientStatus').value;
            var dispValue = '';
            if (cType != 'A') {
                dispValue = 'table-cell';
            }
            else {
                dispValue = 'none';
            }
            if (cType != 'A') {
                document.getElementById('tdBlockDate').style.display = 'table-cell';
            }
            else {
                document.getElementById('tdBlockDate').style.display = 'none';
            }
            if (activeR != '---Select---' && activeR != '0') 
			{
                dispValue = 'table-cell';
            }
            if (cType != 'A') {

                document.getElementById('tdReasonBlock').style.display = dispValue;
                document.getElementById('tdSendSMS').style.display = dispValue;
            }
            else 
            {
                document.getElementById('tdReasonBlock').style.display = 'none';
                document.getElementById('tdSendSMS').style.display = 'none';
           }
        }

        // client logo strats//
        function GetClientLogoUpload() {

            var clientType = document.getElementById('ddlLogoClientTypes').options[document.getElementById('ddlLogoClientTypes').selectedIndex].value;
            if (clientType == "1") {
                document.getElementById('trflUpload').style.display = 'block';

            }
            if (clientType == "2") {
                document.getElementById('trflUpload').style.display = 'none';

            }

        }

        //  client logo strats//

        $(window).load(function() {

            GetClientLogoUpload();
        });




        // client logo ends//
        function DisplayTab(tabName) {
            $('#TabsMenu1 li').removeClass('active');
            if (tabName == 'COM') {
                document.getElementById('tdCommercial').style.display = 'table-cell';
                $('#li1').addClass('active');
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
            }
            else if (tabName == 'SHP') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'table-cell';
                $('#li2').addClass('active');
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
            }
            else if (tabName == 'CNT') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'table-cell';
                $('#li3').addClass('active');
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
            }
            else if (tabName == 'NOT') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'table-cell';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li4').addClass('active');
            }
            else if (tabName == 'REP') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'table-cell';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li5').addClass('active');
            }
            else if (tabName == 'TER') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'table-cell';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li6').addClass('active');
            }
            else if (tabName == 'DES') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'table-cell';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li7').addClass('active');
            }
            else if (tabName == 'STA') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'table-cell';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li8').addClass('active');
            }
            else if (tabName == 'TD') {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('tdLogoStatus').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'table-row';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li10').addClass('active');
            }
            else if (tabName == 'Logo') {
                debugger;
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('tdLogoStatus').style.display = 'table-cell';

                $('#li11').addClass('active');
            }
            /*BEGIN || TAT || RAJKUMAR G || 20191001*/
            else if (tabName == 'CT') {
                debugger;
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'none';
                document.getElementById('trTaxDetails').style.display = 'none';
                
                //document.getElementById('tdLogoStatus').style.display = 'none';
                document.getElementById('trCustomerTAT').style.display = 'table-row';
                $('#li12').addClass('active');
            }
            /*END || TAT || RAJKUMAR G || 20191001*/
            else {
                document.getElementById('tdCommercial').style.display = 'none';
                document.getElementById('tdShip').style.display = 'none';
                document.getElementById('tdContact').style.display = 'none';
                document.getElementById('tdNotify').style.display = 'none';
                document.getElementById('tdReports').style.display = 'none';
                document.getElementById('tdTerms').style.display = 'none';
                document.getElementById('tdDespt').style.display = 'none';
                document.getElementById('tdCStatus').style.display = 'none';
                document.getElementById('tdAttribs').style.display = 'block';
                //document.getElementById('tdLogoStatus').style.display = 'none';
                /*BEGIN || TAT || RAJKUMAR G || 20191001*/
                document.getElementById('trCustomerTAT').style.display = 'none';
                /*END || TAT || RAJKUMAR G || 20191001*/
                $('#li9').addClass('active');
            }
        }

        function MandatoryCredits() {
            var dispValue = '';
            if (document.getElementById('Chkiscash').checked == true) {
                dispValue = 'none';
            }
            else {
                dispValue = 'block';
            }
            document.getElementById('starimgCreditLimit').style.display = dispValue;
            document.getElementById('starimgCreditDays').style.display = dispValue;
        }
        function redirectPage(obj) {
            var cTypeID = obj.split('~')[0];
            var ClientID = obj.split('~')[1];
            var ClientName = obj.split('~')[2];
            var strURl = '../Admin/SpecialRateCard.aspx?MapType=CLI&cTypeID=' + cTypeID + '&ClientID=' + ClientID + '&CName=' + ClientName + '&IsPopup=Y';
            var confirmmsg1;
            //var userMsg = SListForApplicationMessages.Get("Invoice\\ClientMaster.aspx_43");
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_38") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_38") : "'You have selected show only mapped items.You can map the items in Service Client Mapping. Click Ok, to go Service Client Mapping";
            var dummy;
            var btnok = SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") : "Ok";
            var btncancel = SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") : "Cancel";
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            if (UsrAlrtMsg != null) {
                confirmmsg1 = UsrAlrtMsg;

            }
            else {
                //confirmmsg1 = 'You have selected show only mapped items.You can map the items in Service Client Mapping. Click Ok, to go Service Client Mapping';
                confirmmsg1 = UsrAlrtMsg;
            }
            dummy = ConfirmWindow(UsrAlrtMsg, AlrtWinHdr, btnok, btncancel);
           
            if (dummy==true) {
                $(location).attr('href', strURl);
            }
            else {

            }
        }
        function GetID(source, eventArgs) {
            document.getElementById('txtClientName').value = eventArgs.get_text();
            document.getElementById('hdnHosOrRefID').value = eventArgs.get_value();
        }
        function DisplayRole(chkbxID) {
            if (document.getElementById(chkbxID).checked == true) {
                document.getElementById('tdRole').style.display = 'table-cell';
                document.getElementById('tdlblRole').style.display = 'table-cell';
                document.getElementById('td2AdColspan').style.display = "table-cell";
                document.getElementById('td4AdColspan').style.display = "none";
            }
            else {
                document.getElementById('td2AdColspan').style.display = "none";
                document.getElementById('td4AdColspan').style.display = "table-cell";
                document.getElementById('tdRole').style.display = 'none';
                document.getElementById('tdlblRole').style.display = 'none';
            }
        }

function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
    var AlertType = SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01') == null ? "Alert" : SListForAppMsg.Get('Billing_Scripts_LabQuickBilling_js_01');
    var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_04") : "Invalid E-Mail ID";
    var value = emailcntl.value;
    if (value != '') {
        var result = value.split(seperator);
        for (var i = 0; i < result.length; i++) {
            if (result[i] != '') {
                if (!validateEmail(result[i])) {
                   // emailcntl.focus();
                    ValidationWindowEmail('' + UsrAlrtMsg + '', AlertType);
                    document.getElementById('txtEmailID').value = "";

                    var elements = document.getElementById('chkDespatchMode');
                    if (document.getElementById('txtEmail').value != '') {

                        //elements.cells[0].childNodes[0].checked = false;
                        document.getElementById('chkDespatchMode_0').checked = false;
                        /*changed by arivalagan.kk*/
                        //elements.cells[0].childNodes[0].checked = false;
                        /*changed by arivalagan.kk*/
                    }
                    return false;
                }
            }
        }
    }
    return true;
}

function validateEmail(field) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,10}$/;
    return (regex.test(field)) ? true : false;
}

function ValidationWindowEmail(message, tt) {
    jQuery('<div>')
        .html("<p>" + message + "</p>")
        .dialog({
            autoOpen: false,
            modal: true,
            title: tt,
            dialogClass: 'validationwindow',
            close: function() {
                jQuery(this).dialog("destroy");
            },
            buttons: {
                "MyButton": {
                    id: "okbtnid",
                    "class": "btn",
                    click: function() {
                        jQuery(this).dialog("destroy");
                        document.getElementById('txtEmail').focus();
                    }
                }
            },
            create: function() {

                var canceltxt = jQuery('#Language').text();
                jQuery('#Cancelbtnid').text(canceltxt);
                //var oktxt = jQuery('[id$=hdnButtonText]').val();
                var oktxt = SListForAppDisplay.Get("Scripts_Common_js_Ok") == null ? "Ok" : SListForAppDisplay.Get("Scripts_Common_js_Ok");
                if (oktxt == '' || oktxt == null) {
                    try {
                        oktxt = jQuery('[id$=btnRoleOK]').val();
                    }
                    catch (Error) {
                        oktxt = "Ok";
                    }
                    oktxt = oktxt == "" || oktxt == undefined ? "Ok" : oktxt;
                }

                jQuery('#okbtnid').text(oktxt);
                jQuery('#okbtnid').css("width", "80px");
                jQuery('#okbtnid').css("height", "30px");
            }
        }).dialog("open");
}

        //-----Code End-----//
    </script>

    <style type="text/css">
        .ui-datepicker
        {
            font-size: 8pt !important;
        }
    </style>
    <style type="text/css">
        .style3
        {
            width: 125px;
            height: 21px;
        }
        .style4
        {
            width: 220px;
            height: 21px;
        }
        .style6
        {
            height: 166px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <div id="wrapper">
        <div id="header">
            <div class="logoleft" style="z-index: 2;">
                <div class="logowrapper">
                    <img alt="" src="<%=LogoPath%>" class="logostyle" />
                </div>
            </div>
            <div style="float: right;" class="Rightheader">
            </div>
        </div>
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>
                <td width="15%" valign="top" id="menu" style="display: block;">
                </td>
                <td width="85%" valign="top" class="tdspace">
                    <img alt="" onclick="Showmenu();Showhide();" src="../Images/hide.png" id="showmenu"
                        style="cursor: pointer">
                </td>
            </tr>
        </table>
    </div>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">

                        <script type="text/javascript">
                            $(function() {
                                TempDate();
                                //                    $("#txtFDate").datepicker({
                                //                        changeMonth: true,
                                //                        changeYear: true,
                                //                        minDate: 0,
                                //                        yearRange: '2012:2030'
                                //                    });
                                //                    $("#txtTDate").datepicker({
                                //                        changeMonth: true,
                                //                        changeYear: true,
                                //                        minDate: 0,
                                //                        yearRange: '2012:2030'
                                //                    })
                                //                    $("#TxtRptPrintFrom").datepicker({
                                //                        changeMonth: true,
                                //                        changeYear: true,
                                //                      //  minDate: 0,
                                //                        yearRange: '2012:2030'
                                //                    });
                            });
                        </script>

        <table class="tableborder w-100p">
            <tr>
                <td class="tdspace w-100p v-top">
                    <div>
                        <asp:UpdatePanel ID="UpdatePanel" runat="server">
                            <ContentTemplate>
                                <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="UpdatePanel" runat="server">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter">
                                        </div>
                                        <div align="center" id="processMessage">
                                            <asp:Label ID="Rs_Pleasewait" Text="Please wait... " runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                            <br />
                                            <br />
                                            <asp:Image ID="imgProgressbar" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <table class="w-100p">
                                    <tr>
                                        <td colspan="2">
                                            <div>
                                                <asp:Panel ID="pnlas" runat="server" meta:resourcekey="pnlasResource1">
                                                    <table class="w-100p">
                                                        <%-- <tr class="panelHeader">
                                                            <td class="a-center">
                                                               <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                            </td>
                                                        </tr>--%>
                                                        <%--<tr>
                                                            <td class="h-4">
                                                                    <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                                            </td>
                                                        </tr>--%>
                                                        <tr class="panelContent">
                                                            <td>
                                                                 <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                                <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                                                <asp:Panel ID="Panel1" runat="server" meta:resourcekey="Panel1Resource1">
                                                                    <table class="dataheader3 w-100p">
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <asp:Panel ID="Panel6" runat="server" meta:resourceKey="Panel6Resource2">
                                                                                    <table class="searchPanel w-100p bg-row">
                                                                                     <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                                                                    <%--IDENTITY--%><%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_012%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                        <tr class="panelContent">
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="lblClientType" Text="Client Type" runat="server" meta:resourceKey="lblClientTypeResource2"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="ddlClientType" runat="server" Style="margin-left: 0px"
                                                                                                    CssClass="ddlsmall" onChange="SetContextKeyRefHos()" meta:resourcekey="ddlClientTypeResource1">
                                                                                                </asp:DropDownList>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="lblclient" Text="Client Name" runat="server" meta:resourcekey="lblclientResource1">
                                                                                                <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_044%>
                                                                                                </asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="txtClientName" runat="server" MaxLength="50" AutoComplete="off"
                                                                                                    CssClass="small"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  onchange="javascript:return ClearFields('CLI');"
                                                                                                     meta:resourcekey="txtClientNameResource1"></asp:TextBox>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                <div id="aceClientName">
                                                                                                </div>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender6" runat="server" TargetControlID="txtClientName"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                                                                    OnClientItemSelected="GetID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                    Enabled="True" UseContextKey="True" CompletionListElementID="aceClientName" OnClientShown="setAceWidth">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                            </td>
                                                                                            <td style="width: 125px; display: table-cell;" id="lbidcode" runat="server">
                                                                                                <asp:Label ID="lblClientcode" Text="Client Code" runat="server" meta:resourcekey="lblClientcodeResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width: 220px; display: table-cell;" id="txtclcode" runat="server">
                                                                                                <asp:TextBox ID="txtClientCode" runat="server" MaxLength="50" CssClass="Txtboxsmall"
                                                                                                    AutoComplete="off"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                                                                    onBlur="CheckCodes('CLI',this.id);" Width="70px" meta:resourcekey="txtClientCodeResource1"></asp:TextBox>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr class="panelContent">
                                                                                            <td class="style3">
                                                                                                <asp:Label ID="Label6" Text="Location" runat="server" meta:resourcekey="Label6Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td class="style4">
                                                                                                <asp:TextBox ID="txtcollectioncenter" runat="server" MaxLength="50" AutoComplete="off"
                                                                                                    CssClass="AutoCompletesearchBox1"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" 
                                                                                                    onchange="javascript:return ClearFields('');" onBlur="CheckLocationName('LOC',this.id);" meta:resourceKey="txtcollectioncenterResource2"></asp:TextBox>
                                                                                                <div id="aceLocation">
                                                                                                </div>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender4" runat="server" TargetControlID="txtcollectioncenter"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetCollectionCentreMaster"
                                                                                                    OnClientItemSelected="OnCollectioncenterselected" ServicePath="~/WebService.asmx"
                                                                                                    DelimiterCharacters="" Enabled="True" CompletionListElementID="aceLocation" OnClientShown="setAceWidth">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                            </td>
                                                                                            <td class="style3">
                                                                                                <asp:Label ID="Label7" Text="Hub" runat="server" meta:resourcekey="Label7Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td class="style4">
                                                                                                <asp:TextBox ID="txtHub" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox1" 
                                                                                                    onchange="javascript:return ClearFields('HUB');" meta:resourcekey="txtHubResource1"></asp:TextBox>
                                                                                                <div id="aceHub">
                                                                                                </div>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender5" runat="server" TargetControlID="txtHub"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHubDetails"
                                                                                                    OnClientItemSelected="OnHubSelected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                    Enabled="True" CompletionListElementID="aceHub" OnClientShown="setAceWidth">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                            </td>
                                                                                            <td class="style3">
                                                                                                <asp:Label ID="Label5" Text="Zone" runat="server" meta:resourcekey="Label5Resource1"></asp:Label>
                                                                                            </td>
                                                                                            <td class="style4">
                                                                                                <asp:TextBox ID="txtzone" runat="server" MaxLength="50" AutoComplete="off" CssClass="AutoCompletesearchBox1"
                                                                                                     meta:resourcekey="txtzoneResource1"></asp:TextBox>
                                                                                                <div id="acezone">
                                                                                                </div>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txtzone"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetGroupMasterDetails"
                                                                                                    OnClientItemSelected="Onzoneselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                    Enabled="True" CompletionListElementID="acezone" OnClientShown="setAceWidth">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr class="panelContent">
                                                                                            <td class="style3">
                                                                                                <asp:Label ID="lblRoutename" Text="Route" runat="server" meta:resourceKey="lblRoutenameResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td class="style4">
                                                                                                <asp:TextBox ID="txtRouteName" runat="server" MaxLength="50" CssClass="AutoCompletesearchBox1"
                                                                                                    AutoComplete="off" onchange="javascript:return ClearFields('ROU');" onBlur="CheckRouteName('route',this.id);"
                                                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" ></asp:TextBox>
                                                                                                <div id="aceRouteName">
                                                                                                </div>
                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender12" runat="server" TargetControlID="txtRouteName"
                                                                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                    MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetRouteNames"
                                                                                                    OnClientItemSelected="Onrouteselected" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                    Enabled="True" CompletionListElementID="aceRouteName" OnClientShown="setAceWidth">
                                                                                                </ajc:AutoCompleteExtender>
                                                                                            </td>
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="lblPanNo" Text="PAN No" runat="server" meta:resourcekey="lblPanNoResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="txtPanNo" runat="server" MaxLength="50" CssClass="small" 
                                                                                                    AutoComplete="off"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" meta:resourcekey="txtPanNoResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="lblCstno" Text="CST No" runat="server" meta:resourcekey="lblCstnoResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="txtcstno" runat="server" CssClass="small" AutoComplete="off"
                                                                                                      OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" meta:resourcekey="txtcstnoResource1"></asp:TextBox>
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr class="panelContent">
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="Label8" Text="Business Type" runat="server"   meta:resourcekey="lblLabel8Resource1" ></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:DropDownList ID="drpBusinessType" runat="server" CssClass="ddlsmall"
                                                                                                    meta:resourcekey="drpBusinessTypeResource1">
                                                                                                </asp:DropDownList>
                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                            </td>
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="lblsapcode" Text="SAP Code" runat="server" meta:resourcekey="lblsapcodeResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="txtsapcode" runat="server" MaxLength="20" CssClass="Txtboxsmall"
                                                                                                    AutoComplete="off" onkeydown=" return isNumeric(event,this.id);" meta:resourcekey="txtsapcodeResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td style="width: 125px;">
                                                                                                <asp:Label ID="lblServiceTaxNo" Text="ServiceTax No" runat="server" meta:resourcekey="lblServiceTaxNoResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <asp:TextBox ID="txtServiceTaxNo" runat="server" MaxLength="50" CssClass="small"
                                                                                                    AutoComplete="off"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"
                                                                                                    onBlur="CheckServiceTaxNo('STN',this.id);" meta:resourcekey="txtServiceTaxNoResource1"></asp:TextBox>
                                                                                            </td>
                                                                                            <td style="width: 125px; display: none;" colspan="1" id="tdIsSponsor" runat="server"
                                                                                                nowrap="nowrap">
                                                                                                <asp:CheckBoxList ID="chklstIsSponsor" runat="server" RepeatColumns="7" RepeatDirection="Horizontal"
                                                                                                    meta:resourcekey="chklstIsSponsorResource1" />
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr class="panelContent">
                                                                                            <td nowrap="nowrap">
                                                                                                <asp:Label ID="lblddlPrintLocation" Text="Print.Location" runat="server" meta:resourcekey="lblddlPrintLocationResource1"></asp:Label>
                                                                                            </td>
                                                                                            <td>
                                                                                                <span class="richcombobox" style="width: 153px;padding:0;" nowrap="nowrap">
                                                                                                    <asp:DropDownList ID="ddlPrintLocation" CssClass="ddl" Width="153px" runat="server"
                                                                                                        meta:resourcekey="ddlPrintLocationResource2">
                                                                                                    </asp:DropDownList>
                                                                                                </span>
                                                                                            </td>
                                                                                            <td colspan="5">
                                                     <%--                                           <asp:RadioButtonList ID="RdoClientRmtAccess" runat="server" RepeatDirection="Horizontal"
                                                                                                    meta:resourceKey="RdoClientRmtAccessResource1">
                                                                                                    <asp:ListItem Selected="True" meta:resourceKey="ListItemResource1">None</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourceKey="ListItemResource2">Client Access</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourceKey="ListItemResource3">Remote Registration</asp:ListItem>
                                                                                                </asp:RadioButtonList>--%>
                                                                                                 <asp:CheckBoxList CssClass="chkbox" ID="RdoClientRmtAccess" runat="server" RepeatDirection="Horizontal">
                                                                                                    <asp:ListItem  Selected="True" meta:resourceKey="ListItemResource1">None</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourceKey="ListItemResource2">Client Access</asp:ListItem>
                                                                                                    <asp:ListItem meta:resourceKey="ListItemResource3">Remote Registration</asp:ListItem>
                                                                                                 
                                                                                                 </asp:CheckBoxList> 
                                                                                                            
                                                                                            </td>
                                                                                        </tr>
                                                                                        <tr class="panelContent">
                                                                                            <%--<td nowrap="nowrap">
                                                                                                    <asp:Label ID="lblddlPrintLocation" Text="Print.Location" runat="server" meta:resourcekey="lblddlPrintLocationResource1"></asp:Label>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <span class="richcombobox" style="width: 155px;" nowrap="nowrap">
                                                                                                        <asp:DropDownList ID="ddlPrintLocation" CssClass="ddl" Width="155px" runat="server"
                                                                                                            meta:resourcekey="ddlPrintLocationResource2">
                                                                                                        </asp:DropDownList>
                                                                                                    </span>
                                                                                                </td>--%>
                                                                                            <td colspan="8">
                                                                                                <table class="w-100p">

                                                                                                    <tr>
                                                                                                        <td class="w-9p" nowrap="nowrap">
                                                                                                            <asp:CheckBoxList ID="chklstIdentity" runat="server" RepeatDirection="Horizontal"
                                                                                                                meta:resourcekey="chklstIdentityResource1" />
                                                                                                        </td>
                                                                                                        <td class="w-9p" nowrap="nowrap">
                                                                                                            <asp:CheckBox ID="Chkiscash" runat="server" Text="Cash Client?" meta:resourcekey="ChkiscashResource1" />
                                                                                                        </td>
                                                                                                        <td class="w-14p" nowrap="nowrap">
                                                                                                            <asp:CheckBox ID="chkisapproval" runat="server" Text="Invoice approval needed" onclick="DisplayRole(this.id);"
                                                                                                                meta:resourcekey="chkisapprovalResource1" />
                                                                                                        </td>
                                                                                                        <td class="w-12p" nowrap="nowrap">
                                                                                                            <asp:CheckBox ID="chkShowMappedItems" Text="Only Mapped Services?" runat="server"  meta:resourcekey="chkShowMappedItemsResource1" />
                                                                                                        </td>
                                                                                                        <td class="w-10p" nowrap="nowrap">
                                                                                                            <asp:CheckBox ID="chkDiscount" runat="server" Text="Allow Discount?" meta:resourcekey="chkDiscountResource1" />
                                                                                                        </td>
                                                                                                        <td class="w-8p" nowrap="nowrap">
                                                                                                            <asp:CheckBox ID="chkisparent" runat="server" onclick="funenableparent();" Text="Parent Client"
                                                                                                                meta:resourcekey="chkisparentResource1" />
                                                                                                        </td>
                                                                                                        <td class="w-32p" nowrap="nowrap">
                                                                                                            <%-- <asp:CheckBox ID="chkClientAccess" runat="server" Text="Is Client Access" />--%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td id="tdlblRole" style="display: none;" runat="server">
                                                                                                            <asp:Label ID="lblRole" runat="server" Text="Select Role Name" meta:resourcekey="lblRoleResource1"></asp:Label>
                                                                                                        </td>
                                                                                                        <td id="tdRole" runat="server" style="display: none;" colspan="2">
                                                                                                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="ddl" meta:resourcekey="ddlRoleResource1">
                                                                                                            </asp:DropDownList>
                                                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                        </td>
                                                                                                        <td id="td2AdColspan" colspan="2" style="display: none;" runat="server">
                                                                                                        </td>
                                                                                                        <td id="td4AdColspan" colspan="4" style="display: none;" runat="server">
                                                                                                        </td>
                                                                                                        <td id="isparentclient" runat="server" style="display: none;" colspan="3">
                                                                                                            <div>
                                                                                                                <asp:Label ID="Label12" runat="server" Text="Enter Parent Client " meta:resourcekey="Label12Resource1"></asp:Label><asp:TextBox
                                                                                                                    ID="txtparentClient" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                    MaxLength="50"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"  Width="170px"
                                                                                                                    meta:resourcekey="txtparentClientResource1"></asp:TextBox>&nbsp;<img align="middle"
                                                                                                                        alt="" src="../Images/starbutton.png" />
                                                                                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionInterval="1"
                                                                                                                    UseContextKey="True" CompletionListCssClass="wordWheel listMain .box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                                                                    CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                                                                                                    Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="SelectedClientValue"
                                                                                                                    ServiceMethod="GetClientNamebyClientType" ServicePath="~/WebService.asmx" TargetControlID="txtparentClient">
                                                                                                                </ajc:AutoCompleteExtender>
                                                                                                                <asp:CheckBox ID="chkDebtor" runat="server" Text="Is Debtor/Payer?" meta:resourcekey="chkDebtorResource1" />
                                                                                                            </div>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr> 
                                                                                                        <asp:RadioButtonList RepeatDirection="Horizontal"
                                                                    ID="rblSearchType" runat="server" RepeatColumns="3" >
                                                                      <asp:ListItem Text="Both" Value="0" Selected="True" meta:resourcekey="rblBothamtResource1" ></asp:ListItem>
                                                                    <asp:ListItem Text="Only Gross Amt" Value="1" meta:resourcekey="rblGrossamtResource1" ></asp:ListItem>
                                                                    <asp:ListItem Text="Only Net Amt" Value="2" meta:resourcekey="rblNetamtResource1" ></asp:ListItem> 
                                                                    </asp:RadioButtonList>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </asp:Panel>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td colspan="3">
                                                                                <table class="w-100p">
                                                                                    <tr>
                                                                                        <td valign="top">
                                                                                            <div id='TabsMenu1' align="left">
                                                                                                <ul>
                                                                                                    <li id="li1" class="active" onclick="DisplayTab('COM')" runat="server"><a href='#'><span>
                                                                                                        <asp:Label ID="lblCommercials" runat="server" Text="Commercials" meta:resourcekey="lblCommercialsResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li4" onclick="DisplayTab('NOT')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblNotification" runat="server" Text="Notification" meta:resourcekey="lblNotificationResource1"></asp:Label></span></a></li>
                                                                                                    <%--    <li id="li7" onclick="DisplayTab('DES')"><a href='#'><span>
                                                                                                            <asp:Label ID="lblDespatchMode" runat="server" Text="Despatch Mode" 
                                                                                                                meta:resourcekey="lblDespatchModeResource1"></asp:Label></span></a></li>--%>
                                                                                                    <li id="li2" onclick="DisplayTab('SHP')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblShippingInformation" runat="server" Text="Shipping Information"
                                                                                                            meta:resourcekey="lblShippingInformationResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li3" onclick="DisplayTab('CNT')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblContactInformtion" runat="server" Text="Contact Informtion" meta:resourcekey="lblContactInformtionResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li5" onclick="DisplayTab('REP')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblReports" runat="server" Text="Reports" meta:resourcekey="lblReportsResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li6" onclick="DisplayTab('TER')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblTerms" runat="server" Text="Terms" meta:resourcekey="lblTermsResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li8" onclick="DisplayTab('STA')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblClientStatus" runat="server" Text="Client Status" meta:resourcekey="lblClientStatusResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li9" onclick="DisplayTab('ATT')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblClientAttributes" runat="server" Text="Client Attributes" meta:resourcekey="lblClientAttributesResource1"></asp:Label></span></a></li>
                                                                                                    <li id="li7" onclick="DisplayTab('TD')"><a href='#'><span>
                                                                                                        <asp:Label ID="lblTaxDetails" runat="server" Text="Tax Details" meta:resourcekey="lblTaxDetailsResource"></asp:Label></span></a></li>
                                                                                                    <%-- client logo strats --%>
                                                                                                    <li id="li11" onclick="DisplayTab('Logo')" runat="server"><a href='#'><span>
                                                                                                        <asp:Label ID="lblClientLogo" runat="server" Text="Client Logo" meta:resourcekey="lblClientLogo1"></asp:Label></span></a></li>
                                                                                                    <%-- client logo ends --%>
                                                                                                    
                                                                                                    <%-- BEGIN || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                    <li id="li12" onclick="DisplayTab('CT')"><a href='#'><span>
                                                                                                            <asp:Label ID="lblCustomerTAT" runat="server" Text="Customer TAT" Width="80px"></asp:Label></span></a></li>
                                                                                                           <%-- END || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                </ul>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td nowrap="nowrap" class="a-right">
                                                                                            <div id="ExportXL" runat="server">
                                                                                                <asp:Label ID="lblExport" runat="server" Text="Export To Excel" Font-Bold="True"
                                                                                                    Font-Names="Verdana" Font-Size="9pt" meta:resourceKey="lblExportResource1"></asp:Label>
                                                                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                                                                <asp:ImageButton ID="ImageBtnExport" runat="server" Visible="true" ImageUrl="~/Images/ExcelImage.GIF"
                                                                                                    meta:resourcekey="imgBtnXLResource1" Style="width: 16px" OnClick="ImageBtnExport_Click" />
                                                                                            </div>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td valign="top" colspan="2">
                                                                                            <table class="w-100p">
                                                                                                <tr>
                                                                                                    <td id="tdCommercial" runat="server" valign="top">
                                                                                                        <asp:Panel ID="pnlCommercials" runat="server" CssClass="w-100p" meta:resourceKey="pnlCommercialsResource2">
                                                                                                            <table class="panelHeader w-100p bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                                                                                            <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_013%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td nowrap="nowrap">
                                                                                                                        <asp:Label ID="Label4" runat="server" Text="Credit Limit" meta:resourcekey="Label4Resource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtcreditlimit" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                            MaxLength="20"    onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                                            Width="70px" meta:resourcekey="txtcreditlimitResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <img src="../Images/starbutton.png" style="display: none" alt="" id="starimgCreditLimit"
                                                                                                                            align="middle" />
                                                                                                                    </td>
                                                                                                                    <td width="120">
                                                                                                                        <asp:Label ID="Label9" runat="server" Text="Credit Days" meta:resourcekey="Label9Resource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtCreditDays" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                            MaxLength="20"    onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                                            Width="70px" meta:resourcekey="txtCreditDaysResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <img src="../Images/starbutton.png" style="display: none" alt="" id="starimgCreditDays"
                                                                                                                            align="middle" />
                                                                                                                    </td>
                                                                                                                    <td nowrap="nowrap">
                                                                                                                    <%-- BEGIN || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                                        <%--<asp:Label ID="lblTransitTime" runat="server" Text="Transit Time" meta:resourcekey="lblTransitTimeResource1"></asp:Label>--%>
                                                                                                                        <%-- END || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                                    </td>
                                                                                                                    <td nowrap="nowrap">
                                                                                                                    <%-- BEGIN || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                                        <%--<asp:TextBox ID="txtTransitTime" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                            MaxLength="2"    onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                                            Width="70px" meta:resourcekey="txtTransitTimeResource1"></asp:TextBox>
                                                                                                                        <asp:DropDownList ID="ddlTransitTime" runat="server" CssClass="ddl" meta:resourcekey="ddlTransitTimeResource1">
                                                                                                                        </asp:DropDownList>--%>
                                                                                                                        <%-- END || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="Label10" runat="server" Text="Grace Limit" meta:resourcekey="Label10Resource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtgracelimit" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                            MaxLength="50" onkeypress="return ValidateOnlyNumeric(this);" Width="70px"
                                                                                                                            meta:resourcekey="txtgracelimitResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="Label11" Text="Grace Days" runat="server" meta:resourcekey="Label11Resource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtgracedays" runat="server" MaxLength="50" CssClass="Txtboxsmall"
                                                                                                                            AutoComplete="off" onkeypress="return ValidateOnlyNumeric(this);"
                                                                                                                            Width="70px" meta:resourcekey="txtgracedaysResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="Label13" runat="server" Text="”Promised Business Amount" meta:resourceKey="Label13Resource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td nowrap="nowrap">
                                                                                                                        <asp:TextBox ID="txtPromisedAmount" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                            MaxLength="20"    onkeypress="return ValidateOnlyNumeric(this);"   
                                                                                                                            Width="70px" meta:resourceKey="txtPromisedAmountResource1"></asp:TextBox>
                                                                                                                        <span>/<%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_062%></span>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                <td>
                                                                                                                <asp:label id="PendingCreditLimit" runat="server" Text="Pending Credit Limit" ></asp:label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                 <asp:TextBox ID="txtPendingCreditlimit" runat="server" MaxLength="50" CssClass="Txtboxsmall"
                                                                                                                       Enabled="false"     AutoComplete="off"     Width="70px" ></asp:TextBox>
                                                                                                                </td>
                                                                                                                <td></td>
                                                                                                                <td>
                                                                                                                 <asp:label id="SAPDue" runat="server" Text="SAP Due"></asp:label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                <asp:TextBox ID="txtSapDue" runat="server" MaxLength="50" CssClass="Txtboxsmall"
                                                                                                                       Enabled="false"     AutoComplete="off"     Width="70px" ></asp:TextBox>
                                                                                                                </td>
                                                                                                                <td></td>
                                                                                                                <td>
                                                                                                                 <asp:label id="NotInvoiced" runat="server" Text="Not Invoiced"></asp:label>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                <asp:TextBox ID="txtnotInvoiced" runat="server" MaxLength="50" CssClass="Txtboxsmall"
                                                                                                                   Enabled="false"         AutoComplete="off"     Width="70px" ></asp:TextBox>
                                                                                                                </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                <td>
                                                                                                                <asp:CheckBox ID="chkCreditLimit" runat="server" Text="Use ThresHold For Credit Limit" />
                                                                                                                </td>
                                                                                                                <td colspan="2">
                                                                                                                 <asp:label id="lblBlockDate" runat="server" Text="Valid To :" style="display:none"></asp:label>
                                                                                                                 <asp:label id="lblValidTo" runat="server" Text="" style="display:none"></asp:label>
                                                                                                                </td>
                                                                                                                </tr>
                                                                                                               
                                                                                                                <tr>
                                                                                                                <td colspan="8">
                                                                                                                        <asp:Panel ID="pnlAdvanceDeposite" runat="server" GroupingText="ADVANCE DEPOSITE"
                                                                                                                            Width="100%" meta:resourcekey="pnlAdvanceDepositeResource1">
                                                                                                                                <table class="w-100p">
                                                                                                                                    <tr>
                                                                                                                                        <td>
                                                                                                                                            <asp:CheckBox ID="IsAdvanceClient" runat="server" Text="IsAdvanceClient" meta:resourcekey="IsAdvanceClientResource1" />
                                                                                                                                        </td>
                                                                                                                                        <td colspan="7">
                                                                                                                                        </td>
                                                                                                                                    </tr>
                                                                                                                                    <tr>
                                                                                                                                        <td class="w-20p">
                                                                                                                                        <asp:RadioButtonList ID="rdThreadsHold1" runat="server" RepeatDirection="Horizontal"
                                                                                                                                            meta:resourceKey="rdThreadsHold1Resource1">
                                                                                                                                            <%--<asp:ListItem Selected="True" meta:resourceKey="ListItemResource4">Threshold amount in value </asp:ListItem>--%>
                                                                                                                                        </asp:RadioButtonList>
                                                                                                                                            <%--<input type="radio" runat="server" id="rdThreadsHold1" name="Threadshold %" value="INV1"
                                                                                                                                                onclick="return RadioValidator();" />
                                                                                                                                            <input type="radio" runat="server" id="rdThreadsHold2" name="Threadshold Amount"
                                                                                                                                                value="INV2" />onchange="return ThresHoldValidation();"--%>
                                                                                                                                        </td>
                                                                                                                                        <td>
                                                                                                                                       <table class="w-100p">
                                                                                                                                       <tr>
                                                                                                                                           <td>
                                                                                                                                                    <asp:Label ID="Label15" runat="server" Text="Threshold amount1" meta:resourceKey="Label15Resource1"></asp:Label>
                                                                                                                                           </td>
                                                                                                                                           <td>
                                                                                                                                               <asp:TextBox ID="txtThreadshold" runat="server" CssClass="Txtboxsmall" 
                                                                                                                                                   onblur="return thresHoldValidate();" 
                                                                                                                                                      onkeypress="return ValidateOnlyNumeric(this);"   meta:resourceKey="txtThreadsholdResource1"></asp:TextBox>
                                                                                                                                           </td>
                                                                                                                                           <td>
                                                                                                                                                    <asp:Label ID="Label16" runat="server" Text="Threshold amount2" meta:resourceKey="Label16Resource1"></asp:Label>
                                                                                                                                           </td>
                                                                                                                                           <td>
                                                                                                                                               <asp:TextBox ID="txtThreadshold2" runat="server" CssClass="Txtboxsmall" 
                                                                                                                                                   onblur="return thresHoldValidate();" 
                                                                                                                                                      onkeypress="return ValidateOnlyNumeric(this);"  ></asp:TextBox>
                                                                                                                                           </td>
                                                                                                                                           <td>
                                                                                                                                                    <asp:Label ID="Label17" runat="server" Text="Threshold amount3" meta:resourceKey="Label17Resource1"></asp:Label>
                                                                                                                                           </td>
                                                                                                                                           <td>
                                                                                                                                               <asp:TextBox ID="txtThreadshold3" runat="server" CssClass="Txtboxsmall" 
                                                                                                                                                    onblur="return thresHoldValidate();" 
                                                                                                                                                       onkeypress="return ValidateOnlyNumeric(this);"   meta:resourceKey="txtThreadshold3Resource1"></asp:TextBox>
                                                                                                                                           </td>
                                                                                                                                       </tr>
                                                                                                                                       </table>
                                                                                                                                       </td>
                                                                                                                                        <td align="right">
                                                                                                                                            &nbsp;
                                                                                                                                        </td>
                                                                                                                                        
                                                                                                                                       
                                                                                                                                    </tr>
                                                                                                                                   
                                                                                                                                           
                                                                                                                                            <tr style="display:none;">
                                                                                                                                                <td>
                                                                                                                                        <asp:RadioButtonList ID="rdVirtualCredit1" runat="server" RepeatDirection="Horizontal"
                                                                                                                                            meta:resourceKey="rdVirtualCredit1Resource1">
                                                                                                                                           <%-- <asp:ListItem meta:resourceKey="ListItemResource5">Virtual Credit % </asp:ListItem>--%>
                                                                                                                                            <%--<asp:ListItem Selected="True" meta:resourceKey="ListItemResource6">Virtual Credit Amt</asp:ListItem>--%>
                                                                                                                                        </asp:RadioButtonList>
                                                                                                                                                </td>
                                                                                                                                                <td>
                                                                                                                                                    <asp:TextBox ID="txtVirtualCredit" runat="server" CssClass="Txtboxsmall" 
                                                                                                                                                           onkeypress="return ValidateOnlyNumeric(this);"   meta:resourceKey="txtVirtualCreditResource1"></asp:TextBox>
                                                                                                                                                </td>
                                                                                                                                                <td colspan="6">
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                            <tr style="display:none;">
                                                                                                                                                <td align="right">
                                                                                                                                        <asp:Label ID="lblminAdvance" runat="server" Text="Minimum Advance" meta:resourceKey="lblminAdvanceResource1"></asp:Label>
                                                                                                                                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                                                                                </td>
                                                                                                                                                <td>
                                                                                                                                                    <asp:TextBox ID="txtminAdvance" runat="server" CssClass="Txtboxsmall" 
                                                                                                                                                           onkeypress="return ValidateOnlyNumeric(this);"      meta:resourceKey="txtminAdvanceResource1"></asp:TextBox>
                                                                                                                                                </td>
                                                                                                                                                <td>
                                                                                                                                        <asp:Label ID="lblmiaxAdvance" runat="server" Text="Maximum Advance" meta:resourceKey="lblmiaxAdvanceResource1"></asp:Label>
                                                                                                                                                </td>
                                                                                                                                                <td>
                                                                                                                                                    <asp:TextBox ID="txtmaxAdvance" runat="server" CssClass="Txtboxsmall" 
                                                                                                                                                           onkeypress="return ValidateOnlyNumeric(this);"   meta:resourceKey="txtmaxAdvanceResource1"></asp:TextBox>
                                                                                                                                                </td>
                                                                                                                                            </tr>
                                                                                                                                        </tr>
                                                                                                                                    </tr>
                                                                                                                                </table>
                                                                                                                            </asp:Panel>
                                                                                                                </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                   
                                                                                                                                            <td>
                                                                                                                                                <asp:Panel ID="Panel2" runat="server" meta:resourcekey="Panel2Resource1">
                                                                                                                                                    <asp:CheckBoxList ID="chkClientAttributes" runat="server" meta:resourcekey="chkClientAttributesResource1"
                                                                                                                                                        RepeatDirection="Horizontal" />
                                                                                                                                                </asp:Panel>
                                                                                                                                            </td>
                                                                                                                                            <td>
                                                                                                                                            </td>
                                                                                                                    <td style="display: none" rowspan="2" colspan="6">
                                                                                                                        <asp:Panel ID="Panel7" runat="server" GroupingText="PAYMENT MODE" meta:resourcekey="Panel7Resource1">
                                                                                                                            <asp:CheckBoxList ID="chkPaymentMode" runat="server" RepeatColumns="5" RepeatDirection="Horizontal"
                                                                                                                                meta:resourcekey="chkPaymentModeResource1" />
                                                                                                                        </asp:Panel>
                                                                                                                    </td>
                                                                                                                                        </tr>
                                                                                                                                        <tr>
                                                                                                                    <td class="w-20p" nowrap="nowrap">
                                                                <asp:Label ID="lblInvoiceCycle" runat="server" Text="InvoiceCycle" meta:resourceKey="lblInvoiceCycleResource1"></asp:Label>
                                                                                                                                            </td>
                                                                                                                                            <td>
                                                                                                                                                <asp:DropDownList ID="ddlInvoiceCycle" CssClass="ddl" runat="server">
                                                                                                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="w-20p" nowrap="nowrap">
                                                                <asp:Label ID="lblftppath" runat="server" Text="FTP Path" meta:resourceKey="lblftppathResource1"></asp:Label>
                                                                <asp:TextBox ID="Txtftppath" runat="server" MaxLength="20" onkeypress="return blockSpecialChar(event)"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblTax" Text="Add Tax Name" runat="server" meta:resourcekey="lblTaxResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtTaxName" runat="server" MaxLength="50" CssClass="AutoCompletesearchBox"
                                                                                                                            AutoComplete="off" onBlur="CheckTaxName('TAX',this.id);" onchange="javascript:return ClearFields('TAX');" meta:resourceKey="txtTaxNameResource2"></asp:TextBox>
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender8" runat="server" TargetControlID="txtTaxName"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTODCodeAndID"
                                                                                                                            OnClientItemSelected="GetTaxID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                                            Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblDiscountPolicy" Text="Add Discount Policy" runat="server" meta:resourcekey="lblDiscountPolicyResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtPolicyName" runat="server" CssClass="AutoCompletesearchBox" AutoComplete="off"
                                                                                                                            onBlur="CheckTaxName('Pol',this.id);" 
                                                                                                                            meta:resourcekey="txtPolicyNameResource1"></asp:TextBox>
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender11" runat="server" TargetControlID="txtPolicyName"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTODCodeAndID"
                                                                                                                            OnClientItemSelected="GetPolicyID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                                            Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                <asp:Label ID="lblvol" Text="Volume Based Discount" runat="server" meta:resourceKey="lblvolResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtvolume" runat="server" MaxLength="50" CssClass="AutoCompletesearchBox"
                                                                                                                            AutoComplete="off" Width="70px" onBlur="CheckTaxName('Vol',this.id);" onchange="javascript:return ClearFields('Vol');" meta:resourceKey="txtvolumeResource1"></asp:TextBox>
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender13" runat="server" TargetControlID="txtvolume"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTODCodeAndID"
                                                                                                                            OnClientItemSelected="GetToVolID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                                            Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblTOD" Text="Turn Over Discount" runat="server" meta:resourcekey="lblTODResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtTODCode" runat="server" MaxLength="50" CssClass="AutoCompletesearchBox"
                                                                                                                            AutoComplete="off" Width="70px" onBlur="CheckTaxName('TUN',this.id);" onchange="javascript:return ClearFields('TUN');" meta:resourceKey="txtTODCodeResource2"></asp:TextBox>
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender7" runat="server" TargetControlID="txtTODCode"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                                                            MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTODCodeAndID"
                                                                                                                            OnClientItemSelected="GetTodID" ServicePath="~/WebService.asmx" DelimiterCharacters=""
                                                                                                                            Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:LinkButton ID="lnkviewtestdetails" runat="server" Text="ViewTestDetails" ForeColor="Blue"
                                                                                                                            Font-Underline="True" OnClick="lnkviewtestdetails_Click" OnClientClick="return checkclientname();"  meta:resourceKey="lnkviewtestdetailsResource1">                                                                                                           
                                                                                                                        </asp:LinkButton>
                                                                                                                    </td>
                                                                                                                    <td colspan="7">
                                                                                                                        <table class="w-100p">
                                                                                                                            <tr>
                                                                                                                                <td class="w-30p">
                                                                                                                                    <div id="divTax" runat="server" style="height: 80px; overflow: auto; overflow-x: hidden;">
                                                                                                                                    </div>
                                                                                                                                </td>
                                                                                                                                <td class="w-60p">
                                                                                                                                </td>
                                                                                                                            </tr>
                                                                                                                        </table>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdShip" runat="server">
                                                                                                        <asp:Panel ID="Panel4" runat="server" meta:resourceKey="Panel4Resource2">
                                                                                                            <table class="panelHeader w-100p bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                               <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_017%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblAddressType" runat="server" >
                                                                                                                        <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_032%>
                                                                                                                        </asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="width: 260px;">
                                                                                                                        <asp:DropDownList runat="server" Width="175px" ID="drpaddresstype" CssClass="ddl"
                                                                                                                            meta:resourcekey="drpaddresstypeResource1">
                                                                                                                        </asp:DropDownList>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lbladd1" Text="Address" runat="server" meta:resourcekey="lbladd1Resource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="width: 220px;">
                                                                                                                        <asp:TextBox ID="txtaddres1" runat="server" MaxLength="100" TextMode="MultiLine"
                                                                                                                            CssClass="Txtboxsmall" AutoComplete="off"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateRestrictedSpecialAndNumeric(this);" onpaste="return false "
                                                                                                                            Width="170px" meta:resourcekey="txtaddres1Resource1"></asp:TextBox>&nbsp;<img src="../Images/starbutton.png"
                                                                                                                                alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblSubUrban" Text="Suburb" runat="server" meta:resourcekey="lblSubUrbanResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td width="170px">
                                                                                                                        <asp:TextBox ID="txtSubUrban" runat="server" Width="170px" CssClass="Txtboxsmall"
                                                                                                                            AutoComplete="off" meta:resourcekey="txtSubUrbanResource1" onkeypress="return checksign(this);" onpaste="return false;"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblcity" Text="City" runat="server" onkeydown=" return isNumerics(event,this.id)"
                                                                                                                            meta:resourcekey="lblcityResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtciti" runat="server" MaxLength="50" CssClass="Txtboxsmall" Width="170px"
                                                                                                                            AutoComplete="off"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" onpaste="return false;"
                                                                                                                            meta:resourcekey="txtcitiResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblCountry" Text="Country" runat="server" meta:resourcekey="lblCountryResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="width: 260px;">
                                                                                                                        <asp:DropDownList ID="drpCountry" runat="server" CssClass="ddl" Width="175px" onchange="javascript:loadState();"
                                                                                                                            meta:resourcekey="drpCountryResource1" />
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblState" Text="State" runat="server" meta:resourcekey="lblStateResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="width: 220px;">
                                                                                                                        <asp:DropDownList ID="drpState" runat="server" CssClass="ddl" Width="175px" onchange="javascript:onchangeState();"
                                                                                                                            meta:resourcekey="drpStateResource1" />
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="Rs_EmailID" Text="Report Email-ID" runat="server" meta:resourcekey="Rs_EmailIDResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td width="170px">
                                                                                                                        <asp:TextBox ID="txtEmailID" runat="server" Width="170px" CssClass="Txtboxsmall"
                                                                                                                            AutoComplete="off" 
                                                                                                                            onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');"
                                                                                       meta:resourcekey="txtEmailIDResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td colspan="2">
                                                                                                                        <img src="../Images/starbutton.png" id="starimgEmail" style="display: none" runat="server"
                                                                                                                            align="middle" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblMobile" Text="Mobile" runat="server" meta:resourcekey="lblMobileResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="width: 220px;">
                                                                                                                        <asp:Label ID="lblCountryCode" runat="server" meta:resourcekey="lblCountryCodeResource1"></asp:Label>&nbsp;
                                                                                                                        <asp:TextBox ID="txtmobileno" runat="server" CssClass="Txtboxsmall" Width="142px"
                                                                                                                            AutoComplete="off" onkeydown=" return isNumeric(event,this.id);" meta:resourcekey="txtmobilenoResource1" />
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="Rs_LandLine" Text="LandLine" runat="server" meta:resourcekey="Rs_LandLineResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="width: 220px;">
                                                                                                                        <asp:TextBox ID="txtPhoneNumber" runat="server" MaxLength="15" Width="170px" CssClass="Txtboxsmall"
                                                                                                                            AutoComplete="off" onkeydown="return isNumeric(event,this.id);" meta:resourcekey="txtPhoneNumberResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td style="width: 120px;">
                                                                                                                        <asp:Label ID="lblfaxno" Text="Fax No" runat="server" meta:resourcekey="lblfaxnoResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td colspan="2">
                                                                                                                        <asp:TextBox ID="txtfax" runat="server" MaxLength="20" CssClass="Txtboxsmall" AutoComplete="off"
                                                                                                                            onkeydown=" return isNumeric(event,this.id);" Width="170px" meta:resourcekey="txtfaxResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                <td style="width: 120px;">
                                                                                                                        <asp:Label ID="Label18" Text="Invoice Email" runat="server" ></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td colspan="2">
                                                                                                                        <asp:TextBox ID="txtInvoiceEmail" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                                                                                                            Width="170px" 
                                                                                                                            
                                                                                                                            onblur="javascript:return validateMultipleEmailsCommaSeparated(this,',');"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td colspan="7" class="a-right">
                                                                                                                        <asp:CheckBox ID="chkIsCommunication" runat="server" Text="Primary" onclick="chectisprimary();"
                                                                                                                            meta:resourcekey="chkIsCommunicationResource1" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Button ID="btnAdd" runat="server" Text="Add" CssClass="btn" OnClientClick="return checkCustomerAddress();"
                                                                                                                             meta:resourcekey="btnAddResource1" />
                                                                                                                        <%--<input type="button" id="btnAdd" class="btn" style="width: 60px; height: 20px;" value="Add"
                                                                                                                                onclick="checkCustomerAddress();" />--%>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr class="tablerow">
                                                                                                                    <td colspan="8">
                                                                                                                        <div id="divaddressdetails" runat="server" class="h-100p" style="display: none; overflow: auto;
                                                                                                                            overflow-x: hidden;">
                                                                                                                            <table class="w-100p gridView" id="tblClientDetail" runat="server" style="background-color: White;
                                                                                                                                border: 1,1,1,1;">
                                                                                                                            </table>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdContact" class="searchPanel" runat="server">
                                            <asp:Panel ID="pnlCntPrsn" runat="server" Height="200px" Width="820px" meta:resourceKey="pnlCntPrsnResource2">
                                                                                                            <table class="w-100p bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="5" class="padding5">
                                                                                                                        <p class="bold">
                                                                <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_018%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblContactType" Text="Contact Type" runat="server" meta:resourcekey="lblContactTypeResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:DropDownList runat="server" ID="drplstPerson" Width="170px" CssClass="ddl" onChange="SetContextKey();"
                                                                                                                            meta:resourcekey="drplstPersonResource1">
                                                                                                                        </asp:DropDownList>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblPersonName" Text="Name" runat="server" meta:resourcekey="lblPersonNameResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td style="display: table-cell;" id="tdtxtPrsn">
                                                                                                                        <asp:TextBox ID="txtPersonName" runat="server" CssClass="Txtboxsmall" Width="170px"
                                                                                                                            meta:resourcekey="txtPersonNameResource1"></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                        <ajc:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" TargetControlID="txtPersonName"
                                                                                                                            EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" FirstRowSelected="True"
                                                                                                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" ServiceMethod="GetSpecifiedDeptEmployee"
                                                                                                                            OnClientItemSelected="GetEmpID" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                                                                                            DelimiterCharacters="" Enabled="True">
                                                                                                                        </ajc:AutoCompleteExtender>
                                                                                                                    </td>
                                                                                                                    <td style="display: none;" id="tdtxtClnt">
                                                                                                                        <asp:TextBox ID="txtCntClient" runat="server" CssClass="Txtboxsmall" Width="170px"
                                                                                                                            meta:resourcekey="txtCntClientResource1"></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                        &nbsp;<asp:Label ID="alert" runat="server" ForeColor="Red" meta:resourcekey="alertResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblPrsnMobile" Text="Mobile Number" runat="server" meta:resourcekey="lblPrsnMobileResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtPrsnMobile" runat="server" CssClass="Txtboxsmall" AutoComplete="off"
                                                                                                                            onkeydown=" return isNumeric(event,this.id);" Width="170px" meta:resourcekey="txtPrsnMobileResource1" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                            <asp:Label ID="lblPrsnLandNo" Text="LandLine" runat="server" meta:resourcekey="lblPrsnLandNoResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtPrsnLandNo" runat="server" MaxLength="15" CssClass="Txtboxsmall"
                                                                                                                            AutoComplete="off" onkeydown="return isNumeric(event,this.id);" Width="170px"
                                                                                                                            meta:resourcekey="txtPrsnLandNoResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <asp:Label ID="lblPrsnEmail" Text="Email ID" runat="server" meta:resourcekey="lblPrsnEmailResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:TextBox ID="txtPrsnEmail" runat="server" Width="170px" CssClass="Txtboxsmall"
                                                                                                                            AutoComplete="off" onblur="checkMailId();" meta:resourcekey="txtPrsnEmailResource1"></asp:TextBox>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:CheckBox ID="chkPrsnPrimary" runat="server" Text="Primary" onclick="chckPrsnPrimary();"
                                                                                                                            meta:resourcekey="chkPrsnPrimaryResource1" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Button ID="btnPrsnAdd" runat="server" Text="Add Details" CssClass="btn" OnClientClick="return AddContactPerson();"
                                                                                                                            meta:resourcekey="btnPrsnAddResource1" />
                                                                                                                        <%--<input type="button" id="btnPrsnAdd" class="btn" value="Add Details" onclick="return AddContactPerson();" />--%>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td id="tdPrsnDetails" style="display: none;" colspan="4">
                                                                                                                        <div id="divPrsnDetails" runat="server" class="w-80" style="overflow: auto; overflow-x: hidden;
                                                                                                                            width: 810px">
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdNotify" runat="server">
                                                                                                        <table class="w-100p v-top bg-row">
                                                                                                            <tr class="colorforcontent">
                                                                                                                <td colspan="8" class="padding5">
                                                                                                                    <p class="bold">
                                                            <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_019%> </p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr class="v-top">
                                                                                                                <td>
                                                                                                                    <asp:Panel ID="pnlNotify" runat="server">
                                                                                                                        <asp:CheckBoxList ID="chkNotification" runat="server" RepeatDirection="Horizontal" RepeatColumns="8"
                                                                                                                            onclick="ReportPrintChanged(this);" meta:resourcekey="chkNotificationResource1" />
                                                                                                                    </asp:Panel>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr id="ReportPrintFrom" runat="server" class="v-top" style="display: table-row;">
                                                                                                                <td>
                                                                                                                    <table>
                                                                                                                        <tr>
                                                                                                                            <td class="w-100 a-right">
                                                                                                                                <asp:Label ID="Label14" Text="Report Print From" runat="server" meta:resourcekey="Label14Resource1" ></asp:Label>
                                                                                                                            </td>
                                                                                                                            <td class="w-80">
                                                                                                                                <asp:TextBox Width="60px" ID="TxtRptPrintFrom" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                                                                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                            </td>
                                                                                                                        </tr>
                                                                                                                    </table>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr class="colorforcontent">
                                                                                                                <td colspan="8" class="padding5">
                                                                                                                    <p class="bold">
                                                            <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_020%> </p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr class="v-top">
                                                                                                                <td>
                                                        <asp:Panel ID="pnlinvoicenoti" runat="server" meta:resourceKey="pnlinvoicenotiResource1">
                                                                                                                        <asp:CheckBoxList ID="chkDespatch" runat="server" RepeatColumns="7" RepeatDirection="Horizontal"
                                                                                                                            onClick="EnableMadatory();" meta:resourcekey="chkDespatchResource1" />
                                                                                                                    </asp:Panel>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdReports" runat="server">
                                            <asp:Panel ID="pnlReport" runat="server" meta:resourceKey="pnlReportResource2">
                                                                                                            <table class="w-100p bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                                <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_021%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td class="w-15p">
                                                            <asp:Label ID="Label3" Text="Invoice Report Format" runat="server" meta:resourceKey="Label3Resource2"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-15p">
                                                                                                                        <asp:DropDownList ID="drpreportformat" runat="server" Width="175px" CssClass="ddl"
                                                                                                                            meta:resourcekey="drpreportformatResource1">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </td>
                                                                                                                    <td style="display: none">
                                                                                                                        <asp:CheckBoxList ID="chklstReport" runat="server" RepeatDirection="Horizontal" meta:resourcekey="chklstReportResource1" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                            <asp:Panel ID="pnlResultReport" runat="server" Height="50px" meta:resourceKey="pnlResultReportResource1">
                                                                                                            <table class="w-100p bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                                <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_022%></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td class="w-15p">
                                                            <asp:Label ID="lblStationery" Text="Stationery Type" runat="server" meta:resourceKey="lblStationeryResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-15p">
                                                                                                                        <asp:DropDownList ID="ddlStationery" runat="server" Width="175px" CssClass="ddl">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                        <asp:Panel ID="pnlrepang" runat="server">
                                                                                                            <table class="w-100p bg-row">
                                                                                                            <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                                                                                         <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_069%></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td id="tdreplang" runat="server" class="w-15p">
                                                                                                                        <asp:Label ID="lblreplang" runat="server" Text="Report Language" meta:resourcekey="lblreplangResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td id="tdddreplang" runat="server" class="w-15p">
                                                                                                                        <asp:DropDownList CssClass="ddlsmall" ID="ddlreplang" runat="server">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </td>
                                                                                                                    <td class="w-15p">
                                                                                                                        <asp:Label ID="lblnoofprint" runat="server" Text="Number of copies to print"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-15p">
                                                                                                                    <asp:TextBox ID="txtnoofprint" runat="server" ></asp:TextBox>
                                                                                                                    </td>
                                                                                                                     <td>
                                                                                                                        <asp:Button ID="btnAddlang" runat="server" Text="Add" CssClass="btn" OnClientClick="return AddReportLanguage();"
                                                                                                                             meta:resourcekey="btnAddlangResource1" />
                                                                                                                        <%--<input type="button" id="btnAdd" class="btn" style="width: 60px; height: 20px;" value="Add"
                                                                                                                                onclick="checkCustomerAddress();" />--%>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                 <tr class="tablerow">
                                                                                                                    <td colspan="5">
                                                                                                                        <div id="divreplang" runat="server" class="h-100p" style="display: none; overflow: auto;
                                                                                                                            overflow-x: hidden;">
                                                                                                                            <table class="w-100p gridView" id="tblreportlang" runat="server" style="background-color: White;
                                                                                                                                border: 1,1,1,1;">
                                                                                                                            </table>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                         <asp:Panel ID="pnlbilltype" runat="server" Height="50px" meta:resourceKey="pnlResultReportResource1" Visible="false">
                                                                                                            <table class="w-100p bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                               Bill Type</p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td class="w-15p">
                                                                                                           <asp:Label ID="Label19" Text="Bill Type" runat="server"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-15p">
                                                                                                                        <asp:DropDownList ID="ddlbilltype" runat="server" Width="175px" CssClass="ddl">
                                                                                                                        </asp:DropDownList>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdTerms" runat="server">
                                                                                                        <asp:Panel ID="pnlTerms" runat="server" Height="200px" meta:resourcekey="pnlTermsResource1">
                                                                                                            <table class="w-100p">
                                                                                                                <tr>
                                                                                                                    <td class="v-top w-10p">
                                                                                                                        <asp:Label ID="lbltermsconditions" Text="Terms & Conditions" runat="server" meta:resourcekey="lbltermsconditionsResource1"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="v-top w-80p">
                                                                                                                        <FCKeditorV2:FCKeditor ID="fckInvDetailss" runat="server" Width="500px" Height="180px">
                                                                                                                        </FCKeditorV2:FCKeditor>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdCStatus" runat="server" style="display: none;">
                                                                                                        <div id="divClientStatus" runat="server">
                                                                                                            <asp:Panel ID="Panel5" runat="server" Height="165px" meta:resourcekey="Panel5Resource1">
                                                                                                                <table id="Table1" runat="server" class="v-top w-100p">
                                                                                                                    <tr id="Tr1" runat="server">
                                                                                                                        <td id="tdlblReason" runat="server" colspan="4">
                                                                                                                            <asp:Label ID="lblReasonTxt" runat="server" Font-Bold="True" Font-Underline="True"
                                                                                                                                ForeColor="Red"></asp:Label>
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                    <tr id="Tr2" runat="server">
                                                                                                                        <td class=" w-15p" id="tdClientSt" runat="server">
                                                                                                                            <table align="left">
                                                                                                                                <tr>
                                                                                                                                    <td id="tdlblCStatus" runat="server" style="display: none;" class="w-80p">
                                                                                                                                        <asp:Label ID="lblCltStatus" runat="server" Text="Client Status" meta:resourcekey="lblCltStatusResource1"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td style="display: none;" id="tdClientStatus" runat="server">
                                                                                                                                        <asp:DropDownList ID="ddlClientStatus" onChange="GetReason();" CssClass="ddl" runat="server"
                                                                                                                                            meta:resourcekey="ddlClientStatusResource1">
                                                                                                                                        </asp:DropDownList>
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                            </table>
                                                                                                                        </td>
                                                                                                                        <td id="tdReasonBlock" style="display: none" class="w-40p" runat="server">
                                                                                                                            <table align="left">
                                                                                                                                <tr>
                                                                                                                                    <td>
                                                                                                                                        <asp:Label runat="server" Text="Reason" ID="lblReason" meta:resourcekey="lblReasonResource1"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td class="v-middle">
                                                                                                                                        <asp:DropDownList ID="drpReason" runat="server" CssClass="ddl">
                                                                                                                                        </asp:DropDownList>
                                                                                                                                    </td>
                                                                                                                                    <td class="a-left">
                                                                                                                                        &nbsp;<img src="../Images/starbutton.png" id="imgStarReason" align="middle" runat="server" />
                                                                                                                                    </td>
                                                                                                                                    <td>
                                                                                                                                        <asp:Label ID="lblAuthorizedBy" runat="server" Text="Authorized By" meta:resourcekey="lblAuthorizedByResource1"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td>
                                                                                                                                        <asp:DropDownList ID="ddlAuthorizedBy" runat="server" CssClass="ddl">
                                                                                                                                        </asp:DropDownList>
                                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                            </table>
                                                                                                                        </td>
                                                                                                                        <td id="tdBlockDate" style="display: none" class="w-35p" runat="server">
                                                                                                                            <table align="left">
                                                                                                                                <tr>
                                                                                                                                    <td class="a-top w-25p">
                                                                                                                                        <asp:Label ID="lblFrom" Text="Blocked From" runat="server" meta:resourcekey="lblFromResource1"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td class="w-65">
                                                                                                                                        <asp:TextBox Width="60px" ID="txtFDate"  ReadOnly="true" CssClass="Txtboxsmall" runat="server"></asp:TextBox>
                                                                                                                                    </td>
                                                                                                                                    <td class="w-3">
                                                                                                                                        &nbsp;<img src="../Images/starbutton.png" id="img2" align="middle" runat="server" />
                                                                                                                                    </td>
                                                                                                                                    <td class="w-100 a-right">
                                                                                                                                        <asp:Label ID="lblblockedto" Text="Blocked To" runat="server" meta:resourcekey="lblblockedtoResource1"></asp:Label>
                                                                                                                                    </td>
                                                                                                                                    <td class="w-60">
                                                                                                                                        <asp:TextBox ID="txtTDate" MaxLength="10" CssClass="Txtboxsmall" Width="60px" runat="server"></asp:TextBox>
                                                                                                                                    </td>
                                                                                                                                    <td class="w-3">
                                                                                                                                        &nbsp;<img src="../Images/starbutton.png" id="img1" align="middle" runat="server" />
                                                                                                                                    </td>
                                                                                                                                </tr>
                                                                                                                            </table>
                                                                                                                        </td>
                                                                                                                        <td style="display: none;" id="tdSendSMS" runat="server" class="w-8p">
                                                                                                                            <asp:CheckBox ID="chkSndSMS" runat="server" Text="Send SMS" meta:resourcekey="chkSndSMSResource1" />
                                                                                                                        </td>
                                                                                                                        <td class="w-5p a-right" id="tdHistory" runat="server" style="display: none;">
                                                                                                                            <img src="../Images/Hist2.png" alt="Client Status History" width="20" height="20"
                                                                                                                                align="top" onclick="return ShowPopUP();" style="cursor: pointer;" />
                                                                                                                        </td>
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </asp:Panel>
                                                                                                        </div>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdDespt" runat="server">
                                                                                                        <asp:Panel ID="Panel3" runat="server" GroupingText="DESPATCH MODE" Height="200px"
                                                                                                            meta:resourcekey="Panel3Resource1">
                                                                                                            <%--   <asp:CheckBoxList ID="chkDespatch" runat="server" RepeatColumns="7" RepeatDirection="Horizontal"
                                                                                                                    onClick="EnableMadatory();" meta:resourcekey="chkDespatchResource1" />--%></asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td id="tdAttribs" runat="server">
                                                                                                        <asp:Panel ID="pnlAttribs" runat="server" meta:resourcekey="pnlAttribsResource1">
                                                                                                            <table class="w-100p">
                                                                                                                <tr>
                                                                                                                    <td valign="top" align="left">
                                                                                                                        <div id="Div1" runat="server" style="display: block;">
                                                                                                                            &nbsp;<img src="../Images/ShowBids.gif" alt="Show" width="15" height="15" align="top"
                                                                                                                                style="cursor: pointer" onclick="showResponses('Div1','Div2','divLocation',1);" />
                                                                                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div1','Div2','divLocation',1);">
                                                                                                                                <asp:Label ID="Label1" ForeColor="Black" Text="Click To Add Client Attributes" Font-Underline="True"
                                                                                                                                    runat="server" meta:resourcekey="Label1Resource1"></asp:Label></span></div>
                                                                                                                        <div id="Div2" runat="server" style="display: none;">
                                                                                                                            &nbsp;<img src="../Images/HideBids.gif" alt="hide" width="15px" height="15px" align="top"
                                                                                                                                style="cursor: pointer" onclick="showResponses('Div1','Div2','divLocation',0);" />
                                                                                                                            <span class="dataheader1txt" style="cursor: pointer" onclick="showResponses('Div1','Div2','divLocation',0);">
                                                                                                                                <asp:Label ID="Label2" ForeColor="Black" Text="Hide" Font-Underline="True" runat="server"
                                                                                                                                    meta:resourcekey="Label2Resource1"></asp:Label></span></div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <div id="divLocation" runat="server">
                                                                                                                            <asp:Panel ID="tblPanel" CssClass="mytable1 gridView" runat="server" Height="200px"
                                                                                                                                meta:resourcekey="tblPanelResource1">
                                                                                                                                <table id="tblclientatt" runat="server" width="100%">
                                                                                                                                    <tr id="Tr3" runat="server">
                                                                                                                                        <td id="Td1" runat="server">
                                                                                                                                            <table class="w-100p">
                                                                                                                                                <tr id="Tr4" runat="server">
                                                                                                                                                    <td id="Td8" runat="server">
                                                                                                                                                        <asp:Label ID="Rs_SelectAttributes" Text="Attributes" runat="server" meta:resourcekey="Rs_SelectAttributesResource1"></asp:Label>
                                                                                                                                                    </td>
                                                                                                                                                    <td id="Td9" runat="server">
                                                                                                                                                        <asp:TextBox ID="txtClientAttributes" runat="server" CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"></asp:TextBox>
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                                <tr id="Tr5" runat="server">
                                                                                                                                                    <td id="Td10" runat="server">
                                                                                                                                                        <asp:Label ID="Rs_EnterAttributeValue" Text="Enter Attribute Value" runat="server"
                                                                                                                                                            meta:resourcekey="Rs_EnterAttributeValueResource1"></asp:Label>
                                                                                                                                                    </td>
                                                                                                                                                    <td id="Td11" runat="server">
                                                                                                                                                        <asp:TextBox ID="txtValue" runat="server" CssClass="Txtboxsmall"   OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);"></asp:TextBox>&nbsp;<img
                                                                                                                                                            src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                                <tr id="Tr6" runat="server">
                                                                                                                                                    <td id="Td12" runat="server">
                                                                                                                                                        <asp:Label ID="Rs_SelectAttributeType" Text="Select Attribute Type" runat="server"
                                                                                                                                                            meta:resourcekey="Rs_SelectAttributeTypeResource1"></asp:Label>
                                                                                                                                                    </td>
                                                                                                                                                    <td id="Td13" runat="server">
                                                                                                                                                        <asp:DropDownList ID="ddlClientTypes" CssClass="ddlsmall" runat="server">
                                                                                                                                                        </asp:DropDownList>
                                                                                                                                                        <asp:Button ID="btnClientAttributes" runat="server" Text="Add" CssClass="btn" OnClientClick="javascript:return createClienttab();"
                                                                                                                                                            meta:resourcekey="btnClientAttributesResource1" />
                                                                                                                                                        <%-- <input type="button" id="btnClientAttributes" value="Add" class="btn" onclick="javascript:createClienttab();" />--%>
                                                                                                                                                    </td>
                                                                                                                                                </tr>
                                                                                                                                            </table>
                                                                                                                                        </td>
                                                                                                                                        <td id="Td14" valign="top" runat="server">
                                                                                                                                            <div id="div3" runat="server" style="overflow: auto; height: 180px; width: 300px">
                                                                                                                                                <input type="hidden" id="hdnClientAttributes" runat="server" />
                                                                                                                                                <input id="hdntvtvalue" runat="server" type="hidden" />
                                                                                                                                                <table id="tblClientAttributes" border="0" cellpadding="0" cellspacing="0" class="dataheaderInvCtrl"
                                                                                                                                                    style="display: none;">
                                                                                                                                                    <tr class="dataheader1">
                                                                                                                                                        <td class="w-10">
                                                                                                                                                        </td>
                                                                                                                                                        <td class="w-25">
                                                                                                <asp:Label ID="Rs_Attributes1" runat="server" meta:resourceKey="Rs_Attributes1Resource1"
                                                                                                    Text="Attributes"></asp:Label>
                                                                                                                                                        </td>
                                                                                                                                                        <td class="w-25">
                                                                                                <asp:Label ID="Rs_Type1" runat="server" meta:resourceKey="Rs_Type1Resource1" Text="Type"></asp:Label>
                                                                                                                                                        </td>
                                                                                                                                                        <td class="w-40">
                                                                                                <asp:Label ID="Rs_Value1" runat="server" meta:resourceKey="Rs_Value1Resource1" Text="Value"></asp:Label>
                                                                                                                                                        </td>
                                                                                                                                                    </tr>
                                                                                                                                                </table>
                                                                                                                                            </div>
                                                                                                                                        </td>
                                                                                                                                    </tr>
                                                                                                                                </table>
                                                                                                                            </asp:Panel>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr id="trTaxDetails" runat="server" style="display: none;">
                                                                                                    <td class="w-100p">
                                                                                                        <asp:Panel ID="Pnltaxdetails" runat="server" Height="250px">
                                                                                                            <table class="w-100p  v-top bg-row">
                                                                                                                <tr class="colorforcontent">
                                                                                                                    <td colspan="8" class="padding5">
                                                                                                                        <p class="bold">
                                                                <%=Resources.Invoice_ClientDisplay.Invoice_ClientMaster_aspx_023%> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr class="v-top">
                                                                                                                    <td class="w-18p">
                                                                                                                        <asp:Label ID="lblTaxDetailsPercentage" Text="Tax Details & Percentage" runat="server"
                                                                                                                            meta:resourcekey="TaxDetailsPercentageResource"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-16p">
                                                                                                                        <asp:DropDownList runat="server" ID="ddlTaxDetails" Width="170px" CssClass="ddl">
                                                                                                                        </asp:DropDownList>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td class="w-11p">
                                                                                                                        <asp:Label ID="lblSequenceNo" Text="Sequence Number" runat="server" meta:resourcekey="lblSequenceNumberResource"></asp:Label>
                                                                                                                    </td>
                                                                                                                    <td class="w-15p">
                                                                                                                        <asp:TextBox ID="TxtSeqNo" runat="server" CssClass="Txtboxsmall" Width="70px" meta:resourcekey="txtTxtSeqNoResource"></asp:TextBox>
                                                                                                                        &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:CheckBox ID="ChkIsActive" runat="server" Text="IsActive" meta:resourcekey="chkIsActiveResource" />
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <asp:Button ID="BtnAddTaxDetails" runat="server" Text="Add Tax Details" CssClass="btn"
                                                                                                                            meta:resourcekey="btnAddTaxDetailsResource" OnClientClick="return AddTaxDetails();" />
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr id="TrTxDetails" style="display: none;" class="v-top">
                                                                                                                    <td colspan="6">
                                                                                                                        <div id="divTxDetails" runat="server" class="w-100p" style="height: 200px; overflow: auto;
                                                                                                                            overflow-x: hidden; width: auto">
                                                                                                                            <table id="TblTxDetails" runat="server" style="width: 100%; height: 200px; background-color: White;
                                                                                                                                border: 1,1,1,1; vertical-align: top;">
                                                                                                                            </table>
                                                                                                                        </div>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </asp:Panel>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                
                                                                                                
                                                                                                
                                                                                                <%-- BEGIN || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                                <tr id="trCustomerTAT" runat="server" style="display: none;">
																									    <td id="tdCustomerTAT" runat="server">
                                                                                                            <asp:Panel ID="pnlCustomerTAT" BorderWidth="1px" runat="server" Width="100%">
                                                                                                                <table width="100%">
                                                                                                                    <tr valign="top">
                                                                                                                        <td style="font-weight: normal; font-size: 12px; color: #000; width: 10%;" valign="top">
                                                                                                                            <asp:Label ID="lblTATStartsfrom" Text="TAT Starts From" runat="server"></asp:Label>
                                                                                                                        </td>
                                                                                                                        <td style="font-weight: normal; font-size: 12px; height: 20px; color: #000; width: 20%;">
                                                                                                                            <asp:DropDownList ID="ddlTATStartsfrom" ToolTip="Select TAT Starts from" runat="server"
                                                                                                                                CssClass="ddllarge" Height="20px" Width="174px">
                                                                                                                            </asp:DropDownList>
                                                                                                                            <%--<img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                                                                            &nbsp;
                                                                                                                        </td>
                                                                                                                        <td style="font-weight: normal; font-size: 12px; color: #000; width: 10%;" valign="top">
                                                                                                                            <asp:Label ID="lblTransitType" Text="Transit Type" runat="server"></asp:Label>
                                                                                                                        </td>
                                                                                                                        <td style="font-weight: normal; font-size: 12px; height: 20px; color: #000; width: 20%;">
                                                                                                                            <asp:DropDownList ID="ddlTransitType" ToolTip="Select Transit Type" runat="server"
                                                                                                                                CssClass="ddllarge" Height="20px" Width="174px" OnChange="TransitTypeChange()">
                                                                                                                            </asp:DropDownList>
                                                                                                                           <%-- <img src="../Images/starbutton.png" alt="" align="middle" />--%>
                                                                                                                            &nbsp;
                                                                                                                        </td>
                                                                                                                        <td nowrap="nowrap">
                                                                                                                            <asp:Label ID="lblTransitTime" runat="server" Text="Transit Time" meta:resourcekey="lblTransitTimeResource1"></asp:Label>
                                                                                                                        </td>
                                                                                                                        <td nowrap="nowrap" id="tdTransitTime">
                                                                                                                            <asp:TextBox ID="txtTransitTime" runat="server" AutoComplete="off" CssClass="Txtboxsmall"
                                                                                                                                MaxLength="2" onkeydown=" return isNumericss(event,this.id);" onkeypress="return"
                                                                                                                                Width="70px" meta:resourcekey="txtTransitTimeResource1"></asp:TextBox>
                                                                                                                            <asp:DropDownList ID="ddlTransitTime" runat="server" CssClass="ddl" meta:resourcekey="ddlTransitTimeResource1">
                                                                                                                            </asp:DropDownList>
                                                                                                                           
                                                                                                                        </td>
                                                                                                                        <td id="tdlnkTransitTime" runat="server" style="display:none">
                                                                                                                         <asp:LinkButton ID="lnkTransitTime" runat="server" Text="Location" ForeColor="Blue" />
                                                                                                                        </td>
                                                                                                                       
                                                                                                                    </tr>
                                                                                                                </table>
                                                                                                            </asp:Panel>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <%-- END || TAT || RAJKUMAR G || 20191001 --%>
                                                                                                
                                                                                                
                                                                                                
                                    <%-- client logo strats --%>
                                    <tr>
                                    <td id="tdLogoStatus" style="display: none" runat="server">
                                        <asp:Panel ID="Panel8" runat="server" Height="165px" GroupingText="LogoUpload" meta:resourcekey="Panel8resource">
                                            <%--<asp:UpdatePanel runat="server" ID="UpdatePanel123" >
                                                                                                                    <ContentTemplate>--%>
                                            <table id="Table34" runat="server" width="100%">
                                                <tr>
                                                    <td id="tdClientLogoStatus" runat="server">
                                                        <asp:DropDownList ID="ddlLogoClientTypes" CssClass="ddl" onChange="GetClientLogoUpload();"
                                                            runat="server" Width="120px" meta:resourcekey="ddlLogoClientTypesResource1">
                                                            <asp:ListItem Text="Receipt" Value="1" />
                                                            <asp:ListItem Text="Report" Value="2" />
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                                <tr id="trflUpload" style="display: none;" runat="server">
                                                    <td>
                                                        <asp:Label ID="Rs_SelectLogo" runat="server" Text="UploadLogo"></asp:Label>
                                                    </td>
                                                    <td colspan="4">
                                                        <asp:FileUpload ID="flUpload" runat="server" onchange="javascript:ValidateUpload(this.id);" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="btnLogoView" Text="View" runat="server" CssClass="btn" Width="100px"
                                                            OnClick="btn_ViewLogo" />
                                                    </td>
                                                    <td colspan="4">
                                                        <img id="imgView" runat="server" style="display: none;" align="middle" alt="Logo Display" />
                                                    </td>
                                                </tr>
                                            </table>
                                            <%--</ContentTemplate>--%>
                                            <%--<Triggers>
                                                                                                                        <asp:AsyncPostBackTrigger ControlID="btnLogoView"  />
                                                                                                                        
                                                                                                                    </Triggers>--%>
                                            <%-- </asp:UpdatePanel>--%>
                                        </asp:Panel>
                                    </td>
                                    </tr>
                                    <%-- client logo ends --%>
                                </table>
                                </td> </tr> </table> </td> </tr> </table> </asp:Panel> </td> </tr>
                                                        <tr>
                                                            <td id="tdChkDelete" valign="top" runat="server">
                                                                <asp:HiddenField ID="hdnCheckIsUsed" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        <td> &nbsp
                                                        </td>
                                                        </tr>
                                                         <tr>
                                                        <td> &nbsp
                                                        </td>
                                                        </tr>
                                                        <tr class="panelFooter">
                                                            <td colspan="2" align="center">
                                        <asp:Label ID="lblReason1" runat="server" Text="Reason" meta:resourceKey="lblReason1Resource1" />
                                                                &nbsp;
                                                                <asp:DropDownList ID="ddlReason" Width="173px" runat="server" AutoPostBack="false"
                                                                    CssClass="ddlmedium">
                                                                </asp:DropDownList>
                                                                <img src="../Images/starbutton.png" alt="" align="middle" />
                                                                &nbsp;
                                                                <asp:Button ID="btnFinish" Text="Save" runat="server" onmouseover="this.className='btn btnhov'"
                                                                    CssClass="btn" onmouseout="this.className='btn'" OnClientClick="return checkisempty();"
                                                                    Width="100px" OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                                                &nbsp;
                                                                <asp:Button ID="btnCancel" runat="server" Text="Clear" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                                    onmouseout="this.className='btn'" Width="100px" OnClick="btnCancel_Click" meta:resourcekey="btnCancelResource1" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <br />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td class="colorforcontent h-23 a-left">
                                                                <div id="ACX2OPPmt" runat="server" style="display: block;">
                                                                    &nbsp;<img src="../Images/ShowBids.gif" alt="Show" class="w-15 h-15 v-top pointer"
                                                                        onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                                    <span class="dataheader1txt pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                                        <asp:Label ID="Rs_SupplierSearch" Text="Client Search" runat="server" meta:resourcekey="Rs_SupplierSearchResource1"></asp:Label>
                                                                    </span>
                                                                </div>
                                                                <div id="ACX2minusOPPmt" runat="server" style="display: none;">
                                                                    &nbsp;<img src="../Images/HideBids.gif" alt="hide" class="w-15 h-15 v-top pointer"
                                                                        onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                                    <span class="dataheader1txt pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                                        <asp:Label ID="Rs_SupplierSearch1" Text="Client Search" runat="server" meta:resourcekey="Rs_SupplierSearch1Resource1"></asp:Label></span></div>
                                                            </td>
                                                        </tr>
                                                        <tr class="tablerow" id="ACX2responsesOPPmt" runat="server" style="display: table-row;">
                                                            <td id="Td2" colspan="2" runat="server">
                                                                <table class="dataheader2 defaultfontcolor w-100p bg-row" border="0" cellpadding="4" cellspacing="0">
                                                                    <tr id="Tr7" runat="server">
                                                                        <td id="Td3" class="style1" runat="server">
                                                                            <asp:Label ID="Rs_SupplierName" Text="Client Name" runat="server" meta:resourcekey="Rs_SupplierNameResource1"></asp:Label>
                                                                        </td>
                                                                        <td id="Td4" runat="server">
                                                                            <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" CssClass="small"
                                                                                AutoComplete="off"></asp:TextBox>
                                                                            <div id="aceClientNameSrch">
                                                                            </div>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender9" runat="server" TargetControlID="txtClientNameSrch"
                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True"
                                                                                CompletionListElementID="aceClientNameSrch" OnClientShown="setAceWidth">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td id="Td5" runat="server">
                                                                            <asp:Label ID="Rs_TinNo1" Text="Client Code" runat="server" meta:resourcekey="Rs_TinNo1Resource1"></asp:Label>
                                                                        </td>
                                                                        <td id="Td6" runat="server">
                                                                            <asp:TextBox ID="txtClientCodeSrch" runat="server" MaxLength="20" CssClass="small"></asp:TextBox>
                                                                            <div id="aceClientCodeSrch">
                                                                            </div>
                                                                            <ajc:AutoCompleteExtender ID="AutoCompleteExtender10" runat="server" TargetControlID="txtClientCodeSrch"
                                                                                CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                                                CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                                                MinimumPrefixLength="1" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                                                ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True"
                                                                                CompletionListElementID="aceClientCodeSrch" OnClientShown="setAceWidth">
                                                                            </ajc:AutoCompleteExtender>
                                                                        </td>
                                                                        <td id="Td7" class="style1 a-center" runat="server">
                                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" onmouseover="this.className='btn btnhov'"
                                                                                CssClass="btn" onmouseout="this.className='btn'" OnClick="btnSearch_Click" meta:resourcekey="btnSearchResource1" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table id="excel" class="gridView w-100p" runat="server">
                                                        <tr id="Tr8" runat="server">
                                                            <td id="Td18" runat="server">
                                                                </b>
                                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="return CallPrint();"
                                                                    ToolTip="Print" Visible="False" />
                                                                <asp:LinkButton ID="PrintReport" Text="Print Report" runat="server" OnClientClick="return CallPrint();"
                                                                    Font-Underline="True" Font-Bold="True" Style="border-width: 2px;" Font-Size="12px"
                                                                    ForeColor="Black" Visible="False" meta:resourcekey="PrintReportResource1"></asp:LinkButton>
                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:GridView ID="gvclientmaster" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                                            DataKeyNames="ClientID" CssClass="mytable1 gridView" PageSize="5" Width="100%"
                                                                            wrap="wrap" OnPageIndexChanging="gvclientmaster_PageIndexChanging" OnRowDataBound="gvclientmaster_RowDataBound"
                                                                            OnRowCommand="gvclientmaster_RowCommand" EmptyDataText="No matching record found.!" >
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="S.No." meta:resourcekey="BoundField2Resource">
                                                                                    <ItemTemplate>
                                                                                        <%#Container.DataItemIndex+1%></ItemTemplate>
                                                                                    <ItemStyle Width="8%" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="ClientName"  meta:resourcekey="BoundField1Resource">
                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ClientCode" HeaderText="Client Code" meta:resourcekey="BoundField3Resource">
                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ServiceTaxNo" HeaderText="ServiceTax No" meta:resourcekey="BoundField4Resource">
                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" Visible="false" meta:resourcekey="BoundField5Resource">
                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="CstNo" HeaderText="CstNo" meta:resourcekey="BoundField6Resource">
                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="ApprovalRequired" HeaderText="Approval Required" meta:resourcekey="BoundField7Resource">
                                                                                    <ItemStyle Width="10%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="LoginName" HeaderText="Admin Login Name" Visible="true" meta:resourcekey="BoundField8Resource">
                                                                                    <ItemStyle Width="22%" HorizontalAlign="Left" />
                                                                                </asp:BoundField>
                                                                            </Columns>
                                                                            <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                            <HeaderStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                                        </asp:GridView>
                                                                        <input type="hidden" id="hdnAddressDetails" runat="server" />
                                                                        <input type="hidden" id="hdnreplanguage" runat="server" />
                                                                        <input type="hidden" id="hdnTxDetails" runat="server" />
                                                                        <input type="hidden" id="hdnAddressID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnParentClientID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdntxtzoneID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdntxtrouteID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnHubID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdncollectioncenterid" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnclientnames" runat="server" value="" />
                                                                        <input type="hidden" id="hdnStateID" value="0" runat="server" />
                                                                        <input type="hidden" id="hdnPrsnDetails" runat="server" />
                                                                        <input type="hidden" id="hdnGetEmpContact" runat="server" />
                                                                        <input type="hidden" id="hdnGetOtherContact" runat="server" />
                                                                        <input type="hidden" id="hdnAddressTypeID" runat="server" />
                                                                        <input type="hidden" id="hdnEmpID" runat="server" />
                                                                        <input type="hidden" id="hdnHosOrRefID" runat="server" />
                                                                        <input type="hidden" id="hdnCheckCode" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnValidateActive" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnClientStatus" runat="server" />
                                                                        <input type="hidden" id="hdnIsCtParentOrg" runat="server" />
                                                                        <input type="hidden" id="hdnClientTypeID" runat="server" />
                                                                        <input type="hidden" id="hdnGetParentID" runat="server" />
                                                                        <input type="hidden" id="hdnTaxValue" runat="server" />
                                                                        <input type="hidden" id="hdnSetParentID" runat="server" value="" />
                                                                        <input type="hidden" id="hdnSkipID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnAddDepart" runat="server" value="" />
                                                                        <input type="hidden" id="hdnPolicyID" runat="server" value="" />
                                                                        <input type="hidden" id="hdnTodID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnVolID" runat="server" value="0" />
                                                                        <input type="hidden" id="hdnlstStationery" runat="server" value="" />
                                                                        <%--VEL--%>
                                                                        <input type="hidden" id="hdnlstBillType" runat="server" value="" />
                                                                        <%--VEL--%>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                            <div id="divPrintarea">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="style3">
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                            <Triggers>
                                <%-- client logo strats --%>
                                <%--<asp:PostBackTrigger ControlID="btnFinish" />--%>
                                <asp:PostBackTrigger ControlID="btnLogoView" />
                                <%-- client logo ends --%>
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
                    <input type="hidden" id="hdnStatus" runat="server" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Panel ID="pnlClientStatus" runat="server" ScrollBars="Both" CssClass="modalPopup dataheaderPopup"
                        Width="90%" Height="50%" meta:resourcekey="pnlClientStatusResource1">
                        <table class="w-100p" style="font-family: Tahoma;">
                            <tr>
                                <td class="a-center">
                                    <asp:UpdatePanel runat="server" ID="updPnl">
                                        <ContentTemplate>
                                            <asp:Label ID="lblHeaderText" runat="server" Font-Bold="True" Font-Size="Medium"
                                                meta:resourcekey="lblHeaderTextResource1"></asp:Label>
                                            <asp:GridView ID="grdClientHistory" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                                                CssClass="mytable1 gridView w-100p" OnPageIndexChanging="grdClientHistory_PageIndexChanging"
                                                wrap="wrap" meta:resourcekey="grdClientHistoryResource1">
                                                <Columns>
                                            <asp:TemplateField HeaderText="S.No" meta:resourcekey="TemplateFieldResource1">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1%>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="ClientName" HeaderText="Client Name" Visible="False" meta:resourcekey="BoundFieldResource1">
                                                        <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Status" HeaderText="Client Status" meta:resourcekey="BoundFieldResource2">
                                                        <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Reason" HeaderText="Reason" meta:resourcekey="BoundFieldResource3">
                                                        <ItemStyle HorizontalAlign="Left" Width="16%" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Block From" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBlockFrom" runat="server" Text='<%# Eval("BlockFrom").ToString().Equals("01/01/1753 00:00:00") ? "" : Eval("BlockFrom","{0:dd/MM/yyyy}") %>'
                                                                meta:resourcekey="lblBlockFromResource1"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="12%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Block To" meta:resourcekey="TemplateFieldResource3">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblBlockFrom" runat="server" Text='<%# Eval("BlockTo").ToString().Equals("01/01/1753 00:00:00") ? "" : Eval("BlockTo","{0:dd/MM/yyyy}") %>'
                                                                meta:resourcekey="lblBlockFromResource2"></asp:Label>
                                                        </ItemTemplate>
                                                        <ItemStyle Width="12%" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="AuthorizedRole" HeaderText="Authorized By" meta:resourcekey="BoundFieldResource4">
                                                        <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ModifedPerson" HeaderText="Modified By" meta:resourcekey="BoundFieldResource5">
                                                        <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ModifiedAt" DataFormatString="{0:f}" HeaderText="Modified At"
                                                        meta:resourcekey="BoundFieldResource6">
                                                        <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                                <PagerStyle CssClass="dataheader1" HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </ContentTemplate>
                                     <Triggers>
                                <%-- <asp:PostBackTrigger ControlID="imgExportToExcel"  />--%>
                                <asp:PostBackTrigger ControlID="lnkviewtestdetails" />
                                 <asp:PostBackTrigger ControlID="ImageBtnExport" />
                            </Triggers>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <asp:Button ID="btnClose" Text="Close" runat="server" CssClass="btn1" onmouseover="this.className='btn1 btnhov1'"
                                        onmouseout="this.className='btn1'" meta:resourcekey="btnCloseResource1" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
                <td>
                    <ajc:ModalPopupExtender ID="ModelPopPatientSearch" runat="server" TargetControlID="btnR"
                        PopupControlID="pnlClientStatus" BackgroundCssClass="modalBackground" OkControlID="btnClose"
                        DynamicServicePath="" Enabled="True" />
                    <input type="button" id="btnR" runat="server" style="display: none;" />
                </td>
            </tr>
        </table>
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnOrgID" runat="server" />
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />

<script type="text/javascript" language="javascript">
    function checksign(e) {
        e = window.event;
        var code = e.keyCode || e.which;
        if (code == 94 || code==38) {
            return false;
        }
    }
    //AB Code
    function ThresHoldValidation() {
        if ($("#rdThreadsHold1_0").is(":checked") == true) {
            if ($("#txtThreadshold").val() > 100) {
                $("#txtThreadshold").val("");
                $("#rdThreadsHold1_0").attr('checked', true);

                return true;
            }
            else {
                true;
            }
        }
        else {
            /*$("#txtThreadshold").attr("maxlength", "15");*/
            if ($("#txtThreadshold").val().length > 7) {
                $("#txtThreadshold").val("");
                return true;
            }
        }

    }
    function thresHoldValidate() {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_39") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_39") : "You can Enter only below 100";
        /*
        if ($("#rdThreadsHold1").is(":checked") == true && $("#txtThreadshold").val() > 100) {
        $("#txtThreadshold").val("");
        //alert("You can Enter only below 100");
        ValidationWindow(UsrAlrtMsg,AlrtWinHdr):
        }
        */
        var threshold = $('#<%=rdThreadsHold1.ClientID %> input[type=radio]:checked').val();
        if (threshold == 'Threshold amount in percentage' && document.getElementById('<%= txtThreadshold.ClientID %>').value > 100) {
            document.getElementById('<%= txtThreadshold.ClientID %>').value = "";
                //alert("You can Enter only below 100");
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        }

    }

    function setAceWidth(source, eventArgs) {
        document.getElementById('aceClientName').style.width = 'auto';
        document.getElementById('aceClientNameSrch').style.width = 'auto';
        document.getElementById('aceLocation').style.width = 'auto';
        document.getElementById('aceHub').style.width = 'auto';
        document.getElementById('acezone').style.width = 'auto';
        document.getElementById('aceRouteName').style.width = 'auto';
        document.getElementById('aceClientCodeSrch').style.width = 'auto';
           



    }
    //Added By Arivalagan K Tax Details//
    function clearTaxdetails() {
        document.getElementById('ddlTaxDetails').value = "0";
        document.getElementById('TxtSeqNo').value = '';
        document.getElementById('ChkIsActive').checked = true;
        return true;
    }
    function AddTaxDetails() {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_40") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_40") : "Select one TaxDetails.";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_41") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_41") : "Enter Sequence Number.";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_42") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_42") : "Enter Number only..";
            
        var TaxType = document.getElementById('ddlTaxDetails').options[document.getElementById('ddlTaxDetails').selectedIndex].text;
        var TaxId = document.getElementById('ddlTaxDetails').options[document.getElementById('ddlTaxDetails').selectedIndex].value;
        var TxSequenceNo = document.getElementById('TxtSeqNo').value;
        var TxisActive = document.getElementById('ChkIsActive').checked ? "Y" : "N";

        if (TaxId == 0) {
                //alert('Select one TaxDetails.');
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            document.getElementById("ddlTaxDetails").focus();
            return false;
        }
        if (TxSequenceNo == "") {
                // alert('Enter Sequence Number.');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            document.getElementById('TxtSeqNo').focus();
            return false;
        }
        if (isNaN(TxSequenceNo)) {
                //alert('Enter Number only.');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
            document.getElementById('TxtSeqNo').focus();
            return false;
        }

        if (TaxId != 0 && TxSequenceNo != "") {
            var flag = 0;
            if (flag == 0) {
                var secFlag = 0;
                if (document.getElementById('hdnTxDetails').value != '') {
                    var ExistsItem = document.getElementById('hdnTxDetails').value.split('^');
                        var TextDisp = SListForAppMsg.Get("Invoice_ClientMaster_aspx_024") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_024") : "is already added \n";
                        var TextDisp1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_025") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_025") : ". The Sequence No :";
                    for (var i = 0; i < ExistsItem.length; i++) {
                        if (ExistsItem[i] != '') {
                            var Msg = '';
                            var Count = 0;
                            if (ExistsItem[i].split('|')[0] == TaxType && ExistsItem[i].split('|')[3] == TaxId) {
                                Count++;
                                    //                                    Msg += Count + '. ' + TaxType + ' is already added \n';
                                    Msg += Count + '. ' + TaxType + TextDisp;
                            }
                            if (ExistsItem[i].split('|')[1] == TxSequenceNo) {
                                Count++;
                                    //                                    Msg += Count + '. The Sequence No : ' + TxSequenceNo + ' is already added';
                                    Msg += Count + TextDisp1 + TxSequenceNo + TextDisp;
                            }
                            /*
                            if (ExistsItem[i].split('|')[2] == TxisActive) {
                            Count++;
                            Msg = Count + '.' + TxSequenceNo + 'is already added';
                            }*/
                            if (Msg != '') {

                                userMsg = Msg;
                                if (userMsg != null) {
                                        //alert(userMsg);
                                        ValidationWindow(userMsg, AlrtWinHdr);
                                    return false;
                                }
                                else {
                                        // alert(Msg);
                                        ValidationWindow(Msg, AlrtWinHdr);
                                    return false;
                                }
                                secFlag = 1;
                                return false;
                            }
                        }
                    }
                }
                if (secFlag == 0) {
                    document.getElementById('hdnTxDetails').value += TaxType + "|" + TxSequenceNo + "|" + TxisActive + "|" + TaxId + "^";
                    CreateTaxDetails();
                    clearTaxdetails();
                    return false;
                }
            }
            return false;
        }
        return false;
    }

    function CreateTaxDetails() {

        var items = '';
        document.getElementById('divTxDetails').innerHTML = "";
        if (document.getElementById('hdnTxDetails').value != '') {
            items = document.getElementById('hdnTxDetails').value.split('^');
        }
        if (items != "") {
            var startTag, bodyTag, endTag;
            var vTax = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_045") == null ? "Tax Type" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_045");
            var vSequence = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_046") == null ? "Sequence Number" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_046");
            var vIsActive = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_047") == null ? "IsActive" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_047");
            var vAction = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_048") == null ? "Action" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_048");
            startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='800px' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='left' width='8%'> " + vTax + " </th><th scope='col' align='left' width='8%'> " + vSequence + " </th><th scope='col' align='left' width='12%'> "+ vIsActive +" </th><th scope='col' align='left' width='5%'> "+ vAction +" </th></tr>";
            endTag = "</TBODY></TABLE>";
            bodyTag = startTag;
            for (var i = 0; i < items.length; i++) {
                if (items[i] != "") {
                    bodyTag += "<TR><TD>" + items[i].split('|')[0] + "</TD>";
                    bodyTag += "<TD>" + items[i].split('|')[1] + "</TD>";
                    bodyTag += "<TD>" + items[i].split('|')[2] + "</TD>";
                    bodyTag += "<TD><input name='" + items[i] + "' onclick='return EditTaxDetails(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'/><input name='" + items[i] + "' onclick='return DeleteTaxDetails(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";
                    bodyTag += "</TR>";
                }
            }

            bodyTag += endTag;
            document.getElementById('TrTxDetails').style.display = 'table-row';
            document.getElementById('divTxDetails').innerHTML = bodyTag;
            var vAddMore = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_043") == null ? "AddMore" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_043");
            document.getElementById('BtnAddTaxDetails').value = vAddMore;
        }
    }

    function EditTaxDetails(sEditedData) {

        if (document.getElementById('hdnTxDetails').value != "") {
            var y = sEditedData.split('|');
            document.getElementById('ddlTaxDetails').value = y[3];
            document.getElementById('TxtSeqNo').value = y[1];
            document.getElementById('ChkIsActive').checked = y[2] == "Y" ? true : false;
            var list = document.getElementById('hdnTxDetails').value.split("^");
            document.getElementById('hdnTxDetails').value = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    if (list[i] != sEditedData) {
                        document.getElementById('hdnTxDetails').value += list[i] + "^";
                    }
                }
            }
        }
        CreateTaxDetails();
        var vAddMore1 = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_061") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_061");
        document.getElementById('BtnAddTaxDetails').value = vAddMore1;
    }
    function DeleteTaxDetails(sEditedData) {
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") : "Confirm to delete!!";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") : "Confirm to delete!!";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") : "Ca";
        var i;
        var confirmmsg1;
           // var userMsg = SListForApplicationMessages.Get("Invoice\\ClientMaster.aspx_44");
            if (UsrAlrtMsg != null) {
                confirmmsg1 = UsrAlrtMsg;

        }
        else {
                //confirmmsg1 = 'Confirm to delete!!';
                confirmmsg1 = UsrAlrtMsg;
        }
        var IsDelete = confirm(confirmmsg1);
        if (IsDelete == true) {
            var x = document.getElementById('hdnTxDetails').value.split("^");
            document.getElementById('hdnTxDetails').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnTxDetails').value += x[i] + "^";
                    }
                }
            }
            CreateTaxDetails();
        }
        else {
            return false;
        }
    }
    //Added By Arivalagan K End Tax Details//

    function clearaddress() {
        //        var countryid = document.getElementById('drpCountry').value;
        //        var stateid = document.getElementById('drpState').value;
        var vAdd = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_058") == null ? "ADD" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_058");
        document.getElementById('txtaddres1').value = "";
        document.getElementById('txtciti').value = "";
        document.getElementById('txtEmailID').value = "";
        document.getElementById('txtPhoneNumber').value = "";
        document.getElementById('txtmobileno').value = "";
        document.getElementById('btnAdd').value = vAdd;
        document.getElementById('lblmsg').innerText = "";
        document.getElementById('hdnStatus').value = 'ADD';
        document.getElementById('txtfax').value = "";
        document.getElementById('hdnAddressID').value = "0";
        document.getElementById('drpaddresstype').value = "0";
        document.getElementById('chkIsCommunication').checked = false;
        document.getElementById('txtSubUrban').value = "";
        document.getElementById('txtInvoiceEmail').value = "";
    }
    
  function AddReportLanguage() {
 
            var ReportLang = document.getElementById('ddlreplang').value;
            var Noofcopies = document.getElementById('txtnoofprint').value;
            var Language = $("#ddlreplang option:selected").text(); 
            document.getElementById('hdnreplanguage').value += Language + "|" + Noofcopies + "|" + ReportLang + "^";
            GenerateLangTable();
            clearlanguage();
            showResponses('Div1', 'Div2', 'divLocation', 0)
            return false;
         
    }
 function clearlanguage() { 
    document.getElementById('txtnoofprint').value="";
	document.getElementById('ddlreplang').selectedIndex=0; 
    }
    function GenerateLangTable() {
 
        while (count = document.getElementById('tblreportlang').rows.length) {
            for (var j = 0; j < document.getElementById('tblreportlang').rows.length; j++) {
                document.getElementById('tblreportlang').deleteRow(j);
            }
        }
        var pList = document.getElementById('hdnreplanguage').value.split("^");
        if (pList != "") {
            document.getElementById('divreplang').style.display = "block";
            var Headrow = document.getElementById('tblreportlang').insertRow(0);
            Headrow.id = "HeadLangID";
            var id = 0;
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"

            var vNo = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_033") == null ? "S.No" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_033");
            var vRepLanguage = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_065") == null ? "Language" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_065");
            var vNoofcopies = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_066") == null ? "Number of Copies" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_066");
            var vAction = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_040") == null ? "Action" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_040");
            var vLangcode = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_067") == null ? "Lang Code" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_067");
           
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3); 
            var cell5 = Headrow.insertCell(4); 
			
            cell1.innerHTML = vNo;
            cell2.innerHTML = vRepLanguage;
            cell3.innerHTML = vNoofcopies;
            cell4.innerHTML = vLangcode;
            cell5.innerHTML = vAction;
            cell4.style.display = 'none'; 
            for (s = 0; s < pList.length; s++) {
                if (pList[s] != "") {
                    y = pList[s].split('|');
                    var row = document.getElementById('tblreportlang').insertRow(1);
                    row.style.height = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    cell4.style.display = 'none';
                    cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                    cell2.innerHTML = y[0];
                    cell3.innerHTML = y[1];
                    cell4.innerHTML = y[2];    
                    cell5.innerHTML = "<input id='editlang' name='" + y[0]+ "|" + y[1] +"|"+y[2]  +
                                                              "' onclick='btnEditLang_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> " +
                                           "<input id='deletelang' name='" + y[0] + "|" + y[1] + "|" + y[2] +
                                                                "' onclick='btnDeleteLang(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

                }
            }
        }
    }
	
	function btnEditLang_OnClick(sEditedData) {
        var vUpdate = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057");
        if (document.getElementById('hdnreplanguage').value != "") {
            sEditedData = sEditedData.replace("\\", "'");
            var y = sEditedData.split('|');
            $('#ddlreplang').val(y[2]);
            //$("#ddlreplang option[value='" + y[2] + "']").attr("selected", "selected");
            document.getElementById('txtnoofprint').value = y[1];
            document.getElementById('btnAddlang').value = vUpdate; 
            var list = document.getElementById('hdnreplanguage').value.split("^");
            document.getElementById('hdnreplanguage').value = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    list[i] = list[i].replace(/\&amp;/g, "&");
                    //                    sEditedData = sEditedData.replace(/\&amp;/g, "&");
                    if (list[i] != sEditedData) {
                        document.getElementById('hdnreplanguage').value += list[i] + "^";
                    }
                }
            }
        } 
        GenerateLangTable();
        var tbl = document.getElementById('tblreportlang').rows.length;
        var Tb = document.getElementById('tblreportlang');
        if (tbl > 0) {
            for (var j = 0; j < tbl; j++) {
                Tb.rows[j].cells[3].style.display = "none";
            }
        }


        var Add = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_068") == null ? "Add" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_068");
        document.getElementById('btnAddlang').value = Add;
    }
    function btnDeleteLang(sEditedData) {
        var i;
        var confirmmsg1;
            //var userMsg = SListForApplicationMessages.Get("Invoice\\ClientMaster.aspx_44");
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") : "Confirm to delete!!";
            var btnok = SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") : "Ok";
            var btncancel = SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") : "Cancel";
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            if (UsrAlrtMsg != null) {
                confirmmsg1 = UsrAlrtMsg;

        }
        else { 
                confirmmsg1 = UsrAlrtMsg;
        }
            var IsDelete = ConfirmWindow(confirmmsg1, AlrtWinHdr, btnok, btncancel);
        if (IsDelete == true) {
            var x = document.getElementById('hdnreplanguage').value.split("^");
            document.getElementById('hdnreplanguage').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnreplanguage').value += x[i] + "^";
                    }
                }
            }
            GenerateLangTable();
        }
        else {
            return false;
        }
    }
    function chectisprimary() {
        var flag = 0;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_43") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_43") : "Already Given Communication Address";
        if (document.getElementById('hdnAddressDetails').value != "") {
            var detail = document.getElementById('hdnAddressDetails').value.split("^");
            for (var i = 0; i < detail.length; i++) {
                if (detail[i].split("|")[7] == "Y") {
                    flag = 1;
                }
            }
            if (flag != 0) {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_34');
                    if (UsrAlrtMsg != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    document.getElementById('chkIsCommunication').checked = false;
                    return false;
                }
                else {
                        // alert("Already Given Communication Address");
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                document.getElementById('chkIsCommunication').checked = false;
                document.getElementById('chkIsCommunication').focus();
                return false;

            }
        }
    }
    function checkclientname() {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_44") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_44") : "select the Client Name";
        var ClientName = document.getElementById('txtClientName').value;
        if (ClientName == "") {
                //alert("select the Client Name")
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            return false;
        }
        else {
            return true;
            
        }
    
    }
    
    function checkCustomerAddress() {

        if (checkAddressDetails()) {
            var vAddMore = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_043") == null ? "AddMore" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_043");
            var countryid;
            if (document.getElementById('drpCountry').value == "--Select--") {
                countryid = 0;
            } else {
               countryid = document.getElementById('drpCountry').value;
            }
            var stateid = document.getElementById('drpState').value;
            var address = document.getElementById('txtaddres1').value;
            var city = document.getElementById('txtciti').value;
            var email = document.getElementById('txtEmailID').value;
            var reportEmail = document.getElementById('txtInvoiceEmail').value;
            var phone = document.getElementById('txtPhoneNumber').value;
            var mobile = document.getElementById('txtmobileno').value;
            document.getElementById('btnAdd').value = 'A';
            document.getElementById('lblmsg').innerText = vAddMore;
            document.getElementById('hdnStatus').value = 'AddMore';
            var fax = document.getElementById('txtfax').value;
            var addresstype = document.getElementById('drpaddresstype').options[document.getElementById('drpaddresstype').selectedIndex].text;

            var adtype = document.getElementById('drpaddresstype').value;
            var iscommunication = document.getElementById('chkIsCommunication').checked ? "Y" : "N";
            var addressid = document.getElementById('hdnAddressID').value;
            var ctrycode = document.getElementById('lblCountryCode').innerHTML;
            var subUrban = document.getElementById('txtSubUrban').value;
            document.getElementById('hdnAddressDetails').value += address + "|" + city + "|" + email + "|" + phone + "|" + mobile + "|" + fax + "|" +
                                                              adtype + "|" + iscommunication + "|" + addressid + "|" + countryid + "|" + stateid + "|" + addresstype + "|" + ctrycode + "|" + subUrban +"|" + reportEmail + "^";
            GenerateTable();


            clearaddress();
            showResponses('Div1', 'Div2', 'divLocation', 0)
        }
        return false;

    }

    function GenerateTable() {

        var vAddMore = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_043") == null ? "AddMore" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_043");
        document.getElementById('btnAdd').value = vAddMore;
        while (count = document.getElementById('tblClientDetail').rows.length) {
            for (var j = 0; j < document.getElementById('tblClientDetail').rows.length; j++) {
                document.getElementById('tblClientDetail').deleteRow(j);
            }
        }
        var pList = document.getElementById('hdnAddressDetails').value.split("^");
        if (pList != "") {
            document.getElementById('divaddressdetails').style.display = "block";
            var Headrow = document.getElementById('tblClientDetail').insertRow(0);
            Headrow.id = "HeadID";
            var id = 0;
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"

            var vAddressType = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_032") == null ? "AddressType" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_032");
            var vNo = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_033") == null ? "S.No" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_033");
            var vAddress = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_034") == null ? "Address" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_034");
            var vSuburb = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_035") == null ? "Suburb" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_035");
            var vPhone = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_036") == null ? "Phone" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_036");
            var vMobile = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_037") == null ? "Mobile" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_037");
            var vFax = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_038") == null ? "Fax" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_038");
            var vCommunication = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_039") == null ? "Communication" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_039");
            var vAction = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_040") == null ? "Action" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_040");
            var vCity = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_041") == null ? "City" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_041");
            var vEmail = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_042") == null ? "Email" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_042");
            var InvoiceEmail = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_042") == null ? "Email" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_042");
           
            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);
            var cell5 = Headrow.insertCell(4);
            var cell6 = Headrow.insertCell(5);
            var cell7 = Headrow.insertCell(6);
            var cell8 = Headrow.insertCell(7);
            var cell9 = Headrow.insertCell(8);
            var cell10 = Headrow.insertCell(9);
            var cell11 = Headrow.insertCell(10);
            var cell12 = Headrow.insertCell(11);

            cell1.innerHTML = vNo;
            cell2.innerHTML = vAddress;
            cell3.innerHTML = vCity;
            cell4.innerHTML = vAddress;
            cell5.innerHTML = vEmail;
            cell6.innerHTML = vPhone;
            cell7.innerHTML = vMobile;
            cell8.innerHTML = vFax;
            cell9.innerHTML = vAddressType;
            cell10.innerHTML = vCommunication;
            cell11.innerHTML =InvoiceEmail ;
            cell12.innerHTML = vAction;
            for (s = 0; s < pList.length; s++) {
                if (pList[s] != "") {
                    y = pList[s].split('|');
                    var row = document.getElementById('tblClientDetail').insertRow(1);
                    row.style.height = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    var cell5 = row.insertCell(4);
                    var cell6 = row.insertCell(5);
                    var cell7 = row.insertCell(6);
                    var cell8 = row.insertCell(7);
                    var cell9 = row.insertCell(8);
                    var cell10 = row.insertCell(9);
                    var cell11 = row.insertCell(10);
                    var cell12 = row.insertCell(11);
                    cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                    cell2.innerHTML = y[0];
                    cell3.innerHTML = y[1];
                    cell4.innerHTML = y[13];
                    if (y[2].split(",")[0] != "") {
                        var email = y[2].split(",");
                        for (var i = 0; i < email.length; i++) {
                            cell5.innerHTML += email[i] + "<br/>";
                        }
                    }
                    else {
                        cell5.innerHTML = y[2];
                    }

                    cell6.innerHTML = y[3];
                    if (y[4].split(",")[0] != "") {
                        var mob = y[4].split(",");
                        for (var i = 0; i < mob.length; i++) {
                            cell7.innerHTML += y[12] + mob[i] + "<br/>";
                        }
                    }
                    else {
                        cell7.innerHTML = y[12] + y[4];
                    }
                    cell8.innerHTML = y[5];
                    cell9.innerHTML = y[11];
                    cell10.innerHTML = y[7];
                    cell11.innerHTML = y[14];
                    var ys = y[0];
                    cell12.innerHTML = "<input id='edit' name='" + y[0].replace("'", "\\") + "|" + y[1] + "|" + y[2] + "|" + y[3] + "|" + y[4] + "|" + y[5] + "|" + y[6] + "|" + y[7] + "|" + y[8] + "|" + y[9] + "|" + y[10] + "|" + y[11] + "|" + y[12] + "|" + y[13] + "|" + y[14] +
                                                              "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> " +
                                           "<input id='edit1' name='" + y[0] + "|" + y[1] + "|" + y[2] + "|" + y[3] + "|" + y[4] + "|" + y[5] + "|" + y[6] + "|" + y[7] + "|" + y[8] + "|" + y[9] + "|" + y[10] + "|" + y[11] + "|" + y[12] + "|" + y[13] + "|" + y[14] +
                                                                "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"

                }
            }
        }
    }




    function btnEdit_OnClick(sEditedData) {
        var vUpdate = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057");
        if (document.getElementById('hdnAddressDetails').value != "") {
            sEditedData = sEditedData.replace("\\", "'");
            var y = sEditedData.split('|');
            document.getElementById('drpCountry').value;
            document.getElementById('drpState').value;
            document.getElementById('txtaddres1').value = y[0];
            document.getElementById('txtciti').value = y[1];
            document.getElementById('txtEmailID').value = y[2];
            document.getElementById('txtPhoneNumber').value = y[3];
            document.getElementById('txtmobileno').value = y[4];
            document.getElementById('btnAdd').value = vUpdate;
            document.getElementById('lblmsg').innerText = "";
            document.getElementById('hdnStatus').value = 'Update';
            document.getElementById('txtfax').value = y[5];
            document.getElementById('drpaddresstype').value = y[6];
            document.getElementById('hdnAddressID').value = y[8];
            document.getElementById('chkIsCommunication').checked = y[7] == "Y" ? true : false;
            document.getElementById('drpCountry').value = y[9];

            loadState();
            //
            document.getElementById('lblCountryCode').value = y[12];
            document.getElementById('hdnStateID').value = y[10];
            document.getElementById('drpState').value = y[10];
            document.getElementById('txtSubUrban').value = y[13];
            document.getElementById('txtSubUrban').value = y[13];
            document.getElementById('txtInvoiceEmail').value = y[14];
            var list = document.getElementById('hdnAddressDetails').value.split("^");
            document.getElementById('hdnAddressDetails').value = "";
            for (var i = 0; i < list.length; i++) {
                if (list[i] != "") {
                    list[i] = list[i].replace(/\&amp;/g, "&");
                    //                    sEditedData = sEditedData.replace(/\&amp;/g, "&");
                    if (list[i] != sEditedData) {
                        document.getElementById('hdnAddressDetails').value += list[i] + "^";
                    }
                }
            }
        }
        showResponses('ACX2OPPmt', 'ACX2minusOPPmt', 'ACX2responsesOPPmt', 0)
        GenerateTable();
        var tbl = document.getElementById('tblClientDetail').rows.length;
        var Tb = document.getElementById('tblClientDetail');
        if (tbl > 0) {
            for (var j = 0; j < tbl; j++) {
                Tb.rows[j].cells[9].style.display = "none";
            }
        }


        var Update = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_060") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_060");
        document.getElementById('btnAdd').value = Update;
    }
    function btnDelete(sEditedData) {
        var i;
        var confirmmsg1;
            //var userMsg = SListForApplicationMessages.Get("Invoice\\ClientMaster.aspx_44");
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_026") : "Confirm to delete!!";
            var btnok = SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_58") : "Ok";
            var btncancel = SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_59") : "Cancel";
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            if (UsrAlrtMsg != null) {
                confirmmsg1 = UsrAlrtMsg;

        }
        else {
                //confirmmsg1 = 'Confirm to delete!!';
                confirmmsg1 = UsrAlrtMsg;
        }
            var IsDelete = ConfirmWindow(confirmmsg1, AlrtWinHdr, btnok, btncancel);
        if (IsDelete == true) {
            var x = document.getElementById('hdnAddressDetails').value.split("^");
            document.getElementById('hdnAddressDetails').value = '';
            for (i = 0; i < x.length; i++) {
                if (x[i] != "") {
                    if (x[i] != sEditedData) {
                        document.getElementById('hdnAddressDetails').value += x[i] + "^";
                    }
                }
            }
            GenerateTable();
        }
        else {
            return false;
        }
    }

    // Added By Gurunath.S
    function AddContactPerson() {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_45") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_45") : "Please enter contact type";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_46") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_46") : "Please Enter Person Name";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_47") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_47") : "Person not associate with this contact type";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_48") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_48") : "This person already added";
        var Contacttype = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
        var contactTypeID = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
        var prsnName = document.getElementById('txtPersonName').value;
        var empID = document.getElementById('hdnEmpID').value;
        var clientName = document.getElementById('txtCntClient').value;
        var prsnMobile = document.getElementById('txtPrsnMobile').value;
        var prsnLandNo = document.getElementById('txtPrsnLandNo').value;
        var prsnEmail = document.getElementById('txtPrsnEmail').value;
        var prsnPrimary = document.getElementById('chkPrsnPrimary').checked ? "Y" : "N";
        var uniqAddID = document.getElementById('hdnAddressID').value;
        var Personname = '';
        var flag = 0;
        var newAddDept = document.getElementById('hdnAddDepart').value.split('^');
        var deptFlag = 0;
        for (var i = 0; i < newAddDept.length; i++) {
            if (newAddDept[i] != "") {
                if (contactTypeID == newAddDept[i].split('~')[1]) {
                    deptFlag = 1;
                    break;
                }
            }
        }
        var cType = '';
        if (contactTypeID == "0") {
              //  userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_35');
                if (UsrAlrtMsg != null) {
                    //  alert(userMsg);
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            else {
                    // alert('Please enter contact type');
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                return false;
            }
            document.getElementById('drplstPerson').focus();
            return false;
        }
        if (deptFlag == 0) {
            cType = 'EMP';
            if (prsnName == '') {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_36');
                    if (UsrAlrtMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                        //alert('Please Enter Person Name');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
                document.getElementById('tdtxtClnt').style.display = "none";
                document.getElementById('tdtxtPrsn').style.display = "table-cell";
                document.getElementById('txtPersonName').focus();
                flag = 1;
                return false;
            }
            if (empID <= 0) {
                   // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_37');
                    if (UsrAlrtMsg2 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    return false;
                }
                else {
                        //alert('Person not associate with this contact type');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    return false;
                }
            }
        }
        else {
            cType = "CLT";
            empID = -1;
            if (clientName == '') {
                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_36');
                    if (UsrAlrtMsg1 != null) {
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert('Please Enter Person Name');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    return false;
                }
                document.getElementById('tdtxtClnt').style.display = "table-cell";
                document.getElementById('tdtxtPrsn').style.display = "none";
                document.getElementById('txtCntClient').focus();
                flag = 1;
                return false;
            }
        }
        if (flag == 0) {
            var secFlag = 0;
            if (document.getElementById('hdnPrsnDetails').value != '') {
                var ExistsItem = document.getElementById('hdnPrsnDetails').value.split('^');
                for (var i = 0; i < ExistsItem.length; i++) {
                    if (ExistsItem[i] != '') {
                        if (deptFlag == "0") {
                            if (ExistsItem[i].split('~')[2] == empID) {
                                    //userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_38');
                                    if (UsrAlrtMsg3 != null) {
                                        //alert(userMsg);
                                        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                                    return false;
                                }
                                else {
                                        // alert("This person already added");
                                        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                                    return false;
                                }
                                secFlag = 1;
                                return false;
                            }
                        }
                    }
                }
            }
            if (secFlag == 0) {
                var addItems = prsnName + '~' + clientName + '~' +
                               empID + '~' + Contacttype + '~' + contactTypeID + '~' +
                               prsnMobile + '~' + prsnLandNo + '~' +
                               prsnEmail + '~' + prsnPrimary + '~' +
                               cType + '~' + uniqAddID + '^';
                document.getElementById('hdnPrsnDetails').value += addItems;
                CreateContactPerson();
                return false;
            }
        }
        return false;
    }

    function CreateContactPerson() {
        document.getElementById('divPrsnDetails').innerHTML = "";
        var items = document.getElementById('hdnPrsnDetails').value.split('^');
        var startTag, bodyTag, endTag;
        if (items != "") {
            var vType = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_049") == null ? "Contact Type" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_049");
            var vName = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_050") == null ? "Contact Name" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_050");
            var vMobile = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_051") == null ? "Mobile Number" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_051");
            var vLandLine = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_052") == null ? "LandLine Number" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_052");
            var vEmail = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_053") == null ? "Email" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_053");
            var vPrimary = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_054") == null ? "Primary" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_054");
            var vAction = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_055") == null ? "Action" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_055");
            var vbutton = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_056") == null ? "Add Details" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_056");
            startTag = "<TABLE ID='tabDrg1' Cellpadding='2' Cellspacing='1' width='800px' class='dataheaderInvCtrl' style='font-size: 11px;' ><TBODY><tr class='dataheader1'><th scope='col' align='left' width='12%'> " + vType + " </th><th scope='col' align='left' width='12%'> " + vName + " </th><th scope='col' align='left' width='8%'> " + vMobile + " </th><th scope='col' align='left' width='8%'> " + vLandLine + " </th><th scope='col' align='left' width='12%'> " + vEmail + " </th><th scope='col' align='left' width='5%'>" + vPrimary + "</th><th scope='col' align='left' width='5%'>" + vAction + "</th></tr>";
            endTag = "</TBODY></TABLE>";
            bodyTag = startTag;
            for (var i = 0; i < items.length; i++) {
                if (items[i] != "") {
                    bodyTag += "<TR><TD>" + items[i].split('~')[3] + "</TD>";
                    if (items[i].split('~')[9] != 'CLT') {
                        bodyTag += "<TD>" + items[i].split('~')[0] + "</TD>";
                    }
                    else {
                        bodyTag += "<TD>" + items[i].split('~')[1] + "</TD>";
                    }
                    bodyTag += "<TD style='display: none;'>" + items[i].split('~')[2] + "</TD>";
                    bodyTag += "<TD>" + items[i].split('~')[5] + "</TD>";
                    bodyTag += "<TD>" + items[i].split('~')[6] + "</TD>";
                    bodyTag += "<TD>" + items[i].split('~')[7] + "</TD>";
                    bodyTag += "<TD>" + items[i].split('~')[8] + "</TD>";
                    bodyTag += "<TD><input name='" + items[i] + "' onclick='return EditPrsnDetails(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'/><input name='" + items[i] + "' onclick='return deletePrsnDetails(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/></TD>";
                    bodyTag += "</TR>";
                }
            }
            bodyTag += endTag;
            document.getElementById('tdPrsnDetails').style.display = 'table-cell';
            document.getElementById('divPrsnDetails').innerHTML = bodyTag;
            document.getElementById('txtPersonName').value = '';
            document.getElementById('txtPrsnMobile').value = '';
            document.getElementById('txtPrsnLandNo').value = '';
            document.getElementById('txtPrsnEmail').value = '';
            document.getElementById('txtCntClient').value = '';
            document.getElementById('chkPrsnPrimary').checked = false;
            document.getElementById('hdnAddressID').value = '0';
            document.getElementById('btnPrsnAdd').value = vbutton;
            document.getElementById('drplstPerson').disabled = false;
            document.getElementById('drplstPerson').value = 0;
            document.getElementById('hdnEmpID').value = '';
        }
    }

    function EditPrsnDetails(EditItems) {
        if (document.getElementById('btnPrsnAdd').value == 'Update') {
            AddContactPerson();
        }
        if (EditItems != '') {
            deletePrsnDetails(EditItems);
            var vUpdate12 = SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057") == null ? "Update" : SListForAppDisplay.Get("Invoice_ClientMaster_aspx_057");
            document.getElementById('btnPrsnAdd').value = vUpdate12;
            if (EditItems.split('~')[9] != 'CLT') {
                document.getElementById('tdtxtClnt').style.display = "none";
                document.getElementById('tdtxtPrsn').style.display = "table-cell";
                document.getElementById('txtPersonName').value = EditItems.split('~')[0];
                document.getElementById('hdnEmpID').value = '';
                document.getElementById('hdnEmpID').value = EditItems.split('~')[2];
            }
            else {
                document.getElementById('tdtxtClnt').style.display = "table-cell";
                document.getElementById('tdtxtPrsn').style.display = "none";
                document.getElementById('txtCntClient').value = EditItems.split('~')[1];
            }
            document.getElementById('txtPrsnMobile').value = EditItems.split('~')[5];
            document.getElementById('txtPrsnLandNo').value = EditItems.split('~')[6];
            document.getElementById('txtPrsnEmail').value = EditItems.split('~')[7];
            if (EditItems.split('~')[8] == 'Y') {
                document.getElementById('chkPrsnPrimary').checked = true;
            }
            else {
                document.getElementById('chkPrsnPrimary').checked = false;
            }
            document.getElementById('drplstPerson').value = EditItems.split('~')[4];
            document.getElementById('hdnAddressID').value = EditItems.split('~')[10];
            document.getElementById('drplstPerson').disabled = true;
            document.getElementById('txtPersonName').focus();
        }
    }

    function deletePrsnDetails(DeleteItems) {
        var ExitItems = document.getElementById('hdnPrsnDetails').value.split('^');
        var NewItems = '';
        if (ExitItems != '') {
            for (var i = 0; i < ExitItems.length; i++) {
                if (ExitItems[i] != '') {
                    if (ExitItems[i] != DeleteItems) {
                        NewItems += ExitItems[i] + '^';
                    }
                }
            }
        }
        document.getElementById('hdnPrsnDetails').value = '';
        document.getElementById('hdnPrsnDetails').value = NewItems;
        CreateContactPerson();
    }

    function GenerateContactTable() {
        var empContact = document.getElementById('hdnGetEmpContact').value;
        var otherContact = document.getElementById('hdnGetOtherContact').value;
        document.getElementById('hdnPrsnDetails').value = empContact + otherContact;
        CreateContactPerson();
    }

    function chckPrsnPrimary() {
        var flag = 0;
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_49") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_49") : "Already primary contact person was selected";
        if (document.getElementById('hdnPrsnDetails').value != "") {
            var detail = document.getElementById('hdnPrsnDetails').value.split("^");
            for (var i = 0; i < detail.length; i++) {
                if (detail[i].split('~')[8] == "Y") {
                    flag = 1;
                }
            }
            if (flag != 0) {
                   // userMsg = SListForApplicationMessages.Get('Invoice\\ClientMaster.aspx_39');
                    if (UsrAlrtMsg != null) {
                        document.getElementById('chkPrsnPrimary').checked = false;
                        //alert(userMsg);
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                else {
                        // alert("Already primary contact person was selected");
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    return false;
                }
                document.getElementById('chkPrsnPrimary').checked = false;
                document.getElementById('chkPrsnPrimary').focus();
                return false;

            }
        }
    }
    function SetContextKey() {
        var deptName = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].text;
        var deptCode = document.getElementById('drplstPerson').options[document.getElementById('drplstPerson').selectedIndex].value;
        var depart = document.getElementById('hdnAddDepart').value.split('^');
        var flag = 0;
        for (var i = 0; i < depart.length; i++) {
            if (depart[i] != "") {
                if (deptCode == depart[i].split('~')[1]) {
                    flag = 1;
                    break;
                }
            }
        }
        if (flag == 1) {
            document.getElementById('hdnEmpID').value = "-1";
            document.getElementById('tdtxtClnt').style.display = "table-cell";
            document.getElementById('tdtxtPrsn').style.display = "none";
        }
        else {
            document.getElementById('tdtxtClnt').style.display = "none";
            document.getElementById('tdtxtPrsn').style.display = "table-cell";
            $find('AutoCompleteExtender3').set_contextKey(deptCode);
        }
        return;
    }
    function ShowPopUP() {
        $find('ModelPopPatientSearch').show();
        document.getElementById('pnlClientStatus').style.display = 'block';
        return false;
    }


    function TempDate() {
        $("#txtFDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
                yearRange: '2012:2030',
                dateFormat: 'dd/mm/yy'
        });
        $("#txtTDate").datepicker({
            changeMonth: true,
            changeYear: true,
            minDate: 0,
                yearRange: '2012:2030',
                dateFormat: 'dd/mm/yy'
        })
        $("#TxtRptPrintFrom").datepicker({
            changeMonth: true,
            changeYear: true,
            //minDate: 0,
                yearRange: '2012:2030',
                dateFormat: 'dd/mm/yy'
        })
    }
    $(document).ready(function() {
        $('#tdCommercial').show();
        $('#tdLogoStatus').hide();
        });
        $(document).on("click", "input[type='checkbox'][name^='RdoClientRmtAccess']", function(e) {
//            $('#RdoClientRmtAccess').on('click', function(e) {
            if (e.target.id == 'RdoClientRmtAccess_0') {
                if (this.checked) {
                    $("#RdoClientRmtAccess_1").prop("checked", false);
                    $("#RdoClientRmtAccess_2").prop("checked", false);
                }

            }
            else {
                if ($("#RdoClientRmtAccess_1").is(':checked') || $("#RdoClientRmtAccess_2").is(':checked')) {
                    $("#RdoClientRmtAccess_0").prop("checked", false);
                }
                else{$("#RdoClientRmtAccess_0").prop("checked", true);}
             }

        });

        //----Code End------------
        function LoadCSS() {
            $(document).ready(function() {
                //$('#tdCommercial').show();
               $('#tdLogoStatus').hide();
            $('INPUT[type="text"]').focus(function() {
                $(this).addClass("focus");
            });
            $('INPUT[type="text"]').blur(function() {
                $(this).removeClass("focus");
            });
            $('INPUT[type="checkbox"]').focus(function() {
                $(this).addClass("chkfocus");
            });
            $('INPUT[type="checkbox"]').blur(function() {
                $(this).removeClass("chkfocus");
            });
            $('#txtaddres1').focus(function() {
                $(this).addClass("focus");
            });
            $('#txtaddres1').blur(function() {
                $(this).removeClass("focus");
            });
            $('#RdoClientRmtAccess input[type="checkbox"]').on('click', function(e) {
             if (e.target.id == 'RdoClientRmtAccess_0') {
                if (this.checked) {
                    $("#RdoClientRmtAccess_1").prop("checked", false);
                    $("#RdoClientRmtAccess_2").prop("checked", false);
                }

            }
            else {
                if($("#RdoClientRmtAccess_1").is(':checked') || $("#RdoClientRmtAccess_2").is(':checked'))
                {
                $("#RdoClientRmtAccess_0").prop("checked", false);
                }
                else{$("#RdoClientRmtAccess_0").prop("checked", true);}
             }
            });
        });
    }
    function CheckLocationName(codeType, TxtID) {
        var txtValue = document.getElementById(TxtID).value.trim();
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_50") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_50") : "Select the Location Name From List";
	

        if (txtValue != '') {
            if (document.getElementById('hdncollectioncenterid').value == '0') {
                    // alert('Select the Location Name From List')
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('txtcollectioncenter').focus();
                document.getElementById('txtcollectioncenter').value = '';
                return false;
            }
        }
    }

    function CheckHubName(codeType, TxtID) {
        var txtValue = document.getElementById(TxtID).value.trim();
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_51") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_51") : "Select the Hub Name From List";

        if (txtValue != '') {
            if (document.getElementById('hdnHubID').value == '0') {
                    //alert('Select the Hub Name From List')
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('txtHub').focus();
                document.getElementById('txtHub').value = '';
                return false;
            }
        }
    }


    function CheckZoneName(codeType, TxtID) {
        var txtValue = document.getElementById(TxtID).value.trim();

            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_52") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_52") : "Select the Zone Name From List";
        if (txtValue != '') {
            if (document.getElementById('hdntxtzoneID').value == '0') {
                    //alert('Select the Zone Name From List')
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('txtzone').focus();
                document.getElementById('txtzone').value = '';
                return false;
            }
        }
    }


    function CheckRouteName(codeType, TxtID) {
        var txtValue = document.getElementById(TxtID).value.trim();
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_53") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_53") : "Select the Route Name From List";

        if (txtValue != '') {
            if (document.getElementById('hdntxtrouteID').value == '0') {
                    //alert('Select the Route Name From List')
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                document.getElementById('txtRouteName').focus();
                document.getElementById('txtRouteName').value = '';
                return false;
            }
        }
    }

    function ClearFields(Name) {
        if (Name == 'LOC') {
            document.getElementById('hdncollectioncenterid').value = '0';
        }
        else if (Name == 'HUB') {
            document.getElementById('hdnHubID').value = '0';
        }
        else if (Name == 'ZON') {
            document.getElementById('hdntxtzoneID').value = '0';
        }
        else if (Name == 'ROU') {
            document.getElementById('hdntxtrouteID').value = '0';
        }
        else if (Name == 'CLI') {
            document.getElementById('hdnHosOrRefID').value = '';
        }
        else if (Name == 'TAX') {
            document.getElementById('hdnTaxValue').value = '';
        }
        else if (Name == 'Pol') {
            document.getElementById('hdnPolicyID').value = '';
        }
        else if (Name == 'Vol') {
            document.getElementById('hdnVolID').value = '0';
        }
        else if (Name == 'TUN') {
            document.getElementById('hdnTodID').value = '0';
        }
    }

    function CheckTaxName(codeType, TxtID) {
            var AlrtWinHdr = SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_002") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Invoice_ClientMaster_aspx_54") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_54") : "Select the Tax Name From List";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_55") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_55") : "Select the Policy From List";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_56") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_56") : "Select the Volume Based Discount From List";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Invoice_ClientMaster_aspx_57") != null ? SListForAppMsg.Get("Invoice_ClientMaster_aspx_57") : "Select the Turn Over Discount From List";
        var txtValue = document.getElementById(TxtID).value.trim();
        if (codeType == 'TAX') {
            if (txtValue != '') {
                if (document.getElementById('hdnTaxValue').value == '') {
                        // alert('Select the Tax Name From List');
                        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                    document.getElementById('txtTaxName').focus();
                    document.getElementById('txtTaxName').value = '';
                    return false;
                }
            }
        }
        else if (codeType == 'Pol') {
            if (txtValue != '') {
                if (document.getElementById('hdnPolicyID').value == '') {
                        // alert('Select the Policy From List');
                        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    document.getElementById('txtPolicyName').focus();
                    document.getElementById('txtPolicyName').value = '';
                    return false;
                }
            }
        }
        else if (codeType == 'Vol') {
            if (txtValue != '') {
                if (document.getElementById('hdnVolID').value == '0') {
                        //alert('Select the Volume Based Discount From List');
                        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    document.getElementById('txtvolume').focus();
                    document.getElementById('txtvolume').value = '';
                    return false;
                }
            }

        }
        else if (codeType == 'TUN') {
            if (txtValue != '') {
                if (document.getElementById('hdnTodID').value == '0') {
                        // alert('Select the Turn Over Discount From List');
                        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                    document.getElementById('txtTODCode').focus();
                    document.getElementById('txtTODCode').value = '';
                    return false;
                }
            }

        }
    }

    function SetContextKeyRefHos() {
        var ClientTypeID = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].value;
        var ClientTypeName = document.getElementById('ddlClientType').options[document.getElementById('ddlClientType').selectedIndex].innerText;
        var ClientTypeCode = '';
        var vCode = '';
        var parentClientTypeID = '';
        var DisplayValue = '';
        var flag = 0;
        var skipID = 0;

        document.getElementById('chkisparent').disabled = false;

        vCode = document.getElementById('hdnGetParentID').value;
        if (ClientTypeName == 'Study') {
            ClientTypeCode = 'CRO';
            document.getElementById('chkisparent').checked = true;
            funenableparent();
            flag = 1;
        }
        else if (ClientTypeName == 'Site') {
            ClientTypeCode = 'STY';
            document.getElementById('chkisparent').checked = true;
            funenableparent();
            flag = 1;
        }
        else if (ClientTypeName == 'CRO') {
            document.getElementById('chkisparent').checked = false;
            document.getElementById('chkisparent').disabled = true;
            document.getElementById('isparentclient').style.display = "none";
            document.getElementById('txtparentClient').value = '';
            document.getElementById('chkDebtor').checked = false;
            funenableparent();
            flag = 1;
        }
        if (flag == 1) {
            if (vCode != '') {
                var getClientTypeID = vCode.split('^');
                for (var i = 0; i < getClientTypeID.length; i++) {
                    if (getClientTypeID[i] != '') {
                        if (getClientTypeID[i].split('~')[1] == ClientTypeCode) {
                            parentClientTypeID = getClientTypeID[i].split('~')[0];
                            break;
                        }
                    }
                }
            }
        }
        else {
            parentClientTypeID = ClientTypeID;
        }
        if (ClientTypeName == 'Referring Hospital' || ClientTypeName == 'Hospital') {

            if (ClientTypeID != null && ($find('AutoCompleteExtender6') != null || $find('AutoCompleteExtender6') != undefined)) {
                $find('AutoCompleteExtender6').set_contextKey(ClientTypeID);
            }
            document.getElementById('txtClientName').className = 'AutoCompletesearchBox1';

        }
        else if (ClientTypeName == 'Referring Physician') {
            if (ClientTypeID != null && ($find('AutoCompleteExtender6') != null || $find('AutoCompleteExtender6') != undefined)) {
                $find('AutoCompleteExtender6').set_contextKey(ClientTypeID);
            }
            document.getElementById('txtClientName').className = 'AutoCompletesearchBox1';

        }
        else {
            if ($find('AutoCompleteExtender6') != null || $find('AutoCompleteExtender6') != undefined)
                $find('AutoCompleteExtender6').set_contextKey('');
            document.getElementById('txtClientName').className = 'Txtboxsmall1';

            //txt.style['width'] = '170px';

        }
        // begin Modifed by NallaThambi /parentClient AutoComplete Not working/
        if (skipID == 0 && ($find('AutoCompleteExtender1') != null)) {
            var OrgID = document.getElementById('hdnOrgID').value;
            $find('AutoCompleteExtender1').set_contextKey(OrgID + '~' + 0 + '~' + 0 + '~');
        }
        else {
            document.getElementById('hdnSetParentID').value = OrgID + '~' + 0 + '~' + 0 + '~';
        }
        // END
        if (ClientTypeID == 5 && document.getElementById('hdnIsCtParentOrg').value == 'Y') {
            document.getElementById('tdIsSponsor').style.display = 'table-cell';
        }
        else {
            document.getElementById('tdIsSponsor').style.display = 'none';
        }
    }
    
</script>

    </form>
</body>
</html>
