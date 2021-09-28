<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TATAnalysisReport.aspx.cs"
    Inherits="Reports_TATAnalysisReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajc" %>
<%@ Register Src="../CommonControls/PatientDetails.ascx" TagName="PatientDetails"
    TagPrefix="ucPatientdet" %>
<%@ Register Src="../CommonControls/Attune_OrgHeader.ascx" TagName="Attuneheader"
    TagPrefix="Attune" %>
<%@ Register Src="../CommonControls/Attune_Footer.ascx" TagName="Attunefooter" TagPrefix="Attune" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--
    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>--%>

    <script type="text/javascript" src="../Scripts/datetimepicker_css.js"></script>

    <link type="text/css" href="../StyleSheets/jquery-ui-1.8.19.custom.css" rel="stylesheet" />
    <link href="../StyleSheets/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_page.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/demo_table_jui.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery.dataTables_themeroller.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/jquery-ui-1.8.4.custom.css" rel="stylesheet" type="text/css" />
    <link href="../StyleSheets/TableTools_JUI.css" rel="stylesheet" type="text/css" />
    <title></title>

    <script language="javascript" type="text/javascript">

        function GetData() {
            var AlertType = SListForAppMsg.Get('Reports_EpisodeReport_aspx_01') == null ? "Alert" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_01');
            var fdate = SListForAppMsg.Get('Reports_EpisodeReport_aspx_02') == null ? "Select From Date!!!" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_02');
            var tdate = SListForAppMsg.Get('Reports_EpisodeReport_aspx_03') == null ? "Select To Date!!!'" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_03');
            var val = SListForAppMsg.Get('Reports_EpisodeReport_aspx_04') == null ? "Select Valid Status" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_04');
            var err = SListForAppMsg.Get('Reports_EpisodeReport_aspx_05') == null ? "Error" : SListForAppMsg.Get('Reports_EpisodeReport_aspx_05');
 //           debugger;

            try {
                if (document.getElementById('txtFromDate').value == '') {

                    ValidationWindow(fdate, AlertType);
                //    alert('Select From Date!!!');
                    return false
                }
                if (document.getElementById('txtToDate').value == '') {
                    //alert('Select To Date!!!');
                    ValidationWindow(tdate, AlertType);
                    return false
                }
                document.getElementById('tmpdiv').style.display = 'block';
                var pFromDate = document.getElementById('txtFromDate').value;
                var pToDate = document.getElementById('txtToDate').value;
                var pRoutine = document.getElementById('ddlRoutineStat').value;
                var pLocationID = document.getElementById('ddlLocation').value;
                if (document.getElementById('hdnClientID').value != null && document.getElementById('hdnClientID').value != '') {
                    var pClientID = document.getElementById('hdnClientID').value;
                }
                else {
                    pClientID = 0;
                }
                var pFromStatusold = document.getElementById("ddlfromStatus");
                var pFromStatus = pFromStatusold.options[pFromStatusold.selectedIndex].text;

                var pToStatusold = document.getElementById("ddltoStatus");
                var pToStatus = pToStatusold.options[pToStatusold.selectedIndex].text;

                if ((pFromStatus == 'Paid' && pToStatus == 'Paid') || (pFromStatus == 'SampleCollected' && pToStatus == 'SampleCollected') ||
                (pFromStatus == 'SampleReceived' && pToStatus == 'SampleReceived') || (pFromStatus == 'Completed' && pToStatus == 'Completed') ||
                (pFromStatus == 'Approved' && pToStatus == 'Approved') || (pFromStatus == 'SampleCollected' && pToStatus == 'Paid') || (pFromStatus == 'SampleReceived' && pToStatus == 'Paid') ||
                (pFromStatus == 'SampleReceived' && pToStatus == 'SampleCollected') || (pFromStatus == 'Completed' && pToStatus == 'SampleReceived') || (pFromStatus == 'Completed' && pToStatus == 'SampleCollected') ||
                (pFromStatus == 'Completed' && pToStatus == 'Paid') || (pFromStatus == 'Approved' && pToStatus == 'Paid') || (pFromStatus == 'Approved' && pToStatus == 'SampleCollected') || (pFromStatus == 'Approved' && pToStatus == 'SampleReceived')
                || (pFromStatus == 'Approved' && pToStatus == 'Completed')) 
                {
                    // alert('Select Valid Status');
                    ValidationWindow(val, AlertType);
                    return false;
                }
                else {
                    $.ajax({
                        type: "POST",
                        url: "../WebService.asmx/GetTATAnalysisReport",
                        contentType: "application/json; charset=utf-8",
                        data: "{ 'FromDate': '" + pFromDate + "','ToDate': '" + pToDate + "','Routine':'" + pRoutine + "','LocationID':'" + pLocationID + "','ClientID':'" + pClientID + "','FromStatus':'" + pFromStatus + "','ToStatus':'" + pToStatus + "'}",
                        dataType: "json",
                        success: AjaxGetFieldDataSucceeded,
                        error: function(xhr, ajaxOptions, thrownError) {
                        //  alert("Error");
                        ValidationWindow(err, AlertType);
                            return false;
                        }
                    });
                }
                return false;
            }
            catch (e) {
                return false;
            }
        }
        function AjaxGetFieldDataSucceeded(result) {

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

            { "mDataProp": "TestName" },
            { "mDataProp": "Testtype" },
            { "mDataProp": "Counts" },
            { "mDataProp": "ZeroFiveHr" },
            { "mDataProp": "OneHr" },
            { "mDataProp": "OneFiveHr" },
            { "mDataProp": "TwoHr" },
            { "mDataProp": "TwoFiveHr" },
            { "mDataProp": "ThreeHr" },
            { "mDataProp": "ThreeFiveHr" },
            { "mDataProp": "FourHr" },
            { "mDataProp": "SixHr" },
            { "mDataProp": "EightHr" },
            { "mDataProp": "TenHr" },
            { "mDataProp": "TwelveHr" },
            { "mDataProp": "SixteenHr" },
            { "mDataProp": "TwentyHr" },
            { "mDataProp": "TwentyFourHr" },
            { "mDataProp": "ThirtyTwoHr" },
            { "mDataProp": "FourtyHr" },
            { "mDataProp": "FourtyEightHr" },
            { "mDataProp": "ThreeDay" },
            { "mDataProp": "FourDay" },
            { "mDataProp": "FiveDay" },
            { "mDataProp": "SixDay" },
            { "mDataProp": "SevenDay" },
            { "mDataProp": "EightDay" },
            { "mDataProp": "NineDay" },
            { "mDataProp": "TenDay" },
            { "mDataProp": "AboveTenDay" }
            ],
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
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <Attune:Attuneheader ID="Attuneheader" runat="server" />
    <div class="contentdata">
        <div id="tmpdiv" style="display: none">
            <progresstemplate>
                                        <div id="progressBackgroundFilter" class="a-center">
                                        </div>
                                        <div id="processMessage" class="a-center w-20p">
                                            <asp:Image ID="img3" Width="40px" Height="40px" runat="server" ImageUrl="../Images/loading.GIF" meta:resourcekey="img1Resource1" />
                                        </div>
                                    </progresstemplate>
        </div>
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <table id="tblContent" runat="server" class="w-100p searchPanel">
                    <tr>
                        <td>
                            <div id="divSearch" runat="server">
                                <table id="tblsearch" runat="server" class="dataheaderInvCtrl w-100p">
                                    <tr>
                                        <td>
                                            <asp:Label ID="fromDate" runat="server" Text="From Date" meta:resourcekey="fromDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFromDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntCalcFrom" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                            <span>
                                                <img src="../Images/starbutton.png" alt="" align="middle" /></span>
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtFromDate"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator5" runat="server" ControlExtender="MaskedEditExtender5"
                                                ControlToValidate="txtFromDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(mm-dd-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator5" meta:resourcekey="MaskedEditValidator5Resource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                                Format="MM/dd/yyyy" PopupButtonID="ImgBntCalcFrom" Enabled="True" />
                                        </td>
                                        <td>
                                            <asp:Label ID="toDate" runat="server" Text="To Date" meta:resourcekey="toDateResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtToDate" runat="server" CssClass="Txtboxsmall"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntCalcTo" runat="server" ImageUrl="~/images/Calendar_scheduleHS.png"
                                                CausesValidation="False" meta:resourcekey="ImgBntCalcFromResource1" />
                                            <span>
                                                <img src="../Images/starbutton.png" alt="" align="middle" /></span>
                                            <ajc:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtToDate"
                                                Mask="99/99/9999" MaskType="Date" DisplayMoney="Left" AcceptNegative="Left" ErrorTooltipEnabled="True"
                                                CultureAMPMPlaceholder="" CultureCurrencySymbolPlaceholder="" CultureDateFormat=""
                                                CultureDatePlaceholder="" CultureDecimalPlaceholder="" CultureThousandsPlaceholder=""
                                                CultureTimePlaceholder="" Enabled="True" />
                                            <ajc:MaskedEditValidator ID="MaskedEditValidator6" runat="server" ControlExtender="MaskedEditExtender6"
                                                ControlToValidate="txtToDate" EmptyValueMessage="Date is required" InvalidValueMessage="Date is invalid"
                                                Display="Dynamic" TooltipMessage="(mm-dd-yyyy)" EmptyValueBlurredText="*" InvalidValueBlurredMessage="*"
                                                ValidationGroup="MKE" ErrorMessage="MaskedEditValidator6" meta:resourcekey="MaskedEditValidator5Resource1" />
                                            <ajc:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                                Format="MM/dd/yyyy" PopupButtonID="ImgBntCalcTo" Enabled="True" />
                                        </td>
                                        <td>
                                            <asp:Label ID="lblLocation" runat="server" Text="Location" meta:resourcekey="lblLocationResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlLocation" runat="server" CssClass="ddl">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblClientName" runat="server" Text="Client Name" meta:resourcekey="lblClientNameResource1"></asp:Label>
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
                                        <td>
                                            <asp:Label ID="lblRoutine" runat="server" Text="Routine/STAT" meta:resourcekey="lblRoutineResource1"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlRoutineStat" runat="server" CssClass="ddl">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblInvStatus" runat="server" Text="Investigation Status" meta:resourcekey="lblInvStatusResource1"></asp:Label>
                                        </td>
                                        <td colspan="2">
                                            <asp:DropDownList ID="ddlfromStatus" runat="server" CssClass="ddl">
                                            </asp:DropDownList>
                                            <asp:DropDownList ID="ddltoStatus" runat="server" CssClass="ddl">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnSearch" runat="server" CssClass="btn" Text="Search" OnClientClick="javascript:return GetData()" meta:resourcekey="btnSearchResource1"/>
                                            <asp:LinkButton ID="lnkBack" runat="server" Text="Back" CssClass="details_label_age"
                                                OnClick="lnkBack_Click" meta:resourcekey="lnkBackResource1"></asp:LinkButton>
                                        </td>
                                       
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="w-100p">
                            <div id="divExamples" runat="server" class="w-100p">
                                <table id="example" style="display: none" class="w-100p">
                                    <thead>
                                        <tr>
                                            <th>
                                                                   <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_01%>
                                                                       <%-- Test Name--%>
                                                                    </th>
                                                                    <th>
                                                                    <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_02%>
                                                                       <%-- Type--%>
                                                                    </th>
                                                                    <th>
                                                                    <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_03%>
                                                                        <%--Counts--%>
                                                                    </th>
                                                                    <th>
                                                                      <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_04%>
                                                                       <%-- 0.5 Hr--%>
                                                                    </th>
                                                                    <th>
                                                                      <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_05%>
                                                                        <%--1 Hr--%>
                                                                    </th>
                                                                    <th>
                                                                      <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_06%>
                                                                        <%--1.5 Hr--%>
                                                                    </th>
                                                                    <th>
                                                                      <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_07%>
                                                                        <%--2 Hr--%>
                                                                    </th>
                                                                    <th>
                                                                        <%--2.5 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_08%>
                                                                    </th>
                                                                    <th>
                                                                        <%--3 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_09%>
                                                                    </th>
                                                                    <th>
                                                                        <%--3.5 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_10%>
                                                                    </th>
                                                                    <th>
                                                                        <%--4 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_11%>
                                                                    </th>
                                                                    <th>
                                                                        <%--6 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_12%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--8 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_13%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--10 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_14%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--12 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_15%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--16 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_16%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--20 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_01%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--24 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_17%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--32 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_18%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--40 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_19%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--48 Hr--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_20%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--3 Day--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_21%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--4 Day--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_22%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%--5 Day--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_23%>
                                                                        
                                                                    </th>
                                                                    <th>
                                                                        <%-->5 Day--%>
                                                                          <%=Resources.Reports_ClientDisplay.Reports_TATAnalysisReport_aspx_24%>
                                                                        
                                                                    </th>
                                                                    <%--<th>
                                                                        7 Day
                                                                    </th>
                                                                    <th>
                                                                        8 Day
                                                                    </th>
                                                                    <th>
                                                                        9 Day
                                                                    </th>
                                                                    <th>
                                                                        10 Day
                                                                    </th>
                                                                    <th>
                                                                        >10 Day
                                                                    </th>--%>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdnFromDate" runat="server" />
                <asp:HiddenField ID="hdnToDate" runat="server" />
                <asp:HiddenField ID="hdnClientID" runat="server" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <Attune:Attunefooter ID="Attunefooter" runat="server" />
    </form>
    <%--    <script src="../Scripts/jquery-1.8.1.min.js" language="javascript" type="text/javascript"></script>

    <script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>
--%>

    <script type="text/javascript" src="../Scripts/jquery.dataTables.min.js"></script>

    <script type="text/javascript" src="../Scripts/ZeroClipboard.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.js"></script>

    <script type="text/javascript" src="../Scripts/TableTools.min.js"></script>

</body>
</html>
