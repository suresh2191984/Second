<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Intend.aspx.cs" Inherits="Inventory_Intend"
    EnableEventValidation="false" meta:resourcekey="PageResource2"   %>

<%@ Register Src="~/InventoryCommon/Controls/InventorySearch.ascx" TagName="InventorySearch"
    TagPrefix="uc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Intend Detail View</title>
 
    <script language="javascript" type="text/javascript">
        var userMsg;
        function GetLocationlist() {


            var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;

            document.getElementById('hdnSelectOrgid').value = drpOrgid;
            //            var options = document.getElementById('hdnlocation').value;
            //            var ddlLocation = document.getElementById('ddlLocation');
            //            //var ddlUser = document.getElementById('ddlUser');
            //          //  var userList = document.getElementById('hdnUserlist').value;

            //            //ddlUser.options.length = 0;
            //            ddlLocation.options.length = 0;
            ////            var optn1 = document.createElement("option");
            ////            ddlUser.options.add(optn1);
            ////            optn1.text = "-----Select-----";
            ////            optn1.value = "0";

            //            var list = options.split('^');
            //            for (i = 0; i < list.length; i++) {
            //                if (list[i] != "") {
            //                    var res = list[i].split('~');



            //                    if (drpOrgid == res[0]) {
            //                        var optn = document.createElement("option");
            //                        ddlLocation.options.add(optn);
            //                        optn.text = res[2];
            //                        optn.value = res[1];
            //                    }

            //                }
            //            }
        }
        //



        //        function locationdetails() {
        //            var Trustedorgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;
        //            if (Trustedorgid > 0) {

        //               document.getElementById('hdnSelectOrgid').value = Trustedorgid;
        //            }
        //           
        //            var Fromlocationid = document.getElementById('ddlLocation').options[document.getElementById('ddlLocation').selectedIndex].value;

        //            if (Fromlocationid > 0) {

        //                document.getElementById('hdnFromLocationID').value = Fromlocationid;
        //            }

        //        }


        function checkboxSelection(ID) {

            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {
                document.getElementById('CheckRaisedFrom').checked = true;
                if (ID == "CheckRaisedFrom") {
                    document.getElementById('CheckRaisedFrom').checked = true;
                    document.getElementById('CheckRaisedTo').checked = false;




                } else {
                    document.getElementById('CheckRaisedFrom').checked = false;
                    document.getElementById('CheckRaisedTo').checked = true;


                }
            }

        }




        //old =======================================================================



        function RaisedCheckBox() {


            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {

                document.getElementById('CheckRaisedFrom').visible = true;
                document.getElementById('CheckRaisedTo').visible = true;
                //document.getElementById('CheckRaisedTo').checked = true;

                if (document.getElementById('CheckRaisedFrom').checked == true) {

                        //document.getElementById('lblLocation').style.display = 'hide';
                        //document.getElementById('ddlLocation').style.display = 'hide';
                        //document.getElementById('lblRaiseLocation').style.display = 'hide';
                        //document.getElementById('ddlRaiselocation').style.display = 'hide';
                        //document.getElementById('lblIssueLocation').style.display = 'show';
                        //document.getElementById('ddlIssuelocation').style.display = 'show';

                        $('#lblLocation').removeClass().addClass('hide');
                        $('#ddlLocation').removeClass().addClass('hide');
                        $('#lblRaiseLocation').removeClass().addClass('hide');
                        $('#ddlRaiselocation').removeClass().addClass('hide');
                        $('#lblIssueLocation').removeClass().addClass('show');
                        $('#ddlIssuelocation').removeClass().addClass('show');

                    //                        document.getElementById('lblLocation').visible = false;
                    //                        document.getElementById('ddlLocation').visible = false;
                    //                        document.getElementById('lblRaiseLocation').visible = false;
                    //                        document.getElementById('ddlRaiselocation').visible = false;
                    //                        document.getElementById('lblIssueLocation').visible = true;
                    //                        document.getElementById('ddlIssuelocation').visible = true;


                    //                        document.getElementById('divLocation').style.display = 'none';
                    //                        document.getElementById('divlblRaiseLocation').style.display = 'none';
                    //                        document.getElementById('divlblIssueLocation').style.display = 'block';



                }
                else if (document.getElementById('CheckRaisedTo').checked == true) {

                    //                        document.getElementById('divLocation').style.display = 'none';
                    //                        document.getElementById('divlblRaiseLocation').style.display = 'block';
                    //                        document.getElementById('divlblIssueLocation').style.display = 'none';


                        //document.getElementById('lblLocation').style.display = 'hide';
                        //document.getElementById('ddlLocation').style.display = 'hide';
                        //document.getElementById('lblRaiseLocation').style.display = 'show';
                        //document.getElementById('ddlRaiselocation').style.display = 'show';
                        //document.getElementById('lblIssueLocation').style.display = 'hide';
                        //document.getElementById('ddlIssuelocation').style.display = 'hide';

                        $('#lblLocation').removeClass().addClass('hide');
                        $('#ddlLocation').removeClass().addClass('hide');
                        $('#lblRaiseLocation').removeClass().addClass('show');
                        $('#ddlRaiselocation').removeClass().addClass('show');
                        $('#lblIssueLocation').removeClass().addClass('hide');
                        $('#ddlIssuelocation').removeClass().addClass('hide');


                    //                        document.getElementById('lblLocation').visible = false;
                    //                        document.getElementById('ddlLocation').visible = false;
                    //                        document.getElementById('lblRaiseLocation').visible = true;
                    //                        document.getElementById('ddlRaiselocation').visible = true;
                    //                        document.getElementById('lblIssueLocation').visible = false;
                    //                        document.getElementById('ddlIssuelocation').visible = false;

                }
                else {

                    //                        document.getElementById('lblLocation').visible = false;
                    //                        document.getElementById('ddlLocation').visible = false;
                    //                        document.getElementById('lblRaiseLocation').visible = false;
                    //                        document.getElementById('ddlRaiselocation').visible = false;
                    //                        document.getElementById('lblIssueLocation').visible = false;
                    //                        document.getElementById('ddlIssuelocation').visible = false;


                        //document.getElementById('lblLocation').style.display = 'hide';
                        //document.getElementById('ddlLocation').style.display = 'hide';
                        //document.getElementById('lblRaiseLocation').style.display = 'hide';
                        //document.getElementById('ddlRaiselocation').style.display = 'hide';
                        //document.getElementById('lblIssueLocation').style.display = 'hide';
                        //document.getElementById('ddlIssuelocation').style.display = 'hide';

                        $('#lblLocation').removeClass().addClass('hide');
                        $('#ddlLocation').removeClass().addClass('hide');
                        $('#lblRaiseLocation').removeClass().addClass('hide');
                        $('#ddlRaiselocation').removeClass().addClass('hide');
                        $('#lblIssueLocation').removeClass().addClass('hide');
                        $('#ddlIssuelocation').removeClass().addClass('hide');

                    //                        document.getElementById('divLocation').style.display = 'none';
                    //                        document.getElementById('divlblRaiseLocation').style.display = 'none';
                    //                        document.getElementById('divlblIssueLocation').style.display = 'none';

                }

            }

            else {
                //                    document.getElementById('lblLocation').visible = true;
                //                    document.getElementById('ddlLocation').visible = true;
                //                    document.getElementById('lblRaiseLocation').visible = false;
                //                    document.getElementById('ddlRaiselocation').visible = false;
                //                    document.getElementById('lblIssueLocation').visible = false;
                //                    document.getElementById('ddlIssuelocation').visible = false;

                    //document.getElementById('lblLocation').style.display = 'show';
                    //document.getElementById('ddlLocation').style.display = 'show';
                    //document.getElementById('lblRaiseLocation').style.display = 'hide';
                    //document.getElementById('ddlRaiselocation').style.display = 'hide';
                    //document.getElementById('lblIssueLocation').style.display = 'hide';
                    //document.getElementById('ddlIssuelocation').style.display = 'hide';

                    $('#lblLocation').removeClass().addClass('show');
                    $('#ddlLocation').removeClass().addClass('show');
                    $('#lblRaiseLocation').removeClass().addClass('hide');
                    $('#ddlRaiselocation').removeClass().addClass('hide');
                    $('#lblIssueLocation').removeClass().addClass('hide');
                    $('#ddlIssuelocation').removeClass().addClass('hide');

                    //document.getElementById('divcheck').style.display = 'hide';
                    $('#divcheck').removeClass().addClass('hide');

                    //document.getElementById('CheckRaisedFrom').style.display = 'hide';
                    //document.getElementById('CheckRaisedTo').style.display = 'hide';
                    $('#CheckRaisedFrom').removeClass().addClass('hide');
                    $('#CheckRaisedTo').removeClass().addClass('hide');

                document.getElementById('CheckRaisedFrom').visible = false;
                document.getElementById('CheckRaisedTo').visible = false;

            }
        }






        function CheckDates(splitChar) {

            var drpIndentType = $('#ddlIndentType').val();
            $('#hdnIsIndentType').val(drpIndentType);
            //            var drpOrgid = document.getElementById('ddlTrustedOrg').options[document.getElementById('ddlTrustedOrg').selectedIndex].value;

            //            if ((drpOrgid == 0) || (drpOrgid <= 0)) {
            //                userMsg = SListForApplicationMessages.Get('SelectRole.aspx_1');
            //                if (userMsg != null) {
            //                    alert(userMsg);
            //                    return false;
            //                }
            //                else {
            //                    alert("Select Organization");
            //                    return false;
            //                }
            //                return false;


            //            }


            //            if (document.getElementById('CheckRaisedTo').checked == true) {

            //                document.getElementById('CheckRaisedFrom').checked = false;
            //            }
            
            if (document.getElementById('txtFrom').value == '') {
                var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_05") == null ? "Select From Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_05");
                ValidationWindow(userMsg, errorMsg);
            }
            else if (document.getElementById('txtTo').value == '') {
                var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_06") == null ? "Select To Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_06");
                ValidationWindow(userMsg, errorMsg);
            }
            else {
                //Assign From And To Date from Controls 
                DateFrom = document.getElementById('txtFrom').value;
                DateTo = document.getElementById('txtTo').value;
                //DateNow = now.split(splitChar);
                //Argument Value 0 for validating Current Date And To Date 
                //Argument Value 1 for validating Current From And To Date 
                //if (doDateValidation(DateTo, DateNow, 0)) {
                if (CheckFromToDate(DateFrom, DateTo)) {
                        //alert("Validation Succeeded");



                    //  intendcheckboxvalidation();
                    return true;

                    }
                    else {
                        return false;
                    }
                //}
               // else {
               //     return false;
               // }
            }


            //            var getFromLocation = $('#ddlFromLocation option:selected').val();
            //            var getToLocation = $('#ddlLocation option:selected').val();
            //            if (getFromLocation != '-1' && getToLocation != '-1') {
            //                if (getFromLocation == getToLocation) {
            //                    userMsg = SListForApplicationMessages.Get('Inventory\\Intend.aspx_3');
            //                    if (userMsg != null) {
            //                        alert(userMsg);
            //                        return false;
            //                    }
            //                    else {
            //                        alert('change To locations');
            //                        return false;
            //                    }
            //                }
            //            }
        }


        function doDateValidation(from, to, bit) {
            var dayFlag = true;
            var monthFlag = true;
            var i = from.length - 1;
            if (Number(to[i]) >= Number(from[i])) {
                if (Number(to[i]) == Number(from[i])) {
                    monthFlag = false;
                }
                i--;
                if (Number(to[i]) >= Number(from[i])) {
                    if (Number(to[i]) == Number(from[i])) {
                        dayFlag = false;
                    }
                    i--;
                    if (Number(to[i]) >= Number(from[i])) {
                        i--;
                        return true;
                    }
                    else {
                        if (dayFlag) {
                            return true;
                        }
                        else {
                            if (bit == 0) {
                                var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_07") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_07");
                                ValidationWindow(userMsg, errorMsg);
                            }
                            else {
                                var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_07") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_07");
                                ValidationWindow(userMsg, errorMsg);
                            }
                            return false;
                        }
                    }
                }
                else if (monthFlag) {
                    return true;
                }
                else {
                    if (bit == 0) {
                        var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_07") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_07");
                        ValidationWindow(userMsg, errorMsg);   
                    }
                    else {
                        var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_07") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_07");
                        ValidationWindow(userMsg, errorMsg);  
                    }
                    return false;
                }
            }
            else {
                if (bit == 0) {
                    var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_07") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_07");
                    ValidationWindow(userMsg, errorMsg);  
                }
                else {
                    var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_07") == null ? "Invalid Date" : SListForAppMsg.Get("StockIntend_Intend_aspx_07");
                    ValidationWindow(userMsg, errorMsg);  
                }
                return false;
            }
        }


        //Uncheckes all the radio inside the grid except one at a time -GridSingleRadioCheck
        function SelectIntendRowCommon(rid, IntId, Intstatus, locationID, IntendReceivedID, IntendReceivedDetailID, ToLocationID, ReceivedOrgID, orgid,TaskId) {
            $('#ddlAction').show();
            $('#divAction').show();
            $('#ddlAction').empty();
            chosen = "";
            var len = document.forms[0].elements.length;
            for (var i = 0; i < len; i++) {
                if (document.forms[0].elements[i].type == "radio") {
                    document.forms[0].elements[i].checked = false;
                }
            }
            document.getElementById(rid).checked = true;
            document.getElementById('hdnId').value = IntId;
            document.getElementById('hdnStatus').value = Intstatus;
            document.getElementById('hdnLocationID').value = locationID;
            document.getElementById('hdnIntendReceivedID').value = IntendReceivedID;
            document.getElementById('hdnIntendReceivedDetailID').value = IntendReceivedDetailID;
            document.getElementById('hdnTolocationID').value = ToLocationID;
            document.getElementById('hdnReceivedOrgID').value = ReceivedOrgID;
            document.getElementById('hdnorgid').value = orgid;
            document.getElementById('hdnTaskId').value = TaskId;
            //$('#btnSetAction').click();
            fnSetActions();
        }


        function fnSetActions() {

            $.ajax({
                type: "GET",
                url: '../InventoryCommon/setAction.ashx?IsTransfer=' + $('#hdnIsTransfer').val() + '&hdnLocationID=' + document.getElementById('hdnLocationID').value + '&hdnTolocationID=' + document.getElementById('hdnTolocationID').value + '&hdnStatus=' + document.getElementById('hdnStatus').value + '&InventoryLocationID=' + document.getElementById('hdnInventoryLocationID').value + '&InventoryIndentType=' + document.getElementById('hdnIsIndentType').value,
                contentType: "application/json; charset=utf-8",
                dataType: "html",
                async: true,
                success: function(data) {
                    if (data != '||') {
                        BindDDLACTION(data);
                    }
                    else {
                        $('#ddlAction').hide();
                        $('#divAction').hide();
                    }
                },
                failure: function(msg) {
                    var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_02") == null ? "Error" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                }
            });

        }

        function BindDDLACTION(data) {
            $('#ddlAction').empty();
            var getValue = data.split('|');
            var actionValue = getValue[0].split('@');
            var actionUrl = getValue[1].split('@');
            var actionCode = getValue[2].split('@');
            if (actionValue.length > 0) {
                for (var i = 0; i < actionValue.length; i++) {
                    $('#ddlAction').append('<option ac="' + actionCode[i] + '" value="' + actionUrl[i] + '">' + actionValue[i] + '</option>');

                    if (i == 0) {
                        $('#hdnDDLActionText').val(actionValue[i]);
                        $('#hdnDDLActionValue').val(actionUrl[i]);
                    }
                }
            }
        }



        //        function checkDetails() {
        //            if (document.getElementById('ddlStatus').value == '0') {
        //                alert('Select the Indent Status ');
        //                document.getElementById('ddlLocation').focus();
        //                return false;
        //            }
        //            if (document.getElementById('ddlUser').value == '0') {
        //                alert('Select the received by ');
        //                document.getElementById('ddlUser').focus();
        //                return false;
        //            }
        //        }


            function intendcheckboxvalidation() {
                if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {
                    if ((document.getElementById('CheckRaisedTo').checked != true) && (document.getElementById('CheckRaisedFrom').checked != true)) {
                        var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_10") == null ? "Select any one indent type" : SListForAppMsg.Get("StockIntend_Intend_aspx_10");
                        ValidationWindow(userMsg, errorMsg);
                        //document.getElementById('divgvIntend').style.display = "none";
                        $('#divgvIntend').removeClass().addClass('hide');
                        return false;
                    }
                    else {
                        return true;
                        //document.getElementById('divgvIntend').style.display = "block";
                        $('#divgvIntend').removeClass().addClass('show');
                    }
                }
                else {
                    return true;
                }



        }


        function indentValidationForCS() {

            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {

                if ((document.getElementById('CheckRaisedTo').checked == true)) {

                    if (document.getElementById('hdnStatus').value == 'Pending') {


                        if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].text == 'View Indent')) {
                            //alert('This Intend is not yet');

                            return true;
                        }
                        else {
                            var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_11") == null ? "This Indent is not suitable" : SListForAppMsg.Get("StockIntend_Intend_aspx_11");
                            ValidationWindow(userMsg, errorMsg);
                            return false;

                        }
                    }

                }





            }

            if ((document.getElementById('hdnCS').value == 'CS-POS') || (document.getElementById('hdnCS').value == 'CS')) {



                if ((document.getElementById('CheckRaisedFrom').checked == true)) {

                    if (document.getElementById('hdnStatus').value == 'Pending') {

                        if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].text == 'View Indent') || (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].text == 'Issue Stock')) {
                            //alert('This Intend is not yet');

                            return true;
                        }
                        else {
                            var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_11") == null ? "This Indent is not suitable" : SListForAppMsg.Get("StockIntend_Intend_aspx_11");
                            ValidationWindow(userMsg, errorMsg);
                        }
                    }



                }
            }



        }






        function intendValidation() {

            if (document.getElementById('hdnId').value == '') {
                var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_12") == null ? "Select an intend" : SListForAppMsg.Get("StockIntend_Intend_aspx_12");
                ValidationWindow(userMsg, errorMsg);
            }


            if (document.getElementById('hdnStatus').value == 'Issued') {
                if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Intend') || (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'Received Indent')) {
                    return true;
                }
                else {
                    var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_13") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_Intend_aspx_13");
                    ValidationWindow(userMsg, errorMsg);
                }
            }
            if (document.getElementById('hdnStatus').value == 'Inprogress') {
                if (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'Issue Indent') {
                    var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_13") == null ? "This indent is not approved yet" : SListForAppMsg.Get("StockIntend_Intend_aspx_13");
                    ValidationWindow(userMsg, errorMsg);
                    
                }
            }

            if ((document.getElementById('hdnCS').value != 'CS-POS') && (document.getElementById('hdnCS').value != 'CS')) {
                if (document.getElementById('hdnStatus').value == 'Received') {
                    if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Intend') && (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') != 'Issue Stock')) {

                        return true;
                    }
                    else {
                        var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_11") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_Intend_aspx_11");
                        ValidationWindow(userMsg, errorMsg);
                       
                    }
                }
            }

            if ($('#CheckRaisedFrom').length > 0 && document.getElementById('CheckRaisedFrom').checked == true) {

                if (document.getElementById('hdnStatus').value == 'Received') {
                    if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Intend') && (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') != 'Issue Stock')) {

                        return true;
                    }
                    else {
                        var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_11") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_Intend_aspx_11");
                        ValidationWindow(userMsg, errorMsg);
                        
                    }
                }

            }

            if (document.getElementById('hdnStatus').value == 'Received') {
                if ((document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') == 'View Intend') && (document.getElementById('ddlAction').options[document.getElementById('ddlAction').selectedIndex].getAttribute('ac') != 'Issue Stock')) {

                    return true;
                }
                else {
                    var userMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_11") == null ? "This indent is not Suitable...." : SListForAppMsg.Get("StockIntend_Intend_aspx_11");
                    ValidationWindow(userMsg, errorMsg);
                }
            }
        }
    
        
        
        
        
        
        
        
    </script>

    <script language="javascript" type="text/javascript">
        function onCalendarShown2() {

            var cal = $find("calendar2");
            //Setting the default mode to month
            cal._switchMode("months", true);

            //Iterate every month Item and attach click event to it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }
        }

        function onCalendarHidden2() {
            var cal = $find("calendar2");
            //Iterate every month Item and remove click event from it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }

        }

        function call2(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar2");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }
 

    </script>

    <script language="javascript" type="text/javascript">
        function onCalendarShown() {

            var cal = $find("calendar1");
            //Setting the default mode to month
            cal._switchMode("months", true);

            //Iterate every month Item and attach click event to it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }
        }

        function onCalendarHidden() {
            var cal = $find("calendar1");
            //Iterate every month Item and remove click event from it
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }

        }

        function call(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar1");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }
    </script>

</head>
<body oncontextmenu="return true;">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader ID="Attuneheader" runat="server" />

                    <div class="contentdata">
                        
                            <div id="divProjection">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                            <div class="marginT10 marginB10">
                            <div class="w-97p marginauto card-md card-md-default padding10 ">
                                <table class="w-100p" >
                                <tr>
                                    <td>
                                        <asp:Label ID="lblMsg" runat="server" meta:resourcekey="lblMsgResource2"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table class="w-100p">
                                            <tr>
                                                <td id="divcheck" class="v-top" >
                                                    <asp:CheckBox ID="CheckRaisedTo" Text=" Indents Raised To Other Location" onclick="checkboxSelection(this.id)"
                                                        CssClass="hide" runat="server" meta:resourcekey="CheckRaisedToResource1" />
                                                    <asp:CheckBox ID="CheckRaisedFrom" Text=" Indents Raised From Other Location" onclick="checkboxSelection(this.id)"
                                                        CssClass="hide" runat="server" 
                                                        meta:resourcekey="CheckRaisedFromResource1" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <table class="w-100p lh25">
                                                        <tr>
                                                            <td nowrap="nowrap">
                                                                <asp:Label ID="Rs_FromDate" Text="From Date" CssClass="bold" runat="server" meta:resourcekey="Rs_FromDateResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtFrom" runat="server" CssClass="datePicker small" onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtFromResource2" />
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="Rs_ToDate" Text="To Date" runat="server" CssClass="bold" meta:resourcekey="Rs_ToDateResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtTo" runat="server" CssClass="datePicker small" onkeypress="return ValidateSpecialAndNumeric(this);" meta:resourcekey="txtToResource2" />
                                                            </td>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="Rs_IndentType" Text="Indent Type" runat="server" CssClass="bold" meta:resourcekey="Rs_IndentTypeResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlIndentType" runat="server" CssClass="small"
                                                                    meta:resourcekey="ddlIndentTypeResource2">
                                                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource7"></asp:ListItem>
                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource8"></asp:ListItem>
                                                                </asp:DropDownList>
                                                                &nbsp;<span class="star-icon"></span>
                                                            </td>
                                                        </tr>
                                                        <tr id="trTrusted" runat="server" >
                                                            <td nowrap="nowrap" runat="server">
                                                                <asp:Label ID="lblStatus" Text="Status" runat="server" CssClass="bold" meta:resourcekey="lblStatusResource2"></asp:Label>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="small" meta:resourcekey="ddlStatusResource2">
                                                                    <asp:ListItem Value="-1" meta:resourcekey="ListItemResource9">-----All-----</asp:ListItem>
                                                                    <asp:ListItem Value="1" meta:resourcekey="ListItemResource10">Received</asp:ListItem>
                                                                    <asp:ListItem Value="2" meta:resourcekey="ListItemResource11">Issued</asp:ListItem>
                                                                    <asp:ListItem Value="3" meta:resourcekey="ListItemResource12">Pending</asp:ListItem>
                                                                    <asp:ListItem Value="5" meta:resourcekey="ListItemResource13">Approved</asp:ListItem>
                                                                    <asp:ListItem Value="4" meta:resourcekey ="PartialIssued">Partial Issued</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td align="left" nowrap="nowrap" runat="server">
                                                                <asp:Label ID="Rs_IndentNo" Text="Indent No" CssClass="bold" runat="server" meta:resourcekey="Rs_IndentNoResource2"></asp:Label>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:TextBox ID="txtIntendNo"  runat="server" CssClass="small" onkeypress="return ValidateMultiLangChar(this);"
                                                                    meta:resourcekey="txtIntendNoResource2"></asp:TextBox>
                                                            </td>
                                                            <td nowrap="nowrap" runat="server">
                                                                <asp:Label ID="lblSelectOrg" runat="server" CssClass="bold" Text="Select Org" 
                                                                    meta:resourcekey="lblSelectOrgResource1"></asp:Label>
                                                            </td>
                                                            <td runat="server">
                                                                <asp:DropDownList ID="ddlTrustedOrg" AutoPostBack="True" TabIndex="1" runat="server"
                                                                    CssClass="small" 
                                                                    OnSelectedIndexChanged="ddlTrustedOrg_SelectedIndexChanged1" 
                                                                    meta:resourcekey="ddlTrustedOrgResource1">
                                                                </asp:DropDownList>
                                                                &nbsp;<span class="star-icon"></span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td class="a-left" nowrap="nowrap">
                                                                <asp:Label ID="lblLocation" Text="Location" CssClass="bold" runat="server" meta:resourcekey="lblLocationResource2"></asp:Label>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlLocation" runat="server" CssClass="small" meta:resourcekey="ddlLocationResource2">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Button ID="btnSearch" ToolTip="Search" runat="server" Text="Search" CssClass="btn"
                                                                    OnClientClick="javascript:return CheckDates('/');" OnClick="btnSearch_Click"
                                                                    meta:resourcekey="btnSearchResource2" />
                                                            </td>
                                                            <td class="a-left">
                                                                <asp:Button ID="btnCancel" ToolTip="Clear" runat="server" Text="Clear" CssClass="btn"
                                                                     OnClick="btnCancel_Click"  meta:resourcekey="btnCancelResource2" />
                                                            </td>
                                                             <td >
                                                            <asp:CheckBox ID="chkSetDefault" runat="server" Text="Set Default" meta:resourcekey="chkSetDefaultResource1" />&nbsp;&nbsp;&nbsp;
                                                        </td>  
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            </div>
                            </div>
                            <table id="tblGrid" class="w-99p marginauto">
                                <tr>
                                    <td>
                                        <div id="divgvIntend" runat="server">
                                            <%--<asp:UpdatePanel ID="Up2" runat="server">
                                            <ContentTemplate>--%>
                                            <asp:GridView ID="gvIntend" EmptyDataText="No matching records found " runat="server" 
                                                AutoGenerateColumns="False" CssClass="responstable w-100p a-center" OnRowDataBound="gvIntend_RowDataBound"
                                                AllowPaging="True" PageSize="10" OnPageIndexChanging="gvIntend_PageIndexChanging"
                                                meta:resourcekey="gvIntendResource2">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdSel" GroupName="SelectRow" ToolTip="Select Row" runat="server"
                                                                meta:resourcekey="rdSelResource2" />
                                                            <asp:HiddenField ID="hdnIntendID" Value='<%# Eval("IntendID") %>' runat="server" />
                                                        </ItemTemplate>
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="IntendNo" HeaderText="Indent No" ItemStyle-HorizontalAlign="Left"
                                                        meta:resourcekey="BoundFieldResource8">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                    <%--<asp:BoundField DataField="IntendDate" DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Left"
                                        HeaderText="Indent Date" meta:resourcekey="BoundFieldResource9">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Indent Date">
                                        <ItemTemplate>
                                            <span>
                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "IntendDate")).ToString(DateTimeFormat)%></span>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="Left" CssClass="w-20p"></ItemStyle>
                                    </asp:TemplateField>
                                                    <%--<asp:BoundField DataField="IntendIssuedDate" DataFormatString="{0:d}"
                                                        HeaderText="Indent Issued Date" meta:resourcekey="BoundFieldResource10">
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-HorizontalAlign="Left"
                                                        meta:resourcekey="BoundFieldResource11">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="LocName" HeaderText="Location" ItemStyle-HorizontalAlign="Left"
                                                        meta:resourcekey="BoundFieldResource12">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="LocationID" HeaderText="Raise Location" ItemStyle-HorizontalAlign="Left"
                                                        Visible="false" meta:resourcekey="BoundFieldResource13">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ToLocationID" HeaderText="Issued Location" ItemStyle-HorizontalAlign="Left"
                                                        Visible="false" meta:resourcekey="BoundFieldResource14">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IndentReceivedNo" HeaderText="Indent Received No" 
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="StockType" HeaderText="Org Type" 
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource3">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                     <asp:BoundField  Visible="false" DataField="TaskId" HeaderText="TaskId" 
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                </Columns>
                                                <PagerStyle CssClass="pagination-ys" HorizontalAlign="Right" />
                                                <HeaderStyle CssClass="responstableHeader" />
                                            </asp:GridView>
                                            <asp:GridView ID="gvStockTansfer" EmptyDataText="No matching records found " runat="server" EmptyDataRowStyle-CssClass="ui-state-info ui-corner-all a-center"
                                                AutoGenerateColumns="False" CssClass="responstable w-100p a-center" OnRowDataBound="gvtranfer_RowDataBound"
                                                AllowPaging="True" PageSize="20" OnPageIndexChanging="gvtranfer_PageIndexChanging"
                                                meta:resourcekey="gvIntendResource2">
                                                <EmptyDataRowStyle CssClass="ui-state-info ui-corner-all a-center"></EmptyDataRowStyle>
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                                                        <ItemTemplate>
                                                            <asp:RadioButton ID="rdSel" GroupName="SelectRow" ToolTip="Select Row" runat="server"
                                                                meta:resourcekey="rdSelResource2" />
                                                            <asp:HiddenField ID="hdnIntendID" Value='<%# Eval("IntendID") %>' runat="server" />
                                                        </ItemTemplate>

