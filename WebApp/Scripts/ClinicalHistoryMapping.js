var lstHistoryMappings = [];
var lstHistoryMaster = [];
var orgID = 0;
//var dict = [];

$(document).ready(function() {
    //alert("Clinical HistoryMapping.js load ");
    //$("#btnUpdate").hide();
    //debugger;
    orgID = parseInt($("#hdnOrgId").val());

    var hitms = [];
    hitms.push(getAllHistoryItems());
    $.when.apply(this, hitms).done(function() { });

    Reset();
    var sitms = [];
    sitms.push(getAllHistoryMappingItems());

    $.when.apply(this, sitms).done(function() { });
});

function getAllHistoryItems() {
   // debugger;
    var errorMsg = "Error";
    //alert(orgID + '-' + locId)
    return $.ajax({
        async: false,
        type: "POST",
        url: "../WebService.asmx/GetAllHistoryMasterItems",
        contentType: "application/json; charset=utf-8",
        data: "{ 'Orgid' : " + orgID + "}",
        //data: "",
        dataType: "json",
        success: function(data) {
            //alert(data.d)
            //debugger;
            lstHistoryMaster = data.d;
        },
        failure: function(msg) {
            var userMsg = 'Collect Clinical History Items';
            ValidationWindow(userMsg, errorMsg);
            return false;

        }
    });
    return false;
}

function getAllHistoryMappingItems() {
    //debugger;
    var errorMsg = "Error";
    //alert(orgID + '-' + locId)
    return $.ajax({
        async: false,
        type: "POST",
        url: "../WebService.asmx/GetAllHistoryMappingItems",
        contentType: "application/json; charset=utf-8",
        data: "{ 'Orgid' : " + orgID + "}",
        //data: "",
        dataType: "json",
        success: function(data) {
            //alert(data.d)
            //debugger;
            lstHistoryMappings = data.d;

            if (lstHistoryMappings.length > 0) {

                fun_bindHistoryMapping(lstHistoryMappings);
            }
        },
        failure: function(msg) {
            var userMsg = 'Collect Clinical History Mapping Items';
            ValidationWindow(userMsg, errorMsg);
            return false;

        }
    });
    return false;
}

function fun_bindHistoryMapping(lst) {
    //alert('bind');
    //debugger;

    if (lst == null)
        return false;
    BND = [];
    if (lst) {
        var sno = 0;
        $.each(lst, function() {
            var testName = this.TestName;
            var testType = this.InvType;

            var oHistory = GetHistoryMaster(this.MedicalDetailID);
            var historyName = "";
            var historyCode = "";

            if (oHistory == null)
                return false;
            //if (oHistory != null) 
            {
                historyName = oHistory.HistoryName;
                historyCode = oHistory.HistoryCode;
            }
            var historySequence = this.HistorySequence;

            var isMandatory = this.IsMandatory == 'Y' ? "Yes" : "No";
            var isActive = this.IsActive == 'Y' ? true : false;
            sno = sno + 1;

            var isActiveSte = "Active";
            var activateDeactivateImgPath = "..\\Images\\Active.png";
            if (!isActive) {
                activateDeactivateImgPath = "..\\Images\\Inactive.png";
                isActiveSte = "In-active";
            }
            var acnActivate = '<img src=\'' + activateDeactivateImgPath + '\' alt="Is Active" id="IsActive" title=\'' + isActiveSte + '\'  width="15" height="15" border="0" onClick=" HistoryActivate(' + this.InvMedMappingID + ')" historyMapId=" ' + this.InvMedMappingID + '"/>&nbsp;|&nbsp;';


            var action = acnActivate+'<input type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer " onclick="EditHistoryMapping(' + this.InvMedMappingID + ')" id=" ' + this.MedicalDetailID + '"/>&nbsp;|&nbsp;' +
            '<input type="button" class="ui-icon ui-icon-trash b-none pointerm marginL5 pointer " onclick="DeleteHistoryMappingItem(' + this.InvMedMappingID + ')" id=" ' + this.MedicalDetailID + '"/>';

            BND.push([
                testName = testName,
                historyName = historyName,
                historyCode = historyCode,
                historySequence = historySequence,
                isMandatory = isMandatory,
                action = action
              ]);
        });
    }


    $("#tblHistoryMapping").dataTable().fnDestroy();
    $('#tblHistoryMapping').dataTable({
        "bDestroy": true,
        "bProcessing": false,
        "bPaginate": true,
        "bDeferRender": true,
        "bSortable": false,
        "bJQueryUI": false,
        "aaData": BND,
        'bSort': false,
        'bFilter': true,
        'sPaginationType': 'full_numbers',
        'bInfo': false
    });
}

