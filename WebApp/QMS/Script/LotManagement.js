
var btntype = null;
$btnSave = $('#btnSave');
$btnupdate = $("#btnupdate");
$btnmanusave = $('#btnManuFactSave');
$btnmanuupdate = $('#btnManuFactUpdate');
$btnlotsave = $('#btnLotsSave');
$btnlotupdate=$('#btnLotsUpdate');
$(document).ready(function() {
    Loadcountry();
    LoadLotvendorDetails();
    LoadLotManufacturerDetails();
    LoadLotMasterDetails();
    ddlManufacturer();
    ddlVendor();
    ddlAnalyte();

    var TTable = null;

    $(".uniquetestcode").click(function() {
        $('#Check_Manucode i').addClass('fa fa-question');
        $('#Check_Manucode').removeClass('btn-danger').addClass('btn-success');
        $('#check_vendor i').addClass('fa fa-question');
        $('#check_vendor').removeClass('btn-danger').addClass('btn-success');
        $('#Check_Testcode i').addClass('fa fa-question');
        $('#Check_Testcode').removeClass('btn-danger').addClass('btn-success');
        $('#btnsave').show().removeAttr("disabled");
        $('#btnupdate').hide().removeAttr("disabled");
        $('#btnManuFactSave').show().removeAttr("disabled");
        $('#btnManuFactUpdate').hide().removeAttr("disabled");
        $('#btnLotsSave').show().removeAttr("disabled");
        $('#btnLotsUpdate').hide().removeAttr("disabled");
        clear1();
        ClearLots();
        ClearVendor();
        btntype = null;

    });
    $("#btnManuFactSave").click(function() {
        var ManufacturerName;
        var ManufacturerCode;
        var Email;
        var Phone;
        ManufacturerName = $('#txtManufactName').val();
        ManufacturerCode = $('#txtManufactCode').val();
        Email = $('#txtManufactEmail').val();
        Phone = $('#txtManufactPhone').val();
        var LotmanufacturerMaster = [];
        if (ManufacturerName != "" && ManufacturerCode != "") {
            if (Email !='')
            {
                if (!ValidateEmail(Email)) {

                    alert(langData.alert_emailinvalid);
                    return false;

                }
            }
            LotmanufacturerMaster.push({
                ManufacturerName: ManufacturerName,
                ManufacturerCode: ManufacturerCode,
                EmailID: Email,
                MobileNo: Phone

            });
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_LotManufacturerMaster",
                data: JSON.stringify({ LotManufacturerMaster: LotmanufacturerMaster }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    var Result = data.d;
                    if (Result > 0) {
                        clear1();
                        LoadLotManufacturerDetails();
                        ddlVendor();
                        ddlManufacturer();
                        alert(langData.alert_manufacadd);
                    }
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }


            });
        }
        else {
            alert(langData.alert_manu_namecode);
        }
    });
    $("#btnSave").click(function() {
        var Vendorname;
        var Vendorcode;
        var PanNo;
        var SPOCName;
        var EmailId;
        var MobileNo;
        var Landlineno;
        var Faxno;
        var Country;
        var State;
        var city;
        var Postalcode;
        var Address;
        var terms;
        Vendorname = $("#txtVendorName").val();
        Vendorcode = $("#txtVendorCode").val();
        PanNo = $("#txtPanNo").val();
        SPOCName = $("#txtSpocName").val();
        EmailId = $("#txtEmailId").val();
        MobileNo = $("#txtMobileNo").val();
        Landlineno = $("#txtLandlineNo").val();
        Faxno = $("#txtFaxNo").val();
        Country = $("#ddlCountry option:selected").val();
        state = $("#ddlState option:selected").val();
        city = $("#txtCity").val();
        Postalcode = $("#txtPostalCode").val();
        Address = $("#txtAddress").val();
        terms = $("#txtTerms").val();
        var LotvendorMaster = [];
        if (Vendorname == "") {
            alert(langData.alert_vendorname);
            return false;
        }
        else if (Vendorcode == "") {
            alert(langData.alert_vendorcode);
            return false;
        }
        else if ($('#txtSpocName').val() == "") {
            alert(langData.alert_spocname);
            return false;
        }
        else if (!ValidateEmail(EmailId)) {

            alert(langData.alert_emailinvalid);
            return false;

        }
        else if ($('#ddlCountry').val() == "0") {
            alert(langData.alert_countryselect);
            return false;
        }
        else if ($('#ddlState').val() == "0") {
            alert(langData.alert_stateselect);
            return false;
        }
        else if ($('#txtCity').val() == "") {
            alert(langData.alert_city);
            return false;
        } else if ($('#txtAddress').val() == "") {
            alert(langData.alert_vendoraddress);
            return false;
        }



        LotvendorMaster.push({
            Vendorcode: Vendorcode,
            VendorName: Vendorname,
            PanNo: PanNo,
            SPOCName: SPOCName,
            EmailID: EmailId,
            Mobileno: MobileNo,
            Landlineno: Landlineno,
            FaxNo: Faxno,
            CountryID: parseInt(Country) || 0,
            StateID: parseInt(state) || 0,
            //CityID: parseInt(city) || 0,
            PostalCode: Postalcode,
            TempAddress: Address,
            Termsandconditions: terms
        });
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/QMS_LotVendorMaster",
            data: JSON.stringify({ LotVendorMaster: LotvendorMaster, city: city }),
            dataType: "JSON",
            async: false,
            success: function(data) {
                var Result = data.d;
                if (Result > 0) {
                    ClearVendor();
                    ddlManufacturer();
                    ddlVendor();
                    LoadLotvendorDetails();
                    alert(langData.alert_vendoradd);
                }
            },
            error: function(xhr, status, error) {
                alert(xhr);
            }


        });


    });
    $("#btnManuFactUpdate").click(function() {
        var ManufacturerName;
        var ManufacturerCode;
        var Email;
        var Phone;
        ManufacturerName = $('#txtManufactName').val();
        ManufacturerCode = $('#txtManufactCode').val();
        Email = $('#txtManufactEmail').val();
        Phone = $('#txtManufactPhone').val();
        var LotmanufacturerMaster = [];
        if (ManufacturerName != "" && ManufacturerCode != "") {
            if (Email != "") {
                if (!ValidateEmail(Email)) {
                    alert(langData.alert_emailinvalid);
                    return false;
                }
            }
            LotmanufacturerMaster.push({
                ManufacturerName: ManufacturerName,
                ManufacturerCode: ManufacturerCode,
                EmailID: Email,
                MobileNo: Phone

            });
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_UpdateLotManufactureMaster",
                data: JSON.stringify({ Manufacturemaster: LotmanufacturerMaster, MacID: hdnMacID.value }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    btntype = null;
                    var Result = data.d;
                    if (Result > 0) {
                        $("#btnManuFactUpdate").hide();
                        $("#btnManuFactSave").show();
                        clear1();
                        LoadLotManufacturerDetails();
                        ddlManufacturer();
                        ddlVendor();
                        alert(langData.alert_manufacturer_update);
                    }
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }


            });
        }
        else {
            alert(langData.alert_manu_namecode_select);
        }
    });
    $("#btnLotsSave").click(function() {
        var LotName;
        var LotNo;
        var MacID;
        var VendorID;
        var Description;
        var ExpiryDate;
        var Level;
        var Analyte;
        var AnalyteNAme;
        var IsExpired;
        LotName = $('#txtLotName').val();
        LotNo = $('#txtLotNo').val();
        MacID = $('#ddlManufacturer option:selected').val();
        VendorID = $('#ddlVendor option:selected').val();
        Description = $('#txtDescription').val();
        ExpiryDate = dateformat($('#txtExpiryDate').val(), "YYYY/MM/DD");
        Level = $('#ddlLevel').val();

        Analyte = $('#ddlAnalyte').val();


        if (ValidateLotTab() == true) {

            AnalyteNAme = $("#ddlAnalyte option:selected").map(function() {
                return $(this).text();
            }).get();
            var LevelID = "";
            $.each(Level, function(idx, val) {
                if (idx == 0)
                { LevelID = LevelID + val }
                else {
                    LevelID = LevelID + '~' + val
                }
            })
            var LotMaster = [];
            if ($("#LotExpiryID").is(':checked'))
                IsExpired = 'Y';
            else
                IsExpired = 'N'
            LotMaster.push({
                LotName: LotName,
                LotCode: LotNo,
                MacID: MacID,
                VendorID: VendorID,
                ExpiryDate: ExpiryDate,
                IsExpired: IsExpired,
                DisplayText: Description
            });

            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_SaveLotManagement",
                data: JSON.stringify({ LotMaster: LotMaster, AnalyteID: Analyte, AnalyteName: AnalyteNAme, LevelID: LevelID }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    var Result = data.d;
                    if (Result > 0) {
                        LoadLotMasterDetails();
                        ClearLots();
                        alert(langData.alert_lotadd);
                    }
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }


            });
        }

    });


    function ValidateLotTab() {
        if ($('#txtLotName').val() == "") {
            alert(langData.alert_lotname);
            $('#txtLotName').focus();
            return false;
        }
        else if ($('#txtLotNo').val() == "") {
            alert(langData.alert_lotno);
            $('#txtLotNo').focus();
            return false;
        }
        else if ($('#ddlVendor option:selected').val() == 0) {
            alert(langData.alert_vendorselect);
            $('#ddlVendor').focus();
            return false;
        }
        else if ($('#txtExpiryDate').val() == "") {
            alert(langData.alert_expiryselect);
            $('#txtExpiryDate').focus();
            return false;
        }
        else if ($('#ddlVendor option:selected').val() == 0) {
            alert(alert_vendorname);
            $('#ddlVendor').focus();
            return false;
        }
        else if ($('#ddlLevel').val() == null) {
            alert(langData.alert_levelselect);
            $('#ddlLevel').focus();
            return false;
        }
        else if ($('#ddlAnalyte').val() == null) {
            alert(langData.alert_instrumentselect);
            $('#ddlAnalyte').focus();
            return false;
        }
        else {
            return true;
        }

    }


    $('#btnLotsUpdate').click(function() {
        var LotName;
        var LotNo;
        var MacID;
        var VendorID;
        var Description;
        var ExpiryDate;
        var Level;
        var Analyte;
        var AnalyteNAme;
        var IsExpired;
        LotName = $('#txtLotName').val();
        LotNo = $('#txtLotNo').val();
        MacID = $('#ddlManufacturer option:selected').val();
        VendorID = $('#ddlVendor option:selected').val();
        Description = $('#txtDescription').val();
        ExpiryDate = dateformat($('#txtExpiryDate').val(), 'YYYY/MM/DD');
        Level = $('#ddlLevel').val();

        Analyte = $('#ddlAnalyte').val();

        if (ValidateLotTab() == true) {

            AnalyteNAme = $("#ddlAnalyte option:selected").map(function() {
                return $(this).text();
            }).get();
            var LevelID = "";
            $.each(Level, function(idx, val) {
                if (idx == 0)
                { LevelID = LevelID + val }
                else {
                    LevelID = LevelID + '~' + val
                }
            })
            var LotMaster = [];
            if ($("#LotExpiryID").is(':checked'))
                IsExpired = 'Y';
            else
                IsExpired = 'N'
            LotMaster.push({
                LotID: hdnLotID.Value,
                LotName: LotName,
                LotCode: LotNo,
                MacID: MacID,
                VendorID: VendorID,
                ExpiryDate: ExpiryDate,
                IsExpired: IsExpired,
                DisplayText: Description
            });

            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../QMS.asmx/QMS_UpdateLotManagement",
                data: JSON.stringify({ LotMaster: LotMaster, AnalyteID: Analyte, AnalyteName: AnalyteNAme, LevelID: LevelID }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    btntype = null;
                    $('#btnLotsUpdate').hide();
                    $('#btnLotsSave').show();
                    LoadLotMasterDetails();
                    ClearLots();
                    alert(langData.alert_update);

                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }


            });
        }

    });
    $("#btnupdate").click(function() {
        var Vendorname;
        var Vendorcode;
        var PanNo;
        var SPOCName;
        var EmailId;
        var MobileNo;
        var Landlineno;
        var Faxno;
        var Country;
        var State;
        var city;
        var Postalcode;
        var Address;
        var terms;
        Vendorname = $("#txtVendorName").val();
        Vendorcode = $("#txtVendorCode").val();
        PanNo = $("#txtPanNo").val();
        SPOCName = $("#txtSpocName").val();
        EmailId = $("#txtEmailId").val();
        MobileNo = $("#txtMobileNo").val();
        Landlineno = $("#txtLandlineNo").val();
        Faxno = $("#txtFaxNo").val();
        Country = $("#ddlCountry option:selected").val();
        state = $("#ddlState option:selected").val();
        city = $("#txtCity").val();
        Postalcode = $("#txtPostalCode").val();
        Address = $("#txtAddress").val();
        terms = $("#txtTerms").val();
        var LotvendorMaster = [];
        if (Vendorname == "") {
            alert(langData.alert_vendorname);
            return false;
        }
        else if (Vendorcode == "") {
            alert(langData.alert_vendorcode);
            return false;
        }
        else if (EmailId == "") {
            alert(langData.alert_email);
            return false;
        }
        else if (SPOCName == "") {
            alert(langData.alert_spocname);
            return false;
        }
        else if ($('#ddlCountry').val() == "0") {
            alert(langData.alert_countryselect);
            return false;
        }
        else if ($('#ddlState').val() == "0") {
            alert(langData.alert_stateselect);
            return false;
        }
        else if ($('#txtCity').val() == "") {
        alert(langData.alert_cityselect);
            return false;
        }
        else if ($('#txtAddress').val() == "") {
            alert(langData.alert_vendoraddress);
            return false;
        }
        else if (EmailId != "") {
            if (!ValidateEmail(EmailId)) {
                alert(langData.alert_emailinvalid);
                return false;
            }
        }
        LotvendorMaster.push({
            Vendorcode: Vendorcode,
            VendorName: Vendorname,
            PanNo: PanNo,
            SPOCName: SPOCName,
            EmailID: EmailId,
            Mobileno: MobileNo,
            Landlineno: Landlineno,
            FaxNo: Faxno,
            CountryID: parseInt(Country) || 0,
            StateID: parseInt(state) || 0,
            // CityID: parseInt(city) || 0,
            PostalCode: Postalcode,
            TempAddress: Address,
            Termsandconditions: terms
        });
        $.ajax({
            type: "POST",
            contentType: "application/json;charset=utf-8",
            url: "../QMS.asmx/QMS_UpdateLotVendorMaster",
            data: JSON.stringify({ LotVendorMaster: LotvendorMaster, VendorID: hdnVendorID.value, city: city }),
            dataType: "JSON",
            async: false,
            success: function(data) {
                var Result = data.d;
                if (Result > 0) {
                    btntype = null;
                    $("#btnupdate").hide();
                    $("#btnSave").show();
                    LoadLotvendorDetails();
                    ClearVendor();
                    ddlManufacturer();
                    ddlVendor();
                    alert(langData.alert_save);
                }
            },
            error: function(xhr, status, error) {
                alert(xhr);
            }


        });

    });
    $("#ddlCountry").change(function() {
        var CountryID = $("#ddlCountry").val();
        if (CountryID != 0) {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../WebService.asmx/QMS_Loadlocalitiesdetails",
                data: JSON.stringify({ CountryID: CountryID }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    $('#ddlState').empty();
                    $("#ddlState").append($('<option></option>').val(0).html(langData.ddl_select));
                    if (data.d.length >= 0) {
                        var ArryLst = data.d;

                        $.each(ArryLst, function(ind, val) {
                            $('#ddlState').append('<option value="' + val.Locality_ID + '">' + val.Locality_Value + '</option>');

                        });

                    }
                    $('#txtCity').val('');
                    $('#txtPostalCode').val('');
                    $('#txtAddress').val('');
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }
            });
        } else {
            $('#ddlState').empty();
            $("#ddlState").append($('<option></option>').val(0).html(langData.ddl_select));
            $('#txtCity').val('');
            $('#txtPostalCode').val('');
            $('#txtAddress').val('');
        }
    });
    $("#ddlState").change(function() {
        var CountryID = $("#ddlState").val();
        if (CountryID != 0) {
            $.ajax({
                type: "POST",
                contentType: "application/json;charset=utf-8",
                url: "../WebService.asmx/QMS_Loadlocalitiesdetails",
                data: JSON.stringify({ CountryID: CountryID }),
                dataType: "JSON",
                async: false,
                success: function(data) {
                    $('#txtCity').empty();
                    $("#txtCity").append($('<option></option>').val(0).html(langData.ddl_select));
                    if (data.d.length >= 0) {
                        var ArryLst = data.d;


                        $.each(ArryLst, function(ind, val) {
                            $('#txtCity').append('<option value="' + val.Locality_ID + '">' + val.Locality_Value + '</option>');

                        });

                    }
                    $('#txtCity').val('');
                    $('#txtPostalCode').val('');
                    $('#txtAddress').val('');
                },
                error: function(xhr, status, error) {
                    alert(xhr);
                }
            });
        }
        else {
            $('#txtCity').val('');
            $('#txtPostalCode').val('');
            $('#txtAddress').val('');
        }
    });
});
function uniquevalues(ID, value,e) {


    var Testcode = $("#" + ID).val();
    var oVal = $("#"+ ID).attr('OVal');
    if (Testcode == "") {
        $('.Check_Testcode i').removeClass('fa fa-check');
        $('.Check_Testcode i').addClass('fa fa-question');
        //$("#btnSave").addClass('disabled');
    }
    else {
        if (btntype == 'update') {
            if (Testcode.toUpperCase() == oVal.toUpperCase()) {
                $('.Check_Testcode i').removeClass('fa fa-question');
                $('.Check_Testcode i').removeClass('fa fa-times');
                $('.Check_Testcode i').removeClass('NotOk');
                $('.Check_Testcode i').addClass('fa fa-check');
                $('.Check_Testcode i').addClass('Ok');
                $('.Check_Testcode').removeClass('btn-danger');
                $('.Check_Testcode').addClass('btn-success');
                $('.Check_Testcode').attr('error', 'N');
                $('#btnupdate').removeAttr("disabled");
                $('#btnManuFactUpdate').removeAttr("disabled");
                $('#btnLotsUpdate').removeAttr("disabled");
            }
            else {
                var ObjClientDevice = {};
                ObjClientDevice["DeviceID"] = value;
                ObjClientDevice["Testcode"] = Testcode;

            var returnCode = CheckDeviceID(ObjClientDevice, "../QMS.asmx/CheckTextCode");


            }
        }
        else {
            var ObjClientDevice = {};
            ObjClientDevice["DeviceID"] = value;
            ObjClientDevice["Testcode"] = Testcode;

            var returnCode = CheckDeviceID(ObjClientDevice, "../QMS.asmx/CheckTextCode");

        }

    }
}
function CheckDeviceID(ObjClient, URL) {
    var returnCode = true;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: URL,
        async: false,
        data: JSON.stringify(ObjClient),
        dataType: "json",
        success: function(data) {//On Successfull service call

            if (data.d == 'N') {

                $('.Check_Testcode i').removeClass('fa fa-question');
                $('.Check_Testcode i').removeClass('fa fa-check');
                $('.Check_Testcode i').removeClass('Ok');
                $('.Check_Testcode i').addClass('fa fa-times');
                $('.Check_Testcode i').addClass('NotOk');
                $('.Check_Testcode').addClass('btn-danger');
                $('#btnLotsSave').attr("disabled", "disabled");
                $('#btnSave').attr("disabled", "disabled");
                $('#btnManuFactSave').attr("disabled", "disabled");
                $('#btnupdate').attr("disabled", "disabled");
                $('#btnManuFactUpdate').attr("disabled", "disabled");
                $('#btnLotsUpdate').attr("disabled", "disabled");
                returnCode = false;
            }
            else if (data.d == 'Y') {
                $('.Check_Testcode i').removeClass('fa fa-question');
                $('.Check_Testcode i').removeClass('fa fa-times');
                $('.Check_Testcode i').removeClass('NotOk');
                $('.Check_Testcode').removeClass('btn-danger');
                $('.Check_Testcode i').addClass('fa fa-check');
                $('.Check_Testcode i').addClass('Ok');
                $('#btnLotsSave').removeAttr("disabled");
                $('#btnSave').removeAttr("disabled");
                $('#btnManuFactSave').removeAttr("disabled");
                $('#btnupdate').removeAttr("disabled");
                $('#btnManuFactUpdate').removeAttr("disabled");
                $('#btnLotsUpdate').removeAttr("disabled");
                returnCode = true;
            }


            //  alert(data.GetDDlDataResult[0].StateName);
        },
        error: function(result) {
            alert("Error");
        } // When Service call fails
    });
    return returnCode;
}
function Loadcountry() {
    var obj = {};
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../WebService.asmx/QMS_Loadcountrydetails",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $("#ddlCountry").append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlCountry').append('<option value="' + val.Locality_ID + '">' + val.Locality_Value + '</option>');
                    //$('#ddlDeviceName').append('option value="'+val.InstrumentID+'">'+val.InstrumentName+'</option>');
                });

            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }
    });
}
function ValidateEmail(email) {
    var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    if (expr.test(email)) {

        return true;

    }

    else {

        return false;

    }

};
function ddlManufacturer() {
    var obj = {};
    var Status = "Manufacturer"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/QMS_LoadDevicesManufacturer",
        data: JSON.stringify({ status: Status }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (data.d.length >= 0) {
                var ArryLst = data.d;
                $("#ddlManufacturer").empty();
                $("#ddlManufacturer").append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlManufacturer').append('<option value="' + val.MacID + '">' + val.ManufacturerName + '</option>');
                    //$('#ddlDeviceName').append('option value="'+val.InstrumentID+'">'+val.InstrumentName+'</option>');
                });

            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}
