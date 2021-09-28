<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddOrChangeBarcodePatterns.aspx.cs"
    Inherits="Admin_AddOrChangeBarcodePatterns" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/PhysicianHeader.ascx" TagName="DocHeader" TagPrefix="uc7" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Add/Change Barcode Pattern</title>
    <link rel="Stylesheet" type="text/css" />

    <script language="javascript" type="text/javascript">
        /********************Added By Arivalagan.kk**********************/
        function ResetPage() {
            window.location.assign("../Admin/AddOrChangeBarcodePatterns.aspx");
        }
        /*****************End***Added By Arivalagan.kk**********************/

        function ChildGridList() {
            while (count = document.getElementById('tblSelectedPatterns').rows.length) {
                for (var j = 0; j < document.getElementById('tblSelectedPatterns').rows.length; j++) {
                    document.getElementById('tblSelectedPatterns').deleteRow(j);
                }
            }

            var pParentProIDs = document.getElementById('hdnRecords').value.split("^");

            var Headrow = document.getElementById('tblSelectedPatterns').insertRow(0);
            Headrow.id = "HeadID";
            Headrow.style.fontWeight = "bold";
            Headrow.className = "dataheader1"

            var cell1 = Headrow.insertCell(0);
            var cell2 = Headrow.insertCell(1);
            var cell3 = Headrow.insertCell(2);
            var cell4 = Headrow.insertCell(3);

            var objcategoryname = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_001") == null ? "Category Name" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_001");
            var objmainatt = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_002") == null ? "Main Attribute" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_002");
            var objpattern = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_003") == null ? "Pattern" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_003");
            var objaction = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_004") == null ? "Action" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_004");
                
