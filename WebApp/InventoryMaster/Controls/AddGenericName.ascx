<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AddGenericName.ascx.cs"
    Inherits="CommonControls_AddGenericName" %>

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
    var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Error" : SListForAppMsg.Get('InventoryMaster_Error');
    var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Information');
</script>
<script type="text/javascript" language="javascript">
    var userMsg;
    $(document).ready(function() {
        GetGenericList(1);
    });

    function btnSaveClick() {
        var TableData = tableToData();

        var Parameters = { lstDrugGeneric: TableData };
        try {
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/Webservice/InventoryMaster.asmx/SaveDrugGeneric",
                data: JSON.stringify(Parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    GenerateTable(data.d.lstDrugGeneric);
                    if (data.d.RecordCount != 0) {
                        createPager(data.d.RecordCount, $('div[id$=divPager]'));
                    }
                    else {
                        $('#divPager').hide();
                    }
                    userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_01') == null ? "Saved Successfully" : SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_01');
                    var Information = SListForAppMsg.Get('InventoryMaster_Information') == null ? "Information" : SListForAppMsg.Get('InventoryMaster_Information');
                    ValidationWindow(userMsg, Information);
                },
                failure: function(xhr, ajaxOptions, thrownError) {
                ValidationWindow(xhr.status,errorMsg);
                }
            });
        }
        catch (e) {
            return false;
        }
        $('button[id*=btnSaveGenericList]').hide();
    }

    function GetGenericList(_PageNumber) {
        var Searchname = $('input[id*=txtSearchGenName]').val();
        var Parameters = { PageNum: _PageNumber, GenericName: Searchname };
        try {
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/WebService/InventoryMaster.asmx/GetSearchGenericListForUpdate",
                data: JSON.stringify(Parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    totalCount = data.d.RecordCount;
                    GenerateTable(data.d.lstDrugGeneric);
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
    function GenerateTable(data) {
        var Genericname = SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_02') == null ? "Generic name" : SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_02');
        var Action = SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_07') == null ? "Action" : SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_07');
        var Header = "<table id='tblGenericNameList' class='responstable w-100p' ><tr class='responstableHeader lh20'><td>" + Genericname + "</td><td>" + Action + "</td></tr>";
        if (data != null && data != undefined && data.length > 0) {
            for (var i = 0; i < data.length; i++) {
                var Parameters = { GenericID: data[i].GenericID, GenericName: data[i].GenericName };
                var pAction = "<input id='btnGenEdit_" + data[i].GenericName + "_" + data[i].GenericID + "' onclick='btnGenEdit_OnClick(" + JSON.stringify(Parameters) + ");'  type='button' class='ui-icon ui-icon-pencil pointer' ";
                var GenericName = (data[i].GenericName).replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '');
                Header += "<tr id='trGen_" + GenericName + "_" + data[i].GenericID + "'><td><span id='spnGenericName'>" + data[i].GenericName + "</span><input type='hidden' id='hdnGenericID_" + data[i].GenericID + "' value='" + data[i].GenericID + "'></td><td>" + pAction + " </td></tr>";
               // Header += "<tr id='trGen_" + data[i].GenericName + "_" + data[i].GenericID + "'><td><span id='spnGenericName'>" + data[i].GenericName + "</span><input type='hidden' id='hdnGenericID_" + data[i].GenericID + "' value='" + data[i].GenericID + "'></td><td>" + pAction + " </td></tr>";
            }
            Header += "</table>";
            $('div[id*=dvGenericList]').html(Header);
            createPager(totalCount, $('#divPager'));
            //$('button[id*=btnSaveGenericList]').show();
        }
        else {
            $('button[id*=btnSaveGenericList]').hide();
        }
    }

    function btnGenEdit_OnClick(name) {
        var Update = SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_01') == null ? "Update" : SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_01');
        if ($('button[id*=btnAddGenericName]').val() != 'Update') {
            if (name != null && name != undefined) {
                $('input[id*=txtAddGenericName]').val(name.GenericName);
                $('input[id*=hdnEditGenericID').val(name.GenericID);
                $('input[id*=hdnEditGenericName').val(name.GenericName);
                $('button[id*=btnGenEdit]').val('Edit');
                $('button[id*=btnAddGenericName]').html(Update);
                $('button[id*=btnAddGenericName]').val('Update');                
                $('button[id*=btnCancelGenericName]').show();
                var GenericName = (name.GenericName).replace(/[^a-z0-9\s]/gi, '').replace(/[_\s]/g, '');
                $('tr[id=trGen_' + GenericName + '_' + name.GenericID + ']').remove();
            }
        }
        else {
            userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_02') == null ? "Please update the current item" : SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_02');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
            ValidationWindow(userMsg, errorMsg);
        }
    }

    function btnCancelEdit() {
        var Add = SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_03') == null ? "Add" : SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_03');
        var TableData = tableToData();
        var NewGenericName = $('input[id*=hdnEditGenericName]').val();
        var HdnGenericID = $('input[id*=hdnEditGenericID').val();
        var RowData = { GenericName: NewGenericName, GenericID: HdnGenericID };
        TableData.unshift(RowData);
        GenerateTable(TableData);
        $('input[id*=hdnEditGenericName]').val("");
        $('input[id*=hdnEditGenericID').val("");
        $('button[id*=btnAddGenericName]').val(Add);
        $('button[id*=btnCancelGenericName]').hide();
        $('input[id*=txtAddGenericName]').val("");
    }

    function btnAddItem() {
        var Add = SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_03') == null ? "Add" : SListForAppDisplay.Get('InventoryMaster_Controls_AddGenericName_ascx_03');
        var TableData = tableToData();
        var NewGenericName = $.trim($('input[id*=txtAddGenericName]').val());
        if (NewGenericName == "") {
            var userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_04') == null ? "Please enter the generic name" : SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_04');
            var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
            ValidationWindow(userMsg, errorMsg);
            return false;
            $('input[id*=txtAddGenericName]').focus();
        }
        //GetValidateGenericName added at 9-1-2016 by sabaree
        
        var Parameters = { GenericName: NewGenericName };
        var _Retvalue = -1;
        if ($('input[id*=hdnEditGenericName').val() != NewGenericName)
            {
        try {
            $.ajax({
                type: "POST",
                url: "../InventoryMaster/Webservice/InventoryMaster.asmx/GetValidateGenericName",
                data: JSON.stringify(Parameters),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    _Retvalue = data.d;
                    if (_Retvalue != -1 && _Retvalue != 0 && _Retvalue != undefined) {
        for (var i = 0; i < TableData.length; i++) {
            if (TableData[i].GenericName.toUpperCase() == NewGenericName.toUpperCase()) {
                var userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_03') == null ? "The generic name already exists" : SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_03');
                var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
                ValidationWindow(userMsg, errorMsg);
                return false;
                $('input[id*=txtAddGenericName]').focus();
            }
        }
        if ($('button[id*=btnAddGenericName]').val() == 'Add') {
         
            var RowData = { GenericName: NewGenericName, GenericID: '0' };
            TableData.unshift(RowData);
        }
        else {
           
            var HdnGenericID = $('input[id*=hdnEditGenericID').val();
            var RowData = { GenericName: NewGenericName, GenericID: HdnGenericID };
            TableData.unshift(RowData);
            $('button[id*=btnAddGenericName]').val("Add");
            $('button[id*=btnAddGenericName]').html(Add);   
            $('button[id*=btnCancelGenericName]').hide();
        }
        if (TableData != null && TableData != undefined) {//poorani
            GenerateTable(TableData);
            $('button[id*=btnSaveGenericList]').show();
            $('button[id*=btnSaveGenericList]').removeClass().addClass('btn');
        }
        $('input[id*=txtAddGenericName]').val("");
                    }
                    else {

                        var userMsg = SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_03') == null ? "The generic name already exists" : SListForAppMsg.Get('InventoryMaster_Controls_AddGenericName_ascx_03');
                        var errorMsg = SListForAppMsg.Get('InventoryMaster_Error') == null ? "Alert" : SListForAppMsg.Get('InventoryMaster_Error');
                        ValidationWindow(userMsg, errorMsg);
                        return false;
                        $('input[id*=txtAddGenericName]').focus();
                    }

                },
                failure: function(xhr, ajaxOptions, thrownError) {
                    ValidationWindow(xhr.status, errorMsg);
                }
            });
        }
        catch (e) {
            return false;
        }
        }
    }

    function tableToData() {
        var TableData = [];
        $('table[id$=tblGenericNameList] tr').each(function() {
            var tr = $(this).closest("tr");
            var GenericName = $(tr).find('span[id$=spnGenericName]') ? $(tr).find('span[id$=spnGenericName]').text() : '';
            var GenericID = $(tr).find('input:hidden[id*=hdnGenericID]') ? $(tr).find('input:hidden[id*=hdnGenericID]').val() : '';
            if (GenericName != "" && GenericName != undefined) {
                if (GenericID == undefined) {
                    GenericID = 0;
                }
                var RowData = { GenericName: GenericName, GenericID: GenericID };
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
    function callPage(pageno) {
        pno = pageno;
        GetGenericList(pno);
    }



    function createPager(count, id) {
        var lastPno = ((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1);
        $(id).html('');
        if (count != 0) {
            totalCount = count;
            var aFirst, aPrev;
            if (pno == 1) {
                aPrev = $("<a id=\"aP\"  class=\"btn marginL5\" tabindex=\"12\"></a>");
                $(aPrev).html('Prev');
                aFirst = $("<a id=\"aF\"  class=\"btn\" tabindex=\"11\"></a>");
                $(aFirst).html('&lt;&lt;');
            }
            else {
                aPrev = $("<a id=\"aP\"  class=\"btn pointer marginL5\" tabindex=\"12\"></a>");
                $(aPrev).html('Prev');
                $(aPrev).click(function() {
                    callPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
                });
                $(aPrev).keypress(function() {
                    if (event.keyCode == 13) {
                        callPage(parseInt(pno) > 1 ? parseInt(pno) - 1 : parseInt(pno));
                    }
                });
                aFirst = $("<a id=\"aF\"  class=\"btn pointer\" tabindex=\"11\"></a>");
                $(aFirst).click(function() {
                    callPage(1);
                });

                $(aFirst).keypress(function(event) {
                    if (event.keyCode == 13) {
                        callPage(1);
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
                        newA = $("<a id=\"a" + i + "\" class=\"btn pointer;\" tabindex=\"12\"></a>");
                        //$(newA).attr('class', 'Selected');
                        $(newA).addClass('Selected');
                    }
                    else {
                        newA = $("<a id=\"a" + i + "\" class=\"btn pointer;\" tabindex=\"12\"></a>");
                        $(newA).click(function() {
                            var cRow = this.id.split('a')[1];
                            callPage(cRow);
                        });
                        $(newA).keypress(function() {
                            if (event.keyCode == 13) {
                                var cRow = this.id.split('a')[1];
                                callPage(cRow);
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
                aLast = $("<a id=\"aL\" class=\"btn textcur\" tabindex=\"13\"></a>");
                $(aLast).html('&gt;&gt;');

                aNext = $("<a id=\"aN\" class=\"btn marginR5;\" tabindex=\"12\"></a>");
                $(aNext).html('Next');

            }
            else {
                aLast = $("<a id=\"aL\" class=\"btn pointer marginR5;\" tabindex=\"13\"></a>");
                $(aLast).html('&gt;&gt;');
                $(aLast).click(function() {
                    callPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
                });
                $(aLast).keypress(function(event) {
                    if (event.keyCode == 13) {
                        callPage(((count % 10) == 0 ? (count / 10) : parseInt(count / 10) + 1));
                    }
                });
                aNext = $("<a id=\"aN\" class=\"btn pointer marginR5\" tabindex=\"12\"></a>");
                $(aNext).html('Next');
                $(aNext).click(function() {
                    callPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
                });
                $(aNext).keypress(function(event) {
                    if (event.keyCode == 13) {
                        callPage(parseInt(pno) < lastPno ? parseInt(pno) + 1 : parseInt(pno));
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
    
</script>

<table class="searchPanel w-100p marginT2">
    <tr class="panelHeader">
        <td class="lh20"colspan="2">
            <div id="divExpanded" runat="server" class="show">
                &nbsp;<img src="../PlatForm/Images/ShowBids.gif" alt="Show" class="w-15 h-15 v-top pointer pull-right"
                     onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',1);" />
                <span class="pointer" onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',1);">
                    <asp:Label ID="Rs_ProductSearch" Text="Generic Name Search" runat="server" meta:resourcekey="Rs_ProductSearchResource1"></asp:Label></span>
            </div>
            <div id="divCollapsed" runat="server" class="hide">
                &nbsp;<img src="../PlatForm/Images/HideBids.gif" alt="hide" class="w-15 h-15 v-top pointer pull-right" onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',0);" />
                <span class="dataheader1txt pointer" onclick="showResponses('<%=divExpanded.ClientID %>','<%=divCollapsed.ClientID %>','<%=divBody.ClientID %>',0);">
                    <asp:Label ID="Rs_ProductSearch1" Text="Generic Name Search" runat="server" meta:resourcekey="Rs_ProductSearch1Resource1"></asp:Label>
            </div>
        </td>
    </tr>
    <tr class="tablerow dataheader2 defaultfontcolor lh25 hide" id="divBody" runat="server" >
        <td id="Td1" class="w-10p" runat="server">
            <span id="Span1"><asp:Label ID="lblGenericName1" runat="server" 
                Text="Generic Name" meta:resourcekey="lblGenericName1Resource1"></asp:Label></span>
        </td>
        <td>
         <asp:TextBox OnKeyPress="return ValidateMultiLangChar(this)" ID="txtSearchGenName" class="medium" runat="server" 
                meta:resourcekey="txtSearchGenNameResource1"></asp:TextBox>&nbsp;&nbsp;
            <input type="button" runat="server" class="btn" id="btnGenSearch" value="Search"
                onclick="GetGenericList(1)" />
                 <ajc:AutoCompleteExtender ID="AutoCompleteMfg1" runat="server" CompletionInterval="1"
                CompletionListCssClass="wordWheel listMain box" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                CompletionListItemCssClass="listitemtwo" EnableCaching="False" FirstRowSelected="True"
                MinimumPrefixLength="2" ServiceMethod="GetSearchGenericList" ServicePath="~/InventoryCommon/WebService/InventoryWebService.asmx"
                TargetControlID="txtSearchGenName" DelimiterCharacters="" Enabled="True">
            </ajc:AutoCompleteExtender>
        </td>
    </tr>
</table>
<div>
</div>
<table class="dataheader2 defaultfontcolor w-100p">
    <tr class="lh30">
        <td class="w-10p">
            <span id="lblGenericName"><asp:Label ID="Label1" runat="server" 
                Text="Generic Name" meta:resourcekey="Label1Resource1"></asp:Label></span>
        </td>
        <td class="w-12p">
            <input type="text" maxlength="100" OnKeyPress="return ValidateMultiLangChar(this)" id="txtAddGenericName" class="medium" runat="server" />

        </td>
        <td >
            &nbsp;&nbsp;<button runat="server" class="btn" id="btnAddGenericName" value="Add" tabindex="110"
                onclick="btnAddItem();return false;">
                <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddGenericName_ascx_05==null?"Add":Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddGenericName_ascx_05) %>
                </button>
            <button runat="server" class="cancel-btn hide" id="btnCancelGenericName" value="Cancel" tabindex="109"
                onclick="btnCancelEdit();return false;">
                  <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddGenericName_ascx_06==null?"Cancel":Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddGenericName_ascx_06) %>
                </button>
        </td>
    </tr>
</table>
<input id="hdnEditGenericName" type="hidden" runat="server" />
<input type="hidden" runat="server" id="hdnEditGenericID" />
<asp:HiddenField ID="hdnTotalCount" runat="server" />
<div id="divContainer">
    <div id="dvGenericList" runat="server" class="h-300 auto borderGrey">
    </div>
    <div id="divPager" class="n-float a-center paddingT10 font12">
    </div>
    <div class="a-center marginT10">
        <button runat="server" class="btn" id="btnSaveGenericList" value="Save"
            onclick="btnSaveClick();return false;">
             <%=(Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddGenericName_ascx_04 == null ? "Save" : Resources.InventoryMaster_ClientDisplay.InventoryMaster_Controls_AddGenericName_ascx_04)%>
            </button>
    </div>
</div>
