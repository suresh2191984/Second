
function chk() {
    $('#CheckBox1').change(function() {

        $('tbody tr td input[class="chk1"]').prop('checked', $(this).prop('checked'));
        return true;
    });

    $('#CheckBox2').change(function() {

        $('tbody tr td input[class="chk2"]').prop('checked', $(this).prop('checked'));
        return true;
    });
    
}

///// <reference name="MicrosoftAjax.js"/>

//Type.registerNamespace("WebApp");

//WebApp.ReceiveBatchSheet = function(element) {
//    WebApp.ReceiveBatchSheet.initializeBase(this, [element]);
//}

//WebApp.ReceiveBatchSheet.prototype = {
//    initialize: function() {
//        WebApp.ReceiveBatchSheet.callBaseMethod(this, 'initialize');

//        // Add custom initialization here
//    },
//    dispose: function() {
//        //Add custom dispose actions here
//        WebApp.ReceiveBatchSheet.callBaseMethod(this, 'dispose');
//    }
//}
//WebApp.ReceiveBatchSheet.registerClass('WebApp.ReceiveBatchSheet', Sys.UI.Control);

//if (typeof (Sys) !== 'undefined') Sys.Application.notifyScriptLoaded();


//Sathish.E//
function GetSamplesForBatch() {
    //debugger;
    chk();
    var strReceived = SListForAppDisplay.Get("Scripts_ReceiveBatchSheet_js_01") == null ? "Received" : SListForAppDisplay.Get("Scripts_ReceiveBatchSheet_js_01");
    var strTransferred = SListForAppDisplay.Get("Scripts_ReceiveBatchSheet_js_02") == null ? "Transferred" : SListForAppDisplay.Get("Scripts_ReceiveBatchSheet_js_02");
    var NewOrgID = document.getElementById('hdnBaseOrgId').value;
    var BatchNumber = document.getElementById('txtBatchNo').value;
//    $('#grdBatchSamples tbody tr:not(:first)').children().remove();
//    $('#grdAdditionalBatchSamples tbody tr:not(:first)').children().remove();
    $('#grdBatchSamples tbody tr:not(:first)').remove();
    $('#grdAdditionalBatchSamples tbody tr:not(:first)').remove();
    document.getElementById('txtSampleBarcode').value = '';
    var haveUnreceiveSamples = false;
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/GetSamplesForBatch",
        data: JSON.stringify({ Orgid: NewOrgID, BatchNo: BatchNumber }),
        dataType: "json",
        async: false,
        success: function(data) {

            if (data.d.length > 0) {

                var list = data.d;
                if (list[0].length > 0) {
                    var list1 = list[0];
                    var list2 = list[1];
                    if (list1.length > 0) {
                        $('#grdBatchSamples').css('visibility', 'visible');
                        document.getElementById('tblLegends').style.display = 'block';

                        for (var i = 0; i < list1.length; i++) {
                            var oldDate = new Date(parseInt(list1[i].CreatedAt.slice(6, -2)));
                            var DateTime = (oldDate.getDate() + '/' + (1 + oldDate.getMonth()) + '/' + oldDate.getFullYear().toString().slice(-2));

//                            if (list1[i].BatchStatus == "Transferred") {
//                                $("#grdBatchSamples").append("<tr id=tr_" + i + " style='background-color:#6D6968 !important;'><td>" + list1[i].BatchNo + "</td><td><span id='lblExVisitID'>" + list1[i].ExternalVisitID + "<td><span id ='lblSampleName'>" + list1[i].SampleDesc + "</span></td><td><span id ='lblPatientName'>" + list1[i].Name + "</span></td><td><span id='lblCreatedAt'>" + DateTime + "</span></td><td><span id ='lblSampleSts'>" + list1[i].BatchStatus + "</span></td><td style='display:none';><span id ='lblSampleId'>" + list1[i].SampleID + "</span></td><td  style='display:none'; ><span id ='lblVisitId'>" + list1[i].PatientVisitID + "</span></td><td   style='display:none';><span id='lblbarcode'>" + list1[i].BarcodeNumber + "</span></td><td><input type='checkbox' id=Batchchk_" + i + " onclick=ChangeGridRowColour(this.id); ></td></tr>");
//                                haveUnreceiveSamples = true;
//                            }
//                            if (list1[i].BatchStatus == "Received") {
//                                $("#grdBatchSamples").append("<tr id=tr_" + i + " style='background-color:#85BB65 !important;'><td>" + list1[i].BatchNo + "</td><td><span id='lblExVisitID'>" + list1[i].ExternalVisitID + "<td><span id ='lblSampleName'>" + list1[i].SampleDesc + "</span></td><td><span id ='lblPatientName'>" + list1[i].Name + "</span></td><td><span id='lblCreatedAt'>" + DateTime + "</span></td><td><span id ='lblSampleSts'>" + list1[i].BatchStatus + "</span></td><td   style='display:none';><span id ='lblSampleId'>" + list1[i].SampleID + "</span></td><td  style='display:none';><span id ='lblVisitId'>" + list1[i].PatientVisitID + "</span></td><td  style='display:none';><span id='lblbarcode'>" + list1[i].BarcodeNumber + "</span></td><td><input type='checkbox' id=Batchchk_" + i + " disabled='true' onclick=ChangeGridRowColour(this.id); ></td></tr>");
//                            }
                            if (list1[i].BatchStatus == strTransferred) {
                                $("#grdBatchSamples").append("<tr id=tr_" + i + " style='background-color:#6D6968 !important;'><td>" + list1[i].BatchNo + "</td><td><span id='lblExVisitID'>" + list1[i].ExternalVisitID + "<td><span id ='lblSampleName'>" + list1[i].SampleDesc + "</span></td><td><span id ='lblPatientName'>" + list1[i].Name + "</span></td><td><span id='lblCreatedAt'>" + DateTime + "</span></td><td><span id ='lblSampleSts'>" + list1[i].BatchStatus + "</span></td><td style='display:none';><span id ='lblSampleId'>" + list1[i].SampleID + "</span></td><td  style='display:none'; ><span id ='lblVisitId'>" + list1[i].PatientVisitID + "</span></td><td   style='display:none';><span id='lblbarcode'>" + list1[i].BarcodeNumber + "</span></td><td><input type='checkbox' class='chk1' id=Batchchk_" + i + " onclick=ChangeGridRowColour(this.id); ></td></tr>");
                                haveUnreceiveSamples = true;
                                $("#grdBatchSamples tr th:eq(10)").hide();
                            }
                            if (list1[i].BatchStatus == strReceived) {
                                $("#grdBatchSamples").append("<tr id=tr_" + i + " style='background-color:#85BB65 !important;'><td>" + list1[i].BatchNo + "</td><td><span id='lblExVisitID'>" + list1[i].ExternalVisitID + "<td><span id ='lblSampleName'>" + list1[i].SampleDesc + "</span></td><td><span id ='lblPatientName'>" + list1[i].Name + "</span></td><td><span id='lblCreatedAt'>" + DateTime + "</span></td><td><span id ='lblSampleSts'>" + list1[i].BatchStatus + "</span></td><td   style='display:none';><span id ='lblSampleId'>" + list1[i].SampleID + "</span></td><td  style='display:none';><span id ='lblVisitId'>" + list1[i].PatientVisitID + "</span></td><td  style='display:none';><span id='lblbarcode'>" + list1[i].BarcodeNumber + "</span></td><td><input type='checkbox' id=Batchchk_" + i + " disabled='true' onclick=ChangeGridRowColour(this.id); ></td></tr>");
                            }
                        }
                        document.getElementById('hdnBatchId').value = list1[0].BatchID;
                        if (haveUnreceiveSamples) {
                            document.getElementById('tdBtnReceive').style.display = 'block';
                            document.getElementById('trSampleBarcode').style.display = 'block';
                        }
                        else {

                            document.getElementById('tdbtnReprint').style.display = 'block';
                            $("#grdBatchSamples tr th:eq(10)").show();
                        }
                        $("#grdBatchSamples tr th:eq(6)").hide();
                        $("#grdBatchSamples tr th:eq(7)").hide();
                        $("#grdBatchSamples tr th:eq(8)").hide();
                    }
                    if (list2.length > 0) {
                        document.getElementById('hdnAdditionalSampleBatchTracker').value = '';
                        for (var i = 0; i < list2.length; i++) {
                            var j = $("#grdAdditionalBatchSamples tr").length;
                            $("#grdAdditionalBatchSamples").append("<tr style='background-color:#F9B7FF !important;'><td><span id ='lblTxtBarCode'>" + list2[i].BarcodeNumber + "</span></td><td><input type='checkbox' id=chk_" + (j - 1) + " onclick=openSampleGridRow(this.id); ></td></tr>");
                            $('#grdAdditionalBatchSamples').css('visibility', 'visible');
                            if (document.getElementById('hdnAdditionalSampleBatchTracker').value == "") {
                                document.getElementById('hdnAdditionalSampleBatchTracker').value = list2[i].BarcodeNumber;
                            }
                            else {
                                document.getElementById('hdnAdditionalSampleBatchTracker').value += "," + list2[i].BarcodeNumber;
                            }
                        }
                    }
                }
                //$("#grdBatchSamples tr th:eq(9)").hide();

            }

        },
        error: function(result) {
            alert("New Error");
        }
    });

}