//            cell1.innerHTML = "Category Name";
//            cell2.innerHTML = "Main Attribute";
//            cell3.innerHTML = "Pattern";
//            cell4.innerHTML = "Action";

            cell1.innerHTML = objcategoryname;
            cell2.innerHTML = objmainatt;
            cell3.innerHTML = objpattern;
            cell4.innerHTML = objaction;

            for (j = 0; j < pParentProIDs.length; j++) {
                if (pParentProIDs[j] != "") {
                    var test = pParentProIDs[j].split('~');
                    var row = document.getElementById('tblSelectedPatterns').insertRow(1);
                    row.style.height = "10px";
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);

                    if (test != "") {
                        cell1.innerHTML = test[0];
                        cell2.innerHTML = test[1];
                        cell3.innerHTML = test[2];
                        cell4.innerHTML = "<input name='" + test[0] + "~" + test[1] + "~" + test[2] + "~" + test[3] + "~" + test[4] + "~" + test[5] + "~" + test[6] + "' onclick='btnEdit_OnClick(name);' value = 'Edit' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                                 "<input name='" + test[0] + "~" + test[1] + "~" + test[2] + "~" + test[3] + "~" + test[4] + "~" + test[5] + "~" + test[6] + "' onclick='btnDelete(name);' value = 'Delete' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"
                    }
                }
            }
        }
        function btnEdit_OnClick(sEditedData) {
            document.getElementById('hdnEditedValue').value = sEditedData;
            var y = sEditedData.split('~');

            document.getElementById('btnpattern').value = 'Update Pattern';
            var e = document.getElementById("LstBarcodeCategories");
            var f = document.getElementById("LstBarcodeMainAttributes");
            var g = document.getElementById("lbSelectedItems");
            document.getElementById('hdnPattern1').value = "";
            document.getElementById('hdnPattern2').value = "";
            document.getElementById('hdnRowID1').value = "0";

            var len = e.length;
            var len1 = f.length;

            for (var i = 0; i < len; i++) {
                if (e.options[i].innerHTML == y[0]) {
                    e.options[i].selected = true;
                    e.options[i].disabled = false;
                }
            }
            for (var i = 0; i < len1; i++) {
                if (f.options[i].innerHTML == y[1]) {
                    f.options[i].selected = true;
                    f.options[i].disabled = false;
                }
            }

            g.length = 0;
            document.getElementById("Txtheight").value = '';
            if (y[1] == "Height" || y[1] == "Width") {
                document.getElementById("trTextbox").style.display = 'block';
                //                document.getElementById("lblheight").style.display = 'block';
                document.getElementById("LstBarcodePlaceHolders").style.display = 'none';
                document.getElementById("Lblplaceholder").style.display = 'none';
                var selectedlen = g.length;
                var newOption = new Option();
                newOption.text = y[2];
                document.getElementById("Txtheight").value = y[2];
                g.options[selectedlen] = newOption;
            }
            else {
                document.getElementById("trTextbox").style.display = 'none';
                //                document.getElementById("lblheight").style.display = 'none';
                document.getElementById("LstBarcodePlaceHolders").style.display = 'block';
                document.getElementById("Lblplaceholder").style.display = 'block';
                var strVal = y[2].split('}');
                var strVal1;
                var strcode = y[6].split('}');
                var strcode1;
                var l = strVal.length;
                var l = strcode.length;
                for (var i = 0; i < l; i++) {
                    if (strVal[i] != ' ') {
                        strVal1 = strVal[i].split('{');
                        strcode1 = strcode[i].split('{');
                        var selectedlen = g.length;
                        var newOption = new Option();
                        newOption.text = strVal1[1];
                        newOption.value = strcode1[1];
                        g.options[selectedlen] = newOption;
                    }
                }




            }




            document.getElementById('hdnPattern1').value = y[3];
            document.getElementById('hdnPattern2').value = y[4];
            document.getElementById('hdnRowID1').value = y[5];
//            var x = document.getElementById('hdnRecords').value.split("^");
//            document.getElementById('hdnRecords').value = '';
//            for (var i = 0; i < x.length; i++) {
//                if (x[i] != "") {
//                    if (x[i] != sEditedData) {
//                        document.getElementById('hdnRecords').value += x[i] + "^";
//                    }
//                }
//            }
          //  ChildGridList();
        }

        function btnDelete(sEditedData) {
        var objvarAlert = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert");
            var i;
            var objvar13 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_12") == null ? "Confirm to delete!!" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_12");
             var btnoktext = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_14") == null ? "OK" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_14");
             var btnclosetext = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_15") == null ? "Close" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_15");
            // andrews var IsDelete = confirm(objvar13);
            var IsDelete = ConfirmWindow(objvar13,objvarAlert,btnoktext,btnclosetext);
            if (IsDelete == true) {
                var x = document.getElementById('hdnRecords').value.split("^");
                document.getElementById('hdnRecords').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnRecords').value += x[i] + "^";
                        }
                    }
                }
                ChildGridList();
            }
            else {
                return false;
            }
        }
        function CheckToSaveData() {

            //setTimeout("alert('Save Successfully.');", 3000);
        }
        function RestrictChar(id) {

            var exp = String.fromCharCode(window.event.keyCode)
            var r = new RegExp("[0-9\r]", "g");
            if (exp.match(r) == null) {
                window.event.keyCode = 0
                return false;
            }
        }

        function Clearcat() {
            var e = document.getElementById("LstBarcodeMainAttributes");
            var f = document.getElementById("LstBarcodePlaceHolders");
            e.options.selectedIndex = -1;
            f.options.selectedIndex = -1;
        }

        function CheckCategory() {
            var e = document.getElementById("LstBarcodeMainAttributes");
            var cat = document.getElementById("LstBarcodeCategories");
            var f = document.getElementById("LstBarcodePlaceHolders");
            //var g = document.getElementById("LstBarcodeSubAttributes");

        var objvarAlert = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert");

            var len = e.length;
            var objvar2 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_02") == null ? "Please select a category" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_02");
            if (cat.options.selectedIndex == -1) {
                //alert('Please select a category');
                ValidationWindow(objvar2, objvarAlert);
                e.options.selectedIndex = -1;
                return false;
            }
            else {
                for (var i = 0; i < len; i++) {
                    if (e.options[i].selected == true) {
                        var s = e.options[i].text;
                        f.options.selectedIndex = -1;
                        // e.options.selectedIndex = -1;

                    }
                }
                if (s == "Height") {
                    var selected = document.getElementById("lbSelectedItems");
                    selected.length = 0;
                    document.getElementById('trTextbox').style.display = "block";
                    document.getElementById("LstBarcodePlaceHolders").style.display = 'none';
                    document.getElementById("Lblplaceholder").style.display = 'none';

                }
                if (s == "Width") {
                    var selected = document.getElementById("lbSelectedItems");
                    selected.length = 0;
                    document.getElementById('trTextbox').style.display = "block";
                    document.getElementById("LstBarcodePlaceHolders").style.display = 'none';
                    document.getElementById("Lblplaceholder").style.display = 'none';
                }
                if (s != "Height" && s != "Width") {
                    var selected = document.getElementById("lbSelectedItems");
                    selected.length = 0;
                    document.getElementById("Lblplaceholder").style.display = 'block';
                    document.getElementById("LstBarcodePlaceHolders").style.display = 'block';
                    document.getElementById('trTextbox').style.display = "none";
                }

            }
        }

        function MoveUp() {
        var objvarAlert = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert");
            var objvar1 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_01") == null ? "Please select an Item to swap" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_01");
            var e = document.getElementById("lbSelectedItems");
            var len = e.length;
            var newOption = new Option();
            var newOption1 = new Option();
            if (e.options.selectedIndex == -1) {
               // alert('Please select an Item to swap');
                ValidationWindow(objvar1, objvarAlert);
                return false;
            }
            if (e.options.selectedIndex >= 0) {
                newOption.text = e.options[e.options.selectedIndex].text;
                newOption.value = e.options[e.options.selectedIndex].value;
                newOption1.text = e.options[e.options.selectedIndex - 1].text;
                newOption1.value = e.options[e.options.selectedIndex - 1].value;
                e.options[e.selectedIndex].text = newOption1.text;
                e.options[e.selectedIndex].value = newOption1.value;
                e.options[e.selectedIndex - 1].text = newOption.text;
                e.options[e.selectedIndex - 1].value = newOption.value;
                e.options[e.selectedIndex - 1].selected = true;
            }

            return false;
        }
        function MoveDown() {
            var e = document.getElementById("lbSelectedItems");
            var len = e.length;
            var newOption = new Option();
            var newOption1 = new Option();
            if (e.options.selectedIndex == -1) {
                //alert('Please select an Item to swap');
                ValidationWindow(objvar1, objvarAlert);
                return false;
            }
            if (e.options.selectedIndex >= 0) {
                newOption.text = e.options[e.options.selectedIndex].text;
                newOption.value = e.options[e.options.selectedIndex].value;
                newOption1.text = e.options[e.options.selectedIndex + 1].text;
                newOption1.value = e.options[e.options.selectedIndex + 1].value;
                e.options[e.selectedIndex].text = newOption1.text;
                e.options[e.selectedIndex].value = newOption1.value;
                e.options[e.selectedIndex + 1].text = newOption.text;
                e.options[e.selectedIndex + 1].value = newOption.value;
                e.options[e.selectedIndex + 1].selected = true;

            }

            return false;
        }


        function AddItemValues() {
        var objvarAlert = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert");
        
            var objvar2 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_02") == null ? "Please select a category" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_02");
            var objvar3 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_03") == null ? "Please select a Main Attribute" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_03");

            var flag = 0;
            var f = document.getElementById("LstBarcodeMainAttributes");
            var available = document.getElementById("LstBarcodePlaceHolders");
            var selected = document.getElementById("lbSelectedItems");
            var cat = document.getElementById("LstBarcodeCategories");
            if (cat.options.selectedIndex == -1) {
                //alert('Please select a category');
                ValidationWindow(objvar2, objvarAlert);
                return false;
            }
            if (f.options.selectedIndex == -1) {
                //alert('Please select a Main Attribute');
                ValidationWindow(objvar3, objvarAlert);
                return false;
            }


            if (f.options[f.options.selectedIndex].text == 'Height' || f.options[f.options.selectedIndex].text == 'Width') {
                var objvar4 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_04") == null ? "Please enter value to add" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_04");
                if (document.getElementById('Txtheight').value == "") {
                    // alert('Please enter value to add');
                    ValidationWindow(objvar4, objvarAlert);
                    return false;
                }
                else {
                    selected.length = 0;
                    var newOption = new Option();
                    newOption.text = document.getElementById('Txtheight').value;
                    newOption.value = document.getElementById('Txtheight').value;
                    selected.options[selected.length] = newOption;
                }
            }
            else {
                if (available.options.selectedIndex == -1) {
                    var objvar5 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_05") == null ? "Please select an Item to add" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_05");
                    // alert('Please select an Item to add');
                    ValidationWindow(objvar5, objvarAlert);
                    return false;
                }

                if (available.options.selectedIndex >= 0) {
                    if (selected.length > 0) {
                        for (var t = 0; t < selected.length; t++) {
                            if (selected[t].text == available.options[available.options.selectedIndex].text) {
                                flag = 1;
                                return false;
                            }
                        }
                    }
                }
                if (flag == 0) {
                    var newOption = new Option();
                    newOption.text = available.options[available.options.selectedIndex].text;
                    newOption.value = available.options[available.options.selectedIndex].value;
                    selected.options[selected.length] = newOption;
                }
            }
        }

        function RemoveItemValues() {
        var objvarAlert = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert");
        
            var objvar6 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_06") == null ? "Please select a category" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_06");
            var objvar7 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_07") == null ? "Please select a Main Attribute" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_07");
            var objvar8 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_08") == null ? "Please select an Item to remove" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_08");
            var selected = document.getElementById("lbSelectedItems");
            var available = document.getElementById("LstBarcodePlaceHolders");
            var f = document.getElementById("LstBarcodeMainAttributes");
            var cat = document.getElementById("LstBarcodeCategories");
            if (cat.options.selectedIndex == -1) {
                // alert('Please select a category');
                ValidationWindow(objvar6, objvarAlert);
                return false;
            }

            if (f.options.selectedIndex == -1) {
                //alert('Please select a Main Attribute');
                ValidationWindow(objvar7, objvarAlert);
                return false;
            }

            if (selected.options.selectedIndex == -1) {
                // alert('Please select an Item to remove');
                ValidationWindow(objvar8, objvarAlert);
                return false;
            }
            if (selected.options.selectedIndex >= 0) {
                var objvar9 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_09") == null ? "Number cannot be removed" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_09");
                if (selected.options[selected.options.selectedIndex].text == "Number") {
                    // alert('Number cannot be removed');
                    ValidationWindow(objvar9, objvarAlert);
                }
                else
                    selected.remove(selected.options.selectedIndex);
            }

            return false;
        }


        function CheckToAssign(id) {

        var objvarAlert = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert") == null ? "Alert" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_Alert");

            if (document.getElementById(id).value == 'Update Pattern') {

                var hdnList = document.getElementById('hdnRecords').value;
                document.getElementById('hdnRecords').value = "";
                var hdnVal = hdnList.split("^");
                for (var i = 0; i < hdnVal.length; i++) {
                    if (hdnVal[i] != "") {
                        if (document.getElementById('hdnEditedValue').value != hdnVal[i]) {
                            document.getElementById('hdnRecords').value += hdnVal[i] + "^";
                        }
                    }
                   
                }
            }
        
        
        
        
            var flag = 1;
            var e = document.getElementById("LstBarcodeCategories");
            var f = document.getElementById("LstBarcodeMainAttributes");
            var g = document.getElementById("lbSelectedItems");
            var len = g.length;

            var pattern = '';
            var pattern1 = '';
            if (len <= 0) {
                var objvar10 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_10") == null ? "Add a pattern to assign" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_10");
                //alert('Add a pattern to assign');
                ValidationWindow(objvar10, objvarAlert);
                return false;
            }
            if (f.options.selectedIndex == -1) {
                var objvar11 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_11") == null ? "Select a Main Attribute" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_11");
                ValidationWindow(objvar11, objvarAlert);
                //alert('Select a Main Attribute');
                return false;
            }

            if (e.options.selectedIndex == -1) {
                var objvar14 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_13") == null ? "Select a Category" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_13");
                // alert('Select a Category');
                ValidationWindow(objvar14, objvarAlert);
                return false;
            }
            if (document.getElementById('hdnRecords').value != "") {
                var str = document.getElementById('hdnRecords').value.split('^');
                for (var s = 0; s < str.length; s++) {
                    if (str[s] != "") {
                        var eValue = str[s].split('~')[0];
                        var fValue = str[s].split('~')[1];
                        if (e.options[e.options.selectedIndex].innerHTML == eValue && f.options[f.options.selectedIndex].innerHTML == fValue) {
                            //alert('Pattern Already exists');
                            var objvar15 = SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_14") == null ? "Pattern Already exists" : SListForAppMsg.Get("Admin_AddOrChangeBarcodePatterns_aspx_14");
                            ValidationWindow(objvar15, objvarAlert);
                            flag = 0;
                            return false;
                        }
                    }
                }
            }
            if (flag == 1) {
                var pattern;
                var pattern1;

                if (f.options[f.options.selectedIndex].innerHTML == "Height" || f.options[f.options.selectedIndex].innerHTML == "Width") {
                    for (var p = 0; p < g.length; p++) {
                        pattern += g.options[p].text;
                        pattern1 += g.options[p].value;
                    }

                }
                else {
                    for (var p = 0; p < g.length; p++) {
                        pattern += '{' + g.options[p].text + '}' + ' ';

                    }
                    for (var p = 0; p < g.length; p++) {

                        pattern1 += '{' + g.options[p].value + '}' + ' ';
                    }

                }
                document.getElementById('hdnRecords').value += e.options[e.options.selectedIndex].innerHTML + "~" + f.options[f.options.selectedIndex].innerHTML + "~" + pattern + "~" + e.options[e.options.selectedIndex].value + "~" + f.options[f.options.selectedIndex].value + "~" + document.getElementById('hdnRowID1').value + "~" + pattern1 + "^";
                ChildGridList();
                document.getElementById('hdnRowID1').value = "0";
                g.length = 0;
            }
            document.getElementById('btnpattern').value = 'Assign Pattern';
            document.getElementById('LstBarcodePlaceHolders').value = 0;
            document.getElementById("Txtheight").value = '';
            return false;
        }
    </script>

    <style type="text/css">
        .style1
        {
            width: 180px;
        }
        .style2
        {
            width: 250px;
        }
        .dataheaderInvCtrl tr, .dataheaderInvCtrl td, .dataheaderInvCtrl th
        {
            border: 1px solid #686868;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <table border="0" cellpadding="0" cellspacing="0" class="w-100p searchPanel">
                    <tr>
                        <td>
                            <div>
                                <table class="w-35p" align="left">
                                    <tr>
                                        <td class="style1">
                                            <asp:Label ID="lblCategories" runat="server" Text="Select a Category" CssClass="paddingB5"
                                                Font-Size="Small" Font-Bold="True" 
                                                meta:resourcekey="lblCategoriesResource1" /><br />
                                            <asp:ListBox ID="LstBarcodeCategories" runat="server" Width="180px" 
                                                Height="150px" meta:resourcekey="LstBarcodeCategoriesResource1">
                                            </asp:ListBox>
                                        </td>
                                        <td class="style1">
                                            <asp:Label ID="lblPatterns" runat="server" Text="Select MainAttributes" CssClass="paddingB5"
                                                Font-Size="Small" Font-Bold="True" 
                                                meta:resourcekey="lblPatternsResource1" /><br />
                                            <asp:ListBox ID="LstBarcodeMainAttributes" runat="server" Width="130px" 
                                                Height="150px" meta:resourcekey="LstBarcodeMainAttributesResource1">
                                            </asp:ListBox>
                                        </td>
                                    </tr>
                                </table>
                                <table class="w-20p" align="left">
                                    <tr>
                                        <td class="style2">
                                            <asp:Label ID="Lblplaceholder" runat="server" Text="Select PlaceHolders" CssClass="paddingB5"
                                                Font-Size="Small" Font-Bold="True" 
                                                meta:resourcekey="LblplaceholderResource1" />
                                            <asp:ListBox ID="LstBarcodePlaceHolders" runat="server" Height="150px" 
                                                Width="200px" ondblclick="return AddItemValues();" 
                                                meta:resourcekey="LstBarcodePlaceHoldersResource1">
                                            </asp:ListBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="style2">
                                            <table>
                                                <tr id="trTextbox" style="display: none">
                                                    <td>
                                                        <asp:Label ID="lblheight" runat="server" Text="H / W (px)" 
                                                            meta:resourcekey="lblheightResource1"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="Txtheight" onkeypress="return ValidateOnlyNumeric(this);" runat="server"
                                                            MaxLength="3" meta:resourcekey="TxtheightResource1"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <div id="selecteditem">
                                    <table class="w-35p">
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                        <td>
                                                            <asp:Button ID="btnAdd" runat="server" Style="cursor: pointer;" CssClass="btn w-100 marginB10"
                                                                Text=">>ADD>>" OnClientClick="JavaScript:AddItemValues();return false" 
                                                                meta:resourcekey="btnAddResource1" />
                                                            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<br />
                                                            <asp:Button ID="btnRemove" runat="server" Style="cursor: pointer;" CssClass="btn w-100 marginT10"
                                                                Text="<<REMOVE<<" 
                                                                OnClientClick="JavaScript:RemoveItemValues();return false" 
                                                                meta:resourcekey="btnRemoveResource1" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSelectedItems" runat="server" Text="Selected Items" CssClass="paddingB5"
                                                                Font-Size="Small" Font-Bold="True" 
                                                                meta:resourcekey="lblSelectedItemsResource1" /><br />
                                                            <asp:ListBox ID="lbSelectedItems" runat="server" Height="150px"
                                                                Width="200px" meta:resourcekey="lbSelectedItemsResource1"></asp:ListBox>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="btnUp" runat="server" Style="cursor: pointer;" CssClass="btn w-100 marginB10"
                                                                Text="UP" OnClientClick="JavaScript:MoveUp();return false" 
                                                                meta:resourcekey="btnUpResource1" />
                                                            &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;<br />
                                                            <asp:Button ID="btnDown" runat="server" Style="cursor: pointer;" CssClass="btn w-100 marginT10"
                                                                Text="DOWN" OnClientClick="JavaScript:MoveDown();return false" 
                                                                meta:resourcekey="btnDownResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="a-center">
                                                <asp:Button ID="btnpattern" runat="server" Style="cursor: pointer;" CssClass="btn"
                                                    onmouseout="this.className='btn'" 
                                                    onmouseover="this.className='btn btnhov'" Text="Assign Pattern"
                                                    OnClientClick="return CheckToAssign(this.id);" 
                                                    meta:resourcekey="btnpatternResource1" />
                                                <input type="button" id="Clear" runat="server" value="Clear" class="btn" onclick="JavaScript:ResetPage();" meta:resourcekey="ClearResource1" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:Table ID="tblSelectedPatterns" runat="server" CssClass="dataheaderInvCtrl w-100p a-center gridView"
                    Style="display: table;" border="0" 
            meta:resourcekey="tblSelectedPatternsResource1">
                </asp:Table>
                <table border="0" cellpadding="10" cellspacing="0" class="w-100p">
                    <tr>
                        <td class="a-center">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                onmouseover="this.className='btn btnhov'" OnClick="btnSave_Click" OnClientClick="Javascript:return CheckToSaveData();"
                                Style="display: inline; cursor: pointer;" Text="SAVE" 
                                meta:resourcekey="btnSaveResource1" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:HiddenField ID="hdnRowID" Value="-1" runat="server" />
        <asp:HiddenField ID="hdnRecords" runat="server" />
        <asp:HiddenField ID="hdnEditedValue" runat="server" />
        <asp:HiddenField ID="hdnCatID" Value="0" runat="server" />
        <asp:HiddenField ID="hdnPattern1" runat="server" />
        <asp:HiddenField ID="hdnRowID1" Value="0" runat="server" />
        <asp:HiddenField ID="hdnPattern2" runat="server" />
        <asp:HiddenField ID="hdnorgid" runat="server" />
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
