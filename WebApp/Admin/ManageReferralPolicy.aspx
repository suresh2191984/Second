<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageReferralPolicy.aspx.cs"
    Inherits="Admin_ManageReferralPolicy" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Manage Referral Policy</title>
    <%--<link href="../StyleSheets/TabMenu.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <style type="text/css">
        .policySearchBox
            {
                font-family: Arial, Helvetica, sans-serif;
                text-align: left;
                height: 15px;
                width: 130px;
                border: 1px solid #999999;
                font-size: 11px;
                margin-right: 2%;
                background-image: url('../Images/magnifying-glass.png');
                background-repeat: no-repeat;
                padding-right: 20px!important;
                background-position: right center;
            }

    </style>

    <script type="text/javascript" language="javascript">
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
                if (window.event.shiftKey && event.keyCode == 9) {
                    isCtrl = true;
                }
                else if (window.event.shiftKey)
                { isCtrl = false; }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }
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

            if ((key >= 48 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key == 32)) {
                isCtrl = true;
            }

            return isCtrl;
        }
        function isNumericss(e, Id) {

            var key; var isCtrl; var flag = 0;
            var txtVal = document.getElementById(Id).value.trim();
            var len = txtVal.split('.');
            if (len.length > 1) {
                flag = 1;
            }
            if (window.event) {
                key = window.event.keyCode;
                if (window.event.shiftKey && key == 9) {
                    isCtrl = true;
                }
                else if (window.event.shiftKey)
                { isCtrl = false; }
                else {
                    if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110 && flag == 0) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190 && flag == 0)) {
                        isCtrl = true;
                    }
                    else {
                        isCtrl = false;
                    }
                }
            } return isCtrl;
        }



        function validatePercentageKeyup(txtID, txtMessage) {
            var txtValue = document.getElementById(txtID).value;
            if (isNaN(txtValue)) {
                alert('Enter Valid ' + txtMessage.innerHTML);
                document.getElementById(txtID).focus();
                return false;
            }
            if (parseFloat(txtValue) > 100) {
                alert(txtMessage.innerHTML + ' should not be greater than 100');
                document.getElementById(txtID).focus();
                return false;
            }
            else {
                return true;
            }
        }
    </script>

    <script language="javascript" type="text/javascript">

        function checktable() {
            if (document.getElementById('hdnRefpolicyDetails').value == "") {
                alert('Empty Referral Policy');
                return false;
            }
        }



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
            //*************To block slash(/) into text box change the key value to 48***************************//
            if ((key >= 47 && key <= 57) || (key >= 97 && key <= 122) || (key >= 65 && key <= 90) || (key == 8) || (key != 32)) {
                isCtrl = true;
            }
            return isCtrl;
        }

        function GetValues(id) {
            //var TodId = "0";
            var RowID = 0;
          
            var Type = document.getElementById('drpRefpolicyType').options[document.getElementById('drpRefpolicyType').selectedIndex].text;
            var Code = document.getElementById('txtCategoryCode').value;
            var txtfrom = document.getElementById('txtFrom').value;
            var txtto = document.getElementById('txtTo').value;
            var percentage = document.getElementById('txtPercentage').value;

            if (Code == "") {
                alert('Provide Code');
                document.getElementById('txtCategoryCode').focus();
                return false;
            }


            if (txtfrom == "" || txtfrom == '0') {
                alert('This Range is Not Valid.Please give valid Range');
                //alert('Provide valid range');
                document.getElementById('txtFrom').focus();
                return false;

            }
            if (txtto == "" || txtto == '0') {
                alert('This Range is Not Valid.Please give valid Range');
                document.getElementById('txtTo').focus();
                return false;
            }
            if (percentage == "") {
                alert('Provide percentage');
                document.getElementById('txtPercentage').focus();
                return false;
            }
            if (  (parseInt(percentage)) <= 0) {
                alert('Percentage must be greater than zero');
                document.getElementById('txtPercentage').focus();
                return false;
            }

            if (parseInt(txtto) <= parseInt(txtfrom)) {
                alert('This Range is Not Valid.Please give valid Range');
                document.getElementById('txtFrom').focus();
                return false;

            }
            var hdnVal = document.getElementById('hdnRefpolicyDetails').value.split("^");
            var isValid = true;
            var ddlType = document.getElementById('drpRefpolicyType').options[document.getElementById('drpRefpolicyType').selectedIndex].text;
            var categorycode = document.getElementById('txtCategoryCode').value;
            for (var i = 0; i < hdnVal.length; i++) {
                if (hdnVal[i] != "") {
                    if (document.getElementById(id).value == 'Update') {
                        RowID = parseInt(document.getElementById('btnAdd').getAttribute("Edit"));
                        if (parseInt(hdnVal[i].split('~')[5]) != RowID) {
                            if (parseInt(txtfrom) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtfrom) <= parseInt(hdnVal[i].split('~')[2]) && categorycode == hdnVal[i].split('~')[0]) {
                                isValid = false;
                            }
                            if (parseInt(txtto) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtto) <= parseInt(hdnVal[i].split('~')[2]) && categorycode == hdnVal[i].split('~')[0]) {
                                isValid = false;
                            }
                        }
                    }
                    else {
                        if (parseInt(txtfrom) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtfrom) <= parseInt(hdnVal[i].split('~')[2]) && categorycode == hdnVal[i].split('~')[0]) {
                            isValid = false;
                        }
                        if (parseInt(txtto) >= parseInt(hdnVal[i].split('~')[1]) && parseInt(txtto) <= parseInt(hdnVal[i].split('~')[2]) && categorycode == hdnVal[i].split('~')[0]) {
                            isValid = false;
                        }
                    }

                }
            }


            if (isValid) {

                if (document.getElementById(id).value == 'Update') {
                    //TodId = document.getElementById('hdnEditedValue').value.split('~')[0];
                    //Active = document.getElementById('hdnEditedValue').value.split('~')[6];
                    RowID = parseInt(document.getElementById('btnAdd').getAttribute("Edit"));
                    var hdnList = document.getElementById('hdnRefpolicyDetails').value;
                    document.getElementById('hdnRefpolicyDetails').value = "";
                    var hdnVal = hdnList.split("^");
                    for (var i = 0; i < hdnVal.length; i++) {
                        if (hdnVal[i] != "") {
                            var id = parseInt(hdnVal[i].split('~')[5]);
                            if (id == RowID) {
                                document.getElementById('hdnRefpolicyDetails').value += Code + "~" + txtfrom + "~" + txtto + "~" + percentage + "~" + Type + "~" + RowID + "^"
                            }
                            else {
                                document.getElementById('hdnRefpolicyDetails').value += hdnVal[i] + "^";
                            }
                        }
                    }

                }
                else {
                    var hdnList = document.getElementById('hdnRefpolicyDetails').value;
                    var hdnVal = hdnList.split("^");
                    RowID = hdnVal.length;
                    document.getElementById('hdnRefpolicyDetails').value += Code + "~" + txtfrom + "~" + txtto + "~" + percentage + "~" + Type + "~" + RowID + "^";
                }
                if (document.getElementById('hdnRefpolicyDetails').value != '') {
                    GenerateTable();
                    document.getElementById('drpRefpolicyType').disabled = false;
                    document.getElementById('txtCategoryCode').disabled = false;
                    document.getElementById('btnAdd').value = 'Add';
                    document.getElementById('btnSavePolicy').style.display = 'block';
                    document.getElementById('txtFrom').value = "";
                    document.getElementById('txtTo').value = "";
                    document.getElementById('txtPercentage').value = "";
                    $('#txtCategoryCode').val('');
//                    document.getElementById('drpRefpolicyType').disabled = true;
//                    document.getElementById('txtCategoryCode').disabled = true;
                }
            }
            else {
                alert('This Range is Not Valid.Please give valid Range');
                document.getElementById('txtFrom').focus();
                return false;
            }
        }


        function GenerateTable() {
           
            while (count = document.getElementById('tblRowCnt').rows.length) {
                for (var j = 0; j < document.getElementById('tblRowCnt').rows.length; j++) {
                    document.getElementById('tblRowCnt').deleteRow(j);
                }
            }
            var flag = 0;
            var checkItem = document.getElementById('hdnRefpolicyDetails').value.split('^');
            if (checkItem != "") {

                document.getElementById('btnSavePolicy').style.display = 'block';
                document.getElementById('tdtblRowCnt').style.display = 'table-cell';
                var pList = document.getElementById('hdnRefpolicyDetails').value.split("^");
                var pParentLst = document.getElementById('hdnRefpolicyDetails').value.split("^");
                var Headrow = document.getElementById('tblRowCnt').insertRow(0);
                var Type = document.getElementById('drpRefpolicyType').options[document.getElementById('drpRefpolicyType').selectedIndex].value;
                Headrow.id = "HeadID";
                Headrow.style.fontWeight = "bold";
                Headrow.style.textAlign = "center";
                Headrow.className = "gridHeader";

                var cell0 = Headrow.insertCell(0);
                var cell1 = Headrow.insertCell(1);
                var cell2 = Headrow.insertCell(2);
                var cell3 = Headrow.insertCell(3);
                var cell4 = Headrow.insertCell(4);
                var cell5 = Headrow.insertCell(5);
                var cell6 = Headrow.insertCell(6);

                cell0.innerHTML = "S.No";
                cell1.innerHTML = "Dr Fee Category";
                cell2.innerHTML = "Slab From";
                cell3.innerHTML = "To";
                cell4.innerHTML = "Payout";
                cell5.innerHTML = "Calculate on"
                cell6.innerHTML = "Action";
                cell0.style.width = "13%";
                cell1.style.width = "13%";
                cell2.style.width = "13%";
                cell3.style.width = "13%";
                cell4.style.width = "13%";
                cell5.style.width = "13%";
                cell6.style.width = "13%";

                for (j = 0; j < pParentLst.length; j++) {
                    if (pParentLst[j] != "") {
                        y = pList[j].split('~');
                        var varsno = pParentLst.length - 1;
                        var sno = varsno - j;
                        var row = document.getElementById('tblRowCnt').insertRow(parseInt(y[5]));
                        row.style.height = "10px";
                        row.style.textAlign = "center";
                        var cell0 = row.insertCell(0);
                        var cell1 = row.insertCell(1);
                        var cell2 = row.insertCell(2);
                        var cell3 = row.insertCell(3);
                        var cell4 = row.insertCell(4);
                        var cell5 = row.insertCell(5);
                        var cell6 = row.insertCell(6);
                       
                        //cell0.innerHTML = y[0];
                        cell0.innerHTML = y[5];
                        cell1.innerHTML = y[0];
                        cell2.innerHTML = y[1];
                        cell3.innerHTML = y[2];
                        cell4.innerHTML = y[3];
                        cell5.innerHTML = y[4];
                        cell6.innerHTML = "<input  name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "' onclick='btnEdit_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Edit%>' type='button' style='background-color:Transparent;color:Blue;border-style:none;text-decoration:underline;cursor:pointer'  /> &nbsp;&nbsp;" +
                                          "<input  name='" + y[0] + "~" + y[1] + "~" + y[2] + "~" + y[3] + "~" + y[4] + "~" + y[5] + "' onclick='btnDelete_OnClick(name);' value = '<%=Resources.ClientSideDisplayTexts.Admin_DiscountMaster_Delete%>' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'  />"


                    }
                }
            }
        }
        function btnEdit_OnClick(sEditedData) {
            document.getElementById('hdnEditedValue').value = sEditedData;
            var y = sEditedData.split('~');
            document.getElementById('btnAdd').value = 'Update';
            document.getElementById('txtCategoryCode').value = y[0];
            document.getElementById('txtFrom').value = y[1];
            document.getElementById('txtTo').value = y[2];
            document.getElementById('txtPercentage').value = y[3];
            document.getElementById('btnAdd').setAttribute("Edit", y[5]);
            if (y[4] == "Billed Amount") { document.getElementById('drpRefpolicyType').value = 1; }
            else { document.getElementById('drpRefpolicyType').value = 2; }
            document.getElementById('drpRefpolicyType').disabled = true;
            document.getElementById('txtCategoryCode').disabled = true;
        }
        function btnDelete_OnClick(sEditedData) {
            var i;
            var ConfirmString;
            ConfirmString = 'Confirm to delete!!';
            var IsDelete = confirm(ConfirmString);
            if (IsDelete == true) {
                var x = document.getElementById('hdnRefpolicyDetails').value.split("^");
                document.getElementById('hdnRefpolicyDetails').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnRefpolicyDetails').value += x[i] + "^";
                        }
                    }
                }
                //                if (document.getElementById('btnAdd').value == 'Update') {
                //                    document.getElementById('hdnRefpolicyDetails').value += document.getElementById('txtFrom').value + "~" + document.getElementById('txtTo').value + "~" + document.getElementById('txtPercentage').value + "~" + document.getElementById('TxtInv').value + "^";
                document.getElementById('btnAdd').value = 'Add';
                document.getElementById('txtFrom').value = '';
                document.getElementById('txtTo').value = '';
                document.getElementById('txtPercentage').value = '';
                //                }
                GenerateTable();
            }
            else {
                return false;
            }
        }

        function ClearText() {

            document.getElementById('txtCategoryCode').value = '';
            document.getElementById('txtFrom').value = '';
            document.getElementById('txtTo').value = '';
            document.getElementById('txtPercentage').value = '';
            //document.getElementById('hdnRefpolicyDetails').value = '';
            //document.getElementById('tdtblRowCnt').style.display = 'none';
            document.getElementById('btnAdd').value = 'Add';
            document.getElementById('txtCategoryCode').disabled = false;
            document.getElementById('drpRefpolicyType').disabled = false;
        }

        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtPercentage").value.length;
                var index = document.getElementById("txtPercentage").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }

        function isNumberKeytax(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtPercent").value.length;
                var index = document.getElementById("txtPercent").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }


        function isNumberKeydis(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtDiscountValue").value.length;
                var index = document.getElementById("txtDiscountValue").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }

        function isNumberKeyDP(evt) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46)
                return false;
            else {
                var len = document.getElementById("txtDisValue").value.length;
                var index = document.getElementById("txtDisValue").value.indexOf('.');

                if (index > 0 && charCode == 46) {
                    return false;
                }
                if (index > 0) {
                    var CharAfterdot = (len + 1) - index;
                    if (CharAfterdot > 3) {
                        return false;
                    }
                }

            }
            return true;
        }
    </script>
    
    <script type="text/javascript" language="javascript">
        function filter2(phrase, _id) {
            var words = phrase.value.toLowerCase().split(" ");
            var table = document.getElementById(_id);
            var ele;
            for (var r = 1; r < table.rows.length; r++) {
                ele = table.rows[r].innerHTML.replace(/<[^>]+>/g, "");
                ele = ele.replace('&nbsp;', '');
                ele = ele.replace(' &nbsp;', '');
                var displayStyle = 'none';
                for (var i = 0; i < words.length; i++) {
                    if (ele.toLowerCase().indexOf(words[i]) >= 0)
                        displayStyle = '';
                    else {
                        displayStyle = 'none';
                        break;
                    }
                }
                table.rows[r].style.display = displayStyle;
            }
        }
    </script>
    
