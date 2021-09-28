<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Suppliers.aspx.cs" Inherits="Inventory_Suppliers"
    meta:resourcekey="PageResource1" EnableEventValidation="false" %>

<%--
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>--%>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="~/PlatFormControls/Audit_History.ascx" TagName="Audit_History" TagPrefix="adh1" %>
<%--<%@ Register Src="~/PlatFormControls/PatientAddress.ascx" TagName="PatientAddress"
    TagPrefix="uc12" %>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Suppliers</title>
    <%--  <style>
       .breakword{word-wrap: break-word;word-break: break-all;}
    </style>--%>
    <%--<link href="../PlatForm/StyleSheets/style.css" rel="stylesheet" type="text/css" />--%>

    <script language="javascript" type="text/javascript">

        function ShowAlertMsg(key) {

            var userMsg = SListForApplicationMessages.Get(key);
            if (userMsg != null) {
                alert(userMsg);
                return false;
            } else {
                alert('No matching record found');
                return false;
            }
            return true;
        }
        var EditorInstance = "";
        var userMsg;
        function checkDetails() {
            var errorMsg = SListForAppMsg.Get("InventoryMaster_Error");

            //  var Fin = document.getElementById('btnFinish').value;
            if (document.getElementById('txtSupplierName').value == '') {
                userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_02") == null ? "Provide supplier name" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_02");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtSupplierName').focus();
                return false;
            }
            /*if (document.getElementById('txtTinNo').value == '' && document.getElementById('hdnTinMandatory').value == "N") {
                userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_03") == null ? "Provide TIN number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_03");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtTinNo').focus();
                return false;
            }*/
            //Vijayaraja
            if (document.getElementById('txtGSTinNo').value == '' && document.getElementById('hdnTinMandatory').value == "N") {
                userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_033") == null ? "Provide GSTIN number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_033");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtGSTinNo').focus();
                return false;
            }
            //End
            if ($('#hdnrspadsupllierconfig').val() != 'Y') {
                if ($('#hdnMandFieldDisable').val() == "Y") {
                    if (document.getElementById('txtContactPerson').value == '') {
                        var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_04") == null ? "Provide contact person" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_04");
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtContactPerson').focus();
                        return false;
                    }
                }
            }

            //            if ((document.getElementById('txtPhoneNumber').value == '') && (document.getElementById('txtMobileNumber').value == '')) {
            //                if ($('#hdnMandFieldDisable').val() == "Y") {
            //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_05") == null ? "Provide contact number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_05");
            //                ValidationWindow(userMsg, errorMsg);
            //                document.getElementById('txtPhoneNumber').focus();
            //                return false;
            //                }
            //            }
            if (!fnValidatePatAddress('ucPAdd')) {
                return false;
            }
            if (!$('#chkAddrSame').prop('checked')) {
                if (!fnValidatePatAddress('ucCAdd')) {
                    return false;
                }
            }

            EditorInstance = "";

        }
        function pageLoad() {
            if ($('#txtSupplierName').val() != null && $('#txtSupplierName').val() != "") {
                document.getElementById('txtSupplierName').focus();
            }
        }

        function checkMailId() {
            var emailID = document.getElementById('txtEmailID').value;
            if (emailID != "") {
                var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                var Mail = re.test(emailID);
                if (Mail == false) {
                    var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
                    ValidationWindow(userMsg, errorMsg);
                    $('#txtEmailID').val("");
                    $('#txtEmailID').focus();
                    return false;
                }
                else {
                    return true;
                }
            }
        }
        //            var emailID = document.getElementById('txtEmailID')
        //            if ((emailID.value == null) || (emailID.value.trim() != "")) {
        //                if (!checkemail($.trim($('#txtEmailID').val()))) {
        //                    $('#txtEmailID').focus();
        //                    var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                    ValidationWindow(userMsg, errorMsg);
        //                    $('#txtEmailID').val('');
        //                    return false;
        //                }
        //            }
        //        }
        //        function echeck1(str) {

        //            var at = "@";
        //            var dot = ".";
        //            var lat = str.indexOf(at);
        //            var lstr = str.length;
        //            var ldot = str.indexOf(dot);
        //            if (str.indexOf(at) == -1) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }

        //            if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }

        //            if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }

        //            if (str.indexOf(at, (lat + 1)) != -1) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }

        //            if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }

        //            if (str.indexOf(dot, (lat + 2)) == -1) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }

        //            if (str.indexOf(" ") != -1) {
        //                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06") == null ? "Invalid e-mail ID" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_06");
        //                ValidationWindow(userMsg, errorMsg);
        //                return false;
        //            }
        //        }
        function SetValues(obj) {
            $('#divLoadingGif').show();
            var x = $(obj).val().split('~');
            document.getElementById('hdnCheckIsUsed').value = x[12];
            document.getElementById('hdnId').value = x[0];
            document.getElementById('txtSupplierName').value = x[1];
            document.getElementById('txtContactPerson').value = x[2];
            document.getElementById('txtAddress1').value = x[3];
            document.getElementById('txtAddress2').value = x[4];
            document.getElementById('txtCity').value = x[5];
            document.getElementById('txtEmailID').value = x[6];
            document.getElementById('txtPhoneNumber').value = x[7];
            document.getElementById('txtMobileNumber').value = x[8];
            var update = SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_01') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_01');
            document.getElementById('btnFinish').value = update;
            document.getElementById('lblmsg').innerText = '';
            document.getElementById('hdnStatus').value = 'Update';
            //document.getElementById('txtTinNo').value = x[9];
            document.getElementById('txtGSTINNo').value = x[9];//Vijayaraja
            document.getElementById('txtFaxNumber').value = x[10];
            //document.getElementById('tdChkDelete').style.display = 'block';
            $('#tdChkDelete').removeClass().addClass('show');
            document.getElementById('chkDelete').checked = x[11] == 'N' ? false : true;
            document.getElementById('txtCstNo').value = x[14];
            document.getElementById('txtDrugLicenceNo').value = x[15];
            document.getElementById('txtServiceTaxNo').value = x[17];
            document.getElementById('txtPanNo').value = x[16];
            document.getElementById('txtDrugLicenceNo1').value = x[18];
            document.getElementById('txtDrugLicenceNo2').value = x[19];
            document.getElementById('txtSupplierCode').value = x[20];
            document.getElementById('txtPin').value = x[21];
            //document.getElementById('txtTermsConditions').value=x[13];
            /* if (typeof (FCKeditorAPI) != "undefined") {
                 var editor = document.getElementById('fckInvDetailss').id;
                 //var editor = FCKeditorAPI.GetInstance('fckInvDetailss.ClientID');
                 var EditorInstance1 = FCKeditorAPI.GetInstance(editor);
                 if (EditorInstance1 != undefined) {
                     EditorInstance1.SetHTML(x[13]);
                 }
             }*/
            var frame = document.getElementById("fckInvDetailss_designEditor");
            frameDoc = frame.contentDocument || frame.contentWindow.document;
            frameDoc.documentElement.innerHTML = x[13];
            var select = SListForAppDisplay.Get('InventoryMaster_Products_aspx_16') == null ? "-Select-" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_16');
            $('#ucPAdd_ddState').val(-1);
            $('#ucPAdd_ddlCity').val(-1);
            $('#ucPAdd_ddCountry').val(select);
            $('#ucPAdd_ddlDistricts').val(-1);
            $('#ucPAdd_ddllocalities').val(-1);
            if ($('#hdnId').val() != '') {
                GetSupplierAddress($('#hdnId').val());
            }
            $('#divLoadingGif').hide();
        }

        function GetSupplierAddress(id) {
            if (id != '') {
                $.ajax({
                    type: "POST",
                    url: "../InventoryMaster/Webservice/InventoryMaster.asmx/GetSupplierAddress",
                    data: "{ 'SupplierID': '" + id + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: true,
                    success: function (data) {
                        var Items = data.d;
                        if (Items != '') {
                            BindSupplierAddress(Items);
                        }
                    },
                    failure: function (msg) {
                        //alert('error');
                    }
                });
            }


        }

        function BindSupplierAddress(Items) {
            if (Items[0].AddressType == "C") {
               // bindCommercialAddress(Items[0]);
                bindPermanetAddress(Items[1]);
            }
            else {
                //bindCommercialAddress(Items[1]);
                bindPermanetAddress(Items[0]);
            }
            //SetUIAlign();
        }


        function bindPermanetAddress(list) {

            //            $('#ucPAdd_txtAddress2').val(list.Add1);
            //            $('#ucPAdd_txtAddress1').val(list.Add2);
            //            $('#ucPAdd_txtAddress3').val(list.Add3);
            //            $('#ucPAdd_txtPostalCode').val(list.PostalCode);
            //            $('#ucPAdd_txtMobile').val(list.MobileNumber);
            //            $('#ucPAdd_txtLandLine').val(list.LandLineNumber);


            //            $('#ucPAdd_ddCountry').val(list.CountryCode);
            //            if (list.StateCode != '') {
            //                $('#ucPAdd_hdnAddressState').val(list.StateCode);
            //                loadState('ucPAdd_ddCountry', list.StateCode);
            //            }
            //            if (list.StateCode != '') {
            //                $('#ucPAdd_hdnCityID').val(list.CityCode);
            //                loadCity('ucPAdd_ddState', list.CityCode, list.StateCode);
            //            }
            //            if (list.CityCode != '') {
            //                loadDis('ucPAdd_ddlCity', list.AddLevel1, list.CityCode);
            //            }
            //            if (list.AddLevel1 != '') {
            //                loaLocality('ucPAdd_ddlDistricts', list.AddLevel2, list.AddLevel1);
            //            }

            fnSetAddress(list.Add1, list.Add2, list.Add3, list.CountryID, list.StateID, list.CityCode, list.AddLevel1, list.AddLevel2, list.PostalCode, list.MobileNumber, list.LandLineNumber, 'ucPAdd');
            $('#chkAddrSame').prop('checked', true);
            //$('#divCAD').show();
            $('#divCAD').removeClass().addClass('hide');
        }

        function bindCommercialAddress(list) {
            fnSetAddress(list.Add1, list.Add2, list.Add3, list.CountryID, list.StateID, list.CityCode, list.AddLevel1, list.AddLevel2, list.PostalCode, list.MobileNumber, list.LandLineNumber, 'ucCAdd');
            //            debugger;
            //            $('#ucCAdd_txtAddress2').val(list.Add1);
            //            $('#ucCAdd_txtAddress1').val(list.Add2);
            //            $('#ucCAdd_txtAddress3').val(list.Add3);
            //            $('#ucCAdd_txtPostalCode').val(list.PostalCode);
            //            $('#ucCAdd_txtMobile').val(list.MobileNumber);
            //            $('#ucCAdd_txtLandLine').val(list.LandLineNumber);

            //            $('#ucCAdd_ddCountry').val(list.CountryCode);
            //            if (list.StateCode != '') {
            //                $('#ucCAdd_hdnAddressState').val(list.StateCode);
            //                loadState('ucCAdd_ddCountry', list.StateCode);
            //            }
            //            if (list.StateCode != '') {
            //                $('#ucCAdd_hdnCityID').val(list.CityCode);
            //                loadCity('ucCAdd_ddState', list.CityCode, list.StateCode);
            //            }
            //            if (list.CityCode != '') {
            //                loadDis('ucCAdd_ddlCity', list.AddLevel1, list.CityCode);
            //            }
            //            if (list.AddLevel1 != '') {
            //                loadDis('ucCAdd_ddlDistricts', list.AddLevel2, list.AddLevel1);
            //            }
        }



        function FnClear() {
            var select = SListForAppDisplay.Get('InventoryMaster_Products_aspx_16') == null ? "-Select-" : SListForAppDisplay.Get('InventoryMaster_Products_aspx_16');
            var Save = SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_02') == null ? "Save" : SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_02');
            document.getElementById('hdnId').value = 0;
            document.getElementById('txtSupplierName').value = '';
            document.getElementById('txtContactPerson').value = '';
            document.getElementById('txtAddress1').value = '';
            document.getElementById('txtAddress2').value = '';
            document.getElementById('txtCity').value = '';
            document.getElementById('txtEmailID').value = '';
            document.getElementById('txtPhoneNumber').value = '';
            document.getElementById('txtTinNo').value = '';
            document.getElementById('txtGSTINNo').value = '';//Vijayaraja
            document.getElementById('txtMobileNumber').value = '';
            document.getElementById('txtFaxNumber').value = '';
            document.getElementById('btnFinish').value = Save;
            document.getElementById('lblmsg').innerText = '';
            //document.getElementById('tdChkDelete').style.display = 'none';
            $('#tdChkDelete').removeClass().addClass('hide');
            document.getElementById('txtCstNo').value = '';
            document.getElementById('txtDrugLicenceNo').value = '';
            document.getElementById('txtDrugLicenceNo1').value = '';
            document.getElementById('txtDrugLicenceNo2').value = '';
            document.getElementById('txtPanNo').value = '';
            document.getElementById('txtServiceTaxNo').value = '';
            document.getElementById('txtSupplierCode').value = '';
            document.getElementById('txtPin').value = '';
            if ($('#ucPAdd_txtAddress2').val() != undefined) {
                document.getElementById('ucPAdd_txtAddress2').value = '';
            }
            if ($('#ucCAdd_txtAddress1').val() != undefined) {
                document.getElementById('ucCAdd_txtAddress1').value = '';
            }
            if ($('#ucCAdd_txtMobile').val() != undefined) {
                document.getElementById('ucCAdd_txtMobile').value = '';
            }
            document.getElementById('ucPAdd_txtAddress1').value = '';
            document.getElementById('ucPAdd_txtMobile').value = '';
            document.getElementById('ucPAdd_txtLandLine').value = '';
            document.getElementById('ucCAdd_txtLandLine').value = '';
            document.getElementById('ucPAdd_txtPostalCode').value = '';
            if ($('#ucPAdd_txtAddress3').val() != undefined) {
                document.getElementById('ucPAdd_txtAddress3').value = '';
            }
            // document.getElementById('ucPAdd_ddState').options[document.getElementById('ucPAdd_ddState').selectedIndex].text = select;
            //document.getElementById('ucPAdd_ddCountry').options[document.getElementById('ucPAdd_ddCountry').selectedIndex].text = select;
            document.getElementById('ucPAdd_ddlCity').options[document.getElementById('ucPAdd_ddlCity').selectedIndex].text = select;
            document.getElementById('ucCAdd_ddlCity').options[document.getElementById('ucCAdd_ddlCity').selectedIndex].text = select;
            document.getElementById('ucPAdd_ddlDistricts').options[document.getElementById('ucPAdd_ddlDistricts').selectedIndex].text = select;
            document.getElementById('ucCAdd_ddlDistricts').options[document.getElementById('ucCAdd_ddlDistricts').selectedIndex].text = select;
            //document.getElementById('txtTermsConditions').value = '';
            if (typeof (FCKeditorAPI) != "undefined") {
                var fckname = document.getElementById('fckInvDetailss').id;
                var fckeditor = FCKeditorAPI.GetInstance(fckname);
                fckeditor.EditorDocument.body.innerHTML = '';
            }
            document.getElementById('hdnStatus').value = Save;
            document.getElementById('chkDelete').checked = false;
            return false;
        }
        /*Sathish-All Org MobNo. Validation*/
        function MobNoValidation() {
            try {
                if ($('#hdnPhLength').val() != "" && $('#txtMobileNumber').val() != "") {
                    var MobLen = $('#hdnPhLength').val();
                    var MobMaxLen = $('#txtMobileNumber').val().length;
                    if (MobLen != MobMaxLen) {
                        //var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14") == null ? "Provide a valid '" + MobLen + "' digit mobile number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14");

                        var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14") == null ? "Provide a valid {0} digit mobile number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14");
                        userMsg = userMsg.replace('{0}', MobLen);
                        ValidationWindow(userMsg, errorMsg);
                        $('#txtMobileNumber').val('');
                        $('#txtMobileNumber').focus();
                        return false;
                    }
                }
            }
            catch (Error) {
                alert(Error);
            }
        }
        /*function checkSUPMobileNumber() {
        var MobLen = $('#hdnPhLength').val();
            var cmn = document.getElementById('txtMobileNumber').value;
            if (document.getElementById('txtMobileNumber').value != '') {
                if ($('#hdnMobLenValidation').val() == "Y") {
                    if (MobLen != 9) {
                        var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14") == null ? "Provide a valid 10 digit mobile number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14");
                        ValidationWindow(userMsg, errorMsg);
                        document.getElementById('txtMobileNumber').value = '';
                        document.getElementById('txtMobileNumber').focus();
                        return false;
                    }
                }
                else if (cmn.length < 10) {
                    var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14") == null ? "Provide a valid 10 digit mobile number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_14");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtMobileNumber').value = '';
                    document.getElementById('txtMobileNumber').focus();
                    return false;
                }
                else {

                }
                else if ((cmn.substr(0, 1) != "9") && (cmn.substr(0, 1) != "8")) {
                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_15") == null ? "Provide valid mobile number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_15");
                ValidationWindow(userMsg, errorMsg);
                document.getElementById('txtMobileNumber').value = '';
                document.getElementById('txtMobileNumber').focus();
                return false;
                }

            }
        }*/

        function checkSUPLandLineNumber() {

            var clln = document.getElementById('txtPhoneNumber').value;

            if (document.getElementById('txtPhoneNumber').value != '') {
                if (clln.length < 6) {
                    var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_16") == null ? "Provide valid landline number" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_16");
                    ValidationWindow(userMsg, errorMsg);
                    document.getElementById('txtPhoneNumber').value = '';
                    document.getElementById('txtPhoneNumber').focus();
                    return false;
                }
                else {

                }
            }
            else {

            }

        }

        function CallPrint() {
            var prtContent = document.getElementById('divSupplierPrintarea');
            var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();
            return false;





        }
        function checkDelete(Id) {

            var x = document.getElementById('hdnCheckIsUsed').value;
            var Save = SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_02') == null ? "Save" : SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_02');
            var Delete = SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_03') == null ? "Delete" : SListForAppDisplay.Get('InventoryMaster_Suppliers_aspx_03');
            if (x == 'N') {
                if (document.getElementById(Id).checked == true) {
                    document.getElementById('btnFinish').value = Delete;
                    document.getElementById('hdnStatus').value = 'Delete';
                    document.getElementById('txtSupplierName').disabled = true;
                    document.getElementById('txtContactPerson').disabled = true;
                    document.getElementById('txtAddress1').disabled = true;
                    document.getElementById('txtAddress2').disabled = true;
                    document.getElementById('txtCity').disabled = true;
                    document.getElementById('txtEmailID').disabled = true;
                    document.getElementById('txtPhoneNumber').disabled = true;
                    document.getElementById('txtMobileNumber').disabled = true;
                    document.getElementById('txtTinNo').disabled = true;
                    document.getElementById('txtGSTINNo').disabled = true;//vijayaraja
                    document.getElementById('txtFaxNumber').disabled = true;
                    document.getElementById('txtCstNo').disabled = true;
                    document.getElementById('txtDrugLicenceNo').disabled = true;
                    document.getElementById('txtPanNo').disabled = true;
                    document.getElementById('txtServiceTaxNo').disabled = true;
                    document.getElementById('txtDrugLicenceNo1').disabled = true;
                    document.getElementById('txtDrugLicenceNo2').disabled = true;
                    document.getElementById('txtSupplierCode').disabled = true;
                    document.getElementById('txtPin').disabled = true;


                }
                if (document.getElementById(Id).checked == false) {
                    document.getElementById('btnFinish').value = Save;

                    document.getElementById('txtSupplierName').disabled = false;
                    document.getElementById('txtContactPerson').disabled = false;
                    document.getElementById('txtAddress1').disabled = false;
                    document.getElementById('txtAddress2').disabled = false;
                    document.getElementById('txtCity').disabled = false
                    document.getElementById('txtEmailID').disabled = false;
                    document.getElementById('txtPhoneNumber').disabled = false;
                    document.getElementById('txtMobileNumber').disabled = false;
                    document.getElementById('txtTinNo').disabled = false;
                    document.getElementById('txtGSTINNo').disabled = false;//Vijayaraja
                    document.getElementById('txtFaxNumber').disabled = false;
                    document.getElementById('txtCstNo').disabled = false;
                    document.getElementById('txtDrugLicenceNo').disabled = false;
                    document.getElementById('txtPanNo').disabled = false;
                    document.getElementById('txtServiceTaxNo').disabled = false;
                    document.getElementById('txtDrugLicenceNo1').disabled = false;
                    document.getElementById('txtDrugLicenceNo2').disabled = false;
                    document.getElementById('txtSupplierCode').disabled = false;
                    document.getElementById('txtPin').disabled = false;

                }
            }
            if (x == 'Y') {
                var userMsg = SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_17") == null ? "Supplier name is in use; cannot be deleted" : SListForAppMsg.Get("InventoryMaster_Suppliers_aspx_17");
                ValidationWindow(userMsg, SListForAppMsg.Get("InventoryMaster_Error"));
                document.getElementById('chkDelete').checked = false;
                return false;
            }
        }
        function onlyNumbers(e, Id) {
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


        function isNumericNew(keyCode) {
            return ((keyCode >= 48 && keyCode <= 57) || keyCode == 8 || keyCode == 9 ||
                (keyCode >= 96 && keyCode <= 105))
        }
    </script>

    <%--<style type="text/css">
        /*#ucPAdd_Col1 {width: 17.5% !important;}
        #ucPAdd_Col2 {width: 29.5%;}
        #ucPAdd_Col3 {width: 19%;}
        #ucPAdd_Col4 {width: 32%;}*/

        .style1_SM
        {
            width: 80px;
            height: 48px;
        }
        .style2_SM
        {
            width: 25.8%;
            height: 48px;
        }
        .style3_SM
        {
            width: 38%;
            height: 48px;
        }
        .divTable
        {
            width: 100%;
            display: block;
            height: 450px;
            overflow: auto;
        }
        .divRow
        {
            clear: left;
            float: left;
            width: 99%;
        }
        .divColumn
        {
            float: left;
            display: inline;
            width: 30%;
            padding-bottom: 15px;
            border-right: solid 1px black;
            border-left: solid 1px black;
        }
</style>--%>
</head>
<body onload="pageLoad();" oncontextmenu="return false;">
    <form id="prFrm" runat="server" defaultbutton="btnFinish">
        <asp:HiddenField ID="hdnButtonText" runat="server" meta:resourcekey="hdnButtonText1" />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
        <script language="javascript" type="text/javascript">
            var errorMsg;
            var Information;
            var OkMsg;
            var CancelMsg;
            $(document).ready(function () {
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
                var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
                var OkMsg = SListForAppMsg.Get('InventoryMaster_Ok') == null ? "Ok" : SListForAppMsg.Get('InventoryMaster_Ok');
                var CancelMsg = SListForAppMsg.Get('InventoryMaster_Cancel') == null ? "Cancel" : SListForAppMsg.Get('InventoryMaster_Cancel');
            });
        </script>
        <div class="contentdata">
            <asp:UpdatePanel ID="UpdatePanel" runat="server">
                <ContentTemplate>
                    <table class="w-100p">
                        <tr>
                            <td>
                                <div>
                                    <table class="w-100p searchPanel">
                                        <tr class="panelHeader">
                                            <td class="a-left">
                                                <div class="hide" id="ACX2OPPmt" runat="server">
                                                    <img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="v-top h-18 pointer" onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);" />
                                                    <span class="dataheader1txt pointer" onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',1);">
                                                        <asp:Label ID="Rs_SupplierSearch" Text="Supplier Search" runat="server" meta:resourcekey="Rs_SupplierSearchResource1"></asp:Label></span>
                                                </div>
                                                <div id="ACX2minusOPPmt" runat="server">
                                                    <img src="../PlatForm/Images/HideBids.gif" alt="hide" class="v-top h-18 pointer" onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);" />
                                                    <span class="dataheader1txt pointer" onclick="showResponsesRow('ACX2OPPmt','ACX2minusOPPmt','ACX2responsesOPPmt',0);">
                                                        <asp:Label ID="Rs_SupplierSearch1" Text="Supplier Search" runat="server" meta:resourcekey="Rs_SupplierSearch1Resource1"></asp:Label></span>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr id="ACX2responsesOPPmt" runat="server">
                                            <td id="Td1" colspan="2" runat="server">
                                                <table class="w-100p">
                                                    <tr id="Tr1" runat="server">
                                                        <td id="Td2" runat="server" class="w-11p">
                                                            <asp:Label ID="Rs_SupplierName" meta:resourcekey="Rs_SupplierNameRK1" Text="Supplier Name"
                                                                runat="server"></asp:Label>
                                                        </td>
                                                        <td id="Td3" runat="server" class="w-25p">
                                                            <asp:TextBox  ID="txtSupplierNameSrch" runat="server" MaxLength="20" CssClass="medium"></asp:TextBox>
                                                        </td>
                                                        <td id="Td4" runat="server" class="w-10p">
                                                            <%--<asp:Label ID="Rs_TinNo1" Text="TIN" meta:resourcekey="Rs_TinNo1RK1" runat="server"></asp:Label>--%>
                                                            <asp:Label ID="Rs_TinNo1" Text="GSTIN" meta:resourcekey="Rs_GSTinNo1RK1" runat="server"></asp:Label>
                                                        </td>
                                                        <td id="Td5" runat="server" class="w-22p">
                                                            <asp:TextBox OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this)" ID="txtTinNumberSrch" runat="server" MaxLength="20" CssClass="medium"></asp:TextBox>
                                                        </td>
                                                        <td id="Td6" class="a-left" runat="server">
                                                            <asp:Button ID="btnSearch" runat="server" Text="Search" meta:resourcekey="btnSearchRK1"
                                                                CssClass="btn" OnClick="btnSearch_Click1" />
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table class="w-100p" id="excel" runat="server">
                                                    <tr id="Tr2" runat="server">
                                                        <td id="Td7" class="a-right" runat="server"></b>
                                                        <asp:ImageButton ID="imgBtnXL" OnClick="btn_export_Click" runat="server" ImageUrl="../PlatForm/Images/ExcelImage.GIF"
                                                            ToolTip="Save As Excel" meta:resourcekey="imgbtnsaveRK1" />
                                                            <%-- <asp:LinkButton ID="btn_export" runat="server" Text="Export to Excel" meta:resourcekey="linkbtnexportRK1"
                                                            OnClick="btn_export_Click" CssClass="underline" />--%>
                                                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/PlatForm/Images/printer.gif" OnClientClick="return CallPrint();"
                                                                ToolTip="Print" meta:resourcekey="btnprintRK1" Visible="False" />
                                                            <asp:LinkButton ID="PrintReport" Text="Print Report" meta:resourcekey="lnkbtnprntreportRK1"
                                                                runat="server" OnClientClick="return CallPrint();" CssClass="underline" OnClick="PrintReport_Click"
                                                                Visible="False"></asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div id="divSupplierPrintarea">
                                                    <table id="tblSupplierContainer" runat="server" class="hide">
                                                        <tr>
                                                            <td>
                                                                <asp:GridView ID="gvSupplier" runat="server" wrap="wrap" AutoGenerateColumns="False"
                                                                    CssClass="gridView w-100p" class="w-100p" AllowPaging="True" OnPageIndexChanging="gvSupplier_PageIndexChanging"
                                                                    DataKeyNames="SupplierID" OnRowCommand="gvSupplier_RowCommand" meta:resourcekey="gvSupplierResource2"
                                                                    OnRowDataBound="gvSupplier_RowDataBound">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Select" meta:resourcekey="TemplateFieldResource3">
                                                                            <ItemTemplate>
                                                                                <input id="rdSel" name="radio" value="<%# Eval("Address2") %>" onclick="SetValues(this)"
                                                                                    type="radio" />
                                                                                <asp:HiddenField ID="hdnStateCode" runat="server" Value='<%#Eval("StateCode") %>' />
                                                                                <asp:HiddenField ID="hdnCountryCode" runat="server" Value='<%#Eval("CountryCode") %>' />
                                                                            </ItemTemplate>
                                                                            <ItemStyle Wrap="True" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="SupplierName" HeaderText="Supplier Name" meta:resourcekey="BoundFieldResource133"></asp:BoundField>
                                                                        <asp:BoundField DataField="SupplierCode" HeaderText="Vendor Code" meta:resourcekey="BoundFieldResource134"></asp:BoundField>
                                                                        <asp:BoundField DataField="PIN" HeaderText="PIN" meta:resourcekey="BoundFieldResource135"></asp:BoundField>
                                                                        <asp:BoundField DataField="GSTIN" HeaderText="GSTIN No" meta:resourcekey="BoundFieldResource114"></asp:BoundField>
                                                                        <%--<asp:BoundField DataField="TinNo" ControlStyle-CssClass="hide" HeaderText="Tin No" meta:resourcekey="BoundFieldResource14"></asp:BoundField>--%>
                                                                        <asp:BoundField DataField="CstNo" HeaderText="Cst No" meta:resourcekey="BoundFieldResource15"></asp:BoundField>
                                                                        <asp:BoundField DataField="PanNo" HeaderText="PAN No" meta:resourcekey="BoundFieldResource16"></asp:BoundField>
                                                                        <asp:BoundField DataField="DrugLicenceNo" HeaderText="DrugLicence No" meta:resourcekey="BoundFieldResource17"></asp:BoundField>
                                                                        <asp:BoundField DataField="ServiceTaxNo" HeaderText="ServiceTax No" meta:resourcekey="BoundFieldResource18"></asp:BoundField>
                                                                        <asp:BoundField DataField="ContactPerson" HeaderText="Contact Person" meta:resourcekey="BoundFieldResource19" HeaderStyle-CssClass="w-8p breakword" ItemStyle-CssClass="w-7p breakword" />
                                                                        <asp:BoundField DataField="Address1" HeaderText="Address" meta:resourcekey="BoundFieldResource20" HeaderStyle-CssClass="w-12p breakword" ItemStyle-CssClass="w-10p breakword">
                                                                            <ItemStyle Wrap="True" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Mobile" HeaderText="Phone" meta:resourcekey="BoundFieldResource21" HeaderStyle-CssClass="w-10p breakword" ItemStyle-CssClass="w-9p breakword"></asp:BoundField>
                                                                        <asp:BoundField DataField="EmailID" HeaderText="Email ID" meta:resourcekey="BoundFieldResource22"></asp:BoundField>
                                                                        <asp:BoundField DataField="FaxNumber" HeaderText="Fax Number" meta:resourcekey="BoundFieldResource23"></asp:BoundField>
                                                                        <asp:BoundField DataField="IsDeleted" HeaderText="Active Status" meta:resourcekey="BoundFieldResource24"></asp:BoundField>
                                                                        <asp:TemplateField HeaderText="History" meta:resourcekey="TemplateFieldResource4">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="btnHistory" runat="server" Text="H" CssClass="ui-icon ui-icon-info pointer"
                                                                                    CommandArgument='<%# Container.DataItemIndex %>' CommandName="History" meta:resourcekey="btnHistoryResource2" />
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <PagerStyle CssClass="gridPager a-center" />
                                                                    <HeaderStyle CssClass="gridHeader" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr class="panelContent">
                                            <td></td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="DivEditWindow" runat="server" ScrollBars="Both" CssClass="modalPopup DivEditWindowCss dataheaderPopup w-100p" meta:resourcekey="DivEditWindowResource1">
                                        <%--<div id="DivEditWindow" runat="server" class="scroll w-100p">--%>
                                        <table id="Table1" runat="server" class="w-100p">
                                            <tr id="Tr3" runat="server">
                                                <td id="Td8" runat="server">
                                                    <div class="w-100p DivEditTblHgt">
                                                        <adh1:Audit_History ID="audit_History" runat="server" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr id="Tr4" runat="server">
                                                <td id="Td9" class="a-center" runat="server">
                                                    <asp:Button ID="btnOk" runat="server" Text="OK" meta:resourcekey="btnOK_RK1" CssClass="btn marginT20" />
                                                </td>
                                            </tr>
                                        </table>
                                        <%--</div>--%>
                                    </asp:Panel>
                                    <ajc:ModalPopupExtender ID="ModelPopSupplierSearch" runat="server" TargetControlID="btnR"
                                        PopupControlID="DivEditWindow" BackgroundCssClass="modalBackground" CancelControlID="btnOk"
                                        DynamicServicePath="" Enabled="True" />
                                    <input type="button" id="btnR" runat="server" class="hide" />
                                    <table class="searchPanel w-100p">
                                        <tr>
                                            <td colspan="6" class="a-center">
                                                <asp:Label ID="lblmsg" runat="server" meta:resourcekey="lblmsgResource2"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <asp:HiddenField ID="hdnId" Value="0" runat="server" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="w-11p">
                                                <asp:Label ID="Rs_Supplier" Text="Supplier Name" runat="server" meta:resourcekey="Rs_SupplierResource1"></asp:Label>
                                            </td>
                                            <td class="w-25p">
                                                <asp:TextBox  ID="txtSupplierName" runat="server" MaxLength="200" CssClass="medium"
                                                    meta:resourcekey="txtSupplierNameResource2"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td class="w-10p hide">
                                                <asp:Label ID="Rs_TinNo" Text="TIN No" runat="server" meta:resourcekey="Rs_TinNoResource2"></asp:Label>
                                            </td>
                                            <td class="w-22p hide">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this)" ID="txtTinNo" runat="server" MaxLength="50" CssClass="medium" meta:resourcekey="txtTinNoResource2"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" id="tinMandatory" runat="server" />
                                            </td>
                                            <td class="w-10p">
                                                <asp:Label ID="Label1" Text="GSTIN No" runat="server" meta:resourcekey="Rs_GSTinNoResource2"></asp:Label>
                                            </td>
                                            <td class="w-22p">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this)" ID="txtGSTINNo" runat="server" MaxLength="25" CssClass="medium" meta:resourcekey="txtGSTinNoResource2"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" id="Img1" runat="server" />
                                            </td>
                                            <td id="tdlblCstNo" class="w-9p" runat="server">
                                                <asp:Label ID="lblCstNo" Text="CST No" runat="server" meta:resourcekey="lblCstNoResource2"></asp:Label>
                                            </td>
                                            <td id="tdtxtCstNo" runat="server">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCstNo" runat="server" MaxLength="50" CssClass="medium" meta:resourcekey="txtCstNoResource2"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblDrugLicenceNo" Text="Drug Licence No" runat="server" meta:resourcekey="lblDrugLicenceNoResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDrugLicenceNo" runat="server" MaxLength="50" CssClass="medium"
                                                    meta:resourcekey="txtTinNoResource2"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDrugLicenceNo1" Text="Drug Licence No1" runat="server" meta:resourcekey="lblDrugLicenceNo1Resource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDrugLicenceNo1" runat="server" MaxLength="50" CssClass="medium"
                                                    meta:resourcekey="txtDrugLicenceNo1Resource2"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblDrugLicenceNo2" Text="Drug Licence No2" runat="server" meta:resourcekey="lblDrugLicenceNo2Resource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtDrugLicenceNo2" runat="server" MaxLength="50" CssClass="medium"
                                                    meta:resourcekey="txtTinNoResource2"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdlblServiceTaxNo" runat="server">
                                                <asp:Label ID="lblServiceTaxNo" Text="ServiceTax No" runat="server" meta:resourcekey="lblServiceTaxNoResource2"></asp:Label>
                                            </td>
                                            <td id="tdtxtServiceTaxNo" runat="server">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtServiceTaxNo" runat="server" MaxLength="50" CssClass="medium"
                                                    meta:resourcekey="txtServiceTaxNoResource2"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPanNo" Text="PAN" runat="server" meta:resourcekey="lblPanNoResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtPanNo" runat="server" MaxLength="50" CssClass="medium" meta:resourcekey="txtPanNoResource2"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_ContactPerson" Text="Contact Person" runat="server" meta:resourcekey="Rs_ContactPersonResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtContactPerson" runat="server" MaxLength="50"
                                                    CssClass="medium" meta:resourcekey="txtContactPersonResource2"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" id="imgContactperson" runat="server" alt="" class="a-center" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="hide paddingL4">
                                                <asp:Label ID="Rs_Address1" Text="Address 1" runat="server" meta:resourcekey="Rs_Address1Resource2"></asp:Label>
                                            </td>
                                            <td class="hide">
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAddress1" runat="server" MaxLength="100" TextMode="MultiLine"
                                                    CssClass="medium" meta:resourcekey="txtAddress1Resource2"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center" />
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_Address2" CssClass="hide" Text="Address 2" runat="server" meta:resourcekey="Rs_Address2Resource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtAddress2" runat="server" MaxLength="50" TextMode="MultiLine"
                                                    CssClass="medium hide" meta:resourcekey="txtAddress2Resource2"></asp:TextBox>
                                                <%-- onkeydown=" return isNumerics(event,this.id)"--%>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_City" CssClass="hide" Text="City" runat="server" meta:resourcekey="Rs_CityResource2"
                                                    onkeydown=" return isNumerics(event,this.id)"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtCity" runat="server" MaxLength="50" CssClass="medium hide" onkeydown=" return isNumerics(event,this.id)"
                                                    meta:resourcekey="txtCityResource2"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_EmailID" Text="Email ID" runat="server" meta:resourcekey="Rs_EmailIDResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtEmailID" runat="server" MaxLength="100" CssClass="medium" meta:resourcekey="txtEmailIDResource2"></asp:TextBox>
                                                <%--<asp:RegularExpressionValidator ID="regValidator" runat="server" ErrorMessage="Email is not vaild."
                                                ControlToValidate="txtEmailID" ValidationExpression="^\s*(([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+([;.](([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5}){1,25})+)*\s*$"
                                                ValidationGroup="register" meta:resourcekey="regValidatorResource1">--%> <%--<%=Resources.ClientSideDisplayTexts.Inventory_Suppliers_EmailNotValid%> </asp:RegularExpressionValidator>--%>
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_LandLine" CssClass="hide" Text="Landline" runat="server" meta:resourcekey="Rs_LandLineResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtPhoneNumber" onblur="checkSUPLandLineNumber()" runat="server"
                                                    MaxLength="20" CssClass="medium hide" onkeydown="return isNumericNew(event.keyCode);"
                                                    meta:resourcekey="txtPhoneNumberResource1"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center hide" />
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center hide" />
                                            </td>
                                            <td>
                                                <asp:Label ID="Rs_MobileNumber" CssClass="hide" Text="Mobile Number" runat="server" meta:resourcekey="Rs_MobileNumberResource2"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtMobileNumber" onblur="MobNoValidation()" runat="server"
                                                    CssClass="medium hide" onkeydown="return isNumericNew(event.keyCode);"
                                                    meta:resourcekey="txtMobileNumberResource1"></asp:TextBox>
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center hide" />
                                                <img src="../PlatForm/Images/starbutton.png" alt="" class="a-center hide" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="Rs_FaxNo" Text="Fax No" runat="server" meta:resourcekey="Rs_FaxNoResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtFaxNumber" runat="server" MaxLength="20" CssClass="medium"
                                                    onkeyup="IsNumber(this);" meta:resourcekey="txtFaxNumberResource1"></asp:TextBox>
                                                <%--onkeyup="return onlyNumbers(event,this.id)"--%>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblSupplierCode" Text="Supplier Code" runat="server" meta:resourcekey="Rs_SupplierCodeResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtSupplierCode" runat="server" MaxLength="15" CssClass="medium"
                                                    meta:resourcekey="txtSupplierCodeResource1"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lblPin" Text="PIN" runat="server" meta:resourcekey="Rs_PinResource1"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:TextBox OnKeyPress="return ValidateOnlyNumeric(this)" ID="txtPin" runat="server" MaxLength="20" CssClass="medium"
                                                    meta:resourcekey="txtPinResource1"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6">
                                                <asp:Panel ID="pnAddress" runat="server">
                                                    <table class="w-100p">
                                                        <tr>
                                                            <td>
                                                                <div id="dvucPAdd" class="w-100p" runat="server">
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td id="tdAddrSame" runat="server">
                                                                <asp:CheckBox ID="chkAddrSame" runat="server" Checked="True" CssClass="defaultfontcolor"
                                                                    onclick="CommercialAddrCntrl(this);" Text="Check this if current address is same as above"
                                                                    meta:resourcekey="cAdsameResource1" />
                                                                <div id="divCAD" class="hide a-left">
                                                                    <div id="dvucCAdd" runat="server">
                                                                    </div>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lbltermsconditions" Text="Terms & Conditions" runat="server" Maxlength="250" meta:resourcekey="lbltermsconditionsResource1"></asp:Label>
                                            </td>
                                            <td colspan="5">
                                                <table class="dataheaderInvCtrl w-100p">
                                                    <tr id="termsconditions">
                                                        <td colspan="2">
                                                            <div id="lbltermsconditionsdiv" class="w-99p marginauto">
                                                                <FTB:FreeTextBox ID="fckInvDetailss" runat="server" Width="100%"
                                                                    Height="200px" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                                                                    AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                                                                    AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl=""
                                                                    BreakMode="Paragraph" ButtonDownImage="False" ButtonFileExtention="gif"
                                                                    ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource"
                                                                    ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21"
                                                                    ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                                                                    DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False"
                                                                    DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea"
                                                                    DownLevelRows="10" EditorBorderColorDark="128, 128, 128"
                                                                    EditorBorderColorLight="128, 128, 128" EnableHtmlMode="True" EnableSsl="False"
                                                                    EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True"
                                                                    GutterBackColor="129, 169, 226" GutterBorderColorDark="128, 128, 128"
                                                                    GutterBorderColorLight="255, 255, 255" HelperFilesParameters=""
                                                                    HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True"
                                                                    ImageGalleryPath="~/images/"
                                                                    ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&amp;cif={0}"
                                                                    InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource"
                                                                    Language="en-US" PasteMode="Default" ReadOnly="False"
                                                                    RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True"
                                                                    RenderMode="NotSet" ScriptMode="External" ShowTagPath="False" SslUrl="/."
                                                                    StartMode="DesignMode" StripAllScripting="False"
                                                                    SupportFolder="/aspnet_client/FreeTextBox/" TabIndex="-1"
                                                                    TabMode="InsertSpaces" Text="" TextDirection="LeftToRight"
                                                                    ToolbarBackColor="Transparent" ToolbarBackgroundImage="True"
                                                                    ToolbarImagesLocation="InternalResource"
                                                                    ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                                                                    ToolbarStyleConfiguration="NotSet" UpdateToolbar="True"
                                                                    UseToolbarBackGroundImage="True">
                                                                </FTB:FreeTextBox>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <%--  <FCKeditorV2:FCKeditor ID="fckInvDetailss" runat="server" Width="600px" Height="150px">
                                            </FCKeditorV2:FCKeditor>--%>
                                                <%--<asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" onPaste="return false;" ID="txtTermsConditions" TextMode="MultiLine" CssClass="h-100 w-600" runat="server" meta:Resourcekey="txtTermsConditionsresource1"></asp:TextBox>--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="tdChkDelete" colspan="6" class="hide">
                                                <asp:CheckBox ID="chkDelete" runat="server" Text="Delete Supplier" onclick="checkDelete(this.id);"
                                                    meta:resourcekey="chkDeleteResource1" />
                                                <asp:HiddenField ID="hdnCheckIsUsed" runat="server" />
                                            </td>
                                        </tr>
                                        <tr class="lh35">
                                            <td colspan="6" class="a-center">
                                                <asp:Button ID="btnCancel" OnClientClick="javascript:return FnClear();" runat="server"
                                                    Text="Clear" CssClass="cancel-btn" meta:resourcekey="btnCancelResource2" />&nbsp;&nbsp;&nbsp;
                                            <asp:Button ID="btnFinish" Text="Save" runat="server" CssClass="btn" OnClientClick="javascript:return checkDetails();"
                                                OnClick="btnFinish_Click" meta:resourcekey="btnFinishResource2" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="imgBtnXL" />
                    <%-- <asp:PostBackTrigger ControlID="btn_export" /> --%>
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <Attune:Attunefooter ID="Attunefooter" runat="server" />
        <div id="divLoadingGif">
            <div id="divProgressBackgroundFilter">
            </div>
            <div class="a-center" id="divProcessMessage">
                <asp:Image ID="imgLoadingGif" runat="server"
                    ImageUrl="~/PlatForm/Themes/IB/Images/loaderNew.GIF"
                    meta:resourcekey="imgLoadingGifResource1" />
            </div>
        </div>
        <asp:HiddenField ID="hdnMandFieldDisable" runat="server" Value="Y" />
        <input type="hidden" id="hdnStatus" runat="server" />
        <asp:HiddenField ID="hdnMessages" runat="server" />
        <asp:HiddenField ID="hdnTinMandatory" runat="server" />
        <asp:HiddenField ID="hdnSetCurrentValue" runat="server" />
        <asp:HiddenField ID="hdnrspadsupllierconfig" Value="N" runat="server" />
        <asp:HiddenField ID="hdnSupplierNaming" runat="server" Value="N" />
        <%--Sathish--%>
        <asp:HiddenField ID="hdnPhLength" runat="server" />
        <asp:HiddenField ID="hdnMobLenValidation" runat="server" />
    </form>