function Save() {

    //debugger;
    if (!Validation())
        return false;


    var isMandatory = "N";
    if ($('#chkIsMandatory').is(":checked"))
        isMandatory = "Y";

    var newItem = [];
    newItem.push({
        InvID: $("#hdnInvID").val(),
        TestName: $("#hdnInvName").val(),
        MedicalDetailID: $("#hdnHistoryMasterId").val(),
        IsMandatory: isMandatory,
        InvType: $("#hdnInvType").val(),
        HistorySequence: $("#txt_historySequenceNo").val(),

        MedicalDetailType: "H",
        //MeanTime: 0.00,        
        IsInternal: "N",
        IsActive: "Y",
        OperationType: "Add",
        OrgId: $("#hdnOrgId").val()
    });
    var _jsonStringData = JSON.stringify(newItem);

    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMapping";
    var dataStr = "{ JsonStringData: '" + _jsonStringData + "'}";

    $.ajax({
        type: "POST",
        url: urlPath,
        data: dataStr,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            //debugger;
            var reslt = data.d;
            var alertMsg = "";
            if (reslt != false) {
                //alert("Clinical History Mapping Info Saved Sucessfully..!");

                getAllHistoryMappingItems();
            }
            else {
                alert("Unable to Save Clinical History Mapping Info..");
            }

           // debugger;
            Reset();

            //$('#gv_Tbl').DataTable().fnDestroy();
            //fun_bindHistoryMapping(lstHistoryMappings);
            
        },
        failure: function(msg) {
           // debugger;
            ShowErrorMessage(msg);
        }

    });
    return false;
}

function HistoryActivate(historyMapId) {
    //debugger;

    if (historyMapId == "")
        return false;

    var editItem = GetHistoryMapItem(historyMapId);
    if (editItem == null)
        return false;

    var activateStatus = editItem.IsActive == "Y" ? "N" : "Y";

    var today = new Date();

    var editItems = [];
    editItems.push({
        InvMedMappingID: editItem.InvMedMappingID,
        InvID: editItem.InvID,
        TestName: editItem.TestName,
        MedicalDetailID: editItem.MedicalDetailID,
        IsMandatory: editItem.IsMandatory,
        InvType: editItem.InvType,
        HistorySequence: editItem.HistorySequence,

        MedicalDetailType: editItem.MedicalDetailType,
        //MeanTime: editItem.MeanTime,
        IsInternal: editItem.IsInternal,
        IsActive: activateStatus,
        OrgId: editItem.OrgId,
        OperationType: "Modify"
    });

    var _jsonStringData = JSON.stringify(editItems);

    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMapping";
    var dataStr = "{ JsonStringData: '" + _jsonStringData + "'}";

    $.ajax({
        type: "POST",
        url: urlPath,
        data: dataStr,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            //debugger;
            var reslt = data.d;
            var alertMsg = "";
            if (reslt != false) {
                //alert("Clinical History Mapping Info Update Sucessfully..!");

                //                RemoveItem(historyMapId);
                //                lstHistoryMappings.push(editItem);

                var idx = -1;
                for (var i = 0; i < lstHistoryMappings.length; i++) {
                    if (lstHistoryMappings[i].InvMedMappingID == historyMapId) {
                        idx = i;
                        break;
                    }
                }


                if (idx != -1) {
                    lstHistoryMappings[idx].IsActive = activateStatus;                  
                }

                //$('#gv_Tbl').DataTable().fnDestroy();
                fun_bindHistoryMapping(lstHistoryMappings);

                //debugger;
                Reset();

            }
            else {
                alert("Unable to Update Clinical History Mapping Info..");
            }

        },
        failure: function(msg) {
            //debugger;
            ShowErrorMessage(msg);
        }

    });
    //}

    return false;    
}

