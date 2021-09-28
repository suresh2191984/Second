function CallShowPopUp(id) {
    document.getElementById('btnDummy1').click();
    var CtrlID = id;
    var obj = document.getElementById(CtrlID);
}

function CoumbndTblist() {
    // alert(resouce);
    //alert(sClientLabels.btnEdit + ' - ' + sClientLabels.btnDelete);
    while (count = document.getElementById('tblComboundItems').rows.length) {

        for (var j = 0; j < document.getElementById('tblComboundItems').rows.length; j++) {
            document.getElementById('tblComboundItems').deleteRow(j);
        }
    }
    var Headrow = document.getElementById('tblComboundItems').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "dataheader1"

    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);



    cell1.innerHTML = sClientLabels.serialNumber;
    cell2.innerHTML = sClientLabels.Select;
    cell3.innerHTML = sClientLabels.ProductName;

    var x = document.getElementById('hdnProductList').value.split("^");
    var pCount = x.length;
    pCount = pCount - 1;

    var tGrandTotal = 0.00;
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');

            var row = document.getElementById('tblComboundItems').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var Hdn = '<input id="hdnlstCompound_' + y[6] + '" type="hidden" " value="' + y[6] + '" />';
            cell1.innerHTML = pCount;
            cell2.innerHTML = "<input type=checkbox onclick=CheckBoxCount() id=chk" + y[6] + " name='ProductList '/>" + Hdn;
            cell3.innerHTML = '<span id="lblproductname">' + y[1] + '</span>';
        }

        pCount = pCount - 1;
    }

}

function FnCheckValidation() {

    var userMsg
    var falg = 0;
    $('#tblComboundItems input[type=checkbox]:checked').each(function(i, n) {
        falg = 1;
    });
    if (falg == 0) 
    {
       
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_01") == null ? "select the products" : SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_01");
 ValidationWindow(userMsg, errorMsg);
            return false
       
    }

    if ($('[id$="txtCoumpoundDrugName"]').val() == "") {
        if ($('#ChkIsCoumponent').attr('checked')) 
        {
            
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_02") == null ? "provide the drugName" : SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_02");
 ValidationWindow(userMsg, errorMsg);
                return false
           
        }

    }
    if ($('[id$="ddFrequency"] option:last')[0].selected == true) {
        
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_03") == null ? "provide the frequency" : SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_03");
 ValidationWindow(userMsg, errorMsg);
            return false
      
    }

    if ($('#txtDose').val() == '') {
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_04") == null ? "provide the Dose" : SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_04");
 ValidationWindow(userMsg, errorMsg);
        return false
    }

    if ($('[id$="txtDuration"]').val() == "") {
        
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_05") == null ? "provide the Duration" : SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_05");
 ValidationWindow(userMsg, errorMsg);
            return false
     
    }

    if ($('[id$="txtInstruction"]').val() == "") {
        
var userMsg = SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_06") == null ? "provide the Instruction" : SListForAppMsg.Get("InventoryCommon_Scripts_CompoundDrugs_js_06");
 ValidationWindow(userMsg, errorMsg);
            return false
       
    }
    SaveTesting(); ClearItems();

    return true
}

