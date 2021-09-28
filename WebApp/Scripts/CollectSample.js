function onShowContainerCount() {
    try {
        $('div[id$="divContainerCountRow"]').html('');
        var totalCount = 0;
        if ($.trim($('input[id$="hdnContainerCount"]').val()) != '') {
            var lstContainerCount = JSON.parse($('input[id$="hdnContainerCount"]').val());
            $.each(lstContainerCount, function(i, obj) {
                totalCount = totalCount + obj.ContainerCount;
            });
            var divRowTag = document.createElement('div');
            $(divRowTag).attr('id', 'divContainerCountColumnTotal');
            $(divRowTag).addClass("divColumn");
            $(divRowTag).html('<a href="#' + $('div[id$="divContainerCountRow"]') + '" style="color: #333;">' 
            + $('span[id$="lblTotalContainerCount"]').html() + '<span class="badge">' + totalCount + '</span></a>');
            $(divRowTag).appendTo($('div[id$="divContainerCountRow"]'));

            var divEmptyTag = document.createElement('div');
            $(divEmptyTag).attr('id', 'divContainerCountColumnEmpty');
            $(divEmptyTag).addClass("divEmptyColumn");
            $(divEmptyTag).html('');
            $(divEmptyTag).appendTo($('div[id$="divContainerCountRow"]'));

            $.each(lstContainerCount, function(i, obj) {
                var divColumnTag = document.createElement('div');
                $(divColumnTag).attr('id', 'divContainerCountColumn' + obj.SampleContainerID);
                $(divColumnTag).addClass("divColumn");
                $(divColumnTag).html('<a href="#' + $('div[id$="divContainerCountRow"]') + '">' 
                + obj.ContainerName + '<span class="badge">' + obj.ContainerCount + '</span></a>');
                $(divColumnTag).appendTo($('div[id$="divContainerCountRow"]'));
            });
        }
        else {
            var divRowTag = document.createElement('div');
            $(divRowTag).attr('id', 'divContainerCountColumnTotal');
            $(divRowTag).addClass("divColumn");
            $(divRowTag).html('<a href="#' + $('div[id$="divContainerCountRow"]') + '" style="color: #333;">' 
            + $('span[id$="lblTotalContainerCount"]').html() + '<span class="badge">' + totalCount + '</span></a>');
            $(divRowTag).appendTo($('div[id$="divContainerCountRow"]'));
        }
    }
    catch (e) {
        return false;
    }
    return false;
}
function SetDateTimeDetails() {
try {
    var SampleDAte = $('input[id$="txtSampleDateCollect"]').val();
    if ($('input[id$="txtSampleDateCollect"]').val() == null || $('input[id$="txtSampleDateCollect"]').val() == "") {
        SampleDAte = $('input[id$="DateTimePicker1_txtSampleDateCollect"]').val();
    }
    var SampleTime1 = $('input[id$="txtSampleTime1"]').val();
    var SampleTime2 = $('input[id$="txtSampleTime2"]').val();

    var SampleTimeTypeID;
    var SampleTimeType;

    var ddlAction = $('select[id$="ddlSampleTimeType"] :selected');

    if (ddlAction != null) {

        SampleTimeTypeID = $(ddlAction).val();

        SampleTimeType = $(ddlAction).text();

    }
    var a;
    a = SampleDAte + " " + SampleTime1 + ":" + SampleTime2 + " " + SampleTimeType;
    if ($('#tblCollectSample tr').length > 1) {
        $('#tblCollectSample tr:not(:first)').each(function (i, n) {
            $row = $(n);
            $row.find($('input[id$="txtSampleDateCollect"]')).val(SampleDAte);
            $row.find($('input[id$="txtSampleTime1"]')).val(SampleTime1);
            $row.find($('input[id$="txtSampleTime2"]')).val(SampleTime2);
            $row.find($('select[id$="ddlSampleTimeType"]')).val(SampleTimeTypeID);

        });
    }
    if ($('#CltSample tr').length > 1) {
        $('#CltSample tr:not(:first)').each(function (i, n) {
            $row = $(n);
            $row.find($('input[id$="txtSampleDateCollect"]')).val(SampleDAte);
            $row.find($('input[id$="txtSampleTime1"]')).val(SampleTime1);
            $row.find($('input[id$="txtSampleTime2"]')).val(SampleTime2);
            $row.find($('select[id$="ddlSampleTimeType"]')).val(SampleTimeTypeID);
        });
    }
    }
    catch (e) {
        return false;
    }
}
function onSampleDelete(obj) {
    try {
        var row = $(obj).closest('tr');
        var rowIndex = $(row).index();
        if ($.trim($('input[id$="hdnContainerCount"]').val()) != '') {
            var isExists = false;
            var arrayIndex = 0;
            var lstContainerCount = JSON.parse($('input[id$="hdnContainerCount"]').val());
            var sampleContainerID = $(row).find($('input[id$="hdnContainerID"]')).val();
            if ($.trim(sampleContainerID) != '' && $.trim(sampleContainerID) != '0') {
                $.each(lstContainerCount, function(i, obj) {
                    if (obj.SampleContainerID == sampleContainerID) {
                        isExists = true;
                        arrayIndex = i;
                        return false;
                    }
                });
                if (isExists) {
                    var oInvSampleContainer = lstContainerCount[arrayIndex];
                    if (oInvSampleContainer.ContainerCount == 1) {
                        lstContainerCount.splice(arrayIndex, 1);
                    }
                    else {
                        oInvSampleContainer.ContainerCount = oInvSampleContainer.ContainerCount - 1;
                        lstContainerCount.splice(arrayIndex, 1);
                        lstContainerCount.splice(arrayIndex, 0, oInvSampleContainer);
                    }
                    $('input[id$="hdnContainerCount"]').val(JSON.stringify(lstContainerCount));
                }
                onShowContainerCount();
            }
        }
        $('table[id$="tblChildCollectSample"] tr:eq(' + rowIndex + ')').remove();
        $(row).remove();
    }
    catch (e) {
        return false;
    }
    return false;
}
function onContainerNameChange(obj) {
    try { 
        var row = $(obj).closest('tr');
        var rowIndex = $(row).index();
        var ContainerID = '';
        var ContainerName = '';
        $('input[id$="hdnSampleRowID"]').val(rowIndex);
        ContainerID = $(row).find($('input[id$="hdnContainerID"]')).val();
        $('input[id$="hdnOldhdnContainerID"]').val(ContainerID);
        ContainerName = $(row).find($('span[id$="lblContainerName"]')).html();
        $('select[id$="ddlDynamicSampleContainer"] :selected').text(ContainerName); 
        var PopUpOpen = $find('popupExtenderContainer');
        PopUpOpen.show(); 
    }
    catch (e) {
        return false;
    }
    return false;
}
function OnContainerUpdate() {
    try {
        var rowIndex = $('input[id$="hdnSampleRowID"]').val();
        // var rowIndex = $(row).index();
        var ObjDynamicSampleContainer = $('select[id$="ddlDynamicSampleContainer"] :selected');
        if (ObjDynamicSampleContainer != null) {
            ContainerID = $(ObjDynamicSampleContainer).val();
            ContainerName = $(ObjDynamicSampleContainer).text();
        }
        rowIndex = parseInt(rowIndex) + (parseInt(rowIndex) - 1);
        if (rowIndex != '') {
            $('#tblCollectSample tbody tr:eq(' + rowIndex + ')').map(function() {

                $(this).find($('input[id$="hdnContainerID"]')).val(ContainerID);
                $(this).find($('span[id$="lblContainerName"]'))[0].innerHTML = ContainerName;
            });
        }
        $('input[id$="hdnSampleRowID"]').val('');
        var PopUpOpen = $find('popupExtenderContainer');
        PopUpOpen.hide();
        SetContainerList(ContainerID, ContainerName);
        $('input[id$="hdnOldhdnContainerID"]').val("");

    }
    catch (e) {
        return false;
    }
    return false; 
}
function SetContainerList(containerID, containerName) {
try {
    var sampleContainerID = $('input[id$="hdnOldhdnContainerID"]').val();

    if (sampleContainerID != "" && sampleContainerID != ContainerID) {
        /** For ADD**/
        if (containerID != '' && containerID != '0') {
            var lstContainerCount = [];
            if ($.trim($('input[id$="hdnContainerCount"]').val()) != '') {
                lstContainerCount = JSON.parse($('input[id$="hdnContainerCount"]').val());
            }
            var isExists = false;
            var arrayIndex = 0;
            $.each(lstContainerCount, function(i, obj) {
                if (obj.SampleContainerID == containerID) {
                    isExists = true;
                    arrayIndex = i;
                    return false;
                }
            });
            if (isExists) {
                var oInvSampleContainer = lstContainerCount[arrayIndex];
                oInvSampleContainer.ContainerCount = oInvSampleContainer.ContainerCount + 1;
                lstContainerCount.splice(arrayIndex, 1);
                lstContainerCount.splice(arrayIndex, 0, oInvSampleContainer);
            }
            else {
                lstContainerCount.push({
                    SampleContainerID: containerID,
                    ContainerName: containerName,
                    ContainerCount: 1
                });
            }
            $('input[id$="hdnContainerCount"]').val(JSON.stringify(lstContainerCount));

        }

        /** For Delete**/


        if ($.trim($('input[id$="hdnContainerCount"]').val()) != '') {
            var isExists = false;
            var arrayIndex = 0;

            var lstContainerCount = JSON.parse($('input[id$="hdnContainerCount"]').val());
            if ($.trim(sampleContainerID) != '' && $.trim(sampleContainerID) != '0') {
                $.each(lstContainerCount, function(i, obj) {
                    if (obj.SampleContainerID == sampleContainerID) {
                        isExists = true;
                        arrayIndex = i;
                        return false;
                    }
                });
                if (isExists) {
                    var oInvSampleContainer = lstContainerCount[arrayIndex];
                    if (oInvSampleContainer.ContainerCount == 1) {
                        lstContainerCount.splice(arrayIndex, 1);
                    }
                    else {
                        oInvSampleContainer.ContainerCount = oInvSampleContainer.ContainerCount - 1;
                        lstContainerCount.splice(arrayIndex, 1);
                        lstContainerCount.splice(arrayIndex, 0, oInvSampleContainer);
                    }
                    $('input[id$="hdnContainerCount"]').val(JSON.stringify(lstContainerCount));
                }
            }
        }

        onShowContainerCount();
    }
    }
    catch (e) {
        return false;
    }
}
function onSampleNameChange(obj) {
    try {
        var row = $(obj).closest('tr');
        var rowIndex = $(row).index();
        var SampleCode = '';
        var SampleName = '';
        $('input[id$="hdnSampleRowID"]').val(rowIndex);
        SampleCode = $(row).find($('input[id$="hdnSampleCode"]')).val();
        SampleName = $(row).find($('span[id$="lblSampleName"]')).html();
$('[id$="ddlDynamicSample"]').val(SampleCode);

        //$('select[id$="ddlDynamicSample"] :selected').text(SampleName);
        var PopUpOpen = $find('popupExtenderSample');
        PopUpOpen.show();
    }
    catch (e) {
        return false;
    }
    return false; 
}
function OnSampleUpdate() {
    try {
        var rowIndex = $('input[id$="hdnSampleRowID"]').val();
        // var rowIndex = $(row).index();
        var ObjDynamicSampleContainer = $('select[id$="ddlDynamicSample"] :selected');
        if (ObjDynamicSampleContainer != null) {
            SampleCode = $(ObjDynamicSampleContainer).val();
            SampleName = $(ObjDynamicSampleContainer).text();
        }
        rowIndex = parseInt(rowIndex) + (parseInt(rowIndex) - 1);
        if (rowIndex != '') {
            $('#tblCollectSample tbody tr:eq(' + rowIndex + ')').map(function() {

            $(this).find($('input[id$="hdnSampleCode"]')).val(SampleCode);
            $(this).find($('span[id$="lblSampleName"]'))[0].innerHTML = SampleName;
            });
        }
        $('input[id$="hdnSampleRowID"]').val('');
	 $('[id$="ddlDynamicSample"]').val("0");
        var PopUpOpen = $find('popupExtenderSample');
        PopUpOpen.hide();

    }
    catch (e) {
        return false;
    }
    return false;
}