</body>
</html>

<script type="text/javascript">

    $(document).ready(function () {
        setTimeout(function () {
            $('#divLoadingGif').hide();
        }, 200);
        if ($('#hdnrspadsupllierconfig').val() == 'Y') {
            $('#imgContactperson').removeClass().addClass('a-center hide');
        }
        HideADD();
    });

    function HideADD() {
        $('#mobilen').addClass('hide');
    }

    function CommercialAddrCntrl(ele) {
        if ($(ele).prop('checked')) {
            // $('#divCAD').hide('slow');
            $('#divCAD').removeClass().addClass('hide');
        }
        else {
            // $('#divCAD').show('slow');
            $('#divCAD').removeClass().addClass('show');
        }
    }


    //sathish-start--should alow alphanumeric.. 
    function IsNumber(txt) {
        txt.value = txt.value.replace(/[^0-9\n\r]+/g, '');
    }
    function IsAlpha(txt) {
        txt.value = txt.value.replace(/[^a-zA-Z \n\r]+/g, '');
    }
    //sathish-end--should alow alphanumeric..
    function SuccessAlert(userMsg, informMsg) {
        $('#ucPAdd_txtAddress1').val('');
        $('#ucPAdd_ddCountry').val(0);
        $('#ucPAdd_ddState').val(0);
        $('#ucPAdd_ddlDistricts').val(0);
        $('#ucPAdd_ddlCity').val(0);
        $('#ucPAdd_txtPostalCode').val('');
        $('#ucPAdd_txtMobile').val('');
        $('#ucPAdd_txtLandLine').val('');
        $('#ucCAdd_txtAddress1').val('');
        $('#ucCAdd_ddCountry').val(0);
        $('#ucCAdd_ddState').val(0);
        $('#ucCAdd_ddlCity').val(0);
        $('#ucCAdd_ddllocalities').val(0);
        $('#ucCAdd_txtPostalCode').val('');
        $('#ucCAdd_txtMobile').val('');
        $('#ucCAdd_txtLandLine').val('');
        $('#txtTermsConditions').val('');
        ValidationWindow(userMsg, informMsg);
    }

		$(window).on('beforeunload', function () {
            $('#preloader').hide();
        });
</script>

<script language="javascript" type="text/javascript">
    var ClientSelect = { Select: '<%=Resources.InventoryMaster_ClientDisplay.InventoryMaster_Suppliers_aspx_04%>' };       
</script>

