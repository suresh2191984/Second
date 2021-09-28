<%@ Control Language="C#" AutoEventWireup="true" CodeFile="OrganismDrugPattern.ascx.cs"
    Inherits="Investigation_OrganismDrugPattern" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<style type="text/css">
    .dataheaderInvCtrl td, .dataheaderInvCtrl th
    {
        border: 1px solid #000;
    }
    .divTable
    {
        width: 100%;
        display: block;
        padding-top: 10px;
        padding-bottom: 10px;
        padding-right: 10px;
        padding-left: 10px;
    }
    .divRow
    {
        width: 99%;
    }
    .divColumn
    {
        float: left;
        padding-bottom: 15px;
    }
    .divColumn td, .divColumn th
    {
        border: 1px solid #000;
    }
</style>

<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    var hdnLstOrganisums = '<%=hdnLstOrganisums.ClientID %>';
    function GetOrganismDrugDetails(InvestigationID, organismID, organismCode, type, organismName, hdnInvID, hdnOrganismCount, divTblOrgans) {
        try {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetOrganismDrugDetails",
                data: "{invID: " + InvestigationID + ", organismID:" + organismID + ", organismCode:'" + organismCode + "', type:'" + type + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var lstOrganismDrugDetails = data.d;
                    LoadOrganismDrugList(organismName, lstOrganismDrugDetails, hdnInvID, hdnOrganismCount, divTblOrgans);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                }
            });
        }
        catch (e) {
            return false;
        }
    }
    function GetOtherOrganismDrugDetails(organismName, hdnInvID, hdnOrganismCount, divTblOrgans, divOtherOrganism, txtOtherOrganism) {
        try {
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/GetOtherOrganismDrugDetails",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function Success(data) {
                    var lstInvDrugBrand = data.d;
                    LoadOtherOrganismDrugList(organismName, lstInvDrugBrand, hdnInvID, hdnOrganismCount, divTblOrgans, divOtherOrganism, txtOtherOrganism);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                }
            });
        }
        catch (e) {
            return false;
        }
    }
    function GetOrganismCount(hdnOrganismCount) {
        var OrganismCount = document.getElementById(hdnOrganismCount).value;
        var count = parseInt(OrganismCount) + 1;
        document.getElementById(hdnOrganismCount).value = count;
        return count;
    }
    function isOdd(value) {
        if (value % 2 == 0)
            return false;
        else
            return true;
    }
    function onAddNewDrugDetails(obj) {
        var vdelete = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05');
        var vSensitive = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10');
        var vIntermediate = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11') == null ? "Intermediate" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11');
        var vResistant = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12') == null ? "Resistant" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12');
        var vSusceptible = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14') == null ? "Susceptible" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14');
        var vSusDD = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15') == null ? "Susceptible- Dose dependent" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15');       
        var vSelect = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13') == null ? "Select" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13');
    
        try {
            var vdelete = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05');
            var tableId = $(obj).closest('table').attr('id');
            var table = document.getElementById(tableId);
            var rowCount = 0;
            if (document.getElementById(tableId).getElementsByTagName("tr") != null) {
                rowCount = document.getElementById(tableId).getElementsByTagName("tr").length;
            }
            var row = table.insertRow(rowCount);
            row.setAttribute("style", "height:25px");
            var hdnNameSeq = '<input type="hidden"  id="hdnNameSeq" value="0" />';
            var hdnFamilySeq = '<input type="hidden"  id="hdnFamilySeq" value="0" />';
            var tdDrugName = row.insertCell(0);
            tdDrugName.innerHTML = '<input type="text" id="txtDrugName" class="Txtboxsmall" value="" />' + hdnNameSeq + hdnFamilySeq;
            var tdSensitivity = row.insertCell(1);

            var selectElement = document.createElement("select");
            selectElement.id = "ddlSensitivity";
            selectElement.setAttribute("class", "ddl");
            var option1 = new Option(vSelect, "0");
            selectElement.options[selectElement.options.length] = option1;
            var option2 = new Option(vSensitive, "Sensitive");
            selectElement.options[selectElement.options.length] = option2;
            var option3 = new Option(vIntermediate, "Intermediate");
            selectElement.options[selectElement.options.length] = option3;
            var option4 = new Option(vResistant, "Resistant");
            selectElement.options[selectElement.options.length] = option4;
            var option5 = new Option(vSusceptible, "Susceptible");
            selectElement.options[selectElement.options.length] = option5;
            var option6 = new Option(vSusDD, "Susceptible- Dose dependent");
            selectElement.options[selectElement.options.length] = option6;
            var option7 = new Option("-", "-");
            selectElement.options[selectElement.options.length] = option7;
            tdSensitivity.appendChild(selectElement);
            var tdZone = row.insertCell(2);
            tdZone.innerHTML = '<input type="text" id="txtZone" class="Txtboxverysmall" value="" />';
            var tdDelete = row.insertCell(3);
            tdDelete.innerHTML = '<input id="btnDelete"  value=' + vdelete + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onDeleteDrugDetails(this);" />';
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteOrganismDetails(obj) {
        var vOrganism = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_01') == null ? "Are you sure you want to delete this organism details?" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_01');
        try {
            if (confirm(vOrganism)) {
                $(obj).closest('table').closest('div').remove();
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteDrugDetails(obj) {
        var vDrug = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_02') == null ? "Are you sure you want to delete this drug details?" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_02');
        try {
            if (confirm(vDrug)) {
                $(obj).closest('tr').remove();
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onChangeOrganismDropDown(ddlGrowthOrganisms, hdnInvestigationID, txtOtherOrganismName, divOtherOrganism, hdnOrganismCount, divTblOrgans, hdnVal, GroupName, ddlStatus) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vOrganismAdd = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_03') == null ? "Select any one organism to add" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_03');
        var vDetailsAlready = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04') == null ? "Selected organism details already added" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04');

        try {
            var ddlGrowthOrganismsID = document.getElementById(ddlGrowthOrganisms);
            var hdnInvID = document.getElementById(hdnInvestigationID).value;
            var invID = document.getElementById(hdnVal).value;
            if (ddlGrowthOrganismsID.selectedIndex > 0) {
                var organismName = ddlGrowthOrganismsID.options[ddlGrowthOrganismsID.selectedIndex].text;
                var organismID = ddlGrowthOrganismsID.options[ddlGrowthOrganismsID.selectedIndex].value;
                if (organismID == "Other") {
                    organismName = document.getElementById(txtOtherOrganismName).value;
                }
                var divElement = document.getElementById("divColumnChart" + hdnInvID + organismName);
                if (typeof (divElement) != 'undefined' && divElement != null) {
                    //alert("Selected organism details already added");
                    ValidationWindow(vDetailsAlready, AlertType);
                    return false;
                }
                else {
                    if (organismID == "Other") {
                        GetOtherOrganismDrugDetails(organismName, hdnInvID, hdnOrganismCount, divTblOrgans, divOtherOrganism, txtOtherOrganismName);
                    }
                    else {
                        GetOrganismDrugDetails(invID, organismID, "", "", organismName, hdnInvID, hdnOrganismCount, divTblOrgans);
                    }
                    ddlGrowthOrganismsID.selectedIndex = 0;
                }
				setCompletedStatus(GroupName, ddlStatus);
            }
            else {
                //alert("Select any one organism to add");
                ValidationWindow(vOrganismAdd, AlertType);
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function LoadXMLDrugList(organismName, resultXML, hdnInvID, hdnOrganismCount, divTblOrgans) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDetailsAlready = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04') == null ? "Selected organism details already added" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04');
        var vDrugName = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_06") == null ? "Drug Name" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_06");
        var vSensitivity = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_07") == null ? "Sensitivity" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_07");
        var vMICVal = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_08") == null ? "MIC Values (mcg/ml)" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_08");
        var vAction = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_09') == null ? "Action" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_09');
        var vdelete = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05');
        var vSensitive = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10');
        var vIntermediate = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11') == null ? "Intermediate" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11');
        var vResistant = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12') == null ? "Resistant" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12');
        var vSelect = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13') == null ? "Select" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13');
        var vSusceptible = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14') == null ? "Susceptible" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14');
        var vSusDD = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15') == null ? "Susceptible- Dose dependent" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15');
        var vAdd = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_16') == null ? "Add" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_16');
        
        try {
            var organismXML = $('select[id$="ddlGrowthOrganisms"] option').filter(function() { return $(this).html() == organismName; }).val();
            var divElement = document.getElementById("divColumnChart" + hdnInvID + organismName);
            if (typeof (divElement) != 'undefined' && divElement != null) {
                // alert("Selected organism details already added");
                ValidationWindow(vDetailsAlready, AlertType);
                return false;
            }
            else {
                var divTagTemp = document.createElement('div');
                var divTag = document.createElement('div');
                $(divTag).attr('id', 'divColumnChart' + hdnInvID + organismName);
                $(divTag).addClass("divColumn");
                var table$ = $('<table/>');
                table$.attr('id', hdnInvID + organismName);
                table$.addClass('dataheaderInvCtrl');
                table$.attr('cellpadding', '2').attr('cellspacing', '0');
                var OrganNameRow$ = $('<tr/>');
                var thOrganName = $('<th colspan="4"/>').html('<div style="width:100%;"><div style="width:99%;"><div style="width:80%;float:left;"><span id="spanOrganName" style="font-size:14px;">' + organismName + '</span></div><div style="float:left;padding-right:10px;"><input id="btnAddNewDrug"  value=' + vAdd + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onAddNewDrugDetails(this);" /></div><div style="float:left;"><img href="javascript:void(0);" style="cursor:pointer;" id="imgClose" src="../Images/dialog_close_button.png" onclick="onDeleteOrganismDetails(this);"></img></div></div></div>');
                OrganNameRow$.append(thOrganName);
                var thead$ = $('<thead/>');
                var tbody$ = $('<tbody/>');
                var headerRow$ = $('<tr/>').css('height', '25px');
                var thDrug = $('<th/>').html(vDrugName);
                var thSensitivity = $('<th/>').html(vSensitivity );
                var thZone = $('<th/>').html(vMICVal);
                var thAction = $('<th/>').html(vAction);
                headerRow$.append(thDrug).append(thSensitivity).append(thZone).append(thAction);
                thead$.append(OrganNameRow$).append(headerRow$);
                table$.append(thead$);
                var familyName = '';
                var OrganXMLData = "";
                var ResultXmlData = "";
		var x = jQuery.noConflict();
                if (resultXML != null && resultXML.length > 0) {
                    OrganXMLData = $.parseXML(resultXML);
                }
                else {
                    OrganXMLData = $.parseXML(organismXML);
                }
                $(OrganXMLData).find('Organ').each(function() {
                    var row$ = $('<tr/>').css('height', '25px');
                    var DrugName = '';
                    if (typeof ($(this).attr('DrugName')) != 'undefined') {
                        DrugName = $(this).attr('DrugName');
                    }
                    var Zone = '';
                    if (typeof ($(this).attr('Zone')) != 'undefined') {
                        Zone = $(this).attr('Zone');
                    }
                    var Sensitivity = '';
                    if (typeof ($(this).attr('Sensitivity')) != 'undefined') {
                        Sensitivity = $(this).attr('Sensitivity');
                    }
                    var family = $(this).attr('Family');
                    if (typeof (family) != 'undefined' && family != familyName) {
                        var familyNameRow$ = $('<tr/>').css('height', '25px');
                        var tdFamilyName = $('<td colspan="4" align="center" style="font-weight:bold;"/>').html('<span id="spanFamily">' + family + '</span>');
                        familyNameRow$.append(tdFamilyName);
                        tbody$.append(familyNameRow$);
                        familyName = family;
                    }
                    var NameSeq = '';
                    if (typeof ($(this).attr('NameSeq')) != 'undefined') {
                        NameSeq = $(this).attr('NameSeq');
                    }
                    var FamilySeq = '';
                    if (typeof ($(this).attr('FamilySeq')) != 'undefined') {
                        FamilySeq = $(this).attr('FamilySeq');
                    }
                    var hdnNameSeq = '<input type="hidden"  id="hdnNameSeq" value="' + NameSeq + '" />';
                    var hdnFamilySeq = '<input type="hidden"  id="hdnFamilySeq" value="' + FamilySeq + '" />';
                    var tdDrug = $('<td/>').html('<input type="text" id="txtDrugName" class="Txtboxsmall" value="' + DrugName + '" />' + hdnNameSeq + hdnFamilySeq);
                    var ddlSensitivity = $('<select id="ddlSensitivity" />');
                    ddlSensitivity.addClass('ddl');
                    $('<option />', { value: '0', text: vSelect }).appendTo(ddlSensitivity);
                    if (Sensitivity == "Sensitive")
                        $('<option />', { value: 'Sensitive', text: vSensitive, selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: 'Sensitive', text: vSensitive }).appendTo(ddlSensitivity);
                    if (Sensitivity == "Intermediate")
                        $('<option />', { value: 'Intermediate', text: vIntermediate, selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: 'Intermediate', text: vIntermediate }).appendTo(ddlSensitivity);
                    if (Sensitivity == "Resistant")
                        $('<option />', { value: 'Resistant', text: vResistant, selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: 'Resistant', text: vResistant }).appendTo(ddlSensitivity);
                    if (Sensitivity == "Susceptible")
                        $('<option />', { value: 'Susceptible', text: vSusceptible, selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: 'Susceptible', text: vSusceptible }).appendTo(ddlSensitivity);
                    if (Sensitivity == "Susceptible- Dose dependent")
                        $('<option />', { value: 'Susceptible- Dose dependent', text: vSusDD, selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: 'Susceptible- Dose dependent', text: vSusDD }).appendTo(ddlSensitivity);
                    if (Sensitivity == "-")
                        $('<option />', { value: '-', text: '-', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: '-', text: '-' }).appendTo(ddlSensitivity);            
                    if (Sensitivity == "+")
                        $('<option />', { value: '+', text: '+', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: '+', text: '+' }).appendTo(ddlSensitivity);
                    if (Sensitivity == "++")
                        $('<option />', { value: '++', text: '++', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: '++', text: '++' }).appendTo(ddlSensitivity);
                    if (Sensitivity == "+++")
                        $('<option />', { value: '+++', text: '+++', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: '+++', text: '+++' }).appendTo(ddlSensitivity);
                    if (Sensitivity == "++++")
                        $('<option />', { value: '++++', text: '++++', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: '++++', text: '++++' }).appendTo(ddlSensitivity);
                    if (Sensitivity == "+++++")
                        $('<option />', { value: '+++++', text: '+++++', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: '+++++', text: '+++++' }).appendTo(ddlSensitivity);
                    if (Sensitivity == "Nil")
                        $('<option />', { value: 'Nil', text: 'Nil', selected: true }).appendTo(ddlSensitivity);
                    else
                        $('<option />', { value: 'Nil', text: 'Nil' }).appendTo(ddlSensitivity); 
                                       
                    ddlSensitivity.val(Sensitivity);
                    var tdSensitivity = $('<td/>').html(ddlSensitivity);
                    //                    var txtSensitivity = '<input type="text" id="txtSensitivity" class="Txtboxsmall" value="' + Sensitivity + '" />';
                    //                    var tdSensitivity = $('<td/>').html(txtSensitivity);

                    var tdZone;
                    if ($(this).children().length > 0) {
                        var ddlmic = $('<select id="ddlmic" "width:99%;"/>');
                        ddlmic.addClass('ddl');
                        $('<option />', { value: '0', text: 'Select' }).appendTo(ddlmic);
                        $(this).children().each(function() {
                            if ($(this).text() == Zone) {
                                $('<option />', { value: $(this).text(), text: $(this).text(), selected: true }).appendTo(ddlmic);
                            }
                            else {
                                $('<option />', { value: $(this).text(), text: $(this).text() }).appendTo(ddlmic);
                            }
                        });
                        tdZone = $('<td/>').html(ddlmic);
                    }
                    else {
                        var txtZone = '<input type="text" id="txtZone" class="Txtboxverysmall" value="' + Zone + '" />';
                        tdZone = $('<td />').html(txtZone);
                    }
                    var lnkDelete = '<input id="btnDelete"  value=' + vdelete + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onDeleteDrugDetails(this);" />';
                    var tdDelete = $('<td/>').html(lnkDelete);
                    row$.append(tdDrug).append(tdSensitivity).append(tdZone).append(tdDelete);
                    tbody$.append(row$);
                });
                table$.append(tbody$);
                $(divTag).html(table$);
                $(divTag).appendTo($(divTagTemp));
                var rowCount = 0;
                var isOddNumber = isOdd(GetOrganismCount(hdnOrganismCount));
                var trOrganism = '';
                var tdOrganism = '';
                if (isOddNumber) {
                    if (parseInt(document.getElementById(hdnOrganismCount).value) > 1) {
                        rowCount = document.getElementById(divTblOrgans).rows.length;
                    }
                    trOrganism = document.getElementById(divTblOrgans).insertRow(rowCount);
                    tdOrganism = trOrganism.insertCell(0);
                }
                else {
                    rowCount = document.getElementById(divTblOrgans).rows.length - 1;
                    trOrganism = document.getElementById(divTblOrgans).rows[rowCount];
                    tdOrganism = trOrganism.insertCell(1);
                }
                tdOrganism.setAttribute("style", "width:50%");
                tdOrganism.setAttribute("valign", "top");
                tdOrganism.innerHTML = $(divTagTemp).html();
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function LoadOrganismDrugList(organismName, lstOrganismDrugDetails, hdnInvID, hdnOrganismCount, divTblOrgans) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDetailsAlready = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04') == null ? "Selected organism details already added" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04');
        var vdelete = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05');
        var vSensitive = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10');
        var vIntermediate = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11') == null ? "Intermediate" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11');
        var vResistant = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12') == null ? "Resistant" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12');        
        var vSusceptible = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14') == null ? "Susceptible" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14');
        var vSusDD = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15') == null ? "Susceptible- Dose dependent" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15');
        var vDrugName = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_06") == null ? "Drug Name" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_06");
        var vSensitivity = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_07") == null ? "Sensitivity" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_07");
        var vMICVal = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_08") == null ? "MIC Values (mcg/ml)" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_08");
        var vAction = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_09') == null ? "Action" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_09');
        var vSelect = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13') == null ? "Select" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13');
        var vAdd = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_16') == null ? "Add" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_16');
        
        try {
            var divElement = document.getElementById("divColumnChart" + hdnInvID + organismName);
            if (typeof (divElement) != 'undefined' && divElement != null) {
                //alert("Selected organism details already added");
                ValidationWindow(vDetailsAlready, AlertType);
                return false;
            }
            else {
                var divTagTemp = document.createElement('div');
                var divTag = document.createElement('div');
                $(divTag).attr('id', 'divColumnChart' + hdnInvID + organismName);
                $(divTag).addClass("divColumn");
                var table$ = $('<table/>');
                table$.attr('id', hdnInvID + organismName);
                table$.addClass('dataheaderInvCtrl');
                table$.attr('cellpadding', '2').attr('cellspacing', '0');
                var OrganNameRow$ = $('<tr/>');
                var thOrganName = $('<th colspan="4"/>').html('<div style="width:100%;"><div style="width:99%;"><div style="width:80%;float:left;"><span id="spanOrganName" style="font-size:14px;">' + organismName + '</span></div><div style="float:left;padding-right:10px;"><input id="btnAddNewDrug"  value='+vAdd+' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onAddNewDrugDetails(this);" /></div><div style="float:left;"><img href="javascript:void(0);" style="cursor:pointer;" id="imgClose" src="../Images/dialog_close_button.png" onclick="onDeleteOrganismDetails(this);"></img></div></div></div>');
                OrganNameRow$.append(thOrganName);
                var thead$ = $('<thead/>');
                var tbody$ = $('<tbody/>');
                var headerRow$ = $('<tr/>').css('height', '25px');
                var thDrug = $('<th/>').html(vDrugName);
                var thSensitivity = $('<th/>').html(vSensitivity );
                var thZone = $('<th/>').html(vMICVal);
                var thAction = $('<th/>').html(vAction);
                headerRow$.append(thDrug).append(thSensitivity).append(thZone).append(thAction);
                thead$.append(OrganNameRow$).append(headerRow$);
                table$.append(thead$);
                var familyName = '';
                $.each(lstOrganismDrugDetails, function(i, obj) {
                    var row$ = $('<tr/>').css('height', '25px');
                    var DrugName = obj.DrugName;
                    var Zone = '';
                    var Sensitivity = '';
                    var family = '';
                    var NameSeq = obj.SequenceNo;
                    var FamilySeq = 0;
                    var hdnNameSeq = '<input type="hidden"  id="hdnNameSeq" value="' + NameSeq + '" />';
                    var hdnFamilySeq = '<input type="hidden"  id="hdnFamilySeq" value="' + FamilySeq + '" />';
                    var tdDrug = $('<td/>').html('<input type="text" id="txtDrugName" class="Txtboxsmall" value="' + DrugName + '" />' + hdnNameSeq + hdnFamilySeq);
                    var ddlSensitivity = $('<select id="ddlSensitivity" />');
                    ddlSensitivity.addClass('ddl');
                    $('<option />', { value: '0', text: vSelect }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Sensitive', text: vSensitive }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Intermediate', text: vIntermediate }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Resistant', text: vResistant }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Susceptible', text: vSusceptible }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Susceptible- Dose dependent', text: vSusDD }).appendTo(ddlSensitivity);
                    $('<option />', { value: '-', text: '-' }).appendTo(ddlSensitivity);
                    var tdSensitivity = $('<td/>').html(ddlSensitivity);

                    var txtZone = '<input type="text" id="txtZone" class="Txtboxverysmall" value="' + Zone + '" />';
                    var tdZone = $('<td />').html(txtZone);
                    var lnkDelete = '<input id="btnDelete"  value=' + vdelete + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onDeleteDrugDetails(this);" />';
                    var tdDelete = $('<td/>').html(lnkDelete);
                    row$.append(tdDrug).append(tdSensitivity).append(tdZone).append(tdDelete);
                    tbody$.append(row$);
                });
                table$.append(tbody$);
                $(divTag).html(table$);
                $(divTag).appendTo($(divTagTemp));
                var rowCount = 0;
                var isOddNumber = isOdd(GetOrganismCount(hdnOrganismCount));
                var trOrganism = '';
                var tdOrganism = '';
                if (isOddNumber) {
                    if (parseInt(document.getElementById(hdnOrganismCount).value) > 1) {
                        rowCount = document.getElementById(divTblOrgans).rows.length;
                    }
                    trOrganism = document.getElementById(divTblOrgans).insertRow(rowCount);
                    tdOrganism = trOrganism.insertCell(0);
                }
                else {
                    rowCount = document.getElementById(divTblOrgans).rows.length - 1;
                    trOrganism = document.getElementById(divTblOrgans).rows[rowCount];
                    tdOrganism = trOrganism.insertCell(1);
                }
                tdOrganism.setAttribute("style", "width:50%");
                tdOrganism.setAttribute("valign", "top");
                tdOrganism.innerHTML = $(divTagTemp).html();
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function LoadOtherOrganismDrugList(organismName, lstInvDrugDetails, hdnInvID, hdnOrganismCount, divTblOrgans, divOtherOrganism, txtOtherOrganism) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vDetailsAlready = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04') == null ? "Selected organism details already added" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_04');
        var vdelete = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05') == null ? "Delete" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_05');
        var vSensitive = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_10');
        var vIntermediate = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11') == null ? "Intermediate" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_11');
        var vResistant = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12') == null ? "Resistant" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_12');
        var vSusceptible = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14') == null ? "Susceptible" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_14');
        var vSusDD = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15') == null ? "Susceptible- Dose dependent" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_15');
        var vDrugName = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_06") == null ? "Drug Name" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_06");
        var vSensitivity = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_07") == null ? "Sensitivity" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_07");
        var vMICVal = SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_08") == null ? "MIC Values (mcg/ml)" : SListForAppMsg.Get("Investigation_OrganismDrugPattern_ascx_08");
        var vAction = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_09') == null ? "Action" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_09');
        var vSelect = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13') == null ? "Select" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_13');
        var vAdd = SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_16') == null ? "Add" : SListForAppMsg.Get('Investigation_OrganismDrugPattern_ascx_16');
        try {
            var divElement = document.getElementById("divColumnChart" + hdnInvID + organismName);
            if (typeof (divElement) != 'undefined' && divElement != null) {
                //alert("Selected organism details already added");
                ValidationWindow(vDetailsAlready, AlertType);
                return false;
            }
            else {
                var divTagTemp = document.createElement('div');
                var divTag = document.createElement('div');
                $(divTag).attr('id', 'divColumnChart' + hdnInvID + organismName);
                $(divTag).addClass("divColumn");
                var table$ = $('<table/>');
                table$.attr('id', hdnInvID + organismName);
                table$.addClass('dataheaderInvCtrl');
                table$.attr('cellpadding', '2').attr('cellspacing', '0');
                var OrganNameRow$ = $('<tr/>');
                var thOrganName = $('<th colspan="4"/>').html('<div style="width:100%;"><div style="width:99%;"><div style="width:80%;float:left;"><span id="spanOrganName" style="font-size:14px;">' + organismName + '</span></div><div style="float:left;padding-right:10px;"><input id="btnAddNewDrug"  value='+vAdd+' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onAddNewDrugDetails(this);" /></div><div style="float:left;"><img href="javascript:void(0);" style="cursor:pointer;" id="imgClose" src="../Images/dialog_close_button.png" onclick="onDeleteOrganismDetails(this);"></img></div></div></div>');
                OrganNameRow$.append(thOrganName);
                var thead$ = $('<thead/>');
                var tbody$ = $('<tbody/>');
                var headerRow$ = $('<tr/>').css('height', '25px');
                var thDrug = $('<th/>').html(vDrugName);
                var thSensitivity = $('<th/>').html(vSensitivity);
                var thZone = $('<th/>').html(vMICVal);
                var thAction = $('<th/>').html(vAction);
                headerRow$.append(thDrug).append(thSensitivity).append(thZone).append(thAction);
                thead$.append(OrganNameRow$).append(headerRow$);
                table$.append(thead$);
                var familyName = '';
                $.each(lstInvDrugDetails, function(i, obj) {
                    var row$ = $('<tr/>').css('height', '25px');
                    var DrugName = obj.BrandName;
                    var Zone = '';
                    var Sensitivity = '';
                    var family = '';
                    var NameSeq = 0;
                    var FamilySeq = 0;
                    var hdnNameSeq = '<input type="hidden"  id="hdnNameSeq" value="' + NameSeq + '" />';
                    var hdnFamilySeq = '<input type="hidden"  id="hdnFamilySeq" value="' + FamilySeq + '" />';
                    var tdDrug = $('<td/>').html('<input type="text" id="txtDrugName" class="Txtboxsmall" value="' + DrugName + '" />' + hdnNameSeq + hdnFamilySeq);
                    var ddlSensitivity = $('<select id="ddlSensitivity" />');
                    ddlSensitivity.addClass('ddl');
                    $('<option />', { value: '0', text: vSelect }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Sensitive', text: vSensitive }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Intermediate', text: vIntermediate }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Resistant', text: vResistant }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Susceptible', text: vSusceptible }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Susceptible- Dose dependent', text: vSusDD }).appendTo(ddlSensitivity);
                    $('<option />', { value: '-', text: '-' }).appendTo(ddlSensitivity); 
                    $('<option />', { value: '+', text: '+' }).appendTo(ddlSensitivity);
                    $('<option />', { value: '++', text: '++' }).appendTo(ddlSensitivity);
                    $('<option />', { value: '+++', text: '+++' }).appendTo(ddlSensitivity);
                    $('<option />', { value: '++++', text: '++++' }).appendTo(ddlSensitivity);
                    $('<option />', { value: '+++++', text: '+++++' }).appendTo(ddlSensitivity);
                    $('<option />', { value: 'Nil', text: 'Nil' }).appendTo(ddlSensitivity);
                    var tdSensitivity = $('<td/>').html(ddlSensitivity);

                    var txtZone = '<input type="text" id="txtZone" class="Txtboxverysmall" value="' + Zone + '" />';
                    var tdZone = $('<td />').html(txtZone);
                    var lnkDelete = '<input id="btnDelete"  value=' + vdelete + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="return onDeleteDrugDetails(this);" />';
                    var tdDelete = $('<td/>').html(lnkDelete);
                    row$.append(tdDrug).append(tdSensitivity).append(tdZone).append(tdDelete);
                    tbody$.append(row$);
                });
                table$.append(tbody$);
                $(divTag).html(table$);
                $(divTag).appendTo($(divTagTemp));
                var rowCount = 0;
                var isOddNumber = isOdd(GetOrganismCount(hdnOrganismCount));
                var trOrganism = '';
                var tdOrganism = '';
                if (isOddNumber) {
                    if (parseInt(document.getElementById(hdnOrganismCount).value) > 1) {
                        rowCount = document.getElementById(divTblOrgans).rows.length;
                    }
                    trOrganism = document.getElementById(divTblOrgans).insertRow(rowCount);
                    tdOrganism = trOrganism.insertCell(0);
                }
                else {
                    rowCount = document.getElementById(divTblOrgans).rows.length - 1;
                    trOrganism = document.getElementById(divTblOrgans).rows[rowCount];
                    tdOrganism = trOrganism.insertCell(1);
                }
                tdOrganism.setAttribute("style", "width:50%");
                tdOrganism.setAttribute("valign", "top");
                tdOrganism.innerHTML = $(divTagTemp).html();
                document.getElementById(txtOtherOrganism).value = '';
                document.getElementById(divOtherOrganism).style.display = 'none';
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function SaveOrganismDrugPatternDetails(hdnInvID, ctrlClientID) {
        try {
            var lstOrganisums = [];
            var familyName = '';
            var organName = '';
            var divColumnID = "divColumnChart" + hdnInvID;
            $('div[id^="' + divColumnID + '"]').children().each(function() {
                $(this).children('thead').children().each(function(i, n) {
                    var $header = $(n);
                    if ($header.children().length == 1) {
                        organName = $header.find($('span[id$="spanOrganName"]')).html();
                        return false;
                    }
                });
                $(this).children('tbody').children().each(function(i, n) {
                    var $row = $(n);
                    if ($row.children().length == 1) {
                        familyName = $row.find($('span[id$="spanFamily"]')).html();
                    }
                    else {
                        //                        var drugName = $row.find($('span[id$="spanDrugName"]')).html();
                        var sensitivity = $row.find($('select[id$="ddlSensitivity"]')).val();
                        var drugName = $row.find($('input[id$="txtDrugName"]')).val();
                        //                        var sensitivity = $row.find($('input[id$="txtSensitivity"]')).val();
                        if (sensitivity == '0') {
                            sensitivity = '';
                        }
                        var zone = "";
                        var ddlZone = $row.find($('select[id$="ddlmic"]')).val();
                        var txtZone = $row.find($('input[id$="txtZone"]')).val();
                        if (((ddlZone) != undefined) && (ddlZone != 0)) {
                            zone = ddlZone;
                        }
                        else if (txtZone != undefined) {
                            zone = txtZone;
                        }
                        else {
                            zone = "";
                        }
                        var nameSeq = $row.find($('input[id$="hdnNameSeq"]')).val();
                        var familySeq = $row.find($('input[id$="hdnFamilySeq"]')).val();
                        lstOrganisums.push({
                            OrganName: organName,
                            DrugName: drugName,
                            NameSeq: nameSeq,
                            Sensitivity: sensitivity,
                            Zone: zone,
                            Family: familyName,
                            FamilySeq: familySeq
                        });
                    }
                });
            });
            if (lstOrganisums.length > 0) {
                document.getElementById(ctrlClientID + "_hdnLstOrganisums").value = JSON.stringify(lstOrganisums);
            }
            else {
                document.getElementById(ctrlClientID + "_hdnLstOrganisums").value = "";
            }
        }
        catch (e) {
            return false;
        }
        return true;
    }
    function ShowHideOtherOrganism(ddlOrganism, divOtherOrganism, txtOtherOrganism) {

        try {
            var ddlOrganismID = document.getElementById(ddlOrganism);
            var organName = ddlOrganismID.options[ddlOrganismID.selectedIndex].value;
            document.getElementById(txtOtherOrganism).value = '';
            if (organName == "Other") {
                document.getElementById(divOtherOrganism).style.display = 'block';
            }
            else {
                document.getElementById(divOtherOrganism).style.display = 'none';
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
</script>

<div>
    <table class="w-95p">
        <tr>
            <td>
                <table class="w-100p">
                    <tr>
                        <td class="font11 h-20 w-19p" id="tdInvName" runat="server" style="font-weight: normal;
                            color: #000; display: table-cell;">
                            <asp:Label ID="lblName" runat="server" Font-Bold="True" 
                                meta:resourcekey="lblNameResource1"></asp:Label>
                            <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="Red" OnClick="lnkEdit_Click"
                                Text="Edit" Visible="False" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                            <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                            <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                                visible="false"><u>
                                    <%=Resources.Investigation_ClientDisplay.Investigation_MicroPattern_ascx_01 %></u></a>
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <span class="richcombobox" style="width: 200px;">
                                            <asp:DropDownList ForeColor="Black" ID="ddlGrowthOrganisms" runat="server" 
                                            CssClass="ddlsmall" meta:resourcekey="ddlGrowthOrganismsResource1">
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                    <td>
                                        <asp:Button runat="server" ID="btnOrgADD" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                            onmouseout="this.className='btn'" Width="50px" Height="25px" 
                                            meta:resourcekey="btnOrgADDResource1" />
                                    </td>
                                </tr>
                            </table>
                            <div class="paddingT10" id="divOtherOrganism" runat="server" style="display: none;">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOtherOrganismName" Text="Name" runat="server" 
                                                meta:resourcekey="lblOtherOrganismNameResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOtherOrganism" runat="server" CssClass="small" 
                                                meta:resourcekey="txtOtherOrganismResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                        <td>
                            <table class="w-100p">
                                <tr>
                                    <td class="font10 h-50 w-20p" style="font-weight: normal; color: #000;">
                                        <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                            meta:resourcekey="ddlstatusResource1">
                                            <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td class="font10 h-10" style="font-weight: normal; color: #000;">
                                        <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblReason" Text="Reason" runat="server" 
                                                        meta:resourcekey="lblReasonResource1"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblOpinionUser" runat="server" Text="User" 
                                                        meta:resourcekey="lblOpinionUserResource1" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                        CssClass="ddlsmall" onmousedown="expandDropDownList(this);" 
                                                        onblur="collapseDropDownList(this);" 
                                                        meta:resourcekey="ddlStatusReasonResource1">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                            <tr>
                                                <td>
                                                    <span class="richcombobox w-100">
                                                        <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                            CssClass="ddlsmall" meta:resourcekey="ddlOpinionUserResource1">
                                                            <asp:ListItem Text="--Select--" meta:resourcekey="OpinionUserListItemResource1"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlenabled" runat="server" CssClass="w-100p" 
                    meta:resourcekey="pnlenabledResource1">
                    <table class="w-100p">
                        <tr>
                            <td class="font11 h-20" colspan="2" style="font-weight: normal; color: #000;">
                                <table id="divTblOrgans" runat="server">
                                </table>
                                <%--<div id="divTblOrgans" class="divTable">
                                    <div id="divRowChart" class="divRow" runat="server">
                                    </div>
                                </div>--%>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </td>
        </tr>
    </table>
    <asp:HiddenField runat="server" ID="hidVal" Value="0" />
    <asp:HiddenField runat="server" ID="hdnOrganismCount" Value="0" />
    <asp:HiddenField runat="server" ID="hdnLstOrganisums" Value="" />
    <asp:HiddenField runat="server" ID="hdnInvestigationID" Value="0" />
    <asp:HiddenField runat="server" ID="hdnInvestigationList" Value="0" />
    <input id="hdnstatusreason" runat="server" type="hidden" value="" />
    <input id="hdnOpinionUser" runat="server" type="hidden" value="" />
</div>