<script src="../Scripts/filterTable.js" type="text/javascript" language="javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ctlTaskScriptMgr" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="divTurnovrDisc" runat="server">
            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                <ContentTemplate>
                    <table cellpadding="4" class="searchPanel defaultfontcolor w-100p" id="tblTurnOver">
                        <tr>
                            <td>
                                <asp:Panel ID="pnlTOD" runat="server" meta:resourcekey="pnlTODResource2">
                                    <table cellpadding="3" style="border: 0px; border-color: Red" border="0" cellspacing="3"
                                        width="100%" class="defaultfontcolor">
                                        <tr>
                                            <td>
                                                <table class="w-100p searchPanel">
                                                    <tr>
                                                        <td class="w-5p">
                                                            <asp:Label ID="lblCode" runat="server" Text="Dr Fee Category" meta:resourcekey="lblCodeResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-6p">
                                                            <asp:TextBox ID="txtCategoryCode" Width="60px" CssClass="Txtboxmedium" MaxLength="3" runat="server"
                                                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" ></asp:TextBox>
                                                        </td>
                                                        <td align="left" class="w-3p">
                                                            <asp:Label ID="lblLowerRange" runat="server" Text="Slab From" meta:resourcekey="lblLowerRangeResource2"></asp:Label>
                                                        </td>
                                                        <td class="w-6p">
                                                            <asp:TextBox ID="txtFrom" CssClass="Txtboxmedium" runat="server" onKeyDown="return  isNumeric(event,this.id)"
                                                                Width="60px" MaxLength="9" meta:resourcekey="txtFromResource1"></asp:TextBox>
                                                        </td>
                                                        <td align="left" class="w-1p">
                                                            <asp:Label ID="lblUpperRange" runat="server" Text="To" meta:resourcekey="lblUpperRangeResource2"></asp:Label>
                                                        </td>
                                                        <td class="w-6p">
                                                            <asp:TextBox ID="txtTo" onKeyDown="return  isNumeric(event,this.id)" CssClass="Txtboxmedium"
                                                                runat="server" Width="60px" MaxLength="9" meta:resourcekey="txtToResource1"></asp:TextBox>
                                                        </td>
                                                        <td align="left" class="w-2p">
                                                            <asp:Label ID="lblTODPercent" Text="Payout" runat="server" meta:resourcekey="lblTODPercentResource3"></asp:Label>
                                                        </td>
                                                        <td class="w-5p">
                                                            <asp:TextBox ID="txtPercentage" CssClass="Txtboxmedium" runat="server" Width="30px"
                                                                MaxLength="5" onKeyDown="return  isNumeric(event,this.id)" onblur="validatePercentageKeyup(this.id,lblTODPercent)"
                                                                     onkeypress="return ValidateOnlyNumeric(this);"    meta:resourcekey="txtPercentageResource1"></asp:TextBox>
                                                            <asp:Label ID="lblpercen" runat="server" Text="%" meta:resourcekey="lblpercenResource1"></asp:Label>
                                                        </td>
                                                        <td class="w-4p">
                                                            <asp:Label ID="lblBasedOn" runat="server" Text="Calculate On" meta:resourcekey="lblBasedOnResource2"></asp:Label>
                                                        </td>
                                                        <td class="w-12p">
                                                            <asp:DropDownList ID="drpRefpolicyType" runat="server" CssClass="drpsmall" meta:resourcekey="drpTODTypeResource1">
                                                            </asp:DropDownList>
                                                            &nbsp;
                                                            <input type="button" id="btnAdd" value=" Add " class="btn1" onmouseout="this.className='btn1'"
                                                                onclick="return GetValues(this.id);" enabled="false" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        
                                        <tr>
                                            <td style="font-weight: bold;" class="a-right">
                                             <input name="filter" onkeyup="filter2(this, 'tblRowCnt')" type="text" class="policySearchBox">
                                            </td>
                                        </tr>
                                        
                                        
                                    </table>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td runat="server" id="tdtblRowCnt">
                                <table id="tblRowCnt" runat="server" width="98%" class="gridView">
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table width="8%">
                                    <tr>
                                        <td>
                                            <asp:Button Style="display: none;" ID="btnSavePolicy" runat="server" Text="Save" CssClass="btn1"
                                                OnClientClick="return checktable();" OnClick="btnSavePolicy_Click" meta:resourcekey="btnSaveTODResource1">
                                            </asp:Button>
                                        </td>
                                        <td>
                                            <input type="button" id="btnClearAll" value=" Clear " class="btn1" onclick="ClearText();" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdnEditedValue" runat="server" />
                    <asp:HiddenField ID="hdnRefpolicyDetails" runat="server" />
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
</body>
</html>