function ValidateSamples() {
   
  var  objBatch = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_01") == null ? "Provide The Batch Number !!!" : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_01");
  var objBarcode = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_02") == null ? "Provide The Barcode !!!" : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_02");
   var objReceived = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_03") == null ? "Sample already Received" : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_03");
   var  objconfirm = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_04") == null ? "The barcode is not present in this batch.\n Click 'OK' to select manually or Click 'Cancel' to add as Additional sample." : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_04");
    var OkMsg = SListForAppMsg.Get('Scripts_Ok') == null ? "OK" : SListForAppMsg.Get('Scripts_Ok');
    var CancelMsg = SListForAppMsg.Get('Scripts_Cancel') == null ? "Cancel" : SListForAppMsg.Get('Scripts_Cancel');
    var Information = SListForAppMsg.Get('Scripts_Information') == null ? "Information" : SListForAppMsg.Get('Scripts_Information');

  var  objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    var txtBatchNo = document.getElementById('txtBatchNo').value.trim();
    if (txtBatchNo == "") {
        ValidationWindow(objBatch, objAlert);
        //alert('Provide The Batch Number !!!');
        return false;
    }
    var txtSampleBarcode = document.getElementById('txtSampleBarcode').value.trim();
    if (txtSampleBarcode == "") {
        //alert('Provide The Barcode !!!');
        ValidationWindow(objBarcode, objAlert);
        return false;
    }

    var Flag = '';
    var Confirm = '';
    var $row1 = "";
    var $rowSelected = "";
    var $firstRow = "";
    var TxtBarCode = $('#txtSampleBarcode').val();
    $('#grdBatchSamples tbody tr:not(:first)').each(function(i, n) {
        var $row = $(n);
        if (i == 0) {
            $firstRow = $row.attr('id');
        }
        var GrdBarCode = $row.find($('span[id$="lblbarcode"]')).html();
        var GrdExVisitID = $row.find($('span[id$="lblExVisitID"]')).html();
        var GrdSampleStatus = $row.find($('span[id$="lblSampleSts"]')).html();
        if (GrdBarCode != 'undefined') {
            if (TxtBarCode == GrdBarCode) {
                if (GrdSampleStatus != 'Received') {
                    $row.css('background-color', '#6D6968');
                    if (i != 0)
                        $rowSelected = $row.attr('id');
                    $row.find('input:checkbox').prop('checked', 'checked');
                    $row.find('input:checkbox').attr('disabled', false);
                    Flag = 'Set';
                    document.getElementById('txtSampleBarcode').value = '';
                    document.getElementById('txtSampleBarcode').focus();
                    document.getElementById('txtSampleBarcode').select();
                }
                else {
                    Flag = 'Set';
                    ValidationWindow(objReceived, objAlert);
                   // alert("Sample already Received");
                }
            }
            else if (TxtBarCode == GrdExVisitID) {
                Confirm = 'YES';
                var chkid = $row.find('input:checkbox').attr('id');
                if (document.getElementById(chkid).checked == false && GrdSampleStatus != 'Received') {
                    $row.find('input:checkbox').attr('disabled', false);
                }
            }
        }
    });
    // To move the row to first position
    if ($rowSelected != "") {
        $('#' + $rowSelected).insertBefore('#' + $firstRow);
    }
    if (Confirm == 'YES') {
        var res = ConfirmWindow(objconfirm, objAlert, OkMsg, CancelMsg);
        if (res) {
            Flag = 'Set';
        }
        else {
            $('#grdBatchSamples tbody tr:not(:first)').each(function(i, n) {
                var $row = $(n);
                var GrdSampleStatus = $row.find($('span[id$="lblSampleSts"]')).html();
                var chkid = $row.find('input:checkbox').attr('id');
                if (document.getElementById(chkid).checked == false && GrdSampleStatus != 'Received') {
                    $row.find('input:checkbox').attr('disabled', true);
                }
            });
        }
    }

    if (Flag == '') {
        //debugger;
        var BarcodeNumber = document.getElementById('txtSampleBarcode').value.trim();
        if (document.getElementById('hdnAdditionalSampleBatchTracker').value.indexOf(BarcodeNumber) == -1) {
            var k = $("#grdAdditionalBatchSamples tr").length;
            $("#grdAdditionalBatchSamples").append("<tr style='background-color:#F9B7FF;'><td><span id ='lblTxtBarCode'>" + TxtBarCode + "</span></td><td><input type='checkbox' id=chk_" + (k - 1) + " onclick=openSampleGridRow(this.id); ></td></tr>");
            $('#grdAdditionalBatchSamples').css('visibility', 'visible');
            if (document.getElementById('hdnAdditionalSampleBatchTracker').value == "") {
                document.getElementById('hdnAdditionalSampleBatchTracker').value = BarcodeNumber;
            }
            else {
                document.getElementById('hdnAdditionalSampleBatchTracker').value += "," + BarcodeNumber;
            }
        }
        else {
            objAdditional = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_05") == null ? "Already added to Additional Samples" : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_05");
            //  alert("Already added to Additional Samples");
            ValidationWindow(objAdditional, objAlert);
        }
        document.getElementById('txtSampleBarcode').value = '';
        document.getElementById('txtSampleBarcode').focus();
        document.getElementById('txtSampleBarcode').select();
    }
}