function SaveTesting() {

    var $row;
    var $lstCoumpounnt;
    var lstCoumpounnts = [];
    var ProductID = '';
    var ProductName
    var lstItems = [];
    var DrugName;
    var Frequency;
    var Dose;
    var Duration;
    var DurationType;
    var Instruction;
    var ProductItems = '';
    var ChkID;
    var Flag = 0;
    var TempID = '';
    Frequency = $("#ddFrequency option:selected").val();
    Dose = $('#txtDose').val();
    Duration = $("#txtDuration").val();
    DurationType = $("#ddlDurationType option:selected").val();
    Instruction = $("#txtInstruction").val();
    var ComponentName = $("#txtCoumpoundDrugName").val();
    $('#tblComboundItems input[type=checkbox]:checked').each(function(i, n) {
        $row = $(this).closest("tr");
        var len = $row.length;
        var temp = '';
        var TempID = '';
        Flag = 1;
        temp = $row.find($('span[id^="lblproductname"]')).html();
        TempID = $row.find($('input[id^="hdnlstCompound"]')).val();
        ProductName = $row.find($('span[id^="lblproductname"]')).html();
        ChkID = $row.find($('input[id^="chk"]'))[0].id;
        if ($("#txtCoumpoundDrugName").val() == '') {
            ComponentName = $row.find($('span[id^="lblproductname"]')).html();
        }
        if (ProductItems != '' && ProductID != '') {
            ProductItems = ProductItems + "," + temp;
            ProductID = ProductID + "," + TempID;
        }
        else {
            ProductItems = temp;
            ProductID = TempID;
        }
        lstCoumpounnts.push({
            DrugName: ComponentName,
            ProductID: TempID,
            ProductName: ProductName,
            ChkID: ChkID
        });
    });
    if ($("#ChkIsCoumponent").is(':checked')) {
        lstItems.push({
            BrandName: ComponentName,
            DrugFrequency: Frequency,
            Duration: Duration,
            PrescriptionType: DurationType,
            Instruction: Instruction,
            Direction: ProductItems,
            ProductID: ProductID,
            ChkBoxID: ChkID,
            Dose: Dose
        });
    }
    else {
        $('#tblComboundItems input[type=checkbox]:checked').each(function(i, n) {
            $row = $(this).closest("tr");
            TempID = '';
            ProductName = '';
            ChkID = '';
            temp = $row.find($('span[id^="lblproductname"]')).html();
            TempID = $row.find($('input[id^="hdnlstCompound"]')).val();
            ProductName = $row.find($('span[id^="lblproductname"]')).html();
            ChkID = $row.find($('input[id^="chk"]'))[0].id;
            lstItems.push({
                BrandName: ProductName,
                DrugFrequency: Frequency,
                Duration: Duration,
                PrescriptionType: DurationType,
                Instruction: Instruction,
                Direction: ProductName,
                ProductID: TempID,
                ChkBoxID: ChkID,
                Dose: Dose
            });

        });
    }
    var btnvalue = $('#btnAddComboundItems').val();
    CreateCompoundItemsTable(lstCoumpounnts, btnvalue);
    CreateCompoundTable(lstItems)

}
function CreateCompoundItemsTable(lstCoumpounnts, type) {
    try {

        var DataTable = [];
        var Edit = SListForAppDisplay.Get("InventoryCommon_Scripts_CompoundDrugs_js_07") != null ? SListForAppDisplay.Get("InventoryCommon_Scripts_CompoundDrugs_js_07") : "Edit";
        var Delete = SListForAppDisplay.Get("InventoryCommon_Scripts_CompoundDrugs_js_08")!=null?SListForAppDisplay.Get("InventoryCommon_Scripts_CompoundDrugs_js_08"):"Delete";
        DataTable = lstCoumpounnts;
        if (type == "ADD") {
            $.each(DataTable, function(i, obj) {
                dtTR = $('<tr/>');
                var checkID = $('<td align="left"/>').html("<span id='ChkBoxID'>" + obj.ChkID + " </span>");
                var Direction = $('<td align="left"/>').html("<span id='DrugName'>" + obj.DrugName + " </span>");
                var tdPID = $('<td style="display:block;"/>').html("<span id='ProductID'>" + obj.ProductID + " </span>");
                var tdPName = $('<td align="left"/>').html("<span id='ProductName'>" + obj.ProductName + " </span>");
                var btnEdit = '<input id="btnEdit" value="Edit" runat="server" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;display:none;" onclick="onEditItems(this);" meta:resourcekey="btnEditDiscountResource1"/>';
                var btnDelete = '<input id="btnDelete" value="Delete" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(this);"/>';
                var tdAction = $('<td/>').html(btnEdit + btnDelete);
                dtTR.append(checkID).append(Direction).append(tdPID).append(tdPName);
                $('[id$="tbCoumpoundItems"] tbody').append(dtTR);
            });
            $('#tblComboundItems tr').each(function(i, j) {
                $parentRow = $(j);
                $('input[id^="chk"]').attr('checked', false);
            });
        }
        else {
            var parentDrugName = $("#hdnparentDrugName").val();
            var selectedRowID;
            var selectedRow;
            var $row;
            var childDrugName = '';
            $('#tbCoumpoundItems tbody tr').each(function(i, n) {
                $row = $(n);
                childDrugName = $row.find($('span[id$="DrugName"]')).html();
                if ($.trim(parentDrugName) == $.trim(childDrugName)) {
                    $row.remove();
                }

            });
            $.each(DataTable, function(i, obj) {
                dtTR = $('<tr/>');
                var checkID = $('<td align="left"/>').html("<span id='ChkBoxID'>" + obj.ChkID + " </span>");
                var Direction = $('<td align="left"/>').html("<span id='DrugName'>" + obj.DrugName + " </span>");
                var tdPID = $('<td style="display:block;"/>').html("<span id='ProductID'>" + obj.ProductID + " </span>");
                var tdPName = $('<td align="left"/>').html("<span id='ProductName'>" + obj.ProductName + " </span>");
                var btnEdit = '<input id="btnEditDiscount" value="Edit" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;display:none;" onclick="onEditItems(this);"/>';
                var btnDelete = '<input id="btnDeleteDiscount" value="Delete" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(this);"/>';
                var tdAction = $('<td/>').html(btnEdit + btnDelete);
                dtTR.append(checkID).append(Direction).append(tdPID).append(tdPName);
                $('[id$="tbCoumpoundItems"] tbody').append(dtTR);
            });

        }

    }
    catch (e) {
        return false;
    }
}
function CreateCompoundTable(lstItems) {

    try {

        var DataTable = [];
        DataTable = lstItems;

        if ($('[id$="hdnTempTableIndex"]').val() == '') {
            $.each(DataTable, function(i, obj) {
                dtTR = $('<tr/>');
                var tdPID = $('<td style="display:none;"/>').html("<span id='ProductID'>" + obj.ProductID + "</span>");
                var tdDrugName = $('<td align="left" style="display:block;" name="Drgname"/>').html("<span id='DrugName'>" + obj.BrandName + " </span>");
                var tdFrequency = $('<td align="left"/>').html("<span id='Frequency'>" + obj.DrugFrequency + " </span>");
                var tdDose = $('<td align="left"/>').html("<span id='Dose'>" + obj.Dose + " </span>");
                var tdDuration = $('<td align="left"/>').html("<span id='Duration'>" + obj.Duration + " </span>");
                var tdDurationType = $('<td align="left"/>').html("<span id='DurationType'>" + obj.PrescriptionType + " </span>");
                var tdInstruction = $('<td align="left"/>').html("<span id='Instruction'>" + obj.Instruction + " </span>");
                var PtoductItems = $('<td align="left"/>').html("<span id='PtoductItems'>" + obj.Direction + " </span>");
                var btnEdit = '<input id="btnEdit" value="' + sClientLabels.btnEdit + '" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;display:none;" onclick="onEditItems(this);"/>';
                var btnDelete = '<input id="btnDelete" value="' + sClientLabels.btnDelete + '" type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(this);"/>';
                var tdAction = $('<td/>').html(btnEdit + btnDelete);
                dtTR.append(tdPID).append(tdDrugName).append(tdFrequency).append(tdDose).append(tdDuration).append(tdDurationType).append(tdInstruction).append(PtoductItems).append(tdAction);
                $('[id$="tbCoumpoundTable"] tbody').append(dtTR);
            });
        }
        else {
            var selectedRowID = $('[id$="hdnTempTableIndex"]').val();

            $.each(DataTable, function(i, obj) {
                selectedRow = $('[id$="tbCoumpoundTable"] tbody tr:eq(' + selectedRowID + ')');
                selectedRow.find("span[id$='ProductID']").html(obj.ProductID);
                selectedRow.find("span[id$='DrugName']").html(obj.BrandName);
                selectedRow.find("span[id$='Frequency']").html(obj.DrugFrequency);
                selectedRow.find("span[id$='Dose']").html(obj.Dose);
                selectedRow.find("span[id$='Duration']").html(obj.Duration);
                selectedRow.find("span[id$='DurationType']").html(obj.PrescriptionType);
                selectedRow.find("span[id$='Instruction']").html(obj.Instruction);
                selectedRow.find("span[id$='PtoductItems']").html(obj.Direction);
                $('[id$="hdnTempTableIndex"]').val("");
                $('#btnAddComboundItems').val('ADD');
            });
        }
    }
    catch (e) {
        return false;
    }

}
function onEditItems(editItmes) {
    try {

        var $row;
        var $parentRow;
        var childDrugName;
        $('#hdnparentDrugName').val('');
        var $setItems = $(editItmes).closest('tr');
        var rowIndex = $setItems.index();
        $('#btnAddComboundItems').val('Update');
        var DrugName = $setItems.find("span[id$='DrugName']").html();
        if (DrugName != '') {
            $('[id$="txtCoumpoundDrugName"]').val($.trim(DrugName));
            $("#hdnparentDrugName").val($.trim(DrugName));
        }
        else {
            $('[id$="txtCoumpoundDrugName"]').val('');
        }

        var Frequency = $setItems.find("span[id$='Frequency']").html();
        if (Frequency != '') {
            document.getElementById('ddFrequency').value = $.trim(Frequency);
        }
        else {
            $('[id$="ddFrequency"] option:first').attr("selected", true);
        }

        var dose = $setItems.find("span[id$='Dose']").html();
        if (dose != '') {
            document.getElementById('txtDose').value = $.trim(dose);
        }


        var Duration = $setItems.find("span[id$='Duration']").html();
        if (Duration != '') {
            $('[id$="txtDuration"]').val($.trim(Duration));
        }
        else {
            $('[id$="txtDuration"]').val('');
        }

        var DurationType = $setItems.find("span[id$='DurationType']").html();
        if (DurationType != '') {
            $("#ddlDurationType").val($.trim(DurationType));
        }
        else {
            $('[id$="ddlDurationType"] option:first').attr("selected", true);
        }

        var Instruction = $setItems.find("span[id$='Instruction']").html();
        if (Instruction != '') {
            $('[id$="txtInstruction"]').val($.trim(Instruction));
            document.getElementById('ddlInstruction').value = $.trim(Instruction);
        }
        else {
            $('[id$="txtInstruction"]').val('');
            $('[id$="ddlInstruction"] option:first').attr("selected", true);
        }
        $('[id$="hdnTempTableIndex"]').val($.trim(rowIndex));

        var ParentDrugName;
        var parentChkBox;
        ParentDrugName = $('#hdnparentDrugName').val();
        $('#tbCoumpoundItems tbody tr').each(function(i, n) {
            $row = $(n);
            var childChkBoxID = $row.find($("span[id$='ChkBoxID']")).html();
            childDrugName = $row.find($('span[id$="DrugName"]')).html();

            $('#tblComboundItems tr').each(function(i, j) {
                $parentRow = $(j);
                parentChkBox = $parentRow.find($('input:checkbox[name=ProductList]').attr("id")).selector;
                if ($.trim(childChkBoxID) == $.trim(parentChkBox) && $.trim(ParentDrugName) == $.trim(childDrugName)) {
                    $parentRow.find($('input:checkbox[name=ProductList]').attr('checked', true));
                }
            });

        });
    }
    catch (e) {
        return false;
    }
    return false
}
function onDeleteItem(DeleteItems) {
    try {
        var DrugName
        var ChildDrugName
        var $row;
        var $Childrow;
        $row = $(DeleteItems).closest('tr');
        //alert($row.find($('span[id$="DrugName"]')).html());
        DrugName = $row.find($('span[id$="DrugName"]')).html();
        $(DeleteItems).closest('tr').remove();
        if ($("#tbCoumpoundTable")[0].rows.length > 1) {
            $('#tbCoumpoundItems tbody tr').each(function(i, j) {
                $Childrow = $(j);
                ChildDrugName = $Childrow.find($('span[id$="DrugName"]')).html();
                if ($.trim(DrugName) == $.trim(ChildDrugName)) {
                    $Childrow.remove();
                }
            });
        }
        else {
            $("#tbCoumpoundItems tbody tr").remove();
        }
    }



    catch (e) {
        return false;
    }
    return false;
}
function btnClose() {
    //    if ($("#tbCoumpoundTable")[0].rows.length > 1) {
    //        document.getElementById('tbMAkeDue').style.display = 'block';
    //        document.getElementById('tbMAkePaymet').style.display = 'block';
    //        document.getElementById('tdCancel').style.display = 'block';
    //    }
    //    else {
    //        document.getElementById('tbMAkeDue').style.display = 'none';
    //        document.getElementById('tbMAkePaymet').style.display = 'none';
    //        document.getElementById('tdCancel').style.display = 'none';
    //    }
    document.getElementById('tbMAkeDue').style.display = 'block';
    document.getElementById('tbMAkePaymet').style.display = 'block';
    document.getElementById('tdCancel').style.display = 'block';
    document.getElementById('tdCompoundProducts').style.display = 'block';
}
function btnopClose() {
    //    if ($("#tbCoumpoundTable")[0].rows.length > 1) {
    //        document.getElementById('tbMAkePaymet').style.display = 'block';
    //        document.getElementById('tdCancel').style.display = 'block';
    //    }
    //    else {
    //        document.getElementById('tbMAkePaymet').style.display = 'block';
    //        document.getElementById('tdCancel').style.display = 'block';
    //    }

    $('#tbMAkePaymet').removeClass().addClass('a-left');
    $('#tdCancel').removeClass().addClass('a-right w-49p');
    $('#tdCompoundProducts').removeClass().addClass('displaytd');
    
    

}
function SavePrescriptionDetails() {

    var VisitID = $('[id$="hdnPatVisitID"]').val();
    if ($("#tbCoumpoundTable")[0].rows.length > 1) {
        var lstPrescriptionDetails = [];
        $('[id$="tbCoumpoundTable"] tbody tr').each(function(i, n) {
            var currentRow = $(n);
            var BrandName = currentRow.find("span[id$='DrugName']").html();
            var DrugFrequency = currentRow.find("span[id$='Frequency']").html();
            var Duration = currentRow.find("span[id$='Duration']").html();
            var PrescriptionType = currentRow.find("span[id$='DurationType']").html();
            var Instruction = currentRow.find("span[id$='Instruction']").html();
            var Direction = currentRow.find("span[id$='PtoductItems']").html();
            var DrugID = currentRow.find("span[id$='ProductID']").html();
            var Dose = currentRow.find("span[id$='Dose']").html();

            lstPrescriptionDetails.push({
                BrandName: BrandName,
                DrugFrequency: DrugFrequency,
                Duration: Duration,
                PrescriptionType: PrescriptionType,
                Instruction: Instruction,
                Direction: Direction,
                PatientVisitID: VisitID,
                Dose: Dose
            });
            if (lstPrescriptionDetails.length > 0) {
                $('[id$="hdnlistCoumpoundItems"]').val(JSON.stringify(lstPrescriptionDetails));

            }
        });
    }
    if(document.getElementById('tbCoumpoundItems')!=null)
    {
    if ($("#tbCoumpoundItems")[0].rows.length > 1) {
        var lstProductItems = [];
        $('[id$="tbCoumpoundItems"] tbody tr').each(function(i, n) {
            var currentRow = $(n);
            var BrandName = currentRow.find("span[id$='DrugName']").html();
            var Direction = currentRow.find("span[id$='ProductName']").html();
            var DrugID = currentRow.find("span[id$='ProductID']").html();

            lstProductItems.push({
                BrandName: BrandName,
                ComplaintId: DrugID,
                Direction: Direction,
                PatientVisitID: VisitID
            });
            $('[id$="hdnComponentsID"]').val(JSON.stringify(lstProductItems));
        });
        }
    }
}

