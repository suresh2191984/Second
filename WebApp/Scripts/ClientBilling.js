$(document).ready(function() {
$('input[type="text"]').on('keypress', function(event) {
if (event.keyCode == 13) {
    event.preventDefault();
}
    });
    var Contextkey = document.getElementById('hdnOrgID').value + "~" + document.getElementById('hdnPatientID').value + "~" + "8" + "~" + document.getElementById('hdnClientID').value;
    $("#txtlabnumber").on('keyup', function() {
        if ($(this).val().length < 2 && $("#hdnPatientSelected").val() == "Y") {
            $("#hdnPatientSelected").val('N');
            EnabledTrue();
            clearPageControlsValue('Y');
        }

    });
    $('#ddlUnknownFlag').on('change', function() {
        var sexVal = $(this).val();
        if (sexVal == 0 || sexVal == 3) {
            document.getElementById('ddlSex').value = "0";
            document.getElementById('ddlSex').disabled = true;
            document.getElementById('imgddlSex').style.display = 'none';
            document.getElementById('txtDOBNos').value = "";
            document.getElementById('txtDOBNos').disabled = true;
            document.getElementById('imgAge').style.display = 'none';
            document.getElementById('imgDOB').style.display = 'none';
            document.getElementById('tDOB').disabled = true;
            document.getElementById('ddlDOBDWMY').disabled = true;
            
            
        }
        else if (sexVal == 2) {
            document.getElementById('ddlSex').value = "0";
            document.getElementById('ddlSex').disabled = true;
            document.getElementById('imgddlSex').style.display = 'none';
            document.getElementById('txtDOBNos').value = "";
            document.getElementById('txtDOBNos').disabled = false;
            document.getElementById('imgAge').style.display = 'block';
            document.getElementById('imgDOB').style.display = 'block';
            document.getElementById('tDOB').disabled = false;
            document.getElementById('ddlDOBDWMY').disabled = false;
        }
       else  if (sexVal == 1) {
           document.getElementById('ddlSex').value = "0";
           document.getElementById('ddlSex').disabled = false;
           document.getElementById('imgddlSex').style.display = 'block';
           document.getElementById('txtDOBNos').value = "";
           document.getElementById('txtDOBNos').disabled = true;
           document.getElementById('imgAge').style.display = 'none';
           document.getElementById('imgDOB').style.display = 'none';
           document.getElementById('tDOB').disabled = true;
           document.getElementById('ddlDOBDWMY').disabled = true;
       }


    });
    $("#txtlabnumber").autocomplete({
        source: function(request, response) {
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: '../OPIPBilling.asmx/GetLabQuickBillPatientListForClientBilling',
                data: JSON.stringify({ prefixText: request.term, count: 0, contextKey: Contextkey }),
                dataType: "json",
                success: function(data) {
                    if (data.d.length > 0) {

                        if ($("#hdnPatientSelected").val() == "Y") {

                            EnabledTrue();
                            clearPageControlsValue('Y');
                        }
                        $("#hdnPatientLabnumberList").val("Y");
                        var rsltcomments = '';
                        var rsltlable = '';
                        var rsltvalueSplit = [];
                        var Rslvalue = -1;

                        response($.map(data.d, function(item) {
                        data = JSON.parse(data.d);
                            rsltlable = data.First;
                            rsltcomments = data.Second;


                            return {
                                label: rsltlable,
                                val: rsltcomments
                            }
                        }))
                    }
                    else {
                        if ($("#hdnPatientSelected").val() == "Y") {

                            EnabledTrue();
                            clearPageControlsValue('Y');
                        }
                        $("#hdnPatientLabnumberList").val("N");
                        $("#hdnPatientSelected").val('N');
                    }

                },
                error: function(response) {
                    alert(response.responseText);
                },
                failure: function(response) {
                    alert(response.responseText);
                }
            });
        },

        //        select: function(e, i) {
        //            if (i.item.val != -1) {
        //               

        //                $("#hdnPatientLabNumber").val("Y");
        //                SelectedClientPatient1(i.item.val);
        //            }
        //        },


        minLength: 2
    });

    OnAutocompleteSelect();

});
//debugger;
// //trf upload mandatory
// var found = false;
function OnAutocompleteSelect() {

    $("#txtlabnumber").on("autocompleteselect", function(event, ui) {
        var value = ui.item.value.split(":");
        var city = value[0];
        $("#txtlabnumber").val(city);
        if (ui.item.val == -1) {
            $("#hdnPatientLabNumber").val("N");
            $('#hdnPatientSelected').val('N');
        }
        else {
            $('#hdnPatientLabNumber').val('Y');
            $('#hdnPatientSelected').val('Y');
            $("#hdnPatientLabnumberList").val("N");
            SelectedClientPatient1(ui.item.val);
            event.preventDefault();
        }
    });
}
function SelectedClientPatient1(eventArgs) {
    var vPatientDetails = SListForAppDisplay.Get("Billing_CommonBilling_js_69") == null ? "Patient Details" : SListForAppDisplay.Get("Billing_CommonBilling_js_69")
    var vPatientNo = SListForAppDisplay.Get("Billing_CommonBilling_js_68") == null ? "Patient No:" : SListForAppDisplay.Get("Billing_CommonBilling_js_68")
    var isPatientDetails = [];
    isPatientDetails = eventArgs.split('~');
    var LabNumber = isPatientDetails[48];
    var PatientName = isPatientDetails[1];
    var PatientNumber = isPatientDetails[43];
    var PatientVisitType = isPatientDetails[44];

    var PatientTITLECode = isPatientDetails[0];
    var PatientAge = isPatientDetails[3];
    var PatientDOB = isPatientDetails[4];
    var PatientSex = isPatientDetails[5];
    var PatientMaritalStatus = isPatientDetails[6];
    var PatientMobile = isPatientDetails[7].split(',')[0].trim();
    if (isPatientDetails[7].split(',')[1] != null) {
        var PatientPhone = isPatientDetails[7].split(',')[1].trim();
    }
    var PatientAddress = isPatientDetails[8];
    var PatientCity = isPatientDetails[9];
    var PostalCode = isPatientDetails[10];
    var PatientNationality = isPatientDetails[11];
    var PatientCountryID = isPatientDetails[12];
    var PatientStateID = isPatientDetails[13];
    var PatientID = isPatientDetails[14];
    var PatientEmailID = isPatientDetails[15];
    var URNNo = isPatientDetails[16];
    var URNofId = isPatientDetails[17];
    var URNTypeId = isPatientDetails[18];
    var VisitPurpose = 3
    var PatientPreviousDue = isPatientDetails[19];
    var Suburban = isPatientDetails[20];
    var ExternalPatientNumber = isPatientDetails[21];
    var PatientType = isPatientDetails[22];
    var PatientStatus = isPatientDetails[23];
    var NewOrgID = isPatientDetails[24];
    // var ClientName = isPatientDetails.split('~')[26];
    var PAtientVisitID = isPatientDetails[30];
    document.getElementById('hdnDoFrmVisit').value = PAtientVisitID;
    var PhleboName = isPatientDetails[35];
    var PhleboID = isPatientDetails[36];
    var RoundNo = isPatientDetails[37];
    var ExAutoAuthorization = isPatientDetails[38];
    var LogisticsID = isPatientDetails[39];
    var LogisticsName = isPatientDetails[40];
    var ZoneName = isPatientDetails[46];
    var ZoneID = isPatientDetails[45];
    var DispatchType = isPatientDetails[29];
    document.getElementById('txtLogistics').value = LogisticsName;
    document.getElementById('hdnLogisticsName').value = LogisticsName;
    document.getElementById('txtRoundNo').value = RoundNo;
    document.getElementById('hdnLogisticsID').value = LogisticsID;
    document.getElementById('hdnEditDDlDOB').value = PatientAge.split(' ')[1];
    document.getElementById('hdnPatientAge').value = PatientAge.split(' ')[0];
    document.getElementById('hdnEdtPatientAge').value = PatientAge.split(' ')[0];
    document.getElementById('hdnPatientDOB').value = PatientDOB;
    document.getElementById('hdnPatientSex').value = PatientSex;
    document.getElementById('hdnpatName').value = PatientName;

    document.getElementById('txtPhleboName').value = PhleboName;
    document.getElementById('HdnPhleboID').value = PhleboID;
    document.getElementById('HdnPhleboName').value = PhleboName;
    document.getElementById('hdnpatName').value = PatientName;


    document.getElementById('tDOB').value = PatientDOB;
    document.getElementById('txtzone').value = ZoneName;
    document.getElementById('hdnZoneID').value = ZoneID
    document.getElementById('hdnautoautz').value = ExAutoAuthorization
    if (DispatchType != undefined) {
        document.getElementById('hdnDispatch').value = DispatchType;
    }


    if (DispatchType != undefined) {
        var LstDispatchedtype = DispatchType.split(",");
        for (var j = 0; j < LstDispatchedtype.length; j++) {
            $('[id$="chkDespatchMode"] input[type=checkbox]').each(function(i) {
                if (($("#" + $(this).filter().context.id).next().text()) == LstDispatchedtype[j]) {
                    this.checked = true;
                }
            });
        }
    }


    if (document.getElementById('chkExcludeAutoathz') != null) {
        if (ExAutoAuthorization == 'Y') {
            document.getElementById('chkExcludeAutoathz').checked = true;
        }
        else {
            document.getElementById('chkExcludeAutoathz').checked = false;
        }
    }
    var ClientntName = isPatientDetails[41];
    var ClientID = isPatientDetails[42];
    document.getElementById('hdnSelectedClientClientID').value = ClientID;
    document.getElementById('txtClient').value = ClientntName;
    document.getElementById('hdnSelectedClientName').value = ClientntName;


    //  document.getElementById('hdnBookedID').value = isPatientDetails.split('~')[26];
    if (URNNo != "" && URNTypeId == 6) {
        SetDiscountLimit(URNNo);
    }

    document.getElementById('ddSalutation').value = PatientTITLECode
    document.getElementById('txtName').value = PatientName;
    document.getElementById('txtlabnumber').value = LabNumber;
    document.getElementById('hdnPatientNumber').value = PatientNumber
    document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
    document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
    document.getElementById('ddlSex').value = PatientSex;
    if (document.getElementById('hdnEditSex') != null) {
        document.getElementById('hdnEditSex').value = PatientSex;
    }

    document.getElementById('ddMarital').value = PatientMaritalStatus;
    document.getElementById('txtMobileNumber').value = PatientMobile;
    document.getElementById('hdnddlsalutation').value = PatientTITLECode;
    if (PatientPhone != null) {
        // document.getElementById('txtPhone').value = PatientPhone;
    }
    //document.getElementById('txtAddress').value = PatientAddress.trim();
    //document.getElementById('txtCity').value = PatientCity;
    if (PatientNationality != '') {
        if (document.getElementById('ddlNationality') != null) {
            document.getElementById('ddlNationality').value = PatientNationality;
        }
    }


    document.getElementById('ddCountry').value = PatientCountryID;
    //document.getElementById('ddCountry').onchange();
    document.getElementById('hdnPatientStateID').value = PatientStateID;
    document.getElementById('ddState').value = PatientStateID;
    if (PatientStateID == "") {
        loadState("11");
    }
    document.getElementById('hdnPatientID').value = PatientID;
    var textBox = $get('tDOB');
    //    if (textBox.AjaxControlToolkitTextBoxWrapper) {
    //        textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
    //    }
    //    else {
    //        textBox.value = PatientDOB;
    //    }
    //document.getElementById('txtPincode').value = PostalCode;
    document.getElementById('txtEmail').value = PatientEmailID;
    //document.getElementById('txtURNo').value = URNNo;
    //document.getElementById('hdnNewOrgID').value = NewOrgID;
    /////document.getElementById('ddlUrnoOf').value = URNofId;
    //document.getElementById('ddlUrnType').value = URNTypeId;
    //document.getElementById('lblPatientDetails').innerHTML = '';
    //document.getElementById('trPatientDetails').style.display = "none";
    if (document.getElementById('hdnClientPortal') != null) {
        if (document.getElementById('hdnClientPortal').value != 'Y') {
            if (document.getElementById('txtClient') != null) {
                document.getElementById('txtClient').focus();
            }
        }
    }
    //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
    if (document.getElementById('billPart_lblPreviousDueText') != null) {
        document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
    }
    if (document.getElementById('txtSuburban') != null) {
        document.getElementById('txtSuburban').value = Suburban;
    }
    if (document.getElementById('txtExternalPatientNumber') != null) {
        document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
    }
    var panelLegend = $('#PnlPatientDetail legend');
    panelLegend.html(vPatientDetails).append('<b>('+ vPatientNo +  PatientNumber +   ')</b>');
    document.getElementById('PnlPatientDetail');
    document.getElementById('hdnPatientName').value = PatientName;
    document.getElementById('hdnPatientID').value = PatientID;
    LoadPreviousBillingItemsForClientPatient();

    document.getElementById('hdnPatientID').value = PatientID;
    var ReferingPhysicianName = isPatientDetails[25];
    var HospitalName = isPatientDetails[26];
    if (HospitalName != undefined) {
        document.getElementById('txtInternalExternalPhysician').value = ReferingPhysicianName;
    }
    if (ReferingPhysicianName != undefined) {
        document.getElementById('txtReferringHospital').value = HospitalName;
    }

    EnabledFalse();
}
function clearPageControlsValue(ClearType) {

    if (document.getElementById('hdnlabnumber').value == "Y") 
    {
        document.getElementById('txtName').disabled = false;

       
    }

    if (ClearType == "N") {
        document.getElementById('txtName').value = "";
        if (document.getElementById('txtName') != null) {
            try {
                document.getElementById('txtName').focus();
            }
            catch (err) { }
        }
    }
    document.getElementById('txtDOBNos').value = "";
    document.getElementById('tDOB').value = "";
    document.getElementById('txtReferringHospital').value = "";
    document.getElementById('ddlSex').value = "0";
    document.getElementById('ddlDOBDWMY').value = "Year(s)";
    document.getElementById('txtInternalExternalPhysician').value = "";
    document.getElementById('hdnReferralType').value = "0";
    document.getElementById('hdnPatientLabNumber').value = "";
    document.getElementById('hdnPatientLabnumberList').value = "N";
    if (document.getElementById('hdnClientPortal') != null) {
        if (document.getElementById('hdnClientPortal').value != 'Y') {
            if (document.getElementById('hdnLocationClient').value != 'Y') {
                if ((document.getElementById('hdnDefaultClienID') != null) && (document.getElementById('hdnDefaultClienName') != null)) {
                    if ((document.getElementById('hdnDefaultClienID').value == "") ||
                         ((document.getElementById('hdnDefaultClienName').value != "") && (document.getElementById('hdnDefaultClienName').value != document.getElementById('txtClient').value))) {
                        document.getElementById('txtClient').value = "";
                    }
                }
                else {
                    document.getElementById('txtClient').value = "";
                }
                document.getElementById('txtClient').value = "";
            }
        }
    }
    document.getElementById('txtEmail').value = "";
    document.getElementById('chkMobileNotify').checked = false;
    document.getElementById('txtExternalPatientNumber').value = "";
    document.getElementById('hdnGuID').value = "";
    document.getElementById('hdnClientBalanceAmount').value = "-1";
    document.getElementById('hdnIsCashClient').value = "N";
    document.getElementById('hdnIsEditMode').value = "N";
    document.getElementById('txtRoundNo').value = "";
    document.getElementById('hdnPatientName').value = "";
    var panelLegend = $('#PnlPatientDetail legend');
    panelLegend.html("Patient Details ").append('');

    document.getElementById('ChkTRFImage').checked = false;
    document.getElementById('hdnOPIP').value = "OP";
    document.getElementById('hdnPreviousVisitDetails').value = '';
    document.getElementById('hdnPatientID').value = "-1";
    document.getElementById('hdnVisitPurposeID').value = "-1";
    document.getElementById('hdnClientID').value = "-1";
    document.getElementById('hdnTPAID').value = "-1";
    document.getElementById('hdnClientType').value = "CRP";
    document.getElementById('hdnReferedPhyID').value = "0";
    document.getElementById('hdnReferedPhyName').value = "";
    document.getElementById('hdnReferedPhysicianCode').value = "0";
    document.getElementById('hdnReferedPhyType').value = "";
    document.getElementById('hdnBillGenerate').value = "N";
    document.getElementById('hdnLstPatientInvSample').value = "";
    document.getElementById('hdnLstSampleTracker').value = "";
    document.getElementById('hdnLstPatientInvSampleMapping').value = "";
    document.getElementById('hdnLstInvestigationValues').value = "";
    document.getElementById('hdnLstCollectedSampleStatus').value = "";
    document.getElementById('hdnPatientAlreadyExists').value = 0;
    document.getElementById('hdnPatientAlreadyExistsWebCall').value = 0;
    document.getElementById('hdnVisitID').value = "-1";
    document.getElementById('hdnFinalBillID').value = "-1";
    document.getElementById('hdnCashClient').value = "";
    if (document.getElementById('hdnClientPortal').value != 'Y') {
        if (document.getElementById('hdnLocationClient').value != 'Y') {
            if ((document.getElementById('hdnDefaultClienID') != null) && (document.getElementById('hdnDefaultClienName') != null)) {
                if ((document.getElementById('hdnDefaultClienID').value == "") ||
                        ((document.getElementById('hdnDefaultClienName').value != "") && (document.getElementById('hdnDefaultClienName').value != document.getElementById('txtClient').value))) {

                    document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnDefaultClienID').value;
                }
            }
            else {
                document.getElementById('hdnSelectedClientClientID').value = document.getElementById('hdnBaseClientID').value;
            }

            document.getElementById('txtClient').disabled = false;
        }
    }
    document.getElementById('hdnRateID').value = document.getElementById('hdnBaseRateID').value;
    document.getElementById('hdnMappingClientID').value = "-1";
    document.getElementById('hdnIsMappedItem').value = "N";
    document.getElementById('hdfReferalHospitalID').value = "0";

    document.getElementById('hdnTodayVisitID').value = "0";
    document.getElementById('hdnTempTodayVisitID').value = "0";
    document.getElementById('tdVisitType1').style.display = "none";
    document.getElementById('tdVisitType2').style.display = "none";

    document.getElementById('lblPreviousItems').innerHTML = "";
    document.getElementById('ShowBillingItems').style.display = "none";
    document.getElementById('ShowPreviousData').style.display = "none";

    document.getElementById('txtMobileNumber').value = "";

    //    var dt = new Date();
    //    var dt1 = document.getElementById('hdnOrgDateTimeZone').value;
    //    var pDatearray = dt1.split(' ');
    //    var pDate = pDatearray[0];
    //    var pTimearray = pDatearray[1];
    //    var pHour = pTimearray[1];
    //    var pMinute = pTimearray[2];


    //    document.getElementById('txtSampleDate').value = pDate;
    //    //var time = dt.getHours() + ":" + dt.getMinutes() + ":" + dt.getSeconds();
    //    document.getElementById('txtSampleDate').value = dt1.format('dd/MM/yyyy')
    //    document.getElementById('txtSampleTime22').value = dt1.getMinutes();

    //    var hours24 = dt.getHours(); 
    //    var hours= ((hours24 + 11) % 12) + 1;
    //    var TimeType = hours24 > 11 ? 'PM' : 'AM';

    //    document.getElementById('txtSampleTime11').value = dt1.format('hh');
    //    document.getElementById('ddlSampleTimeType1').value = dt1.format('tt');



    if (document.getElementsByName('rblSearchType') != null) {
        var searchtypeRadioList = document.getElementsByName('rblSearchType');
        for (var i = 0; i < searchtypeRadioList.length; i++) {
            if (searchtypeRadioList[i].checked) {
                searchtype = searchtypeRadioList[i].value
                break;
            }
        }
        if (searchtype == 4) {
            document.getElementById('txtName').setAttribute('autocomplete', 'off');
            if ($find('AutoCompleteExtenderPatient') != null) {
                $find('AutoCompleteExtenderPatient').set_contextKey('');
            }
        }
    }
    document.getElementById('hdnpatName').value = "";

    //    document.getElementById('txtSampleDate').value = "";
    //    document.getElementById('txtSampleTime1').value = "";
    //    document.getElementById('txtSampleTime2').value = "";
    //    document.getElementById('ddlSampleTimeType').value = "AM";
    document.getElementById('hdnDoFrmVisit').value = 0;
    document.getElementById('hdnSampleforPrevious').value = "";
    clearBillPartValues();
}
function clearDespatchMode() {
    $('[id$="chkDespatchMode"] input[type=checkbox]:checked').each(function() {
        $('[id$="chkDespatchMode"] input[type=checkbox]:checked').attr('checked', false);
    });
}