<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="IntendNo" HeaderText="Stock Issue  No" 
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource5">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                  <%--  <asp:BoundField DataField="IntendDate" DataFormatString="{0:d}" ItemStyle-HorizontalAlign="Left"
                                        HeaderText="Stock Issue Date" meta:resourcekey="BoundFieldResource6">
                                        <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                    </asp:BoundField>--%>
                                    <asp:TemplateField HeaderText="Stock Issue Date" meta:resourcekey="BoundFieldResource6">
                                        <ItemTemplate>
                                            <span>
                                                <%#((DateTime)DataBinder.Eval(Container.DataItem, "IntendDate")).ToString(DateTimeFormat)%></span>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                                    <%--<asp:BoundField DataField="IntendIssuedDate" DataFormatString="{0:d}"
                                                        HeaderText="Indent Issued Date" meta:resourcekey="BoundFieldResource10">
                                                    </asp:BoundField>--%>
                                                    <asp:BoundField DataField="Status" HeaderText="Status" ItemStyle-HorizontalAlign="Left"
                                                        meta:resourcekey="BoundFieldResource11">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="LocName" HeaderText="Location" ItemStyle-HorizontalAlign="Left"
                                                        meta:resourcekey="BoundFieldResource12">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="LocationID" HeaderText="Raise Location" ItemStyle-HorizontalAlign="Left"
                                                        Visible="false" meta:resourcekey="BoundFieldResource13">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="ToLocationID" HeaderText="Issued Location" ItemStyle-HorizontalAlign="Left"
                                                        Visible="false" meta:resourcekey="BoundFieldResource14">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="IndentReceivedNo" 
                                                        HeaderText="StockIssue Received No" ItemStyle-HorizontalAlign="Left" 
                                                        meta:resourcekey="BoundFieldResource7">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="StockType" HeaderText="Org Type" 
                                                        ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource10">
