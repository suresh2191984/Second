var lstHistoryMaster = [];
//var dict = [];

$(document).ready(function() {
    //alert("Clinical History.js load ");
    //$("#btn_Update").hide();

    Reset();
    var sitms = [];
    sitms.push(getAllHistoryMaterItems());

    $.when.apply(this, sitms).done(function() { });
});

function getAllHistoryMaterItems() {
    //debugger;
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

            if (lstHistoryMaster.length > 0) {

                fun_bindHistoryMater(lstHistoryMaster);
            }
        },
        failure: function(msg) {
            var userMsg = 'Collect Clinical History Master Items';
            ValidationWindow(userMsg, errorMsg);
            return false;

        }
    });
    return false;
}

function fun_bindHistoryMater(lst) {
    //alert('bind');
    if (lst == null)
        return false;
        
    //debugger;
    BND = [];
    if (lst) {
        var sno = 0;
        $.each(lst, function() {
            var historyName = this.HistoryName;
            var historyCode = this.HistoryCode;
            var controlType = this.ControlType;
            var isActive = this.IsActive == 'Y' ? true : false;
            sno = sno + 1;

            var isActiveSte = "Active";
            var activateDeactivateImgPath = "..\\Images\\Active.png";
            if (!isActive) {
                activateDeactivateImgPath = "..\\Images\\Inactive.png";
                isActiveSte = "In-active";
            }
            var acnActivate = '<img src=\'' + activateDeactivateImgPath + '\' alt="Is Active" id="IsActive" title=\'' + isActiveSte + '\'  width="15" height="15" border="0" onClick=" HistoryActivate(' + this.HistoryID + ')" historyId=" ' + this.HistoryID + '"/>&nbsp;|&nbsp;';

           // debugger;
//            var action = acnActivate + '<input type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer pull-left" onclick="EditHistoryMaster(' + this.HistoryID + ')" historyId=" ' + this.HistoryID + '"/>' +
//            '<input type="button" class="ui-icon ui-icon-trash b-none pointerm pull-left marginL5 pointer pull-left" onclick="DeleteHistoryMaster(' + this.HistoryID + ')" historyId=" ' + this.HistoryID + '"/>';

            var action = acnActivate + '<input type="button" class="ui-icon with-out-bkg ui-icon-pencil b-none pointer " onclick="EditHistoryMaster(' + this.HistoryID + ')" historyId=" ' + this.HistoryID + '"/>&nbsp;|&nbsp;' +
            '<input type="button" class="ui-icon ui-icon-trash b-none pointerm  marginL5 pointer " onclick="DeleteHistoryMaster(' + this.HistoryID + ')" historyId=" ' + this.HistoryID + '"/>';

            BND.push([
                sno = sno,
                historyName = historyName,
                historyCode = historyCode,
                controlType = controlType,
                action = action
              ]);
        });
    }


    $("#tblHistoryMaster").dataTable().fnDestroy();
    $('#tblHistoryMaster').dataTable({
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


    var today = new Date();
    //alert(nowdd);
    var newItem = [];

    newItem.push({
        HistoryName: $("#txt_HistoryName").val(),
        HistoryCode: $("#txt_HistoryCode").val(),
        ControlType: GetControlType($("#ddlControlType").val()),
        OperationType: "Add",
        IsActive: "Y",
        CreatedAt: today.toLocaleString(),
        OrgID: orgID
    });
    var _jsonStringData = JSON.stringify(newItem);

    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMaster";
    var dataStr = "{ JsonStringData: '" + _jsonStringData + "'}";

    $.ajax({
        type: "POST",
        url: urlPath,
        data: dataStr,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        async: false,
        success: function(data) {
           // debugger;
            var reslt = data.d;
            var alertMsg = "";
            if (reslt != false) {
                //alert("Clinical History Info Saved Sucessfully..!");

                //lstHistoryMaster.push(newItem[0]);
                getAllHistoryMaterItems();
            }
            else {
                alert("Unable to Save Clinical History Info..");
            }

            //debugger;
            Reset();

            //$('#gv_Tbl').DataTable().fnDestroy();
            fun_bindHistoryMater(lstHistoryMaster);

        },
        failure: function(msg) {
            //debugger;
            ShowErrorMessage(msg);
        }

    });
    return false;
}

function HistoryActivate(historyId) {

   // debugger;
    if (historyId == "")
        return false;

    var editItem = GetHistoryItem(historyId);
    if (editItem == null)
        return false;

    var activateStatus = editItem.IsActive == "Y" ? "N" : "Y";

    var today = new Date();

    var editItems = [];
    editItems.push({
        HistoryID: editItem.HistoryID,
        HistoryName: editItem.HistoryName,
        HistoryCode: editItem.HistoryCode,
        ControlType: editItem.ControlType,
        ModifiedAt: today.toLocaleString(),
        IsActive: activateStatus,
        OperationType: "Modify"
    });

    var _jsonStringData = JSON.stringify(editItems);

    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMaster";
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
                //alert("Clinical History Info Update Sucessfully..!");
                //Enumerable.From(lstHistoryMaster).Where("($.HistoryID)== " + historyId).IsActive = "\'"+activateStatus+"\'";
                var idx = -1;
                for (var i = 0; i < lstHistoryMaster.length; i++) {
                    if (lstHistoryMaster[i].HistoryID == historyId) {                       
                        idx = i;
                        break;
                    }
                }
                if (idx != -1)
                    lstHistoryMaster[idx].IsActive = activateStatus;
                //RemoveItem(historyId);
                //lstHistoryMaster.push(editItem);
                //editItem.
                //$('#gv_Tbl').DataTable().fnDestroy();
                fun_bindHistoryMater(lstHistoryMaster);

               // debugger;
                Reset();

            }
            else {
                alert("Unable to Update Clinical History Info..");
            }

        },
        failure: function(msg) {
           // debugger;
            ShowErrorMessage(msg);
        }

    });
    //}
}

