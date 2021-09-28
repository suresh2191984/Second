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
            cell1.innerHTML = pCount;
            cell2.innerHTML = "<input type='checkbox' onclick='CheckBoxCount(this.id,name)' id='chk" + y[0] + "' name='" + y[1] + "||" + y[6] + "||chk" + y[0] + "' />";
            cell3.innerHTML = "<span id='lblproductname'>" + y[1] + "</span>";


        }

        pCount = pCount - 1;
    }

    var x = $("#hdnlstCompounts").val().split("^");

    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            var xp = y[7].split("@#$");
            for (k = 0; k < xp.length; k++) {
                if (xp[k] != "") {

                    $("#" + xp[k].split('||')[2]).attr("disabled", true);
                    $("#" + xp[k].split('||')[2]).attr('checked', true);
                }
            }
        }
    }
}


function FnCheckValidation() {

    var userMsg

    if ($("#hdnTempCoumpoundItems").val() == "") {
        userMsg = SListForApplicationMessages.Get('Inventory\\InvIpBilling_3.aspx');
        if (userMsg != null) {
            alert(userMsg);
            return false
        }
        else {
            alert('select the products')
            return false
        }
    }

    if ($('[id$="txtCoumpoundDrugName"]').val() == "") {
        if ($('#ChkIsCoumponent').attr('checked')) {
            userMsg = SListForApplicationMessages.Get('Inventory\\InvIpBilling_4.aspx');
            if (userMsg != null) {
                alert(userMsg);
                return false
            }
            else {
                alert('provide the drugName')
                return false
            }
        }

    }

    if ($("#ddFrequency").val() == '0') {
        userMsg = SListForApplicationMessages.Get('Inventory\\InvIpBilling_5.aspx');
        if (userMsg != null) {
            alert(userMsg);
            return false
        }
        else {
            alert('provide the frequency')
            return false
        }
    }

    if ($("#txtDuration").val() == "") {
        userMsg = SListForApplicationMessages.Get('Inventory\\InvIpBilling_6.aspx');
        if (userMsg != null) {
            alert(userMsg);
            return false
        }
        else {
            alert('provide the Duration')
            return false
        }
    }

    if ($("#ddlInstruction").val() == '0') {
        userMsg = SListForApplicationMessages.Get('Inventory\\InvIpBilling_7.aspx');
        if (userMsg != null) {
            alert(userMsg);
            return false
        }
        else {
            alert('provide the Instruction')
            return false
        }
    }
    SaveTesting();
    ClearItems();

    return true
}


function ClearItems() {
     
        $("#txtCoumpoundDrugName").val("");
        $("#ddFrequency option:first").attr("selected", true);
        $("#txtDuration").val('');
        $("#ddlDurationType option:first").attr("selected", true);
        $("#ddlDurationType option:first").attr("selected", true);
        $("#ddlInstruction option:first").attr("selected", true);
        $("#txtComment").val('');
        $("#hdnTempCoumpoundItems").val('');
      
}


function SaveTesting() {
    if ($("#btnAddComboundItems").val() == 'Update') {
        CompountsDeleterows();
    }
    else {

        var Frequency = '';
        var Duration = '';
        var DurationType = '';
        var Instruction = '';
        var IsCoumponent = false;
        var Comment = '';
        var ComponentName = '';

        IsCoumponent = $("#ChkIsCoumponent").is(':checked');
        ComponentName = $("#txtCoumpoundDrugName").val();
        Frequency = $("#ddFrequency").val();
        Duration = $("#txtDuration").val();
        DurationType = $("#ddlDurationType").val();
        Instruction = $("#ddlInstruction").val();
        Comment = $("#txtComment").val();
        var plst = $("#hdnlstCompounts").val();
        var tempplist = $("#hdnTempCoumpoundItems").val();
        $("#hdnlstCompounts").val(plst + "^" + IsCoumponent + "~" + ComponentName + "~" + Frequency + "~" + Duration + "~" + DurationType +
                        "~" + Instruction + "~" + Comment + "~" + tempplist + "^");
        $("#hdnTempCoumpoundItems").val("");

        CreateCompoundItemsTable();
    }



}
function ResultTemplateShowToolTip(objkey, objval) {

    $('span#popupResultTemplate').html("<img src='../images/Info.png' alt='Info' height='48' width='48' /><em>" + objkey + "</em>" + objval);
    $('span#popupResultTemplate').show();
}
function ResultTemplateHideToolTip() {
    $('span#popupResultTemplate').hide();
}