function ddlVendor() {
    var obj = {};
    var Status = "Vendor"
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/QMS_LoadVendorMaster",
        data: JSON.stringify({ status: Status }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            if (data.d.length >= 0) {
            $("#ddlVendor").empty();
                var ArryLst = data.d;
                $("#ddlVendor").append($('<option></option>').val(0).html(langData.ddl_select));
                $.each(ArryLst, function(ind, val) {
                    $('#ddlVendor').append('<option value="' + val.VendorID + '">' + val.VendorName + '</option>');
                    //$('#ddlDeviceName').append('option value="'+val.InstrumentID+'">'+val.InstrumentName+'</option>');
                });

            }
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}
function ddlAnalyte() {
    var obj = {};
    var Status = "Analyte"
    var resdata = [];
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/QMS_LoadAnalyteMaster",
        data: JSON.stringify({ status: Status }),
        dataType: "JSON",
        async: false,
        success: function(data) {
            val = data.d;
            var len = data.d.length;
            $.each(val, function(i, Zon) {
                var obj = new Object();
                var label = Zon.InstrumentName;
                var value = Zon.InstrumentID;
                obj = { label: label, value: value };
                resdata.push(obj);

            });

            $('#ddlAnalyte').multiselect('dataprovider', resdata);
        },
        error: function(xhr, status, error) {
            alert(xhr);
        }

    });
}
function LoadLotvendorDetails() {
    var obj = {};
    var Activestatus = {};
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/LoadLotvendorDetails",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
            var Items = data.d;
            var dtDayWCR = Items;
            if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                var parseJSONResult = JSON.parse(dtDayWCR);
                $('#VendorDetails').show();
                $('#tblVendorDetails  tbody > tr').remove();
                $('#tblVendorDetails').show();
                $('#tblVendorDetails').dataTable({
                    paging: true,
                     "language": {
                                 "url": dataTablePath
                                  },
                    data: parseJSONResult,
                    "fnDrawCallback": function() {
                        $('.vendor').bootstrapToggle();
                        $('.vendor').change(function() {
                            $('.vendor').bootstrapToggle();

                            //alert('Toggle: ' + $(this).prop('checked') + this.id)

                            if ($(this).prop('checked') == true) {
                                var vendorID = this.id;
                                Activestatus.Active = 'Y';
                                Activestatus.vendorID = vendorID
                                Activeuser(Activestatus);
                            }
                            else {
                                var vendorID = this.id;
                                Activestatus.Active = 'N';
                                Activestatus.vendorID = vendorID;
                                Activeuser(Activestatus);
                            }


                        })
                    },
                    "bDestroy": true,
                    "searchable": true,
                    "sort": true,

                    columns: [
                                            { 'data': 'VendorID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'VendorName' },
                                            { 'data': 'Vendorcode' },
                                            { 'data': 'SPOCName' },
                                            { 'data': 'PanNo', "sClass": "hide_Column"
                                            },
                                            { 'data': 'Landlineno', "sClass": "hide_Column" },
                                            { 'data': 'FaxNo', "sClass": "hide_Column" },
                                            { 'data': 'PostalCode', "sClass": "hide_Column" },
                                            { 'data': 'TempAddress', "sClass": "hide_Column" },
                                            { 'data': 'Termsandconditions', "sClass": "hide_Column" },
                                             { 'data': 'CountryID', "sClass": "hide_Column" },
                                              { 'data': 'StateID', "sClass": "hide_Column" },
                                               { 'data': 'CityID', "sClass": "hide_Column" },
                                            { 'data': 'EmailID' },
                                           { 'data': 'Mobileno' },
                                           { 'data': 'Locality_Value' },
                                            {
                                                'data': 'Edit',
                                                 "mRender": function(data, type, full, meta) {
                                                 return '<input value = "'+langData.Edit+'" '+full.Edit+' class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                 }
                                            },
                                            {
                                                'data': 'Delete',
                                                "sClass": "hide_Column"
                                            },
                                                {
                                                    'data': 'IsActive',
                                                    "ordering": true,
                                                    "mRender": function(data, type, full, meta) {

                                                        if (full.IsActive == 'Y') {

                                                            // your code as is
                                                            return '<input id= "' + full.VendorID + '" type="checkbox" class="vendor" data-on="' + langData.Active + '" data-width="70" checked data-onstyle="success" data-offstyle="danger" data-off="' + langData.InActive + '" name="chk" >';

                                                        }
                                                        else {
                                                            return '<input id= "' + full.VendorID + '" type="checkbox" class="vendor" data-on="' + langData.Active + '" data-width="70" unchecked data-onstyle="success" data-offstyle="danger" data-off="' + langData.InActive + '" name="chk" >';

                                                        }

                                                    }

                                                }

]

                });

                jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                $('#VendorDetails').addClass('show');
            }
            else {
                $('#tblVendorDetails').hide();
                $('#VendorDetails').hide();
                //alert('No matching record found!');

            }

        },
        error: function(xhr, status, error) {
            alert(xhr);
        }
    });
}
function Activeuser(Activestatus) {
    var obj = {};
    obj.Activationstatus = Activestatus.Active;
    obj.VendorID = Activestatus.vendorID;
    //obj.TestCode = Activestatus.Testcode;

    $.ajax({

        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/QMS_DeletelotVendormasterDetails",
        data: JSON.stringify(obj),
        dataType: "json",
        async: false,
        success: function(data) {
            if (data.d > 0) {
                
                LoadLotvendorDetails();
                ddlVendor();
                if(obj.Activationstatus=='N')
                {
                alert(langData.alert_deactivate);
                }
                else
                {
                alert(langData.alert_activate);
                }

            }


        },
        error: function(xhr, status, error) {
            alert(xhr);
        }



    });
}

