<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddManufacturer.ascx.cs"
    Inherits="CommonControls_AddManufacturer" %>

<%--<style type="text/css">
    #tablePagination
    {
        background-color: Transparent;
        font-size: 0.8em;
        padding: 0px 5px;
        height: 20px;
    }
    #tablePagination_paginater
    {
        margin-left: auto;
        margin-right: auto;
    }
    #tablePagination img
    {
        padding: 0px 2px;
    }
    #tablePagination_perPage
    {
        float: left;
    }
    #tablePagination_paginater
    {
        float: right;
    }
    .LOP_Btm_PageNat
    {
        color: #40657F;
        margin-left: -4px;
        float: left;
        margin-top: 10px;
        width: 1300px;
    }
</style>--%>

<script type="text/javascript" language="javascript">
    var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
    var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
</script>
<script type="text/javascript" language="javascript">
    var userMsg;
    $(document).ready(function() {
        
        //GetGenericList(1);
        GetMfgList(1);
        $('input[id$=txtAddMfgPhone]').keydown(function(event) {
            return isNumerc(event, "");
        });
    });

    function isNumerc(e, Id) {

        var key = 0;
        var isCtrl = false;


        key = e.keyCode;
        if (e.shiftKey == true) {
            isCtrl = false;
        }
        else {
            if ((key >= 48 && key <= 57) || (key >= 96 && key <= 105) || (key == 110) || (key == 8) || (key == 9) || (key == 12) || (key == 27) || (key == 37) || (key == 39) || (key == 46) || (key == 190)) {
                isCtrl = true;
            }
            else {
                //if ((key >= 185 && key <= 192) || (key >= 218 && key <= 222))
                isCtrl = false;
            }
        }
        return isCtrl;
    }

    function btnMfgSaveClick() {
        var TableData = tableToMfgData();

        var Parameters = { lstMfg: TableData };
        try {
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/Webservice/InventoryMaster.asmx/SaveManufacturer",
                data: JSON.stringify(Parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    if (data.d != null) {

                        GenerateMfgTable(data.d.lstManufacturer);
                        if (data.d.RecordCount != 0) {
                            createMfgPager(data.d.RecordCount, $('div[id*=divMfgPager]'));
                            $('div[id*=divMfgPager]').show();
                        }
                        else {
                            $('div[id*=divMfgPager]').hide();
                        }
                        userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_01') == null ? "Saved Successfully" : SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_01');
                        var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
                        ValidationWindow(userMsg, Information);
                        $('input[id*=btnSaveMfgList]').hide();
                    }
                },
                failure: function(xhr, ajaxOptions, thrownError) {
                ValidationWindow(xhr.status,errorMsg);
                }
            });
            
        }
        catch (e) {
            return false;
        }


    }

    function GetMfgList(_PageNumber) {
        var Searchname = $('input[id*=txtSearchMfgName]').val();
        var Parameters = { PageNum: _PageNumber, MfgName: Searchname };
        try {
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/Webservice/InventoryMaster.asmx/GetManufacturerForUpdate",
                data: JSON.stringify(Parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    totalMfgCount = data.d.RecordCount;
                    GenerateMfgTable(data.d.lstManufacturer);

                },
                failure: function(xhr, ajaxOptions, thrownError) {
                ValidationWindow(xhr.status,errorMsg);
                }
            });
        }
        catch (e) {
            return false;
        }

    }
    function GenerateMfgTable(data) {   
//        $('#btnSaveMfgList').removeClass().addClass("show");
        //document.getElementById("btnSaveMfgList").style.display = "block";
        var Manufacturername = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_01') == null ? "Manufacturer Name" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_01');
        var Email = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_02') == null ? "Email" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_02');
        var Code = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_10') == null ? "Code" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_10');
        var Phone = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_03') == null ? "Phone" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_03');
        var Action = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_04') == null ? "Action" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_04');
        //$('input [id*=btnSaveMfgList]').hide();
        var Header = "<table id='tblMfgNameList' class='responstable w-100p dataheaderInvCtrl' >"
        Header += "<tr class='responstableHeader lh20'><td>" + Manufacturername + "</td><td>Code</td><td>" + Email + "</td><td>" + Phone + "</td><td>" + Action + "</td></tr>";
        if (data != null && data != undefined && data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                var Parameters = { MfgID: data[i].MfgID, MfgName: data[i].MfgName, MfgCode: data[i].MfgCode, Phone: data[i].Phone, EMail: data[i].EMail };
                var pAction = "<input id='btnMfgEdit_" + data[i].MfgName + "_" + data[i].MfgID + "' onclick='btnMfgEdit_OnClick(" + JSON.stringify(Parameters) + ");' value = '' type='button' class='ui-icon ui-icon-pencil pointer' ";
               /*Sathish-ManuFactNameforming without space*/
                var ManuFactName = (data[i].MfgName).replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '');
                Header += "<tr id='trMfg_" + ManuFactName + "_" + data[i].MfgID + "'><td><span id='spnMfgName'>" + data[i].MfgName + "</span><input type='hidden' id='hdnMfgID_" + data[i].MfgID + "' value='" + data[i].MfgID + "'></td>"
                //Header += "<tr id='trMfg_" + data[i].MfgName + "_" + data[i].MfgID + "'><td><span id='spnMfgName'>" + data[i].MfgName + "</span><input type='hidden' id='hdnMfgID_" + data[i].MfgID + "' value='" + data[i].MfgID + "'></td>"
                Header += "<td><span id='spnMfgCode'>" + data[i].MfgCode + "</span></td>";
                Header += "<td><span id='spnMfgMail'>" + data[i].EMail + "</span></td>";
                Header += "<td><span id='spnMfgPhone'>" + data[i].Phone + "</span></td>";
                Header += "<td>" + pAction + " </td></tr>";
            }
            Header += "</table>";
            $('div[id*=dvMfgList]').html(Header);
            createMfgPager(totalMfgCount, $('div[id*=divMfgPager]'));
           //$('input[id*=btnSaveMfgList]').show();
        }
        else {
            //$('input[id*=btnSaveMfgList]').hide();
        }
        
        //$('#divLoadingGif').hide();
    }

    function btnMfgEdit_OnClick(name) {
        var Update = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_05') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_05');
        var Edit = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_06') == null ? "Edit" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_06');
        if ($('button[id*=btnAddMfgName]').val() != 'Update') {
            if (name != null && name != undefined) {
                $('input[id*=txtAddMfgName]').val(name.MfgName);
                $('input[id*=txtAddMfgCode]').val(name.MfgCode);
                $('input[id*=txtAddMfgPhone]').val(name.Phone);
                $('input[id*=txtAddMfgMail]').val(name.EMail);
                $('input[id*=hdnEditMfgID').val(name.MfgID);
                $('input[id*=hdnEditMfgName').val(name.MfgName);
                $('input[id*=hdnEditMfgCode').val(name.MfgCode);
                $('input[id*=hdnEditMfgPhone').val(name.Phone);
                $('input[id*=hdnEditMfgMail').val(name.EMail);
                $('input[id*=btnMfgEdit]').val(Edit);
                $('button[id*=btnAddMfgName]').val('Update');
                $('button[id*=btnAddMfgName]').html(Update);
                $('input[id*=btnCancelMfgName]').show();
                /*Sathish-Forming ManuFactIdwithoutSpace*/
                var ManuFactName = (name.MfgName).replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '');
                $('tr[id=trMfg_' + ManuFactName + '_' + name.MfgID + ']').remove();
                // $('tr[id=trMfg_' + name.MfgName + '_' + name.MfgID + ']').remove();
            }
        }
        else {
            userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_02') == null ? "Please update the current item" : SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_02');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
            ValidationWindow(userMsg, errorMsg);
        }
    }

    function btnMfgCancelEdit() {
        var Add = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_07') == null ? "Add" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_07');
        var TableData = tableToMfgData();
        var NewMfgName = $('input[id*=hdnEditMfgName]').val();
        var HdnMfgID = $('input[id*=hdnEditMfgID').val();
        var HdnMfgCode = $('input[id*=hdnEditMfgCode').val();
        var HdnMfgMail = $('input[id*=hdnEditMfgMail').val();
        var HdnMfgPhone = $('input[id*=hdnEditMfgPhone').val();
        var RowData = { MfgName: NewMfgName, MfgID: HdnMfgID, MfgCode: HdnMfgCode, EMail: HdnMfgMail, Phone: HdnMfgPhone };
        TableData.unshift(RowData);
        GenerateMfgTable(TableData);
        $('input[id*=hdnEditMfgName]').val("");
        $('input[id*=hdnEditMfgCode]').val("");
        $('input[id*=hdnEditMfgPhone]').val("");
        $('input[id*=hdnEditMfgMail]').val("");
        $('input[id*=hdnEditMfgID').val("");
        $('button[id*=btnAddMfgName]').val(Add);
        $('input[id*=btnCancelMfgName]').hide();
        $('input[id*=txtAddMfgName]').val("");
        $('input[id*=txtAddMfgCode]').val("");
        $('input[id*=txtAddMfgPhone]').val("");
        $('input[id*=txtAddMfgMail]').val("");
    }

    function btnMfgAddItem() {
        //$('#btnSaveMfgList').removeClass().addClass('btn w-50 show');
        $('input[id*=btnSaveMfgList]').show();
        var Add = SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_07') == null ? "Add" : SListForAppDisplay.Get('InventoryMaster_Controls_AddManufacturer_ascx_07');
        var TableData = tableToMfgData();
        var NewMfgName = $('input[id*=txtAddMfgName]').val();

        if (NewMfgName == "") {
            userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_03') == null ? "Provide manufacturer name" : SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_03');
            ValidationWindow(userMsg, errorMsg);
            return false;
        }

        for (var i = 0; i < TableData.length; i++) {
            if (TableData[i].MfgName == NewMfgName) {
                userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_04') == null ? "Manufacturer name already exists" : SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_04');
                var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
                ValidationWindow(userMsg, errorMsg);
                return false;
            }
        }



        var NewMfgCode = $('input[id*=txtAddMfgCode]').val();
        var NewMfgPhone = $('input[id*=txtAddMfgPhone]').val();
        var NewMfgMail = $('input[id*=txtAddMfgMail]').val();
        if (NewMfgMail != "") {
            if (!echeck(NewMfgMail)) {
                $('input[id*=txtAddMfgMail]').focus();
                return false;
            }
        }
        if ($('[id*=btnAddMfgName]').val() == 'Add') {

            var RowData = { MfgName: NewMfgName, MfgID: '0', MfgCode: NewMfgCode, Phone: NewMfgPhone, EMail: NewMfgMail };
            TableData.unshift(RowData);
        }
        else {

            var HdnMfgID = $('input[id*=hdnEditMfgID').val();

            var RowData = { MfgName: NewMfgName, MfgID: HdnMfgID, MfgCode: NewMfgCode, Phone: NewMfgPhone, EMail: NewMfgMail };
            TableData.unshift(RowData);
            $('Button[id*=btnAddMfgName]').val('Add');
            $('Button[id*=btnAddMfgName]').html(Add);
            $('input[id*=btnCancelMfgName]').hide();
        }
        GenerateMfgTable(TableData);
        $('input[id*=txtAddMfgName]').val("");
        $('input[id*=txtAddMfgCode]').val("");
        $('input[id*=txtAddMfgPhone]').val("");
        $('input[id*=txtAddMfgMail]').val("");
    }

    function tableToMfgData() {

        var TableData = [];
        $('table[id$=tblMfgNameList] tr').each(function() {
            var tr = $(this).closest("tr");
            var MfgName = $(tr).find('span[id$=spnMfgName]') ? $(tr).find('span[id$=spnMfgName]').text() : '';
            var MfgCode = $(tr).find('span[id$=spnMfgCode]') ? $(tr).find('span[id$=spnMfgCode]').text() : '';
            var MfgMail = $(tr).find('span[id$=spnMfgMail]') ? $(tr).find('span[id$=spnMfgMail]').text() : '';
            var MfgPhone = $(tr).find('span[id$=spnMfgPhone]') ? $(tr).find('span[id$=spnMfgPhone]').text() : '';
            var MfgID = $(tr).find('input:hidden[id^=hdnMfgID]') ? $(tr).find('input:hidden[id^=hdnMfgID]').val() : '0';
            if (MfgName != "" && MfgName != undefined) {
                if (MfgID == undefined || MfgID=="") {
                    MfgID = 0;
                }
                var RowData = { MfgName: MfgName, MfgID: MfgID, MfgCode: MfgCode, EMail: MfgMail, Phone: MfgPhone };
                TableData.push(RowData);
            }

        });
        return TableData;
    }



    var pno = 1;
    var sort = 0;
    var filter = 0;
    var col = 2;
    var searchtext;
    var totalCount = 0;
    var totalMfgCount = 0;
    var uid = "";
    var rowPid = 0;
    var gid = "";
    var atid = "";
    var atsid = "";
    var projid = 0;
    var pjname = "";
    var fromDate = '';
    var ToDate = '';
    var AdfromDate1 = '';
    var AdToDate1 = '';
    var TPAID = '';
    var ClientID = '';
    var Purpose = '';

    // Paging Method
    function callMfgPage(pageno) {
        pno = pageno;
        GetMfgList(pno);
    }



    function createMfgPager(count, id) {
        var lastPno = ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1);
        $(id).html('');
        if (count != 0) {
            totalCount = count;
            var aFirst, aPrev;
            if (pno == 1) {
                aPrev = $("<a id=\"aP\"  class=\"btn marginL5;\" tabindex=\"12\"></a>");
                $(aPrev).html('Prev');
                aFirst = $("<a id=\"aF\"  class=\"btn\"  tabindex=\"11\"></a>");
                $(aFirst).html('&lt;&lt;');
            }
            else {
                aPrev = $("<a id=\"aP\"  class=\"btn pointer marginL5\" tabindex=\"12\"></a>");
                $(aPrev).html('Prev');
                $(aPrev).click(function() {
                    callMfgPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
                });
                $(aPrev).keypress(function() {
                    if (event.keyCode == 13) {
                        callMfgPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
                    }
                });
                aFirst = $("<a id=\"aF\"  class=\"btn pointer\" tabindex=\"11\"></a>");
                $(aFirst).click(function() {
                    callMfgPage(1);
                });

                $(aFirst).keypress(function(event) {
                    if (event.keyCode == 13) {
                        callMfgPage(1);
                    }
                });
                aFirst.html('&lt;&lt;');
            }
            $(id).append(aFirst);
            var newSpace1 = $("<span>");
            $(newSpace1).html('&nbsp&nbsp');
            $(id).append(newSpace1);
            $(id).append(aPrev);
            var newSpace2 = $("<span>");
            $(newSpace2).html('&nbsp&nbsp');
            $(id).append(newSpace2);
            if (pno > 2 && (count / 10) > 3) {
                var newDots = $("<span>");
                $(newDots).html('...');
                $(id).append(newDots);
                var newSpace = $("<span>");
                $(newSpace).html('&nbsp&nbsp');
                $(id).append(newSpace);
            }
            for (var i = 1; i <= ((count % 10) == 0 ? (count / 10) : (count / 10) + 1); i++) {
                var forCond1 = (parseInt(pno) + 2);
                if (parseInt(pno) == 1) {
                    forCond1 = (parseInt(pno) + 3);
                }
                var forCond2 = parseInt(i) + 2;
                if (parseInt(pno) == parseInt((count % 10) == 0 ? (count / 10) : (count / 10) + 1)) {
                    forCond2 = parseInt(i) + 3;
                }
                if ((parseInt(pno)) < forCond2 && forCond1 > parseInt(i)) {
                    var newA
                    if (pno == i) {
                        newA = $("<a id=\"a" + i + "\"  class=\"btn pointer\" tabindex=\"12\"></a>");
                        //$(newA).attr('class', 'Selected');
                        $(newA).addClass('Selected');
                    }
                    else {
                        newA = $("<a id=\"a" + i + "\"  class=\"btn pointer\" tabindex=\"12\"></a>");
                        $(newA).click(function() {
                            var cRow = this.id.split('a')[1];
                            callMfgPage(cRow);
                        });
                        $(newA).keypress(function() {
                            if (event.keyCode == 13) {
                                var cRow = this.id.split('a')[1];
                                callMfgPage(cRow);
                            }
                        });
                    }
                    $(newA).html(i);
                    var newSpace = $("<span></span>");
                    $(newSpace).html('&nbsp&nbsp');
                    $(id).append(newA);
                    $(id).append(newSpace);
                }
            }
            if ((parseInt(pno) + 1) < (count / 10) && (count / 10) > 3) {
                var newDots = $("<span></span>");
                $(newDots).html('...');
                $(id).append(newDots);
                var newSpace = $("<span></span>");
                $(newSpace).html('&nbsp&nbsp');
                $(id).append(newSpace);
            }
            var aLast, aNext;
            if (pno == ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1)) {
                aLast = $("<a  class=\"btn textcur\" id=\"aL\" tabindex=\"13\"></a>");
                $(aLast).html('&gt;&gt;');

                aNext = $("<a id=\"aN\"  class=\"btn marginR5\" tabindex=\"12\"></a>");
                $(aNext).html('Next');

            }
            else {
                aLast = $("<a id=\"aL\"  class=\"btn pointer marginR5\" tabindex=\"13\"></a>");
                $(aLast).html('&gt;&gt;');
                $(aLast).click(function() {
                    callMfgPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
                });
                $(aLast).keypress(function(event) {
                    if (event.keyCode == 13) {
                        callMfgPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
                    }
                });
                aNext = $("<a id=\"aN\"  class=\"btn pointer marginR5\" tabindex=\"12\"></a>");
                $(aNext).html('Next');
                $(aNext).click(function() {
                    callMfgPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
                });
                $(aNext).keypress(function(event) {
                    if (event.keyCode == 13) {
                        callMfgPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
                    }
                });
            }
            $(id).append(aNext);
            var newSpace4 = $("<span></span>");
            $(newSpace4).html('&nbsp&nbsp');
            $(id).append(newSpace4);
            $(id).append(aLast);
        }
    }

    function echeck(str) {
        var userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_05') == null ? "Invalid e-mail id" : SListForAppMsg.Get('InventoryMaster_Controls_AddManufacturer_ascx_05');
        var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
        var at = "@"
        var dot = "."
        var lat = str.indexOf(at)
        var lstr = str.length
        var ldot = str.indexOf(dot)
        if (str.indexOf(at) == -1) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (str.indexOf(at) == -1 || str.indexOf(at) == 0 || str.indexOf(at) == lstr) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (str.indexOf(dot) == -1 || str.indexOf(dot) == 0 || str.indexOf(dot) == lstr) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (str.indexOf(at, (lat + 1)) != -1) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (str.substring(lat - 1, lat) == dot || str.substring(lat + 1, lat + 2) == dot) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (str.indexOf(dot, (lat + 2)) == -1) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        if (str.indexOf(" ") != -1) {
            ValidationWindow(userMsg, errorMsg);
            return false;
        }
        return true;
    }
    
    