function EditHistoryMaster(historyId) {
    //debugger;
    var obj = GetHistoryItem(historyId);
    if (obj != null) {
        $('#hdn_EditHistoryId').val(obj.HistoryID);
        $('#txt_HistoryName').val(obj.HistoryName);
        $('#txt_HistoryCode').val(obj.HistoryCode);

        var idx = GetControlTypeIdx(obj.ControlType);

        document.getElementsByName("ddlControlType")[0].options[idx].selected = true;
        //$('#ddlControlType').prop('SelectedIndex', idx);

        $('#btn_Save').hide();
        $('#btn_Update').show();
        $('#btn_Update').attr('onclick', 'return UpdateHistoryMaster(' + obj.HistoryID + ');');
    }
}

function UpdateHistoryMaster(historyId) {
    //debugger;
    if (historyId == "")
        return false;

    if (!Validation())
        return false;

    var editItem = GetHistoryItem(historyId);
    if (editItem == null)
        return false;

    var today = new Date();

    var editItems = [];
    editItems.push({
        HistoryID: $("#hdn_EditHistoryId").val(),
        HistoryName: $("#txt_HistoryName").val(),
        HistoryCode: $("#txt_HistoryCode").val(),
        ControlType: GetControlType($("#ddlControlType").val()),
        ModifiedAt: today.toLocaleString(),
        OperationType: "Modify",
        IsActive:editItem.IsActive
    });

    var _jsonStringData = JSON.stringify(editItems);

    //debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMaster";
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
                //alert("Clinical History Info Update Sucessfully..!");

                //                RemoveItem(historyId);
                //                lstHistoryMaster.push(editItem);

                var idx = -1;
                for (var i = 0; i < lstHistoryMaster.length; i++) {
                    if (lstHistoryMaster[i].HistoryID == historyId) {
                        idx = i;
                        break;
                    }
                }
                if (idx != -1) {
                    lstHistoryMaster[idx].HistoryID = editItems[0].HistoryID;
                    lstHistoryMaster[idx].HistoryName=editItems[0].HistoryName;
                    lstHistoryMaster[idx].HistoryCode=editItems[0].HistoryCode;
                    lstHistoryMaster[idx].ControlType=editItems[0].ControlType;
                    lstHistoryMaster[idx].IsActive=editItems[0].IsActive;
                }
                //$('#gv_Tbl').DataTable().fnDestroy();
                fun_bindHistoryMater(lstHistoryMaster);

                //debugger;
                Reset();

            }
            else {
                alert("Unable to Update Clinical History Info..");
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


function DeleteHistoryMaster(historyId) {
   // debugger;
    if (historyId == "")
        return;
    //Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "' && ($.HistoryCode).toLowerCase()== '" + historyCode + "'")
    //var deleteItem = Enumerable.From(lstHistoryMaster).Where("($.HistoryID)=='" + historyId+"'").ToArray()[0];
    var rmItem = GetHistoryItem(historyId);
    if (rmItem == null)
        return;

    //var i = deleteItem.HistoryID;

    var okMsg = "Ok";
    var cancelMsg = "Cancel";
    var infoMsg = "Information";
    var userMsg = "Are You sure do You want to Delete History Item?";
    var re = ConfirmWindow(userMsg, infoMsg, okMsg, cancelMsg);
    if (re == false)
        return;

    var deleteItem = [];
    deleteItem.push({
        HistoryID: rmItem.HistoryID,
        OperationType: "Delete",
        OrgID: orgID
    });
    var _jsonStringData = JSON.stringify(deleteItem);


   // debugger;
    var urlPath = "../WebService.asmx/SaveClinicalHistoryMaster";
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
                //alert("Clinical History Info Deleted Sucessfully..!");                        
                RemoveItem(historyId);
            }
            else {
                alert("Unable to Delete Clinical History Info..");
            }

           // debugger;
            Reset();


            fun_bindHistoryMater(lstHistoryMaster);

        },
        failure: function(msg) {
           // debugger;
            ShowErrorMessage(msg);
        }

    });
    //}

}