function Edit_OnClick(ID) {
    btntype = 'update';
    var oTable = $("#tblVendorDetails").DataTable();
    var rowCount = $('#tblVendorDetails tr').length;
    var indexes = oTable.rows().eq(0).filter(function(rowIdx) {
        if (oTable.cell(rowIdx, 0).data() == ID) {
            var aData = oTable.rows(rowIdx).data();
            var VendorID = aData[0].VendorID;
            var VendorName = aData[0].VendorName;
            var SPOCName = aData[0].SPOCName;
            var EmailID = aData[0].EmailID;
            var Mobileno = aData[0].Mobileno;
            var Vendorcode = aData[0].Vendorcode;
            var FaxNo = aData[0].FaxNo;
            var Landlineno = aData[0].Landlineno;
            var PanNo = aData[0].PanNo;
            var PostalCode = aData[0].PostalCode;
            var TempAddress = aData[0].TempAddress;
            var Termsandconditions = aData[0].Termsandconditions;
            var CityID = aData[0].Locality_Value;
            var StateID = aData[0].StateID;
            var CountryID = aData[0].CountryID;
            if (CountryID != null) {
                $("#ddlCountry").val(CountryID);
                $("#ddlCountry").trigger("change");
                $("#ddlState").val(StateID);
                $("#ddlState").trigger("change");
                $("#txtCity").val(CityID);
            }
            hdnVendorID.value = VendorID;
            $("#txtVendorName").val(VendorName);
            $("#txtVendorCode").val(Vendorcode);
            $("#txtSpocName").val(SPOCName);
            $("#txtEmailId").val(EmailID);
            $("#txtMobileNo").val(Mobileno);
            $("#txtPanNo").val(PanNo);
            $("#txtLandlineNo").val(Landlineno);
            $("#txtFaxNo").val(FaxNo);
            $("#txtPostalCode").val(PostalCode);
            $("#txtAddress").val(TempAddress);
            $("#txtTerms").val(Termsandconditions);
            $("#btnupdate").show();
            $("#btnSave").hide();
            $('#txtVendorCode').attr('OVal', Vendorcode);
            //$('.active').trigger("click");
        }
    });
    $('.tab-scroll').animate({
   scrollTop:0
}, 500);
}
function ClearVendor() {
    //$('#btnsave').show();
    $btnSave.show();
    $btnupdate.hide();
    $("#txtVendorName").val("");
    $("#txtVendorCode").val("");
    $("#txtPanNo").val("");
    $("#txtSpocName").val("");
    $("#txtEmailId").val("");
    $("#txtMobileNo").val("");
    $("#txtLandlineNo").val("");
    $("#txtFaxNo").val("");
    $("#txtPostalCode").val("");
    $("#txtAddress").val("");
    $("#txtTerms").val("");
    $('#ddlCountry').val($("#ddlCountry option:first").val());
    $('#ddlState').empty();
    $("#ddlState").append($('<option></option>').val(0).html(langData.ddl_select));
   
    $("#txtCity").val("")
    $('#check_vendor i').addClass('fa fa-question');
    $('#check_vendor').removeClass('btn-danger').addClass('btn-success');
    $('#txtVendorCode').attr('OVal', '');
    $('#btnSave').removeAttr("disabled");
    $('#btnupdate').hide().removeAttr("disabled");

}
function LoadLotManufacturerDetails() {
    var obj = {};
    var Activestatus = {};
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/LoadLotManufacturerDetails",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
            var Items = data.d;
            var dtDayWCR = Items;
            if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                var parseJSONResult = JSON.parse(dtDayWCR);
                $('#Manufacturerdetails').show();
                $('#tblManufacturerdetails  tbody > tr').remove();
                $('#tblManufacturerdetails').show();
                $('#tblManufacturerdetails').dataTable({
                    paging: true,
                     "language": {
                                 "url": dataTablePath
                                  },
                    data: parseJSONResult,
                    "fnDrawCallback": function() {
                        $('.rgr').bootstrapToggle();
                        $('.rgr').change(function() {
                            $('.rgr').bootstrapToggle();

                            //alert('Toggle: ' + $(this).prop('checked') + this.id)

                            if ($(this).prop('checked') == true) {
                                var MacID = this.id;
                                Activestatus.Active = 'Y';
                                Activestatus.MacID = MacID
                                ActiveManufacturer(Activestatus);
                            }
                            else {
                                var MacID = this.id;
                                Activestatus.Active = 'N';
                                Activestatus.MacID = MacID;
                                ActiveManufacturer(Activestatus);
                            }


                        })
                    },
                    "bDestroy": true,
                    "searchable": true,
                    "sort": true,

                    columns: [
                                            { 'data': 'MacID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'ManufacturerName' },
                                            { 'data': 'ManufacturerCode' },
                                            { 'data': 'EmailID' },
                                            { 'data': 'MobileNo'
                                            },

                                            {
                                                'data': 'Edit',
                                                "mRender": function(data, type, full, meta) {
                                                
                                                return '<input value = "'+langData.Edit+'" ' +full.Edit+ ' class="deleteIcons1" type="button" style="background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer"  />';
                                                }
                                            },

                                                {
                                                    'data': 'IsActive',
                                                    "ordering": true,
                                                    "mRender": function(data, type, full, meta) {

                                                        if (full.IsActive == 'Y') {

                                                            // your code as is
                                                            return '<input id= "' + full.MacID + '" type="checkbox" class="rgr" data-on="'+langData.Active+'" data-width="70" checked data-onstyle="success" data-offstyle="danger" data-off="'+langData.InActive+'" name="chk" >';

                                                        }
                                                        else {
                                                            return '<input id= "' + full.MacID + '" type="checkbox" class="rgr" data-on="'+langData.Active+'" data-width="70" unchecked data-onstyle="success" data-offstyle="danger" data-off="'+langData.InActive+'" name="chk" >';

                                                        }

                                                    }

                                                }

]

                });

                jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                $('#Manufacturerdetails').addClass('show');
            }
            else {
                $('#tblManufacturerdetails').hide();
                $('#Manufacturerdetails').hide();
                //alert('No matching record found!');

            }

        },
        error: function(xhr, status, error) {
            alert(xhr);
        }
    });
}
function ActiveManufacturer(Activestatus) {
    var obj = {};
    obj.Activationstatus = Activestatus.Active;
    obj.MacID = Activestatus.MacID;
    //obj.TestCode = Activestatus.Testcode;

    $.ajax({

        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/QMS_DeletelotManufacturermasterDetails",
        data: JSON.stringify(obj),
        dataType: "json",
         async:false,
        success: function(data) {
            if (data.d > 0) {
//alert('sdfdf');
if(obj.Activationstatus=='N')
{
alert(langData.alert_deactivate);
                LoadLotManufacturerDetails();
                ddlManufacturer();
                }
                else
                {
               
                 LoadLotManufacturerDetails();
                 ddlManufacturer();
                  alert(langData.alert_activate);
                }

            }


        },
        error: function(xhr, status, error) {
            alert(xhr);
        }



    });
}
function Edit_OnClick1(ID) {
    btntype = 'update';
    var oTable = $("#tblManufacturerdetails").DataTable();
    var rowCount = $('#tblManufacturerdetails tr').length;
    var indexes = oTable.rows().eq(0).filter(function(rowIdx) {
        if (oTable.cell(rowIdx, 0).data() == ID) {
            var aData = oTable.rows(rowIdx).data();
            var MacID = aData[0].MacID;
            var ManufacturerName = aData[0].ManufacturerName;
            var ManufacturerCode = aData[0].ManufacturerCode;
            var EmailID = aData[0].EmailID;
            var Mobileno = aData[0].MobileNo;


            hdnMacID.value = MacID;
            $("#txtManufactName").val(ManufacturerName);
            $("#txtManufactCode").val(ManufacturerCode);
            $("#txtManufactEmail").val(EmailID);
            $("#txtManufactPhone").val(Mobileno);
            $('#txtManufactCode').attr('OVal', ManufacturerCode);
            $("#btnManuFactUpdate").show();
            $("#btnManuFactSave").hide();
        }
    });
     $('.tab-scroll').animate({
   scrollTop:0
}, 500);
}
function clear1() {
    $("#txtManufactName").val("");
    $("#txtManufactCode").val("");
    $("#txtManufactEmail").val("");
    $("#txtManufactPhone").val("");
    $('#Check_Manucode i').addClass('fa fa-question');
    $('#Check_Manucode').removeClass('btn-danger').addClass('btn-success');
    $btnmanusave.show().removeAttr("disabled");
    $btnmanuupdate.hide().removeAttr("disabled");
    $('#txtManufactCode').attr('OVal', '');
    
}
function ClearLots() {
    $('#txtLotName').val("");
    $('#txtLotNo').val("");
    $('#txtDescription').val("");
    $('#txtExpiryDate').val("");
    $('#ddlVendor').val($("#ddlVendor option:first").val());
    //    $('#ddlLevel').val($("#ddlLevel option:first").val());
    $("#ddlLevel option:selected").prop("selected", false);
    $("#ddlLevel").multiselect('refresh');
    $('#ddlManufacturer').val($("#ddlManufacturer option:first").val());
      $("#ddlAnalyte option:selected").prop("selected", false);
      $("#ddlAnalyte").multiselect('refresh');
      $('#LotExpiryID').closest('div').removeClass('checked');
      $('#Check_Testcode i').addClass('fa fa-question');
      $('#Check_Testcode').removeClass('btn-danger').addClass('btn-success');
    //$('#ddlVendor').val($("#ddlCountry option:first").val());
    $btnlotsave.show().removeAttr("disabled");
    $btnlotupdate.hide().removeAttr("disabled");
    $('#txtLotNo').attr('OVal', '');
}
function LoadLotMasterDetails() {
    var obj = {};
    var Activestatus = {};
    $.ajax({
        type: "POST",
        contentType: "application/json;charset=utf-8",
        url: "../QMS.asmx/LoadLotMasterDetails",
        data: JSON.stringify(obj),
        dataType: "JSON",
        async: false,
        success: function(data) {
            var Items = data.d;
            var dtDayWCR = Items;
            if (dtDayWCR.length > 0 && dtDayWCR != "[]") {
                var parseJSONResult = JSON.parse(dtDayWCR);
                $('#lotDetails').show();
                $('#tbllotDetails  tbody > tr').remove();
                $('#tbllotDetails').show();
                $('#tbllotDetails').dataTable({
                    paging: true,
                        "language": {
                                 "url": dataTablePath
                                  },
                    data: parseJSONResult,

                    "bDestroy": true,
                    "searchable": true,
                    "sort": true,

                    columns: [
                                            { 'data': 'LotID',
                                                "sClass": "hide_Column"

                                            },
                                            { 'data': 'LotName' },
                                            { 'data': 'LotCode' },
                                            { 'data': 'ManufacturerName' },
                                            { 'data': 'Level'
                                            },

                                            { 'data': 'InvestigationName' },
                                             {
                                                 'data': 'Description',
                                                 "sClass": "hide_Column"
                                             },
                                            { 'data': 'ExpiryDate',
                                                'render': function(JsonDate) {
                                                    var date = new Date(parseInt(JsonDate.substr(6)));
                                                    var month = date.getMonth() + 1;
                                                    return date.getDate() + "/" + month + "/" + date.getFullYear();
                                                }
                                            },
                                            { 'data': 'IsExpired' },
                                            { 'data': 'VendorName', "sClass": "hide_Column" },
                                            { 'data': 'MacID', "sClass": "hide_Column" },
                                             { 'data': 'vendorid', "sClass": "hide_Column" },

                                            {
                                                'data': 'Edit',
                                                "Default Content": 'Edit',
                                                "mRender": function(data, type, full, meta) {

                                                var txt = '<input value = "' + langData.Edit + '" ' + full.Edit + '  />';
                                                txt=txt+' /  '+'<input value = "'+langData.Delete+'" ' +full.Delete + '  />';
                                                return txt;
                                                }
                                            }

]

                });

                jQuery('.dataTable').wrap('<div class="dataTables_scroll" />');

                $('#lotDetails').addClass('show');
            }
            else {
                $('#tbllotDetails').hide();
                $('#lotDetails').hide();
                // alert('No matching record found!');

            }

        },
        error: function(xhr, status, error) {
            alert(xhr);
        }
    });
}
function ActualDate(JsonDate) {
    var date = new Date(parseInt(JsonDate.substr(6)));
    var month = date.getMonth() + 1;
    return date.getDate() + "/" + month + "/" + date.getFullYear();
}
function Edit_OnClic21(ID) {
    //debugger;
    ClearLots();
    btntype = 'update';

    var oTable = $("#tbllotDetails").DataTable();
    var rowCount = $('#tbllotDetails tr').length;
    var indexes = oTable.rows().eq(0).filter(function(rowIdx) {
        if (oTable.cell(rowIdx, 0).data() == ID) {
            var aData = oTable.rows(rowIdx).data();
            var LotID = aData[0].LotID;
            var LotName = aData[0].LotName;
            var Lotcode = aData[0].LotCode;
            var Manufacturer = aData[0].MacID;
            var vendor = aData[0].vendorid;
            var expiryDate = ActualDate(aData[0].ExpiryDate);
            var Levels = aData[0].Level;
            var Analyte = aData[0].InvestigationName;
            var LotExpiryAlert = aData[0].IsExpired;
            var Description = aData[0].Description;
            hdnLotID.Value = LotID;
            $('#txtLotName').val(LotName);
            $('#txtLotNo').val(Lotcode);
            $('#txtExpiryDate').val(expiryDate);
            $('#txtDescription').val(Description);
            $('#ddlManufacturer').val(Manufacturer);
            $("#ddlVendor").val(vendor);
            $('#txtLotNo').attr('OVal', Lotcode);
           // $("#ddlLevel").val(Level);
            if (LotExpiryAlert == 'Y') {
                $('#LotExpiryID').attr("checked", true);
                $('#LotExpiryID').closest('div').addClass('checked');
            }
            else {
                $('#LotExpiryID').attr("checked", false);
               $('#LotExpiryID').closest('div').removeClass('checked');
            }
            checkMultiselect(Analyte, "ddlAnalyte");
            checkMultiselect(Levels, "ddlLevel");
            $('#btnLotsUpdate').show();
            $('#btnLotsSave').hide();

        }
    });
     $('.tab-scroll').animate({
   scrollTop:0
}, 500);
}
function DeleteConfirm() {
    var objConfirm = langData.delete_confirm;
    if (confirm(objConfirm)) {
        return true;
    }
    return;
}
function ActiveLot(Activestatus) {
    if (DeleteConfirm()) {
        var obj = {};
        //obj.Activationstatus = Activestatus.Active;
        obj.LotID = Activestatus;
        //obj.TestCode = Activestatus.Testcode;

    $.ajax({

        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../QMS.asmx/QMS_DeletelotmasterDetails",
        data: JSON.stringify(obj),
        dataType: "json",
        async:false,
        success: function(data) {
            if (data.d > 0) {
               
                LoadLotMasterDetails();
                ClearLots();
                alert(langData.alert_delete);

            }


        },
        error: function(xhr, status, error) {
            alert(xhr);
        }



        });
    }
}



