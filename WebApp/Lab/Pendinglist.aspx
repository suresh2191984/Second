<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Pendinglist.aspx.cs" Inherits="Lab_Pendinglist" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%--<%@ Register Src="../CommonControls/OrgHeader.ascx" TagName="MainHeader" TagPrefix="uc1" %>
<%@ Register Src="../CommonControls/Footer.ascx" TagName="Footer" TagPrefix="uc2" %>
<%@ Register Src="~/CommonControls/LeftMenu.ascx" TagName="LeftMenu" TagPrefix="uc4" %>
<%@ Register Src="../CommonControls/ErrorDisplay.ascx" TagName="ErrorDisplay" TagPrefix="uc7" %>
<%@ Register Src="~/CommonControls/Topheader.ascx" TagName="TopHeader" TagPrefix="Top" %>--%>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Pending List</title>
    <%--    <link href="../StyleSheets/Common.css" rel="stylesheet" type="text/css" />

    <script src="../Scripts/bid.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/InvPattern.js"></script>

    <script src="../Scripts/ResultCapture.js" type="text/javascript"></script>

    <%--    <script src="../Scripts/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script src="../Scripts/Common.js" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <script src="../Scripts/moment.js" type="text/javascript"></script>

    <%--    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />--%>
    <style type="text/css">
        .searchBox
        {
            font-family: Arial, Helvetica, sans-serif;
            text-align: left;
            height: 15px;
            width: 150px;
            border: 1px solid #999999;
            font-size: 11px;
            margin-left: 0px;
            background-image: url('../Images/magnifying-glass.png');
            background-repeat: no-repeat;
            padding-left: 20px;
            background-color: #F3E2A9;
        }
        .listMain
        {
            width: 350px !important;
        }
        .hidden-field
        {
            display: none;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function ClearTestDetails() {
            if (document.getElementById('txtInvestigationName') != null) {
                document.getElementById('txtInvestigationName').value = '';
            }
            if (document.getElementById('hdnTestID') != null) {
                document.getElementById('hdnTestID').value = '';
            }
            if (document.getElementById('hdnTestType') != null) {
                document.getElementById('hdnTestType').value = '';
            }
        }
        function SelectedInvestigation(source, eventArgs) {
            var TestDetails = eventArgs.get_value();
            var lstTestDetails = TestDetails.split('~');

            var TestID = lstTestDetails[1];
            var TestType = lstTestDetails[2];

            $('#hdnTestID').val(TestID);
            $('#hdnTestType').val(TestType);
        }

        function ValidateGridCount() {
            var child = $('#grdresult tr').length;
            if (child > 0) {
                return true;
            }
            return false;
        }

        function CallPrint() {
            var child = $('#grdresult tr').length;
            if (child > 0) {
                var prtContent = document.getElementById('pnlDept');
                var Hwidth = $(window).width();
                var Vwidth = $(window).height();
                var WinPrint = window.open('', '', 'width=' + Hwidth + ',height=' + Vwidth + ',scrollbars=1,status=1,resizable=1');
                WinPrint.document.write(prtContent.innerHTML);
                WinPrint.document.close();
                WinPrint.focus();
                WinPrint.print();
            }
            return false;
        }

        function BatchValidation() {
            /* Added By Venkatesh S */
            var vSampleCollected = SListForAppDisplay.Get('Lab_Pendinglist_aspx_01') == null ? "Sample Collected" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_01');
            var vSampleLoad = SListForAppDisplay.Get('Lab_Pendinglist_aspx_02') == null ? "Sample Loaded" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_02');
            var vPending = SListForAppDisplay.Get('Lab_Pendinglist_aspx_03') == null ? "Pending" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_03');
            var vRecollect = SListForAppDisplay.Get('Lab_Pendinglist_aspx_16') == null ? "Recollect" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_16');
            var vRerun = SListForAppDisplay.Get('Lab_Pendinglist_aspx_17') == null ? "Rerun" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_17');
            var vCompleted = SListForAppDisplay.Get('Lab_Pendinglist_aspx_20') == null ? "Completed" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_20');
            var vSampleTransfr = SListForAppDisplay.Get('Lab_Pendinglist_aspx_18') == null ? "Sample Transferred" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_18');
            var vSampleReceived = SListForAppDisplay.Get('Lab_Pendinglist_aspx_19') == null ? "Sample Received" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_19');
            var vYettoTransfer = SListForAppDisplay.Get('Lab_Pendinglist_aspx_21') == null ? "Yet to Transfer" : SListForAppDisplay.Get('Lab_Pendinglist_aspx_21');
            var vMandatory = SListForAppMsg.Get('Lab_Pendinglist_aspx_02') == null ? "Atleast one status is mandatory" : SListForAppMsg.Get('Lab_Pendinglist_aspx_02');
            var vMandatoryOne = SListForAppMsg.Get('Lab_Pendinglist_aspx_03') == null ? "Atleast one filter is mandatory from Protocol Group / Analyzer Name / Test Name/Department" : SListForAppMsg.Get('Lab_Pendinglist_aspx_03');
            var vFromDateToDate = SListForAppMsg.Get('Lab_Pendinglist_aspx_04') == null ? "Select From Date and To Date" : SListForAppMsg.Get('Lab_Pendinglist_aspx_04');
           var AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');
            try {
                var selectedItems = "";
                var status = '';
                $("[id*=chkStatus] input:checked").each(function() {
                    status = '';
                    if ($(this).next().html().toLowerCase()== vSampleReceived.toString().toLowerCase()) {
                        status = "SampleReceived";
                    }
                    else if ($(this).next().html().toLowerCase() == vSampleCollected.toString().toLowerCase()) {
                        status = "SampleCollected";
                    }
                    else if ($(this).next().html().toLowerCase() == vPending.toString().toLowerCase()) {
                        status = "Pending";
                    }
                    else if ($(this).next().html().toLowerCase() == vRecollect.toString().toLowerCase()) {
                        status = "Retest";
                    }
                    else if ($(this).next().html().toLowerCase() == vRerun.toString().toLowerCase()) {
                        status = "Recheck";
                    }
                    else if ($(this).next().html().toLowerCase() == vCompleted.toString().toLowerCase()) {
                    status = "Completed";
                    }
                    else if ($(this).next().html().toLowerCase() == vSampleTransfr.toString().toLowerCase()) {
                        status = "SampleTransferred";
                    }
                    else if ($(this).next().html().toLowerCase() == vYettoTransfer.toString().toLowerCase()) {
                    status = "Yet to Transfer";
                    }
                    if (selectedItems == "") {
                        selectedItems = status;
                    }
                    else {
                        selectedItems += "," + status;
                    }
                });
                if (selectedItems == "") {
                    ValidationWindow(vMandatory, AlertType);
                    return false;
                }
                document.getElementById('hdnSelectedValue').value = selectedItems;
                var ddlDevice = $("#ddlInstrument :selected").val();
                var ddlProtocol = $("#ddlProtocol :selected").val();
                var ddldepartment = $("#ddldepartment :selected").val();
                if (ddlProtocol == '0' && ddlDevice == '0' && $('#txtInvestigationName').val() == "" && ddldepartment=='0') {
                    ValidationWindow(vMandatoryOne, AlertType);
                    return false;
                }
                if ($('#txtFrom').val() == "" && $('#txtTo').val() == "") {
                    ValidationWindow(vFromDateToDate, AlertType);
                    return false;
                }
            }
            catch (e) {
                return false;
            }
        }

        function onSave() {
            /* Added By Venkatesh S */
            var vSelectTest = SListForAppMsg.Get('Lab_Pendinglist_aspx_05') == null ? "Select From Date and To Date" : SListForAppMsg.Get('Lab_Pendinglist_aspx_05');
            var AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01');
            try {

                var lstResult = [];

                $("[id$='datalist'] input[type=checkbox]:checked").each(function() {
                    var ctrId = $(this).attr('id');

                    var $tr = $(this).closest('tr');
                    if (ctrId.indexOf('chkAll') == -1) {
                        lstResult.push(
                        {
                            PatientInvID: $tr.find("input:hidden[id$='hdnPatientInvID']").val()
                        });
                    }
                });
                if (lstResult.length > 0) {
                    $("[id$='hdnvalues']").val(JSON.stringify(lstResult));
                }
                else {
                    ValidationWindow(vSelectTest, AlertType);
                    return false;
                }
            }
            catch (e) {
                return false;
            }
        }
        function TempDate() {
            $("#txtFrom").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'
            });
            $("#txtTo").datepicker({
                changeMonth: true,
                changeYear: true,
                maxDate: 0,
                yearRange: '1900:2100'
            })
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="360000">
        <Services>
            <asp:ServiceReference Path="~/WebService.asmx" />
        </Services>
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <%--  <script type="text/javascript" src="../Scripts/jquery-1.7.2.min.js"></script>

                        <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

        <script type="text/javascript">
            // $(function() {
            //$("#txtFrom").datepicker({
            //         changeMonth: true,
            //        changeYear: true,
            //       maxDate: 0,
            //      yearRange: '1900:2100'
            //   });
            //  $("#txtTo").datepicker({
            //     changeMonth: true,
            //     changeYear: true,
            //     maxDate: 0,
            //     yearRange: '1900:2100'
            // })
            //});
            //
        </script>

        <div>
            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnBatchSearch" meta:resourcekey="Panel1Resource1">
                <div id="DivSearchArea" class="filterdataheader2" style="display: block;">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:UpdateProgress ID="upProgress" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                <ProgressTemplate>
                                    <div id="progressBackgroundFilter" class="a-center">
                                    </div>
                                    <div id="processMessage" class="a-center w-20p">
                                        <asp:Image ID="img1" CssClass="w-40 h-40" runat="server" ImageUrl="../Images/loading.GIF"
                                            meta:resourcekey="img1Resource1" />
                                    </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <table class="w-100p searchPanel">
                                <tr>
                                    <td class="w-10p a-right">
                                <asp:Label ID="lblanalyzer" class="style1" runat="server" Text="Analyzer Name" meta:resourceKey="lblanalyzerResource1"></asp:Label>
                                    </td>
                                    <td class="w-12p a-left">
                                        <span class="richcombobox">
                                    <asp:DropDownList ID="ddlInstrument" CssClass="ddlsmall" runat="server" meta:resourceKey="ddlInstrumentResource1">
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                    <td class="a-right">
                                <asp:Label ID="lblInvestigationName" class="style1" runat="server" Text="Test Name"
                                    meta:resourceKey="lblInvestigationNameResource1"></asp:Label>
                                    </td>
                                    <td class="a-left w-14p">
                                        <asp:TextBox ID="txtInvestigationName" CssClass="searchBox small" runat="server"
                                    onfocus="javascript:ClearTestDetails();" meta:resourceKey="txtInvestigationNameResource1"></asp:TextBox>
                                        <ajc:AutoCompleteExtender ID="AutoInvestigations" MinimumPrefixLength="2" runat="server"
                                            TargetControlID="txtInvestigationName" ServiceMethod="FetchInvestigationNameForOrg"
                                            ServicePath="~/WebService.asmx" EnableCaching="False" CompletionInterval="2"
                                            CompletionListCssClass="wordWheel listMain .box" CompletionListItemCssClass="wordWheel itemsMain"
                                            CompletionListHighlightedItemCssClass="wordWheel itemsSelected3" Enabled="True"
                                            DelimiterCharacters=";,:" OnClientItemSelected="SelectedInvestigation" OnClientShown="TestPopulated">
                                        </ajc:AutoCompleteExtender>
                                        &nbsp;
                                        <asp:HiddenField ID="hdnTestID" runat="server" Value="" />
                                        <asp:HiddenField ID="hdnTestType" runat="server" Value="" />
                                    </td>
                                    <td class="w-10p a-right">
                                <asp:Label runat="server" ID="lblFromdate" Text="From DateTime" class="style1" Width="120px"
                                    meta:resourceKey="lblFromdateResource1"></asp:Label>
                                    </td>
                                    <td class="w-10p">
                                <asp:TextBox runat="server" ID="txtFrom" CssClass="small" MaxLength="25" size="25"
                                    meta:resourceKey="txtFromResource1"></asp:TextBox>
                                    </td>
                                    <td class="w-8p">
                                        <a href="javascript:NewCssCal('<% =txtFrom.ClientID %>','ddmmyyyy','arrow',true,12,'Y','Y')">
                                            <img src="../Images/Calendar_scheduleHS.png" class="w-16 h-16" alt="Pick a date"></a>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                    </td>
                                    <td class="w-6p">
                                <asp:Label runat="server" ID="lblToDate" Text="To DateTime" class="style1 w-100"
                                    meta:resourceKey="lblToDateResource1"></asp:Label>
                                    </td>
                                    <td class="w-10p">
                                <asp:TextBox runat="server" ID="txtTo" CssClass="small" MaxLength="20" size="25"
                                    meta:resourceKey="txtToResource1"></asp:TextBox>
                                    </td>
                                    <td class="w-8p">
                                        <a href="javascript:NewCssCal('<% =txtTo.ClientID %>','ddmmyyyy','arrow',true,12,'Y','N')">
                                            <img src="../Images/Calendar_scheduleHS.png" class="w-16 h-16" alt="Pick a date"></a>
                                        &nbsp;<img src="../Images/starbutton.png" alt="" class="v-middle" />
                                    </td>
                                </tr>
                                <tr>
                                    <td class="w-8p a-right">
                                <asp:Label ID="lblProtocol" class="style1" runat="server" Text="Protocol Group" meta:resourceKey="lblProtocolResource1"></asp:Label>
                                    </td>
                                    <td class="w-13p a-left">
                                        <span class="richcombobox">
                                    <asp:DropDownList ID="ddlProtocol" CssClass="ddlsmall" runat="server" meta:resourceKey="ddlProtocolResource1">
                                            </asp:DropDownList>
                                        </span>
                                    </td>
                                   <%-- Department Selection--%>
                                    <td>
                                <asp:Label ID="lbldepartment" runat="server" Text="Department" meta:resourceKey="lbldepartmentResource1"></asp:Label>
                                    </td>
                                    <td>
                                <asp:DropDownList ID="ddldepartment" CssClass="ddlsmall" runat="server" meta:resourceKey="ddldepartmentResource1">
                                </asp:DropDownList>
                                    </td>
                                     <td class="w-5p">
                                        <asp:CheckBox ID="chkGroup" runat="server" Text="Group Level" meta:resourceKey="ChkIsGroup" />
                                    </td>
                                   <%-- End Department Selection--%>
                                    <td class="w-8p a-right">
                                        <asp:Label ID="lblstat" runat="server" Text="Status :" meta:resourceKey="lblstatResource1"
                                            Font-Bold="true"></asp:Label>
                                    </td>
                                    <td class="w-50p" colspan="4">
                                        <table class="w-100p">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkAll" runat="server" Text="All" Checked="true" meta:resourceKey="chkAllResource1" />
                                                </td>
                                                <td>
                                                    <asp:CheckBoxList ID="chkStatus" runat="server" RepeatDirection="Horizontal" onclick="CBListClick(this);">
                                             <%--   <asp:ListItem Text="Sample Received" Value="SampleReceived" Selected="True" meta:resourceKey="ListItemResource1"></asp:ListItem>
                                                <asp:ListItem Text="Sample Loaded" Value="SampleLoaded" Selected="True" meta:resourceKey="ListItemResource2"></asp:ListItem>
                                                <asp:ListItem Text="Pending" Value="Pending" Selected="True" meta:resourceKey="ListItemResource3"></asp:ListItem>--%>
                                                    </asp:CheckBoxList>
                                                </td>
                                            </tr>
                                        </table>
                                        <td class="w-50p">
                                            <asp:Label ID="lblstatTest" runat="server" Text="Other Status :" Font-Bold="true"
                                                meta:resourceKey="lblstatTestResource1"></asp:Label><br />
                                            <asp:CheckBox ID="ChkISSTAT" runat="server" Text="IsSTAT" meta:resourceKey="ChkISSTATResource1" />
                                        </td>
                                        <td>
                                    <asp:Button ID="btnBatchSearch" Font-Bold="True" runat="server" Text="Search" OnClick="btnBatchSearch_Click"
                                        OnClientClick="return BatchValidation()" CssClass="btn w-60 h-30" meta:resourceKey="btnBatchSearchResource1" />
                                        </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <table class="w-100p" id="tblContent">
                    <tr>
                        <td class="a-right">
                            <asp:ImageButton ID="imgBtnXL" runat="server" ImageUrl="../Images/ExcelImage.GIF"
                                ToolTip="Save As Excel" OnClick="imgBtnXL_Click" CssClass="h-16" OnClientClick="return ValidateGridCount();"
                                meta:resourceKey="imgBtnXLResource1" />
                            <asp:LinkButton ID="lnkExportXL" Text="Export To XL" runat="server" Font-Bold="True"
                                OnClientClick="return ValidateGridCount();" CssClass="font12" ForeColor="Black"
                                ToolTip="Save As Excel" OnClick="lnkExportXL_Click" meta:resourceKey="lnkExportXLResource1"></asp:LinkButton>&nbsp;&nbsp;&nbsp;
                            <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClientClick="CallPrint();return false;"
                                ToolTip="Print" meta:resourceKey="btnPrintResource1" />
                            <b id="printText" runat="server">
                                <asp:LinkButton ID="lnkPrint" Text="Print" Font-Underline="True" OnClientClick="CallPrint();return false;"
                                    runat="server" Font-Bold="True" Font-Size="12px" ForeColor="Black" ToolTip="print"
                                    meta:resourceKey="lnkPrintResource1"></asp:LinkButton></b>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>
        <div>
            <asp:UpdatePanel ID="up1" runat="server">
                <ContentTemplate>
                    <asp:Panel runat="server" ID="pnlDept" Visible="False" meta:resourcekey="pnlDeptResource1">
                        <table class="w-100p bg-row padding10" runat="server" id="Listddetails" style="display: block;">
                            <tr>
                                <td class="w-7p">
                                    <asp:Label ID="lblgeneration" class="style1" runat="server" Text="Generated by" Font-Bold="True"
                                        meta:resourceKey="lblgenerationResource1"></asp:Label>
                                </td>
                                <td class="w-1p">
                                    <asp:Label ID="lblhifen1" class="style1" runat="server" Text=":" Font-Bold="True"
                                        meta:resourceKey="lblhifen1Resource1"></asp:Label>
                                </td>
                                <td class="w-12p">
                                    <asp:Label ID="lblg" class="style1" runat="server" Font-Bold="True" meta:resourceKey="lblgResource1"></asp:Label>
                                </td>
                                <td class="w-7p">
                                    <asp:Label ID="Lblprotocal" class="style1" runat="server" Text="Protocal Name" Font-Bold="True"
                                        meta:resourceKey="LblprotocalResource1"></asp:Label>
                                </td>
                                <td class="w-1p">
                                    <asp:Label ID="Label1" class="style1" runat="server" Text=":" Font-Bold="True" meta:resourceKey="Label1Resource1"></asp:Label>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="lblprotocalvalue" class="style1" runat="server" Text="-" Font-Bold="True"
                                        meta:resourceKey="lblprotocalvalueResource1"></asp:Label>
                                </td>
                                <td class="w-7p">
                                    <asp:Label ID="lblAnalyzerNametxt" class="style1" runat="server" Text="Analyzer Name"
                                        Font-Bold="True" meta:resourceKey="lblAnalyzerNametxtResource1"></asp:Label>
                                </td>
                                <td class="w-1p">
                                    <asp:Label ID="lbl4" class="style1" runat="server" Text=":" Font-Bold="True" meta:resourceKey="lbl4Resource1"></asp:Label>
                                </td>
                                <td class="w-15p">
                                    <asp:Label ID="lblAnalyzerName" class="style1" runat="server" Text="-" Font-Bold="True"
                                        meta:resourceKey="lblAnalyzerNameResource1"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="w-7p">
                                    <asp:Label ID="lblprint" class="style1" runat="server" Text="Printing Date/Time"
                                        Font-Bold="True" meta:resourceKey="lblprintResource1"></asp:Label>
                                </td>
                                <td class="w-1p">
                                    <asp:Label ID="Label2" class="style1" runat="server" Text=":" Font-Bold="True" meta:resourceKey="Label2Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lbldate" class="style1" runat="server" Font-Bold="True" meta:resourceKey="lbldateResource1"></asp:Label>
                                </td>
                                <td class="w-7p">
                                    <asp:Label ID="lblfrom" class="style1" runat="server" Text="From and To Date" Font-Bold="True"
                                        meta:resourceKey="lblfromResource1"></asp:Label>
                                </td>
                                <td class="w-1p">
                                    <asp:Label ID="Label3" class="style1" runat="server" Text=":" Font-Bold="True" meta:resourceKey="Label3Resource1"></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblFromNTodateValue" class="style1" runat="server" Text="-" Font-Bold="True"
                                        meta:resourceKey="lblFromNTodateValueResource1"></asp:Label>
                                </td>
                            </tr>
                        </table>
                        <asp:GridView ID="grdresult" runat="server" ForeColor="Black" CssClass="gridView w-100p m-auto"
                            AutoGenerateColumns="False" EmptyDataText="No Matching Records Found" OnRowDataBound="grdresult_RowDataBound"
                            OnPreRender="grdresult_PreRender" GridLines="Both" meta:resourceKey="grdresultResource1">
                            <HeaderStyle Font-Bold="True" CssClass="dataheader1" />
                            <Columns>
                                <asp:TemplateField HeaderText="S.No" meta:resourceKey="TemplateFieldResource1">
                                    <ItemTemplate>
                                        <%# Container.DataItemIndex + 1 %>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="w-2p a-center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="RegisteredLocation" HeaderText="Reg.Location" meta:resourceKey="BoundFieldResource1">
                                    <ItemStyle CssClass="w-8p a-left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="RegisteredDate" HeaderText="Reg.date/time" meta:resourceKey="BoundFieldResource2">
                                    <ItemStyle CssClass="w-7p" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ReceivedDateTime" HeaderText="Received date/time" meta:resourceKey="BoundFieldResource3">
                                    <ItemStyle CssClass="w-7p" />
                                </asp:BoundField>
                                <asp:BoundField DataField="VisitNumber" HeaderText="Visit/Barcode No" meta:resourceKey="BoundFieldResource4">
                                    <ItemStyle CssClass="w-8p" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Name" HeaderText="Patient Name" meta:resourceKey="BoundFieldResource5">
                                    <ItemStyle CssClass="a-left w-13p" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Age" HeaderText="Age/Sex" meta:resourceKey="BoundFieldResource6">
                                    <ItemStyle CssClass="w-8p" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Investigationname" HeaderText="Test Name" meta:resourceKey="BoundFieldResource7">
                                    <ItemStyle CssClass="w-15p a-left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Status" HeaderText="Status" meta:resourceKey="BoundFieldResource11">
                                    <ItemStyle CssClass="w-15p " />
                                </asp:BoundField>
                                <asp:BoundField DataField="GroupName"  HeaderText="Group / Package Name">
                                    <ItemStyle CssClass="w-15p " />
                                </asp:BoundField>
                               <%-- <asp:BoundField DataField="GroupName" HeaderText="Test Details" >
                                    <ItemStyle CssClass="w-15p "  />
                                </asp:BoundField>--%>
                                <asp:BoundField DataField="TatDateTime" HeaderText="TAT DateTime" meta:resourceKey="BoundFieldResource9" HeaderStyle-CssClass="hidden-field">
                                    <ItemStyle CssClass="w-8p hidden-field" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="WL.ID" meta:resourceKey="TemplateFieldResource2">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWLID" runat="server" meta:resourceKey="lblWLIDResource1" Text='<%# bind("WorkListID") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="w-3p a-center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="ClientName" HeaderText="Client Name" meta:resourceKey="BoundFieldResource10">
                                    <ItemStyle CssClass="a-center v-bottom w-12p" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Type" HeaderText="Type" meta:resourceKey="BoundFieldResource11"  HeaderStyle-CssClass="hidden-field">
                                    <ItemStyle CssClass="a-center v-bottom w-12p hidden-field " />
                                </asp:BoundField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="dataheader1"></EmptyDataRowStyle>
                        </asp:GridView>
                        <table id="PendingList" class="bg-row" border="1" style="display: none; border-collapse: collapse;
                            empty-cells: show; white-space: nowrap; text-align: left;">
                            <thead>
                                <tr>
                                    <%-- <th>
                                        S.No
                                    </th>--%>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_04 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_05 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_06 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_07 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_08 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_09 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_10 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_11 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_12 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_13 %>
                                    </th>
                                    <th>
                                        <%=Resources.Lab_ClientDisplay.Lab_Pendinglist_aspx_14 %>
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </asp:Panel>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    <asp:HiddenField ID="hdnSelectedValue" runat="server" />
	<asp:HiddenField ID="hdnMessages" runat="server" />
	
    <%--<script src="../Scripts/jquery-1.8.1.min.js" type="text/javascript"></script>

    <script src="../Scripts/JsonScript.js" type="text/javascript"></script>
    
    <script type="text/javascript" src="../Scripts/jquery-ui-1.8.19.custom.min.js"></script>--%>

    <script type="text/javascript">
        $(document).ready(function() {
            
        });

        $(function() {
        CheckAllCheckbox();

        });


        function CheckAllCheckbox() {
            if ($('#chkAll').is(":checked")) {
                $("[id*=chkStatus] input").prop("checked", "checked");
            } else {
                $("[id*=chkStatus] input").removeAttr("checked");
            }
            $('#chkAll').click(
            function() {
                // $("INPUT[type='checkbox']").attr('checked', $('#chkAll').is(':checked'));
                // $("INPUT[type='checkbox']").prop('checked', $('#chkAll').is(':checked'));

                if ($(this).is(":checked")) {
                    $("[id*=chkStatus] input").prop("checked", "checked");
                } else {
                    $("[id*=chkStatus] input").removeAttr("checked");
                }

            });
        }
        function CBListClick(chkList) {
            var chks = chkList.getElementsByTagName("input");
            var count = 0;
            for (var i = 0; i < chks.length; i++) {
                if (chks[i].checked) {
                    count++;
                }
            }
            if (count == 5) {
                $('#chkAll').attr('checked', 'true');
            }
            else {
                $('#chkAll').removeAttr('checked');
            }
        }
    </script>

    <script type="text/javascript" language="javascript">
        function fnGetPendingList(OrgID, RoleID, InvID, InvType, LoginId, IsTrustedDetails, deviceid,
                        protocalID, fromdate, todate, pStatus, IsStat, pDeptid) {
            try {
                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetPendingList",
                    contentType: "application/json; charset=utf-8",
                    data: "{ OrgID: '" + OrgID + "',RoleID: '" + RoleID + "',InvID: '" + InvID + "',InvType: '"
                    + InvType + "',LoginId: '" + LoginId + "',IsTrustedDetails:'" + IsTrustedDetails + "',deviceid:'"
                    + deviceid + "',protocalID:'" + protocalID + "',fromdate:'" + fromdate + "',todate:'"
                    + todate + "',pStatus:'" + pStatus + "',IsStat:'" + IsStat + "',pDeptid:'" + pDeptid + "'}",
                    dataType: "json",
                    success: fnLoadPendingList,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        $('#PendingList').hide();
                        return false;
                    }
                });
            }
            catch (e) {

            }
        }
        function fnLoadPendingList(rltdata) {
            var vSelectTest = SListForAppMsg.Get('Lab_Pendinglist_aspx_result') == null ? "No Results found" : SListForAppMsg.Get('Lab_Pendinglist_aspx_result');
            var AlertType = SListForAppMsg.Get('Lab_Pendinglist_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Lab_Pendinglist_aspx_01')
            try {
                var oTable;
                var countR = rltdata.d.length;
                if (countR > 0 && rltdata != "[]") {
                    if (countR > 0) {
                        oTable == $('#PendingList').dataTable({
                        oLanguage: {
                            "sUrl": getLanguage()
                        },
                            "bDestroy": true,
                            "bAutoWidth": false,
                            "aaData": rltdata.d,
                            "sDom": '<"H"Tfr>t<ip>',
                            //"sDom": '<"H"lr>t<"F"ip>',
                            "bFilter": true,
                            "bInfo": false,
                            "bProcessing": true,
                            //"bServerSide": true,
                            "aoColumns": [
                            //                                { "mDataProp": "S.No"
                            //                                                                  ,
                            //                                    "mRender": function(data, type, full) {
                            //                                        var index = iDisplayIndex + 1;
                            //                                        $('td:eq(0)', nRow).html(index);
                            //                                        return nRow;
                            //                                    }
                            //                                },
                                {"mDataProp": "RegisteredLocation" },
                                { "mDataProp": "RegisteredDate"//,
//                                    "mRender": function(data, type, full) {
//                                        var dtStart = new Date(parseInt(data.substr(6)));
//                                        var dtStartWrapper = moment(dtStart);
//                                        return dtStartWrapper.format('DD/MM/YYYY HH:mm');
//                                    }
                                },
                                { "mDataProp": "ReceivedDateTime"//,
//                                    "mRender": function(data, type, full) {
//                                        var dtStart = new Date(parseInt(data.substr(6)));
//                                        var dtStartWrapper = moment(dtStart);
//                                        return dtStartWrapper.format('DD/MM/YYYY HH:mm');
//                                    }
                                },
                                { "mDataProp": "VisitNumber" },
                                { "mDataProp": "Name" },
                                { "mDataProp": "Age" },
                                { "mDataProp": "InvestigationName" },
                                { "mDataProp": "GroupName" },
                                { "mDataProp": "TATDateTime"///,
                                   // "mRender": function(data, type, full) {
                                   //     return data;
                                        //                                        var dtReport = new Date(parseInt(data.substr(6)));
                                        //                                        var dtReportWrapper = moment(dtReport);
                                        //                                        return dtReportWrapper.format('DD/MM/YYYY HH:mm');
                                   // }

                                },
                        { "mDataProp": "WorkListID" },
                        { "mDataProp": "ClientName" }
                        ],
                            "bPaginate": true,
                            "sPaginationType": "full_numbers",
                            "fnDrawCallback": function() {        //After table is redrawn, customize the pagination control to consistently show 2-digit page numbers to reduce button wandering near the 10th page.
                                $('.paginate_button, .paginate_active').each(function() {
                                    var pgNbr = $(this).text();
                                    if (pgNbr.length == 1 && pgNbr >= '1' && pgNbr <= '9')
                                        $(this).prepend('0');
                                });
                            },
                            "bSort": false,
                            "bJQueryUI": true,
                            "iDisplayLength": 18,
                            "bLengthChange": false,
                            "SDom": '<"top"fp>rt<"bottom"><"clear">'
                        });

                    }
                    $('#PendingList').show();
                } else {
                    $('#PendingList').hide();
                    ValidationWindow(vSelectTest, AlertType); 
                    //alert('No Results found'); 
               }
            }
            catch (e) { alert(0); }
        }
    </script>

    </form>

    <script src="../Scripts/jquery.dataTables.min.js" type="text/javascript"></script>

</body>
</html>
