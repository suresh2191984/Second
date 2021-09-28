<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TestStatisticsReport.aspx.cs"
    Inherits="Reports_TestStatisticsReport" meta:resourcekey="PageResource1" %>

<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" type="text/css" href="http://ajax.aspnetcdn.com/ajax/jquery.dataTables/1.9.4/css/jquery.dataTables.css" />

    <script src="../Scripts/AdobeReaderDetection.js" type="text/javascript" language="javascript" />

<%--    <script src="../Scripts/jquery-1.2.2.pack.js" type="text/javascript"></script>
    <script src="../Scripts/jquery-1.4.1.js" type="text/javascript"></script>
--%>
    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>
    
    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <title><%=Resources.Reports_AppMsg.Reports_TestStatisticsReport_aspx_hdr%></title>

    <script language="javascript" type="text/javascript">
        function ValidDate(obj1, obj2) {
            var obj = document.getElementById(obj1);
            var obj1 = document.getElementById(obj2);
            var AlrtWinHdr = SListForAppMsg.Get("Reports_TestStatisticsReport_Alert") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_Alert") : "Alert";
            var UsrAlrtMsg3 = SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_4") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_4") : "Please select valid ToDate!!!";
            var UsrAlrtMsg = SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_01") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_01") : "Select From Date!!!";
            if (obj.value == '') {
                ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                obj1.value = '';
                obj.focus();
            }
            var currentTime;
            if (obj.value != '' && obj.value != '__/__/____') {
                dobDt = obj.value.split('/');
                var dobDtTime = new Date(dobDt[2] + '/' + dobDt[0] + '/' + dobDt[1]);
                var mMonth = (dobDtTime.getMonth() + 1);
                var mDay = parseInt(dobDt[1]);
                var mYear = parseInt(dobDt[2]);
            }
            if (obj1.value != '' && obj1.value != '__/__/____') {
                dobDt1 = obj1.value.split('/');
                var dobDtTime = new Date(dobDt1[2] + '/' + dobDt1[0] + '/' + dobDt1[1]);
                var month = (dobDtTime.getMonth() + 1);
                var day = parseInt(dobDt1[1]);
                var year = parseInt(dobDt1[2]);
            }
            if (mYear > year) {
                ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
                document.getElementById('txtToDate').value = "";
                return false;
            }
            else if ((mYear == year) && (mMonth > month)) {
            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            document.getElementById('txtToDate').value = "";
                return false;
            }
            else if (mYear == year && mMonth == month && mDay > day) {

            ValidationWindow(UsrAlrtMsg3, AlrtWinHdr);
            document.getElementById('txtToDate').value = "";
                return false;
            }
        }
        function GetData() {
            //debugger;
            var AlrtWinHdr = SListForAppMsg.Get("Reports_TestStatisticsReport_Alert") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_Alert") : "Alert";
            var UsrAlrtMsg = SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_01") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_01") : "Select From Date!!!";
            var UsrAlrtMsg1 = SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_02") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_02") : "Select To Date!!!";
            var UsrAlrtMsg2 = SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_03") != null ? SListForAppMsg.Get("Reports_TestStatisticsReport_aspx_03") : "Please select locations!!!";
            try {
                if (document.getElementById('txtFromDate').value == '' || document.getElementById('txtFromDate').value == '__/__/____') {
                    ValidationWindow(UsrAlrtMsg, AlrtWinHdr);
                  //  alert('Select From Date!!!');
                    return false;   
                }
                if (document.getElementById('txtToDate').value == '' || document.getElementById('txtToDate').value == '__/__/____') {
                    ValidationWindow(UsrAlrtMsg1, AlrtWinHdr);
                    //alert('Select To Date!!!');
                    return false;
                }
                if (document.getElementById('ddlLocations').value == '0') {
                    ValidationWindow(UsrAlrtMsg2, AlrtWinHdr);
                    //alert('Please select locations!!!');
                    return false;
                }
                document.getElementById('tmpdiv').style.display = 'block';

                var pFromDate = document.getElementById('txtFromDate').value;
                var pToDate = document.getElementById('txtToDate').value;
                var location = document.getElementById('ddlLocations').value;
                var pRoutine = document.getElementById('ddlRoutineStat').value;
                if (document.getElementById('ddlRoutineStat').value != null && document.getElementById('ddlRoutineStat').value != '') {
                    pRoutine = document.getElementById('ddlRoutineStat').value;
                }
                else {
                    pRoutine = 0;
                }
                var pClientID;
                  if (document.getElementById('txtClientName').value == null || document.getElementById('txtClientName').value =='')
                  {
                  document.getElementById('hdnClientID').value="0";
                  } 
                if (document.getElementById('hdnClientID').value != null && document.getElementById('hdnClientID').value != '') {
                    pClientID = document.getElementById('hdnClientID').value;
                }
                else {
                    pClientID = 0;
                }
                document.getElementById('hdnFromDate').value = pFromDate;
                document.getElementById('hdnToDate').value = pToDate;
                document.getElementById('hdnLocations').value = location;

                $.ajax({
                    type: "POST",
                    url: "../WebService.asmx/GetTestStatReport",
                    contentType: "application/json; charset=utf-8",
                    data: "{ 'FromDate': '" + pFromDate + "','ToDate': '" + pToDate + "','LocationId': '" + location + "','ClientID':'" + pClientID + "','Routine':'" + pRoutine + "'}",
                    dataType: "json",
                    success: AjaxGetFieldDataSucceeded,
                    error: function(xhr, ajaxOptions, thrownError) {
                        alert("Error");
                        return false;
                    }
                });
            }
            catch (e) {

            }
        }
        function AjaxGetFieldDataSucceeded(result) {
            if ('' == '0') {
                var oTable;

                if (result != "[]") {
                    spanArray = [];
                    spanArray.push(result);
                    oTable = $('#example').dataTable({
                        "bDestroy": true,
                        "bAutoWidth": false,
                        "bProcessing": true,
                        "aaData": result.d,
                        "aoColumns": [

            { "mDataProp": "ProcessLocation" },
            { "mDataProp": "TestCode" },
            { "mDataProp": "TestName" },
            { "mDataProp": "January" },
            { "mDataProp": "February" },
            { "mDataProp": "March" },
            { "mDataProp": "April" },
            { "mDataProp": "May" },
            { "mDataProp": "June" },
            { "mDataProp": "July" },
            { "mDataProp": "August" },
            { "mDataProp": "September" },
            { "mDataProp": "October" },
            { "mDataProp": "November" },
            { "mDataProp": "December"}],
                        "sPaginationType": "full_numbers",
                        "aaSorting": [[0, "asc"]],
                        "bJQueryUI": true,
                        "iDisplayLength": 30,
                        //"sDom": 'T<"clear">lfrtip',
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools": {
                            "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                            "aButtons": [
                            "copy", "csv", "xls", "pdf",
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "Save",
                                 "aButtons": ["csv", "xls", "pdf"]
                             }
                          ]
                        }
                    });
                }
                $('#example').show();
                document.getElementById('tmpdiv').style.display = 'none';
                $('#example1').parents('div.dataTables_wrapper').first().hide();
            }
            else {
                var oTable;

                if (result != "[]") {
                    spanArray = [];
                    spanArray.push(result);
                    oTable = $('#example1').dataTable({
                        "bDestroy": true,
                        "bAutoWidth": false,
                        "bProcessing": true,
                        "aaData": result.d,
                        "aoColumns": [
            { "mDataProp": "ProcessLocation" },
            { "mDataProp": "OrderedLocation" },
            { "mDataProp": "TestCode" },
            { "mDataProp": "TestName" },
            { "mDataProp": "January" },
            { "mDataProp": "February" },
            { "mDataProp": "March" },
            { "mDataProp": "April" },
            { "mDataProp": "May" },
            { "mDataProp": "June" },
            { "mDataProp": "July" },
            { "mDataProp": "August" },
            { "mDataProp": "September" },
            { "mDataProp": "October" },
            { "mDataProp": "November" },
            { "mDataProp": "December"}],
                        "sPaginationType": "full_numbers",
                        "aaSorting": [[0, "asc"]],
                        "bJQueryUI": true,
                        "iDisplayLength": 30,
                        //"sDom": 'T<"clear">lfrtip',
                        "sDom": '<"H"Tfr>t<"F"ip>',
                        "oTableTools": {
                            "sSwfPath": "../Media/copy_csv_xls_pdf.swf",
                            "aButtons": [
                            "copy", "csv", "xls", "pdf",
                             {
                                 "sExtends": "collection",
                                 "sButtonText": "Save",
                                 "aButtons": ["csv", "xls", "pdf"]
                             }
                          ]
                        }
                    });
                }
                $('#example1').show();
                $('#example').parents('div.dataTables_wrapper').first().hide();
               
                document.getElementById('tmpdiv').style.display = 'none';
            }

        }

        function SelectedClient(source, eventArgs) {

            var Name = eventArgs.get_text();
            var list = eventArgs.get_value().split('^');
            var ID = list[5];
            document.getElementById('hdnClientID').value = ID;
        }
        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager2" runat="server">
                </asp:ScriptManager>
        <Attune:Attuneheader ID="Attuneheader" runat="server" />
                            <div class="contentdata">
                                <div id="tmpdiv" style="display: none">
                                    <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                </div>
                                <asp:UpdatePanel ID="up1" runat="server">
                                    <ContentTemplate>
                                        <asp:UpdateProgress ID="Progressbar" AssociatedUpdatePanelID="up1" runat="server">
                                           <ProgressTemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img1" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </ProgressTemplate>
                                        </asp:UpdateProgress>
                                        <table id="tblContent" runat="server" class="w-100p searchPanel">
                                            <tr>
                                                <td>
                                                    
                                                    <asp:Panel ID="pnlsearch" runat="server" CssClass="w-100p" 
                                                        meta:resourcekey="pnlsearchResource1">
                                                        <table id="tblsearch" runat="server" class="dataheaderInvCtrl w-100p">
                                                            <tr runat="server">
                                                                <td runat="server">
                                                                    <asp:Label ID="fromDate" runat="server" Text="From Date" meta:resourcekey="fromDateResource1"></asp:Label>
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromDate"
                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                                        ControlToValidate="txtFromDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                                                        Format="MM/dd/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" style="display: block;" />
                                                                </td>
                                                                <td runat="server">
                                                                    <asp:Label ID="toDate" runat="server" Text="To Date"  meta:resourcekey="toDateResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                                        CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                                                    <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtToDate"
                                                                        Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                                        CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                                        CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                                        CultureTimePlaceholder="" Enabled="True" />
                                                                    <ajc:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="MaskedEditExtender6"
                                                                        ControlToValidate="txtToDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                                        Display="Dynamic" TooltipMessage="(dd-mm-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                                        ValidationGroup="MKE" ErrorMessage="MaskedEditValidator6" meta:resourcekey="MaskedEditValidator5Resource1" />
                                                                    <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                                                        Format="MM/dd/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                                                        <img src="../Images/starbutton.png" alt="" align="middle" style="display: block;" />
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="Label1" runat="server" Text="Location" meta:resourcekey="Label1Resource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <span class="richcombobox" style="width: 155px;">
                                                                        <asp:DropDownList ID="ddlLocations" CssClass="ddl" Width="155px" runat="server">
                                                                            <%--<asp:ListItem Text="---Select---" Value="-1" meta:resourcekey="ListItemResource1"></asp:ListItem>
                                                                            <asp:ListItem Text="Ordered Location" Value="1" meta:resourcekey="ListItemResource3"></asp:ListItem>
                                                                            <asp:ListItem Text="Process Location" Value="0" meta:resourcekey="ListItemResource2"></asp:ListItem>
                                                                            --%>
                                                                        </asp:DropDownList> &nbsp;<img src="../Images/starbutton.png" alt="" align="middle" style="display: block;" />
                                                                        
                                                                    </span>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Label ID="lblRoutine" runat="server" Text="Routine/STAT" meta:resourcekey="lblRoutineResource1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlRoutineStat" runat="server" CssClass="ddl">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblClientName" runat="server" Text="Client Name" meta:resourcekey="lblClientNameResouce1"></asp:Label>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtClientName" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                                                    <ajc:AutoCompleteExtender ID="AutoCompleteExtenderClient" runat="server" TargetControlID="txtClientName"
                                                                        BehaviorID="AutoCompleteExLstGrps" CompletionListCssClass="wordWheel listMain .box"
                                                                        CompletionListItemCssClass="wordWheel itemsMain" CompletionListHighlightedItemCssClass="wordWheel itemsSelected3"
                                                                        EnableCaching="False" MinimumPrefixLength="2" CompletionInterval="1" FirstRowSelected="True"
                                                                        ServiceMethod="GetRateCardForBilling" ServicePath="~/OPIPBilling.asmx" DelimiterCharacters=""
                                                                        OnClientItemSelected="SelectedClient" Enabled="True">
                                                                    </ajc:AutoCompleteExtender>
                                                                </td>
                                                                <td colspan="2">
                                                                    <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClientClick="javascript:GetData();return false;" meta:resourcekey="btnSearchResource1"/>
                                                                    <asp:LinkButton ID="lnkBack" runat="server" Text="Back &nbsp; " CssClass="details_label_age" OnClick="lnkBack_Click"></asp:LinkButton>
                                                                    
                                                                </td>
                                                                <%-- <td align="right" valign="top" id="tdXlandPrint" runat="server" style="display: none;">
                                                                    <table>
                                                                        <tr>
                                                                            <td>
                                                                                <asp:ImageButton ID="imgBtnXL" runat="server" Text="Export to exel" ImageUrl="../Images/ExcelImage.GIF"
                                                                                    ToolTip="Save As Excel" meta:resourcekey="imgBtnXLResource5" OnClick="imgBtnXL_Click" />
                                                                                &nbsp;
                                                                            </td>
                                                                            <td>
                                                                                <asp:ImageButton ID="btnPrint" runat="server" ImageUrl="~/Images/printer.gif" OnClick="btnPrint_OnClick"
                                                                                    ToolTip="Print" meta:resourcekey="btnPrintResource1" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>--%>
                                                            </tr>
                                                        </table>
                                                        <%--   <div id="divPrint" runat="server" visible="false">
                                                            <table cellspacing="0" cellpadding="0">
                                                                <tr>
                                                                    <td>
                                                                        <asp:GridView ID="gvTestStatReport" runat="server" AllowPaging="false" AutoGenerateColumns="false" OnRowDataBound="gvTestStatReport_RowDataBound"
                                                                            CssClass="dataheaderInvCtrl" Width="100%">
                                                                            <Columns>
                                                                                <asp:BoundField DataField="ProcessLocation" HeaderText="Process Location" meta:resourcekey="FDBoundFieldResource1">
                                                                                </asp:BoundField>
                                                                                 <asp:BoundField DataField="OrderedLocation" HeaderText="Ordered Location" meta:resourcekey="FDBoundFieldResource1">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="TestCode" HeaderText="Test Code" meta:resourcekey="PNBoundFieldResource2">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="TestName" HeaderText="Test Name" meta:resourcekey="RNBoundFieldResource3">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="January" HeaderText="January" meta:resourcekey="ANBoundFieldResource4">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="February" HeaderText="February" meta:resourcekey="PNBoundFieldResource5">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="March" HeaderText="March" meta:resourcekey="TPBoundFieldResource6">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="April" HeaderText="April" meta:resourcekey="CBoundFieldResource7">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="May" HeaderText="May" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="June" HeaderText="June" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="July" HeaderText="July" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="August" HeaderText="August" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="September" HeaderText="September" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="October" HeaderText="October" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="November" HeaderText="November" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="December" HeaderText="December" meta:resourcekey="ABoundFieldResource8">
                                                                                </asp:BoundField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>--%>
                                                        <div id="printDiv" runat="server">
                                                            <table id="example" style="display: none">
                                                                <thead>
                                                                    <tr>
                                                                        <th>
                                                                         <%--Process Location--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_02%>
                                                                        </th>
                                                                        <th>
                                                                            <%--Test Code--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_03%>
                                                                        </th>
                                                                        <th>
                                                                            <%--Test Name--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_04%>
                                                                        </th>
                                                                        <th>
                                                                            <%--January--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_05%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- February--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_06%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- March--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_07%>
                                                                        </th>
                                                                        <th>
                                                                            <%--April--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_08%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- May--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_09%>
                                                                        </th>
                                                                        <th>
                                                                            <%--June--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_10%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- July--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_11%>
                                                                        </th>
                                                                        <th>
                                                                            <%--August--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_12%>
                                                                        </th>
                                                                        <th>
                                                                            <%--September--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_13%>
                                                                        </th>
                                                                        <th>
                                                                            <%--October--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_14%>
                                                                        </th>
                                                                        <th>
                                                                            <%--November--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_15%>
                                                                        </th>
                                                                        <th>
                                                                            <%--December--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_16%>
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                            <table id="example1" style="display: none">
                                                                <thead>
                                                                    <tr>
                                                                         <th>
                                                    <%--Process Location--%>
                                                    <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_02%>
                                                </th>
                                                <th>
                                                    Ordered Location
                                                                        </th>
                                                                        <th>
                                                                            <%--Test Code--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_03%>
                                                                        </th>
                                                                        <th>
                                                                            <%--Test Name--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_04%>
                                                                        </th>
                                                                        <th>
                                                                            <%--January--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_05%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- February--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_06%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- March--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_07%>
                                                                        </th>
                                                                        <th>
                                                                            <%--April--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_08%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- May--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_09%>
                                                                        </th>
                                                                        <th>
                                                                            <%--June--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_10%>
                                                                        </th>
                                                                        <th>
                                                                           <%-- July--%>
                                                                           <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_11%>
                                                                        </th>
                                                                        <th>
                                                                            <%--August--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_12%>
                                                                        </th>
                                                                        <th>
                                                                            <%--September--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_13%>
                                                                        </th>
                                                                        <th>
                                                                            <%--October--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_14%>
                                                                        </th>
                                                                        <th>
                                                                            <%--November--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_15%>
                                                                        </th>
                                                                        <th>
                                                                            <%--December--%>
                                                                            <%=Resources.Reports_ClientDisplay.Reports_TestStatisticsReport_aspx_16%>
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:HiddenField ID="hdnMessages" runat="server" />
                                        <asp:HiddenField ID="hdnFromDate" runat="server" />
                                        <asp:HiddenField ID="hdnToDate" runat="server" />
                                        <asp:HiddenField ID="hdnLocations" runat="server" />
                                        <asp:HiddenField ID="hdnClientID" runat="server" />
                                    </ContentTemplate>
                                    <%--  <Triggers>
                                        <asp:PostBackTrigger ControlID="imgBtnXL" />
                                    </Triggers>--%>
                                </asp:UpdatePanel>
                            </div>
         <Attune:Attunefooter ID="Attunefooter" runat="server" />               
    </form>

   <%-- <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

</body>
</html>