function LimitTextValidation(limitField, limitNum) {
    if (limitField.value.length > limitNum) {
        limitField.value = limitField.value.substring(0, limitNum);
    } else {
       // limitCount.value = limitNum - limitField.value.length;
    }

}

function onlyNos(e) {
    try {
        if (window.event) {
            var charCode = window.event.keyCode;
        }
        else if (e) {
            var charCode = e.which;
        }
        else { return true; }
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }
    catch (err) {
        alert(err.Description);
    }
}

function onlyAlphabets(e, t) {
    try {
        if (window.event) {
            var charCode = window.event.keyCode;
        }
        else if (e) {
            var charCode = e.which;
        }
        else { return true; }
        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123))
            return true;
        else
            //$('#errr').html("Only Accepts Alphabets..").show().fadeOut("slow");
            return false;
       //
            
    }
    catch (err) {
        alert(err.Description);
    }
}


function SpecialCharRestriction(e) {
    var regex = new RegExp("^[a-zA-Z0-9-]+$");
    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (regex.test(str)) {
        return true;
    }

    e.preventDefault();
    return false;
}

function SpecialCharRestrictionwithspace(e) {
    var regex = new RegExp("^[a-zA-Z0-9- !@#$%&*]+$");
    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (regex.test(str)) {
        return true;
    }

    e.preventDefault();
    return false;
}

function OnlyNumbers(e) {
    var regex = new RegExp("^[0-9-]+$");
    var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
    if (regex.test(str)) {
        return true;
    }

    e.preventDefault();
    return false;
}

    function validateEmailid(ID) {
    var email = $('#' + ID).val();
    if (!ValidateEmail(email)) {
        alert(langData.alert_emailinvalid);
        $('#' + ID).focus();
        return false;

    }


}
