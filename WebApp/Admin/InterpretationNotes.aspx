<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InterpretationNotes.aspx.cs" Inherits="Admin_InterpretationNotes" EnableEventValidation="false" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>

<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/StyleSheet.css" rel="Stylesheet" type="text/css" />
    <link rel="stylesheet" media="screen" href="../Scripts/handsontable/dist/jquery.handsontable.full.css" />
    <link rel="stylesheet" media="screen" href="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.css" />

    <script type="text/javascript" src="../FCKeditor/fckeditor.js"></script>
     <style type="text/css">
   
    
    div.main {
        clear:both;
    }
    .up {
        float: left;
    }
    .down {
        float: left;
    }
    .listMain
    {
        z-index:9999999999;
    }
</style>

    <script type="text/javascript">

        //        $(document).ready(function() {
        //            $('.up').click(function() {
        //                var parent = $(this).parent();
        //                parent.insertBefore(parent.prev());
        //            });
        //            $('.down').click(function() {
        //                var parent = $(this).parent();
        //                parent.insertAfter(parent.next());
        //            });
        //        });

        var hdnnotes = '<%=hdnnotes.ClientID %>';
        var controlCount = 0;
        var lstControlId = [];
        var htmlRenderer = function(instance, td, row, col, prop, value, cellProperties) {
            var escaped = Handsontable.helper.stringify(value);
            td.innerHTML = escaped;
            return td;
        };
        function TestCodeSchemePopulated(Source, eventArgs) {
            try {
                var autoList = Source.get_completionList();
                if (autoList.childNodes == null && autoList.childNodes.length == 0) {
                    $('#hdnID').val('');
                    $('#hdnType').val('');
                }
            }
            catch (e) {
                return false;
            }
        }
        function SelectedTestCodeScheme(Source, eventArgs) {
            try {
                var lstSelectedValue = eventArgs.get_value().split('~');
                $('#hdnID').val(lstSelectedValue[0]);
                $('#hdnType').val(lstSelectedValue[1]);
                var lstSelectedText = eventArgs.get_text().split(':');
                if (lstSelectedText.length > 1 && lstSelectedText[1] != null) {
                    $('#txtTestCodeScheme').val(lstSelectedText[1]);
                }
            }
            catch (e) {
                return false;
            }
        }
        // Wrapper for adding a new field
        function appendNewField(type) {
            //debugger;
            switch (type) {
                case 'text':
                    appendTextInput();
                    break;
                case 'table':
                    appendHandsonTable();
                    break;
            }
        }
        // single line input type="text"
        function appendTextInput() {


            //'<img src="../Images/up_arrow.png" /><img src="../Images/down_arrow.png" />'
            controlCount++;
            var textId = 'text' + controlCount;
            var hideid = textId + "___Frame";
            //alert(hideid);

            var divmainid = textId + "main";
            // var Funremove = ''
            //  "<input id='Button1' type='button' value='button' onclick='" + a.toString() + "'  />";
            var Hyperlink = '<a href="javascript:Removediv(\'' + divmainid + '\');"><b><font color="3494F5">Remove</font></b></a>'
            //$("#divCtrlContainer").append(Hyperlink); 
            lstControlId.push(textId);
            var textArea = '<textarea id="' + textId + '" name="' + textId + '"></textarea>';
            var divupanddown = ' <div class="up"><img onclick="javascript:uparrow()" src="../Images/UpArrow.png"> </div>'
            divupanddown = divupanddown + '<div class="down"> <img onclick="javascript:downarrow()" src="../Images/DownArrow.png"></div>'
            var divmain = '<div class="main" id="' + divmainid + '">' + textArea + divupanddown + Hyperlink + '</div>'
            $("#divCtrlContainer").append(divmain);
            //$("#divCtrlContainer").append(textArea);
            //$("#divCtrlContainer").append(textArea);
            var oFCKeditor = new FCKeditor(textId);
            oFCKeditor.BasePath = "../fckeditor/";
            oFCKeditor.ReplaceTextarea();
        }

        // Handsontable
        function appendHandsonTable() {

            controlCount++;
            var tableId = 'table' + controlCount;
            lstControlId.push(tableId);

            //            var tableId = 'table' + controlCount;
            //            lstControlId.push(tableId);

            //'<img src="../Images/up_arrow.png" /><img src="../Images/down_arrow.png" />'
            var divmainid = tableId + "main";
            var Hyperlink = '<a href="javascript:Removediv(\'' + divmainid + '\');"><b><font color="3494F5">Remove</font></b></a>'
            //$("#divCtrlContainer").append(Hyperlink);
            var divupanddown = ' <div class="up"><img onclick="javascript:uparrow()" src="../Images/UpArrow.png"> </div>'
            divupanddown = divupanddown + '<div class="down"> <img onclick="javascript:downarrow()" src="../Images/DownArrow.png"></div>'



            var divTable = '<div id="' + tableId + '"></div>';
            var divMainTable = '<div  id="' + divmainid + '" class="main">' + divTable + divupanddown + Hyperlink + '</div>';

            $("#divCtrlContainer").append(divMainTable);
            $("#" + tableId).handsontable({
                minRows: 4,
                minCols: 4,
                startRows: 5,
                startCols: 5,
                rowHeaders: true,
                colHeaders: true,
                minSpareRows: 1,
                minSpareCols: 1,
                contextMenu: false,
                manualColumnResize: true,
                useFormula: false,
                autoWrapRow: true,
                cells: function(row, col, prop) {
                    this.renderer = htmlRenderer;
                }
            });
        }
        function save() {

            var controlCount = 0;
            var controlId = '';
            var xmldom = $($.parseXML('<Interpretation />'));
            $('#divCtrlContainer').children().each(function(i, item) {
                $('#' + item.id).children().each(function(j, item1) {
                    controlId = item1.id;
                    if ($.inArray(controlId, lstControlId) != -1) {
                        if (controlId.indexOf('text') != -1) {
                            if (typeof FCKeditorAPI != 'undefined') {
                                var editorData = FCKeditorAPI.GetInstance(controlId);
                                if (editorData && $.trim(editorData.GetHTML()).length > 0) {
                                    controlCount++;
                                    $('Interpretation', xmldom).append($('<Item />', xmldom).attr({ Type: controlId }).attr({ Value: editorData.GetHTML() }).attr({ RowNo: '0' }).attr({ ColumnNo: '0' }).attr({ ColumnCount: '0' }));
                                }
                            }
                        }
                        else if (controlId.indexOf('table') != -1) {
                            var table = $('#' + controlId).handsontable('getInstance');
                            var tableRowsCount = table.countRows();
                            var tableColsCount = table.countCols();
                            var tableEmptyRowsCount = table.countEmptyRows(true);
                            var tableEmptyColsCount = table.countEmptyCols(true);

                            var tableDataRowsCount = tableRowsCount - tableEmptyRowsCount;
                            var tableDataColsCount = tableColsCount - tableEmptyColsCount;

                            if (tableDataRowsCount) {
                                tableDataRowsCount = tableDataRowsCount - 1;
                            }
                            if (tableDataColsCount) {
                                tableDataColsCount = tableDataColsCount - 1;
                            }
                            var lstTableData = table.getData(0, 0, tableDataRowsCount, tableDataColsCount);
                            if (!(tableDataRowsCount == 0 && tableDataColsCount == 0)) {
                                for (var i = 0; i <= tableDataRowsCount; i++) {
                                    var rowTableData = lstTableData[i];
                                    for (var j = 0; j <= tableDataColsCount; j++) {
                                        var tableData = rowTableData[j];
                                        if (tableData == null) {
                                            tableData = '';
                                        }
                                        $('Interpretation', xmldom).append($('<Item />', xmldom).attr({ Type: controlId }).attr({ Value: tableData }).attr({ RowNo: i + 1 }).attr({ ColumnNo: j + 1 }).attr({ ColumnCount: tableDataColsCount + 1 }));
                                    }
                                }
                            }
                        }

                    }
                });
            });
            if ($(xmldom) != null && $(xmldom).length > 0 && $(xmldom)[0].xml != null && $.trim($(xmldom)[0].xml).length > 0) {
                $('#hdnData').val($(xmldom)[0].xml);
            }
            else {
                $('#hdnData').val('');
            }
        }



        function GetInterpretationNotes() {
            //debugger;
            var Interpretationdata = $("#hdnnotes").val();
            //alert(value);

            var InterpretationNotes = JSON.parse(Interpretationdata);
            var secondtype = ""

            $.each(InterpretationNotes, function(index, Notes) {

                var firsttype = Notes.Type;
                var TypeName = "";
                if (firsttype.indexOf("text") != -1) {

                    TypeName = "text";
                }
                else {

                    TypeName = "table";
                }

                if (firsttype != secondtype || TypeName == "text") {
                    RetriveappendNewField(TypeName, Notes.Value, InterpretationNotes, Notes.Type);
                    secondtype = firsttype;
                }

            });

            //alert(obj.Name);
        }

        function RetriveappendNewField(type, value, Gettabledata, Tabletype) {

            switch (type) {
                case 'text':
                    RetriveappendTextInput(value);
                    break;
                case 'table':
                    RetriveappendHandsonTable(value, Gettabledata, Tabletype);
                    break;
            }
        }

        function RetriveappendTextInput(value) {

            //'<img src="../Images/up_arrow.png" /><img src="../Images/down_arrow.png" />'
            //alert("Bas");
            controlCount++;
            var textId = 'text' + controlCount;
            //var hideid = textId + "___Frame";
            //alert(hideid);
            var divmainid = textId + "main";
            // var Funremove = ''
            //  "<input id='Button1' type='button' value='button' onclick='" + a.toString() + "'  />";
            var Hyperlink = '<a href="javascript:Removediv(\'' + divmainid + '\');"><b><font color="3494F5">Remove</font></b></a>'
            //$("#divCtrlContainer").append(Hyperlink);
            lstControlId.push(textId);
            var textArea = '<textarea id="' + textId + '" name="' + textId + '" >' + value + '</textarea>';

            var divupanddown = '<div class="up"><img onclick="javascript:uparrow()" src="../Images/UpArrow.png"> </div>'
            divupanddown = divupanddown + '<div class="down"> <img onclick="javascript:downarrow()" src="../Images/DownArrow.png"></div>'

            var divmain = '<div class="main" id="' + divmainid + '">' + textArea + divupanddown + Hyperlink + '</div>'
            $("#divCtrlContainer").append(divmain);
            //$('#' + divmainid).append(textArea);
            var oFCKeditor = new FCKeditor(textId);
            oFCKeditor.BasePath = "../fckeditor/";
            oFCKeditor.ReplaceTextarea();
        }

        // Handsontable
        function RetriveappendHandsonTable(value, Gettabledata, type) {

            controlCount++;

            var formElements = [];


            $.each(Gettabledata, function(index, data) {



                if (type == data.Type) {

                    formElements.push({
                        Type: data.Type,
                        Value: data.Value,
                        RowNo: data.RowNo,
                        ColumnNo: data.ColumnNo

                    });
                }
            });

            var rowno2 = "";
            var jsonstring = "[{";

            lstTable = [];
            oTable = [];
            rowNo = 0;
            xmlRowNo = 0;
            $.each(formElements, function(index, value1) {

                xmlRowNo = value1.RowNo;
                if (rowNo != xmlRowNo) {
                    if (oTable.length > 0) {
                        lstTable.push(oTable);
                    }
                    oTable = [];
                    rowNo = xmlRowNo;
                }

                oTable.push(value1.Value);



            });
            if (oTable.length > 0) {
                lstTable.push(oTable);
            }


            // var arrvalue=JSON.stringify(formElements);


            var tableId = 'table' + controlCount;
            lstControlId.push(tableId);


            //'<img src="../Images/up_arrow.png" /><img src="../Images/down_arrow.png" />'
            var divmainid = tableId + "main";
            var Hyperlink = '<a href="javascript:Removediv(\'' + divmainid + '\');"><b><font color="3494F5">Remove</font></b></a>'

            var divupanddown = ' <div class="up"><img onclick="javascript:uparrow()" src="../Images/UpArrow.png"> </div>'
            divupanddown = divupanddown + '<div class="down"> <img onclick="javascript:downarrow()" src="../Images/DownArrow.png"></div>'


            var divTable = '<div id="' + tableId + '"></div>';
            var divMainTable = '<div  id="' + divmainid + '" class="main">' + divTable + divupanddown + Hyperlink + '</div>';

            //var divTable = '<div id="' + divmainid + '" class="main">' + divupanddown + Hyperlink + '</div>';

            $("#divCtrlContainer").append(divMainTable);
            $("#" + tableId).handsontable({
                minRows: 4,
                minCols: 4,
                startRows: 5,
                startCols: 5,
                rowHeaders: true,
                colHeaders: true,
                minSpareRows: 1,
                minSpareCols: 1,
                contextMenu: false,
                manualColumnResize: true,
                useFormula: false,
                autoWrapRow: true,
                cells: function(row, col, prop) {
                    this.renderer = htmlRenderer;
                }
            });



            var handontab1 = $("#" + tableId).handsontable('getInstance');

            //var hdnHandson1Data = JSON.parse($("#hdnsplittabledata").val());
            if (typeof handontab1 != 'undefined') {
                handontab1.loadData(lstTable);
            }


        }

        function uparrow() {

            $('.up').click(function() {
                var parent = $(this).parent();
                parent.insertBefore(parent.prev());
            });

        }
        function downarrow() {

            $('.down').click(function() {
                var parent = $(this).parent();
                parent.insertAfter(parent.next());
            });
        }

        function Removediv(removeid) {
            $('#' + removeid).remove();
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
   <Attune:Attuneheader ID="Attuneheader" runat="server" />
                    <div class="contentdata">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                           
                                <table class="w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblTestName" Text="Code / Name" runat="server" meta:resourcekey="lblTestNameResource1"></asp:Label>&nbsp;
                                            <asp:TextBox ID="txtTestCodeScheme" runat="server" MaxLength="50" Width="330px" CssClass="AutoCompletesearchBox"
                                                meta:resourcekey="txtTestCodeSchemeResource1" TabIndex="2"></asp:TextBox>
                                            <ajc:AutoCompleteExtender ID="ACETestCodeScheme" runat="server" TargetControlID="txtTestCodeScheme"
                                                EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="0" CompletionListCssClass="wordWheel listMain .box mediumList"
                                                CompletionListItemCssClass="wordWheel itemsMain mediumList" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3 mediumList"
                                                ServiceMethod="GetTestCodingDetails" ServicePath="~/WebService.asmx" UseContextKey="True"
                                                DelimiterCharacters=":" Enabled="True" OnClientItemSelected="SelectedTestCodeScheme"
                                                OnClientPopulated="TestCodeSchemePopulated" />
                                            <asp:Button ID="btnLoadTestDetails" runat="server" Text="&nbsp;&nbsp;&nbsp;Load&nbsp;&nbsp;&nbsp;"
                                                CssClass="btn" onmouseover="this.className='btn btnhov'" onmouseout="this.className='btn'"
                                                meta:resourcekey="btnLoadTestDetailsResource1" TabIndex="3" OnClick="btnLoad_Click" />
                                        </td>
                                        <td>
                                            <asp:Button ID="btnAddText" runat="server" Text="Add Text" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnAddTextResource1" TabIndex="4"
                                                OnClientClick="appendNewField('text'); return false;" />
                                            <asp:Button ID="btnAddTable" runat="server" Text="Add Table" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnAddTableResource1" TabIndex="5"
                                                OnClientClick="appendNewField('table'); return false;" />
                                            <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                                onmouseout="this.className='btn'" meta:resourcekey="btnSaveResource1" TabIndex="6"
                                                OnClientClick="save();" OnClick="btnSave_Click" />
                                        </td>
                                    </tr>
                                </table>
                                <div id="divCtrlContainer">
                                </div>
                                <asp:HiddenField ID="hdnID" runat="server" />
                                <asp:HiddenField ID="hdnType" runat="server" />
                                <asp:HiddenField ID="hdnData" runat="server" />
                               <input type="hidden" id="hdnnotes" runat="server" />
                               <asp:HiddenField ID="hdntablevalue" runat="server" />
                               <asp:HiddenField ID="hdnsplittabledata" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <asp:Image ID="imgLoadingbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgLoadingResource1" />
                                <asp:Label ID="Rs_Loading" Text="Loading..." runat="server" meta:resourcekey="Rs_LoadingResource1" />
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />            
<%--    <script type="text/javascript" src="../Scripts/handsontable/lib/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/handsontable/dist/jquery.handsontable.full.js"></script>

    <script type="text/javascript" src="../Scripts/handsontable/lib/jQuery-contextMenu/jquery.contextMenu.js"></script>

    <script type="text/javascript" src="../Scripts/JsonScript.js"></script>

  
    
    </form>
</body>
</html>
