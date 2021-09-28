<%@ Control Language="C#" AutoEventWireup="true" CodeFile="CultureandSensitivityReportV2.ascx.cs"
    Inherits="Investigation_CultureandSensitivityReportV2" %>
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
        width: 33%;
        padding-bottom: 15px;
    }
    .divColumn td, .divColumn th
    {
        border: 1px solid #000;
    }
</style>
<%--<script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

<script src="../Scripts/JsonScript.js" language="javascript" type="text/javascript"></script>

<script language="javascript" type="text/javascript">
    //    var ddlStainType = '<%=ddlStainType.ClientID %>';
    //    var ddlGrowthOrganisms = '<%=ddlGrowthOrganisms.ClientID %>';
    //    var txtStainResult = '<%=txtStainResult.ClientID %>';
    var divRowChart = '<%=divRowChart.ClientID %>';
    var hdnLstStainResult = '<%=hdnLstStainResult.ClientID %>';
    var hdnLstOrganisums = '<%=hdnLstOrganisums.ClientID %>';
    //    var hdnInvestigationID = '<%=hdnInvestigationID.ClientID %>';

    function AddStainResult(ddlStainType, txtStainResult, tblStainResult, divTblStainResult) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vSelectStain = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_01') == null ? "Select stain type\n" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_01');
        var vEnterStain = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_02') == null ? "Enter stain result\n" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_02');
        var vdelete = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_10') == null ? "Delete" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_10');
        try {
            var ddlStainTypeID = document.getElementById(ddlStainType);
            var selectedStainType = ddlStainTypeID.options[ddlStainTypeID.selectedIndex].text;
            var selectedStainResult = $.trim(document.getElementById(txtStainResult).value);
            var message = '';
            var isRequiredMissing = false;
            var value = 0;

            if (ddlStainTypeID.selectedIndex == 0) {
                message += vSelectStain;
                isRequiredMissing = true;
            }
            if (selectedStainResult == '') {
                message += vEnterStain;
                isRequiredMissing = true;
            }
            if (!isRequiredMissing) {
                var table = document.getElementById(tblStainResult);
                var row = table.insertRow(1);
                var tdStainType = row.insertCell(0);
                tdStainType.innerHTML = selectedStainType;
                var tdStainResult = row.insertCell(1);
                tdStainResult.innerHTML = selectedStainResult;
                var tdDelete = row.insertCell(2);
                tdDelete.innerHTML = '<input id="btnDeleteStainResult" value=' + vdelete + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteStainResult(this);" />';
                document.getElementById(divTblStainResult).style.display = 'block';
                document.getElementById(ddlStainType).selectedIndex = 0;
                document.getElementById(txtStainResult).value = '';
            }
            else {
                //alert(message);
                ValidationWindow(message, AlertType);
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function load_xml(msg) {
        if (typeof msg != 'string') {
            if (window.DOMParser)//Firefox
            {
                parser = new DOMParser();
                data = parser.parseFromString(text, "text/xml");
            } else { // Internet Explorer
                data = new ActiveXObject("Microsoft.XMLDOM");
                data.async = "false";
                data.loadXML(msg);
            }
        } else {
            data = msg;
        }
        return data;
    }
    function LoadAllStainResult(stainXML, tblStainResult, divTblStainResult) {
        try {
            var vdelete = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_10') == null ? "Delete" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_10');
            var StainXMLData = load_xml(stainXML);
            var table = document.getElementById(tblStainResult);
            $(StainXMLData).find('Stain').each(function() {
                var stainType = '';
                if (typeof ($(this).attr('Type')) != 'undefined') {
                    stainType = $(this).attr('Type');
                }
                var stainResult = '';
                if (typeof ($(this).attr('Result')) != 'undefined') {
                    stainResult = $(this).attr('Result');
                }
                var row = table.insertRow(-1);
                var tdStainType = row.insertCell(0);
                tdStainType.innerHTML = stainType;
                var tdStainResult = row.insertCell(1);
                tdStainResult.innerHTML = stainResult;
                var tdDelete = row.insertCell(2);
                tdDelete.innerHTML = '<input id="btnDeleteStainResult" value=' + vdelete + ' type="button" style="background-color: Transparent; color: Blue; border-style: none; text-decoration: underline; cursor: pointer; font-size: 11px;" onclick="onDeleteStainResult(this);" />';
                document.getElementById(divTblStainResult).style.display = 'block';
            });
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteStainResult(obj) {
        try {
            $(obj).closest('tr').remove();
            if ($('tr', $(obj).closest('table').find('tbody')).length <= 1) {
                $(obj).closest('table').closest('div').hide();
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onDeleteOrganismDetails(obj) {
        var vValidate = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_aspx_03') == null ? "Are you sure you want to delete this organism details?" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_aspx_03');

        try {
            if (confirm(vValidate)) {
                $(obj).closest('table').closest('div').remove();
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function onChangeOrganismDropDown(ddlGrowthOrganisms, hdnInvestigationID, divRowChart) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vSelectedOrganism = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_aspx_04') == null ? "Selected organism details already added" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_aspx_04');
        
        try {
            var ddlGrowthOrganismsID = document.getElementById(ddlGrowthOrganisms);
            var hdnInvID = document.getElementById(hdnInvestigationID).value;
            if (ddlGrowthOrganismsID.selectedIndex > 0) {
                var organismName = ddlGrowthOrganismsID.options[ddlGrowthOrganismsID.selectedIndex].text;
                var organismXML = ddlGrowthOrganismsID.options[ddlGrowthOrganismsID.selectedIndex].value;
                if ($("#divColumnChart" + hdnInvID + organismName).length <= 0) {
                    LoadXMLDrugList(organismName, organismXML, hdnInvestigationID, divRowChart);
                    ddlGrowthOrganismsID.selectedIndex = 0;
                }
                else {
                    //alert("Selected organism details already added");
                    ValidationWindow(vSelectedOrganism, AlertType);
                    return false;
                }
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function LoadXMLDrugList(organismName, resultXML, hdnInvestigationID, divRowChart) {
        var AlertType = SListForAppMsg.Get("Investigation_Header_Alert") == null ? "Alert" : SListForAppMsg.Get("Investigation_Header_Alert");
        var vSelectedOrganism = SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_04") == null ? "Selected organism details already added" : SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_04");
        var vColonyCount = SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_06") == null ? "Colony Count:" : SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_06");
        var vDrugName = SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_07") == null ? "Drug Name" : SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_07");
        var vSensitivity = SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_08") == null ? "Sensitivity" : SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_08");
        var vMICVal = SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_09") == null ? "MIC Values (mcg/ml)" : SListForAppMsg.Get("Investigation_CultureandSensitivityReportV2_ascx_09");
        var vSelect = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_11') == null ? "Select" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_11');
        var vSensitive = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_12') == null ? "Sensitive" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_12');
        var vIntermediate = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_13') == null ? "Intermediate" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_13');
        var vResistant = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_14') == null ? "Resistant" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_ascx_14');
        
        try {
            var hdnInvID = document.getElementById(hdnInvestigationID).value;
            var organismXML = $('select[id$="ddlGrowthOrganisms"] option').filter(function() { return $(this).html() == organismName; }).val();
            if ($("#divColumnChart" + hdnInvID + organismName).length <= 0) {
                var divTagTemp = document.createElement('div');
                var divTag = document.createElement('div');
                $(divTag).attr('id', 'divColumnChart' + hdnInvID + organismName);
                $(divTag).addClass("divColumn");
                var table$ = $('<table/>');
                table$.attr('id', hdnInvID + organismName);
                table$.addClass('dataheaderInvCtrl');
                table$.attr('cellpadding', '2').attr('cellspacing', '0');
                var OrganNameRow$ = $('<tr/>');
                var thOrganName = $('<th colspan="3"/>').html('<div style="width:100%;"><div style="width:99%;"><div style="width:90%;float:left;"><span id="spanOrganName" style="font-size:14px;">'
			    + organismName + '</span></div><div style="float:left;"><img href="javascript:void(0);" style="cursor:pointer;" id="imgClose" src="../Images/dialog_close_button.png" onclick="onDeleteOrganismDetails(this);"></img></div></div></div>');
                OrganNameRow$.append(thOrganName);
                var OrganXMLData = $.parseXML(organismXML);
                var ResultXmlData = $.parseXML(resultXML);

                var ColonyCount = "";
                $(ResultXmlData).find("Organ").each(function() {
                    if (typeof ($(this).attr('ColonyCount')) != 'undefined') {
                        ColonyCount = $(this).attr('ColonyCount');
                        return;
                    }
                });

                var OrganNameRow1$ = $('<tr/>');
                var thOrganName1 = $('<th colspan="3"/>').html('<div style="width:100%;"><div style="width:99%;">' +
                '<div style="width:90%;float:left;"><span id="spanCount" style="font-size:14px;">' + vColonyCount + '</span><input id=txtCcount type=text value ="' + ColonyCount + '" /></div><div style="float:left;"></div></div></div>');
                OrganNameRow1$.append(thOrganName1);
                var thead$ = $('<thead/>');
                var tbody$ = $('<tbody/>');
                var headerRow$ = $('<tr/>').css('height', '25px');
                var headerRow1$ = $('<tr/>').css('height', '25px');
                var thDrug = $('<th/>').html(vDrugName);
                var thSensitivity = $('<th/>').html(vSensitivity);
                var thZone = $('<th/>').html(vMICVal);
                headerRow$.append(thDrug).append(thSensitivity).append(thZone);
                thead$.append(OrganNameRow$)
                thead$.append(OrganNameRow1$);
                thead$.append(headerRow$);
                table$.append(thead$);
                var row$ = $('<tr/>').css('height', '25px');

                //                row$.append(OrganNameRow1$);
                //                tbody$.append(row$);

                //                table$.append(tbody$);

                var familyName = '';
                //var jq = jQuery.noConflict();



                $(OrganXMLData).find('Organ').each(function() {
                    var row$ = $('<tr/>').css('height', '25px');
                    var DrugName = '';
                    if (typeof ($(this).attr('DrugName')) != 'undefined') {
                        DrugName = $(this).attr('DrugName');
                    }
                    var Zone = '';
                    var Sensitivity = '';
                    $(ResultXmlData).find("Organ").each(function() {
                        if ($(this).attr('DrugName') == DrugName) {
                            if (typeof ($(this).attr('Zone')) != 'undefined') {
                                Zone = $(this).attr('Zone');
                            }
                            if (typeof ($(this).attr('Sensitivity')) != 'undefined') {
                                Sensitivity = $(this).attr('Sensitivity');
                            }
                            var ColonyCount = "";
                            if (typeof ($(this).attr('ColonyCount')) != 'undefined') {
                                ColonyCount = $(this).attr('ColonyCount');
                            }
                            return;
                        }
                    });
                    var family = $(this).attr('Family');
                    if (typeof (family) != 'undefined' && family != familyName) {
                        var familyNameRow$ = $('<tr/>').css('height', '25px');
                        var tdFamilyName = $('<td colspan="3" align="center" style="font-weight:bold;"/>').html('<span id="spanFamily">' + family + '</span>');
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
                    var tdDrug = $('<td/>').html('<span id="spanDrugName">' + DrugName + '</span>' + hdnNameSeq + hdnFamilySeq);
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
                    ddlSensitivity.val(Sensitivity);
                    var tdSensitivity = $('<td/>').html(ddlSensitivity);


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
                        var txtZone = '<input type="text" id="txtZone" class="Txtboxsmall" value="' + Zone + '" />';
                        tdZone = $('<td/>').html(txtZone);
                    }
                    row$.append(tdDrug).append(tdSensitivity).append(tdZone);
                    tbody$.append(row$);
                });
                table$.append(tbody$);
                $(divTag).html(table$);
                $(divTag).appendTo($(divTagTemp));
                document.getElementById(divRowChart).innerHTML += $(divTagTemp).html();
            }
            else {
                //alert("Selected organism details already added");
                ValidationWindow(vSelectedOrganism, AlertType);
                return false;
            }
        }
        catch (e) {
            return false;
        }
        return false;
    }
    function SaveCultureSensitivityV2Details(hdnInvID, ctrlClientID) {
        try {
            var lstStainResult = [];
            var table = document.getElementById(ctrlClientID + "_tblStainResult");
            var type, result;
            for (var i = 0, row; row = table.rows[i]; i++) {
                if (i > 0) {
                    type = "";
                    result = "";
                    for (var j = 0, col; col = row.cells[j]; j++) {
                        if (j == 0) {
                            type = col.innerText;
                        }
                        if (j == 1) {
                            result = col.innerText;
                        }
                    }
                    lstStainResult.push({
                        StainType: type,
                        StainResult: result
                    });
                }
            }
            var lstOrganisums = [];
            var familyName = '';
            var organName = '';
            var ColonyCount = '';
            var divColumnID = "divColumnChart" + hdnInvID;
            $('div[id^="' + divColumnID + '"]').children().each(function() {
                $(this).children('thead').children().each(function(i, n) {
                    var $header = $(n);
                    if ($header.find($('span[id$="spanOrganName"]')).length == 1) {
                        //if ($header.children().length == 1) {
                        organName = $header.find($('span[id$="spanOrganName"]')).html();
                        //organName = $header.find($('span[id$="spanCount"]')).html();
                        //return false;
                    }
                    else if ($header.find($('input[id$="txtCcount"]')).length == 1) {
                        //else if ($header.children().length == 2) {
                        //organName = $header.find($('span[id$="spanOrganName"]')).html();
                        ColonyCount = $header.find($('input[id$="txtCcount"]')).val();
                        //return false;
                    }
                });
                $(this).children('tbody').children().each(function(i, n) {
                    var $row = $(n);
                    if ($row.children().length == 1) {
                        familyName = $row.find($('span[id$="spanFamily"]')).html();
                    }
                    else {
                        var drugName = $row.find($('span[id$="spanDrugName"]')).html();
                        var sensitivity = $row.find($('select[id$="ddlSensitivity"]')).val();
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
                            FamilySeq: familySeq,
                            ColonyCount: ColonyCount
                        });
                    }
                });
            });
            if (lstStainResult.length > 0) {
                document.getElementById(ctrlClientID + "_hdnLstStainResult").value = JSON.stringify(lstStainResult);
            }
            else {
                document.getElementById(ctrlClientID + "_hdnLstStainResult").value = "";
            }
            if (lstOrganisums.length > 0) {
                document.getElementById(ctrlClientID + "_hdnLstOrganisums").value = JSON.stringify(lstOrganisums);
            }
            else {
                document.getElementById(ctrlClientID + "_hdnLstOrganisums").value = "";
            }

            //var status = document.getElementById("ddlstatus")

            var InvStatus = $("#" + ctrlClientID + "_ddlstatus").val().split('_');
            var SelectedStatus = $("#" + ctrlClientID + "_ddlstatus option:selected").text();
            var InvMedicalRemarks = $("#" + ctrlClientID + "_txtMedRemarks").val().trim();

            document.getElementById(ctrlClientID + "_hdnStaus").value = InvStatus[0];
            document.getElementById(ctrlClientID + "_hdnDisplaystatus").value = SelectedStatus;
            document.getElementById(ctrlClientID + "_hdnMedicalRemarks").value = InvMedicalRemarks;

        }
        catch (e) {
            return false;
        }
        return true;
    }
    function onFocusStainResult(txtStainResult) {
        var AlertType = SListForAppMsg.Get('Investigation_Header_Alert') == null ? "Alert" : SListForAppMsg.Get('Investigation_Header_Alert');
        var vAdd = SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_aspx_05') == null ? "Add stain result" : SListForAppMsg.Get('Investigation_CultureandSensitivityReportV2_aspx_05');

        try {
            var txtStain = document.getElementById(txtStainResult).value;
            if (txtStain =! '') {
                //alert("Add stain result");
                ValidationWindow(vAdd, AlertType);
            }
            return false;
        }
        catch (e) {
            return false;
        }
    }
    function onChangeStainType(ddlStainType, hdnInvestigationID, ACEStainResult, divstaintype) {

        try {
            var ddlStainTypeID = document.getElementById(ddlStainType);
            var invID = document.getElementById(hdnInvestigationID).value;
            $find(ACEStainResult).set_contextKey(invID + '~' + ddlStainTypeID.options[ddlStainTypeID.selectedIndex].text);
            var ddlStainname = ddlStainTypeID.options[ddlStainTypeID.selectedIndex].value;
            if (ddlStainname == "Other") {
                document.getElementById(divstaintype).style.display = 'block';

            }
            else {
                document.getElementById(divstaintype).style.display = 'none';
            }
            return false;
        }
        catch (e) {
            return false;
        }
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
            <td class="a-center font12 style1" style="font-weight: normal; color: #000;">
                &nbsp;
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblName" runat="server" Font-Bold="True" 
                    meta:resourcekey="lblNameResource1"></asp:Label>
                <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="Red" OnClick="lnkEdit_Click"
                    Text="Edit" Visible="False" meta:resourcekey="lnkEditResource1"></asp:LinkButton>
                <asp:HiddenField ID="hdnReadonly" runat="server" Value="False" />
                <a id="ATag" runat="server" onclick="lnkEdit_OnClientClick(this.id);" style="color: red;"
                    visible="false"><u><%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReport_aspx_08 %></u></a>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Panel ID="pnlenabled" runat="server" CssClass="w-100p" 
                    meta:resourcekey="pnlenabledResource1">
                    <table class="w-100p">
                        <tr>
                            <td class="h-20 w-17p font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblReportStatus" runat="server" Text="Report Status" 
                                    meta:resourcekey="lblReportStatusResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20 w-83p" style="font-weight: normal; color: #000;">
                                <span class="richcombobox" style="width: 200px;">
                                    <asp:DropDownList ForeColor="Black" ID="ddlData" runat="server" 
                                    CssClass="ddlsmall" meta:resourcekey="ddlDataResource1">
                                    </asp:DropDownList>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td class="w-11 h-20" style="font-weight: normal; color: #000;">
                                <asp:Label runat="server" ID="lblSpecimen" Text="Specimen" 
                                    meta:resourcekey="lblSpecimenResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" ID="txtSpecimen" runat="server" CssClass="small" 
                                    meta:resourcekey="txtSpecimenResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="ACESpecimen" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtSpecimen" ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblClinicalHistory" runat="server" Text="Clinical History" 
                                    meta:resourcekey="lblClinicalHistoryResource1"></asp:Label>
                            </td>
                            <td class="font11" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" ID="txtClinicalHistory" runat="server" TextMode="MultiLine"
                                    CssClass="small" meta:resourcekey="txtClinicalHistoryResource1"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:Label runat="server" ID="lblGross" Text="Gross" 
                                    meta:resourcekey="lblGrossResource1"></asp:Label>
                            </td>
                            <td class="font11 h-20" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" ID="txtGross" runat="server" CssClass="small" 
                                    meta:resourcekey="txtGrossResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="ACEGross" MinimumPrefixLength="2" runat="server" TargetControlID="txtGross"
                                    ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx" EnableCaching="False"
                                    CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                    Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" class="bold font11 v-top" style="color: #000;">
                                <asp:Label ID="lblMicroscopy" runat="server" Text="Microscopy" 
                                    meta:resourcekey="lblMicroscopyResource1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblStainType" runat="server" Text="Stain Type" 
                                    meta:resourcekey="lblStainTypeResource1"></asp:Label>
                            </td>
                            <td class="a-left font11" style="font-weight: normal; color: #000;">
                                <table>
                                    <tr>
                                        <td>
                                            <span class="richcombobox" style="width: 200px;">
                                                <asp:DropDownList ForeColor="Black" ID="ddlStainType" runat="server" 
                                                CssClass="ddlsmall" meta:resourcekey="ddlStainTypeResource1">
                                                </asp:DropDownList>
                                            </span>
                                            <div id="divstaintype" runat="server" style="display: none;">
                                                <asp:TextBox ID="txtOtherstaintype" runat="server" CssClass="small" 
                                                    meta:resourcekey="txtOtherstaintypeResource1" />
                                            </div>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td class="font11" style="font-weight: normal; color: #000;">
                                            <asp:Label ID="lblStainResult" runat="server" Text="Result" 
                                                meta:resourcekey="lblStainResultResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ForeColor="Black" runat="server" ID="txtStainResult" 
                                                CssClass="small" meta:resourcekey="txtStainResultResource1"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="ACEStainResult" MinimumPrefixLength="2" runat="server"
                                                TargetControlID="txtStainResult" ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx"
                                                EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                DelimiterCharacters=";,:" Enabled="True" UseContextKey="True">
                                            </ajc:AutoCompleteExtender>
                                            <asp:Button runat="server" ID="btnAddStain" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" 
                                                meta:resourcekey="btnAddStainResource1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td class="font11 h-20" colspan="2" style="font-weight: normal; color: #000;">
                                <div id="divTblStainResult" runat="server" style="display: none;">
                                    <table id='tblStainResult' runat="server" class="dataheaderInvCtrl w-100p">
                                        <thead>
                                        <tr runat="server" class="colorforcontent h-20">
                                            <th runat="server" class="bold h-8 font11" style="color: White;">
                                                    <asp:Label ID="thStainType" runat="server" Text="Stain Type" meta:resourcekey="lblStainTypeResource1"></asp:Label>
                                            </th>
                                            <th runat="server" class="bold h-8 font11" style="color: White;">
                                                    <asp:Label ID="thStainResult" runat="server" Text="Result" meta:resourcekey="lblStainResultResource1"></asp:Label>
                                            </th>
                                            <th runat="server" class="bold h-8 font11 w-10p" style="color: White;">
                                                    <asp:Label ID="thStainAction" runat="server" Text="Action" meta:resourcekey="thStainActionResource1"></asp:Label>
                                            </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class=" h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:Label runat="server" ID="lblCulture" Text="Culture" 
                                    meta:resourcekey="lblCultureResource1"></asp:Label>
                            </td>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" ID="txtCulture" runat="server" CssClass="small" 
                                    meta:resourcekey="txtCultureResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="ACECulture" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtCulture" ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="a-left h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblGrowthOrganisms" runat="server" Text="Growth & Organisms" 
                                    meta:resourcekey="lblGrowthOrganismsResource1"></asp:Label>
                            </td>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <span class="richcombobox" style="width: 200px;">
                                    <asp:DropDownList ForeColor="Black" ID="ddlGrowthOrganisms" runat="server" 
                                    CssClass="ddlsmall" meta:resourcekey="ddlGrowthOrganismsResource1">
                                    </asp:DropDownList>
                                </span>
                                <asp:Button runat="server" ID="btnOrgADD" Text="Add" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" meta:resourcekey="btnOrgADDResource1" />
                                <div id="divOtherOrganism" runat="server" style="display: none;">
                                    <asp:TextBox ID="txtOtherOrganism" runat="server" CssClass="small" 
                                        meta:resourcekey="txtOtherOrganismResource1" />
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:Label runat="server" ID="lblResistanceDetected" 
                                    Text="Resistance Mechanism Detected" 
                                    meta:resourcekey="lblResistanceDetectedResource1"></asp:Label>
                            </td>
                            <td class=" h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" ID="txtResistanceDetected" runat="server" 
                                    CssClass="small" meta:resourcekey="txtResistanceDetectedResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="ACEResistanceDetected" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtResistanceDetected" ServiceMethod="GetInvestigationBulkData"
                                    ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="0"
                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" DelimiterCharacters=";,:"
                                    Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:Label runat="server" ID="lblColonyCount" Text="Colony Count" 
                                    meta:resourcekey="lblColonyCountResource1"></asp:Label>
                            </td>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" ID="txtColonyCount" runat="server" 
                                    CssClass="small" meta:resourcekey="txtColonyCountResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="ACEColonyCount" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtColonyCount" ServiceMethod="GetInvestigationBulkData" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" UseContextKey="True">
                                </ajc:AutoCompleteExtender>
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20 font11" colspan="2" style="font-weight: normal; color: #000;">
                                <div id="divTblOrgans" class="divTable">
                                    <div id="divRowChart" class="divRow" runat="server">
                                    </div>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td class=" h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="Rs_Comments" Text="Technical Remarks" runat="server" 
                                    meta:resourcekey="Rs_CommentsResource1"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ForeColor="Black" runat="server" ID="txtReason" TextMode="MultiLine"
                                    CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender1" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtReason" ServiceMethod="GetInvRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="SelectedRemarks">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnRemarksID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:Label ID="lblMedRemarks" Text="Medical Remarks" runat="server" 
                                    meta:resourcekey="lblMedRemarksResource1"></asp:Label>
                                <br />
                                <asp:Label ID="lblonreport" Text="(On Report)" Font-Bold="True" ForeColor="Brown"
                                    runat="server" meta:resourcekey="lblonreportResource1"></asp:Label>
                            </td>
                            <td class=" h-20 font11" style="font-weight: normal; color: #000;">
                                <asp:TextBox ForeColor="Black" runat="server" ID="txtMedRemarks" TabIndex="-1" TextMode="MultiLine"
                                    CssClass="small" meta:resourcekey="txtReasonResource1"></asp:TextBox>
                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender2" MinimumPrefixLength="2" runat="server"
                                    TargetControlID="txtMedRemarks" ServiceMethod="GetInvMedicalRemarks" ServicePath="~/WebService.asmx"
                                    EnableCaching="False" CompletionInterval="2" CompletionListCssClass="wordWheel listMain .box"
                                    CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                    DelimiterCharacters=";,:" Enabled="True" OnClientItemSelected="GetInvMedicalRemarks">
                                </ajc:AutoCompleteExtender>
                                <asp:HiddenField ID="hdnMedicalRemarksID" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td class="h-20 font11" style="font-weight: normal; color: #000;">
                                <%=Resources.Investigation_ClientDisplay.Investigation_CultureandSensitivityReportV1_aspx_03%>
                            </td>
                            <td>
                                <table class="w-100p">
                                    <tr>
                                        <td class="h-50 font10 w-20p" style="font-weight: normal; color: #000;">
                                            <asp:DropDownList ForeColor="Black" ID="ddlstatus" runat="server" TabIndex="-1" CssClass="ddlsmall"
                                                meta:resourcekey="ddlstatusResource1">
                                                <asp:ListItem Text="Completed" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td class=" h-10 font10" style="font-weight: normal; color: #000;">
                                            <table id="tdInvStatusReason1" runat="server" style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="lblReason" Text="Reason" runat="server"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdInvStatusOpinion1" runat="server" style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:Label ID="lblOpinionUser" runat="server" Text="User" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td>
                                            <table id="tdInvStatusReason2" runat="server" style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <asp:DropDownList ForeColor="Black" ID="ddlStatusReason" runat="server" TabIndex="-1"
                                                            CssClass="ddlsmall" onmousedown="expandDropDownList(this);" onblur="collapseDropDownList(this);">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdInvStatusOpinion2" runat="server" style="display: none;">
                                                <tr runat="server">
                                                    <td runat="server">
                                                        <span class="richcombobox" class="w-100">
                                                            <asp:DropDownList ForeColor="Black" ID="ddlOpinionUser" runat="server" TabIndex="-1"
                                                                CssClass="ddlsmall">
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
                </asp:Panel>
            </td>
        </tr>
        <tr>
            <td>
                <input type="hidden" id="hresistantto" value="" class="w-100p" runat="server" />
                <input type="hidden" id="drugname" value="" class="w-100p" runat="server" />
                <asp:Label ID="lblraw" runat="server" Font-Bold="False" 
                    meta:resourcekey="lblrawResource1"></asp:Label>
            </td>
        </tr>
        <asp:HiddenField runat="server" ID="hidVal" />
        <asp:HiddenField runat="server" ID="hdnLstStainResult" Value="" />
        <asp:HiddenField runat="server" ID="hdnLstOrganisums" Value="" />
        <asp:HiddenField runat="server" ID="hdnInvestigationID" Value="0" />
        <asp:HiddenField runat="server" ID="hdnInvestigationList" Value="0" />
        <asp:HiddenField runat="server" ID="hdnStaus" Value="0" />
        <asp:HiddenField runat="server" ID="hdnDisplaystatus" Value="0" />
        <asp:HiddenField runat="server" ID="hdnMedicalRemarks" Value="0" />
        <asp:HiddenField runat="server" ID="hdnInvestigationName" Value="0" />
        <input id="hdnOpinionUser" runat="server" type="hidden" value="" />
        <asp:HiddenField ID="hdnAccessionNumber" runat="server" Value="" />
        <%--<asp:HiddenField ID="hdnInvestigationName" runat="server" Value="" />--%>
        
    </table>
</div>
<style type="text/css">
    .list2
    {
        width: 110px;
        border: 1px solid DarkGray;
        list-style-type: none;
        margin: 0px;
        background-color: #fff;
        text-align: left;
        font-weight: normal;
        vertical-align: middle;
        color: Gray;
        font-family: Verdana;
        font-size: 11px;
    }
    ul.list2 li
    {
        padding: 0px 0px;
    }
    .listitem2
    {
        color: Gray;
    }
    .hoverlistitem2
    {
        background-color: #fff;
    }
    .listMain
    {
        background-color: #fff;
        width: 150px;
        max-height: 150px;
        text-align: left;
        list-style: none;
        margin-top: -1px;
        font-weight: normal;
        font-size: 12px;
        overflow: auto;
        padding-left: 1px;
    }
    .wordWheel .itemsMain
    {
        background: none;
        width: 150px;
        border-collapse: collapse;
        color: #383838;
        white-space: nowrap;
        text-align: left;
        font-weight: normal;
        font-size: 12px;
    }
    .wordWheel .itemsSelected
    {
        width: 150px;
        color: #ffffff;
        background: #;
    }
    .style1
    {
        width: 10%;
    }
    .style2
    {
        width: 3%;
        height: 20px;
    }
    .style3
    {
        height: 20px;
    }
    .wordWheel .itemsSelected3
    {
        width: 350px;
        color: #ffffff;
        background: #2c88b1;
        white-space: pre-wrap;
    }
    .listMain
    {
        background-color: #fff;
        width: 350px;
        max-height: 150px;
        text-align: left;
        list-style: none;
        margin-top: -1px;
        font-family: Verdana;
        font-size: 11px;
        overflow: auto;
        padding-left: 1px;
        scrollbar-base-color: pink;
        scrollbar-arrow-color: #469bd0; /* #000000;*/
        scrollbar-3dlight-color: #ffffff; /* #e9eef0;*/
        scrollbar-darkshadow-color: black; /* #909699;*/
        scrollbar-face-color: #dddcdc; /*#cfd0d1;*/
        scrollbar-highlight-color: #909699;
        scrollbar-shadow-color: #fff; /* #cfd0d1;*/
        scrollbar-track-color: #73b5de; /*#89c2e5;  */
    }
</style>