function CreateCompoundItemsTable() {

    while (count = document.getElementById('tbCoumpoundTable').rows.length) {

        for (var j = 0; j < document.getElementById('tbCoumpoundTable').rows.length; j++) {
            document.getElementById('tbCoumpoundTable').deleteRow(j);
        }
    }
    var Headrow = document.getElementById('tbCoumpoundTable').insertRow(0);
    Headrow.id = "HeadID";
    Headrow.style.fontWeight = "bold";
    Headrow.className = "dataheader1"

    var cell1 = Headrow.insertCell(0);
    var cell2 = Headrow.insertCell(1);
    var cell3 = Headrow.insertCell(2);
    var cell4 = Headrow.insertCell(3);
    var cell5 = Headrow.insertCell(4);
    var cell6 = Headrow.insertCell(5);
    var cell7 = Headrow.insertCell(6);
    var cell8 = Headrow.insertCell(7);

    cell1.innerHTML = sClientLabels.DrugName;
    cell2.innerHTML = sClientLabels.Frequency;
    cell3.innerHTML = sClientLabels.Duration;
    cell4.innerHTML = sClientLabels.Instruction;
    cell5.innerHTML = sClientLabels.Products;
    cell6.innerHTML = sClientLabels.IsComponent;
    cell7.innerHTML = sClientLabels.Comment;
    cell8.innerHTML = sClientLabels.Action;

    var x = $("#hdnlstCompounts").val().split("^");
    var pCount = x.length;
    pCount = pCount - 1;

    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            y = x[i].split('~');
            var row = document.getElementById('tbCoumpoundTable').insertRow(1);
            row.style.height = "13px";
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            var cell5 = row.insertCell(4);
            var cell6 = row.insertCell(5);
            var cell7 = row.insertCell(6);
            var cell8 = row.insertCell(7);

            cell1.innerHTML = y[1];
            cell2.innerHTML = y[2];
            cell3.innerHTML = y[3] + "  " + y[4];
            cell4.innerHTML = y[5];

            var xp = y[7].split("@#$");
            var templist = "";
            var fpname = '';

            for (k = 0; k < xp.length; k++) {
                if (xp[k] != "") {
                    templist += xp[k].split('||')[0] + ", ";
                    $("#" + xp[k].split('||')[2]).attr("disabled", true);
                    if (fpname == '') {
                        fpname = xp[k].split('||')[0]
                    }
                }
            }
            if (fpname.length - 1 > 10) {
                fpname = fpname.substring(0, 9) + "....";
            }
            fpname = fpname.substring(0, fpname.length - 1)
            templist = templist.substring(0, templist.length - 1);
            cell5.innerHTML = fpname;
            cell5.setAttribute("onmouseover", "ResultTemplateShowToolTip('" + y[1] + "','" + templist + "')", true)
            cell5.setAttribute("onmouseout", "ResultTemplateHideToolTip()", true);
            cell5.setAttribute("style", "background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;", true);
            cell6.innerHTML = y[0];
            if (y[6].length > 15) {
                fpname = y[6].substring(0, 15) + "....";
            }
            cell7.innerHTML = fpname;
            cell8.innerHTML = '<input id="btnEdit" name="' + x[i] + '" value='sClientLabels.Edit+' runat="server" type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onEditItems(name);" meta:resourcekey="btnEditDiscountResource1"/>'
            + '<input id="btnDelete" name="' + x[i] + '" value='+sClientLabels.Delete+' type="button" style="background-color: Transparent; color: Red; border-style: none; text-decoration: underline; cursor: pointer; font-size: 12px;" onclick="onDeleteItem(name);"/>';
        }

        pCount = pCount - 1;
    }

    $("#btnAddComboundItems").val('Add')


}
function onEditItems(editItmes) {
    $("#hdnRowEdit").val(editItmes);
    y = editItmes.split('~');
    $("#ChkIsCoumponent").is(':checked', y[0]);
    $("#txtCoumpoundDrugName").val(y[1]);
    $("#ddFrequency").val(y[2]);
    $("#txtDuration").val(y[3]);
    $("#ddlDurationType").val(y[4]);
    $("#ddlInstruction").val(y[5]);
    $("#txtComment").val(y[6]);
    $("#hdnTempCoumpoundItems").val(y[7]);
    var xp = y[7].split("@#$");
    for (k = 0; k < xp.length; k++) {
        if (xp[k] != "") {

            $("#" + xp[k].split('||')[2]).attr("disabled", false);

        }
    }
    $("#btnAddComboundItems").val('Update')
}

