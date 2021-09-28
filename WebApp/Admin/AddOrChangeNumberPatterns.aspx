<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOrChangeNumberPatterns.aspx.cs"
    Inherits="Admin_AddOrChangeNumberPatterns" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add/Change Pattern</title>
    <script language="javascript" type="text/javascript">
     var AlertMsg;
////     $(document).ready(function() {
//         AlertMsg = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") != null ? SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") : "Alert";
////     });
        function ShowAlertMsg(key) {
         var objvar1 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_01") == null ? "Data saved Succesfully" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_01");
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
             //alert(userMsg);
             ValidationWindow(userMsg, objAlert);
                return false;
            }
            else {
             //                alert('Data saved Succesfully');
             ValidationWindow(objvar1, objAlert);
                return false;
            }
            return true;
        }

        function InsertNumber() {
         var objvar14 = SListForAppDisplay.Get("Admin_AddOrChangeNumberPatterns_aspx_14") == null ? "Number" : SListForAppDisplay.Get("Admin_AddOrChangeNumberPatterns_aspx_14");
            var newOption = new Option();
            var e = document.getElementById("lbCategories");
            var available = document.getElementById("lbPatterns");
            if (available.options.selectedIndex >= 0) {
                available.options[available.selectedIndex].selected = false;
                document.getElementById("txtOthers").style.display = 'none';
                document.getElementById("txtSeperator").style.display = 'none';
                document.getElementById("lblOthers").style.display = 'none';
                document.getElementById("lblSeperator").style.display = 'none';
                document.getElementById("ddlMonth").style.display = 'none';
                document.getElementById("ddlYear").style.display = 'none';
                document.getElementById("txtSeperator").value = '';
                document.getElementById("REVSeperator").style.display = 'none';
                document.getElementById("REVOthers").style.display = 'none';
                document.getElementById("REVHospitalName").style.display = 'none';
                //          document.getElementById("REVLocation").style.display='none';
                document.getElementById("txtOthers").value = '';
                //          document.getElementById("txtLocation").style.display='none';
                //          document.getElementById("txtLocation").value='';
                //          document.getElementById("lblLocation").style.display='none';
                document.getElementById("txtHospitalName").style.display = 'none';
                document.getElementById("txtHospitalName").value = '';
                document.getElementById("lblHospitalName").style.display = 'none';
            }
            var selected = document.getElementById("lbSelectedItems");
            selected.options.length = 0;
            if (e.options[e.options.selectedIndex].disabled == false) {
             newOption.text = objvar14;
                newOption.value = 'Number';
                selected.options[selected.length] = newOption;
            }
            FramePattern();
            if (document.getElementById('hdnCatID').value != '0') {
                e.options[document.getElementById('hdnCatID').value - 1].disabled = true;
                document.getElementById('btnAssignPattern').value = 'Assign Pattern';
            }
        }
        function CheckCategory() {
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");
            var cat = document.getElementById("lbCategories");
            var e = document.getElementById("lbPatterns");
            var len = e.length;
            if (cat.options.selectedIndex == -1) {

                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_2");
                if (userMsg != null) {
                 //alert(userMsg);
                 ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                 var objvar2 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_02") == null ? "Please select a category" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_02");

                 // alert('Please select a category');
                 ValidationWindow(objvar2, objAlert);
                    return false;
                }
                e.options.selectedIndex = -1;
                return false;
            }
            else {
                for (var i = 0; i < len; i++) {
                    if (e.options[i].selected == true) {
                        var s = e.options[i].text;
                    }
                }
                if (s == "HospitalName") {
                    document.getElementById("txtHospitalName").style.display = 'block';
                    document.getElementById("txtHospitalName").value = '';
                    document.getElementById("lblHospitalName").style.display = 'block';
                    document.getElementById("txtOthers").style.display = 'none';
                    document.getElementById("txtSeperator").style.display = 'none';
                    document.getElementById("lblOthers").style.display = 'none';
                    document.getElementById("lblSeperator").style.display = 'none';
                    document.getElementById("ddlMonth").style.display = 'none';
                    document.getElementById("ddlYear").style.display = 'none';
                    document.getElementById("txtSeperator").value = '';
                    document.getElementById("REVSeperator").style.display = 'none';
                    document.getElementById("REVOthers").style.display = 'none';
                    document.getElementById("txtOthers").value = '';
                }

                else if (s == "Others") {
                    document.getElementById("txtOthers").style.display = 'block';
                    document.getElementById("txtOthers").value = '';
                    document.getElementById("txtSeperator").style.display = 'none';
                    document.getElementById("txtSeperator").value = '';
                    document.getElementById("REVSeperator").style.display = 'none';
                    document.getElementById("REVHospitalName").style.display = 'none';

                    document.getElementById("ddlMonth").style.display = 'none';
                    document.getElementById("ddlYear").style.display = 'none';
                    document.getElementById("lblOthers").style.display = 'block';
                    document.getElementById("lblSeperator").style.display = 'none';

                    document.getElementById("txtHospitalName").style.display = 'none';
                    document.getElementById("lblHospitalName").style.display = 'none';
                }
                else if (s == "Seperator") {
                    document.getElementById("txtSeperator").style.display = 'block';
                    document.getElementById("txtSeperator").value = '';
                    document.getElementById("txtOthers").style.display = 'none';
                    document.getElementById("ddlMonth").style.display = 'none';
                    document.getElementById("ddlYear").style.display = 'none';
                    document.getElementById("lblSeperator").style.display = 'block';
                    document.getElementById("lblOthers").style.display = 'none';
                    document.getElementById("txtOthers").value = '';
                    document.getElementById("REVOthers").style.display = 'none';
                    document.getElementById("REVHospitalName").style.display = 'none';
                    //           document.getElementById("REVLocation").style.display='none';
                    //           document.getElementById("txtLocation").style.display='none';
                    //           document.getElementById("lblLocation").style.display='none';
                    document.getElementById("txtHospitalName").style.display = 'none';
                    document.getElementById("lblHospitalName").style.display = 'none';
                }
                else if (s == "Month") {
                    document.getElementById("ddlMonth").style.display = 'block';
                    document.getElementById("ddlYear").style.display = 'none';
                    document.getElementById("txtSeperator").style.display = 'none';
                    document.getElementById("txtOthers").style.display = 'none';
                    document.getElementById("lblSeperator").style.display = 'none';
                    document.getElementById("lblOthers").style.display = 'none';
                    document.getElementById("txtSeperator").value = '';
                    document.getElementById("REVSeperator").style.display = 'none';
                    document.getElementById("REVOthers").style.display = 'none';
                    document.getElementById("REVHospitalName").style.display = 'none';
                    //           document.getElementById("REVLocation").style.display='none';
                    document.getElementById("txtOthers").value = '';
                    //           document.getElementById("txtLocation").style.display='none';
                    //           document.getElementById("lblLocation").style.display='none';
                    document.getElementById("txtHospitalName").style.display = 'none';
                    document.getElementById("lblHospitalName").style.display = 'none';
                }
                else if (s == "Year") {
                    document.getElementById("ddlYear").style.display = 'block';
                    document.getElementById("ddlMonth").style.display = 'none';
                    document.getElementById("txtSeperator").style.display = 'none';
                    document.getElementById("txtOthers").style.display = 'none';
                    document.getElementById("lblSeperator").style.display = 'none';
                    document.getElementById("lblOthers").style.display = 'none';
                    document.getElementById("txtSeperator").value = '';
                    document.getElementById("REVSeperator").style.display = 'none';
                    document.getElementById("REVOthers").style.display = 'none';
                    document.getElementById("REVHospitalName").style.display = 'none';
                    //           document.getElementById("REVLocation").style.display='none';
                    document.getElementById("txtOthers").value = '';
                    //           document.getElementById("txtLocation").style.display='none';
                    //           document.getElementById("lblLocation").style.display='none';
                    document.getElementById("txtHospitalName").style.display = 'none';
                    document.getElementById("lblHospitalName").style.display = 'none';
                }
                else {
                    document.getElementById("txtOthers").style.display = 'none';
                    document.getElementById("txtSeperator").style.display = 'none';
                    document.getElementById("lblOthers").style.display = 'none';
                    document.getElementById("lblSeperator").style.display = 'none';
                    document.getElementById("ddlMonth").style.display = 'none';
                    document.getElementById("ddlYear").style.display = 'none';
                    document.getElementById("txtSeperator").value = '';
                    document.getElementById("REVSeperator").style.display = 'none';
                    document.getElementById("REVOthers").style.display = 'none';
                    document.getElementById("REVHospitalName").style.display = 'none';
                    //           document.getElementById("REVLocation").style.display='none';
                    document.getElementById("txtOthers").value = '';
                    //           document.getElementById("txtLocation").style.display='none';
                    //           document.getElementById("lblLocation").style.display='none';
                    document.getElementById("txtHospitalName").style.display = 'none';
                    document.getElementById("lblHospitalName").style.display = 'none';
                }
            }
        }
        function FramePattern() {        
            var e = document.getElementById("lbSelectedItems");
            var len = e.length;

            var text = '';
            var text1 = '';
            var textforreset = '';

            var error = 0;
            for (var i = 0; i < len; i++) {
                text = text + e.options[i].value;
                if (e.options[i].text == 'Date') {
                    text1 = text1 + '{DD}';

                    textforreset = textforreset + 'D';

                }
                else if (e.options[i].text == 'Month') {

                    //var Month = document.getElementById("ddlMonth");
                    //if (Month.options[Month.options.selectedIndex].text == "MM") {
                    if ( e.options[i].value == "MM") {                   
                        text1 = text1 + '{MM}';

                    }
                    //else if (Month.options[Month.options.selectedIndex].text == "MMM") {
                    else if (e.options[i].value == "MMM") {
                        text1 = text1 + '{MMM}';
                    }

                    textforreset = textforreset + 'M';
                }
                else if (e.options[i].text == 'Year') {

                   // var Year = document.getElementById("ddlYear");
                    //if (Year.options[Year.options.selectedIndex].text == "YY") {
                    if (e.options[i].value  == "YY") {
                        text1 = text1 + '{YY}';

                    }
                   // else if (Year.options[Year.options.selectedIndex].text == "YYYY") {
                    else if (e.options[i].value == "YYYY") {
                        text1 = text1 + '{YYYY}';

                    }
                    textforreset = textforreset + 'Y';

                }
                else {
                    text1 = text1 + "{" + e.options[i].value + "}";

                }
            }
            if (textforreset == 'DMY' || textforreset == 'DYM' || textforreset == 'YMD' || textforreset == 'YDM' || textforreset == 'MDY' || textforreset == 'MYD' || textforreset == 'MY' || textforreset == 'YM' || textforreset == 'Y') {
                document.getElementById("lnkReset").style.display = 'none';
                document.getElementById("pnlReset").style.display = 'Block';
                var Month = document.getElementById("ddlRMonth");
                if (textforreset == 'Y') {
                    document.getElementById('rdoMonth').disabled = true;
                    Month.options.remove(Month.length - 1);
                }
                else {
                    document.getElementById('rdoMonth').disabled = false;
                    if (Month.length < 13) {
                        var newOption = document.createElement("option");
                        newOption.text = 'EveryMonth';
                        newOption.value = '0';
                        Month.options.add(newOption);
                    }
                    Month.options[Month.length - 1].selected = true;
                }
            }
            else {
                document.getElementById("lnkReset").style.display = 'none';
                document.getElementById("pnlReset").style.display = 'none';
                document.getElementById("lblReset").style.display = 'none';
                document.getElementById("txtReset").style.display = 'none';
                document.getElementById("hdnReset").value = 'N';
            }
            document.getElementById("txtCompletePattern").value = text1;
            document.getElementById("hdnCompletePattern").value = text1;
            document.getElementById("hdnPattern").value = text;
            document.getElementById("lblCompletePattern").style.display = 'block';
            document.getElementById("txtCompletePattern").style.display = 'block';
            document.getElementById("btnAssignPattern").style.display = 'block';
            document.getElementById('lblResetValue').style.display = 'none';
            document.getElementById('lblResetValue1').style.display = 'none';

        }
        function AddItemValues() {
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");
         var objvar3 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_03") == null ? "Please select an Item to add" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_03");
         var objvar4 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_04") == null ? "Type Hospital Name in the textbox provided to add" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_04");
         var objvar5 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_05") == null ? "Enter valid Name" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_05");
         var objvar6 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_06") == null ? "Type a seperator in the textbox provided to add" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_06");
         var objvar7 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_07") == null ? "Enter valid Seperator" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_07");
         var objvar8 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_08") == null ? "Type your own pattern in the textbox provided to add" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_08");
         var objvar9 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_09") == null ? "Enter valid Pattern" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_09");

            var available = document.getElementById("lbPatterns");
            var selected = document.getElementById("lbSelectedItems");
            if (available.options.selectedIndex == -1) {

                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_3");
                if (userMsg != null) {
                 // alert(userMsg);
                 ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                 //alert('Please select an Item to add');
                    ValidationWindow(objvar3, objAlert);
                    return false;
                }
                return false;
            }
            if (available.options.selectedIndex >= 0) {
                var newOption = new Option();
                if (document.getElementById("txtHospitalName").style.display == 'block') {
                    if (document.getElementById("txtHospitalName").value.trim() == '') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_4");
                        if (userMsg != null) {
                         //alert(userMsg);
                         ValidationWindow(userMsg, objAlert);

                            return false;
                        }
                        else {
                         //alert("Type Hospital Name in the textbox provided to add");
                         ValidationWindow(objvar4, objAlert);
                            return false;
                        }
                    }
                    else if (document.getElementById("REVHospitalName").style.display != 'none') {

                        var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_5");
                        if (userMsg != null) {
                         //alert(userMsg);
                         ValidationWindow(userMsg, objAlert);

                            return false;
                        }
                        else {
                         //alert("Enter valid Name");
                         ValidationWindow(objvar5, objAlert);

                            return false;
                        }
                        document.getElementById("txtHospitalName").selected = true;
                    }
                    else {
                        newOption.text = available.options[available.options.selectedIndex].text;
                        newOption.value = document.getElementById("txtHospitalName").value;
                        selected.options[selected.length] = newOption;
                        FramePattern();
                    }
                }
                else if (available.options[available.options.selectedIndex].value == 'LOC' || available.options[available.options.selectedIndex].value == 'CCODE') {
                    newOption.text = available.options[available.options.selectedIndex].text;
                    newOption.value = available.options[available.options.selectedIndex].value;
                    selected.options[selected.length] = newOption;
                    FramePattern();
                }
                else if (document.getElementById("txtSeperator").style.display == 'block') {
                    if (document.getElementById("txtSeperator").value.trim() == '') {

                        var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_6");
                        if (userMsg != null) {
                         //alert(userMsg);
                         ValidationWindow(userMsg, objAlert);

                            return false;
                        }
                        else {
                         //alert("Type a seperator in the textbox provided to add");
                         ValidationWindow(objvar6, objAlert);
                            return false;
                        }
                    }
                    else if (document.getElementById("REVSeperator").style.display != 'none') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_7");
                        if (userMsg != null) {
                         //alert(userMsg);
                         ValidationWindow(userMsg, objAlert);
                            return false;
                        }
                        else {
                         //alert("Enter valid Seperator");
                         ValidationWindow(objvar7, objAlert);
                            return false;
                        }
                        document.getElementById("txtSeperator").selected = true;
                    }
                    else {
                        newOption.text = document.getElementById("txtSeperator").value;
                        newOption.value = document.getElementById("txtSeperator").value;
                        selected.options[selected.length] = newOption;                       
                        FramePattern();
                        
                    }
                }
                else if (document.getElementById("txtOthers").style.display == 'block') {
                    if (document.getElementById("txtOthers").value.trim() == '') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_8");
                        if (userMsg != null) {
                         //alert(userMsg);
                         ValidationWindow(userMsg, objAlert);
                            return false;
                        }
                        else {
                         //alert("Type your own pattern in the textbox provided to add");
                         ValidationWindow(objvar8, objAlert);
                            return false;
                        }
                    }
                    else if (document.getElementById("REVOthers").style.display != 'none') {
                        var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_9");
                        if (userMsg != null) {
                         //alert(userMsg);
                         ValidationWindow(userMsg, objAlert);
                            return false;
                        }
                        else {
                         //alert("Enter valid Pattern");
                         ValidationWindow(objvar9, objAlert);
                            return false;
                        }
                        document.getElementById("txtOthers").selected = true;
                    }
                    else {
                        newOption.text = document.getElementById("txtOthers").value;
                        newOption.value = document.getElementById("txtOthers").value;
                        selected.options[selected.length] = newOption;                       
                        FramePattern();
                    }
                }
                else if (document.getElementById("ddlMonth").style.display == 'block') {
                    var Month = document.getElementById("ddlMonth");
                    if (Month.options[Month.options.selectedIndex].text == "MM") {
                        newOption.text = available.options[available.options.selectedIndex].text;
                        //newOption.value = available.options[available.options.selectedIndex].text;
                        newOption.value=Month.options[Month.options.selectedIndex].text;
                    }
                    else if (Month.options[Month.options.selectedIndex].text == "MMM") {
                        newOption.text = available.options[available.options.selectedIndex].text;
                        //newOption.value = available.options[available.options.selectedIndex].text;
                         newOption.value=Month.options[Month.options.selectedIndex].text;
                    }
                    selected.options[selected.length] = newOption;                  
                    FramePattern();

                }
                else if (document.getElementById("ddlYear").style.display == 'block') {
                    var Year = document.getElementById("ddlYear");
                    if (Year.options[Year.options.selectedIndex].text == "YY") {
                        newOption.text = available.options[available.options.selectedIndex].text;
                        //newOption.value = available.options[available.options.selectedIndex].text;
                         newOption.value=Year.options[Year.options.selectedIndex].text;
                    }
                    if (Year.options[Year.options.selectedIndex].text == "YYYY") {
                        newOption.text = available.options[available.options.selectedIndex].text;
                        //newOption.value = available.options[available.options.selectedIndex].text;
                        newOption.value=Year.options[Year.options.selectedIndex].text;
                    }
                    selected.options[selected.length] = newOption;                   
                    FramePattern();

                }
                else {
                    newOption.text = available.options[available.options.selectedIndex].text;
                    newOption.value = available.options[available.options.selectedIndex].value;
                    selected.options[selected.length] = newOption;                  
                    FramePattern();
                }

                //available.remove(available.options.selectedIndex);
            }
            return false;
        }

        function RemoveItemValues() {
         var objvar10 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_10") == null ? "Please select an Item to remove" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_10");
         var objvar11 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_11") == null ? "Number cannot be removed" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_11");

         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");

            var selected = document.getElementById("lbSelectedItems");
            var available = document.getElementById("lbPatterns");
            if (selected.options.selectedIndex == -1) {
                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_10");
                if (userMsg != null) {
                 // alert(userMsg);
                 ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {
                 //alert('Please select an Item to remove');
                 ValidationWindow(objvar10, objAlert);
                    return false;
                }
                return false;
            }
            if (selected.options.selectedIndex >= 0) {
                if (selected.options[selected.options.selectedIndex].text == "Number") {
                    var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_11");
                    if (userMsg != null) {
                     //alert(userMsg);
                     ValidationWindow(userMsg, objAlert);
                        return false;
                    }
                    else {
                     //alert('Number cannot be removed');
                     ValidationWindow(objvar11, objAlert);
                        return false;
                    }
                }
                else
                    selected.remove(selected.options.selectedIndex);
            }
            FramePattern();
            return false;
        }
        function MoveUp() {
         var objvar12 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_12") == null ? "Please select an Item to swap" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_12");
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");

            var e = document.getElementById("lbSelectedItems");
            var len = e.length;
            var newOption = new Option();
            var newOption1 = new Option();
            if (e.options.selectedIndex == -1) {
                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_12");
                if (userMsg != null) {
                 //alert(userMsg);
                 ValidationWindow(userMsg, objAlert);

                    return false;
                }
                else {
                 //alert('Please select an Item to swap');
                 ValidationWindow(objvar12, objAlert);
                    return false;
                }
                return false;
            }
            // if (e.options.selectedIndex >= 0) {
            if (e.options.selectedIndex > 0) {
                newOption.text = e.options[e.options.selectedIndex].text;
                newOption.value = e.options[e.options.selectedIndex].value;
                newOption1.text = e.options[e.options.selectedIndex - 1].text;
                newOption1.value = e.options[e.options.selectedIndex - 1].value;
                e.options[e.selectedIndex].text = newOption1.text;
                e.options[e.selectedIndex].value = newOption1.value;
                e.options[e.selectedIndex - 1].text = newOption.text;
                e.options[e.selectedIndex - 1].value = newOption.value;
                e.options[e.selectedIndex - 1].selected = true;
                 FramePattern();
                return false;
            }
           
        }
        function MoveDown() {
         var objvar12 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_12") == null ? "Please select an Item to swap" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_12");
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");

            var e = document.getElementById("lbSelectedItems");
            var len = e.length;
            var newOption = new Option();
            var newOption1 = new Option();
            if (e.options.selectedIndex == -1) {
                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_13");
                if (userMsg != null) {
                 //alert(userMsg);
                 ValidationWindow(userMsg, objAlert);
                    return false;
                }
                else {

                 //alert('Please select an Item to swap');
                 ValidationWindow(objvar12, objAlert);
                    return false;
                }
                return false;
            }
            //  if (e.options.selectedIndex >= 0) {
            if (e.options.selectedIndex < (e.length-1)) {
                newOption.text = e.options[e.options.selectedIndex].text;
                newOption.value = e.options[e.options.selectedIndex].value;
                newOption1.text = e.options[e.options.selectedIndex + 1].text;
                newOption1.value = e.options[e.options.selectedIndex + 1].value;
                e.options[e.selectedIndex].text = newOption1.text;
                e.options[e.selectedIndex].value = newOption1.value;
                e.options[e.selectedIndex + 1].text = newOption.text;
                e.options[e.selectedIndex + 1].value = newOption.value;
                e.options[e.selectedIndex + 1].selected = true;
                FramePattern();
              return false;
              }
           
        }
        function CheckToAssign() {
         var objvar13 = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_13") == null ? "Select a Category" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_13");
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");
         var objvar17 = SListForAppDisplay.Get("Admin_OrganisationLocation_aspx_05") == null ? "Your selected pattern is" : SListForAppDisplay.Get("Admin_OrganisationLocation_aspx_05");
         var objvar18 = SListForAppDisplay.Get("Admin_OrganisationLocation_aspx_06") == null ? "Do you want to continue ?" : SListForAppDisplay.Get("Admin_OrganisationLocation_aspx_06");
         var objvar19 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_17") == null ? "Please enter Reset value" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_17");

            var e = document.getElementById("lbCategories");
            var ResetOption;
            var ResetBy;
            var ResetValue;
            var Month = document.getElementById("ddlRMonth");
            if (e.options.selectedIndex == -1) {
                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_14");
                if (userMsg != null) {
                 //alert(userMsg);
                 ValidationWindow(userMsg, objAlert);

                    return false;
                }
                else {

                 //alert('Select a Category');
                 ValidationWindow(objvar13, objAlert);

                    return false;
                }
                return false;
            }

            else {
                var result = ConfirmWindow(objvar17 + " " + document.getElementById("txtCompletePattern").value + ", " + objvar18);
                if (result == true) {
                    var e1 = document.getElementById("lbPatterns");
                    var selected = document.getElementById("lbSelectedItems");
                    if (document.getElementById('btnAssignPattern').value == 'Assign Pattern') {
                        var rows = '';
                        var rowcount = document.getElementById('tblSelectedPatterns').rows.length;
                        var row = document.getElementById('tblSelectedPatterns').insertRow(rowcount);
                        row.id = e.options[e.options.selectedIndex].value;
                        e.options[e.options.selectedIndex].disabled = true;
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        cell1.innerHTML = e.options[e.options.selectedIndex].text;
                        cell1.width = 200;
                        cell2.innerHTML = document.getElementById("txtCompletePattern").value;
                        cell2.width = 500;
                        cell3.width = 100;
                        cell4.width = 150;
                        if (document.getElementById('lblResetValue').style.display == 'block' && document.getElementById('pnlReset').style.display == 'block') {
                            if (document.getElementById('txtResetValue') == '') {
                                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_15");
                                if (userMsg != null) {
                                 // alert(userMsg);
                                 ValidationWindow(userMsg, objAlert);

                                    return false;
                                }
                                else {

                                 // alert('Please enter Reset value');
                                 ValidationWindow(objvar19, objAlert);

                                    return false;
                                }
                                return false;
                            }
                            else {
                                cell4.innerHTML = "RESET ON";
                                document.getElementById("hdnReset").value = 'Y';
                                ResetValue = document.getElementById('txtResetValue').value;
                                if (document.getElementById('rdoMonth').checked == true) {
                                    ResetOption = 'Month';
                                    ResetBy = Month.options[Month.options.selectedIndex].value;
                                }
                                else if (document.getElementById('rdoYear').checked == true) {
                                    ResetOption = 'Year';
                                    ResetBy = Month.options[Month.options.selectedIndex].value;
                                }
                            }
                        }
                        else {
                            cell4.innerHTML = "RESET OFF";
                            document.getElementById("hdnReset").value = 'N';
                        }
                        rows = e.options[e.options.selectedIndex].value + '~' + e.options[e.options.selectedIndex].text + '~' + document.getElementById("hdnCompletePattern").value + '~' + document.getElementById("hdnReset").value + '~' + ResetOption + '~' + ResetBy + '~' + ResetValue + '~' + document.getElementById("hdnPattern").value;
                        document.getElementById('hdnRecords').value = document.getElementById('hdnRecords').value + '^' + rows;
                        cell3.innerHTML = "<input name='Edit' value='" + "<%=Resources.ClientSideDisplayTexts.Admin_AddOrChangeNumberPatterns_Edit%>" + "' type='linkbutton' onclick='EditRow(" + rowcount + ");' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"
                        var len = selected.length;
                        var r = '';
                        for (var i = 0; i < len; i++) {
                            r = r + '^' + selected.options[i].text + '~' + selected.options[i].value;
                        }
                        row.title = r;
                        document.getElementById('tblSelectedPatterns').style.display = 'table';
                        document.getElementById('btnSave').style.display = 'inline';
                        document.getElementById('lnkReset').style.display = 'none';
                        document.getElementById("pnlReset").style.display = 'none';
                        document.getElementById('lblReset').style.display = 'none';
                        document.getElementById('txtReset').style.display = 'none';
                        document.getElementById('hdnReset').value = 'N';
                    }
                    else if (document.getElementById('btnAssignPattern').value == 'Update Pattern') {
                        var rowid = document.getElementById('hdnRowID').value;
                        document.getElementById('tblSelectedPatterns').rows[rowid].id = e.options[e.options.selectedIndex].value;
                        e.options[e.options.selectedIndex].disabled = true;
                        document.getElementById('tblSelectedPatterns').rows[rowid].cells[0].innerHTML = e.options[e.options.selectedIndex].text;
                        document.getElementById('tblSelectedPatterns').rows[rowid].cells[1].innerHTML = document.getElementById("txtCompletePattern").value;
                        if (document.getElementById('lblResetValue').style.display == 'block' && document.getElementById('pnlReset').style.display == 'block') {
                            if (document.getElementById('txtResetValue') == '') {
                                var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_15");
                                if (userMsg != null) {
                                 //alert(userMsg);
                                 ValidationWindow(userMsg, objAlert);
                                    return false;
                                }
                                else {
                                 //alert('Please enter Reset value');
                                 ValidationWindow(objvar19, objAlert);
                                    return false;
                                }
                                return false;
                            }
                            else {
                                document.getElementById('tblSelectedPatterns').rows[rowid].cells[3].innerHTML.innerHTML = "RESET ON";
                                document.getElementById("hdnReset").value = 'Y';
                                ResetValue = document.getElementById('txtResetValue').value;
                                if (document.getElementById('rdoMonth').checked == true) {
                                    ResetOption = 'Month';
                                    ResetBy = Month.options[Month.options.selectedIndex].value;
                                }
                                else if (document.getElementById('rdoYear').checked == true) {
                                    ResetOption = 'Year';
                                    ResetBy = Month.options[Month.options.selectedIndex].value;
                                }
                            }
                        }
                        else {
                            document.getElementById('tblSelectedPatterns').rows[rowid].cells[1].innerHTML.innerHTML = "RESET OFF";
                            document.getElementById("hdnReset").value = 'N';
                        }
                        rows = e.options[e.options.selectedIndex].value + '~' + e.options[e.options.selectedIndex].text + '~' + document.getElementById("hdnCompletePattern").value + '~' + document.getElementById("hdnReset").value + '~' + ResetOption + '~' + ResetBy + '~' + ResetValue + '~' + document.getElementById("hdnPattern").value;
                        document.getElementById('hdnRecords').value = document.getElementById('hdnRecords').value + '^' + rows;
                        //document.getElementById('tblSelectedPatterns').rows[rowid].cells[2].innerHTML="<input name='Edit' value='Edit' type='linkbutton' onclick='EditRow("+rowcount+");' style='background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer'  />"
                        var len = selected.length;
                        var r = '';
                        for (var i = 0; i < len; i++) {
                            r = r + '^' + selected.options[i].text + '~' + selected.options[i].value;
                        }
                        document.getElementById('tblSelectedPatterns').rows[rowid].title = r;
                        if (document.getElementById('hdnReset').value == 'Y')
                            document.getElementById('tblSelectedPatterns').rows[rowid].cells[3].innerHTML = "RESET ON";
                        else
                            document.getElementById('tblSelectedPatterns').rows[rowid].cells[3].innerHTML = "RESET OFF";
                        document.getElementById('btnAssignPattern').value = "Assign Pattern";
                    }

                    e.options[e.options.selectedIndex].selected = false;
                    if (e1.options.selectedIndex >= 0)
                        e1.options[e1.options.selectedIndex].selected = false;
                    document.getElementById("txtCompletePattern").value = '';
                    selected.options.length = 0;
                    if (document.getElementById('txtHospitalName').style.display == 'block') {
                        document.getElementById('txtHospitalName').style.display = 'none';
                        document.getElementById('lblHospitalName').style.display = 'none';
                    }

                    if (document.getElementById('txtSeperator').style.display == 'block') {
                        document.getElementById('txtSeperator').style.display = 'none';
                        document.getElementById('lblSeperator').style.display = 'none';
                    }
                    if (document.getElementById('txtOthers').style.display == 'block') {
                        document.getElementById('txtOthers').style.display = 'none';
                        document.getElementById('lblOthers').style.display = 'none';
                    }
                    if (document.getElementById('ddlMonth').style.display == 'block') {
                        document.getElementById('ddlMonth').style.display = 'none';
                    }
                    if (document.getElementById('ddlYear').style.display == 'block') {
                        document.getElementById('ddlYear').style.display = 'none';
                    }
                    document.getElementById('lnkReset').style.display = 'none';
                    document.getElementById("pnlReset").style.display = 'none';
                    document.getElementById('lblReset').style.display = 'none';
                    document.getElementById('txtReset').style.display = 'none';
                    document.getElementById('hdnReset').value = 'N';
                    return false;
                }

                else {
                    return false;
                }
            }
        }
        function EditRow(id) {
            var e = document.getElementById("lbCategories");
            var selected = document.getElementById("lbSelectedItems");
            selected.options.length = 0;
            var len = e.length;
            var selectedlen = selected.length;
            var cat = document.getElementById('tblSelectedPatterns').rows[id].id;
            document.getElementById('hdnCatID').value = document.getElementById('tblSelectedPatterns').rows[id].id;
            var row = document.getElementById('tblSelectedPatterns').rows[id].title;
            var pat = document.getElementById('tblSelectedPatterns').rows[id].cells[1].innerHTML;
            document.getElementById("txtCompletePattern").value = pat;
            for (var i = 0; i < len; i++) {
                if (e.options[i].value == cat) {
                    e.options[i].selected = true;
                    e.options[i].disabled = false;
                }
            }
            var str = row.split('^');
            var l = str.length;

            for (var j = 0; j < l; j++) {
                if (str[j] != '') {
                    var str1 = str[j].split('~');
                    var newOption = new Option();
                    newOption.text = str1[0];
                    newOption.value = str1[1];
                    selected.options[selectedlen] = newOption;
                }

                selectedlen = selected.length;
            }
            document.getElementById('btnAssignPattern').value = "Update Pattern";
            document.getElementById('hdnRowID').value = id;
            FramePattern();
        }
        function SetResetValue() {
         var objvar20 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_18") == null ? "Reset is set ON for this Category" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_18");
         var objAlert = SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeNumberPatterns_aspx_Alert");
            document.getElementById('hdnReset').value = 'Y';
            var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_16");
            if (userMsg != null) {
             //alert(userMsg);
             ValidationWindow(userMsg, objAlert);

                return false;
            }
            else {
             //alert("Reset is set ON for this Category");
             ValidationWindow(objvar20, objAlert);

                return false;
            }
            document.getElementById('lblReset').style.display = 'Block';
            document.getElementById('txtReset').style.display = 'Block';
        }
        function CheckToSaveData() {
         var objvar21 = SListForAppMsg.Get("Admin_OrganisationLocation_aspx_19") == null ? "These Patterns will be applicable for newly generating numbers.Are you sure you want to save this data?" : SListForAppMsg.Get("Admin_OrganisationLocation_aspx_19");

            var result;
            var userMsg = SListForApplicationMessages.Get("Admin\\AddOrChangeNumberPatterns.aspx_17");
            if (userMsg != null) {
                result = confirm(userMsg);
            }
            else {
             //                result = confirm('These Patterns will be applicable for newly generating numbers.Are you sure you want to save this data?');
             result = confirm(objvar21);
            }

            //  var result = confirm("These Patterns will be applicable for newly generating numbers.Are you sure you want to save this data?");
            if (result == true) {
                return true;
            }
            else {
                return false;
            }
        }
        function ShowDropDown() {
            if (document.getElementById('rdoMonth').checked == true) {
                document.getElementById('ddlRMonth').style.display = 'Block';
                document.getElementById('ddlRMonth').selectedIndex = 0;
                //document.getElementById('ddlRYear').style.display='None';
            }
            else if (document.getElementById('rdoYear').checked == true) {
                //document.getElementById('ddlRYear').style.display='Block';
                //document.getElementById('ddlRYear').selectedIndex=0;
                document.getElementById('ddlRMonth').style.display = 'Block';
            }
        }
        function AssignReset() {
            document.getElementById('lblResetValue').style.display = 'Block';
            document.getElementById('lblResetValue1').style.display = 'none';
            return false;
        }
        function AssignReset1() {
            document.getElementById('lblResetValue1').style.display = 'Block';
            document.getElementById('lblResetValue').style.display = 'none';
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table class="searchPanel">
                                    <tr>
                                        <td colspan="7">
                                            <asp:LinkButton ID="lnkPatterns" Text="Click here to see assigned patterns" Font-Underline="True"
                                                runat="server" ForeColor="Red" meta:resourcekey="lnkPatternsResource1"></asp:LinkButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCategories" runat="server" Text="Select a Category" Font-Size="Small"
                                                Font-Bold="True" meta:resourcekey="lblCategoriesResource1" />
                                        </td>
                                        <td class="style1">
                                        </td>
                                        <td>
                                            <asp:Label ID="lblPatterns" runat="server" Text="Select Pattern" Font-Size="Small"
                                                Font-Bold="True" meta:resourcekey="lblPatternsResource1" />
                                        </td>
                                        <td class="style1">
                                        </td>
                                        <td class="style1">
                                        </td>
                                        <td>
                                            <asp:Label ID="lblSelectedItems" runat="server" Text="Selected Items" Font-Size="Small"
                                                Font-Bold="True" meta:resourcekey="lblSelectedItemsResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lbCategories" runat="server" Height="200px" meta:resourcekey="lbCategoriesResource1">
                                            </asp:ListBox>
                                        </td>
                                        <td class="style1">
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lbPatterns" runat="server" Height="200px" meta:resourcekey="lbPatternsResource1">
                                            </asp:ListBox>
                                        </td>
                                        <td class="v-top">
                                            <asp:TextBox ID="txtHospitalName" runat="server" MaxLength="5" Style="display: none"
                                                CssClass="Txtboxsmall" meta:resourcekey="txtHospitalNameResource1"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="REVHospitalName" runat="server" Display="Dynamic"
                                                ControlToValidate="txtHospitalName" ErrorMessage="HospitalName must contain only letters"
                                                ValidationExpression="^[a-zA-Z]{1,20}$" meta:resourcekey="REVHospitalNameResource1" />
                                            <asp:Label ID="lblHospitalName" runat="server" Text="Type Hospital Name" ForeColor="Red"
                                                Style="display: none" meta:resourcekey="lblHospitalNameResource1"></asp:Label>
                                            <%--<asp:TextBox ID="txtLocation" runat="server" MaxLength="5" Style="display: none"
                                                meta:resourcekey="txtLocationResource1"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="REVLocation" runat="server" Display="Dynamic"
                                                ControlToValidate="txtLocation" ErrorMessage="Location must contain only letters"
                                                ValidationExpression="^[a-zA-Z]{1,20}$" meta:resourcekey="REVLocationResource1" />
                                            <asp:Label ID="lblLocation" runat="server" Text="Type Location" ForeColor="Red" Style="display: none"
                                                meta:resourcekey="lblLocationResource1"></asp:Label>--%>
                                            <asp:DropDownList ID="ddlMonth" runat="server" Width="70%" Style="display: none"
                                                CssClass="ddl" ><%--
                                                <asp:ListItem Selected="True" meta:resourcekey="ListItemResource1" Text="MM"></asp:ListItem>
                                                <asp:ListItem meta:resourcekey="ListItemResource2" Text="MMM"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddlYear" runat="server" Width="70%" CssClass="ddl" Style="display: none">
                                               <%-- <asp:ListItem Selected="True" meta:resourcekey="ListItemResource3" Text="YY"></asp:ListItem>
                                                <asp:ListItem meta:resourcekey="ListItemResource4" Text="YYYY"></asp:ListItem>--%>
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtSeperator" runat="server" MaxLength="5" Style="display: none"
                                                CssClass="Txtboxsmall" meta:resourcekey="txtSeperatorResource1"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="REVSeperator" runat="server" Display="Dynamic"
                                                ControlToValidate="txtSeperator" ErrorMessage="Separator must contain one of /-_."
                                                ValidationExpression="[/._.-]+" meta:resourcekey="REVSeperatorResource1" />
                                            <asp:Label ID="lblSeperator" runat="server" Text="Type Seperators(- , _ , /)" ForeColor="Red"
                                                Style="display: none" meta:resourcekey="lblSeperatorResource1"></asp:Label>
                                            <asp:TextBox ID="txtOthers" runat="server" Style="display: none" MaxLength="20" CssClass="Txtboxsmall"
                                                meta:resourcekey="txtOthersResource1"></asp:TextBox>
                                            <asp:RegularExpressionValidator ID="REVOthers" runat="server" Display="Dynamic" ControlToValidate="txtOthers"
                                                ErrorMessage="Pattern must contain only letters" ValidationExpression="^[a-zA-Z]{1,20}$"
                                                meta:resourcekey="REVOthersResource1" />
                                            <asp:Label ID="lblOthers" runat="server" Text="Type a pattern" ForeColor="Red" Style="display: none"
                                                meta:resourcekey="lblOthersResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnAdd" runat="server" CssClass="btn" Text=">>ADD>>" Width="100px"
                                                OnClientClick="JavaScript:AddItemValues();return false" meta:resourcekey="btnAddResource1" />
                                            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<br />
                                            <asp:Button ID="btnRemove" runat="server" CssClass="btn" Text="<<REMOVE<<" Width="100px"
                                                OnClientClick="JavaScript:RemoveItemValues();return false" meta:resourcekey="btnRemoveResource1" />
                                        </td>
                                        <td>
                                            <asp:ListBox ID="lbSelectedItems" runat="server" Height="200px" Width="150px" meta:resourcekey="lbSelectedItemsResource1">
                                            </asp:ListBox>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnUp" runat="server" CssClass="btn" Text="UP" Width="100px" OnClientClick="JavaScript:MoveUp();return false"
                                                meta:resourcekey="btnUpResource1" />
                                            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<br />
                                            <asp:Button ID="btnDown" runat="server" CssClass="btn" Text="DOWN" Width="100px"
                                                OnClientClick="JavaScript:MoveDown();return false" meta:resourcekey="btnDownResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblCompletePattern" runat="server" Text="Your selected pattern" Font-Bold="True"
                                                Style="display: none" meta:resourcekey="lblCompletePatternResource1"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCompletePattern" runat="server" TextMode="MultiLine" CssClass="Txtboxlarge"
                                                Style="display: none; height: 50px;" ReadOnly="True" meta:resourcekey="txtCompletePatternResource1"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td colspan="2">
                                            <asp:LinkButton ID="lnkReset" runat="server" Text="Click here to set RESET NUMBER option"
                                                OnClientClick="Javascript:SetResetValue(); return false" Style="background-color: Transparent;
                                                color: Red; border-style: none; text-decoration: underline; cursor: pointer;
                                                display: none" meta:resourcekey="lnkResetResource1"></asp:LinkButton>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblReset" runat="server" Text="Your Reset Number starts from" Style="display: none"
                                                meta:resourcekey="lblResetResource1"></asp:Label>
                                            <asp:TextBox ID="txtReset" runat="server" Text="1" Style="display: none" CssClass="Txtboxsmall"
                                                meta:resourcekey="txtResetResource1"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan='4'>
                                            <asp:Panel ID="pnlReset" runat="server" CssClass="defaultfontcolor" meta:resourcekey="pnlResetResource1"
                                                Style="display: none;">
                                                <table class="w-100p defaultfontcolor">
                                                    <tr>
                                                        <td class="colorforcontent w-100p h-23 a-left">
                                                            <div id="ACX2plus1" style="display: block;">
                                                                &nbsp;<img src="../Images/showBids.gif" class="w-15 h-15 v-top pointer" alt="Show"onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);" />
                                                                <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',1);">
                                                                    &nbsp;<asp:Label ID="Rs_FilterResult1" runat="server" Text="RESET Block" meta:resourcekey="Rs_FilterResult1Resource2"></asp:Label></span>
                                                            </div>
                                                            <div id="ACX2minus1" style="display: none;">
                                                                &nbsp;<img src="../Images/hideBids.gif" alt="hide" class="w-15 h-15 v-top pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);" />
                                                                <span class="dataheader1txt pointer" onclick="showResponses('ACX2plus1','ACX2minus1','ACX2responses1',0);">
                                                                    &nbsp<asp:Label ID="Rs_FilterResult2" runat="server" Text="RESET Block" meta:resourcekey="Rs_FilterResult2Resource2"></asp:Label></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr class="tablerow" id="ACX2responses1" style="display: none;">
                                                        <td colspan="7">
                                                            <div class="filterdataheader2">
                                                                <table class="defaultfontcolor w-100p margin3">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ResetCategory" runat="server" Text="RESET based on :: " meta:resourcekey="Rs_ResetCategoryResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdoMonth" Text="Month" GroupName="Reset" runat="server" onclick="javascript:ShowDropDown()"
                                                                                meta:resourcekey="rdoMonthResource1" />
                                                                            <asp:RadioButton ID="rdoYear" Text="Year" GroupName="Reset" Checked="True" runat="server"
                                                                                onclick="javascript:ShowDropDown()" meta:resourcekey="rdoYearResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:DropDownList ID="ddlRMonth" runat="server" CssClass="ddl" meta:resourcekey="ddlRMonthResource1">
                                                                           <%--     <asp:ListItem Value="1" meta:resourcekey="ListItemResource6" Text="January"></asp:ListItem>
                                                                                <asp:ListItem Value="2" meta:resourcekey="ListItemResource7" Text="February"></asp:ListItem>
                                                                                <asp:ListItem Value="3" meta:resourcekey="ListItemResource8" Text="March"></asp:ListItem>
                                                                                <asp:ListItem Value="4" meta:resourcekey="ListItemResource9" Text="April"></asp:ListItem>
                                                                                <asp:ListItem Value="5" meta:resourcekey="ListItemResource10" Text="May"></asp:ListItem>
                                                                                <asp:ListItem Value="6" meta:resourcekey="ListItemResource11" Text="June"></asp:ListItem>
                                                                                <asp:ListItem Value="7" meta:resourcekey="ListItemResource12" Text="July"></asp:ListItem>
                                                                                <asp:ListItem Value="8" meta:resourcekey="ListItemResource13" Text="August"></asp:ListItem>
                                                                                <asp:ListItem Value="9" meta:resourcekey="ListItemResource14" Text="September"></asp:ListItem>
                                                                                <asp:ListItem Value="10" meta:resourcekey="ListItemResource15" Text="October"></asp:ListItem>
                                                                                <asp:ListItem Value="11" meta:resourcekey="ListItemResource16" Text="November"></asp:ListItem>
                                                                                <asp:ListItem Value="12" meta:resourcekey="ListItemResource17" Text="December"></asp:ListItem>
                                                                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource5" Text="EveryMonth"></asp:ListItem>--%>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Rs_ResetValue" runat="server" Text="RESET Number :: " meta:resourcekey="Rs_ResetValueResource1"></asp:Label>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtResetValue" runat="server" Text="1" CssClass="Txtboxsmall" meta:resourcekey="txtResetValueResource1"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td class="a-center">
                                                                            <asp:Button ID="btnSetReset" Text="Apply Reset" CssClass="btn" OnClientClick="Javascript:AssignReset();return false"
                                                                                Width="80px" Height="18px" runat="server" meta:resourcekey="btnSetResetResource1" />
                                                                        </td>
                                                                        <td class="a-center">
                                                                            <asp:Button ID="btnOffReset" Text="Cancel Reset" CssClass="btn" OnClientClick="Javascript:AssignReset1();return false"
                                                                                Width="80px" Height="18px" runat="server" meta:resourcekey="btnOffResetResource1" />
                                                                        </td>
                                                                        <td>
                                                                            <asp:Label ID="lblResetValue" runat="server" Text="RESET ON" Style="display: none"
                                                                                meta:resourcekey="lblResetValueResource"></asp:Label>
                                                                            <asp:Label ID="lblResetValue1" runat="server" Text="RESET OFF" Style="display: none"
                                                                                meta:resourcekey="lblResetValue1Resource1"></asp:Label>
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
                                    <tr>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style3">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' class="style4 a-center">
                                        </td>
                                        <td class="style4" colspan="2">
                                            <asp:Button ID="btnAssignPattern" runat="server" CssClass="btn" Text="Assign Pattern"
                                                OnClientClick="Javascript:CheckToAssign();return false" Width="110px" Style="display: none;
                                                text-align: center" meta:resourcekey="btnAssignPatternResource1" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td colspan='8'>
                                            <table id="tblSelectedPatterns" runat="server" class="dataheaderInvCtrl w-100p a-left bg-row"
                                               style="display: none; padding-left: 60;">
                                                <tr id="Tr1" runat="server">
                                                    <th id="Th1" class="font16 a-left" style="text-decoration: underline;" runat="server">
                                                        <asp:Label ID="lblCategory" runat="server" Text="Category" meta:resourcekey="lblCategoryResource1"></asp:Label>
                                                    </th>
                                                    <th id="Th2" class="font16 a-left" style="text-decoration: underline;" runat="server">
                                                        <asp:Label ID="lblPattern" runat="server" Text="Pattern" meta:resourcekey="lblPatternResource1"></asp:Label>
                                                    </th>
                                                    <th>&nbsp;</th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style6">
                                        </td>
                                        <td colspan='6' class="a-center">
                                            <asp:Button ID="btnSave" runat="server" CssClass="btn" Text="SAVE" Style="display: none"
                                                OnClientClick="Javascript:return CheckToSaveData();" OnClick="btnSave_Click"
                                                meta:resourcekey="btnSaveResource1" />
                                        </td>
                                    </tr>
                                </table>
                                </div> </td> </tr> </table>
                                <asp:Panel ID="pnlPatterns" Width="500px" Height="400px" runat="server" CssClass="modalPopup dataheaderPopup"
                                    Style="display: none" meta:resourcekey="pnlPatternsResource1">
                                    <table class="a-center w-100p">
                                        <tr>
                                            <td>
                                            <div style="width:95%;height:320px;overflow:auto;">
                                                <asp:GridView ID="grdPatterns" runat="server" AutoGenerateColumns="False" Width="100%"
                                                    BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                    CellPadding="3" Font-Bold="False" Font-Names="Verdana" Font-Overline="False"
                                                    Font-Size="9pt" Font-Strikeout="False" Font-Underline="False" meta:resourcekey="grdPatternsResource1">
                                                    <RowStyle ForeColor="#000066" />
                                                    <Columns>
                                                        <asp:BoundField DataField="CategoryName" HeaderText="Category" 
                                                            meta:resourceKey="BoundFieldResource1" />
                                                        <asp:BoundField DataField="PatternValue" HeaderText="Pattern" 
                                                            meta:resourceKey="BoundFieldResource2" />
                                                    </Columns>
                                                    <RowStyle ForeColor="#000066" />
                                                </asp:GridView>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="h-20">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center">
                                                <asp:Button ID="btnOk" runat="server" Text="OK" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                    onmouseout="this.className='btn'" Width="70px" meta:resourcekey="btnOkResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <ajc:ModalPopupExtender ID="mpePatternSelection" runat="server" TargetControlID="lnkPatterns"
                                    PopupControlID="pnlPatterns" BackgroundCssClass="modalBackground" CancelControlID="btnOk"
                                    DynamicServicePath="" Enabled="True" />
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnAdd" EventName="Click" />
                                <asp:AsyncPostBackTrigger ControlID="btnRemove" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnRecords" runat="server" />
    <asp:HiddenField ID="hdnCatID" Value="0" runat="server" />
    <asp:HiddenField ID="hdnRowID" Value="-1" runat="server" />
    <asp:HiddenField ID="hdnCompletePattern" runat="server" />
    <asp:HiddenField ID="hdnReset" Value="N" runat="server" />
    <asp:HiddenField ID="hdnPattern" Value="N" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />  
    </form>
</body>
</html>