</script>

<table class="searchPanel w-100p marginT2 displaytb">
    <tr class="panelHeader">
        <td class="colorforcontent lh20" colspan="2">
            <div id="divExpanded" runat="server" class="show">
                &nbsp;<img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="a-top pointer pull-right w-15 h-15"
                     onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',1);" />
                <span  class=" pointer"  onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',1);">
                    <asp:Label ID="Rs_ProductSearch" Text="Manufacturer Search" runat="server" meta:resourcekey="Rs_ProductSearchResource1"></asp:Label></span>
            </div>
            <div id="divCollapsed" runat="server" class="hide">
                &nbsp;<img src="../PlatForm/Images/HideBids.gif" alt="hide" class="a-top pointer pull-right w-15 h-15"
                     onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',0);" />
                <span  class="pointer" onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',0);">
                    <asp:Label ID="Rs_ProductSearch1" Text="Manufacturer Search" runat="server" meta:resourcekey="Rs_ProductSearch1Resource1"></asp:Label></span>
            </div>
        </td>
    </tr>
    <tr class="tablerow dataheader2 defaultfontcolor lh25 hide" id="divBody" runat="server" >
        <td id="Td1" class="w-10p" runat="server">
            <span id="Span1">
                <asp:Label ID="lblManufacturerName1" runat="server" 
                Text="Manufacturer Name" meta:resourcekey="lblManufacturerName1Resource1"></asp:Label>
            </span>
        </td>
        <td>
            <%--<input type="text"  OnKeyPress="return ValidateMultiLangChar(this)" id="txtSearchMfgName" class="Txtboxsmall" runat="server" runat="server" />--%>
            <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtSearchMfgName" class="small" runat="server" 
                meta:resourcekey="txtSearchMfgNameResource1"></asp:TextBox>
            &nbsp; &nbsp;&nbsp;
            <input type="button" runat="server" class="btn" id="btnMfgSearch" value="Search"
                onclick="GetMfgList(1)" />
            <ajc:AutoCompleteExtender ID="AutoCompleteMfg1" runat="server" CompletionInterval="1"
                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                MinimumPrefixLength="2" ServiceMethod="GetManufacturer" ServicePath="~/InventoryMaster/Webservice/InventoryMaster.asmx"
                TargetControlID="txtSearchMfgName" DelimiterCharacters="" Enabled="True">
            </ajc:AutoCompleteExtender>
        </td>
    </tr>
