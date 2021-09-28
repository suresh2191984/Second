<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VisitWiseSearch.aspx.cs"
    Inherits="Reports_VisitWiseSearch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Visit Wise Search</title>
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        #VisitWiseSerach
        {
            width: 1320px;
            height: auto;
            overflow: auto;
            overflow-y: auto;
            margin: 0 left;
            white-space: nowrap;
        }
        .orderedServices
        {
            display: block;
            height: 100px;
            overflow-y: auto;
        }
        .pTrackContent1 .ui-state-default, .pTrackContent1 .ui-widget-content .ui-state-default, .pTrackContent1 .ui-widget-header .ui-state-default
        {
            background: #f5f5f5 none repeat scroll 0 0 !important;
            border: 1px solid #ccc;
            color: #1c94c4;
            font-weight: normal;
            margin: 1px;
            padding: 2px;
        }
        .pTrackContent1 .ui-buttonset
        {
            display: inline;
            margin-right: 7px;
            float: left;
        }
        .pTrackContent1 .dataTables_filter
        {
            display: inline;
            float: right;
            color: #000;
        }
        .pTrackContent1 .ui-widget-header
        {
            background: #b7b7b5 none repeat scroll 0 0 !important;
        }
        .pTrackContent1 .dataTable
        {
            width: 100%;
        }
        .pTrackContent1 .dataTable td
        {
            padding: 8px;
            border-bottom: 1px solid #ccc;
        }
        .pTrackContent1 .dataTables_info
        {
            display: inline;
            float: right;
            color: #000;
        }
        .pTrackContent1 .dataTables_paginate
        {
            text-align: left;
        }
        .pTrackContent1 .ui-state-default .ui-icon
        {
            background-image: url(../Themes/IB/start/images/ui-icons_056b93_256x240.png);
        }
        .w-98p
        {
            width: 98%;
        }
        .autocompletehide
        {
            visibility: hidden;
        }
    </style>

    <script language="javascript" type="text/javascript">

        function SelectedPatient(source, eventArgs) {
            document.getElementById('<%= hdnSelectedPatient.ClientID %>').value = '';
            var SelectedPatientId = "";
            SelectedPatientId = eventArgs.get_value();
            document.getElementById('<%= hdnSelectedPatient.ClientID %>').value = SelectedPatientId;
            var PatientName = eventArgs.get_text();
            document.getElementById('txtPatientName').value = PatientName;
        }
        function setContextClientNameValue() {
            var sval = '0' + "^" + document.getElementById('<%= ddlOrganization.ClientID %>').value;
            $find('<%= AutoCompleteExtenderClientName.ClientID %>').set_contextKey(sval);
            return false;
        }
        function setContextValue() {
            var sval = 'RPH'
            $find('<%= AutoCompleteExtenderRefPhy.ClientID %>').set_contextKey(sval);
            return false;
        }
        function ClearValue(obj) {
            if (document.getElementById(obj).value == "") {
                document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = "0";
            }
        }
        function SelectedClientID(source, eventArgs) {
            //            document.getElementById('<%= hdnSelectedClientID.ClientID %>').value = eventArgs.get_value().split('|')[0];
            document.getElementById('<%= hdnClientId.ClientID %>').value = eventArgs.get_value().split('|')[0];
        }

        function alpha(e) {
            var k;
            document.all ? k = e.keyCode : k = e.which;
            return ((k > 64 && k < 91) || (k > 96 && k < 123) || k == 8 || k == 32 || k == 46 || (k >= 48 && k <= 57));
        }

        function RefPhysicianSelected(source, eventArgs) {
            var PhysicianID;
            var PhysicianName;
            var PhysicianCode;
            var PhysicianType;
            document.getElementById('txtReferringPhysician').value = eventArgs.get_text();
            var PhyType;
            var list = eventArgs.get_value().split('^');
            if (list.length > 0) {
                for (i = 0; i < list.length; i++) {
                    if (list[i] != "") {
                        PhysicianID = list[1];
                        PhysicianName = list[2];
                        PhysicianCode = list[3];
                        PhysicianType = list[0].trim();
                        PhyType = list[4];
                    }
                }
            }
            document.getElementById('hdnReferedPhyID').value = PhysicianID;
            document.getElementById('hdnReferedPhyName').value = PhysicianName;
            document.getElementById('hdnReferedPhysicianCode').value = PhysicianCode;
            document.getElementById('hdnReferedPhyType').value = PhysicianType;
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata" id="contentdata">
        <div id="statusProgess" style="display: none;">
            <div id="progressBackgroundFilter" class="a-center">
            </div>
            <div id="processMessage" class="w-15p a-center" style="display: block;">
                <asp:Label ID="Rs_Pleasewait1" Text="Please wait... " runat="server" Font-Bold="true"
                    Font-Size="Larger" />
                <br />
                <br />
                <asp:Image ID="imgProgressbar1" Width="16px" Height="16px" runat="server" ImageUrl="../Images/working.gif" />
            </div>
        </div>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <table id="Table1" runat="server" class="w-98p searchPanel">
                    <tr id="Tr1" runat="server">
                        <td id="Td1" runat="server" class="v-top w-13p a-left">
                            <asp:Label ID="lblOrganization" runat="server" Text="Organization : "></asp:Label>
                        </td>
                        <td id="Td2" runat="server" class="v-top w-14p a-left">
                            <asp:DropDownList ID="ddlOrganization" runat="server" AutoPostBack="True" CssClass="ddl"
                                OnSelectedIndexChanged="ddlOrganization_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td id="Td3" runat="server" class="v-top w-15p a-left">
                            <asp:Label ID="lblLocation" runat="server" Text="Location : "></asp:Label>
                        </td>
                        <td id="Td4" runat="server" class="v-top w-14p a-left">
                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl">
                            </asp:DropDownList>
                        </td>
                        <td id="Td5" runat="server" class="v-top a-left">
                            <asp:Label ID="lblvisittype" runat="server" Text="Visit Type : "></asp:Label>
                        </td>
                        <td id="Td6" runat="server" class="v-top a-left">
                            <asp:DropDownList ID="ddlVisitType" runat="server" CssClass="ddl">
                                <asp:ListItem Selected="True" Text="ALL" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Stat" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td id="Td7" runat="server" class="v-top a-left">
                            <asp:Label ID="lblVisitStatus" runat="server" Text="Visit Status : "></asp:Label>
                        </td>
                        <td id="Td8" runat="server" class="v-top a-left">
                            <asp:DropDownList ID="ddlVisitStatus" runat="server" CssClass="ddl">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="Tr2" runat="server">
                        <td id="Td9" runat="server" class="v-top w-12p a-left">
                            <asp:Label ID="lblPatientName" runat="server" Text="Patient Name : "></asp:Label>
                        </td>
                        <td id="Td10" runat="server" class="v-top w-17p a-left">
                            <asp:TextBox ID="txtPatientName" runat="server" onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);"
                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" CssClass="AutoCompletesearchBox" Style="width: 132px;"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteProduct" runat="server" TargetControlID="txtPatientName"
                                FirstRowSelected="True" CompletionListCssClass="wordWheel listMain .box autocompletehide"
                                CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                EnableCaching="False" MinimumPrefixLength="1" ServiceMethod="GetPatientListWithDetails"
                                ServicePath="~/InventoryWebService.asmx" DelimiterCharacters="" Enabled="True"
                                OnClientItemSelected="SelectedPatient">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td id="Td11" runat="server" class="v-top w-12p a-left">
                            <asp:Label ID="lblVisitNo" runat="server" Text="Number : "></asp:Label>
                        </td>
                        <td id="Td12" runat="server" class="v-top w-14p a-left">
                            <asp:TextBox ID="txtVisitNo" runat="server" CssClass="Txtboxsmall" MaxLength="16"
                                     onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                        </td>
                        <td id="Td13" runat="server" class="v-top w-12p a-left">
                            <asp:Label ID="lblReferenceNo" runat="server" Text="Reference No : "></asp:Label>
                        </td>
                        <td id="Td14" runat="server" class="v-top w-14p a-left">
                            <asp:TextBox ID="txtReferenceNo" runat="server" CssClass="Txtboxsmall" MaxLength="16"
                                     onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                        </td>
                        <td id="Td15" runat="server" class="v-top w-12p a-left">
                            <asp:Label ID="lblIdentityNumber" runat="server" Text="Identity Number : "></asp:Label>
                        </td>
                        <td id="Td16" runat="server" class="v-top w-14p a-left">
                            <asp:TextBox ID="txtIdentityNumber" runat="server" CssClass="Txtboxsmall" MaxLength="16"
                                     onkeypress="return ValidateOnlyNumeric(this);"   ></asp:TextBox>
                        </td>
                    </tr>
                    <tr id="Tr3" runat="server">
                        <td id="Td17" runat="server" class="a-left v-top">
                            <asp:Label ID="lblClientName" runat="server" Style="display: block;" Text="Client Name : "></asp:Label>
                        </td>
                        <td id="Td18" runat="server" class="a-left v-top">
                            <asp:TextBox ID="txtClientName" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox"
                                onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" onfocus="setContextClientNameValue();"
                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Style="display: block; width: 132px;"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClientName" runat="server" CompletionInterval="1"
                                CompletionListCssClass="wordWheel listMain .box autocompletehide" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="1" OnClientItemSelected="SelectedClientID"
                                ServiceMethod="GetClientList" ServicePath="~/WebService.asmx" TargetControlID="txtClientName">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td id="Td19" runat="server" class="a-left v-top">
                            <asp:Label ID="lblReferringPhysician" runat="server" Style="display: block;" Text="Ref. Physician : "></asp:Label>
                        </td>
                        <td id="Td20" runat="server" class="a-left v-top">
                            <asp:TextBox ID="txtReferringPhysician" runat="server" autocomplete="off" CssClass="AutoCompletesearchBox"
                                onblur="javascript:ClearValue(this.id);ConverttoUpperCase(this.id);" onfocus="setContextValue();"
                                  OnKeyPress="return ValidateMultiLangCharacter(this) || ValidateOnlyNumeric(this);" Style="display: inline; width: 132px;"></asp:TextBox>
                            <ajc:AutoCompleteExtender ID="AutoCompleteExtenderRefPhy" runat="server" CompletionInterval="1"
                                CompletionListCssClass="wordWheel listMain .box autocompletehide" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                CompletionListItemCssClass="wordWheel itemsMain" DelimiterCharacters="" EnableCaching="False"
                                Enabled="True" FirstRowSelected="True" MinimumPrefixLength="2" OnClientItemSelected="RefPhysicianSelected"
                                ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" TargetControlID="txtReferringPhysician">
                            </ajc:AutoCompleteExtender>
                        </td>
                        <td id="Td21" runat="server" class="v-top a-left">
                            <asp:Label ID="lblFrom" runat="server" Text="From : "></asp:Label>
                        </td>
                        <td id="Td22" runat="server" class="v-top a-left">
                            <asp:TextBox ID="txtFrom" runat="server" ReadOnly="True" CssClass="Txtboxsmall" size="25"
                                Width="126px"></asp:TextBox>
                            <a href="javascript:NewCssCall('<%=txtFrom.ClientID %>','ddMMMyyyy','arrow',true,12,'Y','Y','Y')">
                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                        </td>
                        <td id="Td23" runat="server" class="v-top a-left">
                            <asp:Label ID="lblTo" runat="server" Text="To : "></asp:Label>
                        </td>
                        <td id="Td24" runat="server" class="v-top a-left">
                            <asp:TextBox ID="txtTo" runat="server" ReadOnly="True" CssClass="Txtboxsmall" size="25"
                                Width="126px"></asp:TextBox>
                            <a href="javascript:NewCssCall('<%=txtTo.ClientID %>','ddMMMyyyy','arrow',true,12,'Y','Y','Y')">
                                <img src="../Images/Calendar_scheduleHS.png" alt="Pick a date"></a>
                        </td>
                    </tr>
                    <tr id="Tr4" runat="server">
                        <td id="Td25" runat="server" class="a-center" colspan="8">
                            <asp:Button ID="btnSrarch" runat="server" CssClass="btn" OnClientClick="javascript:return GetResult();"
                                onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov'"
                                Text="Search" />
                            <asp:Button ID="btnClear" runat="server" Width="50px" CssClass="btn" OnClientClick="return ClearValues();"
                                onmouseout="this.className='btn1'" onmouseover="this.className='btn1 btnhov'"
                                Text="Clear" />
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td id="tdVisitWiseSerach" runat="server" style="display: none;">
                            <div>
                                <table>
                                    <tr>
                                        <td>
                                            <input id="txtNormal" name="Normal" type="text" style="background-color: #FFFFFF;
                                                width: 14px;" /><span>Normal</span>
                                            <input id="txtLowerHigher" name="LowerHigher" type="text" style="background-color: #FFFF00;
                                                width: 14px;" /><span>Lower/Higher Abnormal</span>
                                            <input id='txtPanic" ' name="Panic" type="text" style="background-color: #FF0000;
                                                width: 14px;" /><span>Panic</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="VisitWiseSerach" style="overflow-y: scroll; height: 440px;">
                                <ajc:ModalPopupExtender ID="mdlPopup" runat="server" BackgroundCssClass="blur" TargetControlID="pnlPopup"
                                    PopupControlID="pnlPopup" DynamicServicePath="" Enabled="True" />
                                <asp:Panel ID="pnlPopup" runat="server" CssClass="progress" Width="95%" Style="display: none"
                                    BackImageUrl="~/Images/Loader.gif">
                                </asp:Panel>
                                <table id="ReportDetails" style="display: none;" width="95%">
                                    <thead>
                                        <tr>
                                            <th class="a-center">
                                                S No
                                            </th>
                                            <th class="a-center">
                                                Patient Name
                                            </th>
                                            <th class="a-center">
                                                Age/Gender
                                            </th>
                                            <th class="a-center">
                                                Number
                                            </th>
                                            <th class="a-center">
                                                Location
                                            </th>
                                            <th class="a-center">
                                                Ref Physician
                                            </th>
                                            <th class="a-center">
                                                Client Name
                                            </th>
                                            <th class="a-center">
                                                Test Requested
                                            </th>
                                            <th class="a-center">
                                                Receipt No
                                            </th>
                                            <th class="a-center">
                                                Total Amount
                                            </th>
                                            <th class="a-center">
                                                Receipt Status
                                            </th>
                                            <th class="a-center">
                                                E-Mail
                                            </th>
                                            <th class="a-center">
                                                SMS
                                            </th>
                                            <th class="a-center">
                                                Printed
                                            </th>
                                            <th class="a-center">
                                                Print
                                            </th>
                                            <th class="a-center">
                                                PDF
                                            </th>
                                            <th class="a-center">
                                                Mail
                                            </th>
                                            <th class="a-center">
                                                OrderedServices
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <input id="hdnReferedPhyID" type="hidden" value="0" runat="server" />
                <input id="hdnReferedPhyName" runat="server" type="hidden" />
                <input id="hdnReferedPhysicianCode" runat="server" type="hidden" value="0" />
                <input id="hdnReferedPhyType" runat="server" type="hidden" />
                <input id="hdnClientId" runat="server" type="hidden" value="0" />
                <input id="hdnSelectedPatient" runat="server" type="hidden" />
            </ContentTemplate>
        </asp:UpdatePanel>
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTargetCtlMailReport" runat="server" />
                <ajc:ModalPopupExtender ID="modalpopupsendemail" runat="server" PopupControlID="pnlMailReports"
                    TargetControlID="hdnTargetCtlMailReport" BackgroundCssClass="modalBackground"
                    CancelControlID="img1" DynamicServicePath="" Enabled="True">
                </ajc:ModalPopupExtender>
                <asp:Panel ID="pnlMailReports" BorderWidth="1px" Height="40%" Width="30%" CssClass="modalPopup dataheaderPopup"
                    runat="server" meta:resourcekey="pnlMailReportResource1" Style="display: none">
                    <asp:Panel ID="Panel5" runat="server" CssClass="dialogHeader" meta:resourcekey="Panel1Resource1">
                        <table width="100%">
                            <tr>
                                <td>
                                    <asp:Label ID="Label11" runat="server" Text="Email Report" meta:resourcekey="Label11Resource2"></asp:Label>
                                </td>
                                <td align="right">
                                    <img id="img1" src="../Images/dialog_close_button.png" runat="server" alt="Close"
                                        style="cursor: pointer;" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <table class="w-100p">
                        <tr>
                            <td colspan="2">
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="vertical-align: middle;">
                                <asp:Label ID="lblMailAddress" runat="server" Text="To: " meta:resourcekey="lblMailAddressResource1" />
                            </td>
                            <td align="left">
                                <asp:TextBox ID="txtMailAddress" TextMode="MultiLine" Width="300px" Height="40px"
                                    runat="server" />
                                <asp:TextBox ID="txtorgid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                <asp:TextBox ID="txtLocid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                <asp:TextBox ID="txtvisitid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                <asp:TextBox ID="txtroleid" Width="300px" Height="40px" Style="display: none" runat="server" />
                                <p style="margin: 2px 0 5px 0; font-size: 11px; color: #666;">
                                    <asp:Label ID="lblMailAddressHint" runat="server" Text="example: abc@example.com, def@example.com"
                                        meta:resourcekey="lblMailAddressHintResource1" />
                                </p>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                    <ProgressTemplate>
                                        <asp:Image ID="imgProgressbars" runat="server" ImageUrl="~/Images/working.gif" meta:resourcekey="imgProgressbarResource1" />
                                        <asp:Label ID="Rs_Pleasewaits" Text="Please wait...." runat="server" meta:resourcekey="Rs_PleasewaitResource1" />
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </td>
                        </tr>
                        <tr>
                            <td align="center" colspan="2">
                                <asp:Button ID="Send" runat="server" Text="Send" CssClass="btn" onmouseover="this.className='btn btnhov'"
                                    onmouseout="this.className='btn'" OnClientClick="javascript:return CheckEmpty();" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:HiddenField ID="hdnClientEmail" runat="server" />
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="iframeplaceholder">
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnhidegrid" runat="server" Value="N" />
    <asp:HiddenField ID="HdnOrgZoneTime" runat="server" Value="" />
    <asp:HiddenField ID="hdnSelectedClientID" runat="server" Value="0" />
    </form>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

    <script type="text/javascript">
        function ClearValues() {
            //$('#ddlOrganization').val();
            $('#ddlLocation :selected').val('0');
            $('#ddlVisitType :selected').val('0');
            $('#ddlVisitStatus :selected').val('0');
            $('#txtPatientName').val('');
            $('#hdnSelectedPatient').val('');
            $('#txtVisitNo').val('');
            $('#txtReferenceNo').val('');
            $('#txtIdentityNumber').val('');
            $('#txtClientName').val('');
            $('#hdnClientId').val('0');
            $('#txtReferringPhysician').val('');
            $('#hdnReferedPhyID').val('0');

            var m_names = new Array("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");

            var d = new Date();
            var curr_date = d.getDate();
            var curr_month = d.getMonth();
            var curr_year = d.getFullYear();
            //document.write(curr_date + "-" + m_names[curr_month]+ "-" + curr_year);
            $('#txtFrom').val(curr_date + "-" + m_names[curr_month] + "-" + curr_year + ' 12:00AM');
            $('#txtTo').val(curr_date + "-" + m_names[curr_month] + "-" + curr_year + ' 11:59PM');
            $('#tdVisitWiseSerach').hide();
            $('#VisitWiseSerach').hide();

            $('#statusProgess').hide();
        }
        function GetResult() {
            //debugger;
            try {
                var pop = $find("mdlPopup");
                pop.show();
                $('#statusProgess').show();
                var Orgid = $('#ddlOrganization').val();
                var Location = $('#ddlLocation').val();
                var VisitType = $('#ddlVisitType').val();
                var VisitStatus = $('#ddlVisitStatus :selected').text();
                var PatientId = '0';
                if ($('#txtPatientName').val() != '') {
                    PatientId = $('#hdnSelectedPatient').val();
                }
                var VisitNo = $('#txtVisitNo').val();
                var ReferenceNo = $('#txtReferenceNo').val();
                var MobileNumber = $('#txtIdentityNumber').val();
                var ClientID = '0';
                if ($('#txtClientName').val() != '') {
                    ClientID = $('#hdnClientId').val();
                }
                var RefPhyID = '0';
                if ($('#txtReferringPhysician').val() != '') {
                    RefPhyID = $('#hdnReferedPhyID').val();
                }
                var FromDate = $('#txtFrom').val();
                var ToDate = $('#txtTo').val();

                if (VisitNo == 'Visit Number') {
                    VisitNo = '';
                }
                if (MobileNumber == '' || MobileNumber == 'Mobile Number') {
                    MobileNumber = 0;
                }

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetVisitWiseSearchMISReport",
                    contentType: "application/json; charset=utf-8",
                    // data: "{ Orgid: '" + Orgid + "',Location: '" + Location + "',VisitType: " + VisitType + "}",
                    data: "{ Orgid: '" + Orgid + "',Location: '" + Location + "',VisitType: '" + VisitType +
                 "',VisitStatus: '" + VisitStatus + "',PatientId: '" + PatientId + "',VisitNo: '" + VisitNo + "',ReferenceNo: '"
                 + ReferenceNo + "',MobileNumber: '" + MobileNumber + "',ClientID: '" + ClientID + "',RefPhyID: '" + RefPhyID + "',FromDate: '"
                 + FromDate + "',ToDate: '" + ToDate + "'}",
                    dataType: "json",
                    success: AjaxDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#ReportDetails').hide();
                        pop.hide();
                        // Watermark();
                        $('#tdVisitWiseSerach').hide();
                        $('#statusProgess').hide();

                        return false;
                    }
                });

            }
            catch (e) {
                pop.hide();
                $('#statusProgess').hide();
                $('#tdVisitWiseSerach').hide();
            }

            return false;
        }
        function AjaxDataSucceeded(result) {
            // debugger;
            $('#VisitWiseSerach').show();
            $('#tdVisitWiseSerach').show();
            var pop = $find("mdlPopup");
            var oTableTools;
            var countR = result.d.length;

            if (countR > 0 && result != "[]") {

                oTableTools = $('#ReportDetails').dataTable({

                    "bDestroy": true,
                    "bAutoWidth": false,
                    "bProcessing": true,
                    //  "bRetrieve": true,
                    //  "serverSide": true,
                    "aaData": result.d,
                    //sScrollX: "100%",
                    //sScrollX: "500px",
                    //"aoColumnDefs": [
                    // { bSortable: false, aTargets: [4, 5, 6] },
                    //{ sWidth: "7%", aTargets: [1, 2, 3, 4, 5, 6,7,8,9,10,11,12,13] },
                    //],

                    "fnStandingRedraw": function() { pop.show(); },
                    "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {

                        if (aData.IsAbnormal == "N") {
                            $('td:eq(0)', nRow).css("background-color", "#FFFFFF");
                        }
                        if (aData.IsAbnormal == "L") {
                            $('td:eq(0)', nRow).css("background-color", "#FFFF00");
                        }
                        if (aData.IsAbnormal == "A") {
                            $('td:eq(0)', nRow).css("background-color", "#FFFF00");
                        }
                        if (aData.IsAbnormal == "P") {
                            $('td:eq(0)', nRow).css("background-color", "#FF0000");
                        }
                        if (aData.VisitNumber != '') {
                            $('td:eq(3)', nRow).css("color", "#0000FF");
                        }
                        return nRow;
                    },

                    "aoColumns": [
                                { "mDataProp": "SNo" },
                                { "mDataProp": "PatientName" },
                                { "mDataProp": "Age" },
                                { "mDataProp": "VisitNumber" },
                                { "mDataProp": "Location" },
                                { "mDataProp": "PhysicianName" },
                                { "mDataProp": "ClientName" },
                                { "mDataProp": "TestDescription" },
                                { "mDataProp": "BillNumber" },
                                { "mDataProp": "Amount" },
                                { "mDataProp": "ReceiptStatus" },
                                { "mDataProp": "EmailStatus" },
                                { "mDataProp": "SmsStatus" },
                                { "mDataProp": "PrintStatus" },
                                { "mDataProp": "Printpdf" },
                                { "mDataProp": "Pdf" },
                                { "mDataProp": "Col1" },
                                { "mDataProp": "OrderedServices", "bVisible": false },
                                ],
                    "sPaginationType": "full_numbers",
                    "sZeroRecords": "No records found",
                    "bSort": true,
                    "bJQueryUI": true,
                    "iDisplayLength": 30,
                    "sDom": '<"H"Tfr>t<"F"ip>',
                    "oTableTools": {
                        "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                        "aButtons": [
                                {
                                    "sExtends": "xls",
                                    "sButtonText": "Excel",
                                    "mColumns": [0, 1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12, 13, 17]
                                }

                        ]

                    }
                });
                $('#ReportDetails').show();
                $('#statusProgess').hide();
                pop.hide();
            }
            else {
                alert('No Records Found');
                $('#ReportDetails').hide();
                $('#statusProgess').hide();
                pop.hide();
                $('#tdVisitWiseSerach').hide();
            }

            return false;
        }
        function reloadJQGRID() {
            oTableTools.fnReloadAjax();
            oTableTools.fnDraw();
        }
        function ShowPopUp(visitnumber) {
            var ReturnValue = window.open("..\\Reception\\PatientTrackingDetails.aspx?IsPopup=Y&VisitNumber=" + visitnumber, "", "height=800,width=1000,scrollbars=Yes");
        }
        function ViewPdf(name) {

            if (name != 'Empty') {
                $("[id$='btnTarget']").click();
                var orgID = '<%= OrgID %>';
                $('[id$="ifPDF"]').show();
                $("[id$='ifPDF']").attr('src', '<%=ResolveUrl("~/Reception/TRFImagehandler.ashx?PictureName=StationaryPdf&PdfFilePath=' + name + '")%>');
            }
            else {

                alert('Report is not ready');

            }
            return false;
        }
        function Printpdf(OrgId, Locationid, Visitid, RoleID, pdfCreated) {
            if (pdfCreated != 'No') {
                if (confirm("Do you want to print?")) {

                    var Type = 'Print';
                    var Emailaddress = '';
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/InsertNotificationManual",
                        contentType: "application/json; charset=utf-8",
                        data: "{ OrgId: '" + OrgId + "',Locationid: '" + Locationid + "',Visitid: '" + Visitid + "',Type: '" + Type + "',Emailaddress: '" + Emailaddress + "'}",
                        dataType: "json",

                        error: function(xhr, ajaxOptions, thrownError) {
                            alert("Error");
                            return false;
                        }
                    });
                    $("#iframeplaceholder").html("<iframe id='myiframe' name='myname' src='PrintVisitDetails.aspx?vid=" + Visitid + "&roleid=" + RoleID + "&type=ROUNDBPDF&invstatus=approve' style='position:absolute;top:0px; left:0px;width:0px; height:0px;border:0px;overfow:none; z-index:-1'></iframe>");
                }
            }
            else {
                alert('Report is not ready');
            }
            //return false;
        }

        function WaterMark(txtbox, evt, defaultText) {
            if (txtbox.value.length == 0 && evt.type == "blur") {
                txtbox.style.color = "gray";
                txtbox.value = defaultText;
            }
            if (txtbox.value == defaultText && evt.type == "focus") {
                txtbox.style.color = "black";
                txtbox.value = "";
            }
        }
        function blockNonNumbers(obj, e, allowDecimal, allowNegative) {
            var key;
            var isCtrl = false;
            var keychar;
            var reg;

            if (window.event) {
                key = e.keyCode;
                isCtrl = window.event.ctrlKey
            }
            else if (e.which) {
                key = e.which;
                isCtrl = e.ctrlKey;
            }

            if (isNaN(key)) return true;

            keychar = String.fromCharCode(key);

            // check for backspace or delete, or if Ctrl was pressed
            if (key == 8 || isCtrl) {
                return true;
            }

            reg = /\d/;
            var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
            var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;

            return isFirstN || isFirstD || reg.test(keychar);
        }
        function EmailPopup(OrgId, Locationid, Visitid, RoleID, Email) {
            document.getElementById("txtorgid").value = '';
            document.getElementById("txtLocid").value = '';
            document.getElementById("txtvisitid").value = '';
            document.getElementById("txtroleid").value = '';
            document.getElementById("txtMailAddress").value = '';
            document.getElementById("txtorgid").value = OrgId;
            document.getElementById("txtLocid").value = Locationid;
            document.getElementById("txtvisitid").value = Visitid;
            document.getElementById("txtroleid").value = RoleID;
            var modalPopupBehavior = $find('modalpopupsendemail');
            modalPopupBehavior.show();

            //return false;
        }
        function CheckEmpty() {
            debugger;
            var Check = document.getElementById("txtMailAddress").value;
            if (Check == "") {
                alert("Enter Email Address");
                return false;

            }
            else {
                var OrgId = '';
                var Locationid = '';
                var Visitid = '';
                var RoleID = '';

                var Type = 'ManualMail';
                var Emailaddress = '';
                OrgId = document.getElementById("txtorgid").value;
                Locationid = document.getElementById("txtLocid").value;
                Visitid = document.getElementById("txtvisitid").value;
                RoleID = document.getElementById("txtroleid").value;
                Emailaddress = document.getElementById("txtMailAddress").value;
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/InsertNotificationManual",
                    contentType: "application/json; charset=utf-8",
                    data: "{ OrgId: '" + OrgId + "',Locationid: '" + Locationid + "',Visitid: '" + Visitid + "',Type: '" + Type + "',Emailaddress: '" + Emailaddress + "'}",
                    dataType: "json",
                    success: OKsssss,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        return false;
                    }
                });
                return false;
            }
            document.getElementById("txtorgid").value = '';
            document.getElementById("txtLocid").value = '';
            document.getElementById("txtvisitid").value = '';
            document.getElementById("txtroleid").value = '';
            document.getElementById("txtMailAddress").value = '';
            var modalPopupBehavior = $find('modalpopupsendemail');
            modalPopupBehavior.hide();
            return false;
        }
        function OKsssss() {
            document.getElementById("txtorgid").value = '';
            document.getElementById("txtLocid").value = '';
            document.getElementById("txtvisitid").value = '';
            document.getElementById("txtroleid").value = '';
            document.getElementById("txtMailAddress").value = '';
            var modalPopupBehavior = $find('modalpopupsendemail');
            modalPopupBehavior.hide();
            return false;
        }
    </script>

</body>
</html>

<script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