function EditHistoryMapping(historyMapId) {
    //debugger;
    var obj = GetHistoryMapItem(historyMapId);
    if (obj != null) {
        if (obj.IsMandatory == "Y")
            document.getElementById('chkIsMandatory').checked = true;
        else
            document.getElementById('chkIsMandatory').checked = false;


        $('#hdn_EditHistoryMapId').val(obj.InvMedMappingID);

        $("#txt_TestName").val(obj.TestName);
        $("#hdnInvName").val(obj.TestName);
        $("#hdnInvID").val(obj.InvID);
        $("#hdnInvType").val(obj.InvType);

        var oHistoryMaster = GetHistoryMaster(obj.MedicalDetailID);
        if (oHistoryMaster != null) {
            $("#txt_HistoryNameOrCode").val(oHistoryMaster.HistoryName);
            $("#hdnHistoryMasterId").val(oHistoryMaster.HistoryID);
        }

        $("#txt_historySequenceNo").val(obj.HistorySequence);

        $('#btnSave').hide();
        $('#btnUpdate').show();
        $('#btnUpdate').attr('onclick', 'return UpdateHistoryMapMaster(' + obj.InvMedMappingID + ');');

        $("#txt_TestName").prop('disabled', true);
        $("#txt_HistoryNameOrCode").prop('disabled', true);
    }
}

function UpdateHistoryMapMaster(historyMapId) {
    //debugger;
    if (historyMapId == "")
        return false;

    if (!Validation())
        return false;

    var editItem = GetHistoryMapItem(historyMapId);
    if (editItem == null)
        return false;

    var isMandatory = "N";
    if ($('#chkIsMandatory').is(":checked"))
        isMandatory = "Y";

    var editItems = [];
    editItems.push({
        InvMedMappingID: $("#hdn_EditHistoryMapId").val(),        
        InvID: $("#hdnInvID").val(),
        TestName: $("#hdnInvName").val(),
        MedicalDetailID: $("#hdnHistoryMasterId").val(),
        IsMandatory: isMandatory,
        InvType: $("#hdnInvType").val(),
        HistorySequence: $("#txt_historySequenceNo").val(),

        MedicalDetailType: editItem.MedicalDetailType,
        //MeanTime: editItem.MeanTime,
        IsInternal: editItem.IsInternal,
        IsActive: editItem.IsActive,        
        OrgId: editItem.OrgId,
        OperationType: "Modify"
    });

    var _jsonStringData = JSON.stringify(editItems);

    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMapping";
    var dataStr = "{ JsonStringData: '" + _jsonStringData + "'}";

    $.ajax({
        type: "POST",
        url: urlPath,
        data: dataStr,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            //debugger;
            var reslt = data.d;
            var alertMsg = "";
            if (reslt != false) {
                //alert("Clinical History Mapping Info Update Sucessfully..!");

                //                RemoveItem(historyMapId);
                //                lstHistoryMappings.push(editItem);

                var idx = -1;
                for (var i = 0; i < lstHistoryMappings.length; i++) {
                    if (lstHistoryMappings[i].InvMedMappingID == historyMapId) {
                        idx = i;
                        break;
                    }
                }               
             
        
                if (idx != -1) {
                    lstHistoryMappings[idx].IsMandatory=isMandatory;
                    lstHistoryMappings[idx].HistorySequence=editItems[0].HistorySequence;
                    lstHistoryMappings[idx].OperationType=editItems[0].OperationType;
                }

                //$('#gv_Tbl').DataTable().fnDestroy();
                fun_bindHistoryMapping(lstHistoryMappings);

                //debugger;
                Reset();

            }
            else {
                alert("Unable to Update Clinical History Mapping Info..");
            }

        },
        failure: function(msg) {
            //debugger;
            ShowErrorMessage(msg);
        }

    });
    //}

    return false;
}

