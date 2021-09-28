<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TATTestConfiguration.aspx.cs"
    Inherits="Admin_TATTestConfiguration" EnableEventValidation="false" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<!--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %> -->
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter"
    TagPrefix="Attune" %>
<%--<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/UserHeader.ascx" TagName="UserHeader" TagPrefix="uc6" %>
<%@ Register Src="~/CommonControls/PatientHeader.ascx" TagName="PatientHeader"
    TagPrefix="uc3" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>TAT Test Configuration</title>

    <script src="Scripts/CommonBilling.js" type="text/javascript"></script>

    <style>
        .wordWheel.listMain
        {
            z-index: 99999;
        }
        .hide_column
        {
            display: none;
        }
        .dataTables_scrollHeadInner .dataTable
        {
            display: table !important;
        }
        #tblCategoryTest .dataTables_scrollHead ui-state-default
        {
            width: 49% !important;
        }
        #tblTATDelete .dataTables_scrollHead ui-state-default
        {
            width: 49% !important;
        }
        #tblTATDelete_wrapper .dataTables_scrollBody
        {
            max-height: 300px !important;
            min-height: 20px !important;
            height: auto !important;
        }
        #tblCategoryTest_wrapper .dataTables_scrollBody
        {
            max-height: 300px !important;
            min-height: 20px !important;
            height: auto !important;
        }
        #tblclientTAT_wrapper .dataTables_scrollBody
        {
            max-height: 300px !important;
            min-height: 20px !important;
            height: auto !important;
        }
        table.dataTable thead th div.DataTables_sort_wrapper
        {
            position: relative;
            padding-right: 2px !important;
        }
        TABLE.dataTable
        {
            margin: 2px !important;
            clear: both;
            width: 700px !important;
            border-collapse: collapse;
        }
        #tblCategoryTest .fg-toolbar ui-toolbar ui-widget-header ui-corner-tl ui-corner-tr ui-helper-clearfix
        {
            display: none !important;
        }
        .dataheader2
        {
            background-color: #2c88b1;
            width: 250px;
            font-size: 12px;
            font-weight: bold;
            color: #FFFFFF;
            margin-left: 15px;
        }
        .dataheader1
        {
            background-color: rgba(70, 125, 142, 0.88);
            color: Black !important;
        }
        .dataheaderPopup, .dataheaderInvCtrl1
        {
            width: 100% !important;
        }
        .dataheaderInvCtrl1 td
        {
            padding: 3px 5px;
        }
        .childDate
        {
            margin: 0px;
        }
        .dataTable
        {
        	border:1px solid silver;
        }
    </style>
    

    <script type="text/javascript" language="javascript">
            var flag = 0;
    
   
        function ClientSelected(source, eventArgs) {

            var Name = eventArgs.get_text();
            document.getElementById('hdnClientId').value = eventArgs.get_value();
            GetClientTATData();
            $('#DivResultview').hide();
            $('#tblCategoryTest').hide();


        }
        function setAceWidth(source, eventArgs) {
            document.getElementById('aceClientNameSrch').style.width = 'auto';
            document.getElementById('aceTATNameSearch').style.width = 'auto';
            document.getElementById('aceCategoryItemSearch').style.width = 'auto';
        }

        function TATSelected(source, eventArgs) {
            flag = 1;
            var Name = eventArgs.get_text();
            document.getElementById('hdnTATScheduleID').value = eventArgs.get_value();
            var tat = document.getElementById('hdnTATScheduleID').value;
            var clientId = document.getElementById('hdnClientId').value;
            //            if (tat != '' && clientId != 0) {
            //                GetClientTATData();
            //            }
            //            else if (tat != '' && clientId == 0) { GetTATData(); }
            var ConfigID = $("#ddlConfigFor option:selected").val();
            if (tat != '' && ConfigID == 0) {
                GetTATData();
                $('#DivResultview').hide();
                $('#tblCategoryTest').hide();
            }
        }

        function CategorySelected(source, eventArgs) {

            var Name = eventArgs.get_text();
            document.getElementById('hdnCateogoryID').value = eventArgs.get_value();


        }
        function SelectedTemp(source, eventArgs) {
            document.getElementById('hdnSelectedTATTempDetails').value = eventArgs.get_value();
            Tblist();

        }

        function Tblist() {
            $('[id$="trTATDetails"]').show();
            var table = '';
            var tr = '';
            var end = '</table>';
            var y = '';
            $('[id$="lblTATDetails"]').html("");
            table = "<table cellpadding='1' class='dataheaderInvCtrl1' cellspacing='0' border='1'"
                           + "style='width:100% height:250px'><thead  align='Center' class='dataheader1' style='font-size:11px'>"
                           + "<th bgcolor='#f7b64a'>TAT Code</th>"
                            + "<th bgcolor='#f7b64a'>TAT Name</th>"

                                + "<th bgcolor='#f7b64a'>Early ReportTime</th>"
                                + "<th bgcolor='#f7b64a'>Reportedon</th>"
                                + "<th bgcolor='#f7b64a'>ProcessingTime(HH:MM)</th>"
                                 + "<th bgcolor='#f7b64a'>Mode</th>"
                               + "<th bgcolor='#f7b64a'>Frequency</th>"


                                + "<th bgcolor='#f7b64a'>Frequency Schedule</th>"
            + "<th bgcolor='#f7b64a'>ScheduleHolidayday</th>"
            + "<th bgcolor='#f7b64a'>Start - Cutoff Time</th>";

            var ResultValues = document.getElementById('hdnSelectedTATTempDetails').value.split("^");
            var MainTableValues = ResultValues[0].split("~");


            var Childtable = '';
            var Childtr = '';
            var Childend = '</table>';
            var Childy = '';
            var ChildTableValues = ResultValues[1].split("~");
            var icount = 0;
            Childtable = "<table cellpadding='1' class='dataheaderInvCtrl' cellspacing='0' border='1'"
                           + "style='width:25%'><thead class='dataheader2' style='font-size:11px '  >";

            for (var i = 0; i < ChildTableValues.length; i++) {

                Childtr += '<p class="childDate">' + ChildTableValues[i] + '</p>';

            }

            var tabchild = Childtable + Childtr + Childend;



            tr = "<tr bgcolor='#f6f6f6' style='font-size:10px;height:10px;font-color:#0a0101' align='Center'><td >"
                        + MainTableValues[0] + "</td><td>"
                        + MainTableValues[3] + "</td><td>"

                        + MainTableValues[2] + "</td><td>"
                        + MainTableValues[4] + "</td><td>"
                        + MainTableValues[5] + "</td><td>"
                         + MainTableValues[8] + "</td><td>"
                        + MainTableValues[9] + "</td><td>"


                       + MainTableValues[12] + "</td><td>"
                        + MainTableValues[11] + "</td><td>"
                        + Childtr + "</td>"
            var tab = table + tr + end;
            $('[id$="lblTATDetails"]').html(tab);
            tbshow();

        }
       
        
    </script>