</table>
<div >
</div>
<table class="dataheader2 defaultfontcolor w-100p displaytb">
    <tr class="lh30">
        <td >
            <span id="lblMfgName">
                <asp:Label ID="lblManufacturerName" runat="server" Text="Manufacturer Name" 
                meta:resourcekey="lblManufacturerNameResource1"></asp:Label>
            </span>
        </td>
        <td>
            <input type="text" onkeypress="return ValidateMultiLangChar(this)" id="txtAddMfgName" class="small" maxlength="100" runat="server" />
        </td>
        <td >
            <span id="lblMfgCode">
                <asp:Label ID="lblManufacturerCode" runat="server" Text="Manufacturer Code" 
                meta:resourcekey="lblManufacturerCodeResource1"></asp:Label>
            </span>
        </td>
        <td>
            <input type="text"  onkeypress="return ValidateMultiLangChar(this)" id="txtAddMfgCode" class="small" runat="server" maxlength="25" />
        </td>
        <td>
            <span id="lblMfgMail">
                <asp:Label ID="lblEmail" runat="server" Text="EMail" 
                meta:resourcekey="lblEmailResource1"></asp:Label>
            </span>
        </td>
        <td>
            <input type="text" maxlength="100" onkeypress="return ValidateMultiLangChar(this)" id="txtAddMfgMail" class="small" runat="server" />
        </td>
        <td>
            <span id="lblMfgPhone">
                <asp:Label ID="lblPhone" runat="server" Text="Phone" 
                meta:resourcekey="lblPhoneResource1"></asp:Label>
            </span>
        </td>
        <td>
            <input type="text"  onkeypress="return ValidateOnlyNumeric(this)" id="txtAddMfgPhone" class="small" runat="server" onblur="return movetab();" onkeydown="return isNumerc(event,this.id);"
                maxlength="10" />
        </td>

        <td class="w-15p a-left">
            <button runat="server" class="btn" id="btnAddMfgName" value="Add" onclick="btnMfgAddItem();return false;" tabindex="119"
                >
                <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddManufacturer_ascx_07==null?"Add":Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddManufacturer_ascx_07) %>
                </button>
                <%--<asp:Button id="btnAddMfgName" runat="server" onClientClick="btnMfgAddItem();return false;" CssClass="btn" meta:resourcekey="AddManufacturerbtnadd"/>--%>
            &nbsp; &nbsp;
         <button runat="server" class="cancel-btn marginL50 hide" id="btnCancelMfgName" value="Cancel" tabindex="120"
               onclick="btnMfgCancelEdit();return false;">
                  <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddManufacturer_ascx_09 == null ? "Cancel" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddManufacturer_ascx_09)%>
                </button>
        </td>
    </tr>
</table>
<input id="hdnEditMfgMail" type="hidden" runat="server" />
<input id="hdnEditMfgPhone" type="hidden" runat="server" />
<input id="hdnEditMfgCode" type="hidden" runat="server" />
<input id="hdnEditMfgName" type="hidden" runat="server" />
<input type="hidden" runat="server" id="hdnEditMfgID" />
<asp:HiddenField ID="hdnTotalMfgCount" runat="server" />
<div>
    <div id="dvMfgList" runat="server" class="borderGrey h-300 auto">
    </div>
    <div id="divMfgPager" class="paddingT10 n-float a-center font12">
    </div>
    <div  class="a-center marginT10">
<%--        <button runat="server" class="btn w-50 " id="btnSaveMfgList" value="Save" onclick="btnMfgSaveClick();return false;"> 
  <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddManufacturer_ascx_08 == null ? "Save" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddManufacturer_ascx_08)%>
        </button>--%>
        <asp:Button id="btnSaveMfgList" runat="server" onClientClick="btnMfgSaveClick();return false;" CssClass="btn w-50 hide" meta:resourcekey="AddManufacturerbtnsave"/>
    </div>
</div>