function DeleteHistoryMappingItem(historyMapId) {
    //debugger;
    if (historyMapId == "")
        return false;
    //Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "' && ($.HistoryCode).toLowerCase()== '" + historyCode + "'")
    //var deleteItem = Enumerable.From(lstHistoryMaster).Where("($.HistoryID)=='" + historyId+"'").ToArray()[0];
    var rmItem = GetHistoryMapItem(historyMapId);
    if (rmItem == null)
        return false;

    //var i = deleteItem.HistoryID;

    var okMsg = "Ok";
    var cancelMsg = "Cancel";
    var infoMsg = "Information";
    var userMsg = "Are You sure do You want to Delete History Mapping Item?";
    var re = ConfirmWindow(userMsg, infoMsg, okMsg, cancelMsg);
    if (re == false)
        return false;

    var deleteItem = [];
    deleteItem.push({
        InvMedMappingID: rmItem.InvMedMappingID,
        OperationType: "Delete"
    });
    var _jsonStringData = JSON.stringify(deleteItem);


    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMapping";
    var dataStr = "{ JsonStringData: '" + _jsonStringData + "'}";

    $.ajax({
        type: "POST",
        url: urlPath,
        data: dataStr,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
            //debugger;
            var reslt = data.d;
            var alertMsg = "";
            if (reslt != false) {
                //alert("Clinical History Mapping Info Deleted Sucessfully..!");
                RemoveItem(historyMapId);
                fun_bindHistoryMapping(lstHistoryMappings);
            }
            else {
                alert("Unable to Delete Clinical History Mapping Info..");
            }

           // debugger;
            Reset();

        },
        failure: function(msg) {
            //debugger;
            ShowErrorMessage(msg);
        }

    });
   
}

function RemoveItem(invMedMappingID) {
    for (var i = 0; i < lstHistoryMappings.length; i++) {
        if (lstHistoryMappings[i].InvMedMappingID == invMedMappingID) {
            {
                lstHistoryMappings.splice(i, 1);
                break;
            }
        }
    }
}