function ClearItems() {
    try {
        $('[id$="txtCoumpoundDrugName"]').val("");
        $('[id$="ddFrequency"] option:last').attr("selected", true);
        $('[id$="txtDuration"]').val('');
        $('[id$="ddlDurationType"] option:first').attr("selected", true);
        $('[id$="ddlDurationType"] option:first').attr("selected", true);
        $('[id$="ddlInstruction"] option:first').attr("selected", true);
        $('[id$="txtInstruction"]').val('');
        $('#txtDose').val('');
        return false;
    }
    catch (e) {
        return false;
    }
}
function CheckBoxCount() {

    var len;
    var DrgName;
    if ($("#tblComboundItems")[0].rows.length > 1) {
        $('#tblComboundItems input[type=checkbox]:checked').each(function(i, n) {
            var $row = $(this).closest("tr");
            len = $("#tblComboundItems  tbody  tr input[type=checkbox]:checked").length;

        });
        if (len > 1) {
            $("#ChkIsCoumponent").attr('checked', true);
            $("#txtCoumpoundDrugName").val('');
            $("#txtCoumpoundDrugName").attr("disabled", false);

        }
        else {
            $('#tblComboundItems input[type=checkbox]:checked').each(function(i, n) {
                var $row = $(this).closest("tr");
                DrgName = $row.find($('span[id^="lblproductname"]')).html();
            });
            $("#ChkIsCoumponent").attr('checked', false);
            $("#txtCoumpoundDrugName").val(DrgName);
            $("#txtCoumpoundDrugName").attr("disabled", true);
        }
    }
}