</head>
<body oncontextmenu="return false;" onload="javascript:getFocus();">
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
 <Attune:Attuneheader ID="Attuneheader" runat="server" />
     <div class="contentdata">
        <table border="0" cellpadding="0" cellspacing="0" width="100%" class="tableborder">
            <tr>                
                <td width="100%" valign="top" class="tdspace">                     
                    <div class="contentdata">
                        <ul>
                            <li>
                               <%-- <uc7:ErrorDisplay ID="ErrorDisplay1" runat="server" /> --%>
                            </li>
                        </ul>
                        <asp:UpdatePanel ID="UdtPanel" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="pnlCntrl" Width="100%" runat="server">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblConfigFor" Text="Configure For" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlConfigFor" runat="server">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <%--<td id="Td3">--%>
                                            <td id="Td3" runat="server" style="display: None;">
                                                <asp:Label ID="Rs_SupplierName" Text="Client Name" runat="server"></asp:Label>
                                                <%--</td>
                                                <td id="Td4" runat="server" >--%>
                                                <asp:TextBox ID="txtClientNameSrch" runat="server" MaxLength="20" AutoComplete="off"></asp:TextBox>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                                <div id="aceClientNameSrch">
                                                </div>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender9" runat="server" TargetControlID="txtClientNameSrch"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="3" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetHospAndRefPhy"
                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True"
                                                    OnClientItemSelected="ClientSelected" CompletionListElementID="aceClientNameSrch"
                                                    OnClientShown="setAceWidth">
                                                </ajc:AutoCompleteExtender>
                                                <input id="hdnClientId" type="hidden" value="0" runat="server" />
                                            </td>
                                            <%--</td>--%>
                                            <td>
                                                <asp:Label ID="lblTATCode" Text="TAT Code" runat="server"></asp:Label>
                                                <asp:TextBox runat="server" ID="txtTATCode"></asp:TextBox>
                                                <asp:Label ID="lblmsg" Text="please select tat code to save the test" BackColor="Red"
                                                    Style="display: none;" runat="server"></asp:Label>
                                                <div id="aceTATNameSearch">
                                                </div>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender8" runat="server" TargetControlID="txtTATCode"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="3" OnClientItemOver="SelectedTemp" CompletionInterval="1"
                                                    FirstRowSelected="True" ServiceMethod="GetTATSchedulecode" ServicePath="~/WebService.asmx"
                                                    DelimiterCharacters="" Enabled="True" UseContextKey="True" OnClientItemSelected="TATSelected"
                                                    CompletionListElementID="aceTATNameSearch" OnClientShown="setAceWidth">
                                                </ajc:AutoCompleteExtender>
                                                <input id="hdnTATScheduleID" type="hidden" value="0" runat="server" />
                                            </td>
                                            <td id="trTATDetails" style="display: none;">
                                                <div id="showimage" style="display: none; position: absolute; width: 94%; left: 3%;
                                                    top: 4%">
                                                    <div onclick="hidebox();return false" class="divCloseRight">
                                                    </div>
                                                    <table border="0" width="100%" cellspacing="0" class="modalPopup dataheaderPopup"
                                                        cellpadding="0">
                                                        <tr>
                                                            <td id="dragbar" style="cursor: move; cursor: pointer" width="100%" onmousedown="initializedrag(event)">
                                                                <asp:Label ID="lblTATDetails" runat="server"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <%--  <td>
                                                <asp:Button ID="btnSearch" CssClass="btn" runat="server" Text="Search" />
                                            </td>--%>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblMapCategory" Text="Map To Category" runat="server"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlMapCategory" runat="server">
                                                </asp:DropDownList>
                                                &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" />
                                            </td>
                                            <td>
                                                <asp:Label ID="lblCategoryItem" Text="Category Item" runat="server"></asp:Label>
                                                <%--</td>
                                            <td>--%>
                                                <asp:TextBox ID="txtCategoryItem" runat="server" CssClass="AutoCompletesearchBox"
                                                    onKeyPress="javascript:ClearCategoryID();"></asp:TextBox>
                                                <div id="aceCategoryItemSearch">
                                                </div>
                                                <ajc:AutoCompleteExtender ID="AutoCompleteExtender7" runat="server" TargetControlID="txtCategoryItem"
                                                    CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                                    CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" EnableCaching="False"
                                                    MinimumPrefixLength="3" CompletionInterval="1" FirstRowSelected="True" ServiceMethod="GetTATSchedulecategoryItemAutoComplete"
                                                    ServicePath="~/WebService.asmx" DelimiterCharacters="" Enabled="True" UseContextKey="True"
                                                    OnClientItemSelected="CategorySelected" CompletionListElementID="aceCategoryItemSearch"
                                                    OnClientShown="setAceWidth">
                                                </ajc:AutoCompleteExtender>
                                                <input id="hdnCateogoryID" type="hidden" value="0" runat="server" />
                                            </td>
                                            <td>
                                                <asp:Button ID="btnLoad" CssClass="btn" runat="server" Text="Load" OnClientClick="javascript:return GetData();" />
                                                <asp:Button ID="btnClear" CssClass="btn" runat="server" Text="Clear" OnClientClick="javascript:return cancel();" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table>
                                        <tr>
                                            <td style="vertical-align: top; width: 53%;">
                                                <div id="DivResultview" style="display: none" runat="server">
                                                    <table id="tblCategoryTest" style="display: none;">
                                                        <thead align="left">
                                                            <tr>
                                                                <th width="420px">
                                                                    Test Name
                                                                </th>
                                                                <th class="hide_column">
                                                                    IdentifyingID
                                                                </th>
                                                                <th class="hide_column">
                                                                    CodeID
                                                                </th>
                                                                <th class="hide_column">
                                                                    ClientID
                                                                </th>
                                                                <th width="142px">
                                                                    Test Type
                                                                </th>
                                                                <th>
                                                                    Select
                                                                </th>
                                                                <th width="190px" id="thClientName">
                                                                    Client Name
                                                                </th>
                                                                <th width="303px">
                                                                    TAT Code
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                    <asp:Button ID="btnSave" runat="server" CssClass="btn" Style="display: none" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Save/Remove TAT" OnClientClick="javascript:return SaveDeleteTATTest();" />
                                                </div>
                                            </td>
                                            <td width="50%" style="vertical-align: top;">
                                                <div id="divTATDelete" style="display: none" runat="server">
                                                    <table id="tblTATDelete" style="display: none;">
                                                        <thead align="left">
                                                            <tr>
                                                                <th width="250px">
                                                                    Test Name
                                                                </th>
                                                                <th class="hide_column">
                                                                    IdentifyingID
                                                                </th>
                                                                <th width="10px">
                                                                    Test Type
                                                                </th>
                                                                <th width="30px">
                                                                    TAT Code
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                    <asp:Button ID="btnTATDelete" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Remove TAT" OnClientClick="javascript:return DeleteTATTest();" />
                                                </div>
                                            </td>
                                            <td width="50%" style="vertical-align: top;">
                                                <div id="divClientTAT" style="display: none" runat="server">
                                                    <table id="tblclientTAT" style="display: none;">
                                                        <thead align="left">
                                                            <tr>
                                                                <th>
                                                                    Client
                                                                </th>
                                                                <th width="250px">
                                                                    Test Name
                                                                </th>
                                                                <th class="hide_column">
                                                                    IdentifyingID
                                                                </th>
                                                                <th width="10px">
                                                                    Test Type
                                                                </th>
                                                                <th width="30px">
                                                                    TAT Code
                                                                </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        </tbody>
                                                    </table>
                                                    <asp:Button ID="Button1" runat="server" CssClass="btn" onmouseout="this.className='btn'"
                                                        onmouseover="this.className='btn btnhov'" Text="Remove Client TAT" OnClientClick="javascript:return DeleteTATClientTest();" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </td>
            </tr>
        </table>
    </div>
    <asp:HiddenField ID="hdnBaseOrgId" runat="server" />
    <asp:HiddenField ID="hdnCheckType" runat="server" Value="" />
    <input id="hdnSelectedTATTempDetails" type="hidden" value="0" runat="server" />
     <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>

    <script src="Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="Scripts/JsonScript.js" type="text/javascript"></script>

    <script type="text/javascript" src="Scripts/jquery-ui-1.8.19.custom.min.js"></script>

    <script src="Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="Scripts/jquery-1.9.1.min.js"></script>

    <script type="text/javascript" src="Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="Scripts/TableTools.js"></script>

    <script type="text/javascript" src="Scripts/TableTools.min.js"></script>

    <link type="text/css" href="StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="StyleSheets/Common.css" rel="stylesheet" type="text/css" />
    <link type="text/css" href="StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