function onSampleStatusChange(divReason, divOutsource, ddlReason, ddlOutsource, ddlStatus) {
    var strSelect = SListForAppDisplay.Get('CommonControls_CollectSample_ascx_02') != null ? SListForAppDisplay.Get('CommonControls_CollectSample_ascx_02') : "--Select--";
    try {
        document.getElementById(divReason).style.display = "none";
        document.getElementById(divOutsource).style.display = "none";
        var newListItem;
        var objReason = document.getElementById(ddlReason);
        var objOutsource = document.getElementById(ddlOutsource);
        var selectedStatusID = document.getElementById(ddlStatus).value;
        objReason.options.length = 0;
        objOutsource.options.length = 0;

        if (selectedStatusID == "4" || selectedStatusID == "6") {
            document.getElementById(divReason).style.display = "block";
            var lstRejectReason = JSON.parse($('input[id$="hdnLstRejectReason"]').val());
            if (selectedStatusID != 6) {
                newListItem = document.createElement("option");
                objReason.options.add(newListItem);
                newListItem.text = strSelect;
                newListItem.value = "0";
            }
            $.each(lstRejectReason, function(i, obj) {
                if (obj.ParentID == selectedStatusID) {
                    newListItem = document.createElement("option");
                    objReason.options.add(newListItem);
                    newListItem.text = obj.Name;
                    newListItem.value = obj.Value;
                }
            });

            if (objReason.options.length == 0) {
                objReason.options.length = 0;
                newListItem = document.createElement("option");
                objReason.options.add(newListItem);
                newListItem.text = strSelect;
                newListItem.value = "0";
            }
        }
        else if (selectedStatusID == "12") {
            document.getElementById(divOutsource).style.display = "block";
            var lstOutSourceLoc = JSON.parse($('input[id$="hdnLstOutSourceLoc"]').val());

            $.each(lstOutSourceLoc, function(i, obj) {
                newListItem = document.createElement("option");
                objOutsource.options.add(newListItem);
                newListItem.text = obj.Name;
                newListItem.value = obj.Value;
            });

            if (objOutsource.options.length == 0) {
                objOutsource.options.length = 0;
                newListItem = document.createElement("option");
                objOutsource.options.add(newListItem);
                newListItem.text = strSelect;
                newListItem.value = "0";
            }
        }
    }
    catch (e) {
        return false;
    }
}
function CollectSamplePageAddSample() {
    try {
        var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
        var UsrAlrtMsg = SListForAppMsg.Get("Scripts_CollectSample_js_01") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_01") : "Select sample name";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Scripts_CollectSample_js_02") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_02") : "Select sample status";
        var UsrAlrtMsg2 = SListForAppMsg.Get("Scripts_CollectSample_js_03") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_03") : "Select reason";
        var UsrAlrtMsg3 = SListForAppMsg.Get("Scripts_CollectSample_js_04") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_04") : "Select location";
        var UsrAlrtMsg4 = SListForAppMsg.Get("Scripts_CollectSample_js_05") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_05") : "Select an investigation";
        var UsrAlrtMsg5 = SListForAppMsg.Get("Scripts_CollectSample_js_06") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_06") : "Selected investigation(s) are already mapped with sample(s)";
        var UsrAlrtMsg6 = SListForAppMsg.Get("Scripts_CollectSample_js_07") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_07") : "Select Conatiner";
        var UsrAlrtMsg7 = SListForAppMsg.Get("Scripts_CollectSample_js_08") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_08") : "Enter sample collected date and time";
        var UsrAlrtMsg8 = SListForAppMsg.Get("Scripts_CollectSample_js_09") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_09") : "Select Volume Unit";
        var UsrAlrtMsg9 = SListForAppMsg.Get("Scripts_CollectSample_js_10") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_10") : "There was a problem while adding sample";
        var UsrAlrtMsg10 = SListForAppMsg.Get("Scripts_CollectSample_js_22") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_22") : "Select Shipping Condition";
        var errorMessage, sampleName, containerName, sampleStatusName, rejectedReason, receiveLocationName, collectedDateTime, outsourceLocation, temperature, volume;
        var sampleCode, containerID, sampleStatusID, barcode, receiveLocationID, investigationID, shippingConditionID, volumeUnitID, AddExternalBarcode;
        var lstSelectedInvName = "--";
        var lstSelectedInvID = "";
        var dummy = "";

        errorMessage = sampleName = containerName = barcode = sampleStatusName = rejectedReason = receiveLocationName = collectedDateTime = outsourceLocation = temperature = volume = AddExternalBarcode = "";
        sampleCode = containerID = sampleStatusID = receiveLocationID = investigationID = shippingConditionID = volumeUnitID = 0;

        var ddlSampleNameOption = $('select[id$="ddlAddSampleName"] :selected');
        if (ddlSampleNameOption != null) {
            sampleCode = $(ddlSampleNameOption).val();
            sampleName = $(ddlSampleNameOption).text();
        }
        else {
            dummy = ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
            //errorMessage += "Select sample name" + "\n";
        }
if ($('input[id$="hdnIsShowStatus"]').val() == "Y" ) {
        lstSelectedInvName = ($('span[id$="lblInvName"]')).html();
        lstSelectedInvID = $('input[id$="hdnExtraSampleInvID"]').val();
       }

        var ddlAdditiveOption = $('select[id$="ddlAddAdditive"] :selected');
        if (ddlAdditiveOption != null && $(ddlAdditiveOption).val() > 0) {
            containerID = $(ddlAdditiveOption).val();
            containerName = $(ddlAdditiveOption).text();
        }

        var ddlStatusOption = $('select[id$="ddlAddStatus"] :selected');
        if (ddlStatusOption != null) {
            sampleStatusID = $(ddlStatusOption).val();
            //Added by Vijayalakshmi.M
            if (sampleStatusID == 1 && $('input[id$="hdnAddSampleStatuschange"]').val() != "Y" ) {
                sampleStatusID = 3;
            }
            //End
            sampleStatusName = $(ddlStatusOption).text();
        }
        else {
            dummy = ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
            //errorMessage += "Select sample status" + "\n";
        }

        if ($('input[id$="hdnIsBarcodeNeeded"]').val().toLowerCase() == "true") {
            barcode = $('input[id$="txtAddBarCode"]').val();
        }
        var barcodecount;
        if ($('input[id$="hdnIsNeedBarcodeCount"]').val() == "Y") {
            barcodecount = $('input[id$="TxtAddBarcodeCount"]').val();

        }
        else {
            barcodecount = "1";
        }
        
        
        //Added By Jayaramanan.L
        AddExternalBarCode = $('input[id$="ctlCollectSample_txtAddExternalBarcode"]').val();

        var ddlReasonOption = $('select[id$="ddlAddReason"] :selected');
        if (sampleStatusName == "Rejected") {
            if (ddlReasonOption != null) {
                rejectedReason = $(ddlReasonOption).text();
            }
            else {
                dummy = ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                // errorMessage += "Select reason" + "\n";
            }
        }
        else {
            if (ddlReasonOption != null) {
                rejectedReason = $(ddlReasonOption).text();
            }
            else {
                dummy = ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                // errorMessage += "Select reason" + "\n";
            }
        }

        var ddlLocationOption = $('select[id$="ddlAddLocation"] :selected');
        if (ddlLocationOption != null) {
            receiveLocationID = $(ddlLocationOption).val();
            receiveLocationName = $(ddlLocationOption).text();
        }
        else {
            dummy = ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            // errorMessage += "Select location" + "\n";
        }

        if (document.getElementById('ctlCollectSample_chkAddSample').checked == false) {
        if ($('table[id$="dlInvName"] input[type=checkbox]:checked').length <= 0) {
                //errorMessage += "Select an investigation" + "\n";
                dummy = ValidationWindow(UsrAlrtMsg4, AlrtWinHdr);
        }
        else {
            var $row;
            var investigationID = "";
            var isExistingInvName = false;
            var selectedInvIDList = [];
            $('table[id$="dlInvName"] input[type=checkbox]:checked').each(function() {
                if (lstSelectedInvName == "--") {
                    lstSelectedInvName = $(this).closest("td").find("span").html();
                    lstSelectedInvID = $(this).val() + "~" + $(this).closest("td").find("input[type=hidden]").val();
                }
                else {
                    lstSelectedInvName = lstSelectedInvName + "-" + $(this).closest("td").find("span").html();
                    lstSelectedInvID = lstSelectedInvID + "|" + $(this).val() + "~" + $(this).closest("td").find("input[type=hidden]").val();
                }
                selectedInvIDList.push($(this).val());
            });
            if ($('#tblCollectSample tr').length > 1) {
                $('#tblCollectSample tr:not(:first)').each(function(i, n) {
                    $row = $(n);
                    investigationID = $row.find($('input[id$="hdnInvestigationID"]')).val();
                    if (investigationID != undefined) {
                    if (investigationID.indexOf('~') >= 0) {
                        var lstInvID = investigationID.split('|');
                        $.each(lstInvID, function(i, item) {
                            strInvID = item.split('~');
                            $.each(selectedInvIDList, function(j, selInvID) {
                                if (selInvID == strInvID[0]) {
                                    isExistingInvName = true;
                                }
                            });
                        });
                    }
                    else {
                        if (investigationID.length > 0) {
                            strInvID = item.split('~');
                            $.each(selectedInvIDList, function(j, selInvID) {
                                if (selInvID == strInvID[0]) {
                                    isExistingInvName = true;
                                }
                            });
                            }
                        }
                    }
                });
            }
            if (isExistingInvName == true) {
                    //errorMessage += "Selected investigation(s) are already mapped with sample(s)" + "\n";
                    dummy = ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
                }
            }
        }
        else {
            if (containerID == '0') {
                dummy = ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
                //alert('Select Conatiner');
                return false;
            }
        }

        var SampleDate = $('input[id$="txtSampleDateCollect"]').val();
        if ($('input[id$="txtSampleDateCollect"]').val() == null || $('input[id$="txtSampleDateCollect"]').val() == "") {
            SampleDate = $('input[id$="DateTimePicker1_txtSampleDateCollect"]').val();
        }
        var SampleTime1 = $('input[id$="txtSampleTime1"]').val();
        var SampleTime2 = $('input[id$="txtSampleTime2"]').val();
        var ddlAction = $('select[id$="ddlSampleTimeType"] :selected').val();
        //var txtCollectedTime = $('input[id$="txtAddCollectedDate"]');

        var txtCollectedTime = SampleDate.replace(/\//g, '-') + " " + SampleTime1 + ":" + SampleTime2 + ":" + "00" + " " + ddlAction;
        if (txtCollectedTime != "") {
            var varRegEx = /^\d{2}\-\d{2}\-\d{4} \d{2}\:\d{2}(\:\d{2})?[AP]M$/;
            //            if (!$(txtCollectedTime).val().match(varRegEx)) {
            //                errorMessage += "Invalid sample collected date and time: " + $(txtCollectedTime).val() + "\n";
            //            }
            //            else {
            collectedDateTime = $(txtCollectedTime).val();
            // }
        }
        else {
            dummy = ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
            //errorMessage += "Enter sample collected date and time" + "\n";
        }
        var txtAddVolume = $('input[id$="txtAddVolume"]');
        volume = $(txtAddVolume).val();

        var ddlAddvolumeUnits = $('select[id$="ddlAddvolumeUnits"] :selected');
        if (ddlAddvolumeUnits != null) {
            volumeUnitID = $(ddlAddvolumeUnits).val();
        }
        else {
            dummy = ValidationWindow(UsrAlrtMsg8, AlrtWinHdr);
            //errorMessage += "Select Volume Unit" + "\n";
        }

        var ddlAddShippingCondition = $('select[id$="ddlAddShippingCondition"] :selected');
        if (ddlAddShippingCondition != null) {
            shippingConditionID = $(ddlAddShippingCondition).val();
        }
        else {
            // errorMessage += "Select Shipping Condition" + "\n";
            dummy = ValidationWindow(UsrAlrtMsg10, AlrtWinHdr);
        }
        if (dummy.length <= 0) {
            $('table[id$="dlInvName"] input[type=checkbox]:checked').attr('checked', false);
            //Added by Vijayalakshmi.M
            $('select[id$="ddlAddSampleName"] option[value="0"]').attr("selected", true);
            $('select[id$="ddlAddAdditive"] option[value="0"]').attr("selected", true);
            //End
            AddSample(sampleCode, sampleName, containerID, containerName, sampleStatusID, sampleStatusName, barcode, rejectedReason, receiveLocationID, receiveLocationName, lstSelectedInvID, lstSelectedInvName, collectedDateTime, outsourceLocation, temperature, volume, shippingConditionID, volumeUnitID, AddExternalBarCode, barcodecount);
            ChangeDDLItemListWidth();
        }
        else {
            //alert(errorMessage);
            return false;
        }
    }
    catch (e) {
        //ValidationWindow(UsrAlrtMsg9, AlrtWinHdr);
        //alert("There was a problem while adding sample");
        return false;
    }
    return false;
}
function AddSample(sampleCode, sampleName, containerID, containerName, sampleStatusID, sampleStatusName, barcode, rejectedReason, receiveLocationID, receiveLocationName, lstSelectedInvID, lstSelectedInvName, collectedDateTime, outsourceLocation, temperature, volume, shippingConditionID, volumeUnitID, AddExternalBarCode, barcodecount) {
    var strchange = SListForAppDisplay.Get('CommonControls_CollectSample_ascx_04') != null ? SListForAppDisplay.Get('CommonControls_CollectSample_ascx_04') : "Change";
    var strcontainer = SListForAppDisplay.Get('Scripts_CollectSample_js_70') != null ? SListForAppDisplay.Get('Scripts_CollectSample_js_70') : "Click here to Change Container Name";
    var strsample = SListForAppDisplay.Get('Scripts_CollectSample_js_71') != null ? SListForAppDisplay.Get('Scripts_CollectSample_js_71') : "Click here to Change Sample Type";
    var strbarcode = SListForAppDisplay.Get('Scripts_CollectSample_js_72') != null ? SListForAppDisplay.Get('Scripts_CollectSample_js_72') : "Click here to print barcode";
    var strdel = SListForAppDisplay.Get('Scripts_CollectSample_js_73') != null ? SListForAppDisplay.Get('Scripts_CollectSample_js_73') : "Click here to remove details";
    var strSelect = SListForAppDisplay.Get('CommonControls_CollectSample_ascx_02') != null ? SListForAppDisplay.Get('CommonControls_CollectSample_ascx_02') : "--Select--";
    try {
        var row = '<tr style="height: 17px;">';
        var lstSampleStatus = JSON.parse($('input[id$="hdnLstSampleStatus"]').val());
        var lstReceiveLoc = JSON.parse($('input[id$="hdnLstReceiveLoc"]').val());
        var lstOutSourceLoc = JSON.parse($('input[id$="hdnLstOutSourceLoc"]').val());
        var lstRejectReason = JSON.parse($('input[id$="hdnLstRejectReason"]').val());
        var lstDateTime = JSON.parse($('input[id$="hdnDateTime"]').val());
        var ddlStatus = "", ddlReason = "", ddlOutsource = "", ddlReceiveLoc = "";
        var statusOption = "", reasonOption = "", outSourceOption = "", receiveLocOption = "", Datetime = "";
        $.each(lstSampleStatus, function(i, obj) {
            if (obj.Value == sampleStatusID) {
                statusOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                statusOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });

        $.each(lstReceiveLoc, function(i, obj) {
            if (obj.Value == receiveLocationID) {
                receiveLocOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                receiveLocOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });
        var ddlAction1 = $('select[id$="DateTimePicker1_ddlSampleTimeType"] :selected').text();
        var ddlAction = $('select[id$="ddlSampleTimeType"] :selected').val();
        $.each(lstDateTime, function(i, obj) {
            if (obj.Name == ddlAction1) {
                Datetime += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                Datetime += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });
        if (sampleStatusID != 6) {
            reasonOption += "<option value='0'>" + strSelect + "</option>";
        }
        if (sampleStatusID == 4 || sampleStatusID == 6) {
            $.each(lstRejectReason, function(i, obj) {
                if (obj.ParentID == sampleStatusID) {
                    if (obj.Name == rejectedReason) {
                        reasonOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                    }
                    else {
                        reasonOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
                    }
                }
            });
        }
        if (sampleStatusID == 12) {
            $.each(lstOutSourceLoc, function(i, obj) {
                if (obj.Value == outsourceLocation) {
                    outSourceOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
                }
                else {
                    outSourceOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
                }
            });
        }
        else {
            outSourceOption += "<option value='0'>" + strSelect + "</option>";
        }
        var rowCount = $("#tblCollectSample tr").length;
        var SampleDate = $('input[id$="txtSampleDateCollect"]').val();
        if ($('input[id$="txtSampleDateCollect"]').val() == null || $('input[id$="txtSampleDateCollect"]').val() == "") {
            SampleDate = $('input[id$="DateTimePicker1_txtSampleDateCollect"]').val();
        }
        var SampleTime1 = $('input[id$="txtSampleTime1"]').val();
        var SampleTime2 = $('input[id$="txtSampleTime2"]').val();
        var ddlAction = $('select[id$="ddlSampleTimeType"] :selected').val();
        ddlStatus = '<span class="richcombobox" style="width: 80px;"><select id="tblCollectSample' + rowCount + 'ddlStatus" onChange="onSampleStatusChange(\'tblCollectSample' + rowCount + 'divReason\',\'tblCollectSample' + rowCount + 'divOutsource\',\'tblCollectSample' + rowCount + 'ddlReason\',\'tblCollectSample' + rowCount + 'ddlOutsource\',\'tblCollectSample' + rowCount + 'ddlStatus\');" title="Select Sample Status" class="ddl" style="width: 80px;">' + statusOption + '</select></span>';
        if (sampleStatusID == 4 || sampleStatusID == 6) {
            ddlReason = '<div id="tblCollectSample' + rowCount + 'divReason" style="display: block;"><span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlReason" class="ddl" style="width: 120px;" title="Select Reason">' + reasonOption + '</select></span></div>';
        }
        else {
            ddlReason = '<div id="tblCollectSample' + rowCount + 'divReason" style="display: none;"><span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlReason" class="ddl" style="width: 120px;" title="Select Reason">' + reasonOption + '</select></span></div>';
        }
        if (sampleStatusID == 12) {
            ddlOutsource = '<div id="tblCollectSample' + rowCount + 'divOutsource" style="display: block;"><span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlOutsource" class="ddl" style="width: 120px;" title="Select Outsource Location">' + outSourceOption + '</select></span></div>';
        }
        else {
            ddlOutsource = '<div id="tblCollectSample' + rowCount + 'divOutsource" style="display: none;"><span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlOutsource" class="ddl" style="width: 120px;" title="Select Outsource Location">' + outSourceOption + '</select></span></div>';
        }
        ddlReceiveLoc = '<span class="richcombobox" style="width: 130px;"><select id="tblCollectSample' + rowCount + 'ddlLocation" class="ddl" style="width: 130px;" title="Select Location">' + receiveLocOption + '</select></span>';
        // var txtCollectedDateTime = '<input id="tblCollectSample' + rowCount + 'txtCollectedDate" type="text" maxlength="25" title="dd-MM-yyyy hh:mm:ssAM/PM" size="10" style="width:120px;" value="' + collectedDateTime + '" class="Txtboxsmall" />';
        var txtCollectedDateTime = '<table width="20%" cellpadding="1" cellspacing="1" border="0">';
        txtCollectedDateTime += '<tr style="vertical-align:top;"><td><input type="text" value=' + SampleDate + ' id="tblCollectSample' + rowCount + '_DatePicker2_txtSampleDateCollect" title="dd/mm/yyyy" class="Txtboxsmall" style="height:16px;width:80px;" onfocus="Calenderclick(' + rowCount + ');" /></td>';
        txtCollectedDateTime += '<td><input type="text" value=' + SampleTime1 + ' maxlength="2" id="tblCollectSample' + rowCount + '_DatePicker2_txtSampleTime1" title="hr" class="Txtboxsmall" onkeypress="return blockNonNumbers(this, event, true, false);" style="height:16px;width:25px;" /></td>';
        txtCollectedDateTime += '<td><input  type="text" value=' + SampleTime2 + ' maxlength="2" id="tblCollectSample' + rowCount + '_DatePicker2_txtSampleTime2" title="mn" class="Txtboxsmall" onkeypress="return blockNonNumbers(this, event, true, false);" style="height:16px;width:25px;" /></td>';
        txtCollectedDateTime += '<td><select  id="tblCollectSample' + rowCount + '_DatePicker2_ddlSampleTimeType" class="ddl" style="height:19px;width:45px;">';
        //Added by Vijayalakshmi.m
//        if (ddlAction == 'AM') {
//            txtCollectedDateTime += '<option value="PM">PM</option><option selected="selected" value=' + ddlAction + '>' + ddlAction1 + '</option></select><img align="middle" alt="" src="../Images/starbutton.png" /></td></tr></table>';
//        }
//        else if (ddlAction == 'PM') {
//            txtCollectedDateTime += '<option value="AM">AM</option><option selected="selected" value=' + ddlAction + '>' + ddlAction1 + '</option></select><img align="middle" alt="" src="../Images/starbutton.png" /></td></tr></table>';
//        }
//        else {
//            txtCollectedDateTime += '<option value="PM">PM</option><option selected="selected" value="AM">AM</option></select><img align="middle" alt="" src="../Images/starbutton.png" /></td></tr></table>';
//        }
        //End
       // if (ddlAction == 'AM') {
            txtCollectedDateTime += Datetime+'</select><img align="middle" alt="" src="../Images/starbutton.png" /></td></tr></table>';
       // }
        var btnDeleteSample = '<input id="tblCollectSample' + rowCount + 'btnDeleteSample" class="deleteIcons" value="Delete" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="onSampleDelete(this);" title='+strdel+' />';
        row += '<td align="left"><span id="lblInvName">' + lstSelectedInvName + '</span><input id="tblCollectSample' + rowCount + 'hdnInvestigationID" type="hidden" value="' + lstSelectedInvID + '" /></td>';

        var btnSampleNameChange = '<input id="tblCollectSample' + rowCount + 'btnSampleNameChange" runat="server" value=' + strchange + ' type="button" style="background-color: Transparent; color: Green; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" align="right" onclick="onSampleNameChange(this);" title='+strsample+' />';
        var btnContainerNameChange = '<input id="tblCollectSample' + rowCount + 'btnContainerNameChange" runat="server" value=' + strchange + ' type="button" style="background-color: Transparent; color: Green; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" align="right" onclick="onContainerNameChange(this);" title='+strcontainer+' />';
        //Added by Vijayalakshmi.M
        var VisitID = $('input[id$="hdnVisitID"]').val();
        $('input[id$="hdnSampleCode1"]').val(sampleCode);
        //End
        row += '<td align="left">' + '<span id="lblSampleName">' + sampleName + '</span><input id="tblCollectSample' + rowCount + 'hdnSampleCode" type="hidden" value="' + sampleCode + '" />' + "&nbsp;" + btnSampleNameChange + '</td>';
        row += '<td align="left">' + '<span id="lblContainerName">' + containerName + '</span><input id="tblCollectSample' + rowCount + 'hdnContainerID" type="hidden" value="' + containerID + '" />' + "&nbsp;" + btnContainerNameChange + '</td>';
         //Added by Velmurugan D 
         if ($('input[id$="hdnIsEmptyBarcode"]').val() == "Y") {
           var txtBarcode = '<input id="tblCollectSample' + rowCount + 'txtBarcode" type="text" style="width:100px;" value="' + barcode + '" title="Enter Barcode / Label" class="Txtboxsmall" />';
            row += '<td align="center">' + txtBarcode + '</td>';
        }
        else if ($('input[id$="hdnIsBarcodeNeeded"]').val().toLowerCase() == "true") {
            var txtBarcode = '<input id="tblCollectSample' + rowCount + 'txtBarcode" type="text" style="width:100px;" value="' + GetBarcode(barcode) + '" title="Enter Barcode / Label" class="Txtboxsmall" />';
            row += '<td align="center">' + txtBarcode + '</td>';
        }
        //Added by Vijayalakshmi.M
        else if ($('input[id$="hdnIsBarcodeNeeded"]').val().toLowerCase() == "false") {
            var txtBarcode = '<input id="tblCollectSample' + rowCount + 'txtBarcode" type="text" style="width:100px;" value="' + GetBarcodeNo(barcode) + '" title="Enter Barcode / Label" class="Txtboxsmall" />';
            row += '<td align="center">' + txtBarcode + '</td>';
        }
        //End
        row += '<td align="center">' + ddlStatus + '</td>';
        //Added by Jayaramanan L
        if ($('input[id$="hdnIsExternalBarcode"]').val().toUpperCase() == "Y") {
        var ExternalBarcodeValue = '<input id="tblCollectSample' + rowCount + 'txtExternalBarcode" type="text" style="width:100px;" value="' + AddExternalBarCode + '" title="Enter External Barcode" class="Txtboxsmall" />';
        row += '<td align="center">' + ExternalBarcodeValue + '</td>';
    }

    // ADD by seetha

    if ($('input[id$="hdnIsNeedBarcodeCount"]').val().toUpperCase() == "Y") {
        var BarcodeCountValue = '<input id="tblCollectSample' + rowCount + 'TxtBarcodeCount" type="text"  value="' + barcodecount + '" title="Enter Barcode Count" class="Txtboxmicro" onkeypress="return ValidateOnlyNumeric(this);" onblur="validatePercentageKeyup(this.id);" />';
        row += '<td align="center">' + BarcodeCountValue + '</td>';
    }
        row += '<td align="center">' + ddlReason + ddlOutsource + '</td>';
        row += '<td align="center">' + ddlReceiveLoc + '</td>';
        row += '<td align="left">' + txtCollectedDateTime + '</td>';

        if ($('input[id$="hdnIsBarcodeNeeded"]').val().toLowerCase() == "true") {
            var btnPrintBarcode = '<input id="tblCollectSample' + rowCount + 'btnPrintBarcode" value="Print" type="button" class="printIcons" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;margin-left:3px;" onclick="onPrintBarcode(this);" title=' + strbarcode + ' />';
            row += '<td align="center">' + btnDeleteSample + "&nbsp;" + btnPrintBarcode + '</td>';
        }
        else {
            row += '<td align="center">' + btnDeleteSample + '</td>';
        }
        //New Attribute Code 
        var shippingConditionOption = "";
        var txtTemperature = "";
        var txtVolume = "";

        var lstShippingCondition = JSON.parse($('input[id$="hdnShippingCondition"]').val());

        $.each(lstShippingCondition, function(i, obj) {
            if (obj.Value == shippingConditionID) {
                shippingConditionOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                shippingConditionOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });

        txtVolume = '<input id="tblCollectSample' + rowCount + 'txtVolume" type="text" maxlength="25" title="Enter Sample volume" size="10" style="width:40px;" value="' + volume + '" class="Txtboxsmall" />';
        ddlShippingCondition = '<span class="richcombobox" style="width: 120px;"><select id="tblCollectSample' + rowCount + 'ddlShippingCondition" class="ddl" style="width: 120px;" title="Select Location">' + shippingConditionOption + '</select></span>';

        row += "</tr>";

        AddChildSample(sampleCode, sampleName, containerID, containerName, temperature, volume, shippingConditionID, volumeUnitID);

        $('[id$="pnlSamples"]').show();
        $("#tblCollectSample").append(row);
        if ($('input[id$="hdnBarCodeEdit"]').val() == "Y") {
           $('input[id$="txtBarcode"]').prop("disabled", false);
        }
        else
        {
         $('input[id$="txtBarcode"]').prop("disabled", true);
        }
       
        $('select[id$="ddlLocation"]').prop("disabled", true);
        if (containerID != '' && containerID != '0') {
            var lstContainerCount = [];
            if ($.trim($('input[id$="hdnContainerCount"]').val()) != '') {
                lstContainerCount = JSON.parse($('input[id$="hdnContainerCount"]').val());
            }
            var isExists = false;
            var arrayIndex = 0;
            $.each(lstContainerCount, function(i, obj) {
                if (obj.SampleContainerID == containerID) {
                    isExists = true;
                    arrayIndex = i;
                    return false;
                }
            });
            if (isExists) {
                var oInvSampleContainer = lstContainerCount[arrayIndex];
                oInvSampleContainer.ContainerCount = oInvSampleContainer.ContainerCount + 1;
                lstContainerCount.splice(arrayIndex, 1);
                lstContainerCount.splice(arrayIndex, 0, oInvSampleContainer);
            }
            else {
                lstContainerCount.push({
                    SampleContainerID: containerID,
                    ContainerName: containerName,
                    ContainerCount: 1
                });
            }
            $('input[id$="hdnContainerCount"]').val(JSON.stringify(lstContainerCount));
            onShowContainerCount();
        }
    }
    catch (e) {
        throw e;
    }
}
function Calenderclick(rowCount) {
    var Val = $get("tblCollectSample" + rowCount + "_DatePicker2_txtSampleDateCollect").defaultValue;
    if ($find('ctlCollectSample_DatePicker1_CalendarExtender12')) {
        $find('ctlCollectSample_DatePicker1_CalendarExtender12').dispose();
    }
    $create(AjaxControlToolkit.CalendarBehavior, { "button": $get("ImgBntCalc"), "id": 'ctlCollectSample_DatePicker1_CalendarExtender12', "format": "dd/MM/yyyy" }, null, null, $get("tblCollectSample" + rowCount + "_DatePicker2_txtSampleDateCollect"));
    $find('ctlCollectSample_DatePicker1_CalendarExtender12').show();
    hideCalendar("tblCollectSample" + rowCount + "_DatePicker2_txtSampleDateCollect", Val);
}

function hideCalendar(TxtId, Val) {
    var elem = $get(TxtId).value;
    if (elem == null) return;
    if (Val != elem) {
        $find('ctlCollectSample_DatePicker1_CalendarExtender12').dispose();
    }
    else {
        $find('ctlCollectSample_DatePicker1_CalendarExtender12').show();
    }
}
function GenerateWorkOrder(OrgID, LoginID, LocationID, VisitID, UID, CollectAgain, SampleRelationshipID) {
    try {
        var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
        var UsrAlrtMsg = SListForAppMsg.Get("Scripts_CollectSample_js_11") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_11") : "Following investigation(s) are not mapped with sample(s)";
        var UsrAlrtMsg1 = SListForAppMsg.Get("Scripts_CollectSample_js_12") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_12") : "Following investigation's reason are not mapped with associated status";
        var UsrAlrtMsg2 = SListForAppMsg.Get("Scripts_CollectSample_js_13") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_13") : "Following investigation's outsource location are not mapped with associated status";
        var UsrAlrtMsg3 = SListForAppMsg.Get("Scripts_CollectSample_js_14") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_14") : "Following investigation's collected time are not mapped with sample(s)";
        var UsrAlrtMsg4 = SListForAppMsg.Get("Scripts_CollectSample_js_15") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_15") : "Following investigation's collected time are not in correct format";
        var UsrAlrtMsg5 = SListForAppMsg.Get("Scripts_CollectSample_js_16") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_16") : "Collect sample for current visit and then click generate work order";
        var UsrAlrtMsg6 = SListForAppMsg.Get("Scripts_CollectSample_js_17") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_17") : "Select department and then click generate work order";
        var UsrAlrtMsg7 = SListForAppMsg.Get("Scripts_CollectSample_js_18") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_18") : "There was a problem in generating work order";
        var dummy = "";
        document.getElementById('btnFinish').style.display = "none";
        var errorMessage = "";
        var emptybarcode = 0;
        
        if ($('#tblCollectSample tr').length > 1) {
            var $row;
            var lstCollectedInv = "", collectedDateTime = "", invID = "", invName = "";
            var isAllInvMapped = true, isAllReasonMapped = true, isAllOutsourceMapped = true, isAllCollectedTimeMapped = true, isAllCollectedTimeValid = true;
            var lstNotCollectedInv = "", lstNotMappedReason = "", lstNotMappedOutsource = "", lstNotMappedCollectedTime = "", lstInvalidCollectedTime = "";
            var selectedStatusOption, selectedReasonOption, selectedOutsourceOption;
            var varRegEx = /^\d{2}\-\d{2}\-\d{4} \d{2}\:\d{2}(\:\d{2})?[AP]M$/;
            $('#tblCollectSample tr:not(:first)').each(function(i, n) {
                $row = $(n);
                var barcodeNumber = $row.find($('input[id$="txtBarcode"]')).val();
                if (barcodeNumber != '' && barcodeNumber != undefined) {
                    barcodeNumber = barcodeNumber.trim();

                }
                if (barcodeNumber == '' || barcodeNumber == undefined) {

                    emptybarcode = "1";
                }
                
                invID = $row.find($('input[id$="hdnInvestigationID"]')).val();
                invName = $row.find($('span[id$="lblInvName"]')).html();
                if (invID != undefined) {
                    if (invID.indexOf('~') >= 0) {
                        var lstInvID = invID.split('|');
                        $.each(lstInvID, function (i, item) {
                            strInvID = item.split('~');
                            if (lstCollectedInv == "")
                                lstCollectedInv += strInvID[0];
                            else
                                lstCollectedInv += "~" + strInvID[0];
                        });
                    }
                    else {
                        if (invID.length > 0) {
                            strInvID = item.split('~');
                            if (lstCollectedInv == "")
                                lstCollectedInv += strInvID[0];
                            else
                                lstCollectedInv += "~" + strInvID[0];
                        }
                    }
                    selectedStatusOption = $row.find($('select[id$="ddlStatus"] option:selected'));
                    if ($(selectedStatusOption).val() == "4" || $(selectedStatusOption).val() == "6") {
                        selectedReasonOption = $row.find($('select[id$="ddlReason"] option:selected'));
                        if ($(selectedReasonOption).val() == "0" || $(selectedReasonOption).val() == "") {
                            lstNotMappedReason += invName + "\n";
                            isAllReasonMapped = false;
                        }
                    }
                    else if ($(selectedStatusOption).val() == "12") {
                        selectedOutsourceOption = $row.find($('select[id$="ddlOutsource"] option:selected'));
                        if ($(selectedOutsourceOption).val() == "0" || $(selectedOutsourceOption).val() == "") {
                            lstNotMappedOutsource += invName + "\n";
                            isAllOutsourceMapped = false;
                        }
                    }
                    //var SampleDate = $('input[id$="txtSampleDateCollect"]').val();
                    //if ($('input[id$="txtSampleDateCollect"]').val() == null || $('input[id$="txtSampleDateCollect"]').val() == "") {
                    var SampleDate = $('input[id$="DatePicker2_txtSampleDateCollect"]').val();
                   // }
                    if (SampleDate != "") {
                        var SampleTime1 = $('input[id$="DatePicker2_txtSampleTime1"]').val();
                        var SampleTime2 = $('input[id$="DatePicker2_txtSampleTime2"]').val();
                        var ddlAction = $('select[id$="DatePicker2_ddlSampleTimeType"] :selected').val();
                        if (ddlAction == '0') {
                            ddlAction = "AM";
                        }
                    }
                    else {
                        SampleDate = '01/01/1753';
                        var SampleTime1 = '00';
                        var SampleTime2 = '00';
                        var ddlAction = 'AM';
                    }
                    var txtCollectedDate = SampleDate.replace(/\//g, '-') + " " + SampleTime1 + ":" + SampleTime2 + ":" + "00" + " " + ddlAction;
                    collectedDateTime = txtCollectedDate;
                    if (collectedDateTime != "") {
                        //                    if (!collectedDateTime.match(varRegEx)) {
                        //                        lstInvalidCollectedTime += invName + "\n";
                        //                        isAllCollectedTimeValid = false;
                        //                    }
                    }
                    else {
                        lstNotMappedCollectedTime += invName + "\n";
                        isAllCollectedTimeMapped = false;
                    }
                }
            });
            var lstMappedInvestigations = lstCollectedInv.split('~');
            $('table[id$="dlInvName"] input[type=checkbox]').each(function() {
                var dlInvID = $(this).val();
                var $row = $(this).closest("tr");
                if ($.inArray($(this).val(), lstMappedInvestigations) == -1) {
                    lstNotCollectedInv += $row.find($('span[id$="lblInvName"]')).html() + "\n";
                    isAllInvMapped = false;
                }
            });
            var IsEmptyBarcode = 'N';
            if ($('#tblCollectSample tr').length > 1) {
                $('#tblCollectSample tr:not(:first)').each(function(i, n) {
                    $row = $(n);
                    var barcodeNumber = $row.find($('input[id$="txtBarcode"]')).val();

                    if (barcodeNumber == '') {
                        IsEmptyBarcode = 'Y';
                    }

                });
            }
             
            if (IsEmptyBarcode == 'Y') {

                dummy = ValidationWindow("" + "Barcode is Empty Please update the Barcode", AlrtWinHdr);
                $('#btnFinish').show();
                //                return false;
            }
            
            if (!isAllInvMapped) {
                dummy = ValidationWindow(UsrAlrtMsg + lstNotCollectedInv, AlrtWinHdr);
                // errorMessage += "Following investigation(s) are not mapped with sample(s)" + "\n" + lstNotCollectedInv + "\n";
            }
            if (!isAllReasonMapped) {
                dummy = ValidationWindow(UsrAlrtMsg1 + lstNotMappedReason, AlrtWinHdr);
                //errorMessage += "Following investigation's reason are not mapped with associated status" + "\n" + lstNotMappedReason + "\n";
            }
            if (!isAllOutsourceMapped) {
                dummy = ValidationWindow(UsrAlrtMsg2 + lstNotMappedOutsource, AlrtWinHdr);
                //  errorMessage += "Following investigation's outsource location are not mapped with associated status" + "\n" + lstNotMappedOutsource + "\n";
            }
            if (!isAllCollectedTimeMapped) {
                dummy = ValidationWindow(UsrAlrtMsg3 + lstNotMappedCollectedTime, AlrtWinHdr);
                //  errorMessage += "Following investigation's collected time are not mapped with sample(s)" + "\n" + lstNotMappedCollectedTime + "\n";
            }
            if (!isAllCollectedTimeValid) {
                dummy = ValidationWindow(UsrAlrtMsg4 + lstInvalidCollectedTime, AlrtWinHdr);
                //   errorMessage += "Following investigation's collected time are not in correct format" + "\n" + lstInvalidCollectedTime + "\n";
            }

        }
        else {
            dummy = ValidationWindow(UsrAlrtMsg5, AlrtWinHdr);
            // errzorMessage += "Collect sample for current visit and then click generate work order" + "\n";
        }
        if ($("#repDepts input[type=checkbox]:checked").length <= 0) {
            dummy = ValidationWindow(UsrAlrtMsg6, AlrtWinHdr);
            // errorMessage += "Select department and then click generate work order" + "\n";
        }

//        if (emptybarcode == "1") {
//            $('#btnFinish').show();
//            alert("Please enter barcode");
//            return false;
//        }
        if (dummy != "") {
            //alert(errorMessage);
            $('#btnFinish').show();
            return false;
            
        }
        else {
            GenerateSampleList(OrgID, LoginID, LocationID, VisitID, UID, CollectAgain, SampleRelationshipID);
            // return false;
        }
    }
 
    catch (e) {
        ValidationWindow(UsrAlrtMsg7, AlrtWinHdr);
        //alert("There was a problem in generating work order");
        return false;
    }
}

function validateSpecialCharacters(e) {
    var keyCode = e.keyCode == 0 ? e.charCode : e.keyCode;
    var ret = ((keyCode == 45 || (keyCode >= 47 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122)
     && e.charCode != e.keyCode));
    if ((keyCode == 13  || keyCode == 45 ||  (keyCode >= 47 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 97 && keyCode <= 122))) {
       
    }
    else {
        alert("Special characters are not allowed."); 
                  return false;
    } 
} 
 

function IsBarcodeExist(OrgID, txtbarcode, DofromVisit) {
try
{
    var IsbarcodeExist = "";
    var barcodeNumber = document.getElementById(txtbarcode).value;
    if (barcodeNumber != '') {
        $('#tblCollectSample tr:not(:first)').each(function(i, n) {
            $row = $(n);
            barcodeNumber1 = $row.find($('input[id$="txtBarcode"]')).val();
            if (barcodeNumber1 != '' && barcodeNumber1 != undefined) {
                if ($row.find($('input[id$="txtBarcode"]'))[i] != undefined && $row.find($('input[id$="txtBarcode"]'))[i].id != txtbarcode) {
                    if (barcodeNumber == barcodeNumber1)
                        alert("This barcode is already used in other sample");
                    //document.getElementById(txtbarcode).value = '';
                    return false;
                }
            }
        });
    }
    else {

        if (barcodeNumber == '' || barcodeNumber == undefined) {
            $('#tblCollectSample tr:not(:first)').each(function(i, n) {
                $row = $(n);
                barcodeNumber1 = $row.find($('input[id$="txtBarcode"]')).val();
                if (barcodeNumber1 == "" || barcodeNumber1 == undefined) {
                    alert("Barcode is Empty Please update the Barcode");
                    //document.getElementById('btnFinish').style.display = "block";
                    //document.getElementById(txtbarcode).value = '';
                    return false;

                }
            });
        } 
    }
//    if (barcodeNumber.length < 8) {
//        alert("Please Enter Eight Digit Barcode");
//        return false;
//    }
    if (DofromVisit == 'N' && barcodeNumber != "") {

        $.ajax({
            type: "POST",
            url: "../WebService.asmx/CheckExistingBarcode",
            data: JSON.stringify({ OrgID: OrgID, Barcodenumber: barcodeNumber }),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            async: false,
            success: function Success(data) {
                if (data != "[]" && data.d.length > 0) {
                        alert("Barcode Already Exist, Please Enter New Barcode");
                        document.getElementById(txtbarcode).value = "";
                       // document.getElementById(txtbarcode).focus();
                        return false;
                }

            },
            error: function(xhr, ajaxOptions, thrownError) {
                return false;
            }
        });
    }
}
    catch (e) {
        return false;
    }

}

function GenerateSampleList(OrgID, LoginID, LocationID, VisitID, UID, CollectAgain, SampleRelationshipID) {
    try {
        if ($('#tblCollectSample tr').length > 1) {
            TableToJson(OrgID, LoginID, LocationID, VisitID, UID, CollectAgain, SampleRelationshipID);
        }
    }
    catch (e) {
        throw e;
    }
}

function TableToJson(OrgID, LoginID, LocationID, VisitID, UID, CollectAgain, SampleRelationshipID) {
    try {
        ////debugger;
        var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
        var usermsg = SListForAppMsg.Get("Scripts_CollectSample_js_19") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_19") : "There was a problem while getting collected sample details";
        var lstPatientInvSample = [];
        var lstPatientInvestigation = [];
        var lstSampleTracker = [];
        var lstPatientInvSampleMapping = [];
        var lstInvestigationValues = [];
        var sampleID = 0, sampleContainerID = 0, invSampleStatusDesc = "", barcodeNumber = "0", locationName = "", recSampleLocID = 0, collectedDateTime = "", OldSampleID = 0, ExternalBarcode = "0";
        var invSampleStatusID = 0;
        var investigationID = "", strInvID = "";
        var selectedStatusOption, selectedRecLocOption, selectedOutsourceLocOption, selectedReason;
        var referralID = -1;
        var $row;
        var lstCollectedSampleStatus = [];
        var tblAttributes = $('table[id$="tblChildCollectSample"]');
        var vmValue, vmUnitId, shippingConditionId = 0;
        var count = 0;
        $('#tblCollectSample tr:not(:first)').each(function(i, n) {
            $row = $(n);
            count = count + 1;
            sampleID = $row.find($('input[id$="hdnSampleCode"]')).val();
            if (sampleID != undefined) {
            sampleContainerID = $row.find($('input[id$="hdnContainerID"]')).val();
            investigationID = $row.find($('input[id$="hdnInvestigationID"]')).val();
            OldSampleID = $row.find($('input[id$="hdnOldSampleID"]')).val();
            selectedRecLocOption = $row.find($('select[id$="ddlLocation"] option:selected'));
            selectedStatusOption = $row.find($('select[id$="ddlStatus"] option:selected'));
            OutsourceLocOption = $row.find($('select[id$="ddlOutsource"] option:selected'));
            invSampleStatusDesc = $(selectedStatusOption).text();
                invSampleStatusID = $(selectedStatusOption).val();
                if ($(selectedStatusOption).val() == "1") {
                    invSampleStatusDesc = "Collected"
                }
                else if ($(selectedStatusOption).val() == "2") {
                invSampleStatusDesc = "SampleInTransit"
                }
                else if ($(selectedStatusOption).val() == "3") {
                invSampleStatusDesc = "Received"
                }
                else if ($(selectedStatusOption).val() == "4") {
                invSampleStatusDesc = "Rejected"
                }
                else if ($(selectedStatusOption).val() == "5") {
                invSampleStatusDesc = "YetToReceived"
                }
                else if ($(selectedStatusOption).val() == "6") {
                invSampleStatusDesc = "Not given"
                }
                else if ($(selectedStatusOption).val() == "7") {
                invSampleStatusDesc = "Held for Storage"
                }
                else if ($(selectedStatusOption).val() == "8") {
                invSampleStatusDesc = "ProblemSample"
                }
                else if ($(selectedStatusOption).val() == "12") {
                invSampleStatusDesc = "OutSource"
                }
            /*/ Modified By Sathish.E/*/

            //            if (invSampleStatusDesc == 'OutSource') {
            //                invSampleStatusDesc = 'Collected';
            //            }
            //Modified By Ramkumar.S,avoiding Barcode ZERO
            //if ($('input[id$="hdnIsBarcodeNeeded"]').val().toLowerCase() == "true") {
                barcodeNumber = $row.find($('input[id$="txtBarcode"]')).val();
                //Added By Jayaramanan.L
                ExternalBarcode = $row.find($('input[id$="txtExternalBarcode"]')).val();
                Barcodecount = $row.find($('input[id$="TxtBarcodeCount"]')).val();
                //}
            //--End--
            if (barcodeNumber.length <= 0)
                barcodeNumber = "0";
            locationName = $(selectedRecLocOption).text();
            recSampleLocID = $(selectedRecLocOption).val();
                //var SampleDate = $('input[id$="txtSampleDateCollect"]').val();
                //var SampleDate = $row.find($('input[id$="txtSampleDateCollect"]')).val();
               // if ($('input[id$="txtSampleDateCollect"]').val() == null || $('input[id$="txtSampleDateCollect"]').val() == "") {
                var SampleDate = $('input[id$="DatePicker2_txtSampleDateCollect"]').val();
                //}
                if (SampleDate != "") {
                    var SampleTime1 = $('input[id$="DatePicker2_txtSampleTime1"]').val();
                    var SampleTime2 = $('input[id$="DatePicker2_txtSampleTime2"]').val();
                    var ddlAction = $('select[id$="DatePicker2_ddlSampleTimeType"] :selected').val();
                    if (ddlAction == '0') {
                        ddlAction = "AM";
                    }
                }
                else {
                    SampleDate = '01/01/1753';
                    var SampleTime1 = '00';
                    var SampleTime2 = '00';
                    var ddlAction = 'AM';
                }
                var txtCollectedDate = SampleDate.replace(/\//g, '-') + " " + SampleTime1 + ":" + SampleTime2 + ":" + "00" + ddlAction
                collectedDateTime = Date.parseLocale(txtCollectedDate, 'dd-MM-yyyy hh:mm:sstt');

                //if (ddlAction == "PM") {
                if (ddlAction == "PM" && parseInt(SampleTime1) < 12) {
                    SampleTime1 = parseInt(SampleTime1) + 12;
                }
                if (SampleDate.split('/').length == 3) {
                    //txtCollectedDate = SampleDate.split('/')[2] + "/" + SampleDate.split('/')[1] + "/" + SampleDate.split('/')[0] + " " + SampleTime1 + ":" + SampleTime2 + ":" + "00";
                    txtCollectedDate = SampleDate.split('/')[1] + "-" + SampleDate.split('/')[0] + "-" + SampleDate.split('/')[2] + " " + SampleTime1 + ":" + SampleTime2 + ":" + "00" + ddlAction;
                    //collectedDateTime = new Date(Date.parse(txtCollectedDate));
                    collectedDateTime = txtCollectedDate;
                }
            if (CollectAgain != 'Y') {
                SampleRelationshipID = 0;
            }
            var rowAttributes = $(tblAttributes).find('tr:eq(' + $row.index() + ')');
            vmValue = $(rowAttributes).find($('input[id$="txtVolume"]')).val();
            if (vmValue == '') vmValue = 0;
            vmUnitId = $(rowAttributes).find($('select[id$="ddlvolumeUnits"] option:selected')).val();
            shippingConditionId = $(rowAttributes).find($('select[id$="ddlShippingCondition"] option:selected')).val();
            lstPatientInvSample.push({
                PatientVisitID: VisitID,
                OrgID: OrgID,
                CreatedBy: LoginID,
                CollectedLocID: LocationID,
                SampleRelationshipID: OldSampleID,
                UID: UID,
                SampleCode: sampleID,
                SampleContainerID: sampleContainerID,
                InvSampleStatusDesc: invSampleStatusDesc,
                    InvSampleStatusID: invSampleStatusID,
                    BarcodeNumber: barcodeNumber,
                LocationName: locationName,
                RecSampleLocID: recSampleLocID,
                CollectedDateTime: collectedDateTime,
                VmValue: vmValue,
                VmUnitID: vmUnitId,
                SampleConditionID: shippingConditionId,
                ExternalBarcode: ExternalBarcode,
                BarcodeCount: Barcodecount
            });
            selectedReason = '';
            var IsOutSourced = $(OutsourceLocOption).val();
            if ($(selectedStatusOption).val() == "4" || $(selectedStatusOption).val() == "6") {
                selectedReason = $row.find($('select[id$="ddlReason"] option:selected')).text();
            }
            else if (IsOutSourced != undefined && IsOutSourced != "" && IsOutSourced != null) {
                selectedOutsourceLocOption = $row.find($('select[id$="ddlOutsource"] option:selected'));
            }
            /*Modified By Sathish.E*/
            var SampleStatusID;
            if (IsOutSourced != null && IsOutSourced != undefined && IsOutSourced != "") {
                SampleStatusID = $(selectedStatusOption).val();
            }
            else {
                SampleStatusID = $(selectedStatusOption).val();
            }
            lstSampleTracker.push({
                PatientVisitID: VisitID,
                DeptID: $("#hDept").val(),
                CreatedBy: LoginID,
                OrgID: OrgID,
                CollectedIn: LocationID,
                InvSampleStatusID: SampleStatusID,
                Reason: selectedReason,
                Barcode: barcodeNumber,
                SampleID: sampleID
            });

                lstCollectedSampleStatus.push(invSampleStatusDesc);
            if (investigationID.indexOf('~') >= 0) {
                var lstInvID = investigationID.split('|');
                $.each(lstInvID, function(i, item) {
                    strInvID = item.split('~');
                    lstPatientInvSampleMapping.push({
                        ID: strInvID[0],
                        SampleID: sampleID,
                        Type: strInvID[1],
                        Barcode: barcodeNumber,
                        VisitID: VisitID,
                        OrgID: OrgID,
                        UID: UID,
                        ExternalBarcode: ExternalBarcode
                    });
                    lstPatientInvestigation.push({
                    InvestigationID: strInvID[2],
                    GroupID: strInvID[3],
                    PackageID: strInvID[4],
                    InvSampleStatusID: $(selectedStatusOption).val(),
                    PatientVisitID: VisitID,
                    OrgID: OrgID,
                    UID: UID    ,
                    AccessionNumber: strInvID[5]              
                    });
                    if ($(selectedStatusOption).val() == "1" || $(selectedStatusOption).val() == "3" || $(selectedStatusOption).val() == "12" || $(selectedStatusOption).val() == "4" || $(selectedStatusOption).val() == "6") {
                        if (IsOutSourced != null && IsOutSourced != "" && IsOutSourced != undefined && IsOutSourced != "0") {//Added by vijayalakshmi.M
                            referralID = $(selectedOutsourceLocOption).val();
                        }
                        else {
                            referralID = -1;
                        }
                        /*Modified By Sathish.E*/
                        var pSampleStatusDesc;
                        if ($(selectedStatusOption).val() == "12") {
                            pSampleStatusDesc = 'Collected';
                        }
                        else {
                                pSampleStatusDesc = invSampleStatusDesc;
                        }
                        lstInvestigationValues.push({
                            InvestigationID: strInvID[0],
                            Orgid: OrgID,
                            Status: strInvID[1],
                            Value: pSampleStatusDesc,
                            ReferralID: referralID,
                            SequenceNo: recSampleLocID
                        });
                    }
                });
            }
            else {
                if (investigationID.length > 0) {
                    strInvID = item.split('~');
                    lstPatientInvSampleMapping.push({
                        ID: strInvID[0],
                        SampleID: sampleID,
                        Type: strInvID[1],
                        Barcode: barcodeNumber,
                        VisitID: VisitID,
                        OrgID: OrgID,
                        UID: UID,
                        ExternalBarcode: ExternalBarcode
                    });
                    if ($(selectedStatusOption).val() == "1" || $(selectedStatusOption).val() == "3" || $(selectedStatusOption).val() == "4" || $(selectedStatusOption).val() == "6") {
                        lstInvestigationValues.push({
                            InvestigationID: strInvID[0],
                            Orgid: OrgID,
                            Status: strInvID[1],
                            Value: $(selectedStatusOption).text(),
                            SequenceNo: recSampleLocID
                        });
                    }

                else {
//                    strInvID = '-1';
                    lstPatientInvSampleMapping.push({
                        ID: '-1',
                        SampleID: sampleID,
                        Type: '',
                        Barcode: barcodeNumber,
                        VisitID: VisitID,
                        OrgID: OrgID,
                        UID: UID,
                        ExternalBarcode: ExternalBarcode
                    });
                    if ($(selectedStatusOption).val() == "1" || $(selectedStatusOption).val() == "3" || $(selectedStatusOption).val() == "4" || $(selectedStatusOption).val() == "6") {
                        lstInvestigationValues.push({
                            InvestigationID:'-1',
                            Orgid: OrgID,
                            Status: '',
                            Value: $(selectedStatusOption).text(),
                            SequenceNo: recSampleLocID
                        });
                            }
                        }
                    }
                }
            }
        });
        if (lstPatientInvSample.length > 0 && lstSampleTracker.length > 0 && lstPatientInvSampleMapping.length > 0) {
            $('#hdnLstPatientInvSample').val(JSON.stringify(lstPatientInvSample));
            $('#hdnLstSampleTracker').val(JSON.stringify(lstSampleTracker));
            $('#hdnLstPatientInvSampleMapping').val(JSON.stringify(lstPatientInvSampleMapping));
            $('#hdnLstInvestigationValues').val(JSON.stringify(lstInvestigationValues));
            $('#hdnLstCollectedSampleStatus').val(JSON.stringify(lstCollectedSampleStatus));
            $('#hdnLstPatientInvestigation').val(JSON.stringify(lstPatientInvestigation));
        }
        else {
            ValidationWindow(usermsg, AlrtWinHdr);
            //alert("There was a problem while getting collected sample details");
            return false;
        }
    }
    catch (e) {
        throw e;
    }
}
function onPrintBarcode(obj) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
    var usermsg = SListForAppMsg.Get("Scripts_CollectSample_js_20") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_20") : "There is no barcode number to print";
    var $row = $(obj).closest('tr');
    var txtBarcode = $row.find($('input[id$="txtBarcode"]'));
    if ($(txtBarcode).val() == "" || $(txtBarcode).val() == "0") {
        $.ajax({
            url: "../WebService.asmx/GetNextBarcode",
            type: 'POST',
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function(data) {
                var barcode = data.d;
                if (barcode != "" || barcode != "0") {
                    barcode = barcode + "/" + $("#hdnEmpNo").val();
                    $(txtBarcode).val(barcode);
                    PrintBarcode(barcode);
                }
                else {
                    ValidationWindow(usermsg, AlrtWinHdr);
                    // alert("There is no barcode number to print");
                }
            },
            error: function(xhr, textStatus, errorThrown) {
                alert(textStatus);
            }
        });
    }
    else {
        PrintBarcode($(txtBarcode).val());
    }
}
function PrintBarcode(BarCode) {
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
    var usermsg = SListForAppMsg.Get("Scripts_CollectSample_js_20") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_20") : "There is no barcode number to print";
    if (BarCode == "" || BarCode == "0") {
        ValidationWindow(usermsg, AlrtWinHdr);
        //alert("There is no barcode number to print");
    }
    else {
        var prtContent = BarCode;
        var WinPrint = window.open('', '', 'letf=0,top=0,toolbar=0,scrollbars=0,status=0');
        WinPrint.document.write(prtContent);
        WinPrint.document.close();
        WinPrint.focus();
        WinPrint.print();
        WinPrint.close();
    }
}
//Added by Vijayalakshmi.M
function GetBarcodeNo(barcode) {
try
{
    ////debugger;
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
    var usermsg = SListForAppMsg.Get("Scripts_CollectSample_js_21") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_21") : "There is a Problem In Barcode Generation";
    var VisitID = $('input[id$="hdnVisitID"]').val();
    var sampleCode = $('input[id$="hdnSampleCode1"]').val();
    $.ajax({
        url: "../WebService.asmx/GetBarcodeNo",
        type: 'POST',
        data: JSON.stringify({ VisitId: VisitID, SampleCode: sampleCode, BarcodeNumber: barcode }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            if (data.d != "" || data.d != "0") {
                barcodeFromDB = data.d;
                $('input[id$="hdnBarcodewithSuffix"]').val(barcodeFromDB);
            } else {
                ValidationWindow(usermsg, AlrtWinHdr);
                // alert("There is a Problem In Barcode Generation");
            }
        },
        error: function(xhr, textStatus, errorThrown) {
            alert(textStatus);
        }
    });
    return barcodeFromDB;
}
    catch (e) {
        return false;
    }
}
//End
function GetBarcode(barcode) {
try
{
    var AlrtWinHdr = SListForAppMsg.Get("Scripts_datetimepicker_js_02") != null ? SListForAppMsg.Get("Scripts_datetimepicker_js_02") : "Information";
    var usermsg = SListForAppMsg.Get("Scripts_CollectSample_js_21") != null ? SListForAppMsg.Get("Scripts_CollectSample_js_21") : "There is a Problem In Barcode Generation";
    var barcodeFromDB = "0";
    var barcodeNo = "0";
    if ($('input[id$="hdnIsBarcodeNeeded"]').val().toLowerCase() == "true") {
        if (barcode == "" || barcode == "0") {
            $.ajax({
                url: "../WebService.asmx/GetNextBarcode",
                type: 'POST',
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: false,
                success: function (data) {
                    if (data.d != "" || data.d != "0") {
                        // barcodeFromDB = data.d;
                        GetBarcodeNo(data.d)
                        barcodeNo = $('input[id$="hdnBarcodewithSuffix"]').val();
                    } else {
                        ValidationWindow(usermsg, AlrtWinHdr);
                        // alert("There is a Problem In Barcode Generation");
                    }
                },
                error: function (xhr, textStatus, errorThrown) {
                    alert(textStatus);
                }
            });
            return barcodeNo;
        }
        else {
            return barcode;
        }
    } else {
        var count = 0;
        if ($('#tblCollectSample tr').length > 1) {
            $('#tblCollectSample tr:not(:first)').each(function(i, n) {
                $row = $(n);
                if ($row != undefined) {
                    investigationID = $row.find($('input[id$="hdnSampleCode"]')).val(); //hdnSampleCode
                    if (investigationID != undefined) {
                        if (investigationID.indexOf('~') >= 0) {
                            count++;
                        } else {
                            if (investigationID.length > 0) {
                                count++;
                            }
                        }
                    }
                }

            });
        }
        count = count + 1;

        var Visitnumber = $('input[id$="hdnvisitnumber"]').val();
        switch (count) {
            case 1:
                Visitnumber = Visitnumber + "A";
                break;
            case 2:
                Visitnumber = Visitnumber + "B";
                break;
            case 3:
                Visitnumber = Visitnumber + "C";
                break;
            case 4:
                Visitnumber = Visitnumber + "D";
                break;
            case 5:
                Visitnumber = Visitnumber + "E";
                break;
            case 6:
                Visitnumber = Visitnumber + "F";
                break;
            case 7:
                Visitnumber = Visitnumber + "G";
                break;
            case 8:
                Visitnumber = Visitnumber + "H";
                break;
            case 9:
                Visitnumber = Visitnumber + "I";
                break;
            case 10:
                Visitnumber = Visitnumber + "J";
                break;
            case 11:
                Visitnumber = Visitnumber + "K";
                break;
            case 12:
                Visitnumber = Visitnumber + "L";
                break;
            case 13:
                Visitnumber = Visitnumber + "M";
                break;
            case 14:
                Visitnumber = Visitnumber + "N";
                break;
            case 15:
                Visitnumber = Visitnumber + "O";
                break;
            case 16:
                Visitnumber = Visitnumber + "P";
                break;
            case 17:
                Visitnumber = Visitnumber + "Q";
                break;
            case 18:
                Visitnumber = Visitnumber + "R";
                break;
            case 19:
                Visitnumber = Visitnumber + "S";
                break;
            case 20:
                Visitnumber = Visitnumber + "T";
                break;
            case 21:
                Visitnumber = Visitnumber + "U";
                break;
            case 22:
                Visitnumber = Visitnumber + "V";
                break;
            case 23:
                Visitnumber = Visitnumber + "W";
                break;
            case 24:
                Visitnumber = Visitnumber + "X";
                break;
            case 25:
                Visitnumber = Visitnumber + "Y";
                break;
            case 26:
                Visitnumber = Visitnumber + "Z";
                break;
            default:
                Visitnumber = Visitnumber;
                break;

        }

        return Visitnumber;
    }
    }
    catch (e) {
        return false;
    }
}
//}
function AddChildSample(sampleCode, sampleName, containerID, containerName, temperature, volume, shippingConditionID, volumeUnitID) {
    try {
        var row = '<tr style="height: 17px;">';
        var ddlStatus = "", ddlReason = "", ddlOutsource = "", ddlReceiveLoc = "";
        var statusOption = "", reasonOption = "", outSourceOption = "", receiveLocOption = "";

        var rowCount = $("#tblChildCollectSample tr").length;

        row += '<td align="left">' + sampleName + '<input id="tblChildCollectSample' + rowCount + 'hdnSampleCode" type="hidden" value="' + sampleCode + '" /></td>';
        row += '<td align="left">' + containerName + '<input id="tblChildCollectSample' + rowCount + 'hdnContainerID" type="hidden" value="' + containerID + '" /></td>';

        //New Attribute Code
        var shippingConditionOption = "";
        var volumeUnitOption = "";
        var txtTemperature = "";
        var txtVolume = "";
        var ddlvolumeUnits = "";

        var lstvolumeUnits = JSON.parse($('input[id$="hdnvolumeUnits"]').val());

        $.each(lstvolumeUnits, function(i, obj) {
            if (obj.Value == volumeUnitID) {
                volumeUnitOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                volumeUnitOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });

        var lstShippingCondition = JSON.parse($('input[id$="hdnShippingCondition"]').val());

        $.each(lstShippingCondition, function(i, obj) {
            if (obj.Value == shippingConditionID) {
                shippingConditionOption += "<option value='" + obj.Value + "' selected>" + obj.Name + "</option>";
            }
            else {
                shippingConditionOption += "<option value='" + obj.Value + "'>" + obj.Name + "</option>";
            }
        });


        txtVolume = '<input id="tblChildCollectSample' + rowCount + 'txtVolume" type="text" maxlength="25" title="Enter Sample volume" size="10" style="width:40px;" value="' + volume + '" class="Txtboxsmall" />';
        ddlvolumeUnits = '<span class="richcombobox" style="width: 50px;"><select id="tblChildCollectSample' + rowCount + 'ddlvolumeUnits" class="ddl" style="width: 50px;" title="Select Volume Units">' + volumeUnitOption + '</select></span>';
        ddlShippingCondition = '<span class="richcombobox" style="width: 120px;"><select id="tblChildCollectSample' + rowCount + 'ddlShippingCondition" class="ddl" style="width: 120px;" title="Select Location">' + shippingConditionOption + '</select></span>';

        row += '<td align="center">' + txtVolume + '</td>';
        row += '<td align="center">' + ddlvolumeUnits + '</td>';
        row += '<td align="center">' + ddlShippingCondition + '</td>';

        row += "</tr>";
        //$('[id$="pnlChildSamples"]').show();
        $("#tblChildCollectSample").append(row);
    }
    catch (e) {
        throw e;
    }
}
function ShowPopUp(pid, OrgID, SampleCode, ToReplaceBarcodeID) {
    $.ajax({
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: "../WebService.asmx/GetExtraSampleList",
        data: JSON.stringify({ patienid: pid, SampleCode: SampleCode, OrgID: OrgID }),
        dataType: "json",
        success: function(data, value) {
        var GetData1 = data.d;
        GetExtraSampleList(GetData1, ToReplaceBarcodeID)
        },
        error: function(result) {
            alert("Error");
        }
    });
}
function GetExtraSampleList(result, ToReplaceBarcodeID) {

    while (count = document.getElementById('tblSampleAttributes').rows.length) {
        for (var j = 0; j < document.getElementById('tblSampleAttributes').rows.length; j++) {
            document.getElementById('tblSampleAttributes').deleteRow(j);
        }
    }

    if (result.length > 0) {
        var Headrow = document.getElementById('tblSampleAttributes').insertRow(0);
        Headrow.id = "HeadID";
        Headrow.style.fontWeight = "bold";
        Headrow.className = "dataheader1"
        var cell1 = Headrow.insertCell(0);
        var cell2 = Headrow.insertCell(1);
        var cell3 = Headrow.insertCell(2);
        var cell4 = Headrow.insertCell(3);
        var cell5 = Headrow.insertCell(4);
        var cell6 = Headrow.insertCell(5);

        cell1.innerHTML = " ";
        cell2.innerHTML = "Samples";
        cell3.innerHTML = "Additive-Container";
        cell4.innerHTML = "Barcode";
        cell5.innerHTML = "Collected Time";
        cell6.innerHTML = "Action";

        for (var n = 0; n < result.length; n++) {

            var TableInvValue = '';
            var row = document.getElementById('tblSampleAttributes').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var rowCount = n + 1;
            var date_sdate = result[n].CollectedDateTime;
            var ds = new Date(parseInt(/\/Date\((\d+).*/.exec(date_sdate)[1]))
            var sd = ds.format("dd/MM/yyyy hh:mm:ss tt");
            
            var NewBarcodeID = "tblSampleAttributes" + rowCount + "txtExtraBarcode";
            
            var lblSamples = '<input   id="tblSampleAttributes' + rowCount + 'txtExtraSample" type="text" maxlength="25"  size="10" style="width:120px;"  class="Txtboxsmall"  value="' + result[n].SampleDesc + '" />';
            var lblContainer = '<input   id="tblSampleAttributes' + rowCount + 'txtExtraContainer" type="text" maxlength="25"  size="10" style="width:120px;"  class="Txtboxsmall"  value="' + result[n].Testname + '" />';
            var txtBarcode = '<input   id="tblSampleAttributes' + rowCount + 'txtExtraBarcode" type="text" maxlength="25"  size="10" style="width:120px;"  class="Txtboxsmall"  value="' + result[n].BarcodeNumber + '" />';
            var txtCollectedtime = '<input   id="tblCollectSample' + rowCount + 'txttxtExtraCollectedtime" type="text" maxlength="25"  size="10" style="width:120px;"  class="Txtboxsmall"  value="' + sd + '" />';
            var btnAdd = '<input id="tblSampleAttributes' + rowCount + 'btnAddBarcode" value="Add" type="button" style="background-color:Transparent;color: Blue;border-style:none;text-decoration:underline;cursor:pointer;font-size:11px;" onclick="TableBarcode(' + result[n].BarcodeNumber + "," + ToReplaceBarcodeID + ');" title="Click here to Add Barcode details"/>';


            cell1.innerHTML = '<input type="Radio" name="rdsequence" runat="server"/>';
            cell2.innerHTML = lblSamples;
            cell3.innerHTML = lblContainer;
            cell4.innerHTML = txtBarcode;
            cell5.innerHTML = txtCollectedtime;
            cell6.innerHTML = btnAdd
            
        }
        $find('popupPO').show();
    }

}


function TableBarcode(NewBarcodeID, ExisitingBarcodeID)
{
    try {
        var ExistingBarcodeId = ExisitingBarcodeID.id;
        document.getElementById(ExistingBarcodeId).value = NewBarcodeID;
    }

    catch (e) {
        throw e;
    }
}

function ValidateOnlyNumeric(e) {
    var key = window.event ? e.keyCode : e.which;
    var text = String.fromCharCode(event.keyCode);
    var unicodeWord = RegExOnlyNumeric();
    if (unicodeWord.test(text)) {
        return true;
    }
    else {
        return false;
    }
    return true;

}

function validatePercentageKeyup(id) {
    var txtValue = document.getElementById(id).value;
    var BarcountAlert = "Barcode count should not be more than 10 and less than 1";
    var BarcountEmptyAlert = "Barcode count must have value"
    if (parseFloat(txtValue) > 10 || parseFloat(txtValue) < 1) {

        ValidationWindow(BarcountAlert, "Alert");
        //alert(txtMessage.innerHTML + ' should not be greater than 100');
        document.getElementById(id).value = "1";
        document.getElementById(id).focus();
        return false;
    }
    else if (txtValue == "") {
    ValidationWindow(BarcountEmptyAlert, "Alert");
    //alert(txtMessage.innerHTML + ' should not be greater than 100');
    document.getElementById(id).value = "1";
    document.getElementById(id).focus();
    return false;
    }
    else {
        return true;
    }
}
function GetInstructions(vid, OrgID) {
    var Trinstruction = "";
    var tablehead = "";
    var tableEnd = "";
    var FeeID = 0;
    var FeeType = "";
    tablehead = "<table id='tblTestInstruction' class='searchPanel' cellpadding='3'><tr class='Duecolor h-17'><td class='w-20p'><span>Type</span></td><td class='w-20p'><span>Investigation Name</span></td><td><span>Description</span></td></tr>";
   
if (vid != 0 || OrgID != 0) {
    $.ajax({
        type: "POST",
        url: "../WebService.asmx/GetInvestigationInstruction",
        data: "{ 'PatientVisitID': " + vid + ",'OrgID':" + OrgID + ",'FeeID':" + FeeID + ",'FeeType':'" + FeeType + "' }",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            Result = JSON.parse(data.d);
            if (Result.length > 0) {
                for (i = 0; i < Result.length; i++) {
                    tablehead += "<tr><td>" + Result[i].Performertype + "</td><td>" + Result[i].InvestigationName + "</td><td>" + Result[i].InvestigationComment + "</td></tr>";
                   
                }


            }
            
        }
    });
    tablehead += "</table>";


}
$('#ctlCollectSample_ShowInstruction').append(tablehead);
document.getElementById('ctlCollectSample_ShowInstruction').style.display = "block";
}