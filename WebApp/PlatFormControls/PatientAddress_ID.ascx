<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PatientAddress_ID.ascx.cs"
    Inherits="PlatFormControls_PatientAddress_ID" %>
<style>
.w-140{width:140px;}
tr table td {
padding-left: 0;
}
</style>
<script language="javascript" type="text/javascript">

    function expandTextBox(id) {
        document.getElementById(id).rows = "5";
        document.getElementById(id).cols = "20";
        ConverttoUpperCase(id);
    }
    function collapseTextBox(id) {
        document.getElementById(id).rows = "1";
        document.getElementById(id).cols = "20";
        ConverttoUpperCase(id);

    }
    
    

    
</script>
<script type="text/javascript" language="javascript">
    var ErrorMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_01') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_01') : "Error";
    var ConfirmMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_02') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_02') : "Confirm"
    var okMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_03') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_03') : "Ok";
    var CancelMsg = SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_04') != null ? SListForAppMsg.Get('Platform_CommonControls_PatientAddress_ID_ascx_04') : "Cancel";
</script>
<script type="text/javascript" language="javascript">
    function fnClearPatientAddress(CtrlName) {
        if (CtrlName == undefined) {
            CtrlName = '';
        }

        if ($('[id$=' + CtrlName + '_txtAddress1]').lenght > 0) {
            $('[id$=' + CtrlName + '_txtAddress1]')[0].value = '';
        }
        if ($('[id$=' + CtrlName + '_txtAddress2]').length > 0) {
            $('[id$=' + CtrlName + '_txtAddress2]')[0].value = '';
        }
        if ($('[id$=' + CtrlName + '_txtAddress3]').length > 0) {
            $('[id$=' + CtrlName + '_txtAddress3]')[0].value = '';
        }
        if ($('[id$=' + CtrlName + '_txtAddress3]').length > 0) {
            $('[id$=' + CtrlName + '_txtAddress3]')[0].value = '';
        }
        if ($('[id$=' + CtrlName + '_txtMobile]').length > 0) {
            $('[id$=' + CtrlName + '_txtMobile]')[0].value = '';
        }
        if ($('[id$=' + CtrlName + '_txtLandLine]').length > 0) {
            $('[id$=' + CtrlName + '_txtLandLine]')[0].value = '';
        }
        if ($('[id$=' + CtrlName + '_txtPostalCode]').length > 0) {
            $('[id$=' + CtrlName + '_txtPostalCode]')[0].value = '';
        }

        if ($("[id$=" + CtrlName + "_hdnAddressCountry]").length > 0) {
            $("[id$=" + CtrlName + "_hdnAddressCountry]")[0].value = "";
        }

        if ($("[id$=" + CtrlName + "_hdnAddressState]").length > 0) {
            $("[id$=" + CtrlName + "_hdnAddressState]")[0].value = "";
        }

        if ($("[id$=" + CtrlName + "_hdnCityID]").length > 0) {
            $("[id$=" + CtrlName + "_hdnCityID]")[0].value = "";
        }

        if ($("[id$=" + CtrlName + "_hdnDistricts]").length > 0) {
            $("[id$=" + CtrlName + "_hdnDistricts]")[0].value = "";
        }
        if ($("[id$=" + CtrlName + "_hdnLoclities]").length > 0) {
            $("[id$=" + CtrlName + "_hdnLoclities]")[0].value = "";
        }

        loadState1(CtrlName + "_ddCountry");
    }
    function fnValidatePatAddress(ctrlName) {
        if (ctrlName == null || ctrlName == undefined) {
            ctrlName = "";
        }


        if ($("[id$=" + ctrlName + "_hdnLoclities]").length > 0) {
            $("[id$=" + ctrlName + "_hdnLoclities]")[0].value = $("[id$=" + ctrlName + "_ddllocalities]")[0].value;
        }
        if ($("[id$=" + ctrlName + "_hdnDistricts]").length > 0) {
            $("[id$=" + ctrlName + "_hdnDistricts]")[0].value = $("[id$=" + ctrlName + "_ddlDistricts]")[0].value;
        }
        if ($("[id$=" + ctrlName + "_hdnCityID]").length > 0) {
            $("[id$=" + ctrlName + "_hdnCityID]")[0].value = $("[id$=" + ctrlName + "_ddlCity]")[0].value;
        }
        if ($("[id$=" + ctrlName + "_hdnAddressState]").length > 0) {
            $("[id$=" + ctrlName + "_hdnAddressState]")[0].value = $("[id$=" + ctrlName + "_ddState]")[0].value;
        }
        if ($("[id$=" + ctrlName + "_hdnAddressCountry]").length > 0) {
            $("[id$=" + ctrlName + "_hdnAddressCountry]")[0].value = $("[id$=" + ctrlName + "_ddCountry]")[0].value;
        }


        if ($("[id$=" + ctrlName + "_txtAddress1]").length > 0 && $("[id$=" + ctrlName + "_txtAddress1]")[0].value == '') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_01');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Provide address','Error');
            }
            $("[id$=" + ctrlName + "_txtAddress1]").focus();
            return false;
        }
        if ($("[id$=" + ctrlName + "_ddlCity]").length > 0 && $("[id$=" + ctrlName + "_ddlCity]")[0].selectedIndex == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_02');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Select City', 'Error');
            }
            $("[id$=" + ctrlName + "_ddlCity]").focus();
            return false;
        }

        if ($("[id$=" + ctrlName + "_txtMobile]").length > 0 && ($("[id$=" + ctrlName + "_txtMobile]")[0].value == '') && ($("[id$=" + ctrlName + "_txtLandLine]")[0].value == '')) {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_03');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Provide any one contact number','Error');
            }
            $("[id$=" + ctrlName + "_txtMobile]").focus();
            return false;
        }


        return true;
    }
    function fnValidatePatAddress() {
        if (document.getElementById('cAdsame') == null) {

            if ($("[id$=_hdnLoclities]").length > 0) {
                $("[id$=_hdnLoclities]")[0].value = $("[id$=_ddllocalities]")[0].value;
            }
            if ($("[id$=_hdnDistricts]").length > 0) {
                $("[id$=_hdnDistricts]")[0].value = $("[id$=_ddlDistricts]")[0].value;
            }
            if ($("[id$=_hdnCityID]").length > 0) {
                $("[id$=_hdnCityID]")[0].value = $("[id$=_ddlCity]")[0].value;
            }
            if ($("[id$=_hdnAddressState]").length > 0) {
                $("[id$=_hdnAddressState]")[0].value = $("[id$=_ddState]")[0].value;
            }
            if ($("[id$=_hdnAddressCountry]").length > 0) {
                $("[id$=_hdnAddressCountry]")[0].value = $("[id$=_ddCountry]")[0].value;
            }
        }
        else {

            if (document.getElementById('cAdsame').checked) {
                if ($("[id$=_hdnLoclities]").length > 1) {
                    $("[id$=_hdnLoclities]")[0].value = $("[id$=_ddllocalities]")[0].value;
                    $("[id$=_hdnLoclities]")[1].value = $("[id$=_ddllocalities]")[0].value;
                }
                if ($("[id$=_hdnDistricts]").length > 1) {
                    $("[id$=_hdnDistricts]")[0].value = $("[id$=_ddlDistricts]")[0].value;
                    $("[id$=_hdnDistricts]")[1].value = $("[id$=_ddlDistricts]")[0].value;
                }
                if ($("[id$=_hdnCityID]").length > 1) {
                    $("[id$=_hdnCityID]")[0].value = $("[id$=_ddlCity]")[0].value;
                    $("[id$=_hdnCityID]")[1].value = $("[id$=ddlCity]")[0].value;
                }
                if ($("[id$=_hdnAddressState]").length > 1) {
                    $("[id$=_hdnAddressState]")[0].value = $("[id$=_ddState]")[0].value;
                    $("[id$=_hdnAddressState]")[1].value = $("[id$=_ddState]")[0].value;
                }
                if ($("[id$=_hdnAddressCountry]").length > 1) {
                    $("[id$=_hdnAddressCountry]")[0].value = $("[id$=_ddCountry]")[0].value;
                    $("[id$=_hdnAddressCountry]")[1].value = $("[id$=_ddCountry]")[0].value;
                }
            }
            else {
                if ($("[id$=_hdnLoclities]").length > 1) {
                    $("[id$=_hdnLoclities]")[0].value = $("[id$=_ddllocalities]")[0].value;
                    $("[id$=_hdnLoclities]")[1].value = $("[id$=_ddllocalities]")[1].value;
                }
                if ($("[id$=_hdnDistricts]").length > 1) {
                    $("[id$=_hdnDistricts]")[0].value = $("[id$=_ddlDistricts]")[0].value;
                    $("[id$=_hdnDistricts]")[1].value = $("[id$=_ddlDistricts]")[1].value;
                }
                if ($("[id$=_hdnCityID]").length > 1) {
                    $("[id$=_hdnCityID]")[0].value = $("[id$=_ddlCity]")[0].value;
                    $("[id$=_hdnCityID]")[1].value = $("[id$=_ddlCity]")[1].value;
                }
                if ($("[id$=_hdnAddressState]").length > 1) {
                    $("[id$=_hdnAddressState]")[0].value = $("[id$=ddState]")[0].value;
                    $("[id$=_hdnAddressState]")[1].value = $("[id$=ddState]")[1].value;
                }
                if ($("[id$=_hdnAddressCountry]").length > 1) {
                    $("[id$=_hdnAddressCountry]")[0].value = $("[id$=_ddCountry]")[0].value;
                    $("[id$=_hdnAddressCountry]")[1].value = $("[id$=_ddCountry]")[1].value;
                }
            }

        }
        if ($("[id$=_txtAddress1]").length > 0 && $("[id$=_txtAddress1]")[0].value == '') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_01');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Provide address','Error');
            }
            $("[id$=_txtAddress1]")[0].focus();
            return false;
        }
        if ($("[id$=_ddlCity]").length > 0 && $("[id$=_ddlCity]")[0].selectedIndex == '0') {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_02');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Select City', 'Error');
            }
            $("[id$=_ddlCity]")[0].focus();
            return false;
        }

        if ($("[id$=_txtMobile]").length > 0 && ($("[id$=_txtMobile]")[0].value == '') && ($("[id$=_txtLandLine]")[0].value == '')) {
            var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_03');
            var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
            if (ErrorMsg == null) {
                ErrorMsg = "Error";
            }
            if (userMsg != null) {
                ValidationWindow(userMsg, ErrorMsg);
            }
            else {
                ValidationWindow('Provide any one contact number','Error');
            }
            $("[id$=_txtMobile]")[0].focus();
            return false;
        }

        if (document.getElementById('CAD') != null && document.getElementById('CAD').style.display == 'block') {
            if ($("[id$=_txtAddress1]").length > 0 && $("[id$=_txtAddress1]")[0].value == '') {
                var userMsg = SListForAppMsg.Get('PlatFormControls_PatientAddress_ID_ascx_04');
                var ErrorMsg = SListForAppMsg.Get('PlatFormControls_Attune_Footer_ascx_01');
                if (ErrorMsg == null) {
                    ErrorMsg = "Error";
                }
                if (userMsg != null) {
                    ValidationWindow(userMsg, ErrorMsg);
                }
                else {
                    ValidationWindow('Provide the street/road name in current address','Error');
                }
                $("[id$=_txtAddress1]")[0].focus();
                return false;
            }

        }
        return true;
    }

    function loadState1(objState, objID) {

        var parID = objState.substring(0, objState.lastIndexOf('_')); //objState.split("_")[0];
        var Length;
        //        var select = ClientSelect.Select;
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        document.getElementById(parID + "_hdnAddressCountry").value = document.getElementById(objState).value;
        $("select[id$=" + parID + "_ddState] > option").remove();
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        if (Number(document.getElementById(parID + "_ddCountry").value) > 0) {
            $.ajax({
                type: "POST",
                url: "../PlatformWebServices/PlatFormServices.asmx/Localities",

                //data: "{ 'CodeID': " + (document.getElementById(parID + "_ddCountry").value) + "}",
                data: "{ 'CodeID': '" + (document.getElementById(parID +"_ddCountry").value) + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    //$("#" + parID + "_ddState").attr("disabled", false);
                    $("#" + parID + "_ddState").append('<option value="-1">' + select + '</option>');
                    $("#" + parID + "_ddlCity").append('<option value="-1">' + select + '</option>');
                    $("#" + parID + "_ddlDistricts").append('<option value="-1">' + select + '</option>');
                    $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
                    $.each(Items, function(index, Item) {
                        $("#" + parID + "_ddState").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
                        document.getElementById(parID + "_txtCountryCode").value = "+" + Item.ISDCode;

                        Length = Item.PhoneNo_Length;
                        $("[id$=_hdnPhLength]").val(Length);

                        $("[id$=_txtMobile]").prop('maxLength', Length);
                    });

                    if (objID > 0) {
                        document.getElementById(parID + "_ddState").value = objID;
                        document.getElementById(parID + "_hdnAddressState").value = objID;
                    }
                    if ($("[id$=" + parID + "_hdnAddressState]").length > 0) {
                        if ($("[id$=" + parID + "_hdnAddressState]")[0].value != undefined && $("[id$=" + parID + "_hdnAddressState]")[0].value != "") {
                            document.getElementById(parID + "_ddState").value = $("[id$=" + parID + "_hdnAddressState]")[0].value;

                            loadCity1(parID + "_ddState", document.getElementById(parID + "_hdnCityID").value,
                        document.getElementById(parID + "_ddState").value);
                        }
                    }

                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }
    }

    function loadCity1(objCity, objID, StateCode) {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        document.getElementById(parID + "_hdnAddressState").value = document.getElementById(objCity).value;
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        var value = document.getElementById(parID + "_ddState").value;
        if (value == "") {
            value = StateCode;
        }
        $("select[id$=" + parID + "_ddlCity] > option").remove();
        if (Number(value) > 0) {
            $.ajax({
                type: "POST",
                url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
                //data: "{ 'CodeID': " + value + "}",
                data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    $("#" + parID + "_ddlCity").append('<option value="-1">' + select + '</option>');
                    $("#" + parID + "_ddlDistricts").append('<option value="-1">' + select + '</option>');
                    $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
                    $.each(Items, function(index, Item) {
                        $("#" + parID + "_ddlCity").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');
                    });
                    if (objID > 0) {
                        document.getElementById(parID + "_ddlCity").value = objID;
                        document.getElementById(parID + "_hdnCityID").value = objID;
                    }

                    if ($("[id$=" + parID + "_hdnCityID]").length > 0) {
                        if ($("[id$=" + parID + "_hdnCityID]")[0].value != undefined && $("[id$=" + parID + "_hdnCityID]")[0].value != "") {
                            document.getElementById(parID + "_ddlCity").value = $("[id$=" + parID + "_hdnCityID]")[0].value;

                            loadDis1(parID + "_ddlCity", document.getElementById(parID + "_hdnDistricts").value,
                        document.getElementById(parID + "_ddlCity").value);
                        }
                    }
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }
    }
    function loadDis1(objCity, DistrictID, CityCode) {

        var parID = objCity.substring(0, objCity.lastIndexOf('_')); // objCity.split("_")[0];
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        document.getElementById(parID + "_hdnCityID").value = document.getElementById(objCity).value;
        $("select[id$=" + parID + "_ddlDistricts] > option").remove();
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        //var parID = objCity.split("_")[0];
        var value = document.getElementById(parID + "_hdnCityID").value;
        if (value == "") {
            value = CityCode;
        }
        if (Number(value) > 0) {
            $.ajax({
                type: "POST",
                url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
                //data: "{ 'CodeID': " + value + "}",
                data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    $("#" + parID + "_ddlDistricts").append('<option value="-1">' + select + '</option>');
                    $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
                    $.each(Items, function(index, Item) {
                        $("#" + parID + "_ddlDistricts").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

                    });
                    if (DistrictID > 0) {
                        document.getElementById(parID + "_ddlDistricts").value = DistrictID;
                        document.getElementById(parID + "_hdnDistricts").value = DistrictID;
                    }

                    if ($("[id$=" + parID + "_hdnDistricts]").length > 0) {
                        if ($("[id$=" + parID + "_hdnDistricts]")[0].value != undefined && $("[id$=" + parID + "_hdnDistricts]")[0].value != "") {
                            document.getElementById(parID + "_ddlDistricts").value = $("[id$=" + parID + "_hdnDistricts]")[0].value;

                            loaLocality1(parID + "_ddlDistricts",
                                    document.getElementById(parID + "_hdnLoclities").value,
                                    document.getElementById(parID + "_ddlDistricts").value);
                        }
                    }

                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }

    }


    function loaLocality1(objLocality, LocalityID, DistrictID) {

        var parID = objLocality.substring(0, objLocality.lastIndexOf('_'));  //objLocality.split("_")[0];
        var select = SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") != null ? SListForAppDisplay.Get("PlatFormControls_PatientAddress_ID_ascx_01") : "Select";
        var orgID = document.getElementById("<%=hdnOrgID.ClientID %>").value;
        var Langcode = document.getElementById("<%=hdnLangCode.ClientID %>").value;
        $("select[id$=" + parID + "_ddllocalities] > option").remove();
        document.getElementById(parID + "_hdnDistricts").value = document.getElementById(objLocality).value;
        //var parID = objLocality.split("_")[0];
        var value = document.getElementById(parID + "_hdnDistricts").value;
        if (value == "") {
            value = DistrictID;
        }
        if (Number(value) > 0) {
            $.ajax({
                type: "POST",
                url: "../PlatformWebServices/PlatFormServices.asmx/Localities",
                //data: "{ 'CodeID': " + value + "}",
                data: "{ 'CodeID': '" + value + "','OrgID':" + orgID + ",'LangCode':'" + Langcode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function(data) {
                    var Items = data.d;
                    $("#" + parID + "_ddllocalities").append('<option value="-1">' + select + '</option>');
                    $.each(Items, function(index, Item) {
                        $("#" + parID + "_ddllocalities").append('<option value="' + Item.Locality_ID + '">' + Item.Locality_Value + '</option>');

                    });
                    if (LocalityID > 0) {
                        document.getElementById(parID + "_ddllocalities").value = LocalityID;
                    }
                },
                failure: function(msg) {
                    ShowErrorMessage(msg);
                }
            });
        }

    }

    function onchangeLocaliy(id) {
        var parID = id.split("_")[0];
        document.getElementById(parID + "_hdnLoclities").value = document.getElementById(id).value;
    }
    function fnDisableAddress() {

        if ($("[id$=txtAddress1]").length > 0) {
            $("[id$=txtAddress1]")[0].disabled = true;
        }
        if ($("[id$=txtAddress2]").length > 0) {
            $("[id$=txtAddress2]")[0].disabled = true;
        }
        if ($("[id$=txtAddress3]").length > 0) {
            $("[id$=txtAddress3]")[0].disabled = true;
        }
        if ($("[id$=txtPostalCode]").length > 0) {
            $("[id$=txtPostalCode]")[0].disabled = true;
        }
        if ($("[id$=txtMobile]").length > 0) {
            $("[id$=txtMobile]")[0].disabled = true;
        }
        if ($("[id$=txtLandLine]").length > 0) {
            $("[id$=txtLandLine]")[0].disabled = true;
        }
        if ($("[id$=ddCountry]").length > 0) {
            $("[id$=ddCountry]")[0].disabled = true;
        }
        if ($("[id$=ddState]").length > 0) {
            $("[id$=ddState]")[0].disabled = true;
        }
        if ($("[id$=ddlCity]").length > 0) {
            $("[id$=ddlCity]")[0].disabled = true;
        }
        if ($("[id$=ddlDistricts]").length > 0) {
            $("[id$=ddlDistricts]")[0].disabled = true;
        }
        if ($("[id$=ddllocalities]").length > 0) {
            $("[id$=ddllocalities]")[0].disabled = true;
        }
    }
    function fnEnableAddress() {

        if ($("[id$=txtAddress1]").length > 0) {
            $("[id$=txtAddress1]")[0].disabled = false;
        }
        if ($("[id$=txtAddress2]").length > 0) {
            $("[id$=txtAddress2]")[0].disabled = false;
        }
        if ($("[id$=txtAddress3]").length > 0) {
            $("[id$=txtAddress3]")[0].disabled = false;
        }
        if ($("[id$=txtPostalCode]").length > 0) {
            $("[id$=txtPostalCode]")[0].disabled = false;
        }
        if ($("[id$=txtMobile]").length > 0) {
            $("[id$=txtMobile]")[0].disabled = false;
        }
        if ($("[id$=txtLandLine]").length > 0) {
            $("[id$=txtLandLine]")[0].disabled = false;
        }
        if ($("[id$=ddCountry]").length > 0) {
            $("[id$=ddCountry]")[0].disabled = false;
        }
        if ($("[id$=ddState]").length > 0) {
            $("[id$=ddState]")[0].disabled = false;
        }
        if ($("[id$=ddlCity]").length > 0) {
            $("[id$=ddlCity]")[0].disabled = false;
        }
        if ($("[id$=ddlDistricts]").length > 0) {
            $("[id$=ddlDistricts]")[0].disabled = false;
        }
        if ($("[id$=ddllocalities]").length > 0) {
            $("[id$=ddllocalities]")[0].disabled = false;
        }
    }
    function fnSetAddress(Address1, Address2, Address3, CountryCode, StateCode, CityCode, AddLevel1, Addlevel2, PostalCode, Mobile, Landline, CtrlName) {
        if (CtrlName == undefined) {
            CtrlName = '';
        }
        if (Address1 != undefined && Address1 != "") {
            if ($("[id$=" + CtrlName + "_txtAddress1]").length > 0) {
                $("[id$=" + CtrlName + "_txtAddress1]")[0].value = Address1;
            }
        }
        if (Address2 != undefined && Address2 != "") {
            if ($("[id$=" + CtrlName + "_txtAddress2]").length > 0) {
                $("[id$=" + CtrlName + "_txtAddress2]")[0].value = Address2;
            }
        }
        if (Address3 != undefined && Address3 != "") {
            if ($("[id$=" + CtrlName + "_txtAddress3]").length > 0) {
                $("[id$=" + CtrlName + "_txtAddress3]")[0].value = Address3;
            }
        }
        if (PostalCode != undefined && PostalCode != "") {
            if ($("[id$=" + CtrlName + "_txtPostalCode]").length > 0) {
                $("[id$=" + CtrlName + "_txtPostalCode]")[0].value = PostalCode;
            }
        }
        if (Mobile != undefined && Mobile != "") {
            if ($("[id$=" + CtrlName + "_txtMobile]").length > 0) {
                $("[id$=" + CtrlName + "_txtMobile]")[0].value = Mobile;
            }
        }
        if (Landline != undefined && Landline != "") {
            if ($("[id$=" + CtrlName + "_txtLandLine]").length > 0) {
                $("[id$=" + CtrlName + "_txtLandLine]")[0].value = Landline;
            }
        }
        if (CountryCode != undefined && CountryCode != "") {
            if ($("[id$=" + CtrlName + "_hdnAddressCountry]").length > 0) {
                $("[id$=" + CtrlName + "_hdnAddressCountry]")[0].value = CountryCode;
                $("#" + CtrlName + "_ddCountry").val(CountryCode);
            }
        }
        if (StateCode != undefined && StateCode != "") {
            if ($("[id$=" + CtrlName + "_hdnAddressState]").length > 0) {
                $("[id$=" + CtrlName + "_hdnAddressState]")[0].value = StateCode;
            }
        }
        if (CityCode != undefined && CityCode != "") {
            if ($("[id$=" + CtrlName + "_hdnCityID]").length > 0) {
                $("[id$=" + CtrlName + "_hdnCityID]")[0].value = CityCode;
            }
        }
        if (AddLevel1 != undefined && AddLevel1 != "") {
            if ($("[id$=" + CtrlName + "_hdnDistricts]").length > 0) {
                $("[id$=" + CtrlName + "_hdnDistricts]")[0].value = AddLevel1;
            }
        }
        if (Addlevel2 != undefined && Addlevel2 != "") {
            if ($("[id$=" + CtrlName + "_hdnLoclities]").length > 0) {
                $("[id$=" + CtrlName + "_hdnLoclities]")[0].value = Addlevel2;
            }
        }

        if (StateCode != undefined && StateCode != "") {
            loadState1(CtrlName + "_ddCountry", StateCode);
        }
        else {
            loadState1(CtrlName + "_ddCountry");
        }
        
    }
    //sathish-start--should alow alphanumeric.. 
//    function ValidateSplChar(txt) {
//        txt.value = txt.value.replace(/[^a-zA-Z 0-9.#,\n\r]+/g, '');

//    }
    
</script>

<table id="tblAddressCntrl" class="w-100p">
    <tr  id="TitleRow" runat="server">
        <td colspan="6" align="left" id="us" runat="server">
            <asp:Literal ID="litTitle" runat="server" meta:resourcekey="litTitleResource1"></asp:Literal>
            <asp:Literal ID="litCurrentTitle" runat="server" meta:resourcekey="litCurrentTitleResource1"></asp:Literal>
        </td>
    </tr>
    <tr class="lh25">
        <td  runat="server" id="Col1" class="a-left w-11p" >
            <asp:Label ID="Address1" runat="server" Text="Address 1" meta:resourcekey="Address1Resource1"></asp:Label>
        </td>
        <td runat="server" id="Col2"  class="a-left w-25p">
            <asp:TextBox ID="txtAddress1"  CssClass="medium" runat="server" onFocus="return expandTextBox(this.id)"
              onKeyPress="return ValidateMultiLangCharacter(event);"    onBlur="return collapseTextBox(this.id);" MaxLength="150" TabIndex="9" 
                meta:resourcekey="txtAddress2Resource1"  ></asp:TextBox>&nbsp;<img src="../PlatForm/Images/starbutton.png"
                    alt="" align="middle" />
        </td>
        <td  class="a-left w-10p Col3">
            <asp:Label ID="Address2" runat="server" Text="Address 2" 
                meta:resourcekey="Address2Resource2"></asp:Label>
        </td>
        <td  class="a-left w-22p Col4">
            <asp:TextBox ID="txtAddress2" CssClass="medium" runat="server" onBlur="return ConverttoUpperCase(this.id);"
              onKeydown="return ValidateMultiLangCharacter(event);"   MaxLength="250" TabIndex="10" meta:resourcekey="txtAddress1Resource1"></asp:TextBox>
        </td>
        <td class="a-left w-9p Col5">
            <asp:Label ID="Address3" runat="server" Text="Address 3" meta:resourcekey="Address3Resource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtAddress3" CssClass="medium" runat="server" onBlur="return ConverttoUpperCase(this.id);"
              onKeydown="return ValidateMultiLangCharacter(event);"   MaxLength="250" TabIndex="11" meta:resourcekey="txtAddress3Resource1"></asp:TextBox>
        </td>
       
    </tr>
    <tr class="lh25">
     <td id="Col4" runat="server" class="a-left w-9p" >
            <asp:Label ID="Country" runat="server" Text="Country" meta:resourcekey="CountryResource1"></asp:Label>
        </td>
        <td id="Col5" runat="server">
            <asp:DropDownList ID="ddCountry" CssClass="medium" runat="server" TabIndex="12"
                onchange="javascript:loadState1(this.id);" meta:resourcekey="ddCountryResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Label ID="State" runat="server" Text="State" meta:resourcekey="StateResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddState" CssClass="medium" runat="server" TabIndex="13" onchange="javascript:loadCity1(this.id);"
                meta:resourcekey="ddStateResource1">
            </asp:DropDownList>
        </td>
        <td>
            <asp:Label ID="City" runat="server" Text="City" meta:resourcekey="CityResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlCity" runat="server" CssClass="medium" onchange="javascript:loadDis1(this.id);"
                TabIndex="14" meta:resourcekey="ddlCityResource1" >
            </asp:DropDownList>
            <img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
        </td>
      
    </tr>
    <tr class="hide lh25" id="trOtherCountry" runat="server">
        <td colspan="2">
            <div clas="hide" runat="server" id="tbCountry">
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Other Country" meta:resourcekey="Label1Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOtherCountry" CssClass="medium" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                meta:resourcekey="txtOtherCountryResource1"></asp:TextBox>
                            &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
        <td colspan="2">
            <div class="hide" runat="server" id="tbState">
                <table class="w-100p">
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Other State" meta:resourcekey="Label2Resource1"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtOtherState" CssClass="medium" runat="server" onkeypress="return ValidateMultiLangChar(this);"
                                meta:resourcekey="txtOtherStateResource1"></asp:TextBox>
                            &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
      
    </tr>
    <tr class="lh25">
       <td>
            <asp:Label ID="lblDistricts" runat="server" Text="Districts" meta:resourcekey="lblDistrictsResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlDistricts" runat="server" CssClass="medium" onchange="javascript:loaLocality1(this.id);"
                TabIndex="15" meta:resourcekey="ddlDistrictsResource1">
            </asp:DropDownList>
        </td>
      <td>
            <asp:Label ID="lblLocality" runat="server" Text="Locality" meta:resourcekey="lblLocalityResource1"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddllocalities" runat="server" CssClass="medium" onchange="javascript:onchangeLocaliy(this.id);"
                TabIndex="16" meta:resourcekey="ddllocalitiesResource1">
            </asp:DropDownList>
        </td>
       
        <td>
            <asp:Label ID="PostalCode" runat="server" Text="Postal Code" 
                meta:resourcekey="PostalCodeResource1"></asp:Label>
        </td>
        <td >
            <asp:TextBox ID="txtPostalCode" CssClass="medium" TabIndex="17" runat="server" onkeypress="return AlphaNumericOnly(event);"
                MaxLength="6" meta:resourcekey="txtPostalCodeResource1"></asp:TextBox>
            <%--<ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender2"
                TargetControlID="txtPostalCode" Enabled="True">
            </ajc:FilteredTextBoxExtender>--%>
        </td></tr><tr>
        <td>
            <asp:Label ID="Mobile" runat="server" Text="Mobile" meta:resourcekey="MobileResource1"></asp:Label>
        </td>
        <td>
            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                <ContentTemplate>
                    <asp:TextBox ID="txtCountryCode" runat="server" CssClass="mini" onkeypress="return ValidateMultiLangChar(this);"
                        Font-Bold="True" meta:resourcekey="txtCountryCodeResource1"></asp:TextBox>
                    <asp:TextBox ID="txtMobile" CssClass="w-140" TabIndex="18" runat="server" meta:resourcekey="txtMobileResource1"
                         onkeypress="return ValidateSpecialAndNumeric(this);"></asp:TextBox>
                    <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="filtxtMobile"
                        TargetControlID="txtMobile" Enabled="True">
                    </ajc:FilteredTextBoxExtender>
                    &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" /><img src="../PlatForm/Images/starbutton.png"
                        alt="" align="middle" />
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddCountry" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
        <td>
            <asp:Label ID="LandLine" runat="server" Text="Landline" meta:resourcekey="LandLineResource1"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtLandLine" CssClass="medium" TabIndex="19" runat="server" onkeypress="return ValidateSpecialAndNumeric(this);"
                MaxLength="12" onblur="checkLandLineNumber()" meta:resourcekey="txtLandLineResource1"></asp:TextBox>
            <ajc:FilteredTextBoxExtender runat="server" FilterType="Numbers" ID="FilteredTextBoxExtender1"
                TargetControlID="txtLandLine" Enabled="True">
            </ajc:FilteredTextBoxExtender>
            &nbsp;<img src="../PlatForm/Images/starbutton.png" alt="" align="middle" /><img src="../PlatForm/Images/starbutton.png"
                alt="" align="middle" />
        </td>
    </tr>
    <asp:HiddenField ID="hdnAddressCountry" runat="server" />
    <asp:HiddenField ID="hdnAddressState" runat="server" />
    <asp:HiddenField ID="hdnCityID" runat="server" />
    <asp:HiddenField ID="hdnDistricts" runat="server" />
    <asp:HiddenField ID="hdnLoclities" runat="server" />
    <asp:HiddenField ID="hdnPhLength" runat="server" />
    <asp:HiddenField ID="hdnOrgID" runat ="server" />
    <asp:HiddenField ID="hdnLangCode" runat ="server" />
    <asp:TextBox runat="server" Visible="False" ID="txtAddressID" meta:resourcekey="txtAddressIDResource1"></asp:TextBox>
</table>
