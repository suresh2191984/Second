<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customers.aspx.cs" Inherits="Inventory_Customers"
    EnableEventValidation="false" Culture="auto" meta:resourcekey="PageResource1"
    UICulture="auto" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Src="~/PlatFormControls/ErrorDisplay.ascx" TagName="ErrorDisplay"
    TagPrefix="uc6" %>
<%@ Register Src="~/InventoryCommon/Controls/ProductSearch.ascx" TagName="ProductSearch"
    TagPrefix="uc7" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Customers</title>
    <%--<link href="../StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script language="javascript" type="text/javascript">
        var userMsg;
        var strUpdate = SListForAppDisplay.Get("Inventorymaster_Customers_aspx_02") == null ? "Update" : SListForAppDisplay.Get("Inventorymaster_Customers_aspx_02");
             function isNumericss(e, Id) {

                 var key; var isCtrl; var flag = 0;
                 var txtVal = document.getElementById(Id).value.trim();
                 var len = txtVal.split('.');
                 if (len.length > 1) {
                     flag = 1;
                 }
                 if (window.event) {
                     key = window.event.keyCode;
                     if (window.event.shiftKey) {
                         isCtrl = false;
                     }
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
        function SetValues(obj) {
            clearLocations();            
            var x = obj.value.split('~');
            var opt = x != "" && x[13] != "" ? x[13] : 0;
            document.getElementById('hdnId').value = x[0];
            document.getElementById('txtCustomerName').value = x[1];
            document.getElementById('txtContactPerson').value = x[2];
            document.getElementById('txtAddress1').value = x[3];
            document.getElementById('txtAddress2').value = x[4];
            document.getElementById('txtCity').value = x[5];
            document.getElementById('txtEmailID').value = x[6];
            document.getElementById('txtPhoneNumber').value = x[7];
            document.getElementById('txtMobileNumber').value = x[8];
            document.getElementById('btnFinish').value = strUpdate;
            document.getElementById('lblmsg').innerText = "";
            document.getElementById('hdnStatus').value = strUpdate;
            document.getElementById('txtTinNo').value = x[9];
            document.getElementById('txtFaxNumber').value = x[10];
            document.getElementById('txtPan').value = x[14];
            document.getElementById('txtCSTNumber').value = x[15];
            document.getElementById('txtDrugLicenceNo').value = x[16];
            document.getElementById('txtServiceTaxNo').value = x[17];
            document.getElementById('txtTermsCondition').value = x[12];
            document.getElementById('ddlCustomerType').options[opt].selected = true;
            //document.getElementById('tdChkDelete').style.display = 'block';
            $('#tdChkDelete').removeClass().addClass('show');
            document.getElementById('chkDelete').checked = x[11] == 'Y' ? false : true;
            document.getElementById('hdnCustomerLocations').value = "";
            document.getElementById('hdnCustomerLocations').value = x[18];
            setLocations();
            GenerateTable();
            var tbl = document.getElementById('tblCustomerDetail').rows.length;
            if (tbl > 1) {
                showResponses('Div1', 'Div2', 'divLocation', 1);
            }
            else {
                showResponses('Div1', 'Div2', 'divLocation', 0);
            }
        }
        function setLocations() {
            document.getElementById('hdnLocationDetails').value = "";
            var locList = document.getElementById('hdnCustomerLocations').value.split("^");
            for (var i = 0; i < locList.length; i++) {
                if (locList[i] != "") {
//                    if (document.getElementById('hdnId').value == locList[i].split("|")[1]) {
                        document.getElementById('hdnLocationDetails').value += locList[i] +"^";
//                    }
                }
            }
        }

        function clearFields() {
            var strSave = SListForAppDisplay.Get("Inventorymaster_Customers_aspx_03") == null ? "Save" : SListForAppDisplay.Get("Inventorymaster_Customers_aspx_03");
            document.getElementById('hdnId').value = "0";
            document.getElementById('txtCustomerName').value = "";
            document.getElementById('txtContactPerson').value = "";
            document.getElementById('txtAddress1').value = "";
            document.getElementById('txtAddress2').value = "";
            document.getElementById('txtCity').value = "";
            document.getElementById('txtEmailID').value = "";
            document.getElementById('txtPhoneNumber').value = "";
            document.getElementById('txtMobileNumber').value = "";
            document.getElementById('btnFinish').value = strSave;
            document.getElementById('lblmsg').innerText = "";
            document.getElementById('hdnStatus').value = strSave;
            document.getElementById('txtTinNo').value = "";
            document.getElementById('txtFaxNumber').value = "";
            document.getElementById('txtPan').value = "";
            document.getElementById('txtCSTNumber').value = "";
            document.getElementById('txtDrugLicenceNo').value = "";
            document.getElementById('txtServiceTaxNo').value = "";
            document.getElementById('txtTermsCondition').value = "";
            document.getElementById('ddlCustomerType').options[0].selected = true;
            //document.getElementById('tdChkDelete').style.display = 'none';
            $('#tdChkDelete').removeClass().addClass('hide');
            document.getElementById('chkDelete').checked = false;
            showResponses('Div1', 'Div2', 'divLocation', 0);
            return false;
        }
        function checkDetails() {

            //  var Fin = document.getElementById('btnFinish').value;
            if (document.getElementById('txtCustomerName').value == '') {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_04") == null ? "Provide the supplier name" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_04");

                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtCustomerName').focus();
                    return false;
                }
            }
            if (document.getElementById('txtTinNo').value == '') {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_05") == null ? "Provide the tin number" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_05");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtTinNo').focus();
                    return false;
                } 
            }
            if (document.getElementById('txtContactPerson').value == '') {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_06") == null ? "Provide the contact person" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_06");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    alert(userMsg); document.getElementById('txtContactPerson').focus();
                    return false;
                } 
            }
            if (document.getElementById('txtAddress1').value == '') {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_07") == null ? "Provide the address" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_07");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtAddress1').focus();
                    return false;
                } 
            }
            if ((document.getElementById('txtPhoneNumber').value == '') && (document.getElementById('txtMobileNumber').value == '')) {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_08") == null ? "Provide at least one contact number" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_08");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtPhoneNumber').focus();
                    return false;
                } 
            }
            if (document.getElementById('ddlCustomerType').value == 0) {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_09") == null ? "select the Customer Type" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_09");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ddlCustomerType').focus();
                    return false;
                }
            }
            if (document.getElementById('btnAdd').value == strUpdate) {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_10") == null ? "Provide Customer location details" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_10");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                } 
            }
            
            
            //        if (document.getElementById('txtFaxNumber').value == '') {
            //            alert('Provide the FaxNumber');
            //            document.getElementById('txtFaxNumber').focus();
            //            return false;
            //        }
            //        if (document.getElementById('txtPan').value == '') {
            //            alert('Provide the PAN');
            //            document.getElementById('txtPan').focus();
            //            return false;
            //        }
            //        if (document.getElementById('txtCSTNumber').value == '') {
            //            alert('Provide the CST Number');
            //            document.getElementById('txtCSTNumber').focus();
            //            return false;
            //        }
            //        if (document.getElementById('txtDrugLicenceNo').value == '') {
            //            alert('Provide the Drug Licence Number');
            //            document.getElementById('txtDrugLicenceNo').focus();
            //            return false;
            //        }
            //        if (document.getElementById('txtServiceTaxNo').value == '') {
            //            alert('Provide the ServiceTax Number');
            //            document.getElementById('txtServiceTaxNo').focus();
            //            return false;
            //        }
            if (document.getElementById('ddlCustomerType').options[0].selected == true) {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_11") == null ? "Provide Customer Type" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_11");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('ddlCustomerType').focus();
                    return false;
                } 
            }
            EditorInstance = "";

        }
        function checkLocations() {
            if (document.getElementById('txtShippLocation').value.trim() == "") {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_12") == null ? "Provide Shipping Location" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_12");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                } 
            }
            if (document.getElementById('txtShippAddress').value.trim() == "") {
                var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_13") == null ? "Provide Shipping Address" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_13");
                if (userMsg != null && errorMsg != null) {
                    ValidationWindow(userMsg, errorMsg);
                    return false;
                } 
            }
            var LocationID = document.getElementById('hdnLocationID').value;
            var Location = document.getElementById('txtShippLocation').value;
            var Address = document.getElementById('txtShippAddress').value;
            var chkList = document.getElementById('hdnLocationDetails').value.split("^");
            for (var s = 0; s < chkList.length; s++) {
                if (chkList[s] != "") {
                    if (chkList[s].split("|")[1].trim() == Location.trim()) {
                        var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_14") == null ? "Location already exists !!" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_14");
                        if (userMsg != null && errorMsg != null) {
                            ValidationWindow(userMsg, errorMsg);
                            return false;
                        } 
                    }
                }
            }
            document.getElementById('hdnLocationDetails').value += Location + "|" + Address + "|" + LocationID + "^";
            GenerateTable();
            clearLocations();
            return true;
        }
        function clearLocations() {
            document.getElementById('txtShippLocation').value = "";
            document.getElementById('txtShippAddress').value = "";
            document.getElementById('hdnLocationID').value = "0";
        }

        function GenerateTable() {
            var strAdd = SListForAppDisplay.Get("Inventorymaster_Customers_aspx_04") == null ? "Add" : SListForAppDisplay.Get("Inventorymaster_Customers_aspx_04");
            var strSerialNo=SListForAppDisplay.Get("Inventorymaster_Customers_aspx_05")== null ?"S.No.":SListForAppDisplay.Get("Inventorymaster_Customers_aspx_05");
            var strCustomerLocation=SListForAppDisplay.Get("Inventorymaster_Customers_aspx_06")== null ?"Customer Location":SListForAppDisplay.Get("Inventorymaster_Customers_aspx_06");
            var strCustomerAddress=SListForAppDisplay.Get("Inventorymaster_Customers_aspx_07")== null ?"Customer Address":SListForAppDisplay.Get("Inventorymaster_Customers_aspx_07");
            var strAction=SListForAppDisplay.Get("Inventorymaster_Customers_aspx_08")== null ?"Action":SListForAppDisplay.Get("Inventorymaster_Customers_aspx_08");
            var strLocationID=SListForAppDisplay.Get("Inventorymaster_Customers_aspx_09")== null ?"LocationID":SListForAppDisplay.Get("Inventorymaster_Customers_aspx_09");
            var strEdit = SListForAppDisplay.Get("Inventorymaster_Customers_aspx_10") == null ? "Edit" : SListForAppDisplay.Get("Inventorymaster_Customers_aspx_10");
            var strDelete=SListForAppDisplay.Get("Inventorymaster_Customers_aspx_11")== null ?"Delete":SListForAppDisplay.Get("Inventorymaster_Customers_aspx_11");

            document.getElementById('btnAdd').value = strAdd;
            while (count = document.getElementById('tblCustomerDetail').rows.length) {
                for (var j = 0; j < document.getElementById('tblCustomerDetail').rows.length; j++) {
                    document.getElementById('tblCustomerDetail').deleteRow(j);
                } 
            }
            var pList = document.getElementById('hdnLocationDetails').value.split("^");
            if (pList != "") {
                var Headrow = document.getElementById('tblCustomerDetail').insertRow(0);
                Headrow.id = "HeadID";
                var id = 0;
                //Headrow.style.fontWeight = "bold";
                Headrow.addClass("bold");
                Headrow.className = "dataheader1"

                var cell1 = Headrow.insertCell(0);
                var cell2 = Headrow.insertCell(1);
                var cell3 = Headrow.insertCell(2);
                var cell4 = Headrow.insertCell(3);
                var cell5 = Headrow.insertCell(4);

                cell1.innerHTML = strSerialNo;
                cell2.innerHTML = strCustomerLocation;
                cell3.innerHTML = strCustomerAddress;
                cell4.innerHTML = strAction;
                cell5.innerHTML = strLocationID;
                //cell5.style.display = "none";
                cell5.addClass("hide");

                for (s = 0; s < pList.length; s++) {
                    if (pList[s] != "") {
                        y = pList[s].split('|');
                        var row = document.getElementById('tblCustomerDetail').insertRow(1);
                        //row.style.height = "10px";
                        row.addClass("h-10");
                        var cell1 = row.insertCell(0);
                        var cell2 = row.insertCell(1);
                        var cell3 = row.insertCell(2);
                        var cell4 = row.insertCell(3);
                        var cell5 = row.insertCell(4);

                        cell1.innerHTML = pList.length == 1 ? pList.length : pList.length - s - 1;
                        cell2.innerHTML = y[0];
                        cell3.innerHTML = y[1];
                        cell4.innerHTML = "<input id='edit' name='" + y[0] + "|" + y[1] + "|" + y[2] + "' onclick='btnEdit_OnClick(name);' value = " + strEdit + " type='button' class='view1 underline pointer'  /> &nbsp;&nbsp;" +
                                                 "<input id='edit1' name='" + y[0] + "|" + y[1] + "|" + y[2] + "' onclick='btnDelete(name);' value = " + strDelete + " type='button' class='view1 underline pointer'  />"
                        cell5.innerHTML = y[0];
                        //cell5.style.display = "none";
                        cell5.addClass("hide");
                    }
                }
            } 
        }
        function btnDelete(sEditedData) {
            var i;
            var userMsg = SListForAppMsg.Get("Inventorymaster_Customers_aspx_02") == null ? "Confirm to delete!!" : SListForAppMsg.Get("Inventorymaster_Customers_aspx_02");
             if (Usermsg != null && OkMsg != null && CancelMsg != null && ConfirmMsg != null) {
                 var IsDelete = ConfirmWindow(usermsg, InformationMsg, OkMsg, CancelMsg)
             }
            if (IsDelete == true) {
                var x = document.getElementById('hdnLocationDetails').value.split("^");
                document.getElementById('hdnLocationDetails').value = '';
                for (i = 0; i < x.length; i++) {
                    if (x[i] != "") {
                        if (x[i] != sEditedData) {
                            document.getElementById('hdnLocationDetails').value += x[i] + "^";
                        }
                    }
                }
                GenerateTable();
            }
            else {
                return false;
            }
        }
        function btnEdit_OnClick(sEditedData) {
            if (document.getElementById('hdnLocationDetails').value != "") {
                var y = sEditedData.split('|');
                document.getElementById('hdnLocationID').value = y[2];
                document.getElementById('txtShippLocation').value = y[0];
                document.getElementById('txtShippAddress').value = y[1];
                var list = document.getElementById('hdnLocationDetails').value.split("^");
                document.getElementById('hdnLocationDetails').value = "";
                for (var i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        if (list[i] != sEditedData) {
                            document.getElementById('hdnLocationDetails').value += list[i] + "^";
                        }
                    }
                }
            }
            GenerateTable();
            var tbl = document.getElementById('tblCustomerDetail').rows.length;
            var Tb = document.getElementById('tblCustomerDetail');
            if (tbl > 0) {
                for (var j = 0; j < tbl; j++) {
                    Tb.rows[j].cells[3].style.display = "none";
                }
            }

            document.getElementById('btnAdd').value = strUpdate;
        }
    </script>