function CompountsDeleterows() {
    var RowEdit = document.getElementById('hdnRowEdit').value;
    var x = $("#hdnlstCompounts").val().split("^");
    if (RowEdit != "") {
        var Frequency = '';
        var Duration = '';
        var DurationType = '';
        var Instruction = '';
        var IsCoumponent = false;
        var Comment = '';
        var ComponentName = '';

        IsCoumponent = $("#ChkIsCoumponent").is(':checked');
        ComponentName = $("#txtCoumpoundDrugName").val();
        Frequency = $("#ddFrequency").val();
        Duration = $("#txtDuration").val();
        DurationType = $("#ddlDurationType").val();
        Instruction = $("#ddlInstruction").val();
        Comment = $("#txtComment").val();
        var tempplist = $("#hdnTempCoumpoundItems").val();
        $("#hdnlstCompounts").val(IsCoumponent + "~" + ComponentName + "~" + Frequency + "~" + Duration + "~" + DurationType +
                        "~" + Instruction + "~" + Comment + "~" + tempplist + "^");
        $("#hdnTempCoumpoundItems").val("");


        var tlst = ""
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != RowEdit) {
                    tlst += x[i] + "^";
                }
            }
        }
        $("#hdnlstCompounts").val(tlst + $("#hdnlstCompounts").val());
        CreateCompoundItemsTable();
    }
}

function onDeleteItem(DeleteItems) {

    var i;
    var x = $("#hdnlstCompounts").val().split("^");
    $("#hdnlstCompounts").val('');
    var tlst = ""
    for (i = 0; i < x.length; i++) {
        if (x[i] != "") {
            if (x[i] != DeleteItems) {
                tlst += x[i] + "^";
            }
        }
    }
    $("#hdnTempCoumpoundItems").val(DeleteItems.split('~')[7]);
    var xp = DeleteItems.split('~')[7].split("@#$");
    for (k = 0; k < xp.length; k++) {
        if (xp[k] != "") {

            $("#" + xp[k].split('||')[2]).attr("disabled", false);
            $("#" + xp[k].split('||')[2]).attr('checked', false);

        }
    }
    $("#hdnlstCompounts").val(tlst);
    CreateCompoundItemsTable();
    ClearItems();
}

function btnClose() {
    document.getElementById('tbMAkeDue').style.display = 'block';
    document.getElementById('tbMAkePaymet').style.display = 'block';
    document.getElementById('tdCancel').style.display = 'block';
    document.getElementById('tdCompoundProducts').style.display = 'block';
}

function CheckBoxCount(objid, objVal) {
    var TempCoumpoundItems = $("#hdnTempCoumpoundItems").val();
    var x = (TempCoumpoundItems).split("@#$");
    var templist = "";
    $("#hdnTempCoumpoundItems").val('');

    if ($("#" + objid).is(':checked') == false) {
        for (i = 0; i < x.length; i++) {
            if (x[i] != "") {
                if (x[i] != objVal) {
                    templist += x[i] + "@#$";
                }
            }
        }
    }
    else {
        templist = (TempCoumpoundItems + "@#$" + objVal);
    }


    $("#hdnTempCoumpoundItems").val(templist);

    var plistItems = $("#hdnTempCoumpoundItems").val().split("@#$");
    var isCoumpounding = false;
    var pcon = 1;
    for (i = 0; i < plistItems.length; i++) {
        if (plistItems[i] != "") {
            if (pcon > 1) {
                isCoumpounding = true;
                $("#ChkIsCoumponent").attr('checked', true);
                $("#txtCoumpoundDrugName").val('');
                $("#txtCoumpoundDrugName").attr("disabled", false);
            }
            else {
                $("#ChkIsCoumponent").attr('checked', false);
                $("#txtCoumpoundDrugName").val(plistItems[i].split("||")[0]);
                $("#txtCoumpoundDrugName").attr("disabled", true);
            }
            pcon = pcon + 1;

        }
    }
}

function isComponent() {

    if ($("#ChkIsCoumponent").is(':checked')) {
        $("#txtCoumpoundDrugName").attr("disabled", false);
    }
    else {
        $("#txtCoumpoundDrugName").attr("disabled", true);
    }

}