<ItemStyle HorizontalAlign="Left"></ItemStyle>
                                                    </asp:BoundField>
                                                    <%--   <asp:BoundField DataField="IntendReceivedDetailID" HeaderText="Location" Visible="false" ></asp:BoundField>
                                                  --%>
                                                </Columns>
                                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                <HeaderStyle CssClass="gridHeader" />
                                            </asp:GridView>
                                <asp:GridView ID="gvIntendR" EmptyDataText="No matching records found " runat="server"
                                    AutoGenerateColumns="False" CssClass="gridView w-100p a-center" OnRowDataBound="gvIntend_RowDataBound"
                                    AllowPaging="True" PageSize="20" OnPageIndexChanging="gvIntend_PageIndexChanging"
                                    meta:resourcekey="gvIntendResource2">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Select" ItemStyle-HorizontalAlign="Left" meta:resourcekey="TemplateFieldResource2">
                                            <ItemTemplate>
                                                <asp:RadioButton ID="rdSel" GroupName="SelectRow" ToolTip="Select Row" runat="server"
                                                    meta:resourcekey="rdSelResource2" />
                                                <asp:HiddenField ID="hdnIntendID" Value='<%# Eval("IntendID") %>' runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Indent Date">
                                            <ItemTemplate>
                                                <span>
                                                    <%#((DateTime)DataBinder.Eval(Container.DataItem, "IntendDate")).ToString(DateTimeFormat)%></span>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="LoginName" HeaderText="Indent By" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LocName" HeaderText="Raised From" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LocationName" HeaderText="Raised To" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                       <asp:BoundField DataField="ReferenceNo" HeaderText="OT Request No" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PatientName" HeaderText="Patient Name(UHID)" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PatientNo" HeaderText="Visit No" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IntendNo" HeaderText="Indent No" ItemStyle-HorizontalAlign="Left">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="ReplaceMent Status" ItemStyle-HorizontalAlign="Left" >
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LocationID" HeaderText="Raise Location" ItemStyle-HorizontalAlign="Left"
                                            Visible="false" meta:resourcekey="BoundFieldResource13">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField  DataField="ToLocationID" HeaderText="Issued Location" ItemStyle-HorizontalAlign="Left"
                                            Visible="false" meta:resourcekey="BoundFieldResource14">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField Visible="false" DataField="IndentReceivedNo" HeaderText="Indent Received No"
                                            ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource2">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField Visible="false" DataField="StockType" HeaderText="Org Type"
                                            ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource3">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:BoundField Visible="false" DataField="TaskId" HeaderText="TaskId"
                                            ItemStyle-HorizontalAlign="Left" meta:resourcekey="BoundFieldResource4">
                                            <ItemStyle HorizontalAlign="Left"></ItemStyle>
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                                            <%--</ContentTemplate>
                                        </asp:UpdatePanel>  --%>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </div>
                        <div id="divAction" runat="server" class="hide">
                            <table class="w-100p">
                                <tr id="trGo">
                                    <td class="a-center">
                                        <asp:Label ID="Rs_Info" Text="Select a Record and perform one of the following" runat="server"
                                            meta:resourcekey="Rs_InfoResource1"></asp:Label>
                                        <asp:DropDownList ID="ddlAction" runat="server" CssClass="small hide" onchange="fnGetAction()"
                                            meta:resourcekey="ddlActionResource2">
                        </asp:DropDownList>
                        &nbsp;
                        <asp:Button ID="btnGO" runat="server" OnClientClick="javascript:return intendValidation();"
                            CssClass="btn" Text="GO" OnClick="btnGO_Click"
                            meta:resourcekey="btnGOResource2" />
                    </td>
                </tr>
                <tr id="trMsg" class="hide">
                    <td colspan="2" class="a-center">
                        <asp:Label ID="lblNtAcessRcrd" runat="server" Text="you don't have access the record"
                            meta:resourcekey="lblNtAcessRcrdResource2"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <input type="hidden" id="hdnId" runat="server" />
        <input type="hidden" id="hdnStatus" runat="server" />
        <input type="hidden" id="hdnCS" runat="server" />
        <input type="hidden" id="hdnLocationID" runat="server" />
        <input type="hidden" id="hdnIntendReceivedID" runat="server" />
        <input type="hidden" id="hdnIntendReceivedDetailID" runat="server" />
        <input type="hidden" id="hdnCurrentlocation" runat="server" />
        <input type="hidden" id="hdnTolocationID" runat="server" />
        <input type="hidden" id="hdnIndentType" runat="server" />
        <input type="hidden" id="hdnReceivedOrgID" runat="server" />
        <input type="hidden" id="hdnlocation" runat="server" />
        <input type="hidden" id="hdnSelectOrgid" runat="server" />
        <input type="hidden" id="hdnFromLocationID" runat="server" />
        <input type="hidden" id="hdnorgid" runat="server" />
        <input type="hidden" id="hdnInventoryLocationID" runat="server" />
        <input type="hidden" id="hdnIsTransfer" runat="server" value="N" />
        <input type="hidden" id="hdnIsIndentType" runat="server" value="0" />
        <input type="hidden" id="hdnTaskId" runat="server" value="0" />
    </div>
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnDDLActionText" runat="server" />
     <asp:HiddenField ID="hdnCategoryClear" runat="server" />
    <asp:HiddenField ID="hdnDDLActionValue" runat="server" />
    <attune:attunefooter ID="Attunefooter" runat="server" />
    </form>
    <script type="text/javascript">
        var errorMsg = SListForAppMsg.Get("StockIntend_Intend_aspx_02") == null ? "Alert" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
    </script>
    <script type="text/javascript">
  
        var strPending = SListForAppDisplay.Get("StockIntend_Intend_aspx_01") == null ? "Pending" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strApproved = SListForAppDisplay.Get("StockIntend_Intend_aspx_02") == null ? "Approved" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strApprovedIntend = SListForAppDisplay.Get("StockIntend_Intend_aspx_03") == null ? "Approve Indent" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strInprogress = SListForAppDisplay.Get("StockIntend_Intend_aspx_04") == null ? "Inprogress" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strIssued = SListForAppDisplay.Get("StockIntend_Intend_aspx_05") == null ? "Issued" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strIssuedStock = SListForAppDisplay.Get("StockIntend_Intend_aspx_06") == null ? "Issue Stock" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strIssueIntend = SListForAppDisplay.Get("StockIntend_Intend_aspx_07") == null ? "Issue Indent" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strReceivedIndent = SListForAppDisplay.Get("StockIntend_Intend_aspx_08") == null ? "Received Indent" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");
        var strViewIntend = SListForAppDisplay.Get("StockIntend_Intend_aspx_09") == null ? "View Indent" : SListForAppMsg.Get("StockIntend_Intend_aspx_02");

        var slist = { Pending: strPending, Approved: strApproved,
        ApprovedIntend: strApprovedIntend, Inprogress: strInprogress,
        Issued: strIssued, IssuedStock: strIssuedStock,
        IssueIntend: strIssueIntend, ReceivedIndent: strReceivedIndent,
        ViewIntend: strViewIntend
        };
    </script>

    <script type="text/javascript">

        function fnGetAction() {
            $('#hdnDDLActionText').val($('#ddlAction option:selected').text());
            $('#hdnDDLActionValue').val($('#ddlAction option:selected').val());
        }
        $(document).ready(function() {
            if ($("#Attuneheader_TopHeader1_lblvalue").text() == 'Intend') {
                $("#Attuneheader_TopHeader1_lblvalue").text("Indent");
            }
        });
    </script>

</body>
</html>