</head>
<body>
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <attune:attuneheader id="Attuneheader" runat="server" />
    <script type="text/javascript" language="javascript">
        var errorMsg = SListForAppMsg.Get("InventoryMater_Error") != null ? SListForAppMsg.Get("InventoryMater_Error") : "Alert";
        var InformationMsg = SListForAppMsg.Get("InventoryMater_Information") != null ? SListForAppMsg.Get("InventoryMater_Information") : "Information";
        var okMsg = SListForAppMsg.Get("InventoryMater_Ok") != null ? SListForAppMsg.Get("InventoryMater_Ok") : "Ok";
        var CancelMsg = SListForAppMsg.Get("InventoryMater_Cancel") != null ? SListForAppMsg.Get("InventoryMater_Cancel") : "Cancel";
    </script>
    <div class="contentdata">
<%--        <ul>
            <li>
                <uc6:ErrorDisplay ID="ErrorDisplay1" runat="server" />
            </li>
        </ul>--%>
        <asp:UpdatePanel ID="UpdatePanel" runat="server">
            <contenttemplate>
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <div>
                                                <table class="dataheader2 defaultfontcolor w-100p" cellpadding="4">
                                                    <tr>
                                                        <td colspan="4" class ="a-center">
                                                            <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" class="h-4">
                                                            <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblCustomer" Text="Customer Name" runat="server" 
                                                                meta:resourcekey="lblCustomerResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCustomerName" runat="server" MaxLength="50" CssClass="medium"
                                                                meta:resourcekey="txtCustomerNameResource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_TinNo" Text="Tin No" runat="server" 
                                                                meta:resourcekey="lbl_TinNoResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtTinNo" runat="server" MaxLength="50" CssClass="medium"
                                                                meta:resourcekey="txtTinNoResource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_ContactPerson" Text="Contact Person" runat="server" 
                                                                meta:resourcekey="lbl_ContactPersonResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtContactPerson" runat="server" MaxLength="50" 
                                                                CssClass="medium" meta:resourcekey="txtContactPersonResource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_Address1" Text="Address 1" runat="server" 
                                                                meta:resourcekey="lbl_Address1Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAddress1" runat="server" MaxLength="100" TextMode="MultiLine"
                                                                CssClass="medium"
                                                                meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_Address2" Text="Address 2" runat="server" 
                                                                meta:resourcekey="lbl_Address2Resource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAddress2" runat="server" MaxLength="50" TextMode="MultiLine"
                                                                CssClass="medium"
                                                                meta:resourcekey="txtAddress2Resource1"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_City" Text="City" runat="server" 
                                                                meta:resourcekey="lbl_CityResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCity" runat="server" MaxLength="50" CssClass="medium" 
                                                                meta:resourcekey="txtCityResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_EmailID" Text="Email ID" runat="server" Width="201px" 
                                                                meta:resourcekey="lbl_EmailIDResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtEmailID" runat="server" MaxLength="100" 
                                                                CssClass="medium" meta:resourcekey="txtEmailIDResource1"></asp:TextBox>
                                                            <asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                                ControlToValidate="txtEmailID" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                                ValidationGroup="register" meta:resourcekey="regValidatorResource1"> <%= Resources.InventoryMaster_AppMsg.InventoryMaster_Customers_aspx_01 %></asp:RegularExpressionValidator>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_LandLine" Text="Land Line" runat="server" 
                                                                meta:resourcekey="lbl_LandLineResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtPhoneNumber" runat="server" MaxLength="20" 
                                                                CssClass="medium" onKeyDown="return isNumericss(event,this.id)" 
                                                                meta:resourcekey="txtPhoneNumberResource1"></asp:TextBox>
                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_MobileNumber" Text="Mobile Number" runat="server" 
                                                                meta:resourcekey="lbl_MobileNumberResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMobileNumber" runat="server" MaxLength="15" 
                                                                CssClass="medium" onKeyDown="return  isNumericss(event,this.id)"
                                                                Width="201px" meta:resourcekey="txtMobileNumberResource1"></asp:TextBox>
                                                            &nbsp;
                                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_FaxNo" Text="Fax No" runat="server" 
                                                                meta:resourcekey="lbl_FaxNoResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtFaxNumber" runat="server" MaxLength="20" 
                                                                CssClass="medium" onKeyDown="return  isNumericss(event,this.id)"
                                                                meta:resourcekey="txtFaxNumberResource1"></asp:TextBox>
                                                            &nbsp;
                                                            <%--<img src="../Images/starbutton.png" alt="" class="v-middle" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_Pan" Text="PAN" runat="server" 
                                                                meta:resourcekey="lbl_PanResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtPan" runat="server" MaxLength="15" CssClass="medium" 
                                                                meta:resourcekey="txtPanResource1"></asp:TextBox>
                                                            &nbsp;<%-- <img src="../Images/starbutton.png" alt="" class="v-middle" />--%>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_CSTNumber" Text="CST Number" runat="server" 
                                                                meta:resourcekey="lbl_CSTNumberResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCSTNumber" runat="server" MaxLength="20" CssClass="medium"
                                                                meta:resourcekey="txtCSTNumberResource1"></asp:TextBox>
                                                            &nbsp;
                                                            <%--<img src="../Images/starbutton.png" alt="" class="v-middle" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_DrugLicenceNo" Text="Drug Licence No" runat="server" 
                                                                meta:resourcekey="lbl_DrugLicenceNoResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDrugLicenceNo" runat="server" MaxLength="15" CssClass="medium"
                                                                meta:resourcekey="txtDrugLicenceNoResource1"></asp:TextBox>
                                                            &nbsp;
                                                            <%--<img src="../Images/starbutton.png" alt="" class="v-middle" />--%>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lbl_ServiceTaxNo" Text="ServiceTax No" runat="server" 
                                                                meta:resourcekey="lbl_ServiceTaxNoResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtServiceTaxNo" runat="server" MaxLength="20" CssClass="medium"
                                                                meta:resourcekey="txtServiceTaxNoResource1"></asp:TextBox>
                                                            &nbsp;<%-- <img src="../Images/starbutton.png" alt="" class="v-middle" />--%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lbl_CustomerType" Text="Customer Type" runat="server" 
                                                                meta:resourcekey="lbl_CustomerTypeResource1"></asp:Label>
                                                        </td>
                                                        <td>
                                                            <asp:DropDownList ID="ddlCustomerType" runat="server" Width="201px" 
                                                                meta:resourcekey="ddlCustomerTypeResource1">
                                                            </asp:DropDownList>
                                                            &nbsp;
                                                            <img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblTermsConditions" Text="Terms & Conditions" runat="server" 
                                                                meta:resourcekey="lblTermsConditionsResource1"></asp:Label>
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtTermsCondition" runat="server" MaxLength="100" TextMode="MultiLine"
                                                                CssClass="medium" meta:resourcekey="txtTermsConditionResource1"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td id="tdChkDelete" colspan="2" class="hide">
                                                            <asp:CheckBox ID="chkDelete" runat="server" Text="Delete Customer" 
                                                                meta:resourcekey="chkDeleteResource1" />
                                                            <asp:HiddenField ID="hdnCheckIsUsed" runat="server" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="h-10 a-left">
                                                            <div id="Div1" runat="server" class="show">
                                                                &nbsp;<img src="../Images/ShowBids.gif" alt="Show" class="w-15 h-15 a-top pointer"
                                                                    onclick="showResponses('Div1','Div2','divLocation',1);" />
                                                                <span class="dataheader1txt pointer" onclick="showResponses('Div1','Div2','divLocation',1);">
                                                                    <asp:Label ID="Label1" ForeColor="Black" Text="Add more Locations" Font-Underline="True"
                                                                        runat="server" meta:resourcekey="Label1Resource1"></asp:Label></span>
                                                            </div>
                                                            <div id="Div2" runat="server" class="hide">
                                                                &nbsp;<img src="../Images/HideBids.gif" alt="hide" class="w-15 h-15 a-top pointer" 
                                                                    onclick="showResponses('Div1','Div2','divLocation',0);" />
                                                                <span class="dataheader1txt pointer" onclick="showResponses('Div1','Div2','divLocation',0);">
                                                                    <asp:Label ID="Label2" ForeColor="Black" Text="Hide" Font-Underline="True" 
                                                                    runat="server" meta:resourcekey="Label2Resource1"></asp:Label></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4">
                                                            <div id="divLocation" runat="server">
                                                            <asp:Panel ID="tblPanel" CssClass="mytable1 gridView" runat="server" 
                                                                    meta:resourcekey="tblPanelResource1">
                                                                <table class="w-70p" runat="server">
                                                                    <tr runat="server">
                                                                        <td runat="server">
                                                                            <asp:Label ID="lblShippLocation" runat="server" Text="Shipping Location"></asp:Label>
                                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtShippLocation" runat="server" CssClass="medium" MaxLength="20"
                                                                                ></asp:TextBox>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />&nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
                                                                            <asp:Label ID="lblAddress1" runat="server" Text="Shipping Address"></asp:Label>
                                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtShippAddress" runat="server" CssClass="medium" MaxLength="100"
                                                                                TextMode="MultiLine"></asp:TextBox>
                                                                            &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                                                            &nbsp; &nbsp; &nbsp;
                                                                            <input type="button" id="btnAdd" class="btn w-45 h-20" value="Add"
                                                                                onclick="checkLocations();" />
                                                                            <asp:HiddenField ID="hdnLocationDetails" runat="server" />
                                                                            <asp:HiddenField ID="hdnCustomerLocations" runat="server" />
                                                                            <asp:HiddenField ID="hdnLocationID" runat="server" Value="0" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr runat="server">
                                                                        <td colspan="2" runat="server">
                                                                            <div>
                                                                                <table class="w-100p" id="tblCustomerDetail" border="1" runat="server">
                                                                                </table>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                </asp:Panel>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="4" class ="a-center">
                                                            <asp:Button ID="btnFinish" Text="Save" runat="server"
                                                                CssClass="btn" OnClientClick="javascript:return checkDetails();"
                                                                OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource1" />
                                                            &nbsp;
                                                            <asp:Button ID="btnCancel" runat="server" Text="Clear" CssClass="cancel-btn" 
                                                                OnClientClick="clearFields();" 
                                                                 meta:resourcekey="btnCancelResource1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table>
                                                </table>
                                                <table class="w-100p">
                                                    <tr>
                                                        <td class="colorforcontent h-23 a-left">
                                                            <div id="ACX2OPPmt" runat="server" class="show">
                                                                &nbsp;<img src="../Images/ShowBids.gif" alt="Show" class="w-15 h-15 a-top pointer"
                                                                    onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                                <span class="dataheader1txt pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                                    <asp:Label ID="lbl_CustomerSearch" Text="Customer Search" runat="server" 
                                                                    meta:resourcekey="lbl_CustomerSearchResource1"></asp:Label></span>
                                                            </div>
                                                            <div id="ACX2minusOPPmt" runat="server" class="hide">
                                                                &nbsp;<img src="../Images/HideBids.gif" alt="hide" class="w-15 h-15 a-top pointer"
                                                                    onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                                <span class="dataheader1txt pointer" onclick="showResponses('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                                    <asp:Label ID="lbl_CustomerSearch1" Text="Customer Search" runat="server" 
                                                                    meta:resourcekey="lbl_CustomerSearch1Resource1"></asp:Label></span>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr class="displaytr" id="ACX2responsesOPPmt" runat="server">
                                                        <td colspan="2" runat="server">
                                                            <table class="dataheader2 defaultfontcolor w-100p" cellpadding="4"
                                                                >
                                                                <tr runat="server">
                                                                    <td class="style1" runat="server">
                                                                        <asp:Label ID="lbl_CustomerName" Text="Customer Name" runat="server" 
                                                                            meta:resourcekey="lbl_CustomerNameResource1"></asp:Label>
                                                                    </td>
                                                                    <td runat="server">
                                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtSrchCustomerName" runat="server" MaxLength="20" 
                                                                            CssClass="medium" meta:resourcekey="txtSrchCustomerNameResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td runat="server">
                                                                        <asp:Label ID="lbl_TinNo1" Text="TinNo" runat="server" 
                                                                            meta:resourcekey="lbl_TinNo1Resource1"></asp:Label>
                                                                    </td>
                                                                    <td runat="server">
                                                                        <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtSrchTinNumber" runat="server" MaxLength="20" 
                                                                            CssClass="medium" meta:resourcekey="txtSrchTinNumberResource1"></asp:TextBox>
                                                                    </td>
                                                                    <td class ="a-center style1" runat="server">
                                                                        <asp:Button ID="btnSearch" runat="server" Text="Search"
                                                                            CssClass="btn" OnClick="btnSearch_Click" 
                                                                            meta:resourcekey="btnSearchResource1" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <table class="w-100p" id="excel" runat="server">
                                                <tr runat="server">
                                                    <td class="a-right hide" runat="server">
                                                        </b>
                                                        <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource1" />
                                                        <asp:LinkButton ID="btn_export" runat="server" Font-Bold="True" Text="Export to Excel"
                                                             CssClass="border2 font12" ForeColor="Black" 
                                                            Font-Underline="True" meta:resourcekey="btn_exportResource1" />
                                                        <%-- </td>
                                  <td align ="right">--%>
                                                        <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" ToolTip="Print"
                                                            Visible="False" meta:resourcekey="btnPrintResource1" />
                                                        <asp:LinkButton ID="PrintReport" Text="Print Report" runat="server" Font-Underline="True"
                                                            Font-Bold="True" CssClass="border2 font12" ForeColor="Black"
                                                            Visible="False" meta:resourcekey="PrintReportResource1"></asp:LinkButton>
                                                        &nbsp;&nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <div id="divPrintarea">
                                                <table class="w-100p">
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="grdCustomer" runat="server" wrap="wrap" AutoGenerateColumns="False"
                                                                CssClass="gridView w-100p" AllowPaging="True" 
                                                                OnRowDataBound="grdCustomer_RowDataBound" 
                                                                meta:resourcekey="grdCustomerResource1">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Select" 
                                                                        meta:resourcekey="TemplateFieldResource1">
                                                                        <ItemTemplate>
                                                                            <input id="rdSel" name="radio" value='<%# Eval("Address2") %>' onclick="SetValues(this)"
                                                                                type="radio" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="2%" Wrap="True" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="CustomerName" HeaderText="Customer Name" 
                                                                        meta:resourcekey="BoundFieldResource1">
                                                                        <ItemStyle Width="10%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="TINNo" HeaderText="Tin No" 
                                                                        meta:resourcekey="BoundFieldResource2">
                                                                        <ItemStyle Width="10%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" 
                                                                        meta:resourcekey="BoundFieldResource3" />
                                                                    <asp:BoundField DataField="Address1" HeaderText="Address" 
                                                                        meta:resourcekey="BoundFieldResource4">
                                                                        <ItemStyle Width="30%" Wrap="True" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Mobile" HeaderText="Phone" 
                                                                        meta:resourcekey="BoundFieldResource5">
                                                                        <ItemStyle Width="15%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="EmailID" HeaderText="EmailID" 
                                                                        meta:resourcekey="BoundFieldResource6">
                                                                        <ItemStyle Width="22%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="FaxNumber" HeaderText="Fax Number" 
                                                                        meta:resourcekey="BoundFieldResource7">
                                                                        <ItemStyle Width="20%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="PANNumber" HeaderText="PAN" 
                                                                        meta:resourcekey="BoundFieldResource8">
                                                                        <ItemStyle Width="20%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="CSTNo" HeaderText="CSTNo" 
                                                                        meta:resourcekey="BoundFieldResource9">
                                                                        <ItemStyle Width="20%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="DrugLicenceNo" HeaderText="DrugLicenceNo" 
                                                                        meta:resourcekey="BoundFieldResource10">
                                                                        <ItemStyle Width="20%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="ServiceTaxNo" HeaderText="ServiceTaxNo" 
                                                                        meta:resourcekey="BoundFieldResource11">
                                                                        <ItemStyle Width="20%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="TermsConditions" HeaderText="Terms&conditions" 
                                                                        meta:resourcekey="BoundFieldResource12">
                                                                        <ItemStyle Width="20%" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="IsDeleted" HeaderText="Active Status" 
                                                                        meta:resourcekey="BoundFieldResource13">
                                                                        <ItemStyle Width="2%" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <PagerStyle CssClass="gridPager" HorizontalAlign="Center" />
                                                                <HeaderStyle CssClass="gridHeader" />
                                                            </asp:GridView>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </contenttemplate>
            <triggers>
                                <asp:PostBackTrigger ControlID="imgBtnXL" />
                                <asp:PostBackTrigger ControlID="btn_export" />
                            </triggers>
        </asp:UpdatePanel>
    </div>
    <attune:attunefooter id="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnMessages" runat="server" />
    <asp:HiddenField ID="hdnStatus" runat="server" />
    </form>
</body>
</html>
<script language="javascript" type="text/javascript">
		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
    </script>