function ChangeGridRowColour(id) {
    var isChecked = $('#' + id).prop("checked");
    var $selectedRow = $('#' + id).parent("td").parent("tr");

    if (isChecked) {
        $selectedRow.css('background-color', '#6D6968');
        $('#' + id).removeAttr('disabled');
    }
    else {
        if ($('#CheckBox1').prop("checked")) {
            $('#CheckBox1').attr('checked', false);
        }
        $selectedRow.css('background-color', '#FFEBCD');
        $('#' + id).removeAttr('disabled');
    }

    $('#grdBatchSamples tbody tr:not(:first)').each(function(i, n) {
        var $row = $(n);
        if (document.getElementById("Batchchk_" + i) != 'undefined') {
            if (document.getElementById("Batchchk_" + i).checked == false) {
               // document.getElementById("Batchchk_" + i).disabled = true;
            }
        }
    });
    //$('#grdAdditionalBatchSamples tbody tr:not(:first)').children('.checked').remove();

    document.getElementById('txtSampleBarcode').focus();
    document.getElementById('txtSampleBarcode').select();
}

function openSampleGridRow(id) {
    //debugger;
 var   objnot = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_06") == null ? "The Barcode is not in this Batch" : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_06");
  var   objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    var GrdBarCode = '';
    var flag = '';
    var $selectedRow = $('#' + id).parent("td").parent("tr");
    GrdBarCode = $selectedRow.find($('span[id$="lblTxtBarCode"]')).html();


    if ($('#' + id).is(":checked")) {
        $('#' + id).addClass("checked");
    } else {
        $('#' + id).removeClass("checked");
    }

    $('#grdBatchSamples tbody tr:not(:first)').each(function(i, n) {
        var $row = $(n);
        var GrdExVisitID = $row.find($('span[id$="lblExVisitID"]')).html();
        var GrdSampleStatus = $row.find($('span[id$="lblSampleSts"]')).html();
        if (GrdBarCode == GrdExVisitID) {
            flag = 'YES';
            var chkid = $row.find('input:checkbox').attr('id');
            if (document.getElementById(chkid) != 'undefined' && document.getElementById(chkid).checked == false) {
                //if ($row.find('input:checkbox') != 'undefined' && $row.find('input:checkbox').attr('checked') == false) {
                if (document.getElementById(chkid).disabled == false) {
                    //if ($row.find('input:checkbox[id$=Batchchk]').attr('disabled') == false) {
                    document.getElementById(chkid).disabled = !document.getElementById(id).checked;
                    //document.getElementById('Batchchk_' + i).disabled = !document.getElementById(id).checked;
                    //$row.find('input:checkbox[id$=Batchchk]').attr('disabled', !document.getElementById(id).checked);
                }
                else if (document.getElementById(chkid).disabled == false && GrdSampleStatus != 'Received') {
                    //else if ($row.find('input:checkbox[id$=Batchchk]').attr('disabled') == false && GrdSampleStatus != 'Received') {
                    document.getElementById(chkid).disabled = !document.getElementById(id).checked;
                    //document.getElementById('Batchchk_' + i).disabled = !document.getElementById(id).checked;
                    //$row.find('input:checkbox[id$=Batchchk]').attr('disabled', !document.getElementById(id).checked);
                }
                else if (GrdSampleStatus != 'Received') {
                    document.getElementById(chkid).disabled = !document.getElementById(id).checked;
                    //$row.find('input:checkbox[id$=Batchchk]').attr('disabled', !document.getElementById(id).checked);
                }
            }
        }
    });
    if (flag == '') {
        //debugger;
        if (document.getElementById(id) != 'undefined' && document.getElementById(id).checked == true) {
            //alert("The Barcode is not in this Batch");
            ValidationWindow(objnot, objAlert);
            $('#grdAdditionalBatchSamples tbody tr:not(:first)').each(function(i, n) {
                if (document.getElementById("chk_" + i) != 'undefined')
                    document.getElementById("chk_" + i).checked = false;
            });
        }
    }
}