function Validation() {
    //debugger;
    if ($("#txt_TestName").val() == '') {
        var userMsg = "Please Enter Test Name";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else {
        var expectInvName = $("#hdnInvName").val();
        var actualInvName = $("#txt_TestName").val();

        if (expectInvName != actualInvName) {
            var userMsg = "Invalid Test Name..!";
            var errorMsg = "Validation";
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }

    if ($("#txt_HistoryNameOrCode").val() == '') {
        var userMsg = "Please Enter Clinical History Name/Code";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else {
        var accHistoryName = $("#txt_HistoryNameOrCode").val();
        var historyId = $("#hdnHistoryMasterId").val();

        var oHistoryMaster = null;
        if (historyId.length > 0)
            oHistoryMaster = GetHistoryMaster(historyId);

        if (oHistoryMaster == null || (oHistoryMaster.HistoryName != accHistoryName && oHistoryMaster.HistoryCode != accHistoryName)) {
            var invId = $("#hdnInvType").val();
            var userMsg = "Invalid Clinical History Name/Code..!";
            var errorMsg = "Validation";
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
    }

    var val = $("#txt_historySequenceNo").val();
    if (val == '') {
        var userMsg = "Please enter History Sequence No";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else if (isNaN(val)) {
        var userMsg = "Please Enter Numeric Value..";
        var errorMsg = "History Sequence No. Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    else if (val == '0') {
        var userMsg = "History Sequence No. start with '1'..";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }

    var historyId = $("#hdnHistoryMasterId").val();
    var oHistoryMaster = GetHistoryMaster(historyId);
    if (oHistoryMaster == null) {
        var userMsg = "Invalid History Info";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    var historyCode = oHistoryMaster.HistoryCode;

    var invId = $("#hdnInvID").val();
    var historySequence = $("#txt_historySequenceNo").val();

    //    var fltItms = Enumerable.From(lstHistoryMappings).Where("($.InvID)== " + invId + " && ($.MedicalDetailID)== " + historyId + " && ($.HistorySequence)== " + historySequence).ToArray();
    var fltItms = Enumerable.From(lstHistoryMappings).Where("($.InvID)== " + invId + " && ($.HistorySequence)== " + historySequence).ToArray();
    var fltItms_dup_hisId = Enumerable.From(lstHistoryMappings).Where("($.InvID)== " + invId + " && ($.MedicalDetailID)== " + historyId).ToArray();

    var isEditMode = $('#hdn_EditHistoryMapId').val() != '' ? true : false;
    if (lstHistoryMappings != null && lstHistoryMappings.length > 0) {
        if (!isEditMode) {

            if (fltItms_dup_hisId.length > 0) {
                //if ((Enumerable.From(lstHistoryMappings).Where("($.InvID)== " + invId + " && ($.MedicalDetailID)== " + historyCode + " && ($.HistorySequence)== " + historySequence).ToArray()).length > 0) {
                var userMsg = "History Id should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
            //var flt = Enumerable.From(lstHistoryMappings).Where("($.InvID)== " + invId + " && ($.MedicalDetailID)== " + historyId + " && ($.HistorySequence)== " + historySequence).ToArray();
            if (fltItms.length > 0) {
                //if ((Enumerable.From(lstHistoryMappings).Where("($.InvID)== " + invId + " && ($.MedicalDetailID)== " + historyCode + " && ($.HistorySequence)== " + historySequence).ToArray()).length > 0) {
                var userMsg = "History Sequence No should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }
        else {
            var editId = $('#hdn_EditHistoryMapId').val();
            var editItem = GetHistoryMapItem(editId);

            if ((editItem.HistorySequence != historySequence) && (fltItms.length > 0)) {
                var userMsg = "History Sequence No should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }
    }
    return true;
}

function Reset() {
    //debugger;
    $("#txt_TestName").val('');
    $("#hdnInvID").val('');
    $("#hdnInvName").val('');
    $("#hdnInvType").val('');

    $("#txt_HistoryNameOrCode").val('');
    $("#hdnHistoryMasterId").val('');

    $("#txt_historySequenceNo").val('');

    $('#hdn_EditHistoryMapId').val('');

    $('#hdn_EditHistoryMapId').val('');
    $('#chkIsMandatory').attr('checked', false);

    $("#btnUpdate").hide();
    $('#btnSave').show();

    $("#txt_TestName").prop('disabled', false);
    $("#txt_HistoryNameOrCode").prop('disabled', false);

}

function GetHistoryMaster(historyId) {
    //debugger;
    var itemLst = Enumerable.From(lstHistoryMaster).Where("($.HistoryID)==" + historyId).ToArray();

    if (itemLst.length > 0)
        return itemLst[0];

    return null;
}

function GetHistoryMapItem(historyMapId) {
   // debugger;
    var itemLst = Enumerable.From(lstHistoryMappings).Where("($.InvMedMappingID)==" + historyMapId).ToArray();

    if (itemLst.length > 0)
        return itemLst[0];

    return null;
}


function DisableEnterKey(e) {
   // debugger;
    var key;
    if (window.event)
        key = window.event.keyCode; //IE
    else
        key = e.which; //firefox

    return (key != 13);

}