</body>
</html>

<script type="text/javascript" language="javascript">
 $('#txtTATCode').on("keypress", function(e) {
          flag = 0;
});
    
    $(function() {
        $("#ddlConfigFor").change(function() {

            var selectedValue = $(this).val();
            if (selectedValue == '1') {
                document.getElementById("Td3").style.display = '';
                document.getElementById("txtClientNameSrch").focus();
                document.getElementById('txtTATCode').value = '';
                document.getElementById('txtClientNameSrch').value = ''
                document.getElementById('txtCategoryItem').value = '';
                $('#divTATDelete').hide();
                $('#tblTATDelete').hide();
                $('#DivResultview').hide();
                $('#tblCategoryTest').hide();
                $('[id$="trTATDetails"]').hide();
                $('#ddlMapCategory').val('7');
                document.getElementById('txtTATCode').style.backgroundColor = "white";
            }
            else {
                document.getElementById("Td3").style.display = 'none';
                document.getElementById('txtTATCode').value = '';
                document.getElementById('txtCategoryItem').value = '';
                document.getElementById('hdnClientId').value = 0;
                $('#divClientTAT').hide();
                $('#tblclientTAT').hide();
                $('#DivResultview').hide();
                $('#tblCategoryTest').hide();
                $('[id$="trTATDetails"]').hide();
                $('#ddlMapCategory').val('7');
            }

        });
    });


    $(function() {

        $("#ddlMapCategory").change(function() {
            document.getElementById('txtCategoryItem').value = '';
            $('#DivResultview').hide();
            $('#tblCategoryTest').hide();
            // document.getElementById('hdnCateogoryID').value = '';
            var prefixText = document.getElementById('txtCategoryItem').value;
            var SearchType = $(this).val();
            $find('AutoCompleteExtender7').set_contextKey(SearchType);
        });
    });





    function GetData(Type) {
        try {

            var prefixText = document.getElementById('txtCategoryItem').value;
            var ItemID = document.getElementById('hdnCateogoryID').value;
            var SearchType = $("#ddlMapCategory option:selected").val();
            var ConfigID = $("#ddlConfigFor option:selected").val();
            if (SearchType == 7) {
                if (Type != 'SelectedDelete') {
                    alert("Please Select any Category Type ");
                    $('#tblCategoryTest').hide();
                    return false;
                }
                else {
                    $('#DivResultview').hide();
                    $('#tblCategoryTest').hide();
                    return false;
                }
            }
            if (prefixText == "") {
                if (Type != 'SelectedDelete') {
                    alert("Please enter atleast 3 character for Category Item");
                    $('#tblCategoryTest').hide();
                    return false;
                }
                else {
                    $('#DivResultview').hide();
                    $('#tblCategoryTest').hide();
                    return false;
                }
               
            }
            if(flag ==0 )
            {
                  alert("Please select TAT Code from the list");
                   
                    return false;
            }
            if (ConfigID == 0) {

                $('#thClientName').css('display', 'none');
            }
            else { $('#thClientName').css('display', 'table-cell'); }


            $.ajax({
                type: "POST",
                url: "../WebService.asmx/LoadCategoryTestname",
                contentType: "application/json;charset=utf-8",
                data: "{'prefixText': '" + prefixText + "','SearchType': '" + SearchType + "','ItemID': " + ItemID + ",'ConfigID': " + ConfigID + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice tblCategoryTest calling");

                    return false;
                }
            });
            $('#DivResultview').show();
            $('#tblCategoryTest').show();


        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false

    }
    function AjaxGetFieldDataSucceeded(result) {
        try {
            var codedata = document.getElementById('hdnSelectedTATTempDetails').value.split("~");
            var codeid = 0;
            var ClientId = 0;
            ClientId = document.getElementById('hdnClientId').value;
            if (codedata.length > 1) {
                codeid = codedata[1];
            }
            var oTable;
            var dataRes;

            dataRes = result.d;
            var ConfigID = $("#ddlConfigFor option:selected").val();

            var i = 1;
            if (result != "") {

                oTable = $('#tblCategoryTest').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { //pop.show(); 
                    },
                    "aoColumns": [

            { "mDataProp": "CodeName" }, //CodeName
             {"mDataProp": "IdentifyingID", "sClass": "hide_column" }, //IdentifyingID
             {"mDataProp": "CodeID", "sClass": "hide_column" }, //ScheduleID MARIYA
             {"mDataProp": "ClientID", "sClass": "hide_column" }, //ClientID
             {"mDataProp": "IdentifyingType" }, //IdentifyingType

             {"mDataProp": "IdentifyingID", // Select Checkbox

             "mRender": function(data, type, full) {
                
                 if (ConfigID == 0) {
                     if (data != null && codeid == full.CodeID) {
                         return '<input type="checkbox" class="Select" disabled onclick="ChangeAddTATCheckbox(this.id,' + full.IdentifyingID + ',this)" id="chkSelCategory' + full.IdentifyingID + '">';
                     }
                     else if (data != null && codeid != full.CodeID) {
                         return '<input type="checkbox" class="Select" onclick="ChangeAddTATCheckbox(this.id,' + full.IdentifyingID + ',this)" id="chkSelCategory' + full.IdentifyingID + '">';
                     }
                 }
                 else {

                     if (data != null && codeid == full.CodeID && ClientId == full.ClientID) {
                         return '<input type="checkbox" class="Select" disabled onclick="ChangeAddTATCheckbox(this.id,' + full.ClientID + ',this)" id="chkSelCategory' + full.ClientID + '">';
                     }
                     else if (data != null && (codeid == full.CodeID || ClientId != full.ClientID)) {
                         return '<input type="checkbox" class="Select" onclick="ChangeAddTATCheckbox(this.id,' + full.ClientID + ',this)" id="chkSelCategory' + full.ClientID + '">';
                     }
                     else if (data != null && (codeid != full.CodeID || ClientId == full.ClientID)) {
                         return '<input type="checkbox" class="Select" onclick="ChangeAddTATCheckbox(this.id,' + full.ClientID + ',this)" id="chkSelCategory' + full.ClientID + '">';
                     }
                 }

                 return data;
             }
         },
                       { "mDataProp": "IsPrimary" }, //Client NAme
                        {"mDataProp": "CodingSchemaName",
                        "mRender": function(data, type, full) {
                            if (ConfigID == 0) {
                                if (full.CodingSchemaName != '---') {
                                    var decimalValue = '<label id="lblValue' + full.IdentifyingID + '">' + data + '</label>';
                                    decimalValue += '<input type="checkbox"  onclick="ChangeDeleteTATCheckbox(this.id,' + full.IdentifyingID + ',this)"   id="chkDel' + full.IdentifyingID + '" style="width:20px;" value="' + full.CodingSchemaName + '">' + 'Delete' + '';

                                    return decimalValue;
                                }
                            }
                            else {
                                if (full.CodingSchemaName != '---') {
                                    var decimalValue = '<label id="lblValue' + full.IdentifyingID + '">' + data + '</label>';
                                    decimalValue += '<input type="checkbox"  onclick="ChangeDeleteTATCheckbox(this.id,' + full.ClientID + ',this)"   id="chkDel' + full.ClientID + '" style="width:20px;" value="' + full.CodingSchemaName + '">' + 'Delete' + '';

                                    return decimalValue;
                                }
                            }
                            return '';
                        }
}//TAT Code Name
],
                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "bJQueryUI": false,
                    "iDisplayLength": 400,
                    "sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false

                });

                $('#DivResultview').show();
                $('#tblCategoryTest').show();
                $('#btnSave').show();



            }
        }
        catch (e) {

            alert('Error in Test List Values');

        }
    }

    //GET TAT Details

    function GetTATData() {
        try {


            var x = document.getElementById('hdnTATScheduleID').value.split("~");
            var TatID = x[1];
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/LoadtatTestname",
                contentType: "application/json;charset=utf-8",
                data: "{'TatID': " + TatID + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldTATDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice tblCategoryTest calling");

                    return false;
                }
            });
            $('#divTATDelete').show();
            $('#tblTATDelete').show();


        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false
    }
    function AjaxGetFieldTATDataSucceeded(result) {
        try {

            var oTable;
            var dataRes;
            dataRes = result.d;

            var i = 1;
            if (result != "") {

                oTable = $('#tblTATDelete').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { //pop.show(); 
                    },
                    "aoColumns": [

            { "mDataProp": "CodeName" }, //CodeName
             {"mDataProp": "IdentifyingID", "sClass": "hide_column" }, //IdentifyingID
             {"mDataProp": "IdentifyingType" }, //IdentifyingType


 {"mDataProp": "CodingSchemaName",
 "mRender": function(data, type, full) {

     return '<input type="checkbox"     id="chkDel' + full.IdentifyingID + '" style="width:10px;" value="' + full.CodingSchemaName + '">' + full.CodingSchemaName + '';
 }
}//TAT Code Name
],
                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "bJQueryUI": false,
                    "iDisplayLength": 400,
                    "sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false

                });

                $('#DivResultview').show();
                $('#tblTATDelete').show();



            }
        }
        catch (e) {

            alert('Error in Test List Values');

        }
    }


    //Get Client TAT


    function GetClientTATData() {
        try {


            var x = document.getElementById('hdnTATScheduleID').value.split("~");
            if (x != 0) { var TatID = x[1]; } else { TatID = -1 }
            //var TatID = x[1];
            var ClientID = document.getElementById('hdnClientId').value;
            $.ajax({
                type: "POST",
                url: "../WebService.asmx/LoadClienttatTestname",
                contentType: "application/json;charset=utf-8",
                data: "{'TatID': " + TatID + ",'ClientID': " + ClientID + "}",
                dataType: "json",
                async: false,
                success: AjaxGetFieldClientTATDataSucceeded,
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice tblCategoryTest calling");

                    return false;
                }
            });
            $('#divClientTAT').show();
            $('#tblclientTAT').show();


        }
        catch (e) {
            alert('Exception while binding Data');

        }
        return false
    }
    function AjaxGetFieldClientTATDataSucceeded(result) {
        try {

            var oTable;
            var dataRes;
            dataRes = result.d;

            var i = 1;
            if (result != "") {

                oTable = $('#tblclientTAT').dataTable({
                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    "bSort": false,
                    "aaData": result.d,
                    "fnStandingRedraw": function() { //pop.show(); 
                    },
                    "aoColumns": [
             { "mDataProp": "IsPrimary" },
             { "mDataProp": "CodeName" }, //CodeName
             {"mDataProp": "IdentifyingID", "sClass": "hide_column" }, //IdentifyingID
             {"mDataProp": "IdentifyingType" }, //IdentifyingType


 {"mDataProp": "CodingSchemaName",
 "mRender": function(data, type, full) {

     return '<input type="checkbox"     id="chkDel' + full.IdentifyingID + '" style="width:10px;" value="' + full.CodingSchemaName + '">' + full.CodingSchemaName + '';


 }
}//TAT Code Name
],
                    "sPaginationType": "full_numbers",
                    "bPaginate": false,

                    "bJQueryUI": false,
                    "iDisplayLength": 400,
                    "sScrollY": "323px",
                    "bScrollCollapse": true,
                    "bAutoWidth": false

                });

                $('#divClientTAT').show();
                $('#tblclientTAT').show();



            }
        }
        catch (e) {

            alert('Error in TAT List Values');

        }
    }




    //saving the TAT Test Configuration

    function SaveDeleteTATTest() {
        try {
            var lstResultValues = [];
            var lstResultDelete = [];
            var txtTATCodeReturnCode = 0;

            $("#tblCategoryTest > tbody > tr").each(function() {
                var oTable = $("#tblCategoryTest").dataTable();
                var pos = oTable.fnGetPosition(this);
                var rowData = oTable.fnGetData(pos);
                var x = document.getElementById('hdnSelectedTATTempDetails').value.split("~");
                var Scheduleid = x[1];

                var OrgID = document.getElementById('hdnBaseOrgId').value;
                var CategoryType = $("#ddlMapCategory option:selected").val();
                var CategoryID = document.getElementById('hdnCateogoryID').value;
                var clientId = document.getElementById('hdnClientId').value
                var ConfigFor = $("#ddlConfigFor option:selected").val();
                var Code = document.getElementById('txtTATCode').value;
                var ClientNameSrch = document.getElementById('txtClientNameSrch').value;
                if (ConfigFor == 1 && ClientNameSrch == '') {
                    alert('Please select an Client to save the Test');
                    document.getElementById('txtClientNameSrch').focus();
                    document.getElementById('txtClientNameSrch').style.backgroundColor = "yellow";
                    txtTATCodeReturnCode = 2;
                    return false;
                }


                if ($(this).find("[id*=chkSelCategory]").is(':checked') == true && Code == "") {
                    alert('Please select an TAT code to save the Test');
                    document.getElementById('txtTATCode').focus();
                    document.getElementById('txtTATCode').style.backgroundColor = "yellow";
                    txtTATCodeReturnCode = 1;
                    return false;
                }

                if ($(this).find("[id*=chkSelCategory]").is(':checked') == true) {
                    lstResultValues.push({
                        Testid: rowData["IdentifyingID"], //testId
                        CategoryType: CategoryType, //ddlMapCategory
                        OrgID: OrgID,
                        Scheduleid: Scheduleid, //TatID
                        CategoryID: CategoryID, //hdnCateogoryID
                        Clientid: clientId, //clientId
                        Testtype: rowData["IdentifyingType"]
                    });
                }
                if ($(this).find("[id*=chkDel]").is(':checked') == true) {
                    lstResultDelete.push({
                        Testid: rowData["IdentifyingID"],
                        CategoryType: CategoryType,
                        OrgID: OrgID,
                        //                        InvestigationMethodID: InvestigationMethodID,
                        CategoryID: CategoryID,
                        //Clientid: clientId,
                        Clientid: rowData["ClientID"],
                        Testtype: rowData["IdentifyingType"]
                    });
                }

            });
            if (txtTATCodeReturnCode == 1 || txtTATCodeReturnCode == 2) {
                return false;
            }

            var lstrelease, lstdelete;
            //Added TAT Lsit
            if (JSON.stringify(lstResultValues) == "[]") {
                lstrelease = '';
            }
            else {
                lstrelease = JSON.stringify(lstResultValues);
            }

            //Deleted TAT List
            if (JSON.stringify(lstResultDelete) == "[]") {
                lstdelete = '';
            }
            else {
                lstdelete = JSON.stringify(lstResultDelete);
            }
            if (lstrelease == '' && lstdelete == '') {
                alert('Please select Test');

                return false;
            }


            var AjaxContent = "{'lstReportRelease':'" + lstrelease + "','lstReportDelete':'" + lstdelete + "'}";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveDeleteTAT",
                contentType: "application/json; charset=utf-8",
                data: AjaxContent,
                dataType: "json",
                success: function(data) {
                    alert("Updated Sucessfully");
                    deleteRow('tblCategoryTest');

                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Calling");
                    $('#tblCategoryTest').hide();


                    return false;
                }
            });
            return false;
        }

        catch (e) {

            alert("Unable to Save");
            return false;
        }
    }

    function ChangeAddTATCheckbox(id, PositionCount, obj) {

        if ($(obj).is(':checked') == true) {
            var $row = $(obj).closest('tr');
            var ChkDelControl = $row.find("[id*=chkDel]").attr('id');
            var ObjChkDelControl = $row.find("[id*=chkDel]");
            if ($(ObjChkDelControl).is(':checked') == true) {
                $(ObjChkDelControl).prop('checked', false);
            }
        }

        return false;



    }


    function ChangeDeleteTATCheckbox(id, ClientID, obj) {

        if ($(obj).is(':checked') == true) {
            var $row = $(obj).closest('tr');
            var ChkSelControl = $row.find("[id*=chkSelCategory]").attr('id');
            var ObjChkSelControl = $row.find("[id*=chkSelCategory]");
            if ($(ObjChkSelControl).is(':checked') == true) {
                $(ObjChkSelControl).prop('checked', false);
            }
        }

        return false;
    }


    function DeleteTATTest() {
        try {
            var lstResultValues = [];
            var lstResultDelete = [];
            $("#tblTATDelete > tbody > tr").each(function() {
                var oTable = $("#tblTATDelete").dataTable();
                var pos = oTable.fnGetPosition(this);
                var rowData = oTable.fnGetData(pos);
                //var ReferralID = document.getElementById('hdnClientId').value;
                var x = document.getElementById('hdnSelectedTATTempDetails').value.split("~");
                var Scheduleid = x[1];
                var OrgID = document.getElementById('hdnBaseOrgId').value;
                if ($(this).find("[id*=chkDel]").is(':checked') == true) {
                    lstResultDelete.push({
                        Testid: rowData["IdentifyingID"],
                        Testtype: rowData["IdentifyingType"],
                        OrgID: OrgID,
                        Scheduleid: Scheduleid
                    });
                }

            });




            var lstrelease, lstdelete;
            //Added Lsit
            if (JSON.stringify(lstResultValues) == "[]") {
                lstrelease = '';
            }
            else {
                lstrelease = JSON.stringify(lstResultValues);
            }
            //Deleted List
            if (JSON.stringify(lstResultDelete) == "[]") {
                lstdelete = '';
            }
            else {
                lstdelete = JSON.stringify(lstResultDelete);
            }
            if (lstdelete == '') {
                alert('Please Select atleast any One Checkbox');

                return false;
            }
            var AjaxContent = "{'lstReportRelease':'" + lstrelease + "','lstReportDelete':'" + lstdelete + "'}";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveDeleteTAT",
                contentType: "application/json; charset=utf-8",
                data: AjaxContent,
                dataType: "json",
                success: function(data) {
                    alert("Removed Mapped TAT Sucessfully");
                    deleteRow1('tblTATDelete');
                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Calling");
                    $('#tblTATDelete').hide();


                    return false;
                }
            });
            return false;
        }

        catch (e) {

            alert("Unable to Save");
            return false;
        }
    }


    function DeleteTATClientTest() {
        try {
            var lstResultValues = [];
            var lstResultDelete = [];
            $("#tblclientTAT > tbody > tr").each(function() {
                var oTable = $("#tblclientTAT").dataTable();
                var pos = oTable.fnGetPosition(this);
                var rowData = oTable.fnGetData(pos);
                //var ReferralID = document.getElementById('hdnClientId').value;
                var x = document.getElementById('hdnSelectedTATTempDetails').value.split("~");
                var Scheduleid = x[1];
                var OrgID = document.getElementById('hdnBaseOrgId').value;
                var clientId = document.getElementById('hdnClientId').value
                if ($(this).find("[id*=chkDel]").is(':checked') == true) {
                    lstResultDelete.push({
                        Testid: rowData["IdentifyingID"],
                        Testtype: rowData["IdentifyingType"],
                        OrgID: OrgID,
                        Scheduleid: Scheduleid,
                        Clientid: clientId

                    });
                }

            });




            var lstrelease, lstdelete;
            //Added Lsit
            if (JSON.stringify(lstResultValues) == "[]") {
                lstrelease = '';
            }
            else {
                lstrelease = JSON.stringify(lstResultValues);
            }
            //Deleted List
            if (JSON.stringify(lstResultDelete) == "[]") {
                lstdelete = '';
            }
            else {
                lstdelete = JSON.stringify(lstResultDelete);
            }
            if (lstdelete == '') {
                alert('Please Select atleast any One Checkbox');

                return false;
            }
            var AjaxContent = "{'lstReportRelease':'" + lstrelease + "','lstReportDelete':'" + lstdelete + "'}";

            $.ajax({
                type: "POST",
                url: "../WebService.asmx/SaveDeleteTAT",
                contentType: "application/json; charset=utf-8",
                data: AjaxContent,
                dataType: "json",
                success: function(data) {
                    alert("Removed Mapped TAT Sucessfully");
                    deleteRow3('tblclientTAT');
                    return false;
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert("Error in Webservice Calling");
                    $('#tblclientTAT').hide();


                    return false;
                }
            });
            return false;
        }


        catch (e) {

            alert("Unable to Save");
            return false;
        }
    }



    var deleteRow = function(tableID) {
        var ID = "#" + tableID;
        var rowCount = jQuery(ID + " tbody tr").length;
        var clientId = document.getElementById('hdnClientId').value
        jQuery(ID + " input:checked").each(function() {


            jQuery(this).closest('tr').fadeOut(function() {
                jQuery(this).remove();
            });

        });

        if (clientId != 0) {

            $('#divTATDelete').hide();
            $('#tblTATDelete').hide();
            GetClientTATData();
        }
        else {

            $('#divClientTAT').hide();
            $('#tblclientTAT').hide();
            GetTATData();
        }
        GetData('TestDelete');
        return false;
    }



    var deleteRow1 = function(tableID) {
        var ID = "#" + tableID;
        var rowCount = jQuery(ID + " tbody tr").length;

        jQuery(ID + " input:checked").each(function() {


            jQuery(this).closest('tr').fadeOut(function() {
                jQuery(this).remove();
            });
        });
        GetTATData();
        GetData('SelectedDelete');
        return false;
    }


    var deleteRow3 = function(tableID) {
        var ID = "#" + tableID;
        var rowCount = jQuery(ID + " tbody tr").length;

        jQuery(ID + " input:checked").each(function() {


            jQuery(this).closest('tr').fadeOut(function() {
                jQuery(this).remove();
            });
        });
        GetClientTATData();
        GetData('SelectedDelete');
        return false;
    }


    function ClearCategoryID() {

        var ID = document.getElementById('hdnCateogoryID').value;

        if (ID != '') {
            document.getElementById('hdnCateogoryID').value = 0;
        }

    }
    function cancel() {

        document.getElementById('txtClientNameSrch').value = "";
        document.getElementById('txtTATCode').value = "";
        document.getElementById('txtCategoryItem').value = "";
        $('#divClientTAT').hide();
        $('#tblclientTAT').hide();
        $('#divTATDelete').hide();
        $('#tblTATDelete').hide();
        $('#DivResultview').hide();
        $('#tblCategoryTest').hide();
        $('#ddlMapCategory').val('7');
        $('#trTATDetails').hide();
        //        document.getElementById('hdnCateogoryID').value = '';
        //        document.getElementById('hdnClientId').value = '';
        //        document.getElementById('hdnTATScheduleID').value = '';
        document.getElementById('hdnSelectedTATTempDetails').value = '';
        document.getElementById('txtTATCode').style.backgroundColor = "white";
        document.getElementById('txtClientNameSrch').style.backgroundColor = "white";
        return false;

    }
</script>