function ValidateSampleDate() {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ClientBilling_js_01") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_01") : "Alert";
    var UsrAlrtMsg23 = SListForAppMsg.Get("Scripts_ClientBilling_js_23") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_23") : "Provide Validate Sample pick up date";
    var UsrAlrtMsg24 = SListForAppMsg.Get("Scripts_ClientBilling_js_24") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_24") : "Provide Validate Sample pick up Time";

    var SampleDate;
    var SampleTime;
    var SampleTimeType;
    var Sampledt, Sampletm;
    var Sdt, Edt;
    var Stm, Etm;
    Sdt = "01/01/1900";
    Edt = "01/01/2100";
    Stm = "01:00:00";
    Etm = "12:59:00";

    SampleDate = document.getElementById('txtSampleDate').value.trim();
    SampleTime = document.getElementById('txtSampleTime11').value.trim();
    SampleTimeType = document.getElementById('ddlSampleTimeType1').options[document.getElementById('ddlSampleTimeType1').selectedIndex].value;
    Sampledt = SampleDate;
    Sampletm = SampleTime + ":00";
    if (Date.parse(Sampledt) < Date.parse(Sd) || Date.parse(Sampledt) > Date.parse(Edt)) {
        ValidationWindow(UsrAlrtMsg23, AlrtWinHdr);
        document.getElementById('txtSampleDate').focus();
        return false;
    }
    if (Date.parse(Sampletm) < Date.parse(Stm) || Date.parse(Sampletm) > Date.parse(Etm)) {
        ValidationWindow(UsrAlrtMsg24, AlrtWinHdr);
        document.getElementById('txtSampleTime11').focus();
        return false;
    }
}
function ValidateTime(Obj) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ClientBilling_js_01") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_01") : "Alert";
    var UsrAlrtMsg25 = SListForAppMsg.Get("Scripts_ClientBilling_js_25") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_25") : "Provide Valid pick up time(hour)";
    var UsrAlrtMsg26 = SListForAppMsg.Get("Scripts_ClientBilling_js_26") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_26") : "Provide Valid pick up time(minutes)";
    if (Obj.id == 'txtSampleTime11') {
        if (Obj.value == "") {
            document.getElementById('txtSampleTime11').value = "12";
        }
        else if (Obj.value > 12 || Obj.value <= 0) {
            document.getElementById('txtSampleTime11').value = "";
            document.getElementById('txtSampleTime11').focus();
            ValidationWindow(UsrAlrtMsg25, AlrtWinHdr);
        }
    }
    if (Obj.id == 'txtSampleTime22') {
        if (Obj.value == "") {
            document.getElementById('txtSampleTime22').value = "00";
        }
        else if (Obj.value > 59 || Obj.value < 0) {
            document.getElementById('txtSampleTime22').value = "";
            document.getElementById('txtSampleTime22').focus();
            ValidationWindow(UsrAlrtMsg26, AlrtWinHdr);
        }
    }
}