function isComponent() {
    var $len = $("#tblComboundItems  tbody  tr input[type=checkbox]:checked").length;
    if ($("#ChkIsCoumponent").is(':checked')) {
        $("#txtCoumpoundDrugName").attr("disabled", false);
    }
    else {
        $("#txtCoumpoundDrugName").attr("disabled", true);
    }

}

function CoumbndTblistJSON() {    
    $('#tblComboundItems tr').remove();
    var Headrow = document.getElementById('tblComboundItems').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "dataheader1";
    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    cell1.innerHTML = sClientLabels.serialNumber;
    cell2.innerHTML = sClientLabels.Select;
    cell3.innerHTML = sClientLabels.ProductName;   
    var pCount = lstProductList.length;

    $.each(lstProductList, function(obj, value) {    
    var row = document.getElementById('tblComboundItems').insertRow(1);
    row.style.height = "13px";
    var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var Hdn = '<input id="hdnlstCompound_' + value.ProductID + '" type="hidden" " value="' + value.ProductID + '" />';
    cell1.innerHTML = pCount;
    cell2.innerHTML = "<input type=checkbox onclick=CheckBoxCount() id=chk" + value.ProductID + " name='ProductList '/>" + Hdn;
    cell3.innerHTML = '<span id="lblproductname">' + value.ProductName + '</span>';
    pCount = pCount - 1;
  });   

}