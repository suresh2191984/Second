 <%@ Page Language="C#" AutoEventWireup="true" CodeFile="MasterBulkUpload.aspx.cs"
    EnableEventValidation="false" Inherits="Deployability_MasterBulkUpload" %>

<%@ Register Src="~/CommonControls/AddressControl.ascx" TagName="AddressControl"
    TagPrefix="uc2" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .w-300
        {
            width: 245px;
        }
        .w-133
        {
            width: 133px;
        }
        .AutoCompleteClass .ui-autocomplete.ui-front
        {
            width: 160px !important;
            min-height: 20px;
            max-height: 200px;
            overflow: auto;
        }
        .AutoCompleteClass .ui-autocomplete.ui-front
        {
            width: 160px !important;
            min-height: 20px;
            max-height: 200px;
            overflow: auto;
        }
        .inline-block
        {
            display: inline-block;
        }
        #chk
        {
            width: 36px;
        }
        .searchPanel
        {
            width: 87%;
        }
        .style1
        {
            width: 400px;
        }
        .style2
        {
            width: 164px;
        }
        .fg-toolbar.ui-toolbar.ui-widget-header.ui-corner-tl.ui-corner-tr.ui-helper-clearfix, .fg-toolbar.ui-toolbar.ui-widget-header.ui-corner-bl.ui-corner-br.ui-helper-clearfix
        {
            background: none !important;
            border: 0 NONE !important;
            color: #000 !important;
        }
        table.dataTable thead th
        {
            border-bottom: 0 none !important;
        }
        .dataTables_wrapper
        {
            width: 100% !important;
        }
        table.dataTable thead th
        {
            padding: 2px 0 !important;
        }
        .w-100 .DataTables_sort_wrapper
        {
            width: 100px !important;
        }
        .w-112 .DataTables_sort_wrapper
        {
            width: 112px !important;
        }
        .w-120 .DataTables_sort_wrapper
        {
            width: 120px !important;
        }
        .w-135 .DataTables_sort_wrapper
        {
            width: 135px !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="1000">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <iframe id="iframeRR" runat="server" style="display: none;"></iframe>
    <iframe id="iframeExcel" runat="server" style="display: none;"></iframe>
    <div class="contentdata">

        <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

        <div id="TabsMenu" class="TabsMenu ">
            <ul id="RateTabsMenu">
                <li id="tabManageRates" onclick="ShowTabContent('tabManageRates','tabContentdvBulkData')"
                    class="active"><a href="#">
                        <asp:Label ID="lbltabManageRates" runat="server" Text="Masters Upload" /></a></li>
                <li id="tabAttachDocuments" onclick="ShowTabContent('tabAttachDocuments','tabContentdvRanges')">
                    <a href="#">
                        <asp:Label ID="lbltabAttachDocuments" runat="server" Text="Ranges Upload" /></a></li>
            </ul>
        </div>
        <br />
        <div id="tabContentdvBulkData" style="height: 490px;">
            <div class="borderGrey w-100p paddingT5 paddingB8 inline-block">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
                            <ProgressTemplate>
                                <div id="progressBackgroundFilter">
                                </div>
                                <div id="processMessage">
                                    <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF"
                                        meta:resourcekey="img1Resource1" />
                                </div>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                        <div id="divDetails" runat="server">
                            <asp:GridView ID="gvDetails" AutoGenerateColumns="true" CellPadding="5" runat="server"
                                Style="display: none">
                            </asp:GridView>
                        </div>
                        <table class="w-100p">
                            <tr class="lh30">
                                <td class="style2 paddingL10">
                                    <asp:Label ID="Label1" runat="server" Text="Select File Type"></asp:Label>
                                </td>
                                <td class="w-300">
                                    <asp:DropDownList ID="ddlfiletype" runat="server" class="medium">
                                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                                        <asp:ListItem Value="1">Excel(.xls)</asp:ListItem>
                                        <asp:ListItem Value="2">Excel(.xlsx)</asp:ListItem>
                                        <asp:ListItem Value="3">CSV(.csv)</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td class="style2 paddingL10">
                                    <asp:Label ID="lbltype" runat="server" Text="Select Content Type"></asp:Label>
                                </td>
                                <td class="w-300">
                                    <asp:DropDownList ID="ddltype" runat="server" class="medium">
                                    </asp:DropDownList>
                                </td>
                                <td id="tdchks" runat="server">
                                    <input type="button" id="btnloadsheet" class="btn" value="DownLoad Empty Template" />
                                    <input type="checkbox" onclick="showHide(this);" runat="server" class="hide" id="chk" />
                                    <asp:Label ID="lid" runat="server" Text="Is Download Existing RateType?" class="hide"></asp:Label>
                                </td>
                            </tr>
                            <tr id="tr" runat="server" class="hide lh30">
                                <td class="style2 paddingL10">
                                    <asp:Label ID="lblratetype" runat="server" Text="Select Rate Name"></asp:Label>
                                </td>
                                <td class="w-300">
                                    <asp:TextBox ID="txtCopyToRate" runat="server" CssClass="medium"></asp:TextBox>
                                </td>
                                <td>
                                    <input type="button" id="btndownloadtemplatedata0" class="btn" value="DownLoad With Data" />
                                </td>
                            </tr>
                            <tr>
                                <td class="style2 paddingL10">
                                    <asp:Label ID="lblselectfile" runat="server" Text="Get the input Excel file"></asp:Label>
                                </td>
                                <td class="w-300">
                                    <asp:FileUpload ID="fuRM" runat="server" CssClass="f-browse" />
                                </td>
                                <td>
                                    <table class="w-100p">
                                        <tr>
                                            <td class="w-52 a-left">
                                                <input type="button" id="btnupload" class="btn" value="Upload" />
                                            </td>
                                            <td id="tddownloadtemplatedata" runat="server" class="displaytd w-133">
                                                <input type="button" id="btndownloadtemplatedata" width="150px" class="btn" value="DownLoad With Data" />
                                            </td>
                                            <td class="a-left">
                                                <input type="button" id="btnclear" onclick="ClearFields();" class="btn" value="Clear" />
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div id="testgrid">
                    <table id="Gvmasters" class="w-100p gridView" runat="server">
                    </table>
                </div>
                <asp:Label ID="lbl" Text="" runat="server"></asp:Label>
                <asp:Label ID="Label2" Text="" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnRateTypeVal" runat="server" />
                <asp:GridView ID="grdResult" runat="server">
                </asp:GridView>
            </div>
        </div>
        <div class="a-left" id="tabContentdvRanges">
            <asp:UpdatePanel ID="upd" runat="server" UpdateMode="Conditional">
                <ContentTemplate>
                    <div class="borderGrey paddingT3 paddingB5 w-100p inline-block">
                        <table>
                            <tr class="lh30">
                                <td class="style2 paddingL10">
                                    <asp:Label ID="Label3" runat="server" Text="Select Range Type"></asp:Label>
                                </td>
                                <td class="w-300">
                                    <asp:DropDownList ID="ddlItems" runat="server" class="medium">
                                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                                        <asp:ListItem Value="1">Reference Range</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr class="lh30">
                                <td class="style2 paddingL10">
                                    <asp:Label ID="Label4" runat="server" Text="Select File Type"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlDocType" runat="server" class="medium">
                                        <asp:ListItem Value="0">--Select--</asp:ListItem>
                                        <asp:ListItem Value="1">Excel(.xls)</asp:ListItem>
                                        <asp:ListItem Value="2">Csv(.csv)</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                                <td>
                                    <asp:Button ID="btnDownload" runat="server" class="btn" Text="Download Empty Template" />
                                </td>
                                <td>
                                </td>
                            </tr>
                            <tr class="lh10">
                                <td class="style2 paddingL10">
                                    Get the input Excel file:
                                </td>
                                <td>
                                    <asp:FileUpload ID="fuRR" runat="server" />
                                </td>
                                <td colspan="2" class="a-left">
                                    <input type="button" id="btnUploadRange" class="btn" value="Upload" />
                                    <%-- <input type="button" id="btnDownloadRR" class="btn" value="Download" />--%>
                                    <input type="button" id="btnGetRR" class="btn" value="View" />
                                    <input type="button" id="btnclearRange" class="btn" value="Clear" />
                                </td>
                            </tr>
                        </table>
                        <div id="Hidegrid" class="center">
                            <asp:GridView ID="gvReferenceRange" runat="server" AutoGenerateColumns="false" class="w-100p gridView marginT10">
                                <Columns>
                                    <asp:BoundField ItemStyle-Width="150px" DataField="TestCode" HeaderText="Test Code" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="InvestigationName" HeaderText="Investigation Name" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="SubCategoryType" HeaderText="Sub Category Type" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="TypeMode" HeaderText="Type Mode" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="AgeRangeType" HeaderText="Age Range Type" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="AgeRange" HeaderText="Age Range" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="ValueTypeMode" HeaderText="Value Type Mode" />
                                    <asp:BoundField ItemStyle-Width="150px" DataField="Value" HeaderText="Value" />
                                </Columns>
                            </asp:GridView>
                        </div>
                        <iframe id="iframe1" style="display: none;"></iframe>
                        <asp:HiddenField ID="hdnFileName" runat="server" />
                        <asp:HiddenField ID="HiddenField1" runat="server" />
                        <asp:HiddenField ID="hdnFileUploadPath" runat="server" />
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div id="dvPrint">
                <table id="tbl" class="hide gridView w-100p">
                    <thead>
                        <tr style="font-size: 13px;">
                            <th class="w-100">
                                <asp:Label ID="lblTestCode" runat="server" Text="TestCode"></asp:Label>
                            </th>
                             <th >
                                <asp:Label ID="lblInvestigationName" runat="server" Text="InvestigationName"></asp:Label>
                            </th>
                            <th class="w-100">
                                <asp:Label ID="lblRangeType" runat="server" Text="RangeType"></asp:Label>
                            </th>
                            <th class="w-112">
                                <asp:Label ID="lblGenderValue" runat="server" Text="GenderValue"></asp:Label>
                            </th>
                            <th class="w-135">
                                <asp:Label ID="lblSubCategoryType" runat="server" Text="SubCategoryType"></asp:Label>
                            </th>
                            <th class="w-100">
                                <asp:Label ID="lblResultType" runat="server" Text="ResultType"></asp:Label>
                            </th>
                            <th class="w-112">
                                <asp:Label ID="lblTypeMode" runat="server" Text="TypeMode"></asp:Label>
                            </th>
                            <th class="w-112">
                                <asp:Label ID="lblAgeRangeType" runat="server" Text="AgeRangeType"></asp:Label>
                            </th>
                            <th class="w-100">
                                <asp:Label ID="lblAgeRange" runat="server" Text="AgeRange"></asp:Label>
                            </th>
                            <th class="w-100">
                                <asp:Label ID="lblReferenceName" runat="server" Text="ReferenceName"></asp:Label>
                            </th>
                            <th>
                                <asp:Label ID="lblValueTypeMode" runat="server" Text="ValueTypeMode"></asp:Label>
                            </th>
                            <th class="w-100">
                                <asp:Label ID="lblValue" runat="server" Text="Value"></asp:Label>
                            </th>
                            <th>
                                <asp:Label ID="lblIsNormal" runat="server" Text="IsNormal"></asp:Label>
                            </th>
                            <th>
                                <asp:Label ID="lblIsSourceText" runat="server" Text="IsSourceText"></asp:Label>
                            </th>
                            <th class="w-100">
                                <asp:Label ID="lblDevice" runat="server" Text="Device"></asp:Label>
                            </th>
                        </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
    <iframe id="iframe" style="display: none;"></iframe>
    <asp:HiddenField ID="hdnFilePath" runat="server" />

    <script type="text/javascript" language="javascript">
        function checkexlfileornot() {
            var result = true;
            var selectedfileformat = $("#ddlfiletype").val();
            var selectedtype = $("#ddltype").val();
            var fileElement = document.getElementById('<%=fuRM.ClientID%>');
            var fileExtension = "";
            if (fileElement.value.lastIndexOf(".") > 0) {
                fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
            }
            if (selectedfileformat == 0) {
                result = false;

                jAlert("Select the File type", "Alert Box");
                return false;
            }

            else if (selectedtype == 0) {
                result = false;

                jAlert("Select the Content Type", "Alert Box");
                return false;
            }

            else if (fileElement.value == '') {
                result = false;

                jAlert("Please Upload a file", "Alert Box");
                return false;
            }

            else if (selectedfileformat == 1 && fileExtension != 'xls') {
                result = false;
                jAlert("Incorrect Sheet", "Alert Box");

                return false;
            }
            else if (selectedfileformat == 2 && fileExtension != 'xlsx') {
                result = false;

                jAlert("Incorrect Sheet", "Alert Box");
                return false;
            }
            else if (selectedfileformat == 3 && fileExtension != 'csv') {
                result = false;
                jAlert("Incorrect Sheet", "Alert Box");

                return false;
            }
            else {
                result = true;
            }
            return result;
        }
        function ClearFields() {
            $('#ddlfiletype').val(0);
            $('#ddltype').val(0);
            if (/*@cc_on!@*/false || !!document.documentMode) {
                var fil = document.getElementById('<%=fuRM.ClientID%>');
                fil.select();
                n = fil.createTextRange();
                n.execCommand('delete');
                fil.focus(); return false;
            }
            else {
                document.getElementById('<%=fuRM.ClientID%>').value = '';
            }
        }
        function GetValidation() {
            var type = $("#ddltype").val(); // document.getElementById('ddltype').value;
            var Result = true;
            var filetype = $("#ddlfiletype").val(); // document.getElementById('ddlfiletype').value;
            if (filetype == '0') {
                jAlert("Select the File Type", "Alert Box");
                Result = false;
                return false;
            }
            if (type == '0') {
                jAlert("Select the Content Type", "Alert Box", "Alert Box");
                Result = false;
                return false;
            }
            if (type == 'RateMaster') {
                $('#chk').show();
                $('#lid').show();
                $('#chk').attr('checked', false);
                jAlert("Select the  download Existing RateType to download Data", "Alert Box");
                Result = false;
                return false;
            }
            if ((type == 'UserMaster')) {
                $('#btndownloadtemplatedata').prop('disabled', true);
                jAlert("Not allowed to download " + type + " " + "Data", "Alert Box");
                Result = false;
                return false;
            }
            else {
                $('#btndownloadtemplatedata').removeAttr('disabled');
            }
            return Result;
        }

        function GetValidationRateType() {
            var type = $("#ddltype").val(); // document.getElementById('ddltype').value;
            var filetype = $("#ddlfiletype").val(); // document.getElementById('ddlfiletype').value;
            var txtsearch = $('#hdnRateTypeVal').val();
            var Result = true;
            if (txtsearch == '') {
                jAlert("Select the Rate Type", "Alert Box");
                Result = false;
                return false;
            }
            if (filetype == '0') {
                jAlert("Select the File Type", "Alert Box");
                Result = false;
                return false;
            }
            if (type == '0') {
                jAlert("Select the Content type", "Alert Box");
                Result = false;
                return false;
            }
            if ((type == 'UserMaster')) {
                $('#btndownloadtemplatedata').prop('disabled', true);
                jAlert("Not allowed to download " + type + "Data", "Alert Box");
                Result = false;
                return false;
            }
            else {
                $('#btndownloadtemplatedata').removeAttr('disabled');
            }
            if ((type == 'RateMaster') && ($('#txtCopyToRate').val() == '')) {
                jAlert("Please select the Rate Type", "Alert Box");
                Result = false;
                return false;
            }
            return Result;
        }
       
    </script>

    <script language="javascript" type="text/javascript">

        function showHide(id) {
            var lfckv = $('#chk').prop('checked');
            var type = $("#ddltype").val();
            if ((lfckv)) {
                $('#tr').show();
            }
            else {
                $('#tr').hide();
                $('#tddownloadtemplatedata').show();
            }
            $('#txtCopyToRate').val("");
            $('#hdnRateTypeVal').val("");
            if ((lfckv) || (type == 'RateMaster')) {
                $('#tddownloadtemplatedata').hide();
            }
        }
        function LoadTable() {

            var orgid = '<%= OrgID %>';
            var createdby = '<%= LID %>';
            var type = $('#ddltype option:selected').text();
            $.ajax({
                type: "POST",
                url: "MasterBulkUpload.aspx/GetDataFromDB",
                data: "{'orgid': '" + orgid + "','type': '" + type + "','createdby':" + createdby + "}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                success: function(data) {
                    AjaxGetFieldDataSucceeded(data);
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    jAlert(thrownError, 'Alert Box');
                    return false;
                }
            });
        }

        function dtConvFromJSON(dateStr) {
            jsonDate = dateStr;
            var d = new Date(parseInt(jsonDate.substr(6)));
            var m, day;
            m = d.getMonth() + 1;
            if (m < 10)
                m = '0' + m
            if (d.getDate() < 10)
                day = '0' + d.getDate()
            else
                day = d.getDate();
            var formattedDate = m + "/" + day + "/" + d.getFullYear();
            var hours = (d.getHours() < 10) ? "0" + d.getHours() : d.getHours();
            var minutes = (d.getMinutes() < 10) ? "0" + d.getMinutes() : d.getMinutes();
            var formattedTime = hours + ":" + minutes + ":" + d.getSeconds();
            formattedDate = formattedDate + " " + formattedTime;
            return formattedDate;
        }
        function AjaxGetFieldDataSucceeded(result) {
            var oTable;
            if (result != "[]") {
                oTable = $('#Gvmasters').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "aaData": result.d,
                    "aoColumns": [

            { "mDataProp": "CreatedAt", sTitle: "Created Date", "mRender": function(data, type, full) { return dtConvFromJSON(data); } },
            { "mDataProp": "TestType", sTitle: "Master Type" },
            { "mDataProp": "UploadedFilename", sTitle: "Uploaded Filename" },
            { "mDataProp": "Username", sTitle: "Username" },
            { "mDataProp": "UploadedStatus", sTitle: "Status" }
            ],
                    "sPaginationType": "full_numbers",
                    "aaSorting": [],
                    "bJQueryUI": true,
                    "iDisplayLength": 15,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Scripts/DataTable/Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                                {
                                                    "sExtends": "xls",
                                                    "sFileName": "*.xls",
                                                    "bFooter": true

                                                }
                                              ]
                    }
                });
                $('#Gvmasters').show();
            }
        }


        $('#btndownloadtemplatedata0').click(function() {
            var result = GetValidationRateType();
            if (result) {
                $('#preloader').show();
                var filetype = $("#ddlfiletype").val(); //document.getElementById('ddlfiletype').value;
                var type = $("#ddltype").val();
                var OrgID = '<%= OrgID %>';
                var OrgName = '<%= OrgName %>';
                var LID = '<%= LID %>';
                var ratetext = $('#txtCopyToRate').val();
                var RateId = $('#hdnRateTypeVal').val();

                $('#iframeExcel').attr('src', 'MasteruploadExportToExcelHandler.ashx?FileType=' + filetype + '&Type=' + type + '&OrgID=' + OrgID + '&LID=' + LID + '&RateId=' + RateId + '&ratetext=' + ratetext + '&OrgName=' + OrgName);
                $('#iframeExcel').load();
            }
            $('#preloader').hide(5000);
        });


        $('#btndownloadtemplatedata').click(function() {
            var result = GetValidation();
            if (result) {
                $('#preloader').show();
                var filetype = document.getElementById('ddlfiletype').value;
                var type = $("#ddltype").val();
                var OrgID = '<%= OrgID %>';
                var OrgName = '<%= OrgName %>';
                var LID = '<%= LID %>';
                var ratetext = '';
                var RateId = 0;
                $('#iframeExcel').attr('src', 'MasteruploadExportToExcelHandler.ashx?FileType=' + filetype + '&Type=' + type + '&OrgID=' + OrgID + '&LID=' + LID + '&RateId=' + RateId + '&ratetext=' + ratetext + '&OrgName=' + OrgName);
                $('#iframeExcel').load();
                $('#preloader').hide(20000);
            }
        });


        function Getfilename() {
            var fileextension = ".xls";
            var filetype = $("#ddlfiletype").val();
            var selectedtype = $("#ddltype").val();
            var filename = '';
            if (filetype == "1") {
                fileextension = '.xls';
            }
            else if (filetype == "2") {

                fileextension = '.xlsx';
            }

            else {
                fileextension = '.csv';
            }

            if (selectedtype == "InvestigationMaster") {
                filename = "Investigationmaster" + fileextension;
            }
            if (selectedtype == "Group") {
                filename = "Groupmaster" + fileextension;
            }
            if (selectedtype == "Package") {
                filename = "Packagemaster" + fileextension;
            }
            if (selectedtype == "Group Content") {
                filename = "Groupcontent" + fileextension;
            }
            if (selectedtype == "Package Content") {
                filename = "Packagecontent" + fileextension;
            }
            if (selectedtype == "ClientMaster") {
                filename = "ClientMaster" + fileextension;
            }
            if (selectedtype == "ClientRateMapping") {
                filename = "ClientRateMapping" + fileextension;
            }
            if (selectedtype == "RateCard") {
                filename = "RateCard" + fileextension;
            }
            if (selectedtype == "RateMaster") {
                filename = "RateMaster" + fileextension;
            }
            if (selectedtype == "ReferingHospital") {
                filename = "ReferingHospital" + fileextension;
            }
            if (selectedtype == "RefferingPhysician") {
                filename = "RefferingPhysician" + fileextension;
            }
            if (selectedtype == "RefrenceRange") {
                filename = "RefrenceRange" + fileextension;
            }
            if (selectedtype == "TATDetails") {
                filename = "TATDetails" + fileextension;
            }
            if (selectedtype == "UserMaster") {
                filename = "UserMaster" + fileextension;
            }
if (selectedtype == "PhysicianMaster") {
                filename = "PhysicianMaster" + fileextension;
            }
            if (selectedtype == "LocationMaster") {
                filename = "LocationMaster" + fileextension;
            }
            if (selectedtype == "DeviceTestMap") {
                filename = "DeviceTestMap" + fileextension;
            }
            if (selectedtype == "BillofSupplyNumberInvoiceTemplate") {
                filename = "BillofSupplyNumberInvoiceTemplate" + fileextension;
            }          
            return filename;
        }

        function pageLoad() {
            LoadMetadata();
            var orgid = '<%= OrgID %>';
            $("#txtCopyToRate").autocomplete({
                source: function(request, response) {
                    $.ajax({
                        type: "POST",
                        url: "MasterBulkUpload.aspx/loadRateType",
                        data: "{'OrgID':'" + orgid + "' ,'txtSearchName':'" + $('#txtCopyToRate').val() + "' }",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function(data) {
                            var returnedData = JSON.parse(data.d);
                            response($.map(returnedData, function(item) {
                                return {
                                    label: item.RateName,
                                    val: item.RateId
                                }
                            }))
                        },
                        error: function(result) {
                            jAlert("Failed to load names", "Alert Box");
                        }
                    });
                },
                select: function(e, i) {
                    $('#hdnRateTypeVal').val(i.item.val);

                },
                minLength: 1

            });
            $('#ddltype').change(function() {
                LoadTable();
                var type = $("#ddltype").val();
                if ((type != 'UserMaster')) {
                    $('#btndownloadtemplatedata').removeAttr('disabled');
                }
                if ((type == 'RateMaster')) {
                    $('#tddownloadtemplatedata').hide();
                    $('#chk').attr('checked', false);
                    $('#chk').show();
                    $('#lid').show();
                }
                else if ((type == 'BillofSupplyNumberInvoiceTemplate')) {
                    $('#tddownloadtemplatedata').hide();
                    $('#chk').hide();
                    $('#lid').hide();
                    $('#tr').hide();
                  
                }
                else {
                    $('#chk').hide();
                    $('#lid').hide();
                    $('#tr').hide();
                    $('#tddownloadtemplatedata').show();
                }
            })
            check();
        }
        function check() {
            var type = $("#ddltype").val();

            if ((type == 'RateMaster')) {
                $('#txtCopyToRate').val("");
                $('#hdnRateTypeVal').val("");
                $('#chk').attr('checked', false);
                $('#chk').show();
                $('#lid').show();
            }
            return false;
        }

        function LoadMetadata() {

            var OrgID = '<%= OrgID %>';
            var InputParam = {};
            InputParam.OrgID = OrgID;
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MasterBulkUpload.aspx/LoadMetadata",
                data: JSON.stringify(InputParam),
                dataType: "json",
                success: function(data) {
                    var jsdata = JSON.parse(data.d);
                    $('#ddltype').empty();
                    $('#ddltype').append("<option value='0'>--Select--</option>");
                    $.each(jsdata, function(key, value) {
                        $('#ddltype').append($("<option></option>").val(value["Code"]).html(value["DisplayText"]));
                    });

                    return false;
                },
                error: function(result) {
                    jAlert("No Match", 'Alert Box');
                }
            });
        }

        $('#btnupload').click(function() {
            $('#preloader').show();
            fnUploadFileRM();
            $('#preloader').hide(1500);
        });

        function fnUploadFileRM() {
            var UploadFileName = $("#fuRM").val().split('\\').pop();
            var FileDetails;
            var filetype = $("#ddlfiletype").val();
            var type = $("#ddltype").val();
            var OrgID = '<%= OrgID %>';
            var LID = '<%= LID %>';
            if (UploadFileName != "") {
                if (!isAjaxUploadSupported()) { //IE fallfack
                    var iframe = document.createElement("<iframe name='upload_iframe' id='upload_iframe1'>");
                    iframe.setAttribute("width", "0");
                    iframe.setAttribute("height", "0");
                    iframe.setAttribute("border", "0");
                    iframe.setAttribute("src", "javascript:false;");
                    iframe.style.display = "none";
                    var form = document.createElement("form");
                    //form.setAttribute("class", "iefileupload");
                    form.setAttribute("target", "upload_iframe1");
                    form.setAttribute("action", "MasterfileuploadHandler.ashx?FileType=" + filetype + "&Type=" + type + "+&OrgID=" + OrgID + "&LID" + LID);
                    form.setAttribute("method", "post");
                    form.setAttribute("enctype", "multipart/form-data");
                    form.setAttribute("encoding", "multipart/form-data");
                    form.style.display = "inline-block";
                    form.style.left = "13%";
                    form.style.top = "39%";
                    form.style.position = "absolute";
                    var files = document.getElementById("fuRM");
                    form.appendChild(files);
                    document.body.appendChild(form);
                    document.body.appendChild(iframe);
                    iframeIdmyFile = document.getElementById("upload_iframe1");
                    form.submit();
                    var uplctrl = document.getElementById("fuRM");
                    uplctrl.select();
                    //clrctrl = uplctrl.createTextRange();
                    //clrctrl.execCommand('delete');
                    uplctrl.focus();
                    $('#fuRM').replaceWith($('#fuRM').clone());
                    return false;
                }
                else {
                    AddFiletoFolderRM();
                    $('#fuRM').val('');
                }
            }
            else {
                jAlert("Please Add File", 'Alert Box', 'Alert Box');
            }

            return false
        }
        function AddFiletoFolderRM() {
            var result = checkexlfileornot();
            if (result) {
                var fileUpload = $("#fuRM").get(0);
                var files = fileUpload.files;
                var FileDetails = new FormData();
                for (var i = 0; i < files.length; i++) {
                    FileDetails.append(files[i].name, files[i]);
                }

                var filetype = $("#ddlfiletype").val();
                var type = $("#ddltype").val();
                var OrgID = '<%= OrgID %>';
                var LID = '<%= LID %>';
                $.ajax({
                    url: 'MasterfileuploadHandler.ashx?FileType=' + filetype + '&Type=' + type + '&OrgID=' + OrgID + '&LID=' + LID,
                    type: "POST",
                    contentType: false,
                    processData: false,
                    data: FileDetails,
                    success: function(result) {
                        check();
                        $('#tr').hide();
                        if (result == 'Successfully Uploaded') {
                            ClearFields();
                            LoadTable();
                        }
                        else {
                            ClearFields();
                        }
                        jAlert(result, 'Alert Box');
                    },
                    error: function(err) {
                        jAlert(err.statusText, 'Alert Box');
                    }
                });
            }
        };

        $('#btnloadsheet').click(function() {
            var selectedfileformat = $('#ddlfiletype').val(); //document.getElementById('ddlfiletype').value;
            var selectedtype = $('#ddltype').val();
            if (selectedfileformat == 0) {
                jAlert("Select the File Type", "Alert Box");
                return false;
            }
            else if (selectedtype == 0) {
                jAlert("Select the Content Type", "Alert Box");
                return false;
            }
//            else if (selectedtype == 'RateMaster') {

//                jAlert("Not allowed to download empty template for RateMaster", "Alert Box");
//                return false;

//            }
            else {
                var orgid = '<%= OrgID %>';
                var filepath = $('#hdnFilePath').val();
                $('#iframe').attr('src', '../DownloadFile.ashx?OrgID=' + orgid + '&Filename=' + Getfilename() + '&Filepath=' + filepath);
                return false;
            }
        });

    </script>

    <script src="../Scripts/XMLWriter.js" type="text/javascript"></script>

    <script src="../Scripts/TableTools.min.js" type="text/javascript"></script>

    <link href="../Scripts/CustomAlerts/jquery.alerts.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/CustomAlerts/jquery.alerts.js" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">

        $(function() {
            $('[id^="tabContent"]').hide();
            $('#tabManageRates').addClass('active');
            $('#tabContentdvBulkData').show();
            //$('#tabContentdvRanges').show(); 
        });

        function ShowTabContent(tabId, DivId) {
            $('[id^="tabContent"]').hide();
            $('#TabsMenu li').removeClass('active');
            $('li#' + tabId).addClass('active');
            $('#' + DivId).show();

            if ($('#tabManageRates').hasClass('active')) {
                $("#fuRM").show();
                $("#fuRR").hide();
            }
            else {
                $("#fuRM").hide();
                $("#fuRR").show();
            }
            return false;
        }
        var OrgId = '<%=OrgID%>';
        function GetRR() {
            var RTestCode = '';
            var Iparams = {
                OrgId: OrgId
            };
            var SerializeXML = [];
            $.ajax({
                type: "POST",
                contentType: "application/json; charset=utf-8",
                url: "MasterBulkUpload.aspx/GetReferenceRange",
                data: JSON.stringify(Iparams),
                dataType: "json",
                success: function(data) {
                    fun_bindData(JSON.stringify(data.d));
                    $("#tbl").show();
                    $('.fg-toolbar').show();
                    $('#gvReferenceRange').hide();
                    jAlert('Getting Successfully..!', 'Alert Box')
                },
                error: function(result) {
                }
            });
        }
        function fun_bindData(JST) {
            RDL = [];
            if (JST) {
                $.each(JSON.parse(JST), function() {
                var TestCode = this.TestCode;
                var InvestigationName = this.InvestigationName;
                    var RangeType = this.RangeType;
                    var GenderValue = this.GenderValue;
                    var SubCategoryType = this.SubCategoryType;
                    var ReferenceName = this.ReferenceName;
                    var ResultType = this.ResultType;
                    var TypeMode = this.TypeMode;
                    var AgeRangeType = this.AgeRangeType;
                    var AgeRange = this.AgeRange;
                    var ValueTypeMode = this.ValueTypeMode;
                    var Value = this.Value;
                    var IsNormal = this.IsNormal;
                    var IsSourceText = this.IsSourceText;
                    var Device = this.Device;
                    RDL.push(
                                         [
                                            TestCode = TestCode,
                                            InvestigationName=InvestigationName,
                                            RangeType = RangeType,
                                            GenderValue = GenderValue,
                                            SubCategoryType = SubCategoryType,
                                            ResultType = ResultType,
                                            TypeMode = TypeMode,
                                            AgeRangeType = AgeRangeType,
                                            AgeRange = AgeRange,
                                            ReferenceName = ReferenceName,
                                            ValueTypeMode = ValueTypeMode,
                                            Value = Value,
                                            IsNormal = IsNormal,
                                            IsSourceText = IsSourceText,
                                            Device = Device
                                         ]);
                });
            }

            $("#tbl > tbody > tr").remove();
            $('#tbl').dataTable({
                "bDestroy": true,
                "bProcessing": true,
                "bPaginate": true,
                "bFooter": true,
                "bDeferRender": true,
                "bSortable": true,
                "aoColumns": [null, null, null, null, null, null, null, null, null, null, null, null, null, { "bVisible": false}],
                "bJQueryUI": true,
                "aaData": RDL,
                'bSort': true,
                'bFilter': true,
                "iDisplayLength": 10,
                "aaSorting": [],
                'sPaginationType': 'full_numbers',
                "sDom": '<"H"Tfr>t<"F"ip>',
                "oTableTools": {
                    "sSwfPath": "../Scripts/DataTable/Media/copy_csv_xls_pdf.swf",
                    "aButtons": [
                                               {
                                                   "sExtends": "xls",
                                                   "sPdfOrientation": "landscape",
                                                   "sButtonText": "Export To Excel",
                                                   "sToolTip": "Export To Excel"
                                               }
                                             ]
                }
            });

        }

        $('#Hidegrid').hide();
        var RtnXML = [];
        var BulkRR = [];
        function GetRange(InputPath) {
            var params = {
                InputPath: InputPath,
                FileName: $('#hdnFileName').val()
            };
            return $.ajax({
                type: "POST",
                url: "MasterBulkUpload.aspx/GetRangeDetails",
                data: JSON.stringify(params),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function(response) {
                    jAlert(response.d, 'Alert Box');
                },
                error: function(response) {
                    jAlert(response.d, 'Alert Box');
                }
            });
        }
        function OnSuccess(response) {
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            var customers = xml.find("Table");
            var row = $("[id*=gvReferenceRange] tr:last-child").clone(true);
            var PreTCode = "", Flag = "N", FinalOut = "", ProTag = "", PreRootNode = "";
            var TCode = "", CurrentNode = "";
            $("[id*=gvReferenceRange] tr").not($("[id*=gvReferenceRange] tr:first-child")).remove();

            var XML = new XMLWriter();
            $.each(customers, function() {
                var RangeType = $(this).find("RangeType").text() == undefined ? '' : $.trim($(this).find("RangeType").text());
                var InvestigationName = $(this).find("InvestigationName").text() == undefined ? '' : $.trim($(this).find("InvestigationName").text());
                var SubCategoryType = $(this).find("SubCategoryType").text() == undefined ? '' : $.trim($(this).find("SubCategoryType").text());
                var GenderValue = $(this).find("GenderValue").text() == undefined ? '' : $.trim($(this).find("GenderValue").text());
                var ResultType = $(this).find("ResultType").text() == undefined ? '' : $.trim($(this).find("ResultType").text());
                var TypeMode = $(this).find("TypeMode").text() == undefined ? '' : $.trim($(this).find("TypeMode").text());
                var AgeRangeType = $(this).find("AgeRangeType").text() == undefined ? '' : $.trim($(this).find("AgeRangeType").text());
                var AgeRange = $(this).find("AgeRange").text() == undefined ? '' : $.trim($(this).find("AgeRange").text());
                var ReferenceName = $(this).find("ReferenceName").text() == undefined ? '' : $.trim($(this).find("ReferenceName").text());
                var ValueTypeMode = $(this).find("ValueTypeMode").text() == undefined ? '' : $.trim($(this).find("ValueTypeMode").text());
                var Value = $(this).find("Value").text() == undefined ? '' : $.trim($(this).find("Value").text());
                var IsNormal = $(this).find("IsNormal").text() == undefined ? '' : $.trim($(this).find("IsNormal").text());
                var IsSourceText = $(this).find("IsSourceText").text() == undefined ? '' : $.trim($(this).find("IsSourceText").text());
                var data = $(this).find("data").text() == undefined ? '' : $.trim($(this).find("data").text());
                var result = $(this).find("result").text() == undefined ? '' : $.trim($(this).find("result").text());
                var Device = $(this).find("Device").text() == undefined ? '' : $.trim($(this).find("Device").text());
                TCode = $(this).find("TestCode").text() == undefined ? '' : $.trim($(this).find("TestCode").text());
                CurrentNode = RangeType;
                //Generate UDT:

                var tmpListRR = new Object();
                tmpListRR['TestCode'] = TCode;
                tmpListRR['RangeType'] = RangeType;
                tmpListRR['GenderValue'] = GenderValue;
                tmpListRR['SubCategoryType'] = SubCategoryType;
                tmpListRR['ResultType'] = ResultType;
                tmpListRR['TypeMode'] = TypeMode;
                tmpListRR['AgeRangeType'] = AgeRangeType;
                tmpListRR['AgeRange'] = AgeRange;
                tmpListRR['ReferenceName'] = ReferenceName;
                tmpListRR['ValueTypeMode'] = ValueTypeMode;
                tmpListRR['Value'] = Value;
                tmpListRR['IsNormal'] = IsNormal;
                tmpListRR['IsSourceText'] = IsSourceText;
                tmpListRR['Status'] = true;
                tmpListRR['orgID'] = OrgId;
                tmpListRR['ReferenceRange'] = '';
                tmpListRR['Interpretation'] = '';
                tmpListRR['InvestigationID'] = 0;
                tmpListRR['InvestigationName'] = InvestigationName;
                BulkRR.push(tmpListRR);
                //&& RangeType.toLowerCase() == 'referencerange'
                if (TCode != '' && TCode != null) {
                    if (TCode != PreTCode && Flag != 'N') {
                        XML.EndNode();
                        XML.EndNode();
                        FinalOut = XML.ToString();
                        XML = new XMLWriter();
                        GenerateUTD(FinalOut, PreTCode);
                    }
                    if (TCode != PreTCode) {
                        var shema = "1.0"; var SV = "utf-16";
                        var Hnamespace = "<?xml version=\"" + shema + "\" encoding=\"" + SV + "\"?>";
                        XML.WriteString(Hnamespace);
                        XML.BeginNode("referenceranges");
                    }
                    if (TCode != PreTCode) {
                        PreRootNode = "";
                        if (CurrentNode != PreRootNode) {
                            XML.BeginNode(RangeType);
                        }
                    }
                    if (TCode == PreTCode) {
                        if (CurrentNode != PreRootNode) {
                            XML.EndNode();
                            XML.BeginNode(RangeType);
                        }
                    }
                    Flag = 'S';
                    // Load Grid values
                    $("td", row).eq(0).html(TCode);
                    $("td", row).eq(1).html(InvestigationName);
                    $("td", row).eq(2).html(SubCategoryType);
                    $("td", row).eq(3).html(TypeMode);
                    $("td", row).eq(4).html(AgeRangeType);
                    $("td", row).eq(5).html(AgeRange);
                    $("td", row).eq(6).html(ValueTypeMode);
                    $("td", row).eq(7).html(Value);
                    $("[id*=gvReferenceRange]").append(row);
                    row = $("[id*=gvReferenceRange] tr:last-child").clone(true);

                    //Generate xml schema.
                    if (SubCategoryType.toLowerCase() == 'age') {
                        XML.BeginNode("property");
                        XML.Attrib("type", 'age');
                        XML.Attrib("value", GenderValue);
                        XML.Attrib("mode", TypeMode);

                        if (ConvertOperator(AgeRangeType) == "lst") ProTag = "lst"
                        else if (ConvertOperator(AgeRangeType) == "lsq") ProTag = "lsq"
                        else if (ConvertOperator(AgeRangeType) == "eql") ProTag = "eql"
                        else if (ConvertOperator(AgeRangeType) == "grt") ProTag = "grt"
                        else if (ConvertOperator(AgeRangeType) == "grq") ProTag = "grq"
                        else if (ConvertOperator(AgeRangeType) == "btw") ProTag = "btw"
                        else if (ConvertOperator(AgeRangeType) == "ref") ProTag = "ref"
                        XML.BeginNode(ProTag);
                        XML.Attrib("mode", ConvertOperator(ValueTypeMode));
                        XML.Attrib("gender", GenderValue);
                        XML.Attrib("agetype", TypeMode);
                        XML.Attrib("data", data);
                        XML.Attrib("result", result);
                        XML.Attrib("device", Device);
                        XML.Attrib("value", Value);
                        XML.WriteString(AgeRange);
                    }
                    else if (SubCategoryType.toLowerCase() == 'common') {
                        XML.BeginNode("property");
                        XML.Attrib("type", 'common');
                        XML.Attrib("value", GenderValue);

                        if (ConvertOperator(ValueTypeMode) == "lst") ProTag = "lst"
                        else if (ConvertOperator(ValueTypeMode) == "lsq") ProTag = "lsq"
                        else if (ConvertOperator(ValueTypeMode) == "eql") ProTag = "eql"
                        else if (ConvertOperator(ValueTypeMode) == "grt") ProTag = "grt"
                        else if (ConvertOperator(ValueTypeMode) == "grq") ProTag = "grq"
                        else if (ConvertOperator(ValueTypeMode) == "btw") ProTag = "btw"
                        else if (ConvertOperator(ValueTypeMode) == "ref") ProTag = "ref"

                        XML.BeginNode(ProTag);
                        XML.Attrib("data", data);
                        XML.Attrib("result", result);
                        XML.Attrib("device", Device);
                        XML.Attrib("value", GenderValue);
                        XML.WriteString(Value);
                    }
                    else if (SubCategoryType.toLowerCase() == 'other') {
                        XML.BeginNode("property");
                        XML.Attrib("type", 'other');
                        XML.Attrib("value", GenderValue);
                        XML.Attrib("ResultType", ResultType);
                        XML.Attrib("agetype", TypeMode);

                        if (ConvertOperator(ValueTypeMode) == "lst") ProTag = "lst"
                        else if (ConvertOperator(ValueTypeMode) == "lsq") ProTag = "lsq"
                        else if (ConvertOperator(ValueTypeMode) == "eql") ProTag = "eql"
                        else if (ConvertOperator(ValueTypeMode) == "grt") ProTag = "grt"
                        else if (ConvertOperator(ValueTypeMode) == "grq") ProTag = "grq"
                        else if (ConvertOperator(ValueTypeMode) == "btw") ProTag = "btw"
                        else if (ConvertOperator(ValueTypeMode) == "ref") ProTag = "ref"

                        if (ResultType.toLowerCase() == 'numeric') {
                            XML.BeginNode(ProTag);
                            XML.Attrib("gender", GenderValue);
                            XML.Attrib("Normal", IsNormal);
                            if (TypeMode != null && TypeMode != '') {
                                XML.Attrib("agetype", TypeMode);
                                XML.Attrib("ageopr", ConvertOperator(AgeRangeType));
                                XML.Attrib("agerange", AgeRange);
                            }
                            XML.Attrib("data", data);
                            XML.Attrib("result", result);
                            XML.Attrib("device", Device);
                            XML.Attrib("value", Value);
                        }
                        else if (ResultType.toLowerCase() == 'text') {
                            var DynamicNode = '';
                            if (IsSourceText == 'Y') DynamicNode = 'ref';
                            else DynamicNode = 'txt';

                            XML.BeginNode(DynamicNode);
                            XML.Attrib("gender", GenderValue);
                            XML.Attrib("Normal", IsNormal);
                            if (TypeMode != null && TypeMode != '') {
                                XML.Attrib("agetype", TypeMode);
                                XML.Attrib("ageopr", ConvertOperator(AgeRangeType));
                                XML.Attrib("agerange", AgeRange);
                            }
                            XML.Attrib("data", data);
                            XML.Attrib("result", result);
                            XML.Attrib("device", Device);
                            XML.Attrib("value", Value);
                        }
                        else {
                            XML.BeginNode(ProTag);
                            XML.Attrib("gender", GenderValue);
                            XML.Attrib("value", Value);
                        }
                        XML.WriteString(ReferenceName);
                    }

                    XML.EndNode();
                    XML.EndNode();
                    PreTCode = $(this).find("TestCode").text();
                    PreRootNode = $(this).find("RangeType").text();
                    //Generate xml schema end.
                }
            });
            XML.Close();
            GenerateUTD(XML.ToString(), TCode);
            function GenerateUTD(inputXml, TCode) {
                var tmpInputXML = new Object();
                tmpInputXML['TestCode'] = TCode;
                tmpInputXML['ReferenceRange'] = inputXml;
                RtnXML.push(tmpInputXML);
            }
        }
        function btnSave() {
            var stfun = [];
            stfun.push(fnUploadFile());
            $.when.apply(this, stfun).done(function() {
                var Urlpath = ($('#hdnFileUploadPath').val() + $('#hdnFileName').val()).replace(/~/g, "\\");
                stfun.push(GetRange(Urlpath));
                $.when.apply(this, stfun).done(function() {
                    parameters = {
                        InputList: RtnXML,
                        InvBulkRR: BulkRR,
                        FileName: $('#hdnFileName').val(),
                        OrgId: OrgId
                    };
                    $.ajax({
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        url: "MasterBulkUpload.aspx/SaveReferenceRange",
                        data: JSON.stringify(parameters),
                        dataType: "json",
                        success: function(data) {
                            $('#Hidegrid').show();
                            RtnXML = [];
                            BulkRR = [];
                            jAlert(data.d, 'Alert Box');
                        },
                        error: function(result) {
                        }
                    });
                });
            });
            return false;
        }
        function ConvertOperator(Symbol) {
            switch (Symbol) {
                case "<":
                    return "lst";
                    break;
                case "<=":
                    return "lsq";
                    break;
                case "=":
                    return "eql";
                    break;
                case ">":
                    return "grt";
                    break;
                case "=>":
                    return "grq";
                    break;
                case "Between":
                    return "btw";
                    break;
                case "Source":
                    return "ref";
                    break;
            }
        }

        function ConvertStringToOperator(InputString) {
            switch (InputString) {
                case "lst":
                    return "<";
                    break;
                case "lsq":
                    return "<=";
                    break;
                case "eql":
                    return "=";
                    break;
                case "grt":
                    return ">";
                    break;
                case "grq":
                    return "=>";
                    break;
                case "btw":
                    return "Between";
                    break;
                case "ref":
                    return "Source";
                    break;
            }
        }

        $(document).ready(function() {
            LoadTable();
            //File validation
            $('#btnUploadRange').click(function() {
                if ($('#ddlItems').val() != 0 && $('#ddlDocType').val() != 0) {
                    var file = $("#fuRR").val();
                    if (!file) {
                        jAlert('The input file is required.', 'Alert Box');
                        return false;
                    }
                    else {
                        var GetUF = $("#fuRR").val().split('\\').pop();
                        var ddlext = '';
                        var ext = GetUF.split('.').pop();

                        if ($('#ddlDocType').val() == 1) ddlext = 'xls';
                        else if ($('#ddlDocType').val() == 2) ddlext = 'csv';

                        if (ddlext.toLowerCase() == ext.toLowerCase()) {
                            $('#preloader').show();
                            btnSave();
                            $('#preloader').hide(1500);
                            $('#tbl').hide();
                            $('#gvReferenceRange').show();
                            $('.fg-toolbar').hide();
                            return false;
                        }
                        else {
                            jAlert('Upload file and File Type Not matched', 'Alert Box');
                            return false;
                        }
                    }
                }
                else {
                    jAlert('Must Provide Range Type and Doc Type', 'Alert Box');
                    return false;
                }
            });

            $('#btnDownload').click(function() {
                if ($('#ddlItems').val() != 0) {
                    $('#iframe').attr('src', '../DownloadFile.ashx?Filename=ReferenceRange_Bulk.xls&Filepath=' + $('#hdnFilePath').val());
                    return false;
                }
                else {
                    jAlert('Must Provide Range Type ', 'Alert Box');
                    return false;
                }
            });

            $('#btnGetRR').click(function() {
                if ($('#ddlItems').val() != 0) {
                    $('#preloader').show();
                    var stfun = [];
                    stfun.push(GetRR());
                    $.when.apply(this, stfun).done();
                }
                else {
                    jAlert('Must Provide Range Type', 'Alert Box');
                }
                $('#preloader').hide(2000);
                return false;
            });
            $('#btnclearRange').click(function() {
                $('#ddlItems').val(0);
                $('#ddlDocType').val(0);
                $('#fuRR').val('');
            });
            //            $('#btnDownloadRR').click(function() {
            //                alert();
            //                $('#iframeRR').attr('src', 'DownloadBulkRR.ashx?OrgID=112');
            //            });


            $('#fuRR').change(function() {
                var GetUF = $("#fuRR").val().split('\\').pop();
                var ext = GetUF.split('.').pop();
//                if (ext.toLowerCase() != 'xls' || ext.toLowerCase() != 'csv') {
//                    jAlert('Only Accept .xls or .csv files. please save your file these format only..');
//                    $('#fuRR').val('');
//                    return false;
//                }
            });
        });

        function AddFiletoFolderRR(UploadFileName) {
            var fileUpload = $("#fuRR").get(0);
            var files = fileUpload.files;
            var FileDetails = new FormData();
            for (var i = 0; i < files.length; i++) {
                FileDetails.append(files[i].name, files[i]);
            }
            return $.ajax({
                url: "../FileUpload.ashx?Filepath=" + $('#hdnFileUploadPath').val().replace(/~/g, "\\") + "&Filename=" + UploadFileName,
                type: "POST",
                contentType: false,
                processData: false,
                data: FileDetails,
                success: function(result) {
                },
                error: function(err) {
                    jAlert('Error', 'Alert Box');
                }
            });
        }

        function fnUploadFile() {
            var UploadFileName = $("#fuRR").val().split('\\').pop();
            $('#hdnFileName').val(UploadFileName);
            if (UploadFileName != "") {
                if (!isAjaxUploadSupported()) { //IE fallfack
                    var iframe = document.createElement("<iframe name='upload_iframe' id='upload_iframe'>");
                    iframe.setAttribute("width", "0");
                    iframe.setAttribute("height", "0");
                    iframe.setAttribute("border", "0");
                    iframe.setAttribute("src", "javascript:false;");
                    iframe.style.display = "none";

                    var form = document.createElement("form");
                    //form.setAttribute("class", "iefileupload");
                    form.setAttribute("target", "upload_iframe");
                    form.setAttribute("action", "../FileUpload.ashx?Filepath=" + $('#hdnFileUploadPath').val().replace(/~/g, "\\") + "&Filename=" + UploadFileName);
                    form.setAttribute("method", "post");
                    form.setAttribute("enctype", "multipart/form-data");
                    form.setAttribute("encoding", "multipart/form-data");
                    form.style.display = "inline-block";
                    form.style.left = "13%";
                    form.style.top = "39%";
                    form.style.position = "absolute";
                    var files = document.getElementById("fuRR");
                    form.appendChild(files);
                    document.body.appendChild(form);
                    document.body.appendChild(iframe);
                    iframeIdmyFile = document.getElementById("upload_iframe");
                    form.submit();
                    var uplctrl = document.getElementById("fuRR");
                    uplctrl.select();
                    //clrctrl = uplctrl.createTextRange();
                    //clrctrl.execCommand('delete');
                    uplctrl.focus();
                    $('#fuRR').replaceWith($('#fuRR').clone());
                    $("#txtFileName").val('');
                    $("#txtDate").val('');
                    $("#txtType").val('');
                    return false;
                }
                else {
                    AddFiletoFolderRR(UploadFileName);
                    $('#fuRR').val('');
                }
            }
            else {
                jAlert("Please Add File", 'Alert Box', 'Alert Box');
            }

            return false
        }
        function isAjaxUploadSupported() {
            var input = document.createElement("input");
            input.type = "file";
            return (
		        "multiple" in input &&
		            typeof File != "undefined" &&
		            typeof FormData != "undefined" &&
		            typeof (new XMLHttpRequest()).upload != "undefined");
        }
        
    </script>

    </form>
</body>
</html>