function getSampleBatchTrackerDetails() {
    var objatleast = SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_07") == null ? "Select atleast one" : SListForAppMsg.Get("Scripts_ReceiveBatchSheet_js_07");
   var objAlert = SListForAppMsg.Get("Scripts_CommonBiling_js_Alert") == null ? "Alert" : SListForAppMsg.Get("Scripts_CommonBiling_js_Alert");
    var flag = '';
    document.getElementById('hdnSampleBatchTrackerDetails').value = '';
    document.getElementById('hdnAdditionalSampleBatchTracker').value = '';
    var lstPatientInvSample = [];
    //document.getElementById('hdnAdditionalSampleBatchTracker').value = '';
    $('#grdBatchSamples tbody tr:not(:first)').each(function(i, n) {
        var $row = $(n);
        var lstchkbxes = $row.find('input:checkbox');
        var chkid = $(lstchkbxes[0]).attr('id');
        if (chkid != undefined) {
            if (document.getElementById(chkid).checked == true || (lstchkbxes[1]!==null && $(lstchkbxes[1]).prop('checked')==true)) {
                //if ($row.find('input:checkbox[id$=Batchchk]').attr('checked') == true) {
                flag = 'YES';
                var SampleID = $row.find($('span[id$="lblSampleId"]')).html();
                var VisitID = $row.find($('span[id$="lblVisitId"]')).html();
                if (document.getElementById('hdnSampleBatchTrackerDetails').value == "") {
                    document.getElementById('hdnSampleBatchTrackerDetails').value = SampleID;
                    lstPatientInvSample.push({
                        PatientVisitID: VisitID,
                        SampleCode: SampleID
                    });
                }
                else {
                    document.getElementById('hdnSampleBatchTrackerDetails').value += "," + SampleID;
                    lstPatientInvSample.push({
                        PatientVisitID: VisitID,
                        SampleCode: SampleID
                    });
                }
                if (lstPatientInvSample.length > 0) {
                    $('#hdnLstPatientInvSample').val(JSON.stringify(lstPatientInvSample));
                }
            }
        }
    });

    $('#grdAdditionalBatchSamples tbody tr:not(:first)').each(function(i, n) {
        var $row = $(n);
        var BarcodeNumber = $row.find($('span[id$="lblTxtBarCode"]')).html();
        if (document.getElementById('hdnAdditionalSampleBatchTracker').value == "") {
            document.getElementById('hdnAdditionalSampleBatchTracker').value = BarcodeNumber;
            lstPatientInvSample.push({
                PatientVisitID: VisitID,
                SampleCode: SampleID
            });
        }
        else {
            document.getElementById('hdnAdditionalSampleBatchTracker').value += "," + BarcodeNumber;
            lstPatientInvSample.push({
                PatientVisitID: VisitID,
                SampleCode: SampleID
            });
        }
        if (lstPatientInvSample.length > 0) {
            $('#hdnLstPatientInvSample').val(JSON.stringify(lstPatientInvSample));
        }
    });
    if (flag == '') {
        ValidationWindow(objatleast, objAlert);
        //alert("Select atleast one");
        return false;
    }
    return true;
}