function RemoveItem(historyId) {
    for (var i = 0; i < lstHistoryMaster.length; i++) {
        if (lstHistoryMaster[i].HistoryID == historyId) {
            {
                lstHistoryMaster.splice(i, 1);
                break;
            }
        }
    }
}

function GetHistoryItem(historyId) {
    //debugger;
    var itemLst = Enumerable.From(lstHistoryMaster).Where("($.HistoryID)==" + historyId).ToArray();
    if (itemLst.length > 0)
        return itemLst[0];

    return null;
}

function GetControlType(optionId) {
    var ctrlType = "";
    switch (optionId) {
        case '1':
            ctrlType = "TXT"
            break;
        case '2':
            ctrlType = "CBX"
            break;
        case '3':
            ctrlType = "DATE"
            break;

        default:
            ctrlType = "TXT"
            break;
    }
    return ctrlType;
}

function GetControlTypeIdx(controlTypeStr) {
    var idx = "";
    switch (controlTypeStr) {
        case "TXT":
            idx = "1";
            break;
        case "CBX":
            idx = "2";
            break;
        case "DATE":
            idx = "3";
            break;

        default:
            idx = "0";
            break;
    }
    return idx;
}


function Validation() {

    if ($("#txt_HistoryName").val() == '') {
        var userMsg = "Please Enter History Name";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if ($("#txt_HistoryCode").val() == '') {
        var userMsg = "Please Enter History Code";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }
    if ($("#ddlControlType").val() == '') {
        var userMsg = "Please Select Control Type";
        var errorMsg = "Validation";
        ValidationWindow(userMsg, errorMsg);
        return false;
    }

    
    var historyCode = $("#txt_HistoryCode").val().toLowerCase();

    var fltItms = Enumerable.From(lstHistoryMaster).Where("($.HistoryCode).toLowerCase()== '" + historyCode + "'").ToArray();
    var isEditMode = $('#hdn_EditHistoryId').val() != '' ? true : false;
    if (lstHistoryMaster != null && lstHistoryMaster.length > 0) {
        if (!isEditMode) {

            //        if ((Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "' && ($.HistoryCode).toLowerCase()== '" + historyCode + "'").ToArray()).length > 0) {
            if (fltItms.length > 0) {
                var userMsg = "HistoryCode should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }
        else {
            var editId = $('#hdn_EditHistoryId').val();
            var editItem = GetHistoryItem(editId);

            //        if ((editItem.HistoryName != historyName || editItem.HistoryCode != historyCode) && (Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "' && ($.HistoryCode).toLowerCase()== '" + historyCode + "'").ToArray()).length > 0) {
            if ((editItem.HistoryCode.toLowerCase() != historyCode) && (fltItms.length > 0)) {
                var userMsg = "HistoryCode should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

        }
    }
    
    var historyName = $("#txt_HistoryName").val().toLowerCase();
    
    var fltItms = Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "'").ToArray();
    
    if (lstHistoryMaster != null && lstHistoryMaster.length > 0) {
        if (!isEditMode) {

            //        if ((Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "' && ($.HistoryCode).toLowerCase()== '" + historyCode + "'").ToArray()).length > 0) {
            if (fltItms.length > 0) {
                var userMsg = "HistoryName should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }
        else {
            var editId = $('#hdn_EditHistoryId').val();
            var editItem = GetHistoryItem(editId);

            //        if ((editItem.HistoryName != historyName || editItem.HistoryCode != historyCode) && (Enumerable.From(lstHistoryMaster).Where("($.HistoryName).toLowerCase()== '" + historyName + "' && ($.HistoryCode).toLowerCase()== '" + historyCode + "'").ToArray()).length > 0) {
            if ((editItem.HistoryName.toLowerCase() != historyName) && (fltItms.length > 0)) {
                var userMsg = "HistoryName should be Unique..!"
                var errorMsg = "Validation";
                ValidationWindow(userMsg, errorMsg);
                return false;
            }

        }
    }
    return true;
}

function Reset() {
   // debugger;
    $("#txt_HistoryName").val('');
    $('#txt_HistoryCode').val('');
    $("#ddlControlType").prop('selectedIndex', 0);

    $("#btn_Update").hide();
    $("#btn_Save").show();
    $('#hdn_EditHistoryId').val('');
}