function validateForClient() {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ClientBilling_js_01") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ClientBilling_js_02") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_02") : "Provide patient name";
    var UsrAlrtMsg1 = SListForAppMsg.Get("Scripts_ClientBilling_js_03") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_03") : "Provide patient age";
    var UsrAlrtMsg3 = SListForAppMsg.Get("Scripts_ClientBilling_js_05") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_05") : "Select patient sex";
    var UsrAlrtMsg5 = SListForAppMsg.Get("Scripts_ClientBilling_js_07") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_07") : "Provide Client name";
    var UsrAlrtMsg23 = SListForAppMsg.Get("Scripts_ClientBilling_js_23") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_23") : "Provide Validate Sample pick up date";

    document.getElementById('billPart_hdnValidation').value = 'Y';
    if (document.getElementById('txtName').value.trim() == '') 
    {

        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        document.getElementById('txtName').focus();
        return false;
    }
    if (document.getElementById('hdnDoFrmVisit').value != "") 
    {
        if (document.getElementById('chkIncomplete').checked != true) 
        {
            if (document.getElementById('txtDOBNos').value.trim() == '') 
            {
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") 
            {
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                document.getElementById('ddlSex').focus();
                return false;
            }
        }
        else {


            if (document.getElementById('ddlUnknownFlag').options[document.getElementById('ddlUnknownFlag').selectedIndex].value != "0" && document.getElementById('ddlUnknownFlag').options[document.getElementById('ddlUnknownFlag').selectedIndex].value != "3")
             {

                 if (document.getElementById('txtDOBNos').value.trim() == '' && document.getElementById('ddlUnknownFlag').options[document.getElementById('ddlUnknownFlag').selectedIndex].value != "1") 
                 {
                     ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                     document.getElementById('txtDOBNos').focus();
                     return false;
                 }
                 if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0" && document.getElementById('ddlUnknownFlag').options[document.getElementById('ddlUnknownFlag').selectedIndex].value != "2") 
                 {
                     ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                     document.getElementById('ddlSex').focus();
                     return false;
                 } 
             }
                
          }
    }
    else {
        if (document.getElementById('txtDOBNos').value.trim() == '') {
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            document.getElementById('ddlSex').focus();
            return false;
        }
    }
//    if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0")
//     {
//        alert('Select patient sex');
//        document.getElementById('ddlSex').focus();
//        return false;
//    }

    if (document.getElementById('txtClient').value.trim() == '') {
        ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
        document.getElementById('txtClient').focus();
        return false;
    }
    if (document.getElementById('txtSampleDate').value.trim() == '') {
        ValidationWindow(UsrAlrtMsg23, AlrtWinHdr);
        document.getElementById('txtSampleDate').focus();
        return false;
    }



    if (document.getElementById('hdnRoundNo').value == 'Y') {
        if (document.getElementById('txtRoundNo').value.trim() == '') {
            alert('Provide Round No');
            document.getElementById('txtRoundNo').focus();
            return false;
        }
    }


}
function validateEvents(obj) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ClientBilling_js_01") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ClientBilling_js_02") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_02") : "Provide patient name";
    var UsrAlrtMsg1 = SListForAppMsg.Get("Scripts_ClientBilling_js_03") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_03") : "Provide patient age";
    var UsrAlrtMsg2 = SListForAppMsg.Get("Scripts_ClientBilling_js_04") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_04") : "Provide Proper Age";
    var UsrAlrtMsg3 = SListForAppMsg.Get("Scripts_ClientBilling_js_05") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_05") : "Select patient sex";
    var UsrAlrtMsg4 = SListForAppMsg.Get("Scripts_ClientBilling_js_06") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_06") : "Provide Sample pick up Time";
    var UsrAlrtMsg5 = SListForAppMsg.Get("Scripts_ClientBilling_js_07") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_07") : "Provide Client name";
    var UsrAlrtMsg6 = SListForAppMsg.Get("Scripts_ClientBilling_js_08") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_08") : "Provide a valid e-mail address";
    var UsrAlrtMsg7 = SListForAppMsg.Get("Scripts_ClientBilling_js_09") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_09") : "You select dispatch mode as E-mail , Provide e-mail address";
    var UsrAlrtMsg8 = SListForAppMsg.Get("Scripts_ClientBilling_js_10") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_10") : "You select dispatch mode as sms , Provide contact mobile number";
    var UsrAlrtMsg9 = SListForAppMsg.Get("Scripts_ClientBilling_js_11") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_11") : "Include billing items";
    var UsrAlrtMsg10 = SListForAppMsg.Get("Scripts_ClientBilling_js_12") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_12") : "Provide discount authorised by";
    var UsrAlrtMsg11 = SListForAppMsg.Get("Scripts_ClientBilling_js_13") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_13") : "Provide discount reason";
    var UsrAlrtMsg12 = SListForAppMsg.Get("Scripts_ClientBilling_js_14") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_14") : "Insufficient balance, Please deposit the advance amount";
    var UsrAlrtMsg13 = SListForAppMsg.Get("Scripts_ClientBilling_js_15") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_15") : "Second Alert:Threshold value exceed";
    var UsrAlrtMsg14 = SListForAppMsg.Get("Scripts_ClientBilling_js_16") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_16") : "First Alert: Threshold value exceed";

    var UsrAlrtMsg16 = SListForAppMsg.Get("Scripts_ClientBilling_js_27") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_27") : "Credit Limit Days has Expired !";

    var UsrAlrtMsg15 = SListForAppMsg.Get("Scripts_ClientBilling_js_22") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_22") : "Provide Lab Number";
    var UsrAlrtMsg17 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_07") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_07") : "Credit Limit Exceeds";
    var UsrAlrtMsg18 = SListForAppMsg.Get("Scripts_LabQuickBilling_js_08") != null ? SListForAppMsg.Get("Scripts_LabQuickBilling_js_08") : "Third Alert: Threshold value exceed";
    
    document.getElementById('billPart_hdnValidation').value = 'Y';


   // if (document.getElementById('txtlabnumber').value.trim() == '' && document.getElementById('hdnlabnumber').value == "Y") {
        //alert('Provide patient name');
   //     ValidationWindow(UsrAlrtMsg15, AlrtWinHdr);
   //     document.getElementById('txtName').focus();
    //    return false;
  //  }
    
    
    if (document.getElementById('txtName').value.trim() == '') {
        //alert('Provide patient name');
        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        document.getElementById('txtName').focus();
        return false;
    }

    if (document.getElementById('hdnDoFrmVisit').value != "") {
        if (document.getElementById('chkIncomplete').checked != true) {
            if (document.getElementById('txtDOBNos').value.trim() == '') {
                // alert('Provide patient age');
                ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            if (document.getElementById('txtDOBNos').value.trim() == 'NaN') {
                // alert('Provode Proper Age');
                ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                document.getElementById('txtDOBNos').focus();
                return false;
            }
            if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
                // alert('Select patient sex');
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                document.getElementById('ddlSex').focus();
                return false;
            }
        }
    }
    else {
        if (document.getElementById('txtDOBNos').value.trim() == '') {
            // alert('Provide patient age');
            ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('txtDOBNos').value.trim() == 'NaN') {
            //alert('Provode Proper Age');
            ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
            document.getElementById('txtDOBNos').focus();
            return false;
        }
        if (document.getElementById('ddlSex').options[document.getElementById('ddlSex').selectedIndex].value == "0") {
            // alert('Select patient sex');
            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            document.getElementById('ddlSex').focus();
            return false;
        }
    }
    //trf upload mandatory
  //  debugger;
    // if ($('#hdnConfigTRFMandatory').val() == "Y") {
        // var istrfavail = uploadtrfvalidation();
        // if (!istrfavail) {
            // return istrfavail;
        // }
    // }
    //
    if (document.getElementById('txtSampleTime11').value.trim() == '') {
       // alert('Provide Sample pick up Time');
        ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
        document.getElementById('txtSampleTime11').focus();
        return false;
    }
    if (document.getElementById('txtClient').value.trim() == '') {
        //alert('Provide Client name');
        ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
        document.getElementById('txtClient').focus();
        return false;
    }
    if ($.trim($('#txtEmail').val()) != '') {
        var x = document.getElementById('txtEmail').value;
        var atpos = x.indexOf("@");
        var dotpos = x.lastIndexOf(".");
        if (atpos < 1 || dotpos < atpos + 2 || dotpos + 2 >= x.length) {
            //alert("Provide a valid e-mail address");
            ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
            $('#txtEmail').focus();
            return false;
        }
    }
    // var elements = document.getElementById('chkDespatchMode');
    //   if (elements != null) {
    //    for (i = 0; i < elements.rows[0].cells.length; i++) {
    //        if (elements.cells[i].childNodes[0].checked) {
    //        
    //            if (document.getElementById('chkDespatchMode').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "email") {
    //                if (document.getElementById('txtEmail').value.trim() == '') {
    //                    alert("You select despatch mode as E-mail , Provide e-mail address");
    //                    document.getElementById('txtEmail').focus();
    //                    return false;
    //                }
    //            }
    //            if (document.getElementById('chkDespatchMode').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "sms") {
    //                if (document.getElementById('txtMobileNumber').value.trim() == '') {
    //                    alert('You select despatch mode as sms , Provide contact mobile number');
    //                    document.getElementById('txtMobileNumber').focus();
    //                    return false;
    //                }
    //            }
    //            if (document.getElementById('chkDespatchMode').childNodes[0].childNodes[0].cells[i].innerText.toLowerCase() == "courier") {
    //                if (document.getElementById('txtAddress').value.trim() == '') {
    //                    alert("You select despatch mode as courier , Provide address");
    //                    document.getElementById('txtAddress').focus();
    //                    return false;
    //                }
    //                if (document.getElementById('txtCity').value.trim() == '') {
    //                    alert("You select despatch mode as courier , Provide city");
    //                    document.getElementById('txtCity').focus();
    //                    return false;
    //                }
    //                if (document.getElementById('txtPincode').value.trim() == '') {
    //                    alert("You select despatch mode as courier , Provide pincode");
    //                    document.getElementById('txtPincode').focus();
    //                    return false;
    //                }
    //            }
    //         }

    //        }
    //    }
    var elements = document.getElementById('chkDespatchMode');
    if (elements != null) {
        var elements0 = document.getElementById('chkDespatchMode_0');
        var elements1 = document.getElementById('chkDespatchMode_1');
        // var elements2 = document.getElementById('chkDespatchMode_2');
        if (elements0.checked) {
            //  alert('hai');
            if (document.getElementById('txtEmail').value.trim() == '') {
               // alert("You select despatch mode as E-mail , Provide e-mail address");
                ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
                document.getElementById('txtEmail').focus();
                return false;
            }
        }
        if (elements1.checked) {
            if (document.getElementById('txtMobileNumber').value.trim() == '') {
               // alert('You select despatch mode as sms , Provide contact mobile number');
                ValidationWindow(UsrAlrtMsg8, AlrtWinHdr);
                document.getElementById('txtMobileNumber').focus();
                return false;
            }
        }
    }
    if ($.trim($('[id$="hdfBillType1"]').val()) == '' && obj != 'Before') {
        //alert('Include billing items');
        ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
        $('[id$="txtTestName"]').focus();
        return false;
    }
    if (Number($('[id$="hdnDiscountAmt"]').val()) > 0) {
        if ($('[id$="txtAuthorised"]').val() == '') {
            //alert('Provide discount authorised by');
            ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
            $('[id$="txtAuthorised"]').focus();
            return false;
        }
        if ($('[id$="hdnDiscountReason"]').val() == '') {
           // alert('Provide discount reason');
            ValidationWindow(UsrAlrtMsg11, AlrtWinHdr);
            $('[id$="ddlDiscountReason"]').focus();
            return false;
        }
    }
    var hdnAdvanceClient = $('[id$="hdnAdvanceClient"]').val();
    var hdnTotalDepositAmount = $('[id$="hdnTotalDepositAmount"]').val();
    var hdnTotalDepositUsed = $('[id$="hdnTotalDepositUsed"]').val();
    var hdnAvailDepositAmt = $('[id$="hdnAvailDepositAmt"]').val();

    var hdncreditlimit1 = $('[id$="hdnCreditLimit"]').val();
    var PendingCreditLimit = $('[id$="hdnTotalCreditLimit"]').val();
    var NotInvoicedAmt = $('[id$="hdnTotalCreditUsed"]').val();
    var hdnCreditExpiresdays = $('[id$="hdnCreditExpires"]').val();

    var hdnThresholdType = $('[id$="hdnThresholdType"]').val();
    var hdnThresholdValue = $('[id$="hdnThresholdValue"]').val();
    var hdnThresholdValue2 = $('[id$="hdnThresholdValue2"]').val();
    var hdnThresholdValue3 = $('[id$="hdnThresholdValue3"]').val();
    var hdnVirtualCreditType = $('[id$="hdnVirtualCreditType"]').val();
    var hdnVirtualCreditValue = $('[id$="hdnVirtualCreditValue"]').val();
    var hdnNetAmount = $('[id$="hdnNetAmount"]').val();
    var hdnIsBlockReg = $('[id$="hdnIsBlockReg"]').val();
    
    var virtualVal = 0;
    var depositAmountFlag = 0;
    var hdnCLP = $('[id$="hdnCLP"]').val();
    if (hdnCLP.trim() == 1) {
        if ((parseInt(hdnAvailDepositAmt) < parseInt(hdnNetAmount)) || ((parseInt(hdnAvailDepositAmt) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue3))) {
            //alert('Insufficient balance, Please deposit the advance amount');
            ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
            depositAmountFlag = "1";
            return false;
        }

        else if ((parseInt(hdnAvailDepositAmt) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue2)) {
        // alert('Second Alert:Threshold value exceed');
        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);

        }
        else if ((parseInt(hdnAvailDepositAmt) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue)) {
        //alert('First Alert: Threshold value exceed');
        ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);

        }
    } else if (hdncreditlimit1 > 0) {

             if (parseInt(hdnCreditExpiresdays) < 0) {
                ValidationWindow(UsrAlrtMsg16, AlrtWinHdr);
                return false;
             }
             if ((parseInt(PendingCreditLimit) < parseInt(hdnNetAmount))) {
                 ValidationWindow(UsrAlrtMsg17, AlrtWinHdr);
                 depositAmountFlag = "1";
             }
    
            else if ( ((parseInt(PendingCreditLimit) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue3))) {
               
                ValidationWindow(UsrAlrtMsg18, AlrtWinHdr);
                if (hdnIsBlockReg == 'Y') {
                    depositAmountFlag = "1";
                }
                
            }

            else if ((parseInt(PendingCreditLimit) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue2)) {
                //alert('Second Alert:Threshold value exceed');
                ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                //return false;
            }
            else if ((parseInt(PendingCreditLimit) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue)) {
                // alert('First Alert: Threshold value exceed');
                ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                //return false;
            }
    }
    else {
        try {
            //debugger;
            if (hdnAdvanceClient.trim() == 1) {
                $.ajax({
                    type: "POST",
                    url: "../OPIPBilling.asmx/GetAdvanceAmountDetails",
                    data: "{ 'collectionID': '" + parseInt(document.getElementById('hdnCollectionID').value) + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    async: false,
                    success: function(data) {

                        var ArrayItems = data.d;
                        var Items = ArrayItems[0];
                        var SamplesItems = ArrayItems[1];
                        var TotalAvailablebalance = 0
                        hdnTotalDepositAmount = Items.TotalDepositAmount;
                        hdnTotalDepositUsed = Items.TotalDepositUsed;
                        TotalAvailablebalance = Items.AmtRefund
                        if ((parseInt(TotalAvailablebalance) < parseInt(hdnNetAmount)) || ((parseInt(TotalAvailablebalance) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue3))) {
                           // alert('Insufficient balance, Please deposit the advance amount');
                            ValidationWindow(UsrAlrtMsg12, AlrtWinHdr);
                            depositAmountFlag = "1";
                            return false;
                        }

                        else if ((parseInt(TotalAvailablebalance) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue2)) {
                        //alert('Second Alert:Threshold value exceed');
                        ValidationWindow(UsrAlrtMsg13, AlrtWinHdr);
                            return false;
                        }
                        else if ((parseInt(TotalAvailablebalance) - parseInt(hdnNetAmount)) < parseInt(hdnThresholdValue)) {
                        // alert('First Alert: Threshold value exceed');
                        ValidationWindow(UsrAlrtMsg14, AlrtWinHdr);
                            return false;
                        }

                    },
                    failure: function(msg) {
                        ShowErrorMessage(msg);
                    }
                });
                //parseInt(hdnTotalDepositUsed)- parseInt(hdnNetAmount)
            }
        }
        catch (e) {
        }
    }
    if (depositAmountFlag == "1") {
        return false;
    }

    if (obj == 'After') {
        var HasHistory = document.getElementById('billPart_hdnCapture').value;
        var HistoryValue = document.getElementById('billPart_hdnHistoryTableList').value;
        if (HasHistory == 1) {
            var isNeedToCaptureHistory = false;
            if (HistoryValue == '') {
                isNeedToCaptureHistory = true;
            }
            else {
                var HistoryAttributeList = document.getElementById('billPart_hdnHistoryAttributeList').value;
                var lstHistoryTableList = HistoryValue.split('|');
                var isHistoryExists = false;
                if (HistoryAttributeList != null && HistoryAttributeList != "") {
                    var lstHistoryAttributeList = HistoryAttributeList.split('^');
                    if (lstHistoryAttributeList != null && lstHistoryAttributeList.length > 0) {
                        for (k = 0; k < lstHistoryAttributeList.length; k++) {
                            var lstAttributeList = lstHistoryAttributeList[k].split('~');
                            if (lstAttributeList != null && lstAttributeList.length > 0) {
                                if (lstAttributeList[1] != null && lstAttributeList[9] != null && lstAttributeList[9] == "Y") {
                                    if (lstHistoryTableList != null && lstHistoryTableList.length > 0) {
                                        for (i = 0; i < lstHistoryTableList.length; i++) {
                                            lstHistoryList = lstHistoryTableList[i].split('~');
                                            if (lstHistoryList != null && lstHistoryList.length > 0) {
                                                for (j = 0; j < lstHistoryList.length; j++) {
                                                    lstHistory = lstHistoryList[j].split('^');
                                                    if (lstHistory[0] == "HistoryID" && lstAttributeList[1] == lstHistory[1]) {
                                                        isHistoryExists = true;
                                                        break;
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    if (!isHistoryExists) {
                                        isNeedToCaptureHistory = true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
            if (isNeedToCaptureHistory) {
                alert('History needs to be captured for this Patient');
                return false;
            }
        }
    }
    if ($.trim($('[id$="hdfBillType1"]').val()) != '' && obj == 'After') {
        PaymentSaveValidationQuickBill();
        if ($('[id$="txtClient"]').val() == '') {
            if (Number($('[id$="hdnNetAmount"]').val()) > Number($('[id$="hdnAmountReceived"]').val()) && $('[id$="txtClient"]').val() == '') {
                var pBill = confirm("Bill amount will be added to due.\n Do you want to continue");
                if (pBill != true) {
                    $('[id$="hdnDue"]').val() = "0.00";
                    ToTargetFormat($('[id$="hdnDue"]').val());
                    $('[id$="btnGenerate"]').show();
                    $('[id$="btnClose"]').show();
                    return false;
                }
                else {
                    $('[id$="hdnDue"]').val() = (Number(ToInternalFormat($("#hdnNetAmount"))) - Number(ToInternalFormat($("#hdnAmountReceived"))));
                    ToTargetFormat($("#hdnDue"));
                    $('[id$="btnGenerate"]').hide();
                }
            }


            $('[id$="btnGenerate"]').hide();
            $('[id$="btnClose"]').hide();
        }

        if ($('[id$="hdnCashClient"]').val() != 'C') {
            if ($('[id$="txtClient"]').val() != '') {
                // var NetAmount = Number($('[id$="hdnNetAmount"]').val());
                var NetAmount = Number(ToInternalFormat($("#hdnNetAmount")));
                //  var BalanaceAmount = Number($('[id$="hdnClientBalanceAmount"]').val());
                var BalanaceAmount = Number(ToInternalFormat($("#hdnClientBalanceAmount")));
                if (Number(NetAmount) > Number(BalanaceAmount)) {
                    //                    if (confirm('Ordered test items exceed balance client amount'))
                    //                        return true;
                    //                    else
                    //                        return false;
                }
            }
        }
    }
    document.getElementById('ddlSex').disabled = false;
    document.getElementById('btnGenerate').style.display = 'none';
    UnDisablePatientDetails();
     AddSpecimenDetails();
}
function SelectVisitType() {
    //    if ($('[id$="ddlIsExternalPatient"]').val() == 1) {
    //        $('[id$="tdlblWardNo"]').show();
    //        $('[id$="tdtxtWardNo"]').show();
    //    }
    //    else {
    //        $('[id$="tdlblWardNo"]').show();
    //        $('[id$="tdtxtWardNo"]').show();
    //    }
    //    if ($('[id$="ddlIsExternalPatient"]').val() == 1) {
    //        $('[id$="tdlblWardNo"]').show();
    //        $('[id$="tdtxtWardNo"]').show();
    //    }
    //    else {
    //        $('[id$="tdlblWardNo"]').hide();
    //        $('[id$="tdtxtWardNo"]').hide();
    //    }
}

function setDDlDOBYear(id, CB) {
    //debugger;
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ClientBilling_js_01") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ClientBilling_js_17") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_17") : "Provide the age in Years";
    var UsrAlrtMsg1 = SListForAppMsg.Get("Scripts_ClientBilling_js_18") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_18") : "Provide the age in Months";
    var UsrAlrtMsg2 = SListForAppMsg.Get("Scripts_ClientBilling_js_04") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_04") : "Provide the age in Weeks or Months";
    var UsrAlrtMsg3 = SListForAppMsg.Get("Scripts_ClientBilling_js_05") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_05") : "Can not give the Decimal value";
   // var UsrAlrtMsg3 = SListForAppMsg.Get("Scripts_ClientBilling_js_05") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_05") : "Select patient sex";

    var ageVal = document.getElementById('txtDOBNos').value;

    // ageVal = document.getElementById('txtDOBNos');


    var ddlDOB = document.getElementById('ddlDOBDWMY');


    var dob = document.getElementById('tDOB');


    var date = dob.value;


    var ddlval = ddlDOB.value;

    if (ddlval.toLowerCase() == 'month(s)' && ageVal > 11) {
        //alert('Provide the age in Years');
        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        return false;
    }
    if (ddlval.toLowerCase() == 'week(s)' && ageVal > 3) {
        //alert('Provide the age in Months');
        ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        return false;
    }
    if (ddlval.toLowerCase() == 'day(s)' && ageVal > 30) {
        // alert('Provide the age in Weeks or Months');
        ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        return false;
    }

    var decimalAge = ageVal.split('.');
    if (decimalAge.length > 1 && ddlval != 'Year(s)') {
        ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
        //alert('Can not give the Decimal value');
        document.getElementById('tDOB').value = '';
        document.getElementById('txtDOBNos').value = '';
        document.getElementById('ddlDOBDWMY').value = 'Year(s)';
        return false;
    }
    var days = new Date();

    if (ageVal != '') {
        if (ageVal.length < 3 && ddlval == 'Year(s)') {

            //var gdate = days.getDate();

            //var gmonth = days.getMonth();

            var gyear = days.getFullYear();

            dobYear = gyear - ageVal;

            var gmonth = days.getMonth();
            gmonth = parseInt(gmonth) + 1;
            if (gmonth < 10) {
                gmonth = '0' + gmonth;
            }

            var gday = days.getDate();
            gday = parseInt(gday);
            if (gday < 10) {
                gday = '0' + gday;
            }

            //Changed By Arivalagan.kk//
            var Cday = new Date(dobYear, gmonth, gday);
            var Cmth = Cday.getMonth();
            if (Cmth < 10) {
                Cmth = '0' + Cmth;
            }
//            if ((Cmth == (gmonth))) {
//                var dm = DaysInMonth(dobYear, gmonth);
//                //gday = dm;
//                if (((Cmth == (gmonth)) && (Cmth == (02)) && ((gmonth) == (02))) && (dm == 28 || dm == 29)) {
//                    if (dm == 28) { gday = dm; }
//                    if (dm == 29) { gday = dm; }
//                }
//            }
            document.getElementById('tDOB').value = gday + '/' + gmonth + '/' + dobYear;
            //Changed By Arivalagan.kk//

        }

        else if ((ddlval != 'Year(s)') && (ddlval == 'Month(s)' || ddlval == 'Day(s)' || ddlval == 'Week(s)')) {

            if (ageVal <= 1 && (ddlval == 'Year(s)')) {

                document.getElementById('tDOB').value = date;

            }

            else {

                if (ddlval == 'Day(s)') {
                    document.getElementById('tDOB').value = subDate(days, ageVal).format('dd/MM/yyyy');

                }

                if (ddlval == 'Week(s)') {
                    document.getElementById('tDOB').value = subWeek(days, ageVal).format('dd/MM/yyyy');

                }

                if (ddlval == 'Month(s)') {

                    document.getElementById('tDOB').value = subMonth(days, ageVal).format('dd/MM/yyyy');

                }

            }

        }

    }
    document.getElementById('ddlSex').focus();

}
function DaysInMonth(Y, M) {
    with (new Date(Y, M, 1, 24)) {
        setDate(0);
        return getDate();
    }
}
function subDate(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth(), o.getDate() - days);
    return newDate;
}
function subMonth(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth() - days, o.getDate());
    return newDate;
}
function subWeek(o, days) {
    var newDate = new Date(o.getFullYear(), o.getMonth(), o.getDate() - 7 * days);
    return newDate;
}
function onListPopulated() {
    var completionList = $find("AutoCompleteExtenderPatient").get_completionList();
    completionList.style.width = '250';
}

//function getDOB() {
//    if (document.getElementById('txtDOBNos').value.trim() == '') {
//        alert('Provide Age in (Days or Weeks or Months or Year) & choose appropriate from the list');
//        document.getElementById('txtDOBNos').focus();
//        return false;
//    }
//    return true;
//}

function SelectedTemp(source, eventArgs) {
    document.getElementById('hdnSelectedPatientTempDetails').value = eventArgs.get_value();
    Tblist();

}

function Tblist() {
    $('[id$="trPatientDetails"]').show();
    var table = '';
    var tr = '';
    var end = '</table>';
    var y = '';
    $('[id$="lblPatientDetails"]').html("");
    table = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:100%'><thead  align='Left' class='dataheader1' style='font-size:11px'>"
                           + "<th style='width:80px;'>Name</th>"
                           + "<th style='width:50px;'>Number</th>"
                           + "<th style='width:40px;'>OrgName</th>"
                            + "<th style='width:20px;'>URNNo</th>"
                           + "<th style='width:300px;'>Address</th>"
                           + "<th style='Widht:100px;'>Phone</th> </thead>";
    var x = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");

    tr = "<tr style='font-size:10px;height:10px' align='Left'><td style='width:250px;'>"
                        + x[1] + "</td><td style='width:100px;'>"
                        + x[2] + "</td><td style='width:100px;'>"
                        + x[25] + "</td><td style='width:100px;'>"
                        + x[16] + "</td><td style='width:20px;'>"
                        + x[8] + ',' + x[20] + ',' + x[9] + "</td><td style='width:100px;'>"
                        + x[7] + "</td></tr>";



    var tab = table + tr + end;
    $('[id$="lblPatientDetails"]').html(tab);
    // tbshow1();


}
function SelectedPatient(source, eventArgs) {

    //debugger;
    var dateformat;

    if (document.getElementById('hdnDateFormatConfig') != null) {
        dateformat = document.getElementById('hdnDateFormatConfig').value;
    }
    else {
        dateformat = "dd/MM/yyyy";
    }

    var isPatientDetails = "";
    isPatientDetails = eventArgs.get_value().split('|')[0];

    var PatientName = eventArgs.get_text().split(':')[0];
    var PatientNumber = eventArgs.get_text().split(':')[1];
    var PatientVisitType = eventArgs.get_text().split(':')[2];
    var contextKey = document.getElementById('hdnSelectedPatientTempDetails').value.split("~");
    contextKey = contextKey[8];
    if (contextKey != '') {
        var PatientID = contextKey.split(':')[1];
        $.ajax({
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: "../OPIPBilling.asmx/GetQuickPatientSearchDetails",
            data: JSON.stringify({ PatientID: PatientID, contextKey: contextKey }),
            dataType: "json",
            success: function(data, value) {

                var GetData = JSON.parse(data.d[0]);
                //var PatientName = GetData.First.split(':')[0];
                var isPatientDetails = GetData.Second;
                var PatientTITLECode = isPatientDetails.split('~')[0];
                var PatientName = isPatientDetails.split('~')[1];
                var PatientNumber = isPatientDetails.split('~')[2];
                var PatientAge = isPatientDetails.split('~')[3];
                var FullPatientDOBAll = isPatientDetails.split('~')[4];

                var FullPatientDOB = FullPatientDOBAll.split('/');
                var dDate = FullPatientDOB[0];
                var dMonth = FullPatientDOB[1];
                var dYear = FullPatientDOB[2];
                if (dateformat == "dd/MM/yyyy") {
                    var PatientDOB = dDate + '/' + dMonth + '/' + dYear;
                }
                else {
                    var PatientDOB = dMonth + '/' + dDate + '/' + dYear;
                }
                //SAthish.E****************//
                var PatientSex = isPatientDetails.split('~')[5];
                var PatientMaritalStatus = isPatientDetails.split('~')[6];
                var PatientMobile = isPatientDetails.split('~')[7].split(',')[0].trim();
                if (isPatientDetails.split('~')[7].split(',')[1] != null) {
                    var PatientPhone = isPatientDetails.split('~')[7].split(',')[1].trim();
                }
                var PatientAddress = isPatientDetails.split('~')[8];
                var PatientCity = isPatientDetails.split('~')[9];
                var PostalCode = isPatientDetails.split('~')[10];
                var PatientNationality = isPatientDetails.split('~')[11];
                var PatientCountryID = isPatientDetails.split('~')[12];
                var PatientStateID = isPatientDetails.split('~')[13];
                var PatientID = isPatientDetails.split('~')[14];
                var PatientEmailID = isPatientDetails.split('~')[15];
                var URNNo = isPatientDetails.split('~')[16];
                var URNofId = isPatientDetails.split('~')[17];
                var URNTypeId = isPatientDetails.split('~')[18];
                var VisitPurpose = 3
                var PatientPreviousDue = isPatientDetails.split('~')[19];
                var Address2 = isPatientDetails.split('~')[20];
                var ExternalPatientNumber = isPatientDetails.split('~')[21];
                var PatientType = isPatientDetails.split('~')[22];
                var PatientStatus = isPatientDetails.split('~')[23];
                //var NewOrgID = isPatientDetails.split('~')[24];
                var ClientName = isPatientDetails.split('~')[24];
                //var ClientName = isPatientDetails.split('~')[29];
                var NewOrgID = isPatientDetails.split('~')[33];
                //var ClientID = isPatientDetails.split('~')[30];
                var RoundNo = isPatientDetails.split('~')[37];
                var ClientID = isPatientDetails.split('~')[45];
                var ExternelVisitID = isPatientDetails.split('~')[42];
                //document.getElementById('hdnCalculateDays').value = isPatientDetails.split('~')[27];
                if (document.getElementById('hdnRemotelogin').value != "Y") {
                    $('#hdnSelectedClientClientID').val(ClientID);
                }
                counti = 0;
                BindDynamicFields();

                document.getElementById('ddSalutation').value = PatientTITLECode
                document.getElementById('txtName').value = PatientName;
                document.getElementById('hdnPatientNumber').value = PatientNumber
                document.getElementById('txtDOBNos').value = PatientAge.split(' ')[0];
                document.getElementById('ddlDOBDWMY').value = PatientAge.split(' ')[1];
                document.getElementById('ddlSex').value = PatientSex;
                if (document.getElementById('hdnEditSex') != null) {
                    document.getElementById('hdnEditSex').value = PatientSex;
                }
                if (document.getElementById('txtlabnumber') != null) {
                    document.getElementById('txtlabnumber').value = ExternelVisitID;
                }
                document.getElementById('ddMarital').value = PatientMaritalStatus;
                document.getElementById('txtMobileNumber').value = PatientMobile;
                //    if (PatientPhone != null)
                //    {
                //        document.getElementById('txtPhone').value = PatientPhone;
                //    }
                //document.getElementById('txtAddress').value = PatientAddress.trim();
                //document.getElementById('txtCity').value = PatientCity;
                //    if (PatientNationality != '')
                //    {
                //        if (document.getElementById('ddlNationality') != null)
                //        {
                //            document.getElementById('ddlNationality').value = PatientNationality;
                //        }
                //    }
                document.getElementById('ddCountry').value = PatientCountryID;
                //document.getElementById('ddCountry').onchange();
                document.getElementById('hdnPatientStateID').value = PatientStateID;
                document.getElementById('ddState').value = PatientStateID;
                if (PatientStateID == "") {
                    loadState("11");
                }
                document.getElementById('hdnPatientID').value = PatientID;
                var textBox = $get('tDOB');
                if (textBox.AjaxControlToolkitTextBoxWrapper) {
                    textBox.AjaxControlToolkitTextBoxWrapper.set_Value(PatientDOB);
                }
                else {
                    textBox.value = PatientDOB;
                }
                //document.getElementById('txtPincode').value = PostalCode;
                document.getElementById('txtEmail').value = PatientEmailID;
                document.getElementById('txtURNo').value = URNNo;
                document.getElementById('hdnNewOrgID').value = NewOrgID;
                document.getElementById('ddlUrnoOf').value = URNofId;
                document.getElementById('ddlUrnType').value = URNTypeId;
                //document.getElementById('lblPatientDetails').innerHTML = '';
                //document.getElementById('trPatientDetails').style.display = "none";
                if (document.getElementById('txtClient') != null) {
                    document.getElementById('txtClient').focus();
                }
                if (ClientName != undefined && document.getElementById('hdnRemotelogin').value != "Y") {
                    document.getElementById('txtClient').value = ClientName;
                    document.getElementById('hdnSelectedClientName').value = ClientName;
                    document.getElementById('txtClient').disabled = true;
                }
                if (RoundNo != undefined) {
                    document.getElementById('txtRoundNo').value = RoundNo;
                }
                document.getElementById('ddlSex').value = PatientSex;
                if (document.getElementById('hdnRemotelogin').value != "Y") {
                    document.getElementById('hdnSelectedClientClientID').value = ClientID;
                }
                if (ClientName != undefined && ClientName != 'GENERAL')
                    document.getElementById('billPart_hdnIsCashClient').value = "N";
                //Getdigitalnumber(document.getElementById('lblPreviousDueText'), PatientPreviousDue);
                if (document.getElementById('billPart_lblPreviousDueText') != null) {
                    document.getElementById('billPart_lblPreviousDueText').innerHTML = PatientPreviousDue;
                }
                if (document.getElementById('txtSuburban') != null) {
                    document.getElementById('txtSuburban').value = Address2;
                }
                if (document.getElementById('txtExternalPatientNumber') != null) {
                    document.getElementById('txtExternalPatientNumber').value = ExternalPatientNumber;
                }
                var panelLegend = $('#PnlPatientDetail legend');
                panelLegend.html("Patient Details ").append('<b>(Patient No: ' + PatientNumber + ' )</b>');
                document.getElementById('PnlPatientDetail');
                document.getElementById('hdnPatientName').value = PatientName;
                document.getElementById('hdnPatientID').value = PatientID;

                if (document.getElementById('txtClient') != null) {
                    LoadPreviousBillingItemsForPatient();
                }
                else {
                    document.getElementById('hdnPatientID').value = PatientID;
                    if (document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML != "") {
                        document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerHTML = "";
                    }
                    document.getElementById('ComplaintICDCodeBP1_tblDiagnosisItems').innerText = "";
                    LoadComplaintItems((eventArgs.get_value().split('|')[1]));
                    document.getElementById('txtAddress').focus();
                    var list = ((eventArgs.get_value().split('|')[2]).substring(0, (eventArgs.get_value().split('|')[2]).length - 1)).split('~');
                    while (count = document.getElementById('PatientPreference1_PatientPreference').rows.length) {

                        for (var j = 0; j < document.getElementById('PatientPreference1_PatientPreference').rows.length; j++) {
                            document.getElementById('PatientPreference1_PatientPreference').deleteRow(j);

                        }
                    }
                    if ((eventArgs.get_value().split('|')[2]) != "") {
                        for (var count = 0; count < list.length; count++) {
                            var CList = list[count].split('~');
                            var row = document.getElementById('PatientPreference1_PatientPreference').insertRow(0);
                            row.id = parseInt(count);
                            var rwNumber = row.id;
                            var cell1 = row.insertCell(0);
                            var cell2 = row.insertCell(1);
                            var cell3 = row.insertCell(2);
                            cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                            cell2.innerHTML = CList[0];
                            cell3.innerHTML = "<input onclick='btnEditPreference_OnClick(name);' name='" + parseInt(rwNumber) + "^" + CList[0] + "' value = 'Edit' type='button' style='background-color:Transparent;color:Red;border-style:none;text-decoration:underline;cursor:pointer'/>";
                            if (rwNumber == '0') {
                                document.getElementById('hdnPreference').value += rwNumber + "^" + CList[0];
                            }
                            else {
                                document.getElementById('hdnPreference').value += "~" + rwNumber + "^" + CList[0];
                            }
                            document.getElementById('PatientPreference1_PatientPreference').style.display = 'block';
                        }

                    }
                    if (document.getElementById('billPart_UcHistory_hdnPreference') != null) {
                        document.getElementById('billPart_UcHistory_hdnPreference').value = (eventArgs.get_value().split('|')[2]).substring(0, (eventArgs.get_value().split('|')[2]).length - 1);
                    }
                    document.getElementById('btnSaveEMR').value = 'Update';
                }

                // VEL | Rolling Amount | 10-01-2020 | Start | //
                var splitlist = isPatientDetails.split('#####');

                Rollingadamoutcalculation(splitlist[1]);
                // VEL | Rolling Amount | 10-01-2020 | END  | //
            },
            error: function(result) {
                alert("Error");
            }
        });
    }
}

function setPatientSearch() {
    try {
        //debugger;
        var searchvalue, searchtype;
        var searchtypeRadioList = document.getElementsByName('rblSearchType');
        var OrgID = document.getElementById('hdnOrgID').value;
        var NewOrgID = document.getElementById('hdnNewOrgID').value;

        for (var i = 0; i < searchtypeRadioList.length; i++) {
            if (searchtypeRadioList[i].checked) {
                searchtype = searchtypeRadioList[i].value
                break;
            }
        }
        if (searchtype == 4) {
            document.getElementById('txtName').setAttribute('autocomplete', 'off');
        }
        else {
            if (searchtype == 0) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(3);
            }
            else if (searchtype == 1) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(1);
            }
            else if (searchtype == 2) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(5);
            }
            else if (searchtype == 3) {
                $find('AutoCompleteExtenderPatient').set_minimumPrefixLength(1);
            }
            var PatientID = -1;
            searchvalue = OrgID + "~" + PatientID + "~" + searchtype;
            $find('AutoCompleteExtenderPatient').set_contextKey(searchvalue);
            //alert(searchvalue);
        }

    } catch (e) {
        //alert(e);
    }
}


function LoadPreviousBillingItemsForPatient() {
    if (document.getElementById('hdnPreviousVisitDetails') != null) {
        document.getElementById('hdnPreviousVisitDetails').value = ''; //$('[id$="hdnPreviousVisitDetails"]').val(""); 

        $.ajax({
            type: "POST",
            url: "../OPIPBilling.asmx/GetPreviousVisitBilling",
            data: "{ 'PatientID': '" + parseInt(document.getElementById('hdnPatientID').value) + "','VisitID': '" + parseInt(0) + "','Type': ''}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: true,
            success: function(data) {
                var ArrayItems = data.d;
                var Items = ArrayItems[0];
                $.each(Items, function(index, Item) {
                    document.getElementById('hdnPreviousVisitDetails').value += Item.FeeDescription + '$' + Item.FeeId + '$' + Item.FeeType + '$' + Item.Address + '$' + Item.PatientHistory + '$' + Item.Status + '$' + Item.IsOutSource + '$' + Item.ServiceCode + '$' + Item.IsAVisitPurpose + '$' + Item.VisitID + '^';
                    //alert(document.getElementById('hdnPreviousVisitDetails').value);
                });

                SetPreviousVisitItems();
                //alert(Items);
            },
            failure: function(msg) {
                ShowErrorMessage(msg);
            }

        });
    }
}

function SetPreviousVisitItems() {
    var UsrAdd = SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") != null ? SListForAppDisplay.Get("CommonControls_TestMaster_ascx_077") : "Add";
    //debugger;
    var TVisit = "N";
    var tblStatr = "";
    var tblBoody = "";

    var tblEnd = "";
    var tblResult = "";
    var tblTotal = "";
    var listLen = 0;
    if (document.getElementById('hdnPreviousVisitDetails').value != '') {
        listLen = document.getElementById('hdnPreviousVisitDetails').value.split('^').length;
    }
    var sum = 0.00;
    var temp = 0.00;
    var res = new Array();
    var ItemArray = new Array();
    var defalutdata = document.getElementById('hdnDefaultOrgBillingItems').value.split('^');
    var Gender = document.getElementById('ddlSex').value;
    document.getElementById('hdnGender').value = Gender;
    //    FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[1] + "~Descrip^" + defalutdata[2] + "~Amount^"
    //                + defalutdata[3] + "~Quantity^" + defalutdata[4] + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[6] + "~IsReimbursable^" + defalutdata[7] + "~ActualAmount^" + defalutdata[8] + "|";
    //document.getElementById('hdfBillType1').value = FeeViewStateValue;

    if (listLen > 0) {
        tblStatr = " <div style='overflow: auto; height: 120px;width: 475px;'>"
                + "<table border='1' id='tblItems' cellpadding='1' cellspacing='0' class='dataheaderInvCtrl' style='text-align: left; font-size: 11px;' width='100%'>"
                + "<tr class = 'dataheader1' style='font-weight:bold;'><td style='width:30px;'>S.No</td><td  style='width:330px;'>Test Name</td><td  style='display:none;width:30px;'>ID</td><td style='display:table-cell;width:30px;'>Type</td>"
                + "<td style='display:table-cell;width:30px;'><input id='chkAll' name='chkAll1' onclick='chkSelectAll(document.form1.chkAll);' value='SelectAll' type='checkbox'>All</input></td><td  style='display:none;'>IsAddToday</td><td  style='display:none;'>IsOutSource</td><td  style='display:none;'>TestCode</td></tr>";

        ItemArray = document.getElementById('hdnPreviousVisitDetails').value.split('^');

        var curdate = '';
        var predate = '';
        var j = 0;
        var k = 0;
        var count = 0;
        for (var i = 0; i < ItemArray.length; i++) {
            if (ItemArray[i] != "") {
                res = ItemArray[i].split('$');
                curdate = res[3];

                var strPatientHistory = '';
                if (res[4] == null || res[4] == 'null') {
                    strPatientHistory = '';
                }
                else {
                    strPatientHistory = res[4];
                }

                if (predate == curdate) {
                    var str = "chkboxItem" + k;
                    var txt = "txtBillItems" + j;
                    if (defalutdata[0] != res[1] && defalutdata[1] != res[2]) {

                        tblBoody += "<tr><td>" + parseInt(j + 1) + "</td><td>" + res[0] + "</td><td style='display:none;'>" + res[1] + "</td><td style='display:table-cell;'>" + res[2] +
                                "</td><td style='display:table-cell;'><input  id='" + str + "' name='chkAll'  value='" + '' + "' type='checkbox'  /></td><td style='display:none;'>" + res[5] + "</td><td style='display:none;'>" + res[6] + "</td><td style='display:none;'>" + res[7] + "</td>";

                        j++;
                        k++;
                    }
                }
                else {
                    count++;
                    if (count == 6) {
                        break;
                    }
                    tblBoody += "<tr><td style='font-weight:bold' colspan='5' title='" + strPatientHistory + "'>Visit Date : " + curdate + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Patient History: " + strPatientHistory.substring(0, 25) + "</td></tr>";
                    predate = curdate;
                    j = 0;
                    i--;

                }
                var IsTodayVisit = res[8];
                if (IsTodayVisit == 'Y') {
                    TVisit = "Y";
                    var TodayVisitID = res[9];
                    document.getElementById('hdnTodayVisitID').value = TodayVisitID;
                    document.getElementById('hdnTempTodayVisitID').value = TodayVisitID;
                    //document.getElementById('ddlVisitDetails').value = "1~2";
                    var ddlVisitDetails = document.getElementById('ddlVisitDetails');
                    ddlVisitDetails.selectedIndex = 0;
                    //document.getElementById('tdVisitType1').style.display = "table-cell";
                    //document.getElementById('tdVisitType2').style.display = "table-cell";
                    var NewOrgID = document.getElementById('hdnNewOrgID').value;
                    //                    document.getElementById('tdSex1').style.width = '10%';
                    //                    document.getElementById('tdSex2').style.width = '18%';
                }
                else {
                    var TodayVisitID = -1;
                    document.getElementById('hdnTodayVisitID').value = TodayVisitID;
                    document.getElementById('hdnTempTodayVisitID').value = TodayVisitID;
                }
                var TodayVisitID = -1;
                document.getElementById('hdnTodayVisitID').value = TodayVisitID;
                document.getElementById('hdnTempTodayVisitID').value = TodayVisitID;
                document.getElementById('ddlVisitDetails').disabled = true;
            }
        }
        tblTotal += "<tr><td colspan='5' style='display:table-cell;' align='center'><input id='adds' type='button' value=" + UsrAdd + " class='btn' onclick='javascript:AddPreviousVisitItemsToBilling();' ></td></tr>";
        tblEnd = "</table></div>";
    }
    tblResult = tblStatr + tblBoody + tblTotal + tblEnd;
    $('[id$="lblPreviousItems"]').html(tblResult);
    if (document.getElementById('lblPreviousItems').innerHTML.trim() != '') {
        tbItemshow();
    }
    else {
        $('[id$="ShowBillingItems"]').hide();
    }
}

function ShowPrevious() {
    $('[id$="ShowBillingItems"]').show();
    $('[id$="ShowPreviousData"]').hide();
    //    $('[id$="ShowBillingItems"]').show();
    //    $('[id$="ShowPreviousData"]').hide(); 
}

function AddPreviousVisitItemsToBilling() {
    var isAlert = 'Y';
    if (IsItemChecked()) {
        var OrgID = document.getElementById('hdnOrgID').value;
        CallBillItems(OrgID);
        var tbl = document.getElementById('tblItems').rows.length;
        var td = document.getElementById('tblItems');
        var rate = document.getElementById('txtClient').value;
        var pretex = new Array();
        var preInvID = new Array();
        var HasTest = 'N';
        var IsOutSourceLocation;
        var idv = new Array();
        if (tbl > 1) {
            var j = 0;
            var x = -1;
            for (var i = 1; i < tbl - 1; i++) {
                var cellcount = td.rows[i].cells.length;
                if (cellcount > 1) {
                    var tdID = td.rows[i].cells[4].childNodes[0].id;
                    if (document.getElementById(tdID).checked == true) {
                        x++;
                        var testName = td.rows[i].cells[1].childNodes[0];
                        var id = td.rows[i].cells[2].childNodes[0];
                        var FeeType = td.rows[i].cells[3].innerText;
                        var IsOutSource = td.rows[i].cells[6].childNodes[0];
                        if (document.getElementById('hdnBookedID').value != '0') {
                            var TestCode = td.rows[i].cells[8].childNodes[0];
                            IsOutSourceLocation = td.rows[i].cells[8].childNodes[0].data;
                        }
                        else {
                            var TestCode = td.rows[i].cells[7].childNodes[0];
                        }
                        idv[x] = td.rows[i].cells[2].childNodes[0];
                        if (testName.data != "Test Name") {
                            var prefixText = testName.data;
                            preInvID[x] = td.rows[i].cells[2].innerText;
                            var Descrip = td.rows[i].cells[1].innerText
                            var FeeID = td.rows[i].cells[2].innerText;
                            pretex[x] = testName.data;
                            var autoComplete = $find('billPart_AutoCompleteExtender3');
                            $.ajax({
                                type: "POST",
                                url: "../OPIPBilling.asmx/GetBillingItemsDetails",
                                //changes by arun issue fixing - can't add service from top right corner servicelist
                                data: JSON.stringify({ OrgID: document.getElementById('hdnOrgID').value, FeeID: id.data, FeeType: FeeType, Description: testName.data, ClientID: document.getElementById('hdnSelectedClientClientID').value, VisitID: 0, Remarks: '', IsCollected: document.getElementById('billPart_hdnIsCollected').value, CollectedDatetime: document.getElementById('billPart_hdnCollectedDateTime').value, locationName: document.getElementById('billPart_hdnLocName').value, BookingID: 0 }),
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: false,
                                success: function(data) {
                                    var Items = data.d;
                                    $.each(Items, function(index, Item) {
                                        var valu;
                                        for (var k = 0; k < Items.length; k++) {
                                            valu = Items[k].ProcedureName;
                                            // for (var m = 0; m < pretex.length; m++) {
                                            var idvalu = valu.split('^');

                                            var defalutdata = valu.split('^');

                                            if (document.getElementById('hdnBookedID').value != '0') {

                                            }
                                            else {
                                                IsOutSourceLocation = defalutdata[17];
                                            }

                                            var FeeViewStateValue = document.getElementById('billPart_hdfBillType1').value;

                                            var FeeGotValue = new Array();
                                            FeeGotValue = FeeViewStateValue.split('|');
                                            var feeIDALready = new Array();
                                            var tempFeeID, tempFeeType, tempOtherID, tempDateTime, tempDescrip, tempPerphyname, tempPerphyID, Quantity = 1;


                                            var PaymentAAlreadyPresent = new Array();
                                            var iPaymentAlreadyPresent = 0;
                                            var iPaymentCount = 0;
                                            var tarrayChildData = new Array();

                                            for (iMain = 0; iMain < FeeGotValue.length - 1; iMain++) {

                                                tarraySubData = FeeGotValue[iMain].split('~');
                                                for (tiChild = 0; tiChild < tarraySubData.length; tiChild++) {
                                                    tarrayChildData = tarraySubData[tiChild].split('^');
                                                    if (tarrayChildData.length > 0) {

                                                        if (tarrayChildData[0] == "FeeID") {
                                                            tempFeeID = tarrayChildData[1];
                                                        }
                                                        if (tarrayChildData[0] == "FeeType") {
                                                            tempFeeType = tarrayChildData[1];
                                                        }
                                                        if (tarrayChildData[0] == "Descrip") {
                                                            tempDescrip = tarrayChildData[1];
                                                        }
                                                        if (FeeID == tempFeeID && FeeType == tempFeeType && Descrip == tempDescrip) {
                                                            iPaymentAlreadyPresent = 1;
                                                        }
                                                    }
                                                }

                                            }


                                            if (iPaymentAlreadyPresent == 0) {
                                            //changes by arun prasad - b2b reg - delete service is not working when we choose the service already exists patient details
                                                 var IsMandatoryHis1 = document.getElementById('billPart_hdnIsMandatoryHis').value;
                                                var IsSpecialTest1 = document.getElementById('billPart_hdnIsSpecialTest').value;
                                                var Ishtmltab1 = document.getElementById('billPart_hdnIshtml').value;
                                                var IsTemplateID1 = document.getElementById('billPart_hdnIsTemplateID').value;
                                             //
                                                j++;
                                                HasTest = 'Y';
                                                FeeViewStateValue = "FeeID^" + defalutdata[0] + "~FeeType^" + defalutdata[2] + "~Descrip^" + defalutdata[1] +
                                                        "~Amount^" + defalutdata[3] + "~Quantity^" + 1 + "~Remarks^" + defalutdata[5] + "~ReportDate^" + defalutdata[7] +
                                                        "~IsReimbursable^" + defalutdata[6] + "~ActualAmount^" + defalutdata[8] + "~IsNormalRateCard^" + defalutdata[9] +
                                                        "~IsDiscountable^" + defalutdata[9] + "~IsTaxable^" + defalutdata[10] + "~IsRepeatable^" + defalutdata[11] +
                                                        "~IsSTAT^" + defalutdata[12] + "~IsSMS^" + defalutdata[13] + "~IsOutSource^" + IsOutSource.data + "~IsNABL^" + defalutdata[14] +
                                                        "~BillingItemRateID^" + defalutdata[15] + "~Code^" + defalutdata[18] + "~HasHistory^" + "N" + "~outRInSourceLocation^" + IsOutSourceLocation +
                                                        "~BaseRateID^" + defalutdata[19] + "~DiscountPolicyID^" + defalutdata[20] + "~DiscountCategoryCode^" + defalutdata[21] +
                                                        "~ReportDeliveryDate^" + defalutdata[22] + "~MaxDiscount^" + undefined + "~IsRedeem^" + undefined + "~RedeemAmount^" + undefined
                                                //+ "|";
                                                        + "~IsSpecialTest^" + IsSpecialTest1 + "~Ishtmltab^" + Ishtmltab1 + "~IsTemplateID^" + IsTemplateID1 + "~IsMandatoryHis^" + IsMandatoryHis + "|";

                                                document.getElementById('billPart_hdfBillType1').value = (document.getElementById('billPart_hdfBillType1').value).replace(FeeViewStateValue, '');
                                                document.getElementById('billPart_hdfBillType1').value += FeeViewStateValue;

                                                // CreateBillItemsTable(0);
                                                //Co Paymnet//
                                                var BToBhdnCopay
                                                if (document.getElementById('HdnCoPay') != null) {
                                                    BToBhdnCopay = document.getElementById('HdnCoPay').value;
                                                }
                                                else {
                                                    BToBhdnCopay = 'N';
                                                }

                                                if (BToBhdnCopay == 'Y') {
                                                    Calc_Copayment();
                                                }
                                                //End Co Paymnet//
                                            }

                                            else {
                                                if (isAlert == 'Y') {
                                                    isAlert = 'N';
                                                    var objItem = SListForAppMsg.Get("Scripts_CommonBiling_js_25") == null ? "Item already added" : SListForAppMsg.Get("Scripts_CommonBiling_js_25");
                                                    ValidationWindow(objItem, objAlert);
                                                    //alert("Item already added");
                                                    //ClearSelectedData(0);
                                                    return false;
                                                }
                                            }
                                            //}
                                        }


                                    });
                                    if (HasTest == 'Y') {
                                        HasTest = 'N';
                                        CreateBillItemsTable(0);
                                        var FeeViewStateValue = '';
                                    }

                                },
                                failure: function(msg) {
                                    ShowErrorMessage(msg);
                                }

                            });
                        }
                    }
                }
            }
        }
    }
}


function IsItemChecked() {
    var flag = 0;
    var flagAlreadyToday = 0;
    var tbl = document.getElementById('tblItems').rows.length;
    var td = document.getElementById('tblItems');
    if (tbl > 0) {
        for (var i = 0; i < tbl - 1; i++) {
            var cellcount = td.rows[i].cells.length;
            if (cellcount > 1) {
                var tdID = td.rows[i].cells[4].childNodes[0].id;
                if (document.getElementById(tdID).checked == true) {
                    var FeeID = td.rows[i].cells[2].childNodes[0];
                    var FeeType = td.rows[i].cells[3].childNodes[0];
                    var IsAddedToday = td.rows[i].cells[5].childNodes[0];
                    var ItemArrayAlreadyToday = new Array();
                    var resAlreadyToday = new Array();
                    ItemArrayAlreadyToday = document.getElementById('hdnPreviousVisitDetails').value.split('^');
                    for (i = 0; i < ItemArrayAlreadyToday.length; i++) {
                        res = ItemArrayAlreadyToday[i].split('$');
                        if (FeeID.data == res[1] && 'Y' == res[5] && FeeType.data == res[2]) {
                            flagAlreadyToday++;
                        }
                    }
                    flag++;
                }
            }
        }
    }

    if (flag == 0) {
        alert('Does not allowed to add  to click the checkbox');
    }
    else {
        if (flagAlreadyToday == 1) {
            if (window.confirm("Warning: The selected test already ordered today...!  Do you want to continue?")) {
                flagAlreadyToday = 0;
            }
            else {
                flagAlreadyToday = 1;
            }
        }
        if (flagAlreadyToday == 0)
            return true;
        else
            return false;
    }
}

function CheckPatientName() {
    if (document.getElementById('txtName').value.trim() == "") {
        alert("Enter The Patient Name");
        document.getElementById('txtName').focus();
        return false;
    }
}

function ChangeVisit() {
    var visitID;
    visitID = document.getElementById('ddlVisitDetails').value;

    if (visitID.selectedIndex = 1) {
        document.getElementById('hdnTodayVisitID').value = -1;
    }
    else {
        document.getElementById('hdnTodayVisitID').value = document.getElementById('hdnTempTodayVisitID').value;
    }
}

function LoadComplaintItem(source, eventArgs) {

    if (source != undefined) {
        var HidValue;
        var HidValue1;
        var HidValues = source;
        HidValue1 = HidValues.split('|');
        HidValue = HidValue1[1];
        var list = (HidValue1[2].substring(0, HidValue1[2].length - 3)).split('~');
        while (count = document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').rows.length) {

            for (var j = 0; j < document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').rows.length; j++) {
                document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').deleteRow(j);

            }
            document.getElementById('billPart_UcHistory_hdnPreference').value = '';
        }
        var rowcount = '509';
        if (HidValue1[2].substring(0, HidValue1[2].length - 3) != "") {
            for (var count = 0; count < list.length; count++) {

                var CList = list[count].split('~');

                var row = document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').insertRow(0);
                row.id = rowcount;
                var rwNumber = rowcount;
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                cell2.align = 'left';
                cell1.innerHTML = "<img id='imgbtn' OnClick='ImgOnclickPreference(" + parseInt(rwNumber) + ");' style='cursor:pointer;'  src='../Images/Delete.jpg' />";
                cell2.innerHTML = CList[0];
                if (rwNumber == '509') {
                    document.getElementById('billPart_UcHistory_hdnPreference').value += rwNumber + "^" + CList[0];
                }
                else {
                    document.getElementById('billPart_UcHistory_hdnPreference').value += "~" + rwNumber + "^" + CList[0];
                }
                rowcount++;
            }
            document.getElementById('billPart_UcHistory_PatientPreference1_PatientPreference').style.display = 'block';
        }
    }
    else {
        var HidValue = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value;
    }
    var list = HidValue.split('^');
    document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_hdnDiagnosisItems').value = HidValue;

    while (count = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').rows.length) {

        for (var j = 0; j < document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').rows.length; j++) {
            document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').deleteRow(j);

        }
    }
    if (HidValue != "") {
        for (var count = 0; count < list.length - 1; count++) {
            var CList = list[count].split('~');
            var row = document.getElementById('billPart_UcHistory_ComplaintICDCodeBP1_tblDiagnosisItems').insertRow(0);
            row.id = CList[0];
            var rwNumber = CList[0];
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            cell1.innerHTML = "<img id='imgbtn' style='cursor:pointer;' OnClick='ImgOnclickComplaints(" + parseInt(rwNumber) + ");' src='../Images/Delete.jpg' />";
            cell2.innerHTML = CList[1];
            cell3.innerHTML = CList[2];
            cell4.innerHTML = CList[3];
            cell1.width = "1%";
            cell2.width = "1%";
            cell3.width = "1%";
            cell4.width = "1%";
            var CLists = '';
        }
    }

}

function chkSelectAll(obj) {
    for (i = 0; i < obj.length; i++) {
        obj[i].checked = document.form1.chkAll1.checked == true ? true : false;
    }
}
function validateMultipleEmailsCommaSeparated(emailcntl, seperator) {
    var value = emailcntl.value;
    if (value != '') {
        var result = value.split(seperator);
        for (var i = 0; i < result.length; i++) {
            if (result[i] != '') {
                if (!validateEmail(result[i])) {
                    emailcntl.focus();
                    alert('"' + result[i] + '" email addresses not valid!');

                    var elements = document.getElementById('chkDespatchMode');
                    if (document.getElementById('txtEmail').value != '') {
                        document.getElementById('chkDespatchMode_0').checked = false;
                        //elements.cells[0].childNodes[0].checked = false;
                    }
                    return false;
                }
            }
        }
    }
    return true;
}

function AlertforExistingLabNumber() {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_ClientBilling_js_01") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_01") : "Alert";
    var UsrAlrtMsg = SListForAppMsg.Get("Scripts_ClientBilling_js_21") != null ? SListForAppMsg.Get("Scripts_ClientBilling_js_21") : "Lab Number Already Exists, Not allowed for another patient";

    if (document.getElementById('hdnPatientLabnumberList').value == "Y")
    {
    // && document.getElementById('hdnPatientLabNumber').value == "") {
        
        ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
        document.getElementById('txtlabnumber').value = '';
        document.getElementById('hdnPatientLabNumber').value = '';
        document.getElementById('hdnPatientLabnumberList').value = 'N';
        
        return false;
    }
}

function validateEmail(field) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,5}$/;
    return (regex.test(field)) ? true : false;
}
function UnDisablePatientDetails() {
    $('#rblSearchType_0').attr("disabled", false);
    $('#rblSearchType_1').attr("disabled", false);
    $('#rblSearchType_2').attr("disabled", false);
    $('#rblSearchType_3').attr("disabled", false);
    $('#rblSearchType_4').attr("disabled", false);
    $('#ddSalutation').attr("disabled", false);
    $('#txtName').attr("disabled", false);
    $('#ddlSex').attr("disabled", false);
    $('#tDOB').attr("disabled", false);
    $('#txtDOBNos').attr("disabled", false);
    $('#ddlDOBDWMY').attr("disabled", false);
    $('#ddMarital').attr("disabled", false);
    $('#txtMobileNumber').attr("disabled", false);
    $('#txtPhone').attr("disabled", false);
    $('#txtEmail').attr("disabled", false);
    $('#txtAddress').attr("disabled", false);
    $('#txtSuburban').attr("disabled", false);
    $('#txtCity').attr("disabled", false);
    $('#txtPincode').attr("disabled", false);
    $('#ddCountry').attr("disabled", false);
    $('#ddState').attr("disabled", false);
    $('#ddlUrnType').attr("disabled", false);
    $('#ddlUrnoOf').attr("disabled", false);
    $('#txtURNo').attr("disabled", false);
    $('#txtClient').attr("disabled", false);
    $('#txtReferringHospital').attr("disabled", false);
    $('#txtInternalExternalPhysician').attr("disabled", false);
    $('#txtLocClient').attr("disabled", false);
    $('#ddlIsExternalPatient').attr("disabled", false);
    $('#txtWardNo').attr("disabled", false);
    $('#txtExternalPatientNumber').attr("disabled", false);
    $('#ddlPatientStatus').attr("disabled", false);
    $('#txtSampleDate').attr("disabled", false);
    $('#chkSamplePickup').attr("disabled", false);
    $('#txtPhleboName').attr("disabled", false);
    $('#txtLogistics').attr("disabled", false);
    $('#txtRoundNo').attr("disabled", false);
    $('#chkExcludeAutoathz').attr("disabled", false);
    $('#ChkTRFImage').attr("disabled", false);
    $('#FileUpload1').attr("disabled", false);
    $('#chkDisPatchType_0').attr("disabled", false);
    $('#chkDisPatchType_1').attr("disabled", false);
    $('#chkDespatchMode_0').attr("disabled", false);
    $('#chkDespatchMode_1').attr("disabled", false);
    $('#chkDespatchMode_2').attr("disabled", false);
    $('#ChkNotification_0').attr("disabled", false);
    $('#ChkNotification_1').attr("disabled", false);
    $('#ddlVisitDetails').attr("disabled